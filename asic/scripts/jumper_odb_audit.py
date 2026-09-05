#!/usr/bin/env python3
"""Audit (and optionally clear) OpenROAD jumper metadata in an ODB.

Run this script with OpenROAD's Python interpreter, for example:

    openroad -exit -no_splash -python scripts/jumper_odb_audit.py -- \
        --input-odb design.odb --report report.json

The distinction between dbNet.hasJumpers() and dbGuide.isJumper() matters:
FlexDR changes its guide-escape cost for the former, while antenna repair marks
the actual jumper geometry on the latter.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path

import odb


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-odb", required=True, type=Path)
    parser.add_argument("--report", type=Path)
    clear_group = parser.add_mutually_exclusive_group()
    clear_group.add_argument("--clear-net-flags", action="store_true")
    clear_group.add_argument("--clear-orphan-flags", action="store_true")
    parser.add_argument("--set-max-routing-layer", type=int)
    parser.add_argument("--output-odb", type=Path)
    args = parser.parse_args()
    clear_requested = args.clear_net_flags or args.clear_orphan_flags
    mutation_requested = clear_requested or args.set_max_routing_layer is not None
    if mutation_requested != bool(args.output_odb):
        parser.error("a mutation option and --output-odb must be used together")
    return args


def main() -> int:
    args = parse_args()
    db = odb.dbDatabase.create()
    odb.read_db(db, str(args.input_odb.resolve()))
    block = db.getChip().getBlock()

    flagged_nets: list[str] = []
    jumper_guide_nets: list[str] = []
    total_jumper_guides = 0

    for net in block.getNets():
        flagged = net.hasJumpers()
        jumper_guides = sum(1 for guide in net.getGuides() if guide.isJumper())
        if flagged:
            flagged_nets.append(net.getName())
        if jumper_guides:
            jumper_guide_nets.append(net.getName())
            total_jumper_guides += jumper_guides

    flagged_set = set(flagged_nets)
    guide_set = set(jumper_guide_nets)
    report = {
        "input_odb": str(args.input_odb.resolve()),
        "net_count": len(block.getNets()),
        "flagged_net_count": len(flagged_nets),
        "jumper_guide_net_count": len(jumper_guide_nets),
        "jumper_guide_count": total_jumper_guides,
        "flagged_without_jumper_guide_count": len(flagged_set - guide_set),
        "jumper_guide_without_flag_count": len(guide_set - flagged_set),
        "flagged_without_jumper_guide_examples": sorted(flagged_set - guide_set)[:20],
        "jumper_guide_without_flag_examples": sorted(guide_set - flagged_set)[:20],
        "cleared_net_flag_count": 0,
        "max_routing_layer_before": block.getMaxRoutingLayer(),
        "max_routing_layer_after": block.getMaxRoutingLayer(),
    }

    if args.clear_net_flags or args.clear_orphan_flags:
        for net in block.getNets():
            has_jumper_guide = any(guide.isJumper() for guide in net.getGuides())
            should_clear = net.hasJumpers() and (
                args.clear_net_flags or not has_jumper_guide
            )
            if should_clear:
                net.setJumpers(False)
                report["cleared_net_flag_count"] += 1
    if args.set_max_routing_layer is not None:
        block.setMaxRoutingLayer(args.set_max_routing_layer)
        report["max_routing_layer_after"] = block.getMaxRoutingLayer()

    if args.output_odb:
        args.output_odb.parent.mkdir(parents=True, exist_ok=True)
        odb.write_db(db, str(args.output_odb.resolve()))
        report["output_odb"] = str(args.output_odb.resolve())

    rendered = json.dumps(report, indent=2, sort_keys=True) + "\n"
    if args.report:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text(rendered)
    print(rendered, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
