#!/usr/bin/env python3
# =====================================================================
#  send_data.py — Karta UART uzerinden veri gonderme araci (iki mod)
#
#  1) APP modu   : makefile_outputs/app.hex'i Boot ROM'daki FLASHER'a gonderir,
#                  flasher da veriyi QSPI flash'a yazip checksum ile dogrular.
#                  Protokol (main_boot.c: flasher()):
#                     PC -> 4 bayt LENGTH (MSB-first)
#                     PC -> 256 baytlik chunk,  kart -> 0x06 (ACK),  ... tekrar
#                  ON KOSUL: SW0=1 + CPU RESET (7-segment'te "boot" yazmali).
#                  SONUC   : 7-segment/LED  3 = checksum OK, 4 = checksum HATA.
#
#  2) AUDIO modu : sound_samples/ altindaki 1960 baytlik ses verisini UART_YZ'ye
#                  gonderir; kart veriyi YZ bellegine yazip cikarim yapar,
#                  sonucu 7-segment'e basar (7=evet, 8=hayir, 9=sessizlik) VE
#                  ayni sonucu UART_YZ TX'ten geri gonderir. Script bu cevabi
#                  bekleyip ekrana yazar.
#                  Cerceve (main_app.c: yz_report()):
#                     "YZ:B\n"        -> veri yuklendi, cikarim basladi
#                     "YZ:<0-3>\n"    -> cikarim bitti, sinif indeksi
#                  ON KOSUL: app flash'a yazilmis + SW0=0 ile boot edilmis,
#                            ardindan SW1=1 (YZ-UART modu).
#
#  Kullanim:
#      python3 send_data.py app                # ../makefile_outputs/app.hex
#      python3 send_data.py yes                # ../sound_samples/input_data_yes.hex
#      python3 send_data.py no
#      python3 send_data.py sessizlik
#      python3 send_data.py app   <dosya>      # kisayol yerine acik dosya yolu
#      python3 send_data.py audio <dosya>
#      python3 send_data.py app --port /dev/ttyUSB0 --baud 115200
#      python3 send_data.py yes --no-wait      # sonucu bekleme, sadece gonder
#
#  Kisayollar script'in kendi konumuna gore cozulur; hangi klasorden
#  calistirdiginin onemi yoktur.
#
#  Onceden:  pip install pyserial   (ya da: sudo apt install python3-serial)
# =====================================================================
import argparse
import sys
import time
from pathlib import Path

import serial

# --- AYARLAR: kendi sistemine gore duzenle ---
PORT = "/dev/ttyUSB1"     # ls /dev/ttyUSB* ile buldugun UART portu
BAUD = 115200             # UART / UART_YZ RTL'indeki baud ile ESLESMELI!

# --- Protokol sabitleri (main_boot.c ile ayni olmali) ---
CHUNK     = 256           # flasher'in PP chunk boyutu
ACK       = 0x06          # her chunk sonrasi karttan beklenen bayt
ACK_TMO   = 5.0           # ACK bekleme zaman asimi [s]
AUDIO_LEN = 1960          # YZ bellegine yazilan ses verisi uzunlugu [bayt]

# --- YZ cevap protokolu (main_app.c: yz_report()) ---
YZ_PREFIX  = "YZ:"        # her cerceve bu on ek ile baslar
YZ_BUSY    = "YZ:B"       # veri yuklendi, cikarim basladi
RESULT_TMO = 5.0          # cikarim sonucu icin toplam bekleme suresi [s]
POLL_TMO   = 0.1          # tek okuma cagrisinin bloklanma suresi [s]

# --- YZ_RESULT.CLASS -> etiket (soc.h ile ayni sira) ---
CLASS_NAMES = {0: "sessizlik", 1: "bilinmeyen", 2: "evet", 3: "hayir"}

# --- Kisayol -> dosya yolu tablosu (script konumuna gore) ---
HERE      = Path(__file__).resolve().parent          # firmware/scripts
FW_DIR    = HERE.parent                              # firmware
APP_HEX   = FW_DIR / "makefile_outputs" / "app.hex"
AUDIO_HEX = {
    "yes":       FW_DIR / "sound_samples" / "input_data_yes.hex",
    "no":        FW_DIR / "sound_samples" / "input_data_no.hex",
    "sessizlik": FW_DIR / "sound_samples" / "input_data_sessizlik.hex",
}


def open_port(port, baud, timeout=ACK_TMO):
    return serial.Serial(
        port, baud,
        bytesize=serial.EIGHTBITS,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        timeout=timeout,
    )


# =====================================================================
#  AUDIO modu  (ses verisi -> UART_YZ -> YZ bellegi)
# =====================================================================
def read_audio_hex(path):
    """Satir basina bir bayt ('7F\\n7F\\n...') -> ham bayt dizisi."""
    try:
        tokens = Path(path).read_text().split()
    except (OSError, UnicodeDecodeError) as e:
        sys.exit(f"HATA: dosya okunamadi ({e}). Metin formatinda hex mi?")
    try:
        data = bytes(int(t, 16) for t in tokens)
    except ValueError as e:
        sys.exit(f"HATA: hex cozulemedi ({e}). Dosya '7F' formatinda mi?")
    if len(data) != AUDIO_LEN:
        sys.exit(f"HATA: {path} -> {len(data)} bayt, {AUDIO_LEN} olmali. "
                 f"Yanlis dosya olabilir.")
    return data


def read_line(ser, deadline):
    """Deadline'a kadar '\\n' ile biten bir satir topla. Yoksa None.

    ser.timeout kisa (POLL_TMO) tutulur; boylece toplam bekleme suresini
    burada kontrol ederiz, tek okumanin bloklanmasinda degil.
    """
    buf = bytearray()
    while time.monotonic() < deadline:
        b = ser.read(1)
        if not b:
            continue                      # bu poll'da bayt gelmedi, devam
        if b in b"\r\n":
            if buf:
                return buf.decode("ascii", "replace").strip()
            continue                      # bos satir / CRLF artigi
        buf += b
        if len(buf) > 64:                 # cerceve 5 bayt; bu kadari cop demek
            buf.clear()
    return None


def wait_result(ser):
    """Karttan 'YZ:<sinif>' cercevesini bekle. Sinif indeksini dondurur."""
    deadline = time.monotonic() + RESULT_TMO
    while True:
        line = read_line(ser, deadline)
        if line is None:
            sys.exit(
                f"\nHATA: karttan sonuc gelmedi ({RESULT_TMO} s beklendi).\n"
                f"  - SW1=1 (YZ-UART modu) ve SW0=0 mi? TX pini uart_mux'ta\n"
                f"    ancak GPIO_IDR[1:0]==2 iken UART_YZ'ye baglanir.\n"
                f"  - Uygulama flash'tan boot edildi mi (7-segment'te 6/INFRNC)?\n"
                f"  - Port ({ser.port}) ve baud ({ser.baudrate}) dogru mu?"
            )
        if line == YZ_BUSY:
            print("  kart: veri yuklendi, cikarim basladi")
            continue
        if line.startswith(YZ_PREFIX) and line[len(YZ_PREFIX):].isdigit():
            return int(line[len(YZ_PREFIX):])
        print(f"  (yoksayildi: {line!r})")   # gurultu / yarim cerceve


def send_audio(path, port, baud, wait=True):
    data = read_audio_hex(path)
    ser = open_port(port, baud, timeout=POLL_TMO)
    ser.reset_input_buffer()   # onceki calistirmadan kalan baytlari at
    ser.reset_output_buffer()
    ser.write(data)
    ser.flush()               # OS buffer'i bosalt
    print(f"OK: {len(data)} bayt gonderildi -> {port} @ {baud} 8N1")

    if not wait:
        time.sleep(0.3)       # son baytlar FTDI'dan fiziksel olarak ciksin
        ser.close()
        print("Sonuc 7-segment'te: 7=evet, 8=hayir, 9=sessizlik, 10=bilinmeyen")
        return

    try:
        cls = wait_result(ser)
    finally:
        ser.close()

    print(f"SONUC: sinif {cls} -> {CLASS_NAMES.get(cls, 'TANIMSIZ')}")
    print("7-segment karsiligi: 7=evet, 8=hayir, 9=sessizlik, 10=bilinmeyen")


# =====================================================================
#  APP modu  (app.hex -> Boot ROM flasher -> QSPI flash)
# =====================================================================
def read_verilog_hex(path):
    """objcopy -O verilog ciktisi -> ham bayt dizisi.

    '@ADDR' satirlari atlanir. Kalan her token bir 32-bit kelimedir
    (--verilog-data-width=4); token'in metindeki bayt sirasi dogrudan
    gonderilir, cunku flasher'daki urx_word() ilk gelen bayti MSB yapar.
    """
    try:
        tokens = Path(path).read_text().split()
    except (OSError, UnicodeDecodeError) as e:
        sys.exit(f"HATA: dosya okunamadi ({e}). Bu bir .hex dosyasi mi? "
                 f"(app.bin degil, app.hex gonderilir)")

    data = bytearray()
    for t in tokens:
        if t.startswith("@"):          # adres etiketi -> veri degil
            continue
        if len(t) % 2 or not all(c in "0123456789abcdefABCDEF" for c in t):
            sys.exit(f"HATA: beklenmeyen token '{t}'. Dosya objcopy verilog "
                     f"hex'i mi? ('make app' ile uretilir)")
        data += bytes.fromhex(t)

    if not data:
        sys.exit(f"HATA: {path} icinde veri yok.")

    # flasher'in pp_chunk()'i 32-bit kelime yazar -> uzunluk 4'un kati olmali
    while len(data) % 4:
        data.append(0x00)
    return bytes(data)


def send_app(path, port, baud):
    data  = read_verilog_hex(path)
    total = len(data)
    print(f"{path} -> {total} bayt, {(total + CHUNK - 1) // CHUNK} chunk")

    ser = open_port(port, baud)
    ser.reset_input_buffer()
    ser.reset_output_buffer()

    # LENGTH: 4 bayt, MSB-first (main_boot.c: urx_word())
    ser.write(total.to_bytes(4, "big"))
    ser.flush()

    sent = 0
    while sent < total:
        n = min(CHUNK, total - sent)
        ser.write(data[sent:sent + n])
        ser.flush()

        ack = ser.read(1)          # kart chunk'i flash'a yazinca ACK yollar
        if not ack:
            ser.close()
            sys.exit(f"\nHATA: ACK gelmedi ({sent}/{total} bayt sonrasi, "
                     f"{ACK_TMO} s beklendi). SW0=1 + reset yapildi mi? "
                     f"Port/baud dogru mu?")
        if ack[0] != ACK:
            ser.close()
            sys.exit(f"\nHATA: beklenmeyen yanit 0x{ack[0]:02X} "
                     f"(0x{ACK:02X} bekleniyordu).")

        sent += n
        print(f"\r  {sent}/{total} bayt", end="", flush=True)

    ser.close()
    print(f"\nOK: {total} bayt gonderildi -> {port} @ {baud} 8N1")
    print("Kart simdi flash'i geri okuyup checksum karsilastiriyor.")
    print("7-segment/LED:  3 = dogrulama BASARILI,  4 = dogrulama HATALI")


# =====================================================================
#  Komut satiri
# =====================================================================
def main():
    ap = argparse.ArgumentParser(
        description="FPGA'ya UART ile app.hex (flash) veya ses verisi (YZ) gonderir.",
        epilog="Ornek: python3 send_data.py app   |   python3 send_data.py yes",
    )
    ap.add_argument("hedef", choices=["app", "audio", "yes", "no", "sessizlik"],
                    help="app: uygulamayi flash'a yaz | yes/no/sessizlik: hazir "
                         "ses ornegi | audio: kendi ses dosyani ver")
    ap.add_argument("dosya", nargs="?",
                    help="Acik dosya yolu (verilmezse kisayola gore secilir; "
                         "'audio' hedefinde zorunlu)")
    ap.add_argument("--port", default=PORT, help=f"UART portu (varsayilan: {PORT})")
    ap.add_argument("--baud", type=int, default=BAUD,
                    help=f"baud hizi (varsayilan: {BAUD})")
    ap.add_argument("--no-wait", action="store_true",
                    help="ses gonderdikten sonra karttan gelen sonucu bekleme "
                         "(eski davranis; sadece 7-segment'e bakilir)")
    args = ap.parse_args()

    if args.hedef == "app":
        path = Path(args.dosya) if args.dosya else APP_HEX
        if not path.is_file():
            sys.exit(f"HATA: {path} yok. Once 'make app' calistir.")
        send_app(path, args.port, args.baud)
    else:
        if args.hedef == "audio":
            if not args.dosya:
                sys.exit("HATA: 'audio' hedefi icin dosya yolu vermelisin. "
                         "Hazir ornekler icin: yes | no | sessizlik")
            path = Path(args.dosya)
        else:
            path = Path(args.dosya) if args.dosya else AUDIO_HEX[args.hedef]
        if not path.is_file():
            sys.exit(f"HATA: {path} yok.")
        send_audio(path, args.port, args.baud, wait=not args.no_wait)


if __name__ == "__main__":
    main()
