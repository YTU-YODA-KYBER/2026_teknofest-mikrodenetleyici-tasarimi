# Firmware — Derleme Komutları Açıklamaları

> Not: Bir RISC-V toolchain'i kurulu ve PATH'te olmalıdır. Makefile yaygın
> prefix'leri (`riscv-none-elf`, `riscv32-unknown-elf`, `riscv64-unknown-elf`, …)
> sırayla arar ve ilk bulduğunu kullanır; elle zorlamak için
> `make PREFIX=<prefix> <hedef>`.
> Boot senaryosunu denemek için kartın QSPI modülüne harici non volatile flash bellek bağlanması gerekmektedir.

---
### Kartın yürütme aşamaları

Temelde kartın 2 aşaması vardır: `main_boot.c` ve `main_app.c`
- **Boot akışı(main_boot.c)**
	Kart üzerindeki `SW0` pinine göre 2 farklı mod vardır:
	
	**SW0 = 0:** MCU uyandıktan ve reset sinyali kalktıktan sonra QSPI modülünü kullanarak kartın `XXXXXX` pinlerine bağlı olan `non volatile spi flash bellek` okunur ve MCU'nun Instruction RAM'ine yazılır. Sonrasında işlemci yürütme işini Instruction RAM'e devrederek `uygulama kodlarını(main_app.c)` çalıştırmaya başlar.
	
	**SW0 = 1:** İşlemci UART modülünü kullanarak bilgisayardan `send_data.py` scripti (`firmware/scripts` klasöründe detaylı açıklama mevcut) ile gönderilen .hex kodlarını QSPI modülünü kullanarak bağlı olan flash memory'e yazar. Bu sayede uygulama kodları kolay bir şekilde flash memory'e atılmış olur.

- **Uygulama kodu(main_app.c)**
	İşlemci ayağa kalktıktan sonra buradaki asıl yürütmesi gereken komutları yürütür. Burada karta tasarımı çerçevesinde istenilen işlemler yaptırılabilir. Default olarak YZ hızlandırıcının çalışması için gerekli kodlar eklenmiştir. `SW1` pinine göre AI moduna girmektedir.
	
	**SW1 = 1 ise:**
	Kart bilgisayardan `send_data.py` kullanarak ses dosyası gönderilmesini bekler, dosya geldikten sonra interrupt oluşturarak çıkarım işlemini başlatır, çıkarım bittikten sonra tekrar bir interrupt oluşturur ve çıkarım sonucunu hem kart üzerindeki `7-segment ekrana` basar hem de `UART_YZ` üzerinden bilgisayara geri gönderir. `send_data.py` bu cevabı bekleyip terminale yazar.
	
	**UART cevap çerçevesi** (`main_app.c: yz_report()`) — 5 baytlık ASCII satır:
	
	| Çerçeve | Anlamı | Nerede üretilir |
	|---|---|---|
	| `YZ:B\n` | Ses verisi YZ belleğine yüklendi, çıkarım başladı | `load_done_isr()` |
	| `YZ:0\n` … `YZ:3\n` | Çıkarım bitti, `YZ_RESULT.CLASS` (0=sessizlik, 1=bilinmeyen, 2=evet, 3=hayır) | `infer_done_isr()` |
	
	> Sonuç **genel UART'tan değil `UART_YZ`'den** gönderilir: `UART_mux.sv` (modül adı `uart_mux`) tek fiziksel TX pinini `GPIO_IDR[1:0]`'a göre sürer ve YZ modunda (SW1=1, SW0=0 → değer 2) pini `UART_YZ_TX`'e bağlar. Genel UART'a yazılan bayt karttan hiç çıkmaz.

- **Doğrulama uygulaması(yz_bench.c)**
	Yarışma şartnamesinin iki maddesini ölçen ayrı bir programdır; ana akışın parçası **değildir**, yalnızca kanıt üretmek için çalıştırılır. `main_app.c`'nin yerine geçer (ikisi aynı anda kartta olmaz).

	Aynı 1960 baytlık ses verisini **hem hızlandırıcıya hem de CPU'da koşan TFLite yazılım gerçeklemesine** verir, ikisinin sınıfını ve çevrim sayısını ölçüp UART'tan geri gönderir. Böylece *hızlanma* ve *doğruluk* tek koşumda çıkar.

	İki tarafın aynı veriyi görmesini `UART_mux.sv` (modül adı `uart_mux`) sağlar: RX bir mux değil **fan-out**'tur, genel UART her modda dinler. Yani PC tek gönderim yapar, baytlar hem DMA üzerinden YZ RAM'e hem de genel UART üzerinden CPU'ya ulaşır. (YZ RAM'in CPU portu olmadığı için başka yolu yoktur.)

	`main_app.c`'nin aksine **tamamen yoklamalıdır (polling), kesme kullanmaz** — ölçülen şey çevrim sayısı olduğu için ölçüm penceresine kesme gecikmesi karışmasın diye.

	**UART cevap çerçevesi** — iki satır, `YZ:` önce gider ki `send_data.py` bozulmasın:

	| Çerçeve | Anlamı |
	|---|---|
	| `YZ:<sınıf>\n` | Hızlandırıcının sonucu (0=sessizlik, 1=bilinmeyen, 2=evet, 3=hayır) |
	| `SW:<sınıf> HC:<çevrim> SC:<çevrim>\n` | Yazılımın sonucu + donanım/yazılım çevrim sayıları |

	> Bu senaryo 32 KB Boot ROM + 32 KB Data RAM ister (yazılım modelinin 16 KB'lık FC ağırlığı `.rodata`'da durur). Bu ihtiyaç **ana projeye yazılmaz**: `linker_bench.ld` ve `yz_bench_test.tcl`/`.sv` parametreleri dışarıdan ezer, `Top_module.sv` ile `linker.ld` şartname değerlerinde kalır.


### Duruma göre kullanman gereken komut ve scriptler
>`make` ile gerekli hex kodlarını oluştur
>TCL scripti ile projeyi oluştur

- **Sadece boot akışı**
	**Simülasyonda:**
		1- `make sim_boot` ile ilgili hex kodunu oluşturun.
		2-  `project_gen/System_test/boot_test.tcl` scriptini `scripts/README.md` içindeki açıklamaya göre çalıştır ve Vivado projesini oluşturun. Gerekli bütün dosyalar ilgili projeye eklenir.
		3- Simülasyonu çalıştırabilirsin, güncel durum tcl konsolundan raporlanır.
	**FPGA üzerinde:**
		1- `make boot` ile ilgili hex kodunu oluştur.
		2- `project_gen/Main_MCU_Project.tcl` scriptini `scripts/README.md` içindeki açıklamaya göre çalıştır ve Vivado projesini oluşturun. Gerekli bütün dosyalar ilgili projeye eklenir.
		3- `Generate bitstream` ile bitstream dosyasını oluştur ve `program device` ile karta yükle. Kart üzerindeki `CPU_Reset` yazan buton active low reset olarak tanımlıdır.

- **Sadece uygulama kodları:**
	**Simülasyonda:**
		1- `make sim_app` ile ilgili hex kodunu oluşturun.
		2-  `project_gen/System_test/ai_accel_test.tcl` scriptini `scripts/README.md` içindeki açıklamaya göre çalıştır ve Vivado projesini oluşturun. Gerekli bütün dosyalar ilgili projeye eklenir.
		3- Simülasyonu çalıştırabilirsin, güncel durum tcl konsolundan raporlanır.
	**FPGA üzerinde:**
		1- `make app_bootrom` ile ilgili hex kodunu oluştur.
		2- `project_gen/System_test/only_app_test.tcl` scriptini `scripts/README.md` içindeki açıklamaya göre çalıştır ve Vivado projesini oluşturun. Gerekli bütün dosyalar ilgili projeye eklenir.
		3- `Generate bitstream` ile bitstream dosyasını oluştur ve `program device` ile karta yükle. Kart üzerindeki `CPU_Reset` yazan buton active low reset olarak tanımlıdır.
		
- **İkisi birden(bütün tasarım) FPGA üzerinde:**
	**FPGA üzerinde:**
		1- `make all` ile ilgili hex kodunu oluştur.
		2-  `project_gen/Main_MCU_Project.tcl` scriptini `scripts/README.md` içindeki açıklamaya göre çalıştır ve Vivado projesini oluşturun. Gerekli bütün dosyalar ilgili projeye eklenir.
		3- `Generate bitstream` ile bitstream dosyasını oluştur ve `program device` ile karta yükle. Kart üzerindeki `CPU_Reset` yazan buton active low reset olarak tanımlıdır.

- **YZ doğrulaması (hızlandırıcı ↔ yazılım kıyası):**
	Her iki adım da aynı TCL'i kullanır; script bellek parametrelerini kendisi ayarlar, elle hiçbir dosya değiştirmen gerekmez.
	**Simülasyonda (hızlanma ölçümü):**
		1- `make sim_bench` ile ilgili hex kodunu oluştur.
		2- `project_gen/System_test/yz_bench_test.tcl` scriptini `scripts/README.md` içindeki açıklamaya göre çalıştır ve Vivado projesini oluşturun. Gerekli bütün dosyalar ilgili projeye eklenir.
		3- Simülasyonu çalıştır. Testbench ses verisini YZ RAM'e doğrudan DMA'dan yükler (UART'tan göndermek 8,5 M çevrim sürerdi), sonucu ve hızlanma oranını tcl konsoluna basar. Süre ~12 dakikadır.
	**FPGA üzerinde (doğruluk ölçümü):**
		1- `make bench` ile ilgili hex kodunu oluştur.
		2- Aynı `project_gen/System_test/yz_bench_test.tcl` scriptini çalıştır.
		3- `Generate bitstream` ile bitstream dosyasını oluştur ve `program device` ile karta yükle.
		4- `SW1=1`, `SW0=0` yap, sonra etiketli ses kümeni gönder:
		`python3 ../scripts/yz_accuracy/run_accuracy.py --dataset dataset --board`
		Detaylar ve veri kümesinin nasıl hazırlanacağı: `scripts/yz_accuracy/README.md`.

## Kaynak dosyalar ne işe yarar?

| Dosya                  | Görevi                                                                                                                                                                                                                                                                                |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `main_boot.c`          | **Boot ROM kodu.** FPGA üzerindeki SW0'a göre dallanır: SW0=1 → **flasher** (UART'tan app kodunu alıp QSPI flash'a yazar + doğrular), SW0=0 → **boot** (flash'tan app'i okuyup DMA ile INSTRRAM'e yazar, `0x10000000`'a atlar).                                                       |
| `main_app.c`           | **Asıl uygulama.** Flash'a yazılıp INSTRRAM'e boot edilen, kesme-güdümlü ana program. `irq_init` + `trap_handler` + YZ hızlandırıcı ISR'larını (`load_done_isr`, `infer_done_isr`) içerir; `main()` kurulumdan sonra `for(;;)` ile durur, tüm iş mantığı kesmelerle yürür.            |
| `circle.c`             | LED animasyon demosu. Boot ROM / INSTRRAM boot akışını hızlandırıcı olmadan doğrulamak için ayrı `circle` hedefiyle derlenir.                                                                                                                                                         |
| `flasher_echo_test.c`  | UART echo testi. Boot ROM'da koşar (`make echo`); UART hattının/baud'unun doğru çalıştığını flasher akışına girmeden doğrulamak için.                                                                                                                                              |
| `yz_bench.c`           | **Doğrulama uygulaması.** Aynı sesi hem hızlandırıcıya hem CPU'daki yazılım modeline verir, sınıfları ve `mcycle` çevrim sayılarını UART'tan raporlar. Yoklamalı, kesme kullanmaz. Şartnamenin hızlanma + doğruluk maddelerinin kanıtını üretir.                                      |
| `yz_model/tflite_ref.c` `.h` | **Yazılım gerçeklemesi.** TFLite Micro reference kernel'lerinin (`DepthwiseConvPerChannel`, `FullyConnected`, gemmlowp requant) freestanding C portu. `soc.h`/kesme/stdlib bağımlılığı yoktur — **aynı dosya hem host PC'de hem RV32'de derlenir.**                              |
| `yz_model/tflite_model_data.h` | **Üretilmiş dosya, elle düzenleme.** Ağırlıklar, bias'lar, zero-point'ler ve kuantize çarpanlar. `scripts/yz_tflite/gen_tflite_data.py` bunları doğrudan `micro_speech_quantized.tflite`'tan çıkarır ve RTL'deki karşılıklarıyla çapraz doğrular.                          |
| `yz_model/sim_input.h` | **Üretilmiş dosya.** Simülasyonda kullanılan gömülü test vektörü (1960 bayt). UART'tan ses göndermek simülasyonda 8,5 M çevrim süreceği için girdi `.rodata`'ya gömülür.                                                                                                        |
| `boot.S`               | Reset vektörü / crt0: sp kurulumu, `.data`/`.bss`, `main` çağrısı. Yığın adresi sabit değildir, linker'ın verdiği `_stack_top` sembolünden okunur (`la sp, _stack_top`) — böylece farklı bellek konfigürasyonlarında burayı elle değiştirmek gerekmez.                          |
| `linker.ld`            | Boot ROM yerleşimi (`0x00000000`, 1 KB IMEM / 8 KB DMEM — **şartname sınırı**). `main_boot.c`'nin yanı sıra `sim_app` / `app_bootrom` / `echo` hedefleri de bunu kullanır.                                                                                                       |
| `linker_app.ld`        | Uygulama yerleşimi (INSTRRAM, `0x10000000`) — flash'a yazılıp DMA ile boot edilen `app` hedefi.                                                                                                                                                                                       |
| `linker_bench.ld`      | **Yalnızca `bench` / `sim_bench` hedefleri için.** 32 KB Boot ROM + 32 KB Data RAM; yazılım modelinin 16 KB'lık FC ağırlığı `.rodata`'ya sığsın diye. Ana projenin `linker.ld`'si bu yüzden **değiştirilmez**.                                                                   |
| `soc.h`                | **Donanım soyutlama başlığı.** Timer, GPIO, UART (genel + YZ), I2C, QSPI ve YZ hızlandırıcının bütün register'ları, bit alanları, flash komutları, bellek haritası ve kesme numaraları burada tanımlıdır. `.c` dosyaları yalnızca bunu include eder, kendi adres/bit tanımını yapmaz. |
| `scripts/send_data.py` | Karta UART ile veri gönderir: uygulama kodunu flash'a yazdırır ya da YZ'ye ses verisi yollar (aşağıdaki tablo).                                                                                                                                                                       |

---
## Makefile komutları ne işe yarar?
> Bütün çıktılar tek bir klasöre, `firmware/makefile_outputs/` içine yazılır. Dosya adı hangi komuttan geldiğini gösterir; simülasyon için derlenenler `sim_` ön ekini alır.

| Komut                          | Ne yapar                                                                                                                                                                           |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `make boot`                    | Ana kod olan `main_boot.c` ve onun çalışması için gerekli olan linker.ld ve boot.S'yi derleyip `makefile_outputs/boot.hex` adında çıkartır.                                        |
| `make app`                     | Ana kod olan `main_app.c` ve onun çalışması için gerekli olan linker_app.ld ve boot.S'yi derleyip `makefile_outputs/app.hex` (+ `app.bin`) adında çıkartır.                        |
| `make app_bootrom`             | Aynı `main_app.c`'yi **Boot ROM linker'ı** (`linker.ld`, `0x00000000`) ile derler → `makefile_outputs/app_bootrom.hex`. Flash yokken uygulamayı doğrudan karttan çalıştırmak için. |
| `make all`                     | `make boot` ve `make app` komutlarını tek seferde uygular                                                                                                                          |
| `make circle`                  | Kart üzerinde basit bir LED animasyon demosu → `makefile_outputs/circle.hex` (+ `circle.bin`)                                                                                      |
| `make echo`                    | `flasher_echo_test.c`'yi Boot ROM linker'ı ile derler → `makefile_outputs/echo.hex`. UART echo testi.                              |
| `make sim_boot` `make sim_app` | Aynı kodların simülasyon versiyonları. Simülasyonda daha hızlı çalışmak için optimizeler.                                                                                          |
| `make bench`                   | `yz_bench.c` + yazılım modelini **`linker_bench.ld`** (32 KB/32 KB) ile derler → `makefile_outputs/bench.hex`. Kart üzerindeki doğruluk ölçümü için. `-O2` kullanılır: kıyas baseline'ı kasıtlı yavaşlatılmış görünmemeli. |
| `make sim_bench`               | Aynısının simülasyon sürümü (`-DSIMULATION`) → `makefile_outputs/sim_bench.hex`. Ses verisini UART'tan beklemez, `sim_input.h`'teki gömülü vektörü kullanır.                       |

## Register'lara nasıl erişilir? (`soc.h`)

Her bloğun register'larını sırayla tutan bir `struct` ve o bloğun base adresine bakan bir pointer ile tanımlıdır. Bit alanı olan register'lar `union`'dır: `.all` ile 32-bit tamamına, `.bit.<ALAN>` ile tek bir alana erişilir. Sadece sayısal değer tutanlar (sayaç, baud böleni, veri register'ı) düz `uint32_t`'dir.

`soc.h` yalnızca **haritayı** verir; register'a yazılan değerler (flash komutu, veri modu, baud böleni, sınıf indeksi) `.c` dosyalarında doğrudan sayı olarak yazılır. Hangi sayının ne anlama geldiği `soc.h`'ta ilgili register'ın yorumundaki tablodadır.

| Blok | Pointer | Base | Örnek |
|---|---|---|---|
| Timer | `Timer` | `0x4000_0000` | `Timer->TIM_ARE = 1000; Timer->TIM_ENA.bit.ENA = 1;` |
| GPIO | `Gpio` | `0x4001_0000` | `if (Gpio->GPIO_IDR.bit.SW0) ... ; Gpio->GPIO_ODR = 7;` |
| I2C Master | `I2c` | `0x4002_0000` | `I2c->I2C_ADR = 0x50; I2c->I2C_CFG.bit.TXEN = 1;` |
| QSPI Master | `Qspi` | `0x4003_0000` | `Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(0,7,1,255,8,0,3,0x6B); while (!Qspi->QSPI_STA.bit.DONE);` |
| UART (genel) | `Uart` | `0x4004_0000` | `Uart->UART_CPB = 434;` → 50 MHz / 434 = 115200 baud |
| UART (YZ akışı) | `UartAI` | `0x4005_0000` | `UartAI->UART_CPB = 434;` |
| YZ hızlandırıcı | `YzAccel` | `0x4006_0000` | `YzAccel->YZ_CTRL.all = 0x3; cls = YzAccel->YZ_RESULT.bit.CLASS;` |

`QSPI_CCR_MAKE(clr, presc, addr_en, size_m1, dummy, rw, mode, instr)` tek istisnadır: CCR'a yazmak transferi başlattığı için sekiz alanın tek bir 32-bit değere paketlenmesi gerekir. Argümanların hepsi doğrudan sayıdır — yukarıdaki örnekte `3` = x4 veri modu, `0x6B` = QOR flash komutu.

Bunun dışında `soc.h` içinde `SYS_CLK_HZ` (50 MHz, `clk_wiz_0` çıkışı) ve bellek haritası (`INSTRRAM_BASE` vb.) tanımlıdır. Flash komut değerleri, veri modları, YZ sınıf indeksleri ve kesme numaraları ilgili register'ın yorumunda tablo halinde durur.

---
## send_data.py komutları

`/firmware` klasöründen çalıştırılır (script kendi konumuna göre dosyaları bulduğu için başka klasörden de çalışır). Port ve baud dosyanın başında sabittir (`/dev/ttyUSB1`, 115200) ve UART RTL'indeki baud ile eşleşmelidir.

### Yeni bilgisayarda ilk kurulum (Linux)

1. **pyserial kur.** Debian/Ubuntu türevlerinde sistem Python'u dışarıdan pip kurulumuna kapalıdır (PEP 668), o yüzden apt paketi tercih edilir:
   ```bash
   sudo apt install python3-serial
   # apt paketi yoksa: pip3 install --user --break-system-packages pyserial
   ```
2. **Seri porta erişim izni ver.** `/dev/ttyUSB*` `root:dialout` sahipliğindedir; kullanıcı `dialout` grubunda değilse script `Permission denied` (Errno 13) ile patlar:
   ```bash
   sudo usermod -aG dialout $USER
   ```
   Grup değişikliği mevcut oturuma yansımaz — oturumu kapatıp açmak gerekir. Hemen denemek için:
   ```bash
   sg dialout -c "python3 scripts/send_data.py no"
   ```
   Tek seferlik alternatif (kart çıkarılıp takılınca sıfırlanır): `sudo chmod 666 /dev/ttyUSB1`.
3. **Doğru portu bul.** `ls /dev/ttyUSB*` — FTDI iki port açar (genelde `ttyUSB0` JTAG, `ttyUSB1` UART). Farklıysa `--port` ile ver.

| Komut | Ne yapar |
|---|---|
| `python3 scripts/send_data.py app` | `makefile_outputs/app.hex`'i Boot ROM'daki flasher'a gönderir → QSPI flash. Ön koşul: `SW0=1` + reset. |
| `python3 scripts/send_data.py yes` \| `no` \| `sessizlik` | `sound_samples/input_data_X.hex` ses verisini YZ'ye gönderir, ardından karttan gelen `YZ:<sınıf>` cevabını bekleyip sonucu yazar. Ön koşul: uygulama flash'tan boot edilmiş + `SW1=1`. |
| `python3 scripts/send_data.py app <dosya>` | Kısayol yerine kendi hex dosyanı gönderir. |
| `python3 scripts/send_data.py audio <dosya>` | Kendi 1960 baytlık ses dosyanı gönderir. |
| `... --no-wait` | Ses gönderdikten sonra karttan cevap bekleme (eski davranış; sadece 7-segment'e bakılır). |
| `... --port /dev/ttyUSB0 --baud 115200` | Port/baud'u komut satırından ezmek için (her komutla birlikte kullanılabilir). |

> `app` modunda script, kartın her 256 baytlık bloktan sonra gönderdiği ACK'i bekler; ACK gelmezse "SW0=1 + reset yapıldı mı?" uyarısıyla durur. Bu akış kontrolü olmadan kart veri taşması yaşar.

---
## Diğer

| İstediğin | Komut |
|---|---|
| Boyut raporu (main_boot + main_app) | `make size` |
| Boot ROM disassembly | `make disasm_boot` |
| Uygulama disassembly | `make disasm_app` |
| Üretilen çıktıları sil | `make clean` |

---

`make clean` `makefile_outputs/` klasörünü siler — elle temizlik gerekmez.

> `make flash_vmf` / `make sim_flash_vmf` hedefleri **çalışmaz**: bağımlı oldukları
> `hex2vmf.py` scripti depoda yok.

---
