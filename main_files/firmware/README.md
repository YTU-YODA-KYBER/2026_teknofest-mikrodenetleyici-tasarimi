# Firmware — Derleme Komutları

Yapmak istediğini bul, karşısındaki komutu çalıştır. Hepsi bu.

> Not: `riscv32-unknown-elf-gcc` (toolchain) kurulu ve PATH'te olmalı.

---

## Kaynak dosyalar ne işe yarar?

| Dosya | Görevi |
|---|---|
| `main.c` | **Boot ROM kodu.** SW0'a göre dallanır: SW0=1 → **flasher** (UART'tan app'i alıp QSPI flash'a yazar + doğrular), SW0=0 → **boot** (flash'tan app'i okuyup DMA ile INSTRRAM'e yazar, `0x10000000`'a atlar). |
| `circle.c` | **Uygulama (app).** Flash'a yazılıp INSTRRAM'e boot edilen LED animasyon demosu. |
| `flasher_echo_test.c` | UART echo testi (baud + TX/RX doğrulaması için, Boot ROM'da koşar). |
| `boot.S` | Reset vektörü / crt0: sp kurulumu, `.data`/`.bss`, `main` çağrısı. |
| `linker.ld` | Boot ROM yerleşimi (`0x00000000`). |
| `linker_app.ld` | Uygulama yerleşimi (INSTRRAM, `0x10000000`). |
| `soc.h` | Donanım soyutlama başlığı (register/adres tanımları). |
| `hex2vmf.py` | `firmware.hex` → `mem_Q512.vmf` (Micron flash sim modeli için). |

---

## Gerçek donanım (FPGA / Nexys A7)

| İstediğin | Komut |
|---|---|
| Her şeyi derle (Boot ROM + uygulama) | `make` |
| Boot ROM (flasher + boot) | `make main` |
| Uygulama (circle) | `make app` |
| UART echo testi | `make echo` |

## Simülasyon

| İstediğin | Komut |
|---|---|
| Boot ROM'u sim için derle (erase kapalı) | `make sim_main` |
| Uygulamayı sim için derle | `make sim_app` |
| Flash imajı üret (app → mem_Q512.vmf) | `make flash_vmf` |
| Flash imajı üret (sim app'ten) | `make sim_flash_vmf` |

> **Neden ayrı sim hedefleri var?**
> - `sim_main`: flasher'ın erase adımını atlar (`-DFLASHER_NO_ERASE`). Gerçek flash silme sim'de çok yavaş; sim'de flash zaten 0xFF (silinmiş) başlar.
> - `sim_app`: `circle.c`'deki gecikme döngülerini kısaltır (`-DSIMULATION`) ki animasyon sim'de hızlı ilerlesin.

## Diğer

| İstediğin | Komut |
|---|---|
| Boyut raporu (main + app) | `make size` |
| Boot ROM disassembly | `make disasm_main` |
| Uygulama disassembly | `make disasm_app` |
| Üretilen klasörleri sil | `make clean` |

---

## Çıktılar

İlgili `build_*/` klasörüne yazılır:

| Dosya | Ne işe yarar |
|---|---|
| `build_main/firmware.hex` | Boot ROM'a yüklenir (bitstream INIT / testbench `$readmemh`). HW build, erase **açık**. |
| `build_main_sim/firmware.hex` | Aynısı, sim build (erase **kapalı**). |
| `build_app/firmware.hex` | Uygulama hex'i (`hex2vmf.py` girdisi). |
| `build_app/app.bin` | Gerçek QSPI flash'a harici programlayıcı ile yazmak için. |
| `build_app/mem_Q512.vmf` | Sim'de Micron flash modeline yüklenen imaj (`make flash_vmf` üretir). |

`make clean` tüm `build_*` klasörlerini (`build_main`, `build_main_sim`, `build_app`, `build_app_sim`, `build_echo`) siler — elle temizlik gerekmez.

---

## Tipik akışlar

**Gerçek karta yükleme:**
```
make main          # Boot ROM'u bitstream'e göm (erase açık)
make app           # circle app'i derle -> app.bin
```
Sonra: bitstream'i karta yükle, SW0=1 ile app'i UART'tan flash'a yaz, SW0=0 + reset ile boot et.

**Simülasyonda tam sistem testi:**
```
make sim_main      # Boot ROM (erase kapalı)
```
`build_main_sim/firmware.hex`'i testbench'in Boot ROM'una ver. (Flasher yazma testinde `mem_Q512.vmf` dizinde **olmasın** — flash 0xFF başlamalı. Boot okuma testinde `make flash_vmf` ile üretilen `mem_Q512.vmf`'i dizine koy.)
