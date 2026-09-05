#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  compare_metrics.py -- iki LibreLane kosumunun signoff metriklerini karsilastirir
#
#  NEDEN GEREKLI?
#    Optimizasyon fazinda her deney, calisan bir teslim paketini riske atar.
#    "Anten dustu" demek yeterli degil: ayni degisiklik DRC'yi bozmus olabilir.
#    Bu betik KABUL KAPISINI mekanik hale getirir -- goz karari yapilmaz.
#
#  KAPI KURALI
#    Bir aday ancak KIRMIZI listedeki metriklerin HEPSINDE referansa esit veya
#    daha iyiyse benimsenir. Bu metrikler zaten sifirdir; herhangi birinin
#    sifirdan farkli olmasi dogrudan RED sebebidir.
#    SARI listedekiler iyilesmesi HEDEFLENEN metriklerdir; kotulesmeleri
#    uyari uretir ama tek basina red sebebi degildir (takas olabilir).
#
#  KULLANIM
#    python3 scripts/compare_metrics.py <referans.json> <aday.json>
#    python3 scripts/compare_metrics.py --save <cikti.json> <metrics.json>
# ---------------------------------------------------------------------------
import argparse
import json
import pathlib
import sys

# Sifir olmasi ZORUNLU olan signoff metrikleri. Herhangi biri > referans -> RED.
HARD = [
    "route__drc_errors",
    "magic__drc_error__count",
    "klayout__drc_error__count",
    "design__xor_difference__count",
    "magic__illegal_overlap__count",
    "design__lvs_error__count",
    "design__lvs_device_difference__count",
    "design__lvs_net_difference__count",
    "design__lvs_unmatched_pin__count",
    "design__power_grid_violation__count",
    "design__critical_disconnected_pin__count",
    "design__instance_unmapped__count",
    "design__lint_error__count",
    "design__inferred_latch__count",
    "design__lint_timing_construct__count",
    "design__max_fanout_violation__count",
]

# Dusmesi HEDEFLENEN metrikler (kucuk = iyi).
SOFT_LOWER = [
    "antenna__violating__nets",
    "antenna__violating__pins",
    "design__max_slew_violation__count",
    "design__max_cap_violation__count",
    "design__lint_warning__count",
    "design__die__area",
    "design__instance__count",
    "design__instance__count__class:fill_cell",
    "design__instance__count__class:timing_repair_buffer",
    "route__wirelength",
    "route__wirelength__max",
    "power__total",
]

# Yukselmesi HEDEFLENEN metrikler (buyuk = iyi).
SOFT_HIGHER = [
    "timing__setup__ws",
    "timing__hold__ws",
    "design__instance__utilization__stdcell",
]

# Yalnizca bilgi amacli basilanlar.
INFO = [
    "design__core__area",
    "design__instance__utilization",
    "design__instance__area__stdcell",
    "route__vias",
    "design__disconnected_pin__count",
    "timing__setup__tns",
    "timing__hold__tns",
]

ALL = HARD + SOFT_LOWER + SOFT_HIGHER + INFO


def load(path: pathlib.Path):
    m = json.loads(path.read_text())
    # Hem tam metrics.json hem de bu betigin urettigi ozet kabul edilir.
    return {k: m.get(k) for k in ALL}


def fmt(v):
    if v is None:
        return "yok"
    if isinstance(v, float):
        return f"{v:.6g}"
    return str(v)


def delta(ref, cand):
    if ref is None or cand is None:
        return ""
    d = cand - ref
    if d == 0:
        return "="
    return f"{d:+.6g}"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("files", nargs="+", type=pathlib.Path)
    ap.add_argument("--save", type=pathlib.Path,
                    help="tek metrics.json'dan ozet uret ve buraya yaz")
    a = ap.parse_args()

    if a.save:
        if len(a.files) != 1:
            sys.exit("HATA: --save tek bir metrics.json ister")
        a.save.parent.mkdir(parents=True, exist_ok=True)
        a.save.write_text(json.dumps(load(a.files[0]), indent=2) + "\n")
        print(f"ozet yazildi: {a.save}")
        return 0

    if len(a.files) != 2:
        sys.exit("HATA: <referans.json> <aday.json> bekleniyor")
    ref, cand = load(a.files[0]), load(a.files[1])

    fails, warns = [], []
    for title, keys in (("ZORUNLU (sifir kalmali)", HARD),
                        ("HEDEF: dusmeli", SOFT_LOWER),
                        ("HEDEF: yukselmeli", SOFT_HIGHER),
                        ("BILGI", INFO)):
        print(f"\n=== {title}")
        print(f"{'metrik':<52}{'referans':>16}{'aday':>16}{'fark':>14}")
        for k in keys:
            r, c = ref.get(k), cand.get(k)
            mark = ""
            if r is not None and c is not None:
                if keys is HARD and c > r:
                    mark, _ = " <-- RED", fails.append(k)
                elif keys is SOFT_LOWER and c > r:
                    mark, _ = " <-- kotulesti", warns.append(k)
                elif keys is SOFT_HIGHER and c < r:
                    mark, _ = " <-- kotulesti", warns.append(k)
            print(f"{k:<52}{fmt(r):>16}{fmt(c):>16}{delta(r,c):>14}{mark}")

    print()
    if fails:
        print(f"SONUC: RED -- zorunlu metrikler kotulesti: {', '.join(fails)}")
        return 1
    if warns:
        print(f"SONUC: KABUL EDILEBILIR -- zorunlu metrikler korundu, "
              f"su hedefler kotulesti: {', '.join(warns)}")
        return 0
    print("SONUC: KABUL -- zorunlu metrikler korundu, hedeflerde gerileme yok")
    return 0


if __name__ == "__main__":
    sys.exit(main())
