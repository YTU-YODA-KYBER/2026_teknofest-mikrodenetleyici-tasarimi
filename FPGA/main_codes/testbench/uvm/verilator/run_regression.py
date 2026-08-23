#!/usr/bin/env python3
"""
run_regression.py -- UVM regresyon kosucusu

YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi

Yedi blogun butun testlerini, verilen tohum sayisi kadar tekrarlayarak
paralel kosturur; sonuclari toplar ve verification/uvm/ altina rapor yazar.

Blok ve test listeleri Makefile'dan okunur -- tek kaynak orasidir, burada
ikinci bir liste TUTULMAZ.

Kullanim:
    source /usr/Verilator_uvm/env.sh
    python3 run_regression.py [--seeds 3] [--jobs 8] [--blocks gpio,i2c]
"""

import argparse
import csv
import os
import re
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

UVM_DIR   = Path(__file__).resolve().parent.parent
FPGA_ROOT = UVM_DIR.parent.parent.parent
RAPOR_DIR = FPGA_ROOT / "verification" / "uvm"
OBJ_ROOT  = Path(os.environ.get("UVM_OBJ_ROOT", "/usr/Verilator_uvm/build"))

# Bilerek basarisiz olmasi beklenen testler: bulunan bir RTL hatasini
# gosterirler. Raporda "beklenen basarisiz" olarak isaretlenir.
BEKLENEN_BASARISIZ = {
    "gpio_stress_test": "GPIO kabul kosulu kendi awready/arready'siyle nitelenmemis (bkz. findings.md)",
}


def makefile_oku():
    """Makefile'dan blok listesini ve blok basina test listesini cikarir."""
    mk = (UVM_DIR / "Makefile").read_text()
    mk = re.sub(r"\\\s*\n\s*", " ", mk)          # satir devamlarini birlestir
    bloklar = re.search(r"^BLOCKS\s*:=\s*(.+)$", mk, re.M).group(1).split()
    testler = {}
    for b in bloklar:
        m = re.search(rf"^{b}_TESTS\s*:=\s*(.+)$", mk, re.M)
        if m:
            testler[b] = m.group(1).split()
    return [b for b in bloklar if b in testler], testler


def derle(blok):
    t0 = time.time()
    r = subprocess.run(["make", "build", f"BLK={blok}"], cwd=UVM_DIR,
                       capture_output=True, text=True)
    return blok, r.returncode == 0, time.time() - t0, r.stdout + r.stderr


def kostur(blok, test, tohum):
    t0 = time.time()
    subprocess.run(["make", "run", f"BLK={blok}", f"TEST={test}", f"SEED={tohum}"],
                   cwd=UVM_DIR, capture_output=True, text=True)
    sure = time.time() - t0
    log = OBJ_ROOT / blok / "logs" / f"{test}_seed{tohum}.log"
    return blok, test, tohum, sure, log


def log_coz(log_yolu):
    """Log dosyasindan sonucu cikarir."""
    d = {"ihlal": None, "uyari": None, "hata": None, "sonuc": "LOG YOK",
         "yazma": 0, "okuma": 0, "kontrol": 0, "uyusmazlik": 0}
    if not log_yolu.exists():
        return d
    metin = log_yolu.read_text(errors="replace")

    m = re.search(r"AXI protokol ihlali\s*:\s*(\d+)", metin)
    if m: d["ihlal"] = int(m.group(1))
    m = re.search(r"Uyari \(stall/watchdog\)\s*:\s*(\d+)", metin)
    if m: d["uyari"] = int(m.group(1))
    m = re.search(r"UVM_ERROR \+ FATAL\s*:\s*(\d+)", metin)
    if m: d["hata"] = int(m.group(1))
    m = re.search(r"^  SONUC\s+:\s*(\S+)", metin, re.M)
    if m: d["sonuc"] = m.group(1)
    m = re.search(r"Scoreboard\s*:\s*yazma=(\d+) okuma=(\d+) kontrol=(\d+) uyusmazlik=(\d+)", metin)
    if m:
        d["yazma"], d["okuma"], d["kontrol"], d["uyusmazlik"] = map(int, m.groups())
    if "TB ZAMAN ASIMI" in metin:
        d["sonuc"] = "ZAMAN ASIMI"
    return d


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--seeds", type=int, default=3, help="blok basina tohum sayisi")
    ap.add_argument("--jobs",  type=int, default=max(1, os.cpu_count() // 3))
    ap.add_argument("--blocks", default="", help="virgulle ayrilmis blok listesi")
    ap.add_argument("--no-build", action="store_true")
    args = ap.parse_args()

    bloklar, testler = makefile_oku()
    if args.blocks:
        istenen = args.blocks.split(",")
        bloklar = [b for b in bloklar if b in istenen]

    print(f"[REGRESYON] {len(bloklar)} blok, tohum sayisi {args.seeds}, {args.jobs} paralel is")

    # ---- Derleme ----
    if not args.no_build:
        print("[REGRESYON] derleniyor...")
        with ThreadPoolExecutor(max_workers=2) as ex:
            for blok, ok, sure, ciktı in ex.map(derle, bloklar):
                print(f"  {blok:8s} {'OK ' if ok else 'HATA'} ({sure:5.1f} s)")
                if not ok:
                    print(ciktı[-2000:])
                    sys.exit(1)

    # ---- Kosum ----
    isler = [(b, t, s) for b in bloklar for t in testler[b]
                       for s in range(1, args.seeds + 1)]
    print(f"[REGRESYON] {len(isler)} kosum baslatiliyor...")

    sonuclar = []
    t0 = time.time()
    with ThreadPoolExecutor(max_workers=args.jobs) as ex:
        for i, (blok, test, tohum, sure, log) in enumerate(
                ex.map(lambda a: kostur(*a), isler), 1):
            d = log_coz(log)
            d.update(blok=blok, test=test, tohum=tohum, sure=round(sure, 1))
            beklenen = test in BEKLENEN_BASARISIZ
            d["beklenen_basarisiz"] = beklenen
            d["gecti"] = (d["sonuc"] == "GECTI") if not beklenen else (d["sonuc"] != "GECTI")
            sonuclar.append(d)
            durum = "GECTI" if d["gecti"] else "KALDI"
            etiket = " (beklenen basarisiz)" if beklenen else ""
            print(f"  [{i:3d}/{len(isler)}] {blok:8s} {test:26s} tohum={tohum} "
                  f"{durum}{etiket}  {sure:5.1f}s")
    toplam_sure = time.time() - t0

    RAPOR_DIR.mkdir(parents=True, exist_ok=True)
    rapor_yaz(sonuclar, bloklar, testler, args.seeds, toplam_sure)
    kalan = [d for d in sonuclar if not d["gecti"]]
    print(f"\n[REGRESYON] {len(sonuclar)} kosum, {len(sonuclar)-len(kalan)} gecti, "
          f"{len(kalan)} kaldi, {toplam_sure/60:.1f} dk")
    return 1 if kalan else 0


def rapor_yaz(sonuclar, bloklar, testler, tohum_sayisi, toplam_sure):
    # ---- CSV ----
    csv_yolu = RAPOR_DIR / "regression_results.csv"
    alanlar = ["blok", "test", "tohum", "sonuc", "gecti", "beklenen_basarisiz",
               "ihlal", "uyari", "hata", "yazma", "okuma", "kontrol",
               "uyusmazlik", "sure"]
    with csv_yolu.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=alanlar, extrasaction="ignore")
        w.writeheader()
        for d in sorted(sonuclar, key=lambda x: (x["blok"], x["test"], x["tohum"])):
            w.writerow(d)

    # ---- Markdown ozet ----
    from datetime import date
    sat = []
    sat.append("# UVM Regresyon Sonuclari\n")
    sat.append(f"Kosum tarihi: **{date.today().isoformat()}**  ")
    sat.append(f"Simulator: **Verilator 5.050**  |  UVM: **2020.3.1 (no-DPI)**  ")
    sat.append(f"Blok basina tohum sayisi: **{tohum_sayisi}**  |  "
               f"Toplam sure: **{toplam_sure/60:.1f} dakika**\n")
    sat.append("---\n")
    sat.append("## Blok ozeti\n")
    sat.append("| Blok | Test | Kosum | Gecti | Kaldi | AXI ihlali | Uyari |")
    sat.append("|---|---:|---:|---:|---:|---:|---:|")

    for b in bloklar:
        bs = [d for d in sonuclar if d["blok"] == b]
        if not bs:
            continue
        gecti = sum(1 for d in bs if d["gecti"])
        ihlal = sum(d["ihlal"] or 0 for d in bs if not d["beklenen_basarisiz"])
        uyari = sum(d["uyari"] or 0 for d in bs)
        sat.append(f"| {b} | {len(testler[b])} | {len(bs)} | {gecti} | "
                   f"{len(bs)-gecti} | {ihlal} | {uyari} |")

    toplam = len(sonuclar)
    tgecti = sum(1 for d in sonuclar if d["gecti"])
    tihlal = sum(d["ihlal"] or 0 for d in sonuclar if not d["beklenen_basarisiz"])
    sat.append(f"| **TOPLAM** | **{sum(len(testler[b]) for b in bloklar)}** | "
               f"**{toplam}** | **{tgecti}** | **{toplam-tgecti}** | **{tihlal}** | "
               f"**{sum(d['uyari'] or 0 for d in sonuclar)}** |\n")

    sat.append("> AXI ihlali sutununda **beklenen basarisiz** testler haric tutulmustur; "
               "onlar zaten bir RTL bulgusunu gostermek icin yazilmistir.\n")

    # ---- Beklenen basarisizlar ----
    bb = sorted({d["test"] for d in sonuclar if d["beklenen_basarisiz"]})
    if bb:
        sat.append("---\n")
        sat.append("## Beklenen basarisiz testler\n")
        sat.append("Bunlar ortamin bulduğu RTL sorunlarini gosterir; KALDI cikmalari "
                   "beklenen ve dogru sonuctur.\n")
        sat.append("| Test | Ne gosteriyor |")
        sat.append("|---|---|")
        for t in bb:
            sat.append(f"| `{t}` | {BEKLENEN_BASARISIZ[t]} |")
        sat.append("")

    # ---- Test bazinda matris ----
    sat.append("---\n")
    sat.append("## Test x tohum matrisi\n")
    for b in bloklar:
        bs = [d for d in sonuclar if d["blok"] == b]
        if not bs:
            continue
        tohumlar = sorted({d["tohum"] for d in bs})
        sat.append(f"### {b}\n")
        sat.append("| Test | " + " | ".join(f"tohum {s}" for s in tohumlar) +
                   " | AXI ihlali | Sure (s) |")
        sat.append("|---|" + "---|" * len(tohumlar) + "---:|---:|")
        for t in testler[b]:
            ts = [d for d in bs if d["test"] == t]
            hucre = []
            for s in tohumlar:
                d = next((x for x in ts if x["tohum"] == s), None)
                if d is None:
                    hucre.append("-")
                elif d["beklenen_basarisiz"]:
                    hucre.append("beklenen KALDI" if d["gecti"] else "**HATA**")
                else:
                    hucre.append("GECTI" if d["gecti"] else "**KALDI**")
            ihlal = max((d["ihlal"] or 0) for d in ts) if ts else 0
            sure  = max((d["sure"] or 0) for d in ts) if ts else 0
            sat.append(f"| `{t}` | " + " | ".join(hucre) + f" | {ihlal} | {sure:.1f} |")
        sat.append("")

    (RAPOR_DIR / "regression_summary.md").write_text("\n".join(sat) + "\n")
    print(f"[REGRESYON] rapor yazildi: {RAPOR_DIR/'regression_summary.md'}")


if __name__ == "__main__":
    sys.exit(main())
