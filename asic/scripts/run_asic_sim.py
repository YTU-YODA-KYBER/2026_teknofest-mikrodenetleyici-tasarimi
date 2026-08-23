#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  run_asic_sim.py -- ASIC yapilandirmasinin islevsel dogrulamasi (XSim)
#
#  NE YAPAR?
#    asic/filelist.f'teki RTL'i -- yani SKY130 SRAM makrolari ve mask ROM'larla
#    kurulmus SoC'yi -- mevcut sistem testbench'leriyle simule eder. Boylece
#    sartname Bolum 1.3'un "zorunlu SRAM makrosu ... islevsel dogrulama
#    testlerinde kullanilmalidir" sarti sistem seviyesinde karsilanir.
#
#  TESTLER
#    mem   : tb_asic_mem_equiv   -- ASIC bellek sarmalayicilarinin orijinal FPGA
#                                   modulleriyle bit-bit esdegerligi
#    boot  : boot_test           -- Boot ROM'dan acilis, QSPI flash'tan uygulamayi
#                                   Instruction RAM'e yukleme (IMEM SRAM'i surer)
#    yz    : ai_accel_test       -- YZ hizlandirici cikarimi (YZ girdi RAM'i ve
#                                   konvolusyon tamponu SRAM'lerini surer)
#
#  BOOT ROM ICERIGI HAKKINDA
#    ASIC'te Boot ROM bir mask ROM'dur; icerigi sentez aninda RTL'e gomulur.
#    Sistem testleri (FPGA akisinda oldugu gibi) kart firmware'i yerine
#    simulasyon firmware'ini ister (sim_boot.hex / sim_app.hex). Bu betik o
#    testler icin gecici bir ROM varyanti uretir; DONANIM yapisi birebir
#    aynidir, yalnizca gomulu firmware farklidir. Teslim edilen GDSII'de kart
#    firmware'i (boot.hex) gomuludur.
# ---------------------------------------------------------------------------
import argparse
import os
import pathlib
import shutil
import subprocess
import sys

ASIC = pathlib.Path(__file__).resolve().parent.parent
ROOT = ASIC.parent
FPGA = ROOT / "FPGA"
TB = FPGA / "main_codes/testbench"
FW = FPGA / "firmware/makefile_outputs"
AI = FPGA / "main_codes/rtl/desgin_sources/AI_Accelerator"
VIVADO = pathlib.Path(os.environ.get("VIVADO_ROOT", "/usr/Vivado/2025.2/Vivado"))

sys.path.insert(0, str(ASIC / "scripts"))
from filelist import parse  # noqa: E402

TESTS = {
    "mem": dict(
        top="tb_asic_mem_equiv",
        rtl_from_filelist=False,
        extra=[ROOT / "asic_rtl/testbench/tb_asic_mem_equiv.sv"],
        hexes=["boot.hex"],
        ai_hexes=["weights_p8.hex", "fc_weights_p4.hex"],
        boot_hex=None,
    ),
    "boot": dict(
        top="boot_test",
        rtl_from_filelist=True,
        extra=[TB / "AXI_protocol_check/axi_chk_pkg.sv",
               TB / "AXI_protocol_check/axi4lite_protocol_checker.sv",
               TB / "Peripherals/QSPI/Micron_sim_model.v",
               TB / "System_Test/boot_test.sv"],
        incdirs=[TB / "AXI_protocol_check"],
        hexes=[],
        ai_hexes=["weights_p8.hex", "fc_weights_p4.hex", "biases.hex", "fc_biases.hex"],
        boot_hex="sim_boot.hex",
    ),
    "yz": dict(
        top="ai_accel_test",
        rtl_from_filelist=True,
        extra=[TB / "AXI_protocol_check/axi_chk_pkg.sv",
               TB / "AXI_protocol_check/axi4lite_protocol_checker.sv",
               TB / "System_Test/ai_accel_test.sv"],
        incdirs=[TB / "AXI_protocol_check"],
        hexes=[],
        ai_hexes=["weights_p8.hex", "fc_weights_p4.hex", "biases.hex", "fc_biases.hex"],
        sound=True,
        boot_hex="sim_app.hex",
    ),
}

SRAM_MODELS = [
    "sky130_sram_2kbyte_1rw1r_32x512_8.v",
    "sky130_sram_1kbyte_1rw1r_32x256_8.v",
]


def run(cmd, cwd, log):
    print(f"    $ {' '.join(str(c) for c in cmd[:3])} …")
    with open(log, "w") as f:
        r = subprocess.run(cmd, cwd=cwd, stdout=f, stderr=subprocess.STDOUT, text=True)
    return r.returncode


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("test", choices=sorted(TESTS))
    ap.add_argument("--work", type=pathlib.Path,
                    default=pathlib.Path(os.environ.get("ASIC_SIM_DIR",
                                                        "/usr/asic_flow/sim")))
    a = ap.parse_args()
    t = TESTS[a.test]

    settings = VIVADO / "settings64.sh"
    if not settings.is_file():
        sys.exit(f"HATA: Vivado bulunamadi: {settings}\n"
                 f"      VIVADO_ROOT ile yolu verin.")

    w = a.work / a.test
    if w.exists():
        shutil.rmtree(w)
    w.mkdir(parents=True)

    # --- yardimci veri dosyalari calisma dizinine ---
    for h in t.get("ai_hexes", []):
        shutil.copy2(AI / h, w)
    for h in t.get("hexes", []):
        shutil.copy2(FW / h, w)
    if t.get("sound"):
        for s in ("input_data_yes.hex", "input_data_no.hex", "input_data_sessizlik.hex"):
            p = FPGA / "firmware/sound_samples" / s
            if p.is_file():
                shutil.copy2(p, w)

    # --- RTL listesi ---
    incdirs, files = parse()
    sram_dir = pathlib.Path(os.environ["PDK_ROOT"]) / "sky130A/libs.ref/sky130_sram_macros/verilog"
    v_models = [sram_dir / m for m in SRAM_MODELS]

    if t["rtl_from_filelist"]:
        rtl = list(files)
        # Boot ROM icerigini simulasyon firmware'i ile degistir
        if t.get("boot_hex"):
            gen = w / "boot_rom_sim.sv"
            subprocess.run([sys.executable, str(ASIC / "scripts/gen_rom.py"),
                            "--kind", "boot_rom",
                            "--hex", str(FW / t["boot_hex"]),
                            "--out", str(gen),
                            "--orig", "Memory/BRAM_defines/boot_rom_def.sv"],
                           check=True, stdout=subprocess.DEVNULL)
            rtl = [gen if p.name == "boot_rom_asic.sv" else p for p in rtl]
    else:
        AS = ROOT / "asic_rtl"
        rtl = [AS / f for f in (
            "mem/sram32_cell.sv", "mem/sram32_cell_1k.sv",
            "mem/sram32_bank.sv", "mem/sram8_bank.sv",
            "gen/boot_rom_asic.sv", "gen/weights_rom_p8_asic.v",
            "gen/fc_weights_rom_p4_asic.v")]

    inc_args = []
    for d in list(incdirs) + [pathlib.Path(p) for p in t.get("incdirs", [])]:
        inc_args += ["-i", str(d)]

    sh = f"source {settings} >/dev/null && "
    logs = w / "logs"
    logs.mkdir()

    print(f"\n=== ASIC islevsel simulasyon: {a.test}  ({t['top']}) ===")
    print(f"    calisma dizini: {w}")

    steps = [
        ("1-sram-modelleri",
         ["bash", "-c", sh + "xvlog --relax " + " ".join(f'"{p}"' for p in v_models)]),
        ("2-rtl",
         ["bash", "-c", sh + "xvlog -sv --relax -d SRAM_SIM " +
          " ".join(inc_args) + " " + " ".join(f'"{p}"' for p in rtl)]),
        ("3-testbench",
         ["bash", "-c", sh + "xvlog -sv --relax -d SRAM_SIM " +
          " ".join(inc_args) + " " + " ".join(f'"{p}"' for p in t["extra"])]),
        ("4-elaborate",
         ["bash", "-c", sh + f"xelab --relax -debug off {t['top']} -s sim_top"]),
        ("5-simule",
         ["bash", "-c", sh + "xsim sim_top -runall"]),
    ]
    for name, cmd in steps:
        log = logs / f"{name}.log"
        rc = run(cmd, w, log)
        if rc != 0:
            print(f"\n  ADIM BASARISIZ: {name}  (kod {rc})")
            print(f"  --- {log} son satirlar ---")
            print("\n".join(pathlib.Path(log).read_text().splitlines()[-25:]))
            return rc

    out = (logs / "5-simule.log").read_text()
    print("\n--- simulasyon ciktisi (ozet) ---")
    keep = [l for l in out.splitlines()
            if any(k in l for k in ("SONUC", "BASARILI", "BASARISIZ", "PASS", "FAIL",
                                    "HATA", "ERROR", "Fatal", "YZ:", "ihlal", "$finish"))]
    print("\n".join(keep[-40:]) or out[-2000:])
    bad = any(k in out for k in ("BASARISIZ", "FAIL", "Fatal", "ERROR:"))
    print(f"\n=== {a.test}: {'BASARISIZ' if bad else 'BASARILI'} ===")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
