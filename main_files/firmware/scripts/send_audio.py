#!/usr/bin/env python3
# =====================================================================
#  send_audio.py — 1960 baytlik ses verisini FPGA'ya UART ile gonderir
#  Kullanim:  python3 send_audio.py input_data_yes.hex
#  Onceden:   pip install pyserial   (ya da: sudo apt install python3-serial)
# =====================================================================
import serial, sys, time

# --- AYARLAR: kendi sistemine gore duzenle ---
PORT = "/dev/ttyUSB1"     # ls /dev/ttyUSB* ile buldugun UART portu
BAUD = 115200             # UART_YZ RTL'indeki baud ile ESLESMELI!

if len(sys.argv) != 2:
    sys.exit(f"Kullanim: {sys.argv[0]} <input_data_X.hex>")

# hex metin (7F\n7F\n...) -> ham bayt. bytes.fromhex bosluk/newline'lari yoksayar.
try:
    data = bytes.fromhex(open(sys.argv[1]).read())
except ValueError as e:
    sys.exit(f"HATA: hex cozulemedi ({e}). Dosya '7F' formatinda mi?")

if len(data) != 1960:
    sys.exit(f"HATA: dosya {len(data)} bayt, 1960 olmali. Yanlis dosya olabilir.")

ser = serial.Serial(
    PORT, BAUD,
    bytesize=serial.EIGHTBITS,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    timeout=1,
)
ser.reset_output_buffer()
ser.write(data)
ser.flush()               # OS buffer'i bosalt
time.sleep(0.3)           # son baytlar FTDI'dan fiziksel olarak ciksin
ser.close()
print(f"OK: {len(data)} bayt gonderildi -> {PORT} @ {BAUD} 8N1")
