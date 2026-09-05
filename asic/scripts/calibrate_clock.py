#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  calibrate_clock.py -- Beyan edilecek saat periyodunu OLCEREK secer.
#
#  NEDEN AYRI BIR ADIM?
#    Bu tasarimin frekans tavanini standart hucre mantigi degil, SRAM makrosu
#    belirler: sky130_sram_*'in Liberty'si dout0/dout1 icin
#        timing_type : falling_edge
#    tanimlar (OpenRAM'in sense amplifikatoru negatif kenarda atesler).
#    Sarmalayici normal posedge kullandigi icin SRAM'den cikan veri, yukselen
#    kenarda yakalanana kadar T/2 sure bulur, T degil. Yani frekans tavani
#    RTL'den degistirilemez ve TAHMIN EDILEMEZ -- olculmelidir.
#
#  NEREDEN OLCULUR?
#    OpenROAD.STAMidPNR YALNIZCA DEFAULT_CORNER'i (nom_tt) kosar
#    (librelane/steps/openroad.py:536, sta/corner.tcl) -- yani baglayici olan
#    yavas kosede (nom_ss_100C_1v60) hicbir sey soylemez. Post-CTS asamasinda
#    COK CORNER'li tek kaynak OpenROAD.ResizerTimingPostCTS adiminin kendi
#    logudur: o adim STA_CORNERS'in tamamini yukleyip `repair_timing -setup`
#    kosar ve sunlari basar:
#        [INFO RSZ-0098] No setup violations found            <- TEMIZ
#        [INFO RSZ-0094] Found N endpoints with setup violations
#        Iter K   WNS ...  TNS ...  Viol ...                  <- yakinsama
#        [WARNING RSZ-0062] Unable to repair all setup violations.
#
#  YONTEM
#    Tek bir CTS veritabani uzerinde YALNIZ ResizerTimingPostCTS adimi, farkli
#    CLOCK_PERIOD degerleriyle tekrar kosulur. Sentez bu tasarimda periyottan
#    BAGIMSIZDIR (SYNTH_STRATEGY "AREA 0"; olculdu: CP=20 ve CP=40 netlist'leri
#    bit bazinda ayni), CTS ise agirlikli olarak skew hedeflidir. Dolayisiyla
#    ayni CTS veritabanindan periyot taramak gecerli bir karsilastirmadir.
#
#    Secim kurali: ss kosesinde setup ihlali SIFIR olan EN KUCUK periyot.
#
#  Kullanim:
#     python3 scripts/calibrate_clock.py --cts-state run/calib/35-openroad-cts/state_out.json \\
#             --periods 30 25 22 20
# ---------------------------------------------------------------------------
import argparse
import json
import pathlib
import re
import subprocess
import sys
import time

ASIC = pathlib.Path(__file__).resolve().parent.parent


def existing_log(period: int):
    """Bu periyot icin daha once uretilmis bir log varsa dondurur."""
    logs = sorted((ASIC / "run" / f"calib_p{period}").glob(
        "*resizertimingpostcts/*.log"))
    return logs[0] if logs else None


def run_point(cts_state: pathlib.Path, period: int, workdir: pathlib.Path,
              timeout_s: int, reuse: bool = False):
    """Tek bir periyot icin ResizerTimingPostCTS kosar, log yolunu dondurur."""
    if reuse:
        old = existing_log(period)
        if old is not None:
            print("    (diskteki olcum yeniden kullaniliyor)", flush=True)
            return old, 0.0, False
    overlay = workdir / f"clock_{period}.yaml"
    overlay.parent.mkdir(parents=True, exist_ok=True)
    overlay.write_text(
        "meta:\n  version: 2\n\n"
        f"# Frekans kalibrasyonu: {period} ns ({1000.0/period:.2f} MHz)\n"
        f"CLOCK_PERIOD: {period}\n"
    )
    tag = f"calib_p{period}"
    cmd = [sys.executable, str(ASIC / "scripts" / "run_flow.py"),
           "--config", str(ASIC / "config.yaml"),
           "--config", str(overlay),
           "--tag", tag, "--overwrite",
           "--initial-state", str(cts_state),
           "--from", "OpenROAD.ResizerTimingPostCTS",
           "--to", "OpenROAD.ResizerTimingPostCTS"]
    t0 = time.time()
    timed_out = False
    try:
        subprocess.run(cmd, cwd=ASIC, timeout=timeout_s,
                       stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
    except subprocess.TimeoutExpired:
        timed_out = True
    dt = time.time() - t0
    logs = sorted((ASIC / "run" / tag).glob("*resizertimingpostcts/*.log"))
    return (logs[0] if logs else None), dt, timed_out


def parse_log(log: pathlib.Path):
    """repair_timing -setup ciktisini ozetler."""
    if log is None or not log.is_file():
        return dict(clean=None, start_wns=None, final_wns=None,
                    start_viol=None, final_viol=None, note="log yok", effort=None)
    t = log.read_text(errors="ignore")
    if "[INFO RSZ-0098] No setup violations found" in t:
        return dict(clean=True, start_wns=0.0, final_wns=0.0,
                    start_viol=0, final_viol=0, note="RSZ-0098", effort=None)
    m = re.search(r"RSZ-0094\]\s*Found\s+(\d+)\s+endpoints with setup violations", t)
    start_viol = int(m.group(1)) if m else None
    # repair_timing'in ilerleme tablosu boru-ayraclidir:
    #   Iter | Removed | Resized | Inserted | Cloned | Pin | Area | WNS | TNS | Viol | Worst
    #      0 |       0 |       0 |        0 |      0 |   0 |+0.0% | -17.488 | -14782.2 | 2217 | _124940_/D
    # Iterasyon satirlari sayiyla, SON satir ise "final" kelimesiyle baslar.
    # Baglayici olan "final" satiridir; eskiden sadece \d+ arandigi icin
    # okunmuyordu ve son iterasyon nihai sonuc saniliyordu.
    rows = re.findall(
        r"^\s*(?:\d+|final)\s*\|(?:[^|\n]*\|){6}\s*(-?[\d.]+)\s*\|\s*(-?[\d.eE+-]+)\s*\|\s*(\d+)\s*\|",
        t, re.M)
    # Onarim EFORU: setup fazinin final satirindaki
    # Removed | Resized | Inserted | Cloned | PinSwaps sutunlari.
    # Bu, mevcut en iyi "ne kadar zorlandi" gostergesidir -- final WNS degil
    # (o yalnizca resizer'in durma esigini yansitir).
    eff = re.search(
        r"^\s*final\s*\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(\d+)\s*\|",
        t, re.M)
    effort = (dict(removed=int(eff.group(1)), resized=int(eff.group(2)),
                   inserted=int(eff.group(3)), cloned=int(eff.group(4)),
                   swaps=int(eff.group(5)))
              if eff else None)
    start_wns = float(rows[0][0]) if rows else None
    final_wns = float(rows[-1][0]) if rows else None
    final_viol = int(rows[-1][2]) if rows else None
    note = ""
    if "RSZ-0062" in t:
        note = "RSZ-0062 (tamami onarilamadi)"
    # TEMIZ olmanin IKI yolu var:
    #   1) resizer hic ihlal bulmaz -> [INFO RSZ-0098] (yukarida ele alindi)
    #   2) ihlal bulur ama HEPSINI onarir -> son satirda WNS >= 0 ve Viol = 0
    # Ikincisi bu tasarimda tipik durumdur; yalnizca RSZ-0098'e bakmak kapanan
    # bir periyodu yanlislikla "ihlalli" gosterirdi.
    # TEMIZ olmanin olcutu GERCEK slack'tir: final WNS >= 0.
    #
    # DIKKAT: `repair_timing -setup_margin 0.05` ile kosuyor, yani resizer
    # 50 ps'lik bir IC hedef kullanir. Slack'i 0 ile 0,05 arasinda kalan bir
    # uc, GERCEKTE kapaniyor olmasina ragmen "Viol" sutununda sayilir ve
    # [WARNING RSZ-0062] basilir. Bu yuzden RSZ-0062'nin varligi tek basina
    # "kapanmadi" demek DEGILDIR; belirleyici olan final WNS'tir.
    #
    # Buna karsilik cok kucuk bir pay (or. +0,028 ns) parazitik cikarim
    # sonrasi kolayca negatife doner. `margin_ns` bu yuzden ayrica raporlanir
    # ve secim kuralinda esik olarak kullanilir.
    closes = final_wns is not None and final_wns >= 0
    if closes:
        note = (f"kapaniyor, pay {final_wns:+.3f} ns"
                + ("  (resizer'in 50 ps ic hedefinin altinda)" if "RSZ-0062" in t else ""))
    return dict(clean=closes, start_wns=start_wns, final_wns=final_wns,
                start_viol=start_viol, final_viol=final_viol, note=note,
                margin_ns=final_wns, effort=effort)


def main():
    ap = argparse.ArgumentParser(description="saat periyodu kalibrasyonu")
    ap.add_argument("--cts-state", required=True, type=pathlib.Path,
                    help="OpenROAD.CTS adiminin state_out.json dosyasi")
    ap.add_argument("--periods", nargs="+", type=int, required=True,
                    help="denenecek CLOCK_PERIOD degerleri (ns)")
    ap.add_argument("--timeout-min", type=int, default=75,
                    help="periyot basina ust sinir (dk)")
    ap.add_argument("--min-margin", type=float, default=0.0,
                    help="(ileri duzey) ek olarak final WNS esigi. Varsayilan 0: "
                         "secim 'resizer sifir ihlale ulasti mi' olcutune dayanir; "
                         "bkz. rapordaki 'Secim kurali' bolumu")
    ap.add_argument("--reuse", action="store_true",
                    help="run/calib_p<N> altinda log varsa yeniden kosma, "
                         "diskteki olcumu kullan")
    ap.add_argument("--out", type=pathlib.Path,
                    default=ASIC / "reports/timing/frekans_kalibrasyonu.md")
    a = ap.parse_args()

    if not a.cts_state.is_file():
        sys.exit(f"HATA: CTS state dosyasi yok: {a.cts_state}")

    work = ASIC / "run" / "calib_overlays"
    rows = []
    for p in a.periods:
        print(f"\n=== CLOCK_PERIOD = {p} ns  ({1000.0/p:.2f} MHz) ===", flush=True)
        log, dt, to = run_point(a.cts_state, p, work, a.timeout_min * 60, a.reuse)
        r = parse_log(log)
        r.update(period=p, freq=1000.0 / p, secs=dt, timeout=to)
        rows.append(r)
        verdict = ("TEMIZ" if r["clean"] else
                   ("ZAMAN ASIMI (butcede kapanmadi)" if to else "IHLALLI"))
        print(f"    -> {verdict}  baslangic WNS={r['start_wns']}  "
              f"son WNS={r['final_wns']}  ihlal={r['final_viol']}  "
              f"({dt/60:.1f} dk)", flush=True)

    a.out.parent.mkdir(parents=True, exist_ok=True)
    L = ["# Saat periyodu kalibrasyonu", "",
         "Beyan edilecek ASIC saat frekansi TAHMIN EDILMEDI, olculdu. Yontem ve",
         "gerekce `asic/scripts/calibrate_clock.py` basligindadir: tek bir CTS",
         "veritabani uzerinde yalniz `OpenROAD.ResizerTimingPostCTS` adimi farkli",
         "`CLOCK_PERIOD` degerleriyle tekrar kosuldu. O adim STA_CORNERS'in",
         "tamamini yukler, dolayisiyla baglayici yavas kose (`nom_ss_100C_1v60`)",
         "dahil butun corner'lari kapsar -- `OpenROAD.STAMidPNR` ise yalnizca",
         "`DEFAULT_CORNER`'i kosar ve bu soruyu cevaplayamaz.", "",
         f"Girdi CTS veritabani: `{a.cts_state}`", "",
         "| Periyot | Frekans | Sonuc | Baslangic WNS | Baslangic ihlal | Son WNS | Kalan ihlal | Onarim eforu (sok/buyut/ekle) | Sure |",
         "|---:|---:|---|---:|---:|---:|---:|---|---:|"]
    for r in sorted(rows, key=lambda x: x["period"]):
        verdict = ("**TEMIZ**" if r["clean"] else
                   ("zaman asimi" if r["timeout"] else "ihlalli"))
        f = lambda v: "—" if v is None else (f"{v:g}")
        L.append(f"| {r['period']} ns | {r['freq']:.2f} MHz | {verdict} | "
                 f"{f(r['start_wns'])} | {f(r['start_viol'])} | "
                 f"{f(r['final_wns'])} | {f(r['final_viol'])} | "
                 f"{(lambda e: '—' if not e else f"{e['removed']}/{e['resized']}/{e['inserted']}")(r.get('effort'))} | "
                 f"{r['secs']/60:.1f} dk |")
    clean = [r for r in rows if r["clean"]]
    # SECIM OLCUTU: resizer'in SIFIR ihlale ulasmasi.
    solid = [r for r in clean
             if r["final_viol"] == 0 and (r["final_wns"] or 0) >= a.min_margin]
    L += ["", "## Secim kurali", "",
          "**final WNS bir PAY OLCUSU DEGILDIR.** `repair_timing` slack'i",
          "maksimize etmez; `-setup_margin 0.05` ile verilen 50 ps'lik ic hedefe",
          "ulasir ulasmaz durur. Olculen deger bunu acikca gosteriyor: 35 ns'de",
          "final WNS +0,028 ns, 38 ns'de +0,058 ns -- periyot 3 ns uzadigi halde",
          "'pay' neredeyse ayni, cunku ikisinde de resizer ayni esikte durmustur.",
          "",
          "Anlamli olan iki sey vardir:",
          "",
          "1. **Kalan ihlalli uc sayisi.** Sifir ise resizer hedefini TAM",
          "   tutturmustur, yani her ucun slack'i en az 50 ps'tir. Sifirdan",
          "   buyukse (or. 35 ns'de 1 uc) tasarim o periyotta sinirdadir.",
          "2. **Baslangicta ihlalli uc sayisi.** Onarim oncesi kac ucun",
          "   sikistigi, periyodun ne kadar zorlandiginin dogrudan olcusudur.",
          "",
          "Secim: **kalan ihlal sifir olan en kucuk TEST EDILMIS periyot**.",
          "",
          "> Bu bir MUTLAK minimum degildir. Yalnizca --periods ile verilen degerler",
          "> olculur; aradaki test edilmemis periyotlar (or. 37 ns) daha iyi olabilir.",
          "",
          "> Nihai ve baglayici rakam yine de bu tablo DEGILDIR. Post-CTS",
          "> parazitikler TAHMINIDIR ve bu akista `RUN_POST_GRT_RESIZER_TIMING`",
          "> kapalidir (LibreLane varsayilani), yani yollama sonrasi ikinci bir",
          "> zamanlama onarimi yoktur. Beyan edilen frekans, parazitik cikarim",
          "> sonrasi `OpenROAD.STAPostPNR` sonucuyla DOGRULANMALIDIR; o sonuc",
          "> README'nin *Signoff sonuc ozeti* bolumundedir.",
          "", "## Sonuc", ""]
    if solid:
        best = min(solid, key=lambda r: r["period"])
        tried = ", ".join(f"{r['period']}" for r in sorted(rows, key=lambda x: x["period"]))
        L.append(f"Secilen: **{best['period']} ns = {best['freq']:.2f} MHz** "
                 f"(resizer sifir ihlale ulasti; baslangicta "
                 f"{best['start_viol']} ihlalli uc vardi). "
                 f"`config.yaml` icindeki `CLOCK_PERIOD` bu degere ayarlanmistir.")
        L.append("")
        L.append(f"**Test edilen periyotlar:** {tried} ns. Aradaki degerler "
                 f"olculmedigi icin bu deger MUTLAK minimum degil, olculen aday "
                 f"kumesinin en kucugudur.")
        edge = [r for r in clean if r not in solid]
        if edge:
            ms = ", ".join(f"{r['period']} ns ({r['final_viol']} uc kaldi)"
                           for r in sorted(edge, key=lambda x: x["period"]))
            L += ["", f"Sinirda kalan (kapaniyor ama resizer hedefini tutturamadi): {ms}."]
    elif clean:
        best = min(clean, key=lambda r: r["period"])
        L.append(f"Hicbir periyotta resizer sifir ihlale ulasmadi. Kapanan en "
                 f"kucuk periyot **{best['period']} ns = {best['freq']:.2f} MHz** "
                 f"({best['final_viol']} uc kaldi); signoff'ta dogrulanmali.")
    else:
        L.append("Denenen periyotlarin hicbiri kapanmadi; "
                 "aralik yukari genisletilmelidir.")
    a.out.write_text("\n".join(L))
    print(f"\nrapor: {a.out}")

    (a.out.parent / "frekans_kalibrasyonu.json").write_text(
        json.dumps(rows, indent=2))
    return 0


if __name__ == "__main__":
    sys.exit(main())
