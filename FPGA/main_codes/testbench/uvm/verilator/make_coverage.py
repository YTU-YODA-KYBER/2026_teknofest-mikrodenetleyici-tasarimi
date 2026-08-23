#!/usr/bin/env python3
"""
make_coverage.py -- UVM kapsam raporu ureteci

YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi

Regresyonun her kosumda yazdigi kapsam veritabanlarini birlestirir ve
verification/uvm/coverage/ altina iki cikti uretir:

  1) index.html    -- genhtml ile uretilen satir kapsami raporu (yalnizca
                      TASARIM dosyalari; UVM kutuphanesi ve testbench haric)
  2) functional.md -- covergroup bin tablosu; hangi bin dolmus, hangisi
                      erisilemez oldugu icin bos kalmis

Kullanim:
    source /usr/Verilator_uvm/env.sh
    python3 make_coverage.py
"""

import os
import re
import shutil
import subprocess
import sys
from collections import defaultdict
from datetime import date
from pathlib import Path

UVM_DIR   = Path(__file__).resolve().parent.parent
FPGA_ROOT = UVM_DIR.parent.parent.parent
RAPOR_DIR = FPGA_ROOT / "verification" / "uvm" / "coverage"
OBJ_ROOT  = Path(os.environ.get("UVM_OBJ_ROOT", "/usr/Verilator_uvm/build"))
CALISMA   = OBJ_ROOT / "coverage"

RTL_KOK = str(FPGA_ROOT / "main_codes" / "rtl" / "desgin_sources")

# Erisilemez oldugu BILINEN bin'ler ve gerekcesi. Kapsam yuzdesi
# hesaplanirken bunlar disarida birakilir.
ERISILEMEZ = {
    "slverr": "Tasarimdaki hicbir AXI4-Lite slave'i hata cevabi uretmiyor; "
              "bresp/rresp sabit OKAY. Adres araligi kontrolu yalnizca "
              "interconnect seviyesindedir.",
    "decerr": "Ayni sebep: slave'ler DECERR uretmiyor.",
}


def dat_topla():
    return sorted(OBJ_ROOT.glob("*/logs/*.dat"))


def birlestir(datlar, hedef):
    hedef.parent.mkdir(parents=True, exist_ok=True)
    # verilator_coverage komut satiri uzunluk siniri icin parca parca birlestir
    ara = hedef.parent / "ara.dat"
    if ara.exists():
        ara.unlink()
    grup = 200
    mevcut = None
    for i in range(0, len(datlar), grup):
        parca = [str(p) for p in datlar[i:i + grup]]
        girdi = ([str(mevcut)] if mevcut else []) + parca
        r = subprocess.run(["verilator_coverage", "--write", str(ara)] + girdi,
                           capture_output=True, text=True)
        if r.returncode != 0:
            print(r.stderr[-2000:])
            sys.exit(1)
        mevcut = ara
    shutil.move(str(ara), str(hedef))


def info_uret(birlesik, info):
    r = subprocess.run(["verilator_coverage", "--write-info", str(info), str(birlesik)],
                       capture_output=True, text=True)
    if r.returncode != 0:
        print(r.stderr[-2000:])
        sys.exit(1)


def info_suz(kaynak, hedef, kok):
    """lcov .info dosyasindan yalnizca TASARIM dosyalarini birakir."""
    tut, blok, sayac = [], [], False
    for satir in kaynak.read_text(errors="replace").splitlines():
        if satir.startswith("SF:"):
            blok = [satir]
            sayac = satir[3:].startswith(kok)
        elif satir.strip() == "end_of_record":
            blok.append(satir)
            if sayac:
                tut.extend(blok)
            blok, sayac = [], False
        else:
            blok.append(satir)
    hedef.write_text("\n".join(tut) + "\n")
    return sum(1 for s in tut if s.startswith("SF:"))


def covergroup_coz(birlesik):
    """Birlestirilmis .dat icinden covergroup bin'lerini cikarir."""
    metin = birlesik.read_text(errors="replace")
    binler = []
    for satir in metin.splitlines():
        if "v_covergroup/" not in satir:
            continue
        # Kayit bicimi:  \x01<anahtar>\x02<deger>  ... ' <sayi>
        m_bin = re.search("\x01bin\x02([^\x01']*)", satir)
        m_say = re.search(r"'\s+(\d+)\s*$", satir)
        m_grp = re.search("\x01page\x02v_covergroup/([^\x01']*)", satir)
        m_hiy = re.search("\x01h\x02([^\x01']*)", satir)
        m_dos = re.search("\x01f\x02([^\x01']*)", satir)
        m_sat = re.search(r"\x01l\x02(\d+)", satir)
        if m_bin and m_say:
            tam = m_hiy.group(1) if m_hiy else m_bin.group(1)
            # "__vlAnonCG_cg_axil.cp_kind.okuma" -> coverpoint + bin
            parca = tam.split(".")
            binler.append({
                "grup":  m_grp.group(1) if m_grp else "?",
                "cp":    parca[-2] if len(parca) >= 2 else "?",
                "bin":   m_bin.group(1),
                "sayi":  int(m_say.group(1)),
                "dosya": Path(m_dos.group(1)).name if m_dos else "?",
                "satir": int(m_sat.group(1)) if m_sat else 0,
            })
    return binler


def satir_kapsami(info_yolu):
    """Suzulmus .info dosyasindan dosya bazinda satir kapsami cikarir.

    verilator_coverage'in urettigi .info dosyasinda LF:/LH: ozet satirlari
    yoktur; sayim DA: satirlarindan yapilir (DA:<satir>,<sayi>).
    """
    sonuc = {}
    dosya = None
    for satir in info_yolu.read_text(errors="replace").splitlines():
        if satir.startswith("SF:"):
            dosya = Path(satir[3:]).name
            sonuc.setdefault(dosya, {"toplam": 0, "kapsanan": 0})
        elif satir.startswith("DA:") and dosya:
            try:
                _, say = satir[3:].split(",")
            except ValueError:
                continue
            sonuc[dosya]["toplam"] += 1
            if int(say) > 0:
                sonuc[dosya]["kapsanan"] += 1
    for d in sonuc.values():
        d["yuzde"] = 100.0 * d["kapsanan"] / d["toplam"] if d["toplam"] else 0.0
    return sonuc


def main():
    datlar = dat_topla()
    if not datlar:
        print("[KAPSAM] hic .dat bulunamadi -- once regresyonu kosturun")
        return 1
    print(f"[KAPSAM] {len(datlar)} kapsam veritabani birlestiriliyor...")

    CALISMA.mkdir(parents=True, exist_ok=True)
    birlesik = CALISMA / "merged.dat"
    birlestir(datlar, birlesik)

    tum_info = CALISMA / "tum.info"
    info_uret(birlesik, tum_info)

    tasarim_info = CALISMA / "tasarim.info"
    n = info_suz(tum_info, tasarim_info, RTL_KOK)
    print(f"[KAPSAM] {n} tasarim dosyasi suzuldu")

    RAPOR_DIR.mkdir(parents=True, exist_ok=True)
    if shutil.which("genhtml"):
        # --prefix: rapordaki yollar RTL kokune GORE kisaltilir, yoksa
        # genhtml mutlak yolu klasor agaci olarak yeniden uretir.
        r = subprocess.run(["genhtml", str(tasarim_info), "-o", str(RAPOR_DIR),
                            "--title", "YODA KYBER -- UVM satir kapsami",
                            "--prefix", RTL_KOK,
                            "--legend", "--quiet"],
                           capture_output=True, text=True)
        if r.returncode != 0:
            print("[KAPSAM] genhtml hatasi:", r.stderr[-1000:])
        else:
            print(f"[KAPSAM] HTML rapor: {RAPOR_DIR/'index.html'}")
    else:
        print("[KAPSAM] genhtml bulunamadi (lcov kurulu degil), HTML uretilmedi")

    shutil.copy(tasarim_info, RAPOR_DIR / "tasarim.info")

    # ---- Fonksiyonel kapsam ----
    binler = covergroup_coz(birlesik)
    kapsam = satir_kapsami(tasarim_info)
    fonksiyonel_yaz(binler, kapsam)
    return 0


def fonksiyonel_yaz(binler, kapsam):
    gruplar = defaultdict(list)
    for b in binler:
        # Verilator sinif icinde tanimlanan covergroup'un ortuk ornegini
        # "__vlAnonCG_<tip>" diye adlandirir; raporda tip adi kullanilir.
        ad = b["grup"].replace("__vlAnonCG_", "")
        gruplar[ad].append(b)

    sat = []
    sat.append("# UVM Fonksiyonel Kapsam\n")
    sat.append(f"Uretim tarihi: **{date.today().isoformat()}**  ")
    sat.append("Kaynak: `axil_coverage` covergroup'u, butun bloklarin butun "
               "kosumlari birlestirilerek.\n")
    sat.append("Toplayici, monitorun paketledigi HER AXI transaction'ini ornekler; "
               "yani surucunun ne yapmak istedigini degil, telde ne oldugunu sayar.\n")
    sat.append("---\n")

    toplam = dolan = erisilemez = 0
    for grup, bs in sorted(gruplar.items()):
        sat.append(f"## `{grup}`\n")
        sat.append("| Coverpoint | Bin | Ornek sayisi | Durum |")
        sat.append("|---|---|---:|---|")
        for b in sorted(bs, key=lambda x: (x["satir"], x["bin"])):
            toplam += 1
            ad = b["bin"]
            if b["sayi"] > 0:
                durum = "dolu"
                dolan += 1
            elif ad in ERISILEMEZ:
                durum = "**erisilemez** (gerekce asagida)"
                erisilemez += 1
            else:
                durum = "**BOS**"
            sat.append(f"| `{b['cp']}` | `{ad}` | {b['sayi']} | {durum} |")
        sat.append("")

    olculebilir = toplam - erisilemez
    oran = 100.0 * dolan / olculebilir if olculebilir else 0.0
    sat.insert(6, f"**Toplam bin: {toplam}  |  dolan: {dolan}  |  "
                  f"erisilemez: {erisilemez}  |  kapsam: %{oran:.1f}**\n")

    sat.append("---\n")
    sat.append("## Erisilemez bin'ler ve gerekceleri\n")
    for ad, gerekce in ERISILEMEZ.items():
        sat.append(f"- **`{ad}`** — {gerekce}")
    sat.append("")
    sat.append("Bu bin'ler bilerek tanimlanmistir: kapsam raporunun tasarimin "
               "hangi davranislari **uretemedigini** de gostermesi icin. "
               "Kapsam yuzdesi hesaplanirken paydadan cikarilmislardir.\n")

    if kapsam:
        sat.append("---\n")
        sat.append("## Tasarim dosyasi bazinda satir kapsami\n")
        sat.append("| Dosya | Satir | Kapsanan | Yuzde |")
        sat.append("|---|---:|---:|---:|")
        for d, v in sorted(kapsam.items()):
            sat.append(f"| `{d}` | {v.get('toplam',0)} | {v.get('kapsanan',0)} | "
                       f"%{v['yuzde']:.1f} |")
        sat.append("")
        sat.append("> Ayrintili satir satir gorunum icin [`index.html`](index.html).\n")

    (RAPOR_DIR / "functional.md").write_text("\n".join(sat) + "\n")
    print(f"[KAPSAM] fonksiyonel kapsam: {RAPOR_DIR/'functional.md'}")


if __name__ == "__main__":
    sys.exit(main())
