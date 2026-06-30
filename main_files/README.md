# YTU YODA KYBER — Mikrodenetleyici Tasarımı

TEKNOFEST 2026 Çip Tasarım Yarışması (Mikrodenetleyici Kategorisi) için
geliştirilen, **RISC-V CV32E40P** çekirdekli ve yapay zekâ hızlandırıcılı
SoC tasarımının ana çalışma dosyaları.

Bu klasör dört bölümden oluşur. Aşağıda her birinin ne içerdiği ve ne işe
yaradığı yazılı. Her alt klasörün kendi `README.md`'si de var; o klasöre özel
detaylar için oraya bak.

---

## Klasör yapısı

```
main_files/
├── firmware/      → İşlemci üzerinde koşacak yazılım ile ilgili kodlar (C / asm)
├── main_codes/    → Donanım tasarımının tamamı (RTL) + testbench'ler
├── scripts/       → Vivado projesini sıfırdan kuran TCL scriptleri
└── teknotest/     → TEKNOFEST resmi test (DDK) ortamı ve teslim paketi
```

---

## `firmware/`

İşlemcinin çalıştırdığı **bare-metal yazılım**. Çevre birimlerini (Timer,
GPIO, UART, I2C, QSPI) kullanan uygulamalar, başlangıç kodu ve derleme akışı
burada.

İçindekiler:
- Başlangıç ve bellek: `boot.S`, `linker.ld`, `linker_app.ld`, `soc.h`
- Uygulamalar: `main.c` (bootloader), `app_main.c` (çevre birimi testleri),
  `circle.c` (LED demosu), `qspi_flash_test.c` (flash yaz/oku testi)
- Derleme: `Makefile`

> Hangi `make` komutunun neyi derlediği `firmware/README.md` içinde anlatılıyor.

---

## `main_codes/`

Çipin **donanım tasarımının tamamı** — yani sentezlenen RTL kodu ve onu
doğrulayan testbench'ler. Projenin kalbi burası.

| Alt klasör | İçerik |
|---|---|
| `rtl/desgin_sources/CPU/` | CV32E40P RISC-V çekirdeği + OBI↔AXI köprüsü |
| `rtl/desgin_sources/Interconnect/` | AXI4 ara bağlantı ve komut (instruction) ayırıcı |
| `rtl/desgin_sources/Memory/` | Boot ROM, Data RAM, Instruction RAM — AXI4-Lite sarmalayıcılarıyla |
| `rtl/desgin_sources/Peripherals/` | GPIO, I2C, QSPI, Timer, UART (genel + YZ akışı) çevre birimleri |
| `rtl/desgin_sources/AI_Accelerator/` | Yapay zekâ hızlandırıcısı: konvolüsyon/FC katmanları, ağırlık-bias hex'leri, UART girişi |
| `rtl/desgin_sources/Top_Module/` | Tüm blokları birleştiren üst modül + `fpga_top.sv` |
| `testbench/` | Çevre birimi, AI hızlandırıcı ve sistem seviyesi testbench'ler (QSPI için Micron flash modeli dahil) |
| `constraint/` | Basys3 kartı için constraint (.xdc) dosyası |
| `ip/` | Vivado IP'leri (clock wizard) |
| `for_FPU/` | Çekirdeğin FPU'lu (kayan nokta) varyantı için gerekli RTL kodları |

> Detaylı modül açıklamaları için `main_codes/README.md`.

---

## `scripts/`

Vivado projesini **sıfırdan, otomatik kuran TCL scriptleri**. Repoyu klonlayan
biri tek script ile bütün blokları (CPU, interconnect, bellekler, çevre
birimleri) içeren projeyi oluşturabilir; kaynak dosyaları elle eklemekle
uğraşmaz.

İçindekiler:
- `TEKNOFEST_MCU_Project.tcl` — ana proje kurulum scripti (asıl çalıştırılan bu)
- `CPU/`, `Interconnect/`, `Memory/`, `Peripherals/` — her bloğu tek tek
  oluşturan yardımcı scriptler

> Kullanım sırası ve detayları `scripts/README.md` içinde.

---

## `teknotest/`

TEKNOFEST'in sağladığı **resmi test/doğrulama (DDK) ortamı** ve yarışmaya
teslim edilen paket. Tasarımın, yarışmanın standart test düzeneğine entegre
edilmiş hâli burada bulunur.

İçindekiler:
- `rtl/` — tasarımın test ortamına paketlenmiş RTL kopyası + `teknotest_wrapper.sv`
- `teknotest/sw/` — test yazılımı: `helloworld.c`, `crt0.S`, derleme scriptleri
  (`build.py`, `elf_to_mem.py`) ve üretilen çıktılar (`.elf`, `.mem`, `.dis` …)
- `teknotest/tb/` — resmi testbench (`teknotest_tb.sv`)
- `teknotest/scripts/` — Vivado proje oluşturma scripti
- `teknotest/user_files/` — yarışmanın istediği standart dosyalar: `bootrom.ld`,
  `rv_toolchain.conf`, `user_defines.h`, kullanıcı wrapper'ı ve derleme scripti

> Sistemimiz "Hello World!" UART testini başarıyla geçmektedir.

---

> **Not:** Çevre birimleri, OBI→AXI wrapper ve AXI4 interconnect kodları
> (testbench'ler dahil) tamamen YODA KYBER takımı tarafından yazılmıştır;
> hiçbir açık kaynak repo ya da yapay zekâ üretimi kod kullanılmamıştır.
> Yapay zekâdan yalnızca öğrenme ve hata ayıklama sürecinde destek alınmıştır.
