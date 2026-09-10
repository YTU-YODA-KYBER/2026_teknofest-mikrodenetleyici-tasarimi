#!/usr/bin/env python3
"""OpenRAM v1.2.48 memchar entry point for an already-generated SRAM.

Upstream sram_char.py constructs a ``fake_sram`` through the normal SRAM
organization estimator.  That estimator instantiates a physical bitcell even
when words_per_row is already known and only an existing SPICE netlist will be
characterized.  Modern open_pdks installations do not ship the obsolete
per-cell OpenRAM GDS/SPICE directories expected by that code path.

This wrapper skips only that unused bitcell instantiation.  Organization,
ports, the upstream delay/setup-hold engines, SPICE stimuli, models, and
Liberty writer are unchanged.
"""

from __future__ import annotations

import datetime
import os
from pathlib import Path
import re
import sys


openram_home = os.environ.get("OPENRAM_HOME")
if not openram_home:
    raise SystemExit("OPENRAM_HOME is required")
openram_root = str(Path(openram_home).resolve().parent)
sys.path.insert(0, openram_root)

from common import make_openram_package  # noqa: E402

make_openram_package()
import openram  # noqa: E402


class FeasibilityOnlyComplete(Exception):
    """Internal clean-stop signal after one successful functional run."""


def existing_netlist_stimulus_pin_order(spice_file: Path,
                                        macro_name: str) -> list[str]:
    """Translate the published macro's positional pins to stimulus nets.

    The PDK SPICE views declare every bus MSB-first while OpenRAM v1.2.48's
    generic memchar stimulus instantiates buses LSB-first.  SPICE subcircuit
    ports are positional, so leaving that mismatch in place silently connects
    e.g. ``din0_31``/``dout0_31`` to physical bit 0 while the internal probe
    observes physical bit 31.
    """
    lines = spice_file.read_text().splitlines()
    declaration: list[str] | None = None
    for index, line in enumerate(lines):
        match = re.match(
            rf"^\s*\.SUBCKT\s+{re.escape(macro_name)}(?:\s+(.*))?$",
            line,
            re.IGNORECASE,
        )
        if match is None:
            continue
        declaration = (match.group(1) or "").split()
        cursor = index + 1
        while cursor < len(lines) and re.match(r"^\s*\+", lines[cursor]):
            declaration.extend(re.sub(r"^\s*\+\s*", "", lines[cursor]).split())
            cursor += 1
        break
    if declaration is None:
        raise RuntimeError(f"top .SUBCKT {macro_name} not found in {spice_file}")

    vector_prefixes = {
        "din": "din",
        "dout": "dout",
        "addr": "a",
        "wmask": "WMASK",
        "spare_wen": "SPARE_WEN",
    }
    supply_names = {"vccd1": "vdd", "vssd1": "gnd", "vdd": "vdd", "gnd": "gnd"}
    ordered = []
    for formal in declaration:
        lowered = formal.lower()
        vector = re.fullmatch(r"([a-z_]+)(\d+)\[(\d+)\]", lowered)
        scalar = re.fullmatch(r"(csb|web|clk)(\d+)", lowered)
        if vector and vector.group(1) in vector_prefixes:
            prefix = vector_prefixes[vector.group(1)]
            ordered.append(f"{prefix}{vector.group(2)}_{vector.group(3)}")
        elif scalar:
            prefix = scalar.group(1).upper() if scalar.group(1) in ("csb", "web") else "clk"
            ordered.append(f"{prefix}{scalar.group(2)}")
        elif lowered in supply_names:
            ordered.append(supply_names[lowered])
        else:
            raise RuntimeError(
                f"unsupported formal pin {formal!r} in {macro_name} .SUBCKT"
            )
    if len(ordered) != len(set(name.lower() for name in ordered)):
        raise RuntimeError(f"duplicate translated stimulus pin in {macro_name}: {ordered}")
    return ordered


def install_existing_netlist_pin_order(spice_file: Path, macro_name: str) -> None:
    """Make memchar instantiate the macro in its actual positional order."""
    from openram.characterizer.simulation import simulation as simulation_class

    positional_order = existing_netlist_stimulus_pin_order(spice_file, macro_name)
    original = simulation_class.create_signal_names

    def create_signal_names_existing(self):
        original(self)
        if self.sram.name != macro_name:
            return
        generated = {name.lower(): name for name in self.pins}
        positional = {name.lower(): name for name in positional_order}
        if generated.keys() != positional.keys():
            missing = sorted(generated.keys() - positional.keys())
            extra = sorted(positional.keys() - generated.keys())
            raise RuntimeError(
                "existing SRAM formal pins do not match OpenRAM stimulus pins: "
                f"missing_from_spice={missing}, extra_in_spice={extra}"
            )
        self.pins = positional_order.copy()

    simulation_class.create_signal_names = create_signal_names_existing


def configure_existing_netlist_probe_paths(spice_file: Path, macro_name: str) -> None:
    """Match memchar probe templates to the hierarchy in the supplied netlist.

    OpenRAM v1.2.48's sky130 defaults describe the hierarchy generated by the
    current compiler.  The published sky130 SRAM SPICE views used here have an
    older, one-level-shorter bitcell hierarchy and expose ``s_en`` as a local
    node of the top SRAM subcircuit.  A nonexistent probe is especially
    dangerous: the feasible-period search treats the failed Q/Q_bar check as a
    timing failure and keeps doubling the clock period.
    """
    from openram import OPTS

    blocks: dict[str, list[str]] = {}
    current: str | None = None
    body: list[str] = []
    for line in spice_file.read_text().splitlines():
        start = re.match(r"^\s*\.SUBCKT\s+(\S+)", line, re.IGNORECASE)
        if start:
            if current is not None:
                raise RuntimeError(f"nested .SUBCKT while parsing {spice_file}: {line}")
            current = start.group(1).lower()
            body = []
        elif re.match(r"^\s*\.ENDS\b", line, re.IGNORECASE):
            if current is None:
                raise RuntimeError(f"unmatched .ENDS while parsing {spice_file}")
            if current in blocks:
                raise RuntimeError(f"duplicate .SUBCKT {current} in {spice_file}")
            blocks[current] = body
            current = None
        elif current is not None:
            body.append(line)
    if current is not None:
        raise RuntimeError(f"unterminated .SUBCKT {current} in {spice_file}")

    required = (
        (macro_name.lower(), r"^Xbank0\b.*\sbank\s*$"),
        ("bank", r"^Xbitcell_array\b.*\sreplica_bitcell_array\s*$"),
        ("replica_bitcell_array", r"^Xbitcell_array\b.*\sbitcell_array\s*$"),
        ("bitcell_array",
         r"^Xbit_r\d+_c\d+\b.*\ssky130_fd_bd_sram__openram_dp_cell\s*$"),
    )
    for subckt, pattern in required:
        subckt_body = "\n".join(blocks.get(subckt, []))
        if not subckt_body or re.search(
                pattern, subckt_body, re.MULTILINE | re.IGNORECASE) is None:
            raise RuntimeError(
                "existing SRAM hierarchy does not match the supported probe layout: "
                f"{subckt}/{pattern}"
            )

    sep = "{hier_sep}"
    # s_en is created by Xcontrol0 in the top SRAM and merely passed through
    # Xbank0, so ngspice names it X<macro>.s_en0 (not X<macro>.xbank0.s_en0).
    OPTS.sen_format = f"X{{name}}{sep}s_en"
    # Published macro: bank/Xbitcell_array(replica_bitcell_array)/
    # Xbitcell_array(bitcell_array)/Xbit_rN_cM.  The v1.2.48 default contains
    # an additional, nonexistent Xreplica_bitcell_array level.
    OPTS.cell_format = (
        f"X{{name}}{sep}xbank0{sep}xbitcell_array{sep}xbitcell_array"
        f"{sep}xbit_r{{row}}_c{{col}}"
    )


def install_feasible_period_guard(limit_ns: float = 10.0,
                                  feasibility_only: bool = False) -> None:
    """Fail at a configured functional ceiling instead of doubling for hours.

    The matching 1 KiB TT Liberty reports a 1.791 ns minimum period, so its
    pilot ceiling is 2 ns.  Unknown 2 KiB PVTs use a separate, looser ceiling.
    Failure at the applicable ceiling must not be disguised as an ever-larger
    feasible period without investigation.
    """
    from openram.characterizer.delay import delay as delay_class

    original = delay_class.run_delay_simulation

    def guarded(self):
        success, results = original(self)
        if feasibility_only:
            if success:
                raise FeasibilityOnlyComplete(self.period)
            raise RuntimeError(
                f"diagnostic feasibility-only simulation failed at {self.period:g} ns; "
                "stopping before period search/table generation"
            )
        if not success and self.period >= limit_ns:
            raise RuntimeError(
                f"SRAM functional/probe check failed at {self.period:g} ns; "
                "refusing feasible-period doubling"
            )
        return success, results

    delay_class.run_delay_simulation = guarded


def logical_spice_lines(text: str) -> list[str]:
    """Join SPICE ``+`` continuation records without changing token order."""
    logical: list[str] = []
    for physical in text.splitlines():
        if re.match(r"^\s*\+", physical):
            if not logical:
                raise RuntimeError("SPICE continuation appears before a logical line")
            logical[-1] += " " + re.sub(r"^\s*\+\s*", "", physical)
        else:
            logical.append(physical)
    return logical


def subckt_lines(text: str, name: str) -> tuple[list[str], list[str]]:
    """Return a subcircuit's formal pins and logical body lines."""
    logical = logical_spice_lines(text)
    start = None
    formals: list[str] = []
    for index, line in enumerate(logical):
        match = re.match(
            rf"^\s*\.SUBCKT\s+{re.escape(name)}(?:\s+(.*))?$",
            line,
            re.IGNORECASE,
        )
        if match:
            start = index
            formals = (match.group(1) or "").split()
            break
    if start is None:
        raise RuntimeError(f".SUBCKT {name} not found")
    for end in range(start + 1, len(logical)):
        if re.match(rf"^\s*\.ENDS(?:\s+{re.escape(name)})?\s*$",
                    logical[end], re.IGNORECASE):
            return formals, logical[start + 1:end]
    raise RuntimeError(f"unterminated .SUBCKT {name}")


def precharge_columns_for_data_bitline(source_text: str, bitline: int,
                                       port_data_name: str,
                                       instance_name: str,
                                       precharge_name: str) -> tuple[int, int]:
    """Map replica/data nets through one port into precharge-array columns.

    The published dual-port macros prepend ``rbl_bl/rbl_br`` to the normal
    bitlines at the precharge-array instance.  Thus a data column is shifted,
    but deriving the mapping from the netlist avoids silently relying on that
    implementation detail for another macro revision.
    """
    precharge_formals, _ = subckt_lines(source_text, precharge_name)
    _, port_data_body = subckt_lines(source_text, port_data_name)
    matches = [line for line in port_data_body
               if re.match(rf"^\s*{re.escape(instance_name)}\b",
                           line, re.IGNORECASE)]
    if len(matches) != 1:
        raise RuntimeError(
            f"{port_data_name} must contain exactly one {instance_name} instance"
        )
    tokens = matches[0].split()
    if tokens[-1].lower() != precharge_name.lower():
        raise RuntimeError(
            f"{instance_name} does not instantiate {precharge_name}"
        )
    actuals = tokens[1:-1]
    if len(actuals) != len(precharge_formals):
        raise RuntimeError(
            "precharge_array instance/formal pin-count mismatch: "
            f"{len(actuals)} != {len(precharge_formals)}"
        )
    actual_to_formal = dict(zip((pin.lower() for pin in actuals),
                                (pin.lower() for pin in precharge_formals)))
    wanted = ("rbl_bl", f"bl_{bitline}")
    try:
        mapped = tuple(actual_to_formal[pin] for pin in wanted)
    except KeyError as error:
        raise RuntimeError(
            f"precharge_array mapping is missing actual net {error.args[0]}"
        ) from error
    columns = []
    for actual, formal in zip(wanted, mapped):
        match = re.fullmatch(r"bl_(\d+)", formal)
        if match is None:
            raise RuntimeError(
                f"precharge net {actual} maps to unexpected formal {formal}"
            )
        columns.append(int(match.group(1)))
    if columns[0] == columns[1]:
        raise RuntimeError("replica and selected data bitline map to one precharge column")
    return columns[0], columns[1]


def remove_insts_exact(trimmer, subckt_name: str,
                       keep_patterns: list[str]) -> None:
    """Trim one exact subcircuit, avoiding upstream prefix-name collisions.

    OpenRAM's helper uses substring checks, so trimming ``precharge_array``
    also trims ``precharge_array_0`` even though these ports have different
    positional mappings in this macro.
    """
    compiled = [re.compile(pattern) for pattern in keep_patterns]
    start = re.compile(rf"^\s*\.SUBCKT\s+{re.escape(subckt_name)}(?:\s|$)",
                       re.IGNORECASE)
    end = re.compile(rf"^\s*\.ENDS(?:\s+{re.escape(subckt_name)})?\s*$",
                     re.IGNORECASE)
    in_subckt = False
    new_buffer = []
    found = False
    for line in trimmer.sp_buffer:
        if start.match(line):
            if in_subckt:
                raise RuntimeError(f"nested .SUBCKT while trimming {subckt_name}")
            found = True
            in_subckt = True
            new_buffer.append(line)
        elif in_subckt and end.match(line):
            in_subckt = False
            new_buffer.append(line)
        elif not in_subckt or any(pattern.search(line) for pattern in compiled):
            new_buffer.append(line)
    if not found or in_subckt:
        raise RuntimeError(f"cannot safely trim exact subcircuit {subckt_name}")
    trimmer.sp_buffer = new_buffer


def trim_existing_netlist(source: Path, destination: Path, sram, address: str,
                          data_bit: int) -> None:
    """Apply OpenRAM's standard trimming with current net-name compatibility.

    v1.2.48 matches ``wl0_127``/``bl0_63`` while these generated macros use
    ``wl_0_127``/``bl_0_63``.  The retained circuit is otherwise identical to
    characterizer.trim_spice.trim().
    """
    from openram.characterizer.trim_spice import trim_spice

    trimmer = trim_spice(str(source), str(destination))
    trimmer.set_configuration(
        sram.num_banks, sram.num_rows, sram.num_cols, sram.word_size
    )
    wl_address = int(address[trimmer.col_addr_size:], 2)
    col_address = int(address[:trimmer.col_addr_size], 2) if trimmer.col_addr_size else 0
    bitline = int(trimmer.words_per_row * data_bit + col_address)
    source_text = source.read_text()
    rw_replica_precharge, rw_data_precharge = precharge_columns_for_data_bitline(
        source_text, bitline, "port_data", "Xprecharge_array0",
        "precharge_array",
    )
    r_replica_precharge, r_data_precharge = precharge_columns_for_data_bitline(
        source_text, bitline, "port_data_0", "Xprecharge_array1",
        "precharge_array_0",
    )

    trimmer.sp_buffer = list(trimmer.spice)
    notes = [
        "* WARNING: This is a TRIMMED NETLIST. It should NOT be used for LVS!!",
        f"* Keeping wl address {wl_address} and data bit {data_bit}",
        "* Net-name compatibility: accepts wl0_N/bl0_N and wl_0_N/bl_0_N",
        ("* RW precharge mapping: replica column "
         f"{rw_replica_precharge}, data bl_{bitline} column {rw_data_precharge}"),
        ("* R precharge mapping: replica column "
         f"{r_replica_precharge}, data bl_{bitline} column {r_data_precharge}"),
    ]
    trimmer.sp_buffer = notes + trimmer.sp_buffer
    wl_regex = rf"wl(?:\d+|_\d+)?_{wl_address}(?:\s|$)"
    bl_regex = rf"bl(?:\d+|_\d+)?_{bitline}(?:\s|$)"
    bl_no_port_regex = rf"bl_{bitline}(?:\s|$)"
    trimmer.remove_insts("bitcell_array", [wl_regex, bl_regex])
    trimmer.remove_insts("sense_amp_array", [bl_no_port_regex])
    trimmer.remove_insts("single_level_column_mux_array", [bl_no_port_regex])
    trimmer.remove_insts("write_driver_array", [rf"data_{data_bit}(?:\s|$)"])
    # The write-control replica bitline must stay precharged or rbl never rises,
    # the delay chain never enables w_en, and every write-one check fails.  The
    # real data bitline may also be shifted by the prepended replica pair.
    remove_insts_exact(
        trimmer,
        "precharge_array",
        [rf"bl_{rw_replica_precharge}(?:\s|$)",
         rf"bl_{rw_data_precharge}(?:\s|$)"],
    )
    remove_insts_exact(
        trimmer,
        "precharge_array_0",
        [rf"bl_{r_replica_precharge}(?:\s|$)",
         rf"bl_{r_data_precharge}(?:\s|$)"],
    )
    destination.write_text("\n".join(trimmer.sp_buffer))

    text = destination.read_text()
    expected_instance = f"Xbit_r{wl_address}_c{bitline} "
    if expected_instance not in text:
        raise RuntimeError(f"trimming removed target instance {expected_instance.strip()}")
    # The target must occur once in the real array; similarly named dummy or
    # replica cells are not accepted as a substitute.
    main_array = re.search(r"^\.SUBCKT bitcell_array\b(.*?)^\.ENDS bitcell_array\b",
                           text, re.MULTILINE | re.DOTALL)
    if main_array is None or main_array.group(1).count(expected_instance) != 1:
        raise RuntimeError("trimmed main bitcell_array does not contain exactly one target cell")
    for precharge_name, expected_precharges in (
        ("precharge_array", {rw_replica_precharge, rw_data_precharge}),
        ("precharge_array_0", {r_replica_precharge, r_data_precharge}),
    ):
        _, precharge_body = subckt_lines(text, precharge_name)
        retained_precharges = {
            int(match.group(1))
            for line in precharge_body
            if (match := re.match(r"^\s*Xpre_column_(\d+)\b",
                                  line, re.IGNORECASE))
        }
        if retained_precharges != expected_precharges:
            raise RuntimeError(
                f"trimmed {precharge_name} retained the wrong columns: "
                f"actual={sorted(retained_precharges)}, "
                f"expected={sorted(expected_precharges)}"
            )


def main() -> int:
    opts, args = openram.parse_args()
    if len(args) != 2:
        print(f"Usage: {sys.argv[0]} [options] <config file> <spice netlist>")
        return 2

    opts.top_process = "memchar"
    openram.init_openram(config_file=args[0], is_unit_test=False)
    from openram import OPTS, debug, sram_config, tech
    from openram.characterizer import fake_sram

    spice_file = Path(args[1]).resolve()
    debug.check(spice_file.is_file(), f"Spice netlist file {spice_file} not found.")
    install_existing_netlist_pin_order(spice_file, OPTS.output_name)
    configure_existing_netlist_probe_paths(spice_file, OPTS.output_name)
    initial_period = float(getattr(OPTS, "existing_sram_initial_period", 1.0))
    guard_period = float(getattr(OPTS, "existing_sram_functional_guard_period", 2.0))
    if initial_period <= 0 or guard_period < initial_period:
        raise RuntimeError(
            "existing SRAM feasibility periods must satisfy "
            f"0 < initial ({initial_period}) <= guard ({guard_period})"
        )
    tech.spice["feasible_period"] = initial_period
    install_feasible_period_guard(
        guard_period,
        bool(getattr(OPTS, "existing_sram_feasibility_only", False)),
    )

    # With words_per_row fixed, recompute_sizes() derives every organization
    # field needed by memchar without consulting a physical bitcell view.
    original_compute_sizes = sram_config.compute_sizes

    def compute_existing_sizes(self):
        self.recompute_sizes()
        OPTS.words_per_row = self.words_per_row

    sram_config.compute_sizes = compute_existing_sizes
    try:
        sram = fake_sram(
            name=OPTS.output_name,
            word_size=OPTS.word_size,
            num_words=OPTS.num_words,
            write_size=OPTS.write_size,
            num_banks=OPTS.num_banks,
            words_per_row=OPTS.words_per_row,
            num_spare_rows=OPTS.num_spare_rows,
            num_spare_cols=OPTS.num_spare_cols,
        )
    finally:
        sram_config.compute_sizes = original_compute_sizes

    sram.width = OPTS.existing_sram_width
    sram.height = OPTS.existing_sram_height
    sram.drc_errors = 0
    sram.lvs_errors = 0
    sram.generate_pins()
    sram.setup_multiport_constants()

    OPTS.netlist_only = True
    OPTS.check_lvsdrc = False
    # Upstream v1.2.48 can consume a trimmed netlist in memchar mode but does
    # not create it.  Generate the standard row/column reduction here.  The
    # delay engine still copies and simulates the full source for leakage.
    if OPTS.trim_netlist:
        trimmed = Path(OPTS.openram_temp) / "trimmed.sp"
        probe_address = ("0" if sram.num_spare_rows else "") + "1" * (
            sram.addr_size - (1 if sram.num_spare_rows else 0)
        )
        trim_existing_netlist(spice_file, trimmed, sram,
                              probe_address, sram.word_size - 1)

    openram.print_banner()
    start = datetime.datetime.now()
    from openram.characterizer import lib
    mode = "trimmed timing + full leakage" if OPTS.trim_netlist else "fully untrimmed"
    debug.print_raw(f"LIB: Characterizing existing SRAM ({mode})... ")
    try:
        lib(out_dir=OPTS.output_path, sram=sram, sp_file=str(spice_file), use_model=False)
    except FeasibilityOnlyComplete as complete:
        period = float(complete.args[0])
        marker = Path(OPTS.output_path) / "feasibility_passed.json"
        marker.write_text(
            "{\n"
            f'  "period_ns": {period:g},\n'
            '  "functional_checks_passed": true\n'
            "}\n"
        )
        print(f"Feasibility-only functional checks passed at {period:g} ns")
        openram.end_openram()
        return 0
    elapsed = datetime.datetime.now() - start
    print(f"Characterization: {elapsed.total_seconds():.1f} seconds")
    print(f"Output files are: {OPTS.output_path}*.lib")
    openram.end_openram()
    return 0


if __name__ == "__main__":
    sys.exit(main())
