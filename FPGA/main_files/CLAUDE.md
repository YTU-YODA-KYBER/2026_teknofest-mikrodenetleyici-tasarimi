# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Proje

YTU YODA KYBER takımının TEKNOFEST 2026 Çip Tasarım Yarışması (Mikrodenetleyici)
için geliştirdiği SoC: **RISC-V CV32E40P** çekirdeği + AXI4-Lite çevre birimleri +
konuşma tanıma YZ hızlandırıcısı. Akış tamamen **Xilinx Vivado** tabanlıdır
(hedef kart: Nexys A7 / `xc7a100tcsg324-1`); Makefile veya CI ile sentez yapılmaz.
Git deposu değildir. Dokümantasyon ve kod yorumları Türkçedir — aynı dilde devam et.

Projeler `Vivado_projects/` altına açılır. Blok scriptleri (`CPU/`, `Interconnect/`,
`Memory/`, `Peripherals/`) sadece o bloğun RTL'i + testbench'ini içeren küçük
projeler kurar; hızlı iterasyon için bunları kullan.

Doğrulama kanıtları `verification/` altındadır: `vivado_reports/` (sentez,
implementasyon, zamanlama, kaynak kullanımı, kod kapsamı) ve `ai_accel_reports/`
(YZ doğruluk + hız ölçümleri). Özet tablo `verification/README.md`'dedir; ileride
UVM ve Spike ISS sonuçları da oraya eklenecek.

### AXI protokol kontrolü (`main_codes/testbench/AXI_protocol_check/`)


### Kart üzerinde çalıştırma

`send_data.py` (`firmware/scripts/`) hem uygulama flash'lama (`send_data.py app` →
`makefile_outputs/app.hex`, LENGTH + 256 baytlık chunk + `0x06` ACK protokolü) hem YZ
ses verisi gönderme (`send_data.py yes|no|sessizlik`) için kullanılır; port/baud
dosyanın başında sabit (`/dev/ttyUSB1`, 115200) ve UART RTL'indeki baud ile eşleşmeli
(`--port`/`--baud` ile ezilebilir). YZ girişi tam **1960 bayt** olmalı
(`firmware/sound_samples/input_data_{yes,no,sessizlik}.hex`).

Boot senaryosu: `SW0=1` + reset → flasher (UART'tan app'i alıp QSPI flash'a yazar,
7-segment "boot"), `SW0=0` + reset → flash'tan okuyup INSTRRAM'e yazar ve
`0x10000000`'a atlar. `SW1=1` → YZ-UART modu.

Çıkarım sonucu 7-segment'in yanı sıra UART'tan da PC'ye döner (`main_app.c: yz_report()`
→ `"YZ:B\n"` = çıkarım başladı, `"YZ:0".."YZ:3"` = sınıf); `send_data.py` bu cevabı bekler
(`--no-wait` ile kapatılır). TX **UART_YZ'den** gider — `UART_mux.sv` (modül adı
`uart_mux`) fiziksel TX pinini
`GPIO_IDR[1:0]` ile seçer (1 = genel UART, 2 = UART_YZ), yani YZ modunda genel UART'a
yazılan bayt pine hiç ulaşmaz.

RX ise mux değil **fan-out**: genel UART her modda dinler, UART_YZ yalnızca
`GPIO_IDR[1:0]==2` iken. Bu sayede tek gönderim iki yolu birden besler — DMA
YZ RAM'i doldururken CPU aynı baytları genel UART'tan okuyabilir. YZ RAM'in CPU
portu olmadığı için yazılım gerçeklemesinin aynı örneği görmesinin tek yolu budur.

## Mimari

Veri akışı: **CV32E40P (OBI)** → `cv32e40p_obi_to_axi_wrapper` → `Instruction_Splitter`
(instruction/data yollarını ayırır) → `AXI4_Interconnect` → AXI4-Lite slave'ler.
Tüm çevre birimleri ve bellek sarmalayıcıları AXI4-Lite konuşur; adres kod çözme
tek yerde, `AXI4_Interconnect.sv` içindeki `sel_*` assign'larındadır — yeni slave
eklerken burası ve `Top_module.sv` birlikte güncellenir.

### Bellek haritası (interconnect + `firmware/soc.h` — ikisi tutarlı kalmalı)

| Adres | Blok |
|---|---|
| `0x0000_0000` | Boot ROM (1 KB, `boot.hex` ile `$readmemh`) |
| `0x1000_0000` | Instruction RAM (8 KB) |
| `0x1F00_0000` | `mtvec` (trap vektörü) |
| `0x2000_0000` | Data RAM (8 KB) |
| `0x4000_0000` | Timer |
| `0x4001_0000` | GPIO |
| `0x4002_0000` | I2C Master |
| `0x4003_0000` | QSPI Master |
| `0x4004_0000` | UART (genel kullanım) |
| `0x4005_0000` | UART_YZ (YZ veri akışı) |
| `0x4006_0000` | YZ RAM / hızlandırıcı CSR (`yz_csr_wrapper.sv`) |

Bu boyutlar **şartname sınırıdır ve ana projede değiştirilmez.** Daha büyük
bellek isteyen tek senaryo YZ bench'tir (CPU'da koşan TFLite modelinin 16 KB FC
ağırlığı `.rodata`'da, yani IMEM'de durur). Orada RTL'e **hiç dokunulmaz**;
parametreler dışarıdan ezilir — bkz. *YZ yazılım gerçeklemesi* bölümü.

Yığın adresi artık `boot.S`'te sabit değil: her linker script
`_stack_top = ORIGIN(DMEM) + LENGTH(DMEM)` tanımlar, `boot.S` de
`la sp, _stack_top` ile onu okur. Yani bellek boyutu tek yerden değişir.

Sistem saati **50 MHz** (`clk_wiz_0`: 100 MHz × 10 / 20); UART baud böleni
`UART_CPB = 434` (50 MHz / 434 = 115200) olarak koda doğrudan yazılır.

Bütün çevre birimi register'ları `firmware/soc.h`'ta TI C2000 tarzı struct + union
(`.all` / `.bit.X`) olarak tanımlıdır; `.c` dosyaları kendi adres/bit tanımını yapmaz.
`soc.h` sadece haritayı verir — register'a yazılan değerler (flash komutu, veri modu,
baud böleni) `.c` içinde doğrudan sayıdır, anlamları soc.h yorumlarındaki tablolarda.
Tek istisna `QSPI_CCR_MAKE(...)`: CCR'ın sekiz alanı tek 32-bit yazmada verilmeli.
Yazmanın kendisi olay tetikleyen register'lara (`QSPI_CCR`, `YZ_CTRL`) alan alan değil
`.all` ile tek seferde yazılır. Makefile `-fstrict-volatile-bitfields` ile derler.

### Üst modüller

- `Top_module.sv` — sentezlenen SoC. `boot_addr`, `mtvec_addr`, RAM derinlikleri
  parametredir; INSTRRAM'den boot için `boot_addr`'i `0x10000000` yap.
- `fpga_top.sv` — kart sarmalayıcısı (clk_wiz + top_module). Simülasyonda
  `used_in_simulation false` yapılır, testbench'ler doğrudan `top_module`'ü örnekler.
  `INIT_FILE_boot`, `ADDR_WIDTH_boot`, `ADDR_WIDTH_data` parametrelerini `top_module`'e
  **geçirir**; varsayılanları ana proje değerleridir, yalnızca TCL'den ezilir.
- `Top_module_for_app_code.sv` (`main_codes/only_app_code/`) — `Top_module.sv`'nin
  boot'tan geçmeden app koşturan kopyası, yalnızca `only_app_test.tcl` kullanır.

### YZ hızlandırıcı

`AI_Accelerator/`: konvolüsyon + FC katmanları, ağırlık/bias'lar sentez ve
simülasyona "Memory File" olarak eklenen `.hex` ROM'ları. Sürüş kesme güdümlüdür —
`main_app.c` içindeki `load_done_isr` / `infer_done_isr`; `main()` kurulum
sonrası `for(;;)` ile durur, iş mantığı ISR'larda yürür.

**Ağırlık dosyaları iki biçimde durur ve karıştırılmamalı:**

| Dosya | Kim okur |
|---|---|
| `weights.hex` (640×8), `fc_weights.hex` (16000×8) | **Hiçbir RTL.** Model export akışının çıktısı, kaynak veri. |
| `weights_p8.hex` (80×64), `fc_weights_p4.hex` (4000×32) | `weights_rom_p8.v` / `fc_weights_rom_p4.v` — TCL'lere eklenen bunlar |
| `biases.hex`, `fc_biases.hex` | `conv_accelerator.v` (`$readmemh`) |

Hızlandırıcı tap başına 1 çevrim işler ve o tap'in **bütün** ağırlıklarını tek
BRAM okumasında almak zorundadır (conv'da 8 kanal, FC'de 4 sınıf paralel). Düz
bayt dosyaları bunu veremediği için paketlenmiş türevler kullanılır. Paketleme
scripti depoda **yok**; düzeni tersine çözülmüş durumda ve
`scripts/yz_tflite/gen_tflite_data.py` her koşumda 16.640 ağırlığın tamamında
doğruluyor:

```
weights_p8.hex[tap]   = 8 bayt,  bayt c = weights.hex[tap*8 + c]      (tap = fy*8 + fx)
fc_weights_p4.hex[i]  = 4 bayt,  bayt c = fc_weights.hex[c*4000 + i]  (SINIF-major!)
```

**`weights.hex` / `fc_weights.hex` değişirse paketlenmiş dosyalar da yeniden
üretilmeli**, yoksa donanım eski ağırlıklarla çalışmaya devam eder;
`make -C scripts/yz_tflite check-data` bunu yakalar.

### YZ yazılım gerçeklemesi + hızlanma/doğruluk kanıtı

Şartnamenin baseline'ı (`micro_speech_quantized.tflite`'ın TFLite reference
kernel'leriyle C gerçeklemesi) `firmware/yz_model/tflite_ref.{c,h}` içindedir;
sabitleri `scripts/yz_tflite/gen_tflite_data.py` doğrudan `.tflite`'tan üretir
(`firmware/yz_model/tflite_model_data.h`). Aynı dosya hem host'ta hem RV32'de
derlenir — `soc.h`, kesme, stdlib bağımlılığı yoktur.

> Model dosyası deponun **dışındadır**: `../tflite_files/micro_speech_quantized.tflite`
> (yani `main_files/` ile aynı seviyede). Yoksa `make -C scripts/yz_tflite data`
> çalışmaz; başka yerdeyse `--model <yol>` ile verilir.

| Ölçüm | Nerede | Nasıl | Sonuç (2026-08-08) |
|---|---|---|---|
| Hızlanma (Madde A) | Vivado simülasyonu | `make sim_bench` + `yz_bench_test.tcl` | **276,9×** (12.608.381 → 45.540 çevrim) |
| Doğruluk (Madde B) | Kart, 156 örnek | `make bench` + `run_accuracy.py --board` | ikisi de **%91,03**, fark **0,00 puan** |
| Hızlı ön kontrol | iverilog | `scripts/yz_tflite/compare_rtl.py` | sınıf 3/3, skor sapması %0,07 |

Ayrıntılı rapor: `scripts/yz_accuracy/README.md`. Yazılım tarafı bellek
sınırlıdır (MAC başına ~37,5 çevrim — önbellek yok, her ağırlık ayrı bir
AXI4-Lite gidiş-dönüşü); hızlandırıcı tap başına 1 çevrimde kalır.

**Bench ana projeyi hiç kirletmez.** 32 KB Boot ROM + 32 KB Data RAM ihtiyacı
paylaşılan dosyalara değil, yalnızca bench'e ait üç yere yazılıdır:

| Nerede | Ne yapar |
|---|---|
| `firmware/linker_bench.ld` | 32 KB/32 KB bellek haritası (yalnız `make bench`/`sim_bench` kullanır) |
| `yz_bench_test.sv` | `top_module #(.ADDR_WIDTH_boot(13), .ADDR_WIDTH_data(13))` |
| `yz_bench_test.tcl` | sentez için aynısını `set_property generic` ile |

`Top_module.sv`, `Top_module_for_app_code.sv`, `linker.ld`, `linker_app.ld`
ve `boot.S` şartname değerlerindedir. `fpga_top.sv` bu üç parametreyi yalnızca
**geçirir** (varsayılanları ana proje değerleri).

`firmware/yz_bench.c` tamamen yoklamalıdır (kesme yok) ve iki satır raporlar:
`YZ:<sınıf>` + `SW:<sınıf> HC:<çevrim> SC:<çevrim>`.

> **Tuzak:** CV32E40P'de `mcountinhibit` reset'te 1'dir
> (`cv32e40p_cs_registers.sv:1529`). `csrw mcountinhibit, 0` yazılmadan `mcycle`
> hiç saymaz ve bütün çevrim ölçümleri 0 döner.

## Bilinmesi gereken tuzaklar

- **Hex adları tek yerden değişmez:** Makefile her şeyi `firmware/makefile_outputs/`
  altına hedefe göre adlandırarak çıkarır (`boot.hex`, `sim_boot.hex`, `app.hex`,
  `bench.hex`, `sim_bench.hex`, ...). Bir hex'in adını değiştirirsen üç yeri birden
  güncelle: TCL'deki `add_files` + `set_property "Memory File"`, `Top_module.sv`'deki
  `INIT_FILE_boot` (her iki kopya) ve ilgili testbench'in parametre override'ı.
  `Main_MCU_Project.tcl`/`ai_accel_test.tcl` `boot.hex`, `boot_test.tcl` `sim_boot.hex`,
  `yz_bench_test.tcl` ise `sim_bench.hex` (sim) + `bench.hex` (sentez) okur.
- `fpga_top.sv` parametreleri TCL'den ezilir:
  `set_property generic {INIT_FILE_boot="bench.hex" ADDR_WIDTH_boot=13 ADDR_WIDTH_data=13} [get_filesets sources_1]`.
  String generic'te **tırnak zorunlu**, yoksa Vivado değeri sessizce boş bırakır ve
  Boot ROM boş sentezlenir.
- `hex2vmf.py` repoda yok, bu yüzden `make flash_vmf` / `sim_flash_vmf` çalışmaz.
- **2026-08-08'de doğrulandı, CLAUDE.md'de bayat kalmıştı:** `teknotest/`,
  `archive/`, `firmware/build_main/`, `scripts/yz_weights_pack.py`,
  `scripts/run_accel_equiv.sh`, `Full_MCU_Project.tcl` ve
  `System_test/README.md` **depoda yok**. Senkronlanacak ikinci bir RTL kopyası
  yoktur. `boot_test.tcl` da artık projeyi doğru adla (`boot_system_test`)
  oluşturuyor, `ai_accel_test` dizinini ezmiyor; `scripts/README.md` de doğru
  TCL adını (`Main_MCU_Project.tcl`) veriyor.
- `ai_accel_test.sv`'deki `EXP_SCORES` tablosu hızlandırıcının **kendi eski
  çıktısından** dondurulmuştur — regresyon koruması için doğru, ama "RTL
  eğitilmiş modelle aynı mı?" sorusunu kanıtlamaz. O soruyu artık
  `scripts/yz_tflite/compare_rtl.py` bağımsız olarak cevaplıyor.
