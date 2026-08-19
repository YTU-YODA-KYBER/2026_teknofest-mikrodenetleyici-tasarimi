#!/usr/bin/env python3
# =====================================================================
#  run_accuracy.py -- YZ dogruluk kiyasi (yazilim gerceklemesi vs donanim)
#
#  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
#
#  NEYI OLCER
#  ----------
#  Sartname: "YZ hizlandiricisini kullanarak, yazilim ile gerceklenen
#  modelin dogrulugunu (accuracy) %10'luk bir pencere dahilinde
#  yakalamalidir."
#
#  Buradaki accuracy SINIFLANDIRMA dogrulugudur:
#      accuracy = dogru siniflandirilan ornek / toplam ornek
#  Yani "iki taraf %90 ayni cevabi versin" degil, "iki tarafin dogruluk
#  ORANLARI arasindaki fark %10'u gecmesin". Ornek-basi uyum daha guclu
#  bir metrik oldugu icin ayrica raporlanir.
#
#  NASIL OLCULUR  (kart uzerinde, tek gonderim -> iki sonuc)
#  ---------------------------------------------------------
#  yz_bench uygulamasi ayni 1960 bayti hem hizlandiriciya hem de CPU'da
#  kosan TFLite yazilim gerceklemesine verir ve iki satir doner:
#
#      YZ:<sinif>                        <- hizlandirici
#      SW:<sinif> HC:<cevrim> SC:<cevrim> <- yazilim + iki tarafin cevrimi
#
#  uart_mux.sv'de genel UART'in RX'i her modda acik oldugu icin tek
#  gonderim iki yolu birden besler; iki taraf garantili AYNI ornegi isler.
#
#  VERI KUMESI DUZENI
#  ------------------
#  Sinif adi = klasor adi (ayri bir etiket dosyasi tutulmaz):
#
#      dataset/
#      |-- sessizlik/*.wav|*.hex     -> sinif 0
#      |-- bilinmeyen/*.wav|*.hex    -> sinif 1
#      |-- yes/*.wav|*.hex           -> sinif 2
#      +-- no/*.wav|*.hex            -> sinif 3
#
#  .wav dosyalari wav_to_yz.py ile otomatik 1960 baytlik hex'e cevrilir
#  (cache: dataset/.hex_cache/). Dogrudan .hex koyarsan donusum atlanir.
#
#  DIKKAT: model INGILIZCE egitilmistir (TFLite micro_speech). "evet" /
#  "hayir" kayitlari degil, "yes" / "no" kayitlari kullanilmalidir.
#  "bilinmeyen" = yes/no disindaki kelimeler (on, off, up, down, stop...).
#
#  KULLANIM
#  --------
#    # 1) ASIL KOSU: kart bagli, yz_bench bitstream'i yuklu, SW1=1 SW0=0
#    python3 run_accuracy.py --dataset dataset --board --port /dev/ttyUSB1
#
#    # 2) CAPRAZ KONTROL: ayni modeli host'ta kostur (kart gerekmez).
#    #    Kartin SW sutunuyla %100 ayni cikmali -- tam sayi aritmetigi.
#    python3 run_accuracy.py --dataset dataset --host
#
#    # 3) kaydedilmis sonuclardan sadece raporu uret
#    python3 run_accuracy.py --dataset dataset --report
#
#  Sonuclar results_board.csv / results_host.csv icine yazilir.
# =====================================================================
"""YZ hizlandiricisinin dogrulugunu TFLite yazilim referansiyla kiyaslar."""

import argparse
import csv
import importlib.util
import re
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent                       # main_files/
WAV_TO_YZ = ROOT / "scripts/wav_to_yz.py"
SEND_DATA = ROOT / "firmware/scripts/send_data.py"
REF_RUN = ROOT / "scripts/yz_tflite/ref_run"

AUDIO_LEN = 1960

# Sinif indeksleri: soc.h "TFLite Micro Speech standart sirasi"
CLASS_NAMES = ["sessizlik", "bilinmeyen", "yes", "no"]

# Klasor adi -> sinif indeksi. Turkce/Ingilizce ve TFLite'in alt cizgili
# adlandirmasi da kabul edilir ki veri kumesini nasil adlandirdigin onemli
# olmasin.
DIR_ALIASES = {
    "sessizlik": 0, "silence": 0, "_silence_": 0, "background": 0,
    "bilinmeyen": 1, "unknown": 1, "_unknown_": 1,
    "yes": 2, "evet": 2,
    "no": 3, "hayir": 3, "hayır": 3,
}

# yz_bench.c'nin ikinci rapor satiri
SW_LINE_RE = re.compile(r"^SW:(\d+)\s+HC:(\d+)\s+SC:(\d+)$")


# =====================================================================
#  Veri kumesini tara / hazirla
# =====================================================================
def scan_dataset(root):
    """dataset/<sinif>/<dosya> agacini (hex_yolu, etiket) listesine cevirir."""
    root = Path(root)
    if not root.is_dir():
        sys.exit(f"HATA: veri kumesi klasoru yok: {root}")

    cache = root / ".hex_cache"
    items, to_convert = [], []

    for sub in sorted(root.iterdir()):
        if not sub.is_dir() or sub.name.startswith("."):
            continue
        label = DIR_ALIASES.get(sub.name.lower())
        if label is None:
            print(f"  uyari: '{sub.name}' bilinen bir sinif adi degil, atlaniyor")
            continue

        for f in sorted(sub.iterdir()):
            if f.suffix.lower() == ".hex":
                items.append((f, label))
            elif f.suffix.lower() == ".wav":
                # Cache yolunda sinif adini tut: farkli siniflarda ayni
                # dosya adi olabilir (Speech Commands'ta sik gorulur).
                hexf = cache / sub.name / (f.stem + ".hex")
                items.append((hexf, label))
                if not hexf.exists() or hexf.stat().st_mtime < f.stat().st_mtime:
                    to_convert.append((f, hexf))

    if not items:
        sys.exit(f"HATA: {root} altinda hic .wav/.hex bulunamadi")

    if to_convert:
        print(f"wav -> hex donusumu: {len(to_convert)} dosya")
        convert_wavs(to_convert)

    missing = [p for p, _ in items if not p.exists()]
    if missing:
        sys.exit(f"HATA: {len(missing)} hex uretilemedi, ilki: {missing[0]}")

    return items


def convert_wavs(pairs):
    """wav_to_yz.py ile toplu donusum. Cikti yolu -o ile acikca verilir."""
    for i, (wav, hexf) in enumerate(pairs, 1):
        hexf.parent.mkdir(parents=True, exist_ok=True)
        r = subprocess.run(
            [sys.executable, str(WAV_TO_YZ), str(wav), "-o", str(hexf)],
            capture_output=True, text=True)
        if r.returncode != 0:
            sys.exit(f"HATA: wav_to_yz.py basarisiz: {wav}\n{r.stdout}{r.stderr}")
        if i % 25 == 0 or i == len(pairs):
            print(f"  {i}/{len(pairs)}")


# =====================================================================
#  Host kosusu (capraz kontrol)
# =====================================================================
def run_host(items, out_csv):
    """Host'ta derlenmis ref_run'i tum girdiler uzerinde kosturur.

    Kartin dondurdugu SW sutunuyla BIREBIR ayni cikmali: tflite_ref.c tam
    sayi aritmetigi kullanir, taşma olmaz, tanimsiz davranis yoktur --
    yani host ile RV32 ayni sonucu vermek ZORUNDADIR. Ayrisma varsa
    RV32 derlemesinde ya da bellek yerlesiminde bir sorun var demektir.
    """
    if not REF_RUN.exists():
        sys.exit(f"HATA: {REF_RUN} yok.\n"
                 f"  Once:  cd scripts/yz_tflite && make")

    print(f"host referansi kosuyor ({len(items)} ornek)...")
    t0 = time.monotonic()

    # argv sinirina takilmamak icin parcali cagri
    rows, CHUNK = [], 200
    paths = [str(p) for p, _ in items]
    for i in range(0, len(paths), CHUNK):
        r = subprocess.run([str(REF_RUN)] + paths[i:i + CHUNK],
                           capture_output=True, text=True)
        if r.returncode != 0:
            sys.exit(f"HATA: ref_run basarisiz:\n{r.stderr}")
        rows += list(csv.DictReader(r.stdout.splitlines()))

    print(f"  bitti ({time.monotonic() - t0:.1f} s)")

    by_path = {row["dosya"]: row for row in rows}
    with open(out_csv, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["dosya", "etiket", "tahmin", "tahmin_i32"])
        for p, label in items:
            row = by_path[str(p)]
            w.writerow([p, label, row["sinif"], row["sinif_acc"]])
    print(f"  yazildi: {out_csv.name}")


# =====================================================================
#  Kart kosusu -- tek gonderim, iki sonuc
# =====================================================================
def load_send_data():
    """send_data.py'yi modul olarak yukle (paket degil, dosya yolundan)."""
    spec = importlib.util.spec_from_file_location("send_data", SEND_DATA)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def run_board(items, out_csv, port, baud, settle):
    """Her ornegi karta gonderip 'YZ:' ve 'SW:' satirlarini toplar.

    send_data.py'nin send_audio()'su her cagride portu acip kapatir ve
    hatada sys.exit eder -- 300 orneklik bir kosu icin uygun degil. Bu
    yuzden portu bir kez acip yardimci fonksiyonlarini (read_audio_hex,
    read_line) yeniden kullaniyoruz; hata durumunda kosu durmaz, ornek
    'cevapsiz' isaretlenip devam edilir.
    """
    sd = load_send_data()
    ser = sd.open_port(port, baud, timeout=sd.POLL_TMO)
    print(f"kart kosusu: {len(items)} ornek -> {port} @ {baud}")

    results, fails = [], 0
    try:
        for i, (path, label) in enumerate(items, 1):
            data = sd.read_audio_hex(path)
            ser.reset_input_buffer()
            ser.reset_output_buffer()
            ser.write(data)
            ser.flush()

            hw = sw = hc = sc = None
            deadline = time.monotonic() + sd.RESULT_TMO
            while time.monotonic() < deadline and (hw is None or sw is None):
                line = sd.read_line(ser, deadline)
                if line is None:
                    break
                if line == sd.YZ_BUSY:
                    continue
                if line.startswith(sd.YZ_PREFIX) and line[len(sd.YZ_PREFIX):].isdigit():
                    hw = int(line[len(sd.YZ_PREFIX):])
                    continue
                m = SW_LINE_RE.match(line)
                if m:
                    sw, hc, sc = int(m[1]), int(m[2]), int(m[3])

            if hw is None or sw is None:
                fails += 1
                print(f"  [{i}/{len(items)}] EKSIK CEVAP: {path.name} "
                      f"(YZ={hw}, SW={sw})")
            results.append((path, label, hw, sw, hc, sc))

            if i % 25 == 0:
                print(f"  {i}/{len(items)}")
            time.sleep(settle)     # UART hatti bir sonraki cerceve icin dinginlessin
    finally:
        ser.close()

    if fails:
        print(f"  uyari: {fails} ornekte cevap eksik geldi.")
        print(f"    - yz_bench bitstream'i yuklu mu?")
        print(f"    - SW1=1 ve SW0=0 mi? (GPIO_IDR[1:0] == 2, TX pini UART_YZ'de)")

    with open(out_csv, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["dosya", "etiket", "hw", "sw", "hw_cevrim", "sw_cevrim"])
        for path, label, hw, sw, hc, sc in results:
            w.writerow([path, label,
                        "" if hw is None else hw, "" if sw is None else sw,
                        "" if hc is None else hc, "" if sc is None else sc])
    print(f"  yazildi: {out_csv.name}")


# =====================================================================
#  Rapor
# =====================================================================
def load_board(path):
    """results_board.csv -> {dosya: (etiket, hw, sw, hc, sc)}"""
    if not path.exists():
        return None
    out = {}
    with open(path, newline="") as f:
        for row in csv.DictReader(f):
            if row["hw"] == "" or row["sw"] == "":
                continue                       # eksik cevap rapora girmez
            out[row["dosya"]] = (
                int(row["etiket"]), int(row["hw"]), int(row["sw"]),
                int(row["hw_cevrim"]) if row["hw_cevrim"] else None,
                int(row["sw_cevrim"]) if row["sw_cevrim"] else None)
    return out


def load_host(path):
    """results_host.csv -> {dosya: (etiket, tahmin)}"""
    if not path.exists():
        return None
    with open(path, newline="") as f:
        return {row["dosya"]: (int(row["etiket"]), int(row["tahmin"]))
                for row in csv.DictReader(f)}


def accuracy(pairs):
    """pairs: [(etiket, tahmin)] -> (yuzde, dogru, toplam)"""
    if not pairs:
        return 0.0, 0, 0
    ok = sum(1 for lbl, pred in pairs if lbl == pred)
    return 100.0 * ok / len(pairs), ok, len(pairs)


def confusion(pairs):
    m = [[0] * 4 for _ in range(4)]
    for lbl, pred in pairs:
        m[lbl][pred] += 1
    return m


def print_confusion(m, title):
    print(f"\n  {title}   (satir = gercek, sutun = tahmin)")
    head = "".join(f"{n[:9]:>11}" for n in CLASS_NAMES)
    print(f"    {'':>12}{head}{'':>6}dogruluk")
    for i, row in enumerate(m):
        tot = sum(row)
        cells = "".join(f"{v:>11}" for v in row)
        acc = f"{100.0 * row[i] / tot:.1f}%" if tot else "-"   # ornegi olmayan sinif
        print(f"    {CLASS_NAMES[i]:>12}{cells}{acc:>14}")


def verdict(ok):
    return "GECTI" if ok else "KALDI"


def report(board, host):
    print("\n" + "=" * 72)
    print("  YZ DOGRULUK RAPORU -- TFLite yazilim gerceklemesi vs hizlandirici")
    print("=" * 72)

    if not board:
        if host:
            a, ok, n = accuracy(list(host.values()))
            print(f"\n  Host referansi : {a:6.2f} %   ({ok}/{n})")
            print("\n  Kart kosusu yok -- %10 penceresi karari icin --board gerekli.")
        else:
            print("\n  Hic sonuc dosyasi yok. Once --board (ya da --host) kostur.")
        return

    hw_pairs = [(v[0], v[1]) for v in board.values()]
    sw_pairs = [(v[0], v[2]) for v in board.values()]
    n = len(board)

    a_sw, ok_sw, _ = accuracy(sw_pairs)
    a_hw, ok_hw, _ = accuracy(hw_pairs)
    diff = a_sw - a_hw

    print(f"\n  Kart uzerinde, {n} ornek, tek gonderim -> iki sonuc")
    print(f"  accuracy(yazilim, CV32E40P) : {a_sw:6.2f} %   ({ok_sw}/{n})")
    print(f"  accuracy(donanim, YZ accel) : {a_hw:6.2f} %   ({ok_hw}/{n})")

    print(f"\n  --- Sartname: %10'luk pencere ---")
    print(f"  fark (mutlak puan)   : {abs(diff):6.2f} puan   sinir 10.00   "
          f"-> {verdict(abs(diff) <= 10)}")
    if a_sw > 0:
        rel = 100.0 * (1.0 - a_hw / a_sw)
        print(f"  fark (bagil dusus)   : {rel:6.2f} %       sinir 10.00   "
              f"-> {verdict(rel <= 10)}")

    # Ornek-basi uyum: sartnamenin istedigi bu degil ama daha guclu.
    agree = sum(1 for v in board.values() if v[1] == v[2])
    print(f"\n  ornek-basi sinif uyumu : {100.0 * agree / n:6.2f} %   ({agree}/{n})")
    if agree == n:
        print("    -> Iki yol TUM orneklerde ayni sinifi verdi.")
    else:
        print(f"\n    AYRISAN ORNEKLER ({n - agree} adet):")
        for k, v in sorted(board.items()):
            if v[1] != v[2]:
                print(f"      {Path(k).name:<38} gercek={CLASS_NAMES[v[0]]:<11}"
                      f" yazilim={CLASS_NAMES[v[2]]:<11} donanim={CLASS_NAMES[v[1]]}")
        print("\n    Az sayida ayrisma NORMALDIR: hizlandirici requant'i tek")
        print("    adimli (acc*M0 >> SHR), TFLite ise iki adimli gemmlowp;")
        print("    ayrica hizlandirici FC cikisini int8'e sikistirmaz.")

    # --- hiz (bench app zaten olcuyor) ---
    cyc = [(v[3], v[4]) for v in board.values() if v[3] and v[4]]
    if cyc:
        hc = sum(c[0] for c in cyc) / len(cyc)
        sc = sum(c[1] for c in cyc) / len(cyc)
        print(f"\n  --- Hiz (ayni kosudan, ortalama) ---")
        print(f"  donanim : {hc:12,.0f} cevrim   ({hc / 50e6 * 1000:7.3f} ms @ 50 MHz)")
        print(f"  yazilim : {sc:12,.0f} cevrim   ({sc / 50e6 * 1000:7.3f} ms)")
        print(f"  HIZLANMA: {sc / hc:.1f} x")

    # --- host capraz kontrolu ---
    if host:
        common = sorted(set(board) & set(host))
        if common:
            same = sum(1 for k in common if board[k][2] == host[k][1])
            print(f"\n  --- Capraz kontrol: kartin yazilimi == host'un yazilimi ---")
            print(f"  {same}/{len(common)} ornekte ayni sinif "
                  f"({100.0 * same / len(common):.2f} %)")
            if same == len(common):
                print("    -> Ayni C kodu RV32'de ve host'ta AYNI sonucu veriyor;")
                print("       host kosumlari kart kosumunun yerine gecebilir.")
            else:
                print("    -> UYARI: ayrisma var. Tam sayi aritmetiginde bu")
                print("       OLMAMALI; RV32 derlemesi ya da bellek yerlesimi")
                print("       incelenmeli.")

    print_confusion(confusion(sw_pairs), "YAZILIM (CV32E40P)")
    print_confusion(confusion(hw_pairs), "DONANIM (YZ hizlandirici)")
    print()


# =====================================================================
def main():
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--dataset", default=str(HERE / "dataset"),
                    help="sinif adiyla adlandirilmis alt klasorleri olan veri kumesi")
    ap.add_argument("--board", action="store_true",
                    help="kart uzerinde kostur (asil olcum)")
    ap.add_argument("--host", action="store_true",
                    help="ayni modeli host'ta kostur (capraz kontrol)")
    ap.add_argument("--report", action="store_true",
                    help="kosturma, mevcut results_*.csv dosyalarindan rapor uret")
    ap.add_argument("--port", default="/dev/ttyUSB1", help="UART portu")
    ap.add_argument("--baud", type=int, default=115200, help="UART baud")
    ap.add_argument("--settle", type=float, default=0.05,
                    help="kart kosusunda ornekler arasi bekleme (s)")
    ap.add_argument("--outdir", default=str(HERE), help="results_*.csv nereye yazilsin")
    args = ap.parse_args()

    if not (args.board or args.host or args.report):
        ap.error("en az birini ver: --board / --host / --report")

    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)
    board_csv, host_csv = outdir / "results_board.csv", outdir / "results_host.csv"

    if args.board or args.host:
        items = scan_dataset(args.dataset)
        counts = {}
        for _, lbl in items:
            counts[lbl] = counts.get(lbl, 0) + 1
        dist = "  ".join(f"{CLASS_NAMES[k]}={counts.get(k, 0)}" for k in range(4))
        print(f"veri kumesi: {len(items)} ornek   ({dist})")
        if len(items) < 100:
            print(f"  UYARI: 100'den az ornek. Tek ornek {100.0/len(items):.2f} "
                  "puan eder; istatistiksel gurultu %10 penceresini "
                  "yaniltabilir. Sinif basi 50-100 hedefle.")

        if args.board:
            run_board(items, board_csv, args.port, args.baud, args.settle)
        if args.host:
            run_host(items, host_csv)

    report(load_board(board_csv), load_host(host_csv))
    return 0


if __name__ == "__main__":
    sys.exit(main())
