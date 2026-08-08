# YTU YODA KYBER — Mikrodenetleyici Tasarımı

TEKNOFEST 2026 Çip Tasarım Yarışması (Mikrodenetleyici Kategorisi) için
geliştirilen, **RISC-V CV32E40P** çekirdekli ve yapay zekâ hızlandırıcılı
SoC tasarımının ana çalışma dosyaları.

Bu klasör dört bölümden oluşur. Aşağıda her birinin ne içerdiği ve ne işe
yaradığı yazılı. `firmware/` ve `scripts/` klasörlerinin ayrıca kendi
`README.md`'si var; o klasöre özel detaylar için oraya bak.

---

## Klasör yapısı

```
main_files/
├── firmware/      → İşlemci üzerinde koşacak yazılım ile ilgili kodlar (C / asm)
├── main_codes/    → Donanım tasarımının tamamı (RTL) + testbench'ler
├── scripts/       → Vivado proje kurulum scriptleri + ses dönüştürme aracı
└── teknotest/     → Jürinin istediği teknotest klasörü
```

---

### Projeyi nasıl oluşturacağım?

İstediğiniz amaca göre uygun `make` komutunu ve `tcl scriptini` kullanmanız gerekmektedir. Hangi durumda hangi komutları ve scritptleri kullanmanız gerektiği **main_files/firmware** klasöründeki README.md dosyasında açıklanmıştır.

### Kartın yürütme aşamaları

Temelde kartın 2 aşaması vardır: `main_boot.c` ve `main_app.c`
- **Boot akışı(main_boot.c)**
	Kart üzerindeki `SW0` pinine göre 2 farklı mod vardır:
	
	**SW0 = 0:** MCU uyandıktan ve reset sinyali kalktıktan sonra QSPI modülünü kullanarak kartın `XXXXXX` pinlerine bağlı olan `non volatile spi flash bellek` okunur ve MCU'nun Instruction RAM'ine yazılır. Sonrasında işlemci yürütme işini Instruction RAM'e devrederek `uygulama kodlarını(main_app.c)` çalıştırmaya başlar.
	
	**SW0 = 1:** İşlemci UART modülünü kullanarak bilgisayardan `send_data.py` scripti (`firmware/scripts` klasöründe detaylı açıklama mevcut) ile gönderilen .hex kodlarını QSPI modülünü kullanarak bağlı olan flash memory'e yazar. Bu sayede uygulama kodları kolay bir şekilde flash memory'e atılmış olur.

- **Uygulama kodu(main_app.c)**
	İşlemci ayağa kalktıktan sonra buradaki asıl yürütmesi gereken komutları yürütür. Burada karta tasarımı çerçevesinde istenilen işlemler yaptırılabilir. Default olarak YZ hızlandırıcının çalışması için gerekli kodlar eklenmiştir. `SW1` pinine göre AI moduna girmektedir.
	
	**SW1 = 1 ise:**
	Kart bilgisayardan `send_data.py` kullanarak ses dosyası gönderilmesini bekler, dosya geldikten sonra interrupt oluşturarak çıkarım işlemini başlatır, çıkarım bittikten sonra tekrar bir interrupt oluşturur ve çıkarım sonucunu kart üzerindeki `7-segment ekrana` basar. 


## `firmware/`

İşlemcinin çalıştırdığı **bare-metal yazılım**. Çevre birimlerini (Timer,
GPIO, UART, I2C, QSPI) kullanan uygulamalar, başlangıç kodu ve derleme akışı
burada.

İçindekiler:
- Başlangıç ve bellek: `boot.S`, `linker.ld`, `linker_app.ld`, `soc.h`
- Uygulamalar: `main_boot.c` (bootloader + flasher), `main_app.c` (asıl
  uygulama, YZ hızlandırıcı ISR'ları), `circle.c` (LED demosu),
  `flasher_echo_test.c` (UART echo testi)
- Derleme: `Makefile` — bütün çıktılar `makefile_outputs/` altına yazılır
- Yardımcılar: `scripts/send_data.py` (karta UART ile app/ses gönderimi),
  `sound_samples/` (referans YZ girdileri)

> Hangi `make` komutunun neyi derlediği `firmware/README.md` içinde anlatılıyor.

---

## `main_codes/`

Çipin **donanım tasarımının tamamı** — yani sentezlenen RTL kodu ve onu
doğrulayan testbench'ler. Projenin kalbi burası.

| Alt klasör | İçerik |
|---|---|
| `rtl/desgin_sources/CPU/` | CV32E40P RISC-V çekirdeği + OBI↔AXI köprüsü |
| `rtl/desgin_sources/Interconnect/` | AXI4 ara bağlantı, komut (instruction) ayırıcı ve UART mux |
| `rtl/desgin_sources/Memory/` | Boot ROM, Data RAM, Instruction RAM, YZ RAM — AXI4-Lite sarmalayıcıları + `BRAM_defines/` BRAM tanımları |
| `rtl/desgin_sources/Peripherals/` | GPIO, I2C, QSPI, Timer, UART (genel + YZ akışı) çevre birimleri |
| `rtl/desgin_sources/AI_Accelerator/` | Yapay zekâ hızlandırıcısı: konvolüsyon/FC katmanları, ağırlık-bias hex'leri, `yz_csr_wrapper.sv` CSR arayüzü |
| `rtl/desgin_sources/Top_Module/` | Tüm blokları birleştiren üst modül (`Top_module.sv`); kart sarmalayıcısı `fpga_top.sv` bir üst dizinde, `rtl/desgin_sources/` altındadır |
| `rtl/include/` | Ortak `svh` başlıkları (AXI/OBI typedef'leri, assertion'lar) |
| `testbench/` | Çevre birimi, AI hızlandırıcı ve sistem seviyesi testbench'ler (QSPI için Micron flash modeli dahil) + `AXI_protocol_check/` protokol kontrolcüsü |
| `constraint/` | Nexys A7 constraint dosyası (`nexys_a7_soc.xdc`; eski Basys3 dosyası da duruyor) + `cv32e40p_core.sdc` |
| `ip/` | Vivado IP'leri (clock wizard) |
| `only_app_code/` | Boot mekanizmasını atlayıp doğrudan app koşturan üst modül varyantı |
| `for_FPU/` | Çekirdeğin FPU'lu (kayan nokta) varyantı için gerekli RTL kodları |

> AXI protokol kontrolcüsünün detayları
> `main_codes/testbench/AXI_protocol_check/README.md` içinde.

---

## `scripts/`

Vivado projesini **sıfırdan, otomatik kuran TCL scriptleri** ve YZ
hızlandırıcısı için ses hazırlama aracı.

İçindekiler:
- `project_gen/Main_MCU_Project.tcl` — ana proje kurulum scripti (asıl
  çalıştırılan bu). Repoyu klonlayan biri tek script ile bütün blokları
  içeren projeyi oluşturur; kaynak dosyaları elle eklemekle uğraşmaz.
- `project_gen/CPU/`, `Interconnect/`, `Memory/`, `Peripherals/` — her bloğu
  tek tek oluşturan yardımcı scriptler
- `project_gen/System_test/` — sistem seviyesi testler: `boot_test.tcl`,
  `ai_accel_test.tcl`, `only_app_test.tcl`
- `wav_to_yz.py` — 1 saniyelik WAV kaydını YZ hızlandırıcısının beklediği
  49×40 = 1960 baytlık özellik hex'ine çevirir; çıktı `sound_outputs/`
  klasörüne yazılır ve `send_data.py audio <dosya-yolu>` ile karta gönderilir.

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
