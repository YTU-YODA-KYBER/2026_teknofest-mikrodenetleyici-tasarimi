# FPGA — Mikrodenetleyici Tasarımı

**YTU YODA KYBER — TEKNOFEST 2026 Çip Tasarım Yarışması**

TEKNOFEST 2026 Çip Tasarım Yarışması (Mikrodenetleyici Kategorisi) için
geliştirilen, **RISC-V CV32E40P** çekirdekli ve yapay zekâ hızlandırıcılı
SoC tasarımının bütün çalışma dosyaları.

Hedef kart **Nexys A7** (`xc7a100tcsg324-1`), sistem saati **50 MHz**.
Akış tamamen **Xilinx Vivado** tabanlıdır; Makefile ya da CI ile sentez yapılmaz.

---

## Klasör yapısı

```
FPGA/
├── main_codes/        → Donanım tasarımının tamamı (RTL) + testbench'ler
├── firmware/          → İşlemci üzerinde koşan bare-metal yazılım (C / asm)
├── scripts/           → Vivado proje kurulum scriptleri + YZ araç zinciri
├── verification/      → Doğrulama kanıtları (Vivado raporları, YZ ölçümleri)
├── Vivado_projects/   → Scriptlerin ürettiği Vivado projeleri (üretilen çıktı)
└── bitstream_files/   → Karta yüklenen bitstream (`fpga_top.bit`)
```

`firmware/`, `scripts/` ve `verification/` klasörlerinin kendi `README.md`'si
vardır; o klasöre özel ayrıntılar için oraya bakılır.

---

## `main_codes/`

Çipin **sentezlenen RTL kodu** ve onu doğrulayan testbench'ler.

| Alt klasör | İçerik |
|---|---|
| `rtl/desgin_sources/CPU/` | CV32E40P RISC-V çekirdeği + OBI↔AXI köprüsü |
| `rtl/desgin_sources/Interconnect/` | AXI4 ara bağlantı, komut (instruction) ayırıcı, UART mux |
| `rtl/desgin_sources/Memory/` | Boot ROM, Instruction RAM, Data RAM, YZ RAM — AXI4-Lite sarmalayıcıları + `BRAM_defines/` |
| `rtl/desgin_sources/Peripherals/` | GPIO, Timer, I2C Master, QSPI Master, UART (genel + YZ akışı) |
| `rtl/desgin_sources/AI_Accelerator/` | YZ hızlandırıcı: konvolüsyon/FC katmanları, ağırlık-bias hex'leri, `yz_csr_wrapper.sv` |
| `rtl/desgin_sources/Top_Module/` | Tüm blokları birleştiren üst modül (`Top_module.sv`) |
| `rtl/desgin_sources/fpga_top.sv` | Kart sarmalayıcısı: `clk_wiz_0` + `top_module` |
| `rtl/include/` | Ortak `svh` başlıkları (AXI/OBI typedef'leri, assertion'lar) |
| `testbench/Peripherals/` | Her çevre birimi için ayrı testbench (QSPI'nınki Micron flash simülasyon modelini kullanır) |
| `testbench/System_Test/` | Sistem seviyesi testler: `boot_test.sv`, `ai_accel_test.sv`, `yz_bench_test.sv` |
| `testbench/AI_Accelerator/` | Hızlandırıcının tek başına testi (`tb_conv_accel.v`) |
| `testbench/AXI_protocol_check/` | AXI4-Lite protokol kontrolcüsü — `bind` ile 15 arayüze bağlanır |
| `testbench/cv32e40p/` | Çekirdeğin tek başına testi (`tb_soc.sv`) |
| `constraint/` | `nexys_a7_soc.xdc` (asıl kısıt dosyası), `cv32e40p_core.sdc`, eski `basys3_soc.xdc` |
| `ip/` | Vivado IP'leri (`clk_wiz_0`: 100 MHz → 50 MHz) |
| `only_app_code/` | Boot mekanizmasını atlayıp doğrudan uygulama koşturan üst modül varyantı |
| `for_FPU/` | Çekirdeğin FPU'lu (kayan nokta) varyantı için gereken RTL |

> Protokol kontrolcüsünün ayrıntıları:
> [`main_codes/testbench/AXI_protocol_check/README.md`](main_codes/testbench/AXI_protocol_check/README.md)

---

## `firmware/`

İşlemcinin koşturduğu **bare-metal yazılım** ve derleme akışı.

- **Uygulamalar:** `main_boot.c` (bootloader + flasher), `main_app.c` (asıl
  uygulama, YZ hızlandırıcı ISR'ları), `yz_bench.c` (hızlanma/doğruluk ölçüm
  programı), `circle.c` (LED demosu), `flasher_echo_test.c` (UART echo testi)
- **Başlangıç ve bellek:** `boot.S`, `linker.ld` (Boot ROM), `linker_app.ld`
  (Instruction RAM), `linker_bench.ld` (yalnız ölçüm programı için 32 KB/32 KB)
- **Donanım soyutlaması:** `soc.h` — bütün çevre birimi register'ları, bit
  alanları ve bellek haritası; `.c` dosyaları kendi adres tanımını yapmaz
- **Yazılım YZ modeli:** `yz_model/` — TFLite reference kernel'lerinin C portu
  (`tflite_ref.c`) + üretilmiş model verisi (`tflite_model_data.h`)
- **Derleme:** `Makefile` — bütün çıktılar `makefile_outputs/` altına yazılır,
  dosya adı hangi hedeften geldiğini gösterir (`boot.hex`, `app.hex`, `bench.hex`, …)
- **Yardımcılar:** `scripts/send_data.py` (karta UART ile uygulama/ses gönderimi),
  `sound_samples/` (referans YZ girdileri)

**Kullanım:**

```bash
cd firmware
make all          # boot.hex + app.hex
```

Hangi `make` hedefinin neyi derlediği, kartın boot senaryosu (`SW0`/`SW1`
anahtarları) ve `send_data.py` komutları [`firmware/README.md`](firmware/README.md)
içinde anlatılır.

---

## `scripts/`

Vivado projesini sıfırdan kuran TCL scriptleri ve YZ doğrulama araç zinciri.

| Alt klasör / dosya | Ne işe yarar |
|---|---|
| `project_gen/Main_MCU_Project.tcl` | **Ana proje** — bütün tasarımı içeren Vivado projesini kurar |
| `project_gen/System_test/` | Sistem testleri: `boot_test.tcl`, `ai_accel_test.tcl`, `only_app_test.tcl`, `yz_bench_test.tcl` |
| `project_gen/CPU/`, `Interconnect/`, `Memory/`, `Peripherals/` | Tek bir bloğun RTL'i + testbench'ini içeren küçük projeler; hızlı iterasyon için |
| `wav_to_yz.py` | 1 saniyelik WAV kaydını YZ'nin beklediği 1960 baytlık girdiye çevirir |
| `yz_tflite/` | Modeli `.tflite`'tan çıkarır, RTL ağırlıklarıyla çapraz doğrular, iverilog ile hızlı RTL↔C kıyası yapar |
| `yz_accuracy/` | Etiketli ses kümesini karta gönderip donanım/yazılım doğruluk oranlarını kıyaslar |

**Kullanım** — Vivado'nun Tcl Console'unda iki adım:

```tcl
cd /.../mainfiles/FPGA/
source /.../mainfiles/FPGA/scripts/project_gen/Main_MCU_Project.tcl
```

Projeler `Vivado_projects/` altına açılır. Sistem testleri firmware hex'lerini
`firmware/makefile_outputs/` altından okuduğu için scripti çalıştırmadan önce
ilgili `make` hedefi koşturulmalıdır. Hangi script hangi hedefi ister:
[`scripts/README.md`](scripts/README.md).

---

## `verification/`

Doğrulama kanıtları. Özet tablo [`verification/README.md`](verification/README.md)
içinde; sonuçların ayrıntısı alt klasörlerin kendi README'lerinde.

| Alt klasör | İçerik |
|---|---|
| `vivado_reports/synthesis/` | Sentez raporu + kaynak kullanımı |
| `vivado_reports/implementation/` | Yerleştirme / yollama raporu |
| `vivado_reports/timing_report/` | 50 MHz kısıtına karşı zamanlama analizi |
| `vivado_reports/code_coverage/` | 6 çevre birimi + YZ hızlandırıcı için XSim kod kapsamı raporları (HTML) |
| `ai_accel_reports/` | YZ hızlandırıcının bellek bütçesi, doğruluk ve hızlanma ölçümleri |

---

## `Vivado_projects/` ve `bitstream_files/`

`Vivado_projects/` **üretilen çıktıdır** — TCL scriptleri çalıştırıldığında
oluşur, elle düzenlenmez. `bitstream_files/fpga_top.bit` karta yüklenen son
bitstream'dir.

---

> **Not:** Çevre birimleri, OBI→AXI wrapper ve AXI4 interconnect kodları
> (testbench'ler dahil) tamamen YODA KYBER takımı tarafından yazılmıştır;
> hiçbir açık kaynak repo ya da yapay zekâ üretimi kod kullanılmamıştır.
> Yapay zekâdan yalnızca öğrenme ve hata ayıklama sürecinde destek alınmıştır.
