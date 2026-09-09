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
- **Çevre birimleri:** GPIO, Timer, I2C Master, QSPI Master, iki UART — genel kullanım (115200, sonuç çıkışı) ve
  YZ veri akışı (1 Mbps, 1960 baytlık çıkarım vektörü)
- **Yapay zekâ hızlandırıcısı:** TFlite micro speech modelinin RTL gerçeklemesi. Konvolüsyon + tam bağlı katmanlarla anahtar
  kelime tanıma (sessizlik / bilinmeyen / evet / hayır). Softmax katmanı kesme
  servisinde uygulanır; sonuç satırı sınıfla birlikte dört sınıf skorunu da taşır
- **İki boot modu:** **1.** Boot ROM'daki bootloader → QSPI flash'tan uygulamayı
  Instruction RAM'e yükler → çalıştırır. **2.** UART üzerinden bilgisayardan aldığı verileri QSPI modülü ile harici flash belleğe yazar.
- **Kapsamlı doğrulama:** Her çevre birimi, hızlandırıcı ve genel MCU için testbench'ler,
  15 AXI arayüzüne bağlanan protokol kontrolcüsü, kod kapsamı raporları, UVM ve Spike ISS ile çekirdek doğrulaması.
- **Kolay kurulum:** Vivado projesini sıfırdan oluşturan TCL scriptleri.

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
        │     AXI4 Interconnect    │
        └─┬───┬───┬───┬───┬───┬───┬┘
          │   │   │   │   │   │   │
       Boot Instr Data GPIO Tim UART  ... I2C / QSPI / YZ Hızlandırıcı
        ROM  RAM  RAM        er
```

**Boot akışı:** Açılış → CPU Boot ROM'dan bootloader'ı koşar → bootloader
uygulamayı QSPI flash'tan Instruction RAM'e kopyalar → uygulamaya atlar → çalışır.

---

## Depo yapısı

```
┌── FPGA/      → Asıl tasarım: RTL, firmware, Vivado scriptleri, doğrulama raporları
├── asic_rtl/  → Yalnızca ASIC'e özgü RTL (SRAM sarmalayıcıları, mask ROM'lar, yamalar)
├── asic/      → ASIC fiziksel tasarım akışı: LibreLane + SKY130, raporlar, GDSII
└── LICENSE
```

> Her klasördeki dosyaların detaylı açıklamaları ve varsa kullanım şekilleri ilgili klasördeki README metinlerinde bulunmaktadır.

Tasarımın kaynağı [`FPGA/`](FPGA/) altındadır:

| Klasör | İçerik |
|---|---|
| [`FPGA/main_codes/`](FPGA/main_codes/) | MCU tasarımının tamamı (RTL) + testbench'ler |
| [`FPGA/firmware/`](FPGA/firmware/) | İşlemcinin koşturduğu bare-metal yazılım (C / asm) |
| [`FPGA/scripts/`](FPGA/scripts/) | Vivado proje kurulum scriptleri + Hızlandırıcı ile ilgili test dosyaları |
| [`FPGA/verification/`](FPGA/verification/) | Yapılan doğrulamaların detaylı açıklamaları ve kanıtları |
| `FPGA/Vivado_projects/` | Scriptlerin çalıştırıldığında oluşturduğu, Git'e alınmayan Vivado projeleri |
| [`FPGA/bitstream_files/`](FPGA/bitstream_files/) | Nexys A7 100T karta yüklenebilen bitstream (`fpga_top.bit`) |

Klasörlerin ayrıntılı dökümü [`FPGA/README.md`](FPGA/README.md) içinde;
`firmware/`, `scripts/` ve `verification/` klasörlerinin de kendi README'si vardır.

Aynı SoC'nin ASIC'e dönüştürülmüş hâli iki klasördedir. Teknolojiye bağlı farklar
[`asic_rtl/`](asic_rtl/) altında ayrı dosyalar olarak durur ve akış hangi dosyayı
kullanacağını `asic/filelist.f` ile seçer.

| Klasör | İçerik |
|---|---|
| [`asic_rtl/mem/`](asic_rtl/mem/) | FPGA BRAM'lerinin yerine geçen SKY130 SRAM makro sarmalayıcıları |
| [`asic_rtl/gen/`](asic_rtl/gen/) | Boot ROM ve YZ ağırlık ROM'ları — üretilmiş mask ROM RTL'i |
| [`asic_rtl/patched/`](asic_rtl/patched/) | Üretilmiş yamalı kopyalar (sürülmeyen sinyaller, YZ MAC boru hattı) |
| [`asic_rtl/tech/`](asic_rtl/tech/) | Xilinx `IOBUF` primitifinin teknolojiden bağımsız karşılığı |
| [`asic_rtl/testbench/`](asic_rtl/testbench/) | ASIC belleklerinin eşdeğerlik testi |

Akışın kendisi [`asic/`](asic/) altındadır:

| Klasör / dosya | İçerik |
|---|---|
| [`asic/config.yaml`](asic/config.yaml) · [`asic/filelist.f`](asic/filelist.f) | LibreLane yapılandırması ve ASIC akışında derlenen RTL listesi |
| [`asic/constraints/`](asic/constraints/) | Zamanlama kısıtları (`design.sdc`) ve SRAM makro yerleşimi |
| [`asic/macros/`](asic/macros/) | Kullanılan SKY130 SRAM makrolarının GDSII/LEF/Liberty/Verilog/SPICE görünümleri |
| [`asic/reports/`](asic/reports/) | Lint, sentez, fiziksel tasarım, zamanlama, DRC, LVS, anten, güç ve IR-drop raporları |
| [`asic/results/`](asic/results/) | Nihai çıktılar: **GDSII**, LEF, DEF, netlistler, SDC, SPEF, SPICE |
| [`asic/scripts/`](asic/scripts/) · [`asic/Makefile`](asic/Makefile) | Akışı baştan sona çalıştıran otomasyon (`make asic_run`) |

Ayrıntılar, kullanılan araç sürümleri ve signoff sonuçları
[`asic/README.md`](asic/README.md) içinde.

---

## FPGA Üzerinde Hızlı başlangıç

**Detaylı açıklama için:** [`FPGA/firmware/README.md`](FPGA/firmware/README.md)

**1. Yazılımı derle:**
```bash
cd FPGA/firmware/
make all          # bootloader (boot.hex) + uygulama (app.hex)
```
Derleme hedeflerinin tamamı [`FPGA/firmware/README.md`](FPGA/firmware/README.md) içinde anlatılmıştır.

**2. Donanım projesini oluştur (Vivado Tcl Console):**
```tcl
cd /.../FPGA/
source /.../FPGA/scripts/project_gen/Main_MCU_Project.tcl
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
| Sentez + implementasyon | hatasız, 14901/14901 net yollandı |
| Zamanlama (50 MHz) | WNS **+0,174 ns**, WHS +0,037 ns, 0 ihlal |
| Kaynak kullanımı | LUT %15,69 · FF %3,72 · BRAM %11,11 · DSP %2,50 |
| Kod kapsamı | 6 çevre birimi + YZ hızlandırıcı, statement %91–100 |
| AXI4-Lite protokol kontrolü | 15 arayüz, **0 ihlal** |
| YZ hızlanma | **276,9×** (yazılım gerçeklemesine kıyasla) |
| YZ doğruluk | donanım %91,03 · yazılım %91,03 → fark **0,00 puan** |
| YZ bellek bütçesi | 30.720 B (sınır 30 KB) |
| ASIC fiziksel tasarım | LibreLane 3.0.6 + SKY130A, 15 SRAM makrosu — [`asic/`](asic/) |

Çevre birimlerinin her biri kendi directed testbench'i ile, sistem ise boot,
uygulama ve YZ senaryolarını koşturan sistem testleri ile doğrulandı.
**UVM** regresyonu 219/219 koşumla, **Spike ISS** lockstep doğrulaması ise
193/193 komut eşleşmesiyle tamamlandı; ayrıntılı kanıtlar
[`FPGA/verification/`](FPGA/verification/) altındadır.

---

Bu tasarım **YTU YODA KYBER** takımı tarafından geliştirilmiştir.

> Yapay zekâdan yalnızca öğrenme ve hata ayıklama sürecinde destek alınmıştır.
