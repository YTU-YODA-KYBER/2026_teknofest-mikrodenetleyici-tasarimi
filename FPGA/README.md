# FPGA — Mikrodenetleyici Tasarımı

**YTU YODA KYBER — TEKNOFEST 2026 Çip Tasarım Yarışması**

TEKNOFEST 2026 Çip Tasarım Yarışması (Mikrodenetleyici Kategorisi) için
geliştirilen, **RISC-V CV32E40P** çekirdekli ve yapay zekâ hızlandırıcılı
SoC tasarımının çalışma dosyaları.

Hedef kart **Nexys A7** (`xc7a100tcsg324-1`), sistem saati **50 MHz**.
Bu klasördeki akış tamamen **Xilinx Vivado** tabanlıdır. Proje GUI üzerinden
oluşturulabildiği gibi final sentez/implementasyon akışı batch betiğiyle de
tek komutta çalıştırılabilir.

---

## Klasör yapısı

```
FPGA/
├── main_codes/        → MCU tasarımının tamamı (RTL) + testbench'ler
├── firmware/          → İşlemci üzerinde koşan bare-metal yazılım (C / asm)
├── scripts/           → Vivado proje kurulum scriptleri + YZ araç zinciri
├── verification/      → Doğrulama kanıtları (Vivado raporları, YZ ölçümleri)
├── Vivado_projects/   → Scriptlerin ürettiği Vivado projeleri (üretilen çıktı)
└── bitstream_files/   → Karta yüklenen bitstream (`fpga_top.bit`)
```

`firmware/`, `scripts/` ve `verification/` klasörlerinin kendi `README.md`'si
vardır; o klasöre özel ayrıntılar için oraya bakınız.

---

## `main_codes/`

MCU'nun **ana RTL kodları** ve onları doğrulayan testbench'ler.

| Alt klasör | İçerik |
|---|---|
| `rtl/desgin_sources/CPU/` | CV32E40P RISC-V çekirdeği + OBI↔AXI köprüsü |
| `rtl/desgin_sources/Interconnect/` | AXI4 ara bağlantı, komut (instruction) ayırıcı |
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
| `testbench/uvm/` | Yedi AXI4-Lite bloğunun UVM doğrulama ortamı (ortak agent, register modelleri, karşı taraf agent'ları, regresyon ve kapsam betikleri) |
| `testbench/cv32e40p/` | Çekirdeğin tek başına testi (`tb_soc.sv`) |
| `constraint/` | `nexys_a7_soc.xdc` (asıl kısıt dosyası), `cv32e40p_core.sdc`, eski `basys3_soc.xdc` |
| `ip/` | Vivado IP'leri (`clk_wiz_0`: 100 MHz → 50 MHz) |
| `only_app_code/` | Boot mekanizmasını atlayıp doğrudan uygulama koşturan üst modül varyantı |
| `for_FPU/` | Çekirdeğin FPU'lu (kayan nokta) varyantı için gereken RTL |

> Protokol kontrolcüsünün ayrıntıları:
> [`main_codes/testbench/AXI_protocol_check/README.md`](main_codes/testbench/AXI_protocol_check/README.md)
>
> UVM ortamının ayrıntıları:
> [`main_codes/testbench/uvm/README.md`](main_codes/testbench/uvm/README.md) —
> sonuçlar [`verification/uvm/`](verification/uvm/) altındadır.

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

Hangi `make` hedefinin neyi derlediği, kartın boot senaryosu (`SW0`/`SW1`
anahtarları) ve `send_data.py` komutları [`firmware/README.md`](firmware/README.md)
içinde anlatılır.

---

## `scripts/`

Vivado projesini sıfırdan kuran TCL scriptleri ve YZ doğrulama araç zinciri.

| Alt klasör / dosya | Ne işe yarar |
|---|---|
| `scripts/run_fpga_build.sh` | Firmware derlemesini ve Vivado batch final akışını tek komutta başlatır |
| `scripts/build_fpga.tcl` | Sentez, implementasyon, STA, kaynak, güç, DRC raporları ile bitstream'i üretir |
| `project_gen/Main_MCU_Project.tcl` | **Ana proje** — bütün tasarımı içeren Vivado projesini kurar |
| `project_gen/System_test/` | Sistem testleri: `boot_test.tcl`, `ai_accel_test.tcl`, `only_app_test.tcl`, `yz_bench_test.tcl` |
| `project_gen/CPU/`, `Interconnect/`, `Memory/`, `Peripherals/` | Tek bir bloğun RTL'i + testbench'ini içeren küçük projeler; hızlı iterasyon için |
| `wav_to_yz.py` | 1 saniyelik WAV kaydını YZ'nin beklediği 1960 baytlık girdiye çevirir |
| `yz_tflite/` | Modeli `.tflite`'tan çıkarır, RTL ağırlıklarıyla çapraz doğrular, iverilog ile hızlı RTL↔C kıyası yapar |
| `yz_accuracy/` | Etiketli ses kümesini karta gönderip donanım/yazılım doğruluk oranlarını kıyaslar |

**Kullanım** — Vivado'nun Tcl Console'unda iki adım:

```tcl
cd /.../FPGA/
source /.../FPGA/scripts/project_gen/Main_MCU_Project.tcl
```
>FPGA öncesini kendi dosya yoluna göre doldurmanız gerekmektedir.

Projeler `Vivado_projects/` altına açılır. Sistem testleri firmware hex'lerini
`firmware/makefile_outputs/` altından okuduğu için scripti çalıştırmadan önce
ilgili `make` hedefi koşturulmalıdır. Hangi script hangi hedefi ister:
[`scripts/README.md`](scripts/README.md).

Final sentez, implementasyon, STA, kaynak kullanımı, güç, DRC ve bitstream
çıktılarının tamamını temiz projeden yeniden üretmek için:

```bash
export VIVADO_ROOT=/kurulum/yolu/Vivado/2025.2
./scripts/run_fpga_build.sh
```

İsteğe bağlı `FPGA_JOBS` değişkeni Vivado iş parçacığı sayısını belirler;
varsayılan değer bellek kullanımını sınırlamak için `4`'tür. Raporlar
`verification/vivado_reports/`, bitstream ise `bitstream_files/` altına yazılır.

---

## `verification/`

Doğrulama kanıtları. Özet tablo [`verification/README.md`](verification/README.md)
içinde; sonuçların ayrıntısı alt klasörlerin kendi README'lerinde.

| Alt klasör | İçerik |
|---|---|
| `test_plan.md` | Blok, sistem, FPGA ve ASIC faaliyetlerini kapsayan üst seviye doğrulama planı |
| `vivado_reports/synthesis/` | Sentez raporu + kaynak kullanımı |
| `vivado_reports/implementation/` | Yerleştirme / yollama raporu |
| `vivado_reports/timing_report/` | 50 MHz kısıtına karşı zamanlama analizi |
| `vivado_reports/code_coverage/` | 6 çevre birimi + YZ hızlandırıcı için XSim kod kapsamı raporları (HTML) |
| `vivado_reports/testbench_&_protocol_check/` | Directed testbench koşumlarının ham çıktıları + 15 AXI arayüzünün protokol kontrol sonuçları |
| `ai_accel_reports/` | YZ hızlandırıcının bellek bütçesi, doğruluk ve hızlanma ölçümleri |
| `uvm/` | Bütün çevre birimleri ve hızlandırıcı için yapılan UVM test sonuçları ve kanıtları |
| `spike_iss/` Kullanılan cv32e40p çekirdeğinin 193 komutluk bir C kodu ile Spike ISS doğrulaması
---

## `Vivado_projects/` ve `bitstream_files/`

`Vivado_projects/` **üretilen çıktıdır** — TCL scriptleri çalıştırıldığında
oluşur, elle düzenlenmez. `bitstream_files/fpga_top.bit` karta yüklenebilir güncel
bitstream'dir. İsterseniz ana vivado projesi üzerinden kendiniz de oluşturabilirsiniz.

---
