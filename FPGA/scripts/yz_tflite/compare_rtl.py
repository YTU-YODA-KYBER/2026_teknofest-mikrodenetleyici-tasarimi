#!/usr/bin/env python3
# =====================================================================
#  compare_rtl.py -- TFLite yazilim referansi  vs  hizlandirici RTL'i
#
#  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
#
#  NEYI OLCER
#  ----------
#  Ayni girdiyi hem tflite_ref (C) hem conv_accelerator.v (Icarus
#  Verilog) uzerinden gecirip karsilastirir:
#
#    * SINIF UYUMU    -- sartnamedeki %10 penceresinin asil konusu
#    * SKOR SAPMASI   -- FC akumulatorlerindeki fark. Sifir olmasi
#                        BEKLENMEZ: RTL requant'i tek adimli
#                        (acc*M0 + round) >> SHR, TFLite ise iki adimli
#                        gemmlowp (doubling-high-mul + rounding-shift).
#                        18-bit M0'in bagil hatasi ~1e-5 mertebesinde.
#    * CEVRIM SAYISI  -- hizlandiricinin start->done suresi; "hizlanma"
#                        maddesinin donanim tarafi rakami.
#
#  KART GEREKTIRMEZ, VIVADO GEREKTIRMEZ
#  ------------------------------------
#  main_codes/testbench/AI_Accelerator/tb_conv_accel.v kosturulur; o
#  testbench fc_scores'u hiyerarsik okuyup basar. Vivado sistem testinin
#  yerini TUTMAZ (CPU/AXI/UART yolunu test etmez), hizlandirici
#  cekirdeginin dogrulugu icin hizli kapidir.
#
#  KURULUM :  sudo apt install iverilog
#
#  KULLANIM
#  --------
#      python3 compare_rtl.py                      # 3 referans ornek
#      python3 compare_rtl.py --dataset <klasor>   # klasordeki tum .hex
#      python3 compare_rtl.py a.hex b.hex          # belirli dosyalar
# =====================================================================
"""tflite_ref (C) ile conv_accelerator (RTL) sonuclarini karsilastirir."""

import argparse
import csv
import os
import re
import shutil
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
ACCEL = ROOT / "main_codes/rtl/desgin_sources/AI_Accelerator"
TB = ROOT / "main_codes/testbench/AI_Accelerator/tb_conv_accel.v"
REF_RUN = HERE / "ref_run"
SAMPLES = ROOT / "firmware/sound_samples"

RTL_SRCS = ["conv_accelerator.v", "conv_buf_ram.v",
            "weights_rom_p8.v", "fc_weights_rom_p4.v"]

# tb_conv_accel.v'nin bastigi satir:
#   RUN=0 FILE=... CLASS=2 CYCLES=45500 S0=.. S1=.. S2=.. S3=..
LINE_RE = re.compile(
    r"RUN=(\d+)\s+FILE=(\S+)\s+CLASS=(-?\d+)\s+CYCLES=(\d+)\s+"
    r"S0=(-?\d+)\s+S1=(-?\d+)\s+S2=(-?\d+)\s+S3=(-?\d+)")

CLASS_NAME = {0: "sessizlik", 1: "bilinmeyen", 2: "yes", 3: "no"}


def need(tool):
    if shutil.which(tool) is None:
        sys.exit(f"HATA: '{tool}' bulunamadi.\n  Kurulum:  sudo apt install iverilog")


def build_sim(workdir):
    """Simulasyonu derle.

    $readmemh("biases.hex") gibi GORECELI yollar RTL'in icinde sabit, bu
    yuzden vvp'nin AI_Accelerator klasorunden calismasi gerekir. Derleme
    ciktisi gecici klasore konur -- kaynak agacina hicbir sey birakmiyoruz.
    """
    sim = workdir / "sim.vvp"
    cmd = ["iverilog", "-g2012", "-o", str(sim), str(TB)] + \
          [str(ACCEL / s) for s in RTL_SRCS]
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0:
        sys.exit(f"HATA: iverilog derleme basarisiz:\n{r.stdout}{r.stderr}")
    if r.stderr.strip():
        print("  (iverilog uyarilari)\n   ", r.stderr.strip().replace("\n", "\n    "))
    return sim


def run_rtl(sim, hex_path):
    """Tek girdi icin RTL kosumu -> (class, cycles, [s0..s3]).

    Testbench ARD ARDA IKI cikarim yapar; ikisi de ayni cikmali (durum
    makinesinin kendini sifirladigini dogrular). Farkliysa kart uzerinde
    ikinci sesin yanlis siniflanmasi demek olurdu.
    """
    r = subprocess.run(["vvp", str(sim), f"+INPUT={Path(hex_path).resolve()}"],
                       capture_output=True, text=True, cwd=str(ACCEL))
    runs = [m.groups() for m in LINE_RE.finditer(r.stdout)]
    if len(runs) < 2:
        sys.exit(f"HATA: RTL kosumu beklenen ciktiyi vermedi ({hex_path}):\n"
                 f"{r.stdout}{r.stderr}")

    parsed = [(int(g[2]), int(g[3]), [int(x) for x in g[4:8]]) for g in runs]
    if parsed[0] != parsed[1]:
        sys.exit(f"HATA: {Path(hex_path).name}: ard arda iki cikarim FARKLI\n"
                 f"  run0 = {parsed[0]}\n  run1 = {parsed[1]}\n"
                 f"  Durum makinesi kendini sifirlamiyor olabilir.")
    return parsed[0]


def run_ref(hex_paths):
    """C referansini tum girdiler uzerinde kosturur -> {yol: satir}."""
    if not REF_RUN.exists():
        sys.exit(f"HATA: {REF_RUN.name} yok. Once `make` calistir.")
    r = subprocess.run([str(REF_RUN)] + [str(p) for p in hex_paths],
                       capture_output=True, text=True)
    if r.returncode != 0:
        sys.exit(f"HATA: ref_run basarisiz:\n{r.stderr}")
    return {row["dosya"]: row for row in csv.DictReader(r.stdout.splitlines())}


def collect_inputs(args):
    if args.files:
        return [Path(f) for f in args.files]
    if args.dataset:
        files = sorted(Path(args.dataset).rglob("*.hex"))
        if not files:
            sys.exit(f"HATA: {args.dataset} altinda .hex yok")
        return files
    return sorted(SAMPLES.glob("*.hex"))


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("files", nargs="*", help="girdi hex dosyalari")
    ap.add_argument("--dataset", help="veri kumesi klasoru (altindaki tum .hex)")
    ap.add_argument("--limit", type=int, help="ilk N ornekle sinirla")
    ap.add_argument("--jobs", type=int, help="paralel vvp sayisi")
    args = ap.parse_args()

    need("iverilog")
    need("vvp")

    inputs = collect_inputs(args)
    if args.limit:
        inputs = inputs[:args.limit]
    print(f"karsilastirilacak ornek : {len(inputs)}")

    with tempfile.TemporaryDirectory() as tmp:
        print("iverilog derleniyor...")
        sim = build_sim(Path(tmp))
        ref = run_ref(inputs)

        # vvp tek is parcacikli ve ornek basina ~1 s suruyor; ornekler
        # bagimsiz oldugu icin paralel kosturuyoruz.
        jobs = args.jobs or min(len(inputs), (os.cpu_count() or 4))
        if len(inputs) > 1:
            print(f"RTL kosumu ({len(inputs)} ornek, {jobs} paralel)...")
        with ThreadPoolExecutor(max_workers=jobs) as ex:
            hw_all = list(ex.map(lambda p: run_rtl(sim, p), inputs))

    print(f"\n{'ornek':<32}{'yzlm':>5}{'dnnm':>5}{'cevrim':>9}"
          f"{'en buyuk skor farki':>22}")
    print("-" * 74)

    mismatch, cycles, worst_all = [], [], 0.0
    for p, (hw_cls, hw_cyc, hw_scores) in zip(inputs, hw_all):
        row = ref[str(p)]
        sw_cls = int(row["sinif"])
        sw_acc = [int(row[f"acc{i}"]) for i in range(4)]
        cycles.append(hw_cyc)

        # Sapmayi skor buyuklugune gore olcuyoruz: ham fark tek basina
        # anlamsiz, cunku skorlar ornekten ornege on kat degisiyor.
        span = max(max(sw_acc) - min(sw_acc), 1)
        rel = max(abs(a - b) for a, b in zip(sw_acc, hw_scores)) / span
        worst_all = max(worst_all, rel)

        ok = (hw_cls == sw_cls)
        if not ok:
            mismatch.append((p, sw_cls, hw_cls))

        print(f"{p.name:<32}{sw_cls:>5}{hw_cls:>5}{hw_cyc:>9}"
              f"{rel:>21.2%}{'' if ok else '   <-- FARK'}")

    n = len(inputs)
    print("\n" + "=" * 74)
    print("  TFLite yazilim referansi  vs  conv_accelerator (RTL)")
    print("=" * 74)
    print(f"  ornek sayisi                 : {n}")
    print(f"  sinif uyumu                  : {n - len(mismatch)}/{n}"
          f"  ({100.0 * (n - len(mismatch)) / n:.1f}%)")
    print(f"  en buyuk skor sapmasi        : {worst_all:.2%} (skor araligina gore)")

    if cycles:
        lo, hi = min(cycles), max(cycles)
        rng = f"{lo}" if lo == hi else f"{lo}..{hi}"
        print(f"\n  donanim cevrim sayisi        : {rng}"
              f"   (50 MHz -> {hi / 50e6 * 1000:.3f} ms)")
        print("    ^ 'hizlanma' maddesinin donanim tarafi; yazilim tarafi")
        print("      ayni modelin RV32 kosumundan olculecek.")

    if mismatch:
        print("\n  SINIF FARKI OLAN ORNEKLER:")
        for p, s, h in mismatch:
            print(f"    {p.name}: yazilim={s} ({CLASS_NAME.get(s, '?')}), "
                  f"donanim={h} ({CLASS_NAME.get(h, '?')})")
        print("\n  Az sayida fark NORMALDIR (requant yaklasimi). Sistematik")
        print("  ya da tek yone egilimliyse M0/SHR sabitleri incelenmeli.")
        return 1

    print("\n  SONUC: tum orneklerde AYNI SINIF.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
