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
import argparse
import hashlib
import json
import pathlib
import sys

import yaml

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
    # --- ASIC'e ozgu islevsel regresyon kanitlari ---
    ("reports/general/asic_sim/collision/result.json",       "Data SRAM arbitraj testi", True),
    ("reports/general/asic_sim/instr_collision/result.json", "IMEM DMA/arbitraj testi", True),
    ("reports/general/asic_sim/mem/result.json",             "SRAM/ROM esdegerlik testi", True),
    ("reports/general/asic_sim/boot/result.json",            "Tam sistem boot testi", True),
    ("reports/general/asic_sim/yz/result.json",              "YZ hizlandirici testi", True),
    # --- SKY130 SRAM kaynak gorunumleri (iki makro tipi ayri ayri) ---
    ("macros/sky130_sram_2kbyte_1rw1r_32x512_8/gds/*.gds",     "2 KB SRAM GDS gorunumu", True),
    ("macros/sky130_sram_2kbyte_1rw1r_32x512_8/lef/*.lef",     "2 KB SRAM LEF gorunumu", True),
    ("macros/sky130_sram_2kbyte_1rw1r_32x512_8/lib/*.lib",     "2 KB SRAM Liberty modeli", True),
    ("macros/sky130_sram_2kbyte_1rw1r_32x512_8/spice/*.spice", "2 KB SRAM SPICE modeli", True),
    ("macros/sky130_sram_2kbyte_1rw1r_32x512_8/verilog/*.v",   "2 KB SRAM Verilog modeli", True),
    ("macros/sky130_sram_1kbyte_1rw1r_32x256_8/gds/*.gds",     "1 KB SRAM GDS gorunumu", True),
    ("macros/sky130_sram_1kbyte_1rw1r_32x256_8/lef/*.lef",     "1 KB SRAM LEF gorunumu", True),
    ("macros/sky130_sram_1kbyte_1rw1r_32x256_8/lib/*.lib",     "1 KB SRAM Liberty modeli", True),
    ("macros/sky130_sram_1kbyte_1rw1r_32x256_8/spice/*.spice", "1 KB SRAM SPICE modeli", True),
    ("macros/sky130_sram_1kbyte_1rw1r_32x256_8/verilog/*.v",   "1 KB SRAM Verilog modeli", True),
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
    ("reports/routing/*.drc",               "Detailed-routing DRC isaretleri", True),
    # --- Bolum 5.5 zamanlama ---
    ("reports/timing/summary.rpt",          "Butun corner'lar zamanlama ozeti", True),
    # Beyan edilen saat frekansinin OLCUME dayandigini gosteren kayit
    # (scripts/calibrate_clock.py uretir; collect.py HAND_MAINTAINED ile korur).
    ("reports/timing/frekans_kalibrasyonu.md", "Frekans kalibrasyon kaydi", True),
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
    ("reports/power/net-VPWR.csv",           "VPWR IR-drop dugumleri", True),
    ("reports/power/net-VGND.csv",           "VGND IR-drop dugumleri", True),
    # --- Bolum 6.1 zorunlu fiziksel gorunumler ---
    (f"results/gds/{DESIGN}.gds",           "Nihai GDSII", True),
    (f"results/lef/{DESIGN}.lef",           "Nihai LEF", True),
    (f"results/def/{DESIGN}.def",           "Nihai DEF", True),
    # --- Bolum 6.2 zorunlu ek ciktilar ---
    # DIKKAT: "*.nl.v" deseni "*.pnl.v"yi DE eslestirir. Dosya adlarini
    # tasarim adiyla tam eslestirmezsek powered netlist, normal post-PnR
    # netlistinin yoklugunu sessizce gizleyebilir.
    (f"results/netlist/{DESIGN}_synth.v",   "Sentez sonrasi gate level netlist", True),
    (f"results/netlist/{DESIGN}.pnl.v",     "Post-PnR powered netlist", True),
    (f"results/netlist/{DESIGN}.nl.v",      "Post-PnR netlist", True),
    ("results/sdc/*.sdc",                   "PnR / signoff SDC", True),
    ("results/spef/*/*.spef",               "Parazitik cikarim (SPEF)", True),
    ("results/spice/*",                     "GDSII'den cikarilmis SPICE netlist", True),
    ("results/config/resolved.json",        "Cozumlenmis yapilandirma", True),
    ("results/metrics/metrics.csv",         "Metrikler (CSV)", True),
    ("results/metrics/metrics.json",        "Metrikler (JSON)", True),
    # --- Bolum 6.3 onerilen ek ciktilar ---
    ("results/odb/*",                       "OpenROAD veritabani (onerilen)", False),
    ("results/sdf/**/*.sdf",                "SDF gecikme dosyasi (onerilen)", False),
    ("results/lib/**/*.lib",                "Tasarimin Liberty modeli (onerilen)", False),
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
    # Kararlarin ardindaki olcumlerin kaydi (sartname Bolum 7: bilinen sorunlar
    # ve gerekceler teslimle birlikte degerlendirilir)
    ("reports/synthesis/strateji_denemeleri.md", "Fiziksel tasarim deneme kaydi", True),
    # resolved.json secildi: arsivdeki error.log/warning.log dosyalarinin BOS
    # olmasi ANLAMLIDIR (o kosumda hata/uyari cikmadi), denetci ise bos
    # dosyayi isaretler -- gereksiz gurultu olurdu.
    ("reports/synthesis/deney_arsivi/*/resolved.json", "Deney ham kanit arsivi", False),
    ("experiments/README.md",               "Tanisal overlay aciklamalari", False),
]

SIGNOFF_METRICS = [
    ("magic__drc_error__count",                     "Magic DRC ihlali"),
    ("klayout__drc_error__count",                   "KLayout DRC ihlali"),
    ("design__lvs_error__count",                    "LVS hatasi"),
    ("antenna__violating__nets",                    "Anten ihlali (net)"),
    ("antenna__violating__pins",                    "Anten ihlali (pin)"),
    ("design__disconnected_pin__count",             "Baglantisiz pin"),
    ("design__xor_difference__count",               "GDSII XOR farki"),
    ("route__drc_errors",                           "Yollama DRC ihlali"),
    ("design__lint_error__count",                   "Lint hatasi"),
    ("synthesis__check_error__count",               "Sentez kontrol hatasi"),
    ("design__inferred_latch__count",               "Cikarilan latch"),
    # Sartname Bolum 5.6 bunlari da ayrica istiyor:
    ("design__power_grid_violation__count",          "PDN ihlali"),
    ("magic__illegal_overlap__count",                "Illegal overlap"),
    ("klayout__density_error__count",                "KLayout yogunluk ihlali"),
    ("klayout__antenna_error__count",                "KLayout anten ihlali"),
    ("design__critical_disconnected_pin__count",     "Kritik baglantisiz pin"),
    ("design__instance_unmapped__count",             "Unmapped hucre"),
    # Bolum 9.11 signoff ozeti icin zamanlama ihlal sayilari
    ("timing__setup_vio__count",                     "Setup ihlalli yol"),
    ("timing__hold_vio__count",                      "Hold ihlalli yol"),
    ("design__max_slew_violation__count",            "Max slew ihlali"),
    ("design__max_cap_violation__count",             "Max cap ihlali"),
]

# Nihai GDS'nin uretime-hazir sayilabilmesi icin yalniz raporun varligi degil,
# bu metriklerin arac tarafindan URETILMIS ve sifir olmasi gerekir. Anahtar
# eksikligi de kontrolden kacis sayilir.
REQUIRED_ZERO_METRICS = [
    "route__drc_errors",
    "magic__drc_error__count",
    "klayout__drc_error__count",
    "magic__illegal_overlap__count",
    "design__lvs_error__count",
    "antenna__violating__nets",
    "antenna__violating__pins",
    "design__disconnected_pin__count",
    "design__critical_disconnected_pin__count",
    "design__xor_difference__count",
    "design__power_grid_violation__count",
    "design__lint_error__count",
    "synthesis__check_error__count",
    "design__inferred_latch__count",
    "design__instance_unmapped__count",
    "flow__errors__count",
]

EMPTY_OK = {
    "reports/general/error.log",       # sifir hata varsa dogal olarak bostur
    "reports/general/warning.log",     # sifir uyari varsa dogal olarak bostur
    # Magic sifir DRC isaretinde gecerli, sifir-bayt rapor yazar; asil sonuc
    # magic__drc_error__count metrigiyle ayrica zorunlu olarak kontrol edilir.
    "reports/drc/drc.magic.rpt",
    "reports/pdn/VGND-grid-errors.rpt",
    "reports/pdn/VPWR-grid-errors.rpt",
    # TritonRoute sifir ihlalde gecerli fakat sifir-bayt marker dosyasi yazar;
    # asil kabul kapisi route__drc_errors metriginin varligi ve sifir olmasidir.
    "reports/routing/top_module.drc",
}

EXPECTED_MACROS = {
    "sky130_sram_2kbyte_1rw1r_32x512_8": 14,
    "sky130_sram_1kbyte_1rw1r_32x256_8": 1,
}

EXPECTED_ASIC_SIMS = {
    "collision",
    "instr_collision",
    "mem",
    "boot",
    "yz",
}

# Bu anahtarlar fiziksel sonucu dogrudan etkiler ve config.yaml ile teslim
# edilen resolved.json arasinda sessizce ayrisamaz. Yol degerleri LibreLane
# tarafindan mutlak yola cozuldugu icin burada yalniz dogrudan
# karsilastirilabilen yapilandirma degerleri tutulur.
PROVENANCE_CONFIG_KEYS = (
    "DESIGN_NAME", "PDK", "STD_CELL_LIBRARY", "CLOCK_PERIOD", "CLOCK_PORT",
    "CLOCK_NET", "DIE_AREA", "PL_TARGET_DENSITY_PCT", "FP_CORE_UTIL",
    "PRIMARY_GDSII_STREAMOUT_TOOL", "RT_MIN_LAYER", "RT_MAX_LAYER",
    "RT_CLOCK_MIN_LAYER", "RT_CLOCK_MAX_LAYER", "SIGNAL_WIRE_RC_LAYERS",
    "CLOCK_WIRE_RC_LAYERS", "GRT_ADJUSTMENT", "GRT_LAYER_ADJUSTMENTS",
    "GRT_OVERFLOW_ITERS", "MAX_FANOUT_CONSTRAINT", "DEDUPLICATE_CORNERS",
    "RUN_POST_GPL_DESIGN_REPAIR", "RUN_POST_GRT_DESIGN_REPAIR",
    "RUN_POST_CTS_RESIZER_TIMING", "RUN_POST_GRT_RESIZER_TIMING",
    "RUN_ANTENNA_REPAIR", "DIODE_ON_PORTS", "DRT_ANTENNA_REPAIR_ITERS",
    "CTS_DELAY_BUFFER_DERATE_PCT", "CTS_BALANCE_LEVELS",
    "CTS_MACRO_CLUSTERING_SIZE", "CTS_MACRO_CLUSTERING_MAX_DIAMETER",
)


def sha256(path):
    h = hashlib.sha256()
    with path.open("rb") as f:
        for block in iter(lambda: f.read(1 << 20), b""):
            h.update(block)
    return h.hexdigest()


def verify_checksum_manifest():
    """Sunulan SHA256SUMS dosyasinin kendisini gercekten dogrula."""
    manifest = ASIC / "checksums" / "SHA256SUMS"
    errors = []
    if not manifest.is_file():
        return errors  # Bolum 6.3 onerilen cikti; yoklugu CHECKS'te raporlanir.
    seen = set()
    for lineno, line in enumerate(manifest.read_text().splitlines(), 1):
        if not line.strip():
            continue
        try:
            digest, rel = line.split("  ", 1)
        except ValueError:
            errors.append(f"SHA256SUMS:{lineno}: bicim hatasi")
            continue
        relpath = pathlib.PurePosixPath(rel)
        if relpath.is_absolute() or ".." in relpath.parts:
            errors.append(f"SHA256SUMS:{lineno}: guvensiz yol: {rel}")
            continue
        if rel in seen:
            errors.append(f"SHA256SUMS:{lineno}: yinelenen yol: {rel}")
            continue
        seen.add(rel)
        path = ASIC / relpath
        if not path.is_file():
            errors.append(f"checksum dosyasi yok: {rel}")
        elif len(digest) != 64 or sha256(path) != digest.lower():
            errors.append(f"checksum uyusmazligi: {rel}")
    if not seen:
        errors.append("SHA256SUMS bos")
    return errors


def verify_provenance(delivery):
    """Girdi/cikti tutarliligini ve temiz-kosum kanitini denetle."""
    errors = []
    config_path = ASIC / "config.yaml"
    resolved_path = ASIC / "results/config/resolved.json"
    # `make asic_run` UC FAZLI kosar (bkz. Makefile "ZORUNLU HEDEF" basligi ve
    # README Bolum 0.1 "Uc fazli akis"). Teslim edilen resolved.json faz 3'e
    # aittir, yani beklenen deger config.yaml DEGIL, config.yaml + iki resmi
    # overlay'dir. Overlay'leri burada bilerek yukluyoruz: boylece onlarin
    # BILEREK degistirdigi anahtarlar dogru referansa karsi denetlenir ve
    # geri kalan her anahtar eskisi gibi ZORLANMAYA DEVAM EDER (kapi
    # zayiflamaz, yalnizca dogru beklentiye hizalanir).
    overlay_paths = (
        ASIC / "experiments/grt_layer_met3_009.yaml",
        ASIC / "experiments/antenna_jumper.yaml",
    )
    try:
        config = yaml.safe_load(config_path.read_text())
        resolved = json.loads(resolved_path.read_text())
    except (OSError, yaml.YAMLError, json.JSONDecodeError) as exc:
        errors.append(f"config/resolved okunamadi: {exc}")
    else:
        expected = dict(config)
        overlay = {}
        for overlay_path in overlay_paths:
            try:
                part = yaml.safe_load(overlay_path.read_text()) or {}
            except (OSError, yaml.YAMLError) as exc:
                errors.append(f"resmi overlay okunamadi: {overlay_path.name}: {exc}")
                continue
            part.pop("meta", None)
            overlay.update(part)
            expected.update(part)
        for key in PROVENANCE_CONFIG_KEYS:
            if key in expected and expected[key] != resolved.get(key):
                src = "config+resmi-overlay" if key in overlay else "config"
                errors.append(
                    f"{src}/resolved uyusmazligi: {key}: "
                    f"beklenen={expected[key]!r}, resolved={resolved.get(key)!r}")
        # Overlay'ler YALNIZCA faz 2/3'e uygulanir; faz 1 config.yaml'i tek
        # basina kullanir. Bu yuzden overlay'lerin ezdigi anahtarlar icin config.yaml'in
        # KENDI degeri de denetlenmelidir -- aksi halde faz 1 davranisini
        # degistiren bir duzenleme provenance kapisindan gorunmez gecerdi.
        # Beklenen faz 1 degerleri OLCUMLE belirlenmistir:
        #   RUN_ANTENNA_REPAIR: false        -> diyot onarimi DRT'yi
        #       yakinsamaz yapiyor (README Bolum 0.1, kontrollu karsilastirma)
        #   RUN_POST_GRT_RESIZER_TIMING: true -> kapatmak 16.363 hold gecikme
        #       hucresini kaldirip hold'u negatife dusuruyor
        PHASE1_REQUIRED = {
            "RUN_ANTENNA_REPAIR": False,
            "RUN_POST_GRT_RESIZER_TIMING": True,
            "GRT_LAYER_ADJUSTMENTS": [0, 0.3, 0.25, 0, 0, 0],
        }
        for key, want in PHASE1_REQUIRED.items():
            if key in overlay and config.get(key) != want:
                errors.append(
                    f"faz 1 ayari degismis: config.yaml {key}="
                    f"{config.get(key)!r}, beklenen {want!r} "
                    f"(resmi overlay bunu sonraki fazda {overlay[key]!r} yapar)")

        # Faz 3'un GERCEKTEN kostugunu kanitla: jumper'siz bir
        # kosum teslim edilen anten sayilarini uretmez.
        for key, want in (("RUN_ANTENNA_REPAIR", True),
                          ("GRT_ANTENNA_REPAIR_JUMPER_ONLY", True)):
            if resolved.get(key) != want:
                errors.append(
                    f"faz 3 (anten jumper) kanit bulunamadi: "
                    f"{key}={resolved.get(key)!r}, beklenen {want!r}")

    # Iki teslim konumundaki kopyalar byte-duzeyinde ayni kosuma ait olmali.
    for left, right in (
        ("reports/general/resolved.json", "results/config/resolved.json"),
        ("reports/general/metrics.json", "results/metrics/metrics.json"),
        ("reports/general/metrics.csv", "results/metrics/metrics.csv"),
    ):
        a, b = ASIC / left, ASIC / right
        if a.is_file() and b.is_file() and a.read_bytes() != b.read_bytes():
            errors.append(f"teslim kopyalari farkli: {left} != {right}")

    # `make asic_run` UC FAZLI oldugu icin temiz bir kosumun flow.log'u TAM
    # UC baslangic tasir (erken PnR, met3-optimizasyon, anten-jumper/signoff).
    # Ucten farkli bir sayi, elle continuation veya
    # fallback ile birlestirilmis bir kosum demektir ve `make asic_run`
    # yeniden-uretilebilirligini bozar.
    EXPECTED_STARTS = 3
    flow_log = ASIC / "reports/general/flow.log"
    if flow_log.is_file():
        text = flow_log.read_text(errors="replace")
        starts = sum(line == "Starting…" for line in text.splitlines())
        if starts != EXPECTED_STARTS:
            errors.append(
                f"flow.log uc fazli temiz kosum degil: Starting sayisi={starts}, "
                f"beklenen {EXPECTED_STARTS}")
        if "Traceback (most recent call last):" in text:
            errors.append("flow.log Python traceback iceriyor")
        if "multiple top cells" in text:
            errors.append("flow.log KLayout multiple-top-cell hatasi iceriyor")

    if delivery:
        run_dir = ASIC / "run"
        if run_dir.is_symlink():
            errors.append(f"teslimde run/ symlink olamaz: {run_dir.resolve()}")
        elif not run_dir.is_dir():
            errors.append("teslimde run/ gercek bir dizin olmali")
        else:
            extras = sorted(p.name for p in run_dir.iterdir() if p.name != ".gitkeep")
            if extras:
                errors.append(f"teslimde run/ bos degil: {extras[:8]}")
    return errors


def find_macro_counts(value):
    """Yosys stat.json icinde makro sayaclarini tasiyan sozlugu bulur."""
    if isinstance(value, dict):
        if all(name in value for name in EXPECTED_MACROS):
            return {name: value[name] for name in EXPECTED_MACROS}
        for child in value.values():
            found = find_macro_counts(child)
            if found is not None:
                return found
    elif isinstance(value, list):
        for child in value:
            found = find_macro_counts(child)
            if found is not None:
                return found
    return None


def main():
    ap = argparse.ArgumentParser(description="TEKNOFEST ASIC teslim paketi denetimi")
    ap.add_argument("--strict", action="store_true",
                    help="signoff ihlallerini de cikis koduna dahil et")
    ap.add_argument("--delivery", action="store_true",
                    help="teslim durumu: run/ gercek ve bos dizin olmali")
    args = ap.parse_args()
    strict = args.strict
    ok, miss_req, miss_opt, empty = 0, [], [], []
    for pat, desc, req in CHECKS:
        hits = [p for p in ASIC.glob(pat) if p.is_file()]
        if not hits:
            (miss_req if req else miss_opt).append(f"{pat:42s} {desc}")
        else:
            ok += 1
            for h in hits:
                rel = str(h.relative_to(ASIC))
                # Corner bazli unpropagated.rpt'nin bos olmasi, o corner'da
                # propagate edilmemis saat bulunmadigi anlamina gelen temiz
                # OpenSTA sonucudur; dokuz dosyanin varligi kapsam kapisinda
                # zaten ayrica denetlenir.
                empty_unpropagated = (
                    rel.startswith("reports/timing/")
                    and rel.endswith("/unpropagated.rpt")
                )
                if (h.stat().st_size == 0 and rel not in EMPTY_OK
                        and not empty_unpropagated):
                    empty.append(f"{h.relative_to(ASIC)}  ({desc})")

    # Herhangi bir corner'in varligi yeterli degildir: final dokumani uc PVT x
    # uc RC olmak uzere dokuz ayri STA/guc rapor agaci ister. Beklenen adlari
    # elle ikinci kez yazmak yerine akisin teslim edilen resolved config'inden
    # okuruz; boylece rapor ve yapilandirma birbirinden sessizce ayrisamaz.
    timing_corners = sorted({p.parent.name for p in ASIC.glob("reports/timing/*/max.rpt")})
    power_corners = sorted({p.parent.name for p in ASIC.glob("reports/power/*/power.rpt")})
    coverage_errors = []
    resolved_path = ASIC / "results/config/resolved.json"
    expected_corners = []
    if resolved_path.is_file():
        try:
            expected_corners = sorted(json.loads(resolved_path.read_text())["STA_CORNERS"])
        except (OSError, json.JSONDecodeError, KeyError, TypeError) as exc:
            coverage_errors.append(f"STA_CORNERS okunamadi: {exc}")
    if len(expected_corners) != 9:
        coverage_errors.append(
            f"Resolved config STA corner kapsami {len(expected_corners)}/9")
    if expected_corners and timing_corners != expected_corners:
        coverage_errors.append(
            "STA corner adlari config ile ayni degil: "
            f"bulunan={timing_corners}, beklenen={expected_corners}")
    if expected_corners and power_corners != expected_corners:
        coverage_errors.append(
            "Guc corner adlari config ile ayni degil: "
            f"bulunan={power_corners}, beklenen={expected_corners}")

    # Collector her STA corner dizinini butunuyle kopyalar. Yalniz max.rpt'nin
    # bulunmasi, hold/kisit/skew raporlarinin kayip oldugu bir teslimi gizlememeli.
    corner_reports = (
        "max.rpt", "min.rpt", "checks.rpt", "skew.max.rpt", "skew.min.rpt",
        "ws.max.rpt", "ws.min.rpt", "wns.max.rpt", "wns.min.rpt",
        "tns.max.rpt", "tns.min.rpt", "violator_list.rpt", "clock.rpt",
        "unpropagated.rpt", "power.rpt",
    )
    for corner in expected_corners:
        for name in corner_reports:
            p = ASIC / "reports/timing" / corner / name
            if not p.is_file():
                coverage_errors.append(f"STA raporu eksik: {corner}/{name}")

    spefs = sorted((ASIC / "results/spef").rglob("*.spef"))
    expected_spefs = {
        f"nom/{DESIGN}.nom.spef", f"min/{DESIGN}.min.spef",
        f"max/{DESIGN}.max.spef",
    }
    found_spefs = {str(p.relative_to(ASIC / "results/spef")) for p in spefs}
    if found_spefs != expected_spefs:
        coverage_errors.append(
            f"SPEF RC corner kapsami hatali: bulunan={sorted(found_spefs)}, "
            f"beklenen={sorted(expected_spefs)}")

    # Sadece makro dosyalarinin bulunmasi yeterli degildir: sentez netlisti
    # gercekten beklenen fiziksel makrolari icermeli. Aksi halde SRAM'in
    # flip-floplara acilmasi ya da bir bankanin kaybolmasi teslimde fark edilmez.
    stat_json = ASIC / "reports" / "synthesis" / "stat.json"
    if stat_json.is_file():
        try:
            macro_counts = find_macro_counts(json.loads(stat_json.read_text()))
        except (OSError, json.JSONDecodeError) as exc:
            coverage_errors.append(f"Sentez stat.json okunamadi: {exc}")
        else:
            if macro_counts is None:
                coverage_errors.append("Sentez stat.json icinde SRAM makro sayaclari yok")
            else:
                for name, expected in EXPECTED_MACROS.items():
                    actual = macro_counts[name]
                    if actual != expected:
                        coverage_errors.append(
                            f"SRAM makro sayisi {name}: {actual} (beklenen {expected})")

    sim_results = {
        p.parent.name: p
        for p in ASIC.glob("reports/general/asic_sim/*/result.json")
        if p.is_file()
    }
    missing_sims = sorted(EXPECTED_ASIC_SIMS - sim_results.keys())
    for name in missing_sims:
        coverage_errors.append(f"ASIC simulasyon sonucu eksik: {name}/result.json")

    for name in sorted(EXPECTED_ASIC_SIMS & sim_results.keys()):
        sim_result = sim_results[name]
        try:
            result = json.loads(sim_result.read_text())
        except (OSError, json.JSONDecodeError) as exc:
            coverage_errors.append(f"Simulasyon sonucu okunamadi {sim_result.name}: {exc}")
            continue
        if result.get("passed") is not True:
            coverage_errors.append(
                f"ASIC simulasyonu basarisiz: {sim_result.parent.name}")

    integrity_errors = verify_checksum_manifest()
    integrity_errors.extend(verify_provenance(args.delivery))

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
    if coverage_errors:
        print(f"\n  KAPSAM HATASI: {len(coverage_errors)}")
        for e in coverage_errors:
            print(f"     ! {e}")
    if integrity_errors:
        print(f"\n  TUTARLILIK/PROVENANCE HATASI: {len(integrity_errors)}")
        for e in integrity_errors:
            print(f"     ! {e}")
    if miss_req:
        print(f"\n  EKSIK (ZORUNLU): {len(miss_req)}")
        for m in miss_req:
            print(f"     ! {m}")

    # --- signoff metrik ozeti ---
    mj = ASIC / "results" / "metrics" / "metrics.json"
    signoff_errors = []
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
        for key in REQUIRED_ZERO_METRICS:
            if key not in met:
                signoff_errors.append(f"eksik signoff metrigi: {key}")
            elif not isinstance(met[key], (int, float)) or met[key] != 0:
                signoff_errors.append(f"{key} = {met[key]} (0 olmali)")

        # Corner-suffixed metrikler dahil tum STA ve tasarim-kurali sayaclari.
        for k, v in sorted(met.items()):
            is_timing_slack = any(x in k for x in (
                "timing__setup__wns", "timing__setup__tns", "timing__setup__ws",
                "timing__hold__wns", "timing__hold__tns", "timing__hold__ws",
            ))
            if is_timing_slack and (not isinstance(v, (int, float)) or v < 0):
                signoff_errors.append(f"{k} = {v} (>= 0 olmali)")

            must_be_zero = (
                (k.startswith("timing__") and "_vio__count" in k)
                or "design__max_slew_violation__count" in k
                or "design__max_cap_violation__count" in k
                or "design__max_fanout_violation__count" in k
            )
            if must_be_zero and (not isinstance(v, (int, float)) or v != 0):
                signoff_errors.append(f"{k} = {v} (0 olmali)")

        for family in ("timing__setup__wns__corner:", "timing__hold__wns__corner:"):
            if not any(k.startswith(family) for k in met):
                signoff_errors.append(f"corner-bazli metrik ailesi eksik: {family}")
        for k in sorted(met):
            if "timing__setup__ws" in k or "timing__hold__ws" in k or "tns" in k.lower():
                print(f"  {k:34s}: {met[k]}")
    else:
        print("\n  NOT: results/metrics/metrics.json yok, signoff ozeti atlandi.")
        signoff_errors.append(
            "results/metrics/metrics.json yok; signoff sonuclari degerlendirilemedi")

    # ---------------------------------------------------------------------
    #  IKI AYRI KAPI
    #
    #  1) PAKET KAPISI (cikis kodunu belirler): teslim EKSIKSIZ mi?
    #     Sartname Bolum 7: "Ihlal, hata veya uyari bulunmasi teslimin
    #     otomatik olarak gecersiz sayilmasi anlamina gelmez." Bolum 8 ise
    #     `make asic_run`'in zorunlu rapor ve ciktilari TOPLAMASINI istiyor.
    #     Dolayisiyla eksik/bos dosya ve kapsam hatasi HATADIR; kalan DRC veya
    #     anten ihlali ise teslimi gecersiz KILMAZ.
    #
    #  2) SIGNOFF KAPISI (yalnizca raporlar): sonuclar temiz mi?
    #     Muhendislik hedefi budur ama teslim edilebilirligin sarti degildir.
    #     `--strict` ile cikis koduna dahil edilebilir.
    #
    #  Onceki surumde ikisi birlestirilmisti; eksiksiz ama birkac ihlalli bir
    #  paket yanlislikla "basarisiz" sayiliyordu ve `make asic_run` her seyi
    #  topladiktan SONRA sifirdan farkli kodla biterek "akis mi basarisiz,
    #  signoff mu kirli" ayrimini kaybettiriyordu.
    # ---------------------------------------------------------------------
    package_ok = not (miss_req or empty or coverage_errors or integrity_errors)

    if signoff_errors:
        print(f"\n  SIGNOFF SONUCLARI TEMIZ DEGIL: {len(signoff_errors)} kalem")
        for e in signoff_errors:
            print(f"     ! {e}")
        print("     (Bunlar teslimi GECERSIZ KILMAZ -- sartname Bolum 7. Gercek")
        print("      sayilar README'nin 'Signoff sonuc ozeti' bolumundedir.)")
    else:
        print("\n  SIGNOFF SONUCLARI TEMIZ.")

    print()
    if package_ok:
        print("  PAKET KAPISI: GECTI  (butun zorunlu rapor ve ciktilar mevcut)")
    else:
        print("  PAKET KAPISI: BASARISIZ  (eksik/bos zorunlu kalem veya kapsam hatasi)")

    print("=" * 74)
    if strict:
        return 0 if (package_ok and not signoff_errors) else 1
    return 0 if package_ok else 1


if __name__ == "__main__":
    sys.exit(main())
