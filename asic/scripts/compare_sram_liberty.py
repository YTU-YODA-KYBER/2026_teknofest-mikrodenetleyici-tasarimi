#!/usr/bin/env python3
"""Compare OpenRAM timing arcs against the official 1 KiB PDK Liberty."""

from __future__ import annotations

import argparse
from dataclasses import dataclass, field
import json
import math
from pathlib import Path
import re
import statistics
import sys


BLOCK_RE = re.compile(r"^\s*([A-Za-z_]\w*)\s*\((.*?)\)\s*\{\s*$")
ATTR_RE = re.compile(r"^\s*([A-Za-z_]\w*)\s*:\s*(.*?)\s*;\s*$")
NUMBER_RE = re.compile(r"[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?")
TABLE_NAMES = {
    "cell_rise", "cell_fall", "rise_transition", "fall_transition",
    "rise_constraint", "fall_constraint",
}


@dataclass
class Node:
    kind: str
    name: str
    parent: "Node | None" = None
    attrs: dict[str, str] = field(default_factory=dict)
    values: list[float] = field(default_factory=list)
    children: list["Node"] = field(default_factory=list)


def parse_liberty(path: Path) -> Node:
    root = Node("root", path.name)
    stack = [root]
    lines = path.read_text().splitlines()
    index = 0
    while index < len(lines):
        line = lines[index]
        stripped = line.strip()
        block = BLOCK_RE.match(line)
        if block:
            node = Node(block.group(1), block.group(2).strip().strip('"'), stack[-1])
            stack[-1].children.append(node)
            stack.append(node)
        elif stripped.startswith("values("):
            statement = stripped
            while ");" not in statement:
                index += 1
                if index >= len(lines):
                    raise ValueError(f"unterminated values() in {path}")
                statement += " " + lines[index].strip()
            stack[-1].values = [float(x) for x in NUMBER_RE.findall(statement)]
        else:
            attr = ATTR_RE.match(line)
            if attr:
                stack[-1].attrs[attr.group(1)] = attr.group(2).strip().strip('"')
            closes = stripped.count("}")
            for _ in range(closes):
                if len(stack) == 1:
                    raise ValueError(f"unbalanced close brace in {path}:{index + 1}")
                stack.pop()
        index += 1
    if len(stack) != 1:
        raise ValueError(f"unclosed Liberty blocks in {path}")
    return root


def walk(node: Node):
    yield node
    for child in node.children:
        yield from walk(child)


def ancestor(node: Node, kind: str) -> Node | None:
    current = node.parent
    while current:
        if current.kind == kind:
            return current
        current = current.parent
    return None


def timing_tables(root: Node) -> dict[str, list[float]]:
    tables: dict[str, list[float]] = {}
    for node in walk(root):
        if node.kind not in TABLE_NAMES or not node.values:
            continue
        timing = ancestor(node, "timing")
        pin = ancestor(node, "pin")
        bus = ancestor(node, "bus")
        if timing is None or pin is None:
            continue
        pin_name = f"{bus.name}/{pin.name}" if bus else pin.name
        related = timing.attrs.get("related_pin", "").strip('"')
        timing_type = timing.attrs.get("timing_type", "")
        sense = timing.attrs.get("timing_sense", "")
        key = "|".join((pin_name, related, timing_type, sense, node.kind))
        if key in tables:
            raise ValueError(f"duplicate timing-table key: {key}")
        tables[key] = node.values
    return tables


def axes(root: Node) -> dict[str, dict[str, list[float]]]:
    result = {}
    for node in walk(root):
        if node.kind != "lu_table_template":
            continue
        parsed = {}
        for child in node.children:
            del child
        # index_1/index_2 are function-like statements, not brace blocks; parse
        # them independently from the source in main().
        result[node.name] = parsed
    return result


def parse_axes_text(path: Path) -> dict[str, dict[str, list[float]]]:
    text = path.read_text()
    result = {}
    for match in re.finditer(r"lu_table_template\s*\(([^)]+)\)\s*\{(.*?)\}", text, re.S):
        body = match.group(2)
        item = {}
        for axis in ("index_1", "index_2"):
            axis_match = re.search(rf'{axis}\s*\(\s*"([^"]+)"\s*\)', body)
            if axis_match:
                item[axis] = [float(x) for x in NUMBER_RE.findall(axis_match.group(1))]
        result[match.group(1).strip()] = item
    return result


def compare(reference: Path, candidate: Path) -> dict:
    ref_tables = timing_tables(parse_liberty(reference))
    got_tables = timing_tables(parse_liberty(candidate))
    ref_keys, got_keys = set(ref_tables), set(got_tables)
    common = sorted(ref_keys & got_keys)
    arc_rows = []
    length_mismatches = []
    all_abs = []
    all_pct = []
    for key in common:
        expected = ref_tables[key]
        actual = got_tables[key]
        if len(expected) != len(actual):
            length_mismatches.append({"arc": key, "reference": len(expected), "candidate": len(actual)})
            continue
        abs_errors = [abs(a - b) for a, b in zip(actual, expected)]
        pct_errors = [100.0 * e / max(abs(b), 1e-12) for e, b in zip(abs_errors, expected)]
        all_abs.extend(abs_errors)
        all_pct.extend(pct_errors)
        arc_rows.append({
            "arc": key,
            "points": len(expected),
            "reference_min": min(expected),
            "reference_max": max(expected),
            "candidate_min": min(actual),
            "candidate_max": max(actual),
            "mean_absolute_difference": statistics.fmean(abs_errors),
            "max_absolute_difference": max(abs_errors),
            "mean_percent_difference": statistics.fmean(pct_errors),
            "max_percent_difference": max(pct_errors),
        })
    ref_axes = parse_axes_text(reference)
    got_axes = parse_axes_text(candidate)
    axes_equal = ref_axes == got_axes
    return {
        "reference": str(reference),
        "candidate": str(candidate),
        "axes_equal": axes_equal,
        "reference_axes": ref_axes,
        "candidate_axes": got_axes,
        "reference_arc_tables": len(ref_tables),
        "candidate_arc_tables": len(got_tables),
        "matched_arc_tables": len(common),
        "missing_arc_tables": sorted(ref_keys - got_keys),
        "extra_arc_tables": sorted(got_keys - ref_keys),
        "length_mismatches": length_mismatches,
        "all_points": {
            "count": len(all_abs),
            "mean_absolute_difference": statistics.fmean(all_abs) if all_abs else math.nan,
            "max_absolute_difference": max(all_abs, default=math.nan),
            "mean_percent_difference": statistics.fmean(all_pct) if all_pct else math.nan,
            "max_percent_difference": max(all_pct, default=math.nan),
        },
        "arcs": arc_rows,
        "structural_match": not (ref_keys ^ got_keys or length_mismatches),
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("reference", type=Path)
    ap.add_argument("candidate", type=Path)
    ap.add_argument("--json", type=Path, help="write the full machine-readable report")
    args = ap.parse_args()
    for path in (args.reference, args.candidate):
        if not path.is_file():
            ap.error(f"not a file: {path}")
    result = compare(args.reference, args.candidate)
    if args.json:
        args.json.parent.mkdir(parents=True, exist_ok=True)
        args.json.write_text(json.dumps(result, indent=2, allow_nan=False) + "\n")
    summary = result["all_points"]
    print(f"axes_equal={result['axes_equal']}")
    print(f"structural_match={result['structural_match']}")
    print(f"arc_tables={result['matched_arc_tables']}/{result['reference_arc_tables']} reference, "
          f"{result['candidate_arc_tables']} candidate")
    print(f"points={summary['count']} mean_abs={summary['mean_absolute_difference']:.6g} "
          f"max_abs={summary['max_absolute_difference']:.6g} "
          f"mean_pct={summary['mean_percent_difference']:.3f}% "
          f"max_pct={summary['max_percent_difference']:.3f}%")
    return 0 if result["axes_equal"] and result["structural_match"] else 1


if __name__ == "__main__":
    sys.exit(main())
