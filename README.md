# 2026 TEKNOFEST — Mikrodenetleyici Tasarımı

**YTU YODA KYBER** takımının TEKNOFEST 2026 Çip Tasarım Yarışması
(Mikrodenetleyici Kategorisi) için sıfırdan geliştirdiği, **RISC-V tabanlı
ve yapay zekâ hızlandırıcılı** bir Sistem-on-Chip (SoC) tasarımı.

> Tasarım **CV32E40P** RISC-V çekirdeği etrafına kuruldu; çekirdeği AXI4
> ara bağlantı üzerinden bellekler, çevre birimleri ve bir yapay zekâ
> hızlandırıcısı ile birleştirip Nexys A7 FPGA üzerinde çalışır hâle getirdik.

`SystemVerilog · Verilog · Tcl` &nbsp;|&nbsp; Hedef: **Nexys A7 (Artix-7)** @ 50 MHz

---

## Bu proje ne yapıyor?

Tek cümleyle: **kendi çevre birimlerini, kendi ara bağlantısını ve bir yapay
zekâ hızlandırıcısını barındıran, üzerinde bare-metal yazılım koşan tam bir
mikrodenetleyici** tasarladık ve FPGA'de çalıştırdık.

Sistem açıldığında çekirdek, Boot ROM'daki bootloader'ı koşturur; bootloader
uygulama yazılımını QSPI flash'tan okuyup komut belleğine (Instruction RAM)
kopyalar ve oraya atlar. Uygulama da çevre birimlerini (UART, Timer, GPIO,
I2C, QSPI) ve yapay zekâ hızlandırıcısını kullanarak işini yapar.

---

## Öne çıkanlar

- **CV32E40P RISC-V çekirdeği** (RV32IMC + Zicsr/Zifencei), opsiyonel FPU varyantı
- **Bellekler:** Boot ROM, Instruction RAM, Data RAM, YZ RAM (hepsi AXI4-Lite sarmalı)
- **Çevre birimleri:** GPIO, Timer, I2C Master, QSPI Master, iki UART
  (genel kullanım + YZ veri akışı)
- **Yapay zekâ hızlandırıcısı:** konvolüsyon + tam bağlı katmanlarla anahtar
  kelime tanıma (sessizlik / bilinmeyen / evet / hayır)
- **İki katmanlı boot:** Boot ROM'daki bootloader → QSPI flash'tan uygulamayı
  Instruction RAM'e yükler → çalıştırır
- **Kapsamlı doğrulama:** her çevre birimi ve sistem seviyesi için testbench'ler,
  15 AXI arayüzüne bağlanan protokol kontrolcüsü, kod kapsamı raporları
- **Tek tıkla kurulum:** Vivado projesini sıfırdan oluşturan TCL scriptleri

---

## Mimari (genel akış)

```
            ┌──────────────────┐
            │   CV32E40P CPU   │   (RISC-V, RV32IMC)
            └────────┬─────────┘
                     │ OBI
            ┌────────▼─────────┐
            │  OBI → AXI köprü │  + komut ayırıcı
            └────────┬─────────┘
                     │ AXI4
        ┌────────────▼─────────────┐
        │     AXI4 Interconnect     │
        └─┬───┬───┬───┬───┬───┬───┬─┘
          │   │   │   │   │   │   │
       Boot Instr Data GPIO Tim UART  ... I2C / QSPI / YZ Hızlandırıcı
        ROM  RAM  RAM        er
```

**Boot akışı:** Açılış → CPU Boot ROM'dan bootloader'ı koşar → bootloader
uygulamayı QSPI flash'tan Instruction RAM'e kopyalar → uygulamaya atlar → çalışır.

---

## Depo yapısı

```
mainfiles/
├── FPGA/     → Asıl tasarım: RTL, firmware, Vivado scriptleri, doğrulama raporları
├── ASIC/     → ASIC akışı için ayrılmış klasör (şu an boş)
└── LICENSE
```

Bütün çalışma dosyaları [`FPGA/`](FPGA/) altındadır:

| Klasör | İçerik |
|---|---|
| [`FPGA/main_codes/`](FPGA/main_codes/) | Donanım tasarımının tamamı (RTL) + testbench'ler |
| [`FPGA/firmware/`](FPGA/firmware/) | İşlemcinin koşturduğu bare-metal yazılım (C / asm) |
| [`FPGA/scripts/`](FPGA/scripts/) | Vivado proje kurulum scriptleri + YZ araç zinciri |
| [`FPGA/verification/`](FPGA/verification/) | Doğrulama kanıtları: sentez, zamanlama, kod kapsamı, YZ ölçümleri |
| [`FPGA/Vivado_projects/`](FPGA/Vivado_projects/) | Scriptlerin ürettiği Vivado projeleri (üretilen çıktı) |
| [`FPGA/bitstream_files/`](FPGA/bitstream_files/) | Karta yüklenen bitstream (`fpga_top.bit`) |

Klasörlerin ayrıntılı dökümü [`FPGA/README.md`](FPGA/README.md) içinde;
`firmware/`, `scripts/` ve `verification/` klasörlerinin de kendi README'si vardır.

---

## Hızlı başlangıç

**1. Yazılımı derle:**
```bash
cd FPGA/firmware/
make all          # bootloader (boot.hex) + uygulama (app.hex)
```
Derleme hedeflerinin tamamı [`FPGA/firmware/README.md`](FPGA/firmware/README.md) içinde.

**2. Donanım projesini oluştur (Vivado Tcl Console):**
```tcl
cd /.../mainfiles/FPGA/
source /.../mainfiles/FPGA/scripts/project_gen/Main_MCU_Project.tcl
```
Bu, tüm tasarımı içeren Vivado projesini otomatik kurar. Tekil blokları ayrı
denemek için `scripts/project_gen/` altındaki diğer scriptler kullanılır
(bkz. [`FPGA/scripts/README.md`](FPGA/scripts/README.md)).

**3. Karta yükle:** Vivado'da `Generate Bitstream` → `Program Device`.
Uygulamayı flash'a yazma ve YZ'ye ses gönderme adımları
[`FPGA/firmware/README.md`](FPGA/firmware/README.md) içinde.

---

## Doğrulama

Ölçüm sonuçlarının tamamı ve raporlar: [`FPGA/verification/`](FPGA/verification/)

| Doğrulama | Sonuç |
|---|---|
| Sentez + implementasyon | hatasız, 14575/14575 net yollandı |
| Zamanlama (50 MHz) | WNS **+0,564 ns**, 0 ihlal |
| Kaynak kullanımı | LUT %15,76 · FF %3,56 · BRAM %14,07 · DSP %2,50 |
| Kod kapsamı | 6 çevre birimi + YZ hızlandırıcı, statement %91–100 |
| AXI4-Lite protokol kontrolü | 15 arayüz, **0 ihlal** |
| YZ hızlanma | **276,9×** (yazılım gerçeklemesine kıyasla) |
| YZ doğruluk | donanım %91,03 · yazılım %91,03 → fark **0,00 puan** |
| YZ bellek bütçesi | 30.720 B (sınır 30 KB) |

Çevre birimlerinin her biri kendi directed testbench'i ile, sistem ise boot,
uygulama ve YZ senaryolarını koşturan sistem testleri ile doğrulandı.
**UVM** ve **Spike ISS** doğrulamaları planlanmıştır.

---

Bu tasarım **YTU YODA KYBER** takımı tarafından geliştirilmiştir.

> Çevre birimleri, OBI→AXI wrapper ve AXI4 interconnect kodları (testbench'ler
> dahil) **tamamen takım tarafından yazılmıştır**; hiçbir açık kaynak repo ya da
> yapay zekâ tarafından üretilmiş kod kullanılmamıştır. Yapay zekâdan yalnızca
> öğrenme ve hata ayıklama sürecinde destek alınmıştır.
