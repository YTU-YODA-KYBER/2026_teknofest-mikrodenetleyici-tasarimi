#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  gen_macro_keepout.py -- SRAM makrolarinin cevresine met1 keep-out uretir ve
#                          config.yaml icindeki ROUTING_OBSTRUCTIONS blogunu
#                          esitler.
#
#  NEDEN GEREKLI?
#    Detailed routing'i bitirebilen tek kosumda (exp_grt_adj010_drt) geriye
#    7 DRC ihlali kalmisti. Ihlallerin dokumu (o kosumun top_module.drc'si,
#    kopyasi reports/synthesis/deney_arsivi/ altinda):
#
#      6 x Short        met1   net <-> conv_accelerator_inst.u_conv_buf_ram
#                                       ...g_2k[1].u_cell.u_sram
#      1 x Metal Spacing met1  rdata[2] <-> rdata[5]
#
#    7'sinin de katmani met1, 7'sinin de yeri TEK bir makronun sol/ust OBS
#    sinirinin hemen disi (X 2563..2633, Y 1960..1992). Sebep: SRAM LEF'i
#    met1'i makro uzerinde %99,5 kapatir; global router kaba izgarada makro
#    kenarina bitisik gcell'lere yol planlayabiliyor, detailed router o
#    sekilleri gerceklestirince makronun OBS dikdortgenine deger.
#
#    Makro kenarina 10 um'lik bir met1 keep-out koymak guide'larin o seride
#    olusmasini bastan engeller.
#
#  NEDEN 15 MAKRONUN HEPSINE?
#    Onceki oturumda yalnizca ihlalin gorüldügü TEK makro icin elle koordinat
#    yazilmisti (experiments/grt_target_sram_m1_keepout_*.yaml). Ayni yapisal
#    durum 15 makronun HEPSINDE var; hangi makronun kenarinin kurban olacagi
#    yerlestirmeye gore degisir. Ayrica elle yazilan koordinat, floorplan
#    degisirse sessizce yanlis yere duser.
#
#  MALIYETI?
#    Olculdu: tek makro icin met1 kaynagi 1.323.945 -> 1.323.599 (346 track,
#    %0,03). 15 makro icin ~%0,4. Keep-out 20 um'lik makro halo'sunun (
#    FP_MACRO_*_HALO) ICINDE kaldigi icin hicbir standart hucre yerlesimini
#    engellemez ve SRAM sinyal pinleri met4'te oldugu icin pin erisimini de
#    kapatmaz.
#
#  NEDEN SADECE met1?
#    Olculen 7 markerin 7'si de met1'dedir. met2 de makro uzerinde %99,5
#    kapalidir ama en tikanik katmandir; olculmemis bir riske karsi oradan
#    kaynak kismak ters teper. Nihai DRT met2 markeri gosterirse bu betige
#    --layers met1,met2 ile eklenir.
#
#  Kullanim:
#     python3 scripts/gen_macro_keepout.py            # config.yaml'i esitle
#     python3 scripts/gen_macro_keepout.py --check    # guncel mi dogrula
# ---------------------------------------------------------------------------
import argparse
import pathlib
import re
import sys

ASIC = pathlib.Path(__file__).resolve().parent.parent
CFG = ASIC / "config.yaml"
PLACEMENT = ASIC / "constraints" / "macro_placement.cfg"

# LEF SIZE degerleri (macros/*/lef/*.lef icinden)
MACRO_2K = (683.10, 416.54)   # sky130_sram_2kbyte_1rw1r_32x512_8
MACRO_1K = (479.78, 397.50)   # sky130_sram_1kbyte_1rw1r_32x256_8

BEGIN = "# >>> OTOMATIK URETILEN BLOK -- makro met1 keep-out (make keepout) <<<"
END = "# >>> OTOMATIK URETILEN BLOK SONU (keep-out) <<<"


def die_area():
    """config.yaml'daki DIE_AREA'yi okur."""
    m = re.search(r"^DIE_AREA:\s*\[([^\]]+)\]", CFG.read_text(), re.M)
    if not m:
        sys.exit("HATA: config.yaml icinde DIE_AREA bulunamadi")
    x0, y0, x1, y1 = (float(v) for v in m.group(1).split(","))
    return x0, y0, x1, y1


def read_placement():
    """macro_placement.cfg -> [(instance, x, y, orient)]"""
    if not PLACEMENT.is_file():
        sys.exit(f"HATA: {PLACEMENT} yok")
    out = []
    for line in PLACEMENT.read_text().splitlines():
        line = line.split("#", 1)[0].strip()
        if not line:
            continue
        parts = line.split()
        if len(parts) != 4:
            sys.exit(f"HATA: yerlesim satiri cozulemedi: {line!r}")
        inst, x, y, orient = parts
        if orient != "N":
            # Dondurulmus makroda W/H yer degistirir; bugun hepsi N
            # (guc pinleri met3/yatay, PDN'in met4 dikey seritlerine dik).
            sys.exit(f"HATA: bu betik yalniz N yonelimini destekler: {inst} {orient}")
        out.append((inst, float(x), float(y), orient))
    return out


def macro_size(inst: str):
    return MACRO_1K if "g_1k" in inst else MACRO_2K


def build(margin: float, layer: str):
    dx0, dy0, dx1, dy1 = die_area()
    rows = []
    for inst, x, y, _ in read_placement():
        w, h = macro_size(inst)
        x0 = max(dx0, round(x - margin, 2))
        y0 = max(dy0, round(y - margin, 2))
        x1 = min(dx1, round(x + w + margin, 2))
        y1 = min(dy1, round(y + h + margin, 2))
        # Okunabilir etiket: "<ust blok>.<banka>"  (or. yz_bram_ctrl_inst.g_2k[3])
        parts = inst.split(".")
        bank = next((q for q in parts if q.startswith(("g_2k", "g_1k"))), parts[-2])
        short = parts[0] + "." + bank
        rows.append((f"  - [{layer}, {x0:.2f}, {y0:.2f}, {x1:.2f}, {y1:.2f}]", short))
    width = max(len(r[0]) for r in rows)
    body = [BEGIN,
            f"# {len(rows)} SRAM makrosunun cevresinde {margin:g} um'lik {layer} keep-out.",
            f"# Ureten: scripts/gen_macro_keepout.py (kaynak: constraints/macro_placement.cfg)",
            "# Gerekce ve olculen maliyet o betigin basligindadir.",
            "ROUTING_OBSTRUCTIONS:"]
    body += [f"{r[0]:<{width}}   # {r[1]}" for r in rows]
    body.append(END)
    return "\n".join(body) + "\n"


def build_disabled(margin: float, layer: str):
    """Keep-out KAPALI blogu -- neden kapatildigini olcumle birlikte yazar."""
    return "\n".join([
        BEGIN,
        "# KEEP-OUT'LAR KAPALI.  Bu blok bilerek 'null' birakilmistir.",
        "#",
        "# GEREKCE (olculdu, tahmin degil): makro kenarlarina 10 um met1 keep-out",
        "# koymak + GRT cezalarini gevsetmek GRT toplam asimini 5.114'ten 39'a",
        "# indiriyordu, ama DETAYLI YOLLAMAYI cok daha kotu bir noktadan",
        "# baslatiyordu:",
        "#",
        "#   DRT iterasyonu | keep-out + adj 0.05 | keep-out YOK + adj 0.10",
        "#   ---------------+---------------------+-------------------------",
        "#                0 |             233.380 |                  89.218",
        "#                1 |             204.779 |                  41.952",
        "#                3 |            ~165.000 |                  14.862",
        "#              son |    (yakinsamiyordu) |            **24 ihlal**",
        "#",
        "# Yani GRT asimi bu tasarimda gercek metrikle (DRT DRC) TERS korele bir",
        "# VEKIL METRIKTIR: router'a daha fazla gorunur kapasite verilince daha",
        "# sikisik guide uretiyor, detayli yollayici gerceklestiremiyor.",
        "#",
        "# DURUSTLUK NOTU: bu karsilastirmada keep-out'lar ve ceza ayarlari",
        "# BIRLIKTE degistirildi; hangisinin tek basina zararli oldugu izole",
        "# EDILMEDI. Dogrulanan sey KOMBINASYONDUR.",
        "#",
        "# Keep-out'lari geri acmak icin:  make keepout MODE=on",
        f"# (uretilen deger: {len(read_placement())} makro, {margin:g} um {layer})",
        "ROUTING_OBSTRUCTIONS: null",
        END,
    ]) + "\n"


def main():
    ap = argparse.ArgumentParser(description="SRAM makro met1 keep-out ureteci")
    ap.add_argument("--margin", type=float, default=10.0,
                    help="makro kenarindan disari pay (um), varsayilan 10")
    ap.add_argument("--layer", default="met1")
    ap.add_argument("--mode", choices=("off", "on"), default="off",
                    help="off (VARSAYILAN): keep-out URETME, blogu 'null' olarak "
                         "yaz. Gerekce: olculdu, DRT'yi kotulestiriyor (bkz. "
                         "betik basligi). on: keep-out'lari uret.")
    ap.add_argument("--check", action="store_true",
                    help="uretme, config.yaml guncel mi dogrula")
    a = ap.parse_args()

    block = (build(a.margin, a.layer) if a.mode == "on"
             else build_disabled(a.margin, a.layer))
    text = CFG.read_text()

    if BEGIN in text and END in text:
        i = text.index(BEGIN)
        j = text.index(END) + len(END) + 1
        new = text[:i] + block + text[j:]
    else:
        if a.check:
            sys.exit("HATA: config.yaml icinde keep-out blogu yok.\n"
                     "Duzeltme:  make keepout")
        # Blok yoksa dosyanin sonuna ekle.
        new = text.rstrip("\n") + "\n\n" + block

    if a.check:
        if new != text:
            sys.exit("HATA: config.yaml icindeki ROUTING_OBSTRUCTIONS blogu "
                     "macro_placement.cfg ile UYUMSUZ (BAYAT).\n"
                     "Duzeltme:  make keepout")
        print(f"  ROUTING_OBSTRUCTIONS guncel ({len(read_placement())} makro, "
              f"{a.margin:g} um {a.layer})")
        return 0

    CFG.write_text(new)
    print(f"config.yaml esitlendi: {len(read_placement())} makro icin "
          f"{a.margin:g} um {a.layer} keep-out")
    return 0


if __name__ == "__main__":
    sys.exit(main())
