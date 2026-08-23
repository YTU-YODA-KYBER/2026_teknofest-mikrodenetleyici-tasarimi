#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  verify_deliverables.py -- `make asic_verify`
#
#  Sartnamenin Bolum 5 (zorunlu raporlar) ve Bolum 6 (zorunlu ciktilar)
#  listelerini teslim agacinda tek tek arar, temel signoff sonuclarini
#  metrics.json'dan okuyup ozetler.
#
#  Amac: teslimden once eksik/bos dosyayi ve gizlenmis ihlali yakalamak.
#  Eksik ZORUNLU kalem varsa sifirdan farkli kodla biter.
# ---------------------------------------------------------------------------
import json
import pathlib
import sys

ASIC = pathlib.Path(__file__).resolve().parent.parent
DESIGN = "top_module"

# (yol_deseni, aciklama, zorunlu_mu)
CHECKS = [
    # --- Bolum 5.1 genel akis ---
    ("reports/general/flow.log",            "Ana LibreLane calisma gunlugu", True),
    ("reports/general/warning.log",         "Akis uyarilari", True),
    ("reports/general/error.log",           "Akis hatalari", True),
    ("reports/general/resolved.json",       "Cozumlenmis yapilandirma", True),
    ("reports/general/metrics.csv",         "Akis metrikleri (CSV)", True),
    ("reports/general/metrics.json",        "Akis metrikleri (JSON)", True),
    ("environment/versions.txt",            "Arac/PDK surum bilgileri", True),
    ("environment/flake.nix",               "Nix ortam tanimi", True),
    ("environment/flake.lock",              "Nix kilit dosyasi", True),
    # --- Bolum 5.2 lint ---
    ("reports/lint/verilator_lint.log",     "Verilator lint ciktisi", True),
    # --- Bolum 5.3 sentez ---
    ("reports/synthesis/stat.rpt",          "Sentez istatistikleri", True),
    ("reports/synthesis/stat.json",         "Sentez istatistikleri (JSON)", True),
    ("reports/synthesis/latch.rpt",         "Cikarilan latch raporu", True),
    ("reports/synthesis/pre_synth_chk.rpt", "Sentez oncesi yapisal kontrol", True),
    ("reports/synthesis/chk.rpt",           "Sentez sonrasi yapisal kontrol", True),
    # --- Bolum 5.4 fiziksel ---
    ("reports/routing/*wire_lengths*",      "Uzun kablo raporu", True),
    # --- Bolum 5.5 zamanlama ---
    ("reports/timing/summary.rpt",          "Butun corner'lar zamanlama ozeti", True),
    ("reports/timing/*/max.rpt",            "Setup yollari (corner bazli)", True),
    ("reports/timing/*/min.rpt",            "Hold yollari (corner bazli)", True),
    ("reports/timing/*/checks.rpt",         "Kisitlanmamis yol / slew / cap / fanout", True),
    ("reports/timing/*/violator_list.rpt",  "Ihlal listesi", True),
    ("reports/timing/*/clock.rpt",          "Saat bilgileri", True),
    ("reports/timing/*/unpropagated.rpt",   "Propagate edilmemis saatler", True),
    # --- Bolum 5.6 fiziksel signoff ---
    ("reports/drc/*magic*",                 "Magic DRC sonuclari", True),
    ("reports/drc/*klayout*",               "KLayout DRC sonuclari", True),
    ("reports/lvs/*netgen*",                "Netgen LVS sonuclari", True),
    ("reports/antenna/*",                   "Anten kontrolu sonuclari", True),
    ("reports/signoff/*disconnected*",      "Baglantisiz pin tablosu", True),
    ("reports/pdn/*grid-errors*",           "PDN grid hatalari", True),
    ("reports/signoff/*.xml",               "Magic/KLayout GDSII XOR farki", True),
    ("reports/signoff/*manufacturability*", "Uretilebilirlik ozeti", True),
    # --- Bolum 5.7 guc / IR-drop ---
    ("reports/power/*/power.rpt",           "Corner bazli guc raporu", True),
    ("reports/power/irdrop.rpt",            "IR-drop raporu", True),
    # --- Bolum 6.1 zorunlu fiziksel gorunumler ---
    (f"results/gds/{DESIGN}.gds",           "Nihai GDSII", True),
    (f"results/lef/{DESIGN}.lef",           "Nihai LEF", True),
    (f"results/def/{DESIGN}.def",           "Nihai DEF", True),
    # --- Bolum 6.2 zorunlu ek ciktilar ---
    ("results/netlist/*nl.v",               "Sentez sonrasi gate level netlist", True),
    ("results/netlist/*pnl.v",              "Post-PnR netlist", True),
    ("results/sdc/*.sdc",                   "PnR / signoff SDC", True),
    ("results/spef/*",                      "Parazitik cikarim (SPEF)", True),
    ("results/spice/*",                     "GDSII'den cikarilmis SPICE netlist", True),
    ("results/config/resolved.json",        "Cozumlenmis yapilandirma", True),
    ("results/metrics/metrics.csv",         "Metrikler (CSV)", True),
    ("results/metrics/metrics.json",        "Metrikler (JSON)", True),
    # --- Bolum 6.3 onerilen ek ciktilar ---
    ("results/odb/*",                       "OpenROAD veritabani (onerilen)", False),
    ("results/sdf/*",                       "SDF gecikme dosyasi (onerilen)", False),
    ("results/lib/*",                       "Tasarimin Liberty modeli (onerilen)", False),
    ("results/mag/*",                       "Magic layout (onerilen)", False),
    ("results/images/*",                    "Yerlesim goruntusu (onerilen)", False),
    ("checksums/SHA256SUMS",                "SHA-256 ozetleri (onerilen)", False),
    # --- dokumantasyon ---
    ("README.md",                           "Ana aciklama belgesi", True),
    ("THIRD_PARTY.md",                      "Ucuncu taraf bilesenler", True),
    ("config.yaml",                         "LibreLane yapilandirmasi", True),
    ("filelist.f",                          "RTL kaynak listesi", True),
    ("Makefile",                            "Otomasyon (asic_run)", True),
    ("constraints/design.sdc",              "Zamanlama kisitlari", True),
]

SIGNOFF_METRICS = [
    ("magic__drc_error__count",                     "Magic DRC ihlali"),
    ("klayout__drc_error__count",                   "KLayout DRC ihlali"),
    ("design__lvs_error__count",                    "LVS hatasi"),
    ("route__antenna_violation__count",             "Anten ihlali"),
    ("design__disconnected_pin__count",             "Baglantisiz pin"),
    ("design__xor_difference__count",               "GDSII XOR farki"),
    ("route__drc_errors",                           "Yollama DRC ihlali"),
    ("design__lint_error__count",                   "Lint hatasi"),
    ("synthesis__check_error__count",               "Sentez kontrol hatasi"),
    ("design__inferred_latch__count",               "Cikarilan latch"),
]


def main():
    ok, miss_req, miss_opt, empty = 0, [], [], []
    for pat, desc, req in CHECKS:
        hits = [p for p in ASIC.glob(pat) if p.is_file()]
        if not hits:
            (miss_req if req else miss_opt).append(f"{pat:42s} {desc}")
        else:
            ok += 1
            for h in hits:
                if h.stat().st_size == 0:
                    empty.append(f"{h.relative_to(ASIC)}  ({desc})")

    print("=" * 74)
    print("  TESLIM PAKETI DENETIMI  (make asic_verify)")
    print("=" * 74)
    print(f"  Bulunan kalem            : {ok}/{len(CHECKS)}")
    if miss_opt:
        print(f"\n  Eksik (onerilen, zorunlu degil): {len(miss_opt)}")
        for m in miss_opt:
            print(f"     - {m}")
    if empty:
        print(f"\n  BOS DOSYA: {len(empty)}")
        for e in empty:
            print(f"     ! {e}")
    if miss_req:
        print(f"\n  EKSIK (ZORUNLU): {len(miss_req)}")
        for m in miss_req:
            print(f"     ! {m}")

    # --- signoff metrik ozeti ---
    mj = ASIC / "results" / "metrics" / "metrics.json"
    if mj.is_file():
        met = json.load(open(mj))
        print("\n" + "-" * 74)
        print("  SIGNOFF SONUC OZETI (results/metrics/metrics.json)")
        print("-" * 74)
        for key, label in SIGNOFF_METRICS:
            if key in met:
                v = met[key]
                flag = "" if (isinstance(v, (int, float)) and v == 0) else "   <-- SIFIR DEGIL"
                print(f"  {label:34s}: {v}{flag}")
        for k in sorted(met):
            if "timing__setup__ws" in k or "timing__hold__ws" in k or "tns" in k.lower():
                print(f"  {k:34s}: {met[k]}")
    else:
        print("\n  NOT: results/metrics/metrics.json yok, signoff ozeti atlandi.")

    print("=" * 74)
    return 1 if miss_req else 0


if __name__ == "__main__":
    sys.exit(main())
