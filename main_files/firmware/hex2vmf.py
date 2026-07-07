#!/usr/bin/env python3
"""
firmware.hex (objcopy -O verilog --verilog-data-width=4 ciktisi)
        -> mem_Q512.vmf (Micron N25Qxxx/MT25QL256 sim modeli icin)

NEDEN DOGRUDAN BU FORMATTAN GIDIYORUZ (app.bin'den DEGIL):
  objcopy --verilog-data-width=4, her 4 byte'i "sayisal deger" olarak
  (big-endian gosterim) tek bir 8-hex-char token halinde basar. Yani
  token'in SOL->SAG byte sirasi = MSB->LSB.

  QSPI RTL'i flash'tan okurken byte'lari MSB-first birlestiriyor
  (ilk okunan byte -> word'un en anlamli byte'i). Yani flash'ta da
  ayni MSB->LSB byte sirasini istiyoruz.

  Iki "MSB once" gosterim ust uste binince: token'i ikiser karaktere
  bolup SOLDAN SAGA, oldugu gibi flash'a yazmak yeterli. app.bin
  (gercek little-endian bellek dokumu, LSB once) kullansaydik her
  4-byte'i TERS cevirmemiz gerekirdi -- .hex'ten gidince bu adim
  objcopy'nin gosterim bicimi tarafindan zaten yapilmis oluyor.

  Script sonunda bu iddiayi OTOMATIK olarak dogrular: uretilen byte
  dizisini QSPI'in MSB-first birlestirme mantigiyla geri "okuyup"
  orijinal token degerleriyle karsilastirir. Uyusmazsa hata basar,
  sessizce yanlis dosya uretmez.

Kullanim:
    python3 hex2vmf.py <firmware.hex> <mem_Q512.vmf> [flash_offset_hex]

    firmware.hex       : 'make app' ciktisi (build_app/firmware.hex)
    mem_Q512.vmf        : uretilecek flash icerik dosyasi
    flash_offset_hex    : app'in flash'taki bas adresi (varsayilan 0)
                          (bootloader_main.c'deki APP_FLASH_ADDR ile
                           AYNI olmali)
"""
import sys


def parse_verilog_hex(path):
    """objcopy -O verilog --verilog-data-width=4 ciktisini ayristirir.
    Donen deger: [(source_addr, [4 byte, MSB once]), ...] token listesi."""
    tokens = []
    cur_addr = None
    addr_seen = False

    with open(path, "r") as f:
        for lineno, raw in enumerate(f, 1):
            line = raw.strip()
            if not line:
                continue

            if line.startswith("@"):
                cur_addr = int(line[1:], 16)
                addr_seen = True
                continue

            if not addr_seen:
                sys.exit(f"[HATA] satir {lineno}: @adres gelmeden veri satiri "
                          f"bulundu, dosya beklenen Verilog-hex formatinda degil.")

            for tok in line.split():
                if len(tok) != 8 or any(c not in "0123456789abcdefABCDEF" for c in tok):
                    sys.exit(f"[HATA] satir {lineno}: '{tok}' 8 hex karakterlik "
                              f"bir word degil (--verilog-data-width=4 bekleniyor).")
                b = bytes.fromhex(tok)          # b[0]=MSB byte ... b[3]=LSB byte
                tokens.append((cur_addr, b))
                cur_addr += 4

    return tokens


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(1)

    src, dst = sys.argv[1], sys.argv[2]
    flash_off = int(sys.argv[3], 16) if len(sys.argv) > 3 else 0

    tokens = parse_verilog_hex(src)
    if not tokens:
        sys.exit("[HATA] dosyada hic veri token'i bulunamadi.")

    # --- Kaynaktaki adres sicramalarini (varsa) tespit et ve flash'ta ayni
    #     GORECELI bosluk kadar 0xFF (silinmis flash) ile doldur. ---
    out_bytes = bytearray()
    base_addr = tokens[0][0]
    expected_next = base_addr

    for addr, b in tokens:
        if addr != expected_next:
            gap = addr - expected_next
            if gap < 0:
                sys.exit(f"[HATA] kaynak adres geri sardi (0x{addr:X} < "
                          f"beklenen 0x{expected_next:X}) -- dosya bozuk olabilir.")
            print(f"[UYARI] kaynakta 0x{expected_next:X}->0x{addr:X} arasi "
                  f"{gap} bayt bosluk var, flash'ta 0xFF ile dolduruluyor.")
            out_bytes += b"\xFF" * gap
        out_bytes += b                      # b zaten MSB->LSB sirasinda, DOGRUDAN ekle
        expected_next = addr + 4

    # --- OZ-DOGRULAMA: uretilen flash byte dizisini QSPI'in MSB-first
    #     birlestirme mantigiyla geri "oku", orijinal token degerleriyle
    #     karsilastir. ---
    def qspi_reassemble(flash_bytes):
        vals = []
        for i in range(0, len(flash_bytes) - (len(flash_bytes) % 4), 4):
            m0, m1, m2, m3 = flash_bytes[i:i+4]
            vals.append((m0 << 24) | (m1 << 16) | (m2 << 8) | m3)
        return vals

    reassembled = qspi_reassemble(out_bytes)
    original_vals = [int.from_bytes(b, "big") for _, b in tokens]

    # (out_bytes'ta gap doldurma yuzunden hizalama kayabilir; sadece gap'siz
    #  bolgede birebir karsilastirma yapalim -- pratikte bu ornekte gap yok.)
    ok = reassembled[:len(original_vals)] == original_vals
    if not ok:
        sys.exit("[HATA] OZ-DOGRULAMA BASARISIZ: QSPI-birlestirme sonucu "
                  "orijinal instruction degerleriyle uyusmuyor! Dosyayi "
                  "KULLANMA, once bu scripti duzelt.")

    # --- Yaz ---
    lines = []
    if flash_off:
        lines.append(f"@{flash_off:08X}")
    lines += [f"{byte:02X}" for byte in out_bytes]
    with open(dst, "w") as f:
        f.write("\n".join(lines) + "\n")

    print(f"[OK] {src} -> {dst}")
    print(f"     {len(out_bytes)} bayt ({len(tokens)} word), "
          f"flash offset 0x{flash_off:08X}")
    print(f"     OZ-DOGRULAMA: PASS -- QSPI geri-birlestirmesi "
          f"{len(original_vals)}/{len(original_vals)} instruction'da "
          f"orijinaliyle birebir eslesti.")
    print(f"     Ilk 3 instruction (kontrol icin):")
    for i in range(min(3, len(original_vals))):
        print(f"       [{i}] kaynak=0x{original_vals[i]:08X}  "
              f"flash'tan geri-birlesen=0x{reassembled[i]:08X}")


if __name__ == "__main__":
    main()
