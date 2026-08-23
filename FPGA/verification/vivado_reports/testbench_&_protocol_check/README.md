# Directed Testbench ve AXI Protokol Kontrol Raporları

Çevre birimlerinin, YZ hızlandırıcının ve boot zincirinin **yönlendirilmiş
(directed) testbench** koşumları ile bu koşumlar sırasında tasarımın bütün
AXI4-Lite arayüzlerinde yapılan **protokol kontrolünün** sonuçları.

Şartname karşılığı: **madde 5.2-2, 5.2-3, 5.2-4** (üçü de ödül kazanımı için
zorunlu) ve **EK-3**'ün *Protokol Kontrolleri*, *YZ Hızlandırıcı Testleri*,
*Sistem Seviyesi Testler* satırları.

Simülatör: **Vivado XSim 2025.2** · Hedef aygıt: `xc7a100tcsg324-1` ·
Sistem saati: 50 MHz · Ölçüm tarihi: **2026-08-23**

> **Başlangıç noktası: [`index.html`](index.html)** — bütün birimlerin sonuçları
> tek tabloda, her birinin klasörüne ve ham log'una bağlantı ile.

---

## Özet

| | Sonuç |
|---|---|
| Koşum | **8** (6 blok testi + 2 sistem testi) |
| Blok testlerinde sayılan kontrol | **100 / 100 geçti** |
| YZ senaryosu | **3 / 3 geçti** — 12 geçme/kalma kapısının 12'si |
| Boot zinciri | **başarılı** — 2 faz, 5 kilometre taşının tamamı |
| **AXI protokol ihlali** | **0** — sekiz koşumun tamamında |
| Uyarı (stall/watchdog) | **0** |
| Denetlenen ayrı AXI arayüzü | **15** (sistem testlerinde) |

### Blok seviyesi testler

| Birim | Test bloğu | Sayılan kontrol | Geçen | Kalan | İzlenen arayüz | AXI ihlali | Uyarı | Sim süresi | Rapor |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Timer | 6 | 8 | **8** | 0 | 1 | **0** | 0 | 50,14 µs | [`Timer/`](Timer/) |
| GPIO | 15 | 50 | **50** | 0 | 1 | **0** | 0 | 31,07 µs | [`GPIO/`](GPIO/) |
| I2C Master | 10 | 10 | **10** | 0 | 1 | **0** | 0 | 1,080 ms | [`I2C/`](I2C/) |
| QSPI Master | 2 | 12 | **12** | 0 | 1 | **0** | 0 | 6,339 ms | [`QSPI/`](QSPI/) |
| UART_GU | 4 | 10 | **10** | 0 | 1 | **0** | 0 | 1,068 ms | [`UART_GU/`](UART_GU/) |
| UART_YZ | 4 | 10 | **10** | 0 | 1 | **0** | 0 | 1,068 ms | [`UART_YZ/`](UART_YZ/) |
| **Toplam** | **41** | **100** | **100** | **0** | | **0** | **0** | | |

### Sistem seviyesi testler

| Test | Ne sürüyor | Sonuç | İzlenen arayüz | AXI ihlali | Sim süresi | Rapor |
|---|---|---|---:|---:|---:|---|
| Boot zinciri | flasher → QSPI flash → boot → DMA → INSTRRAM → atlama → yürütme | **başarılı** | **15** | **0** | 10,908 ms | [`Boot/`](Boot/) |
| YZ hızlandırıcı | UART → DMA → YZ RAM → çıkarım → kesme → 7-segment | **3/3 senaryo** (12/12 kapı) | **15** | **0** | 513,111 ms | [`AI_Accelerator/`](AI_Accelerator/) |

YZ hızlandırıcının çıkarım gecikmesi üç senaryoda da **45.517 çevrim**
(50 MHz'de 910,3 µs → **1098,5 çıkarım/s**); dört FC skorunun on ikisi de altın
referansla **bit-exact** eşleşti.

---

## Bu klasör neyi kanıtlıyor

Üç ayrı soruya cevap verir:

1. **Blok doğru çalışıyor mu?** Altı çevre biriminin her biri, elle yazılmış
   senaryolarla kendi işlevselliği üzerinden sınanır (sayma modları, FIFO
   bayrakları, NACK davranışı, baud bölenleri, 7-segment kod çözme…).
2. **Sistem doğru çalışıyor mu?** İki sistem seviyesi test gerçek firmware
   koşturur: `Boot/` boot zincirinin tamamını, `AI_Accelerator/` UART'tan gelen
   sesin sınıflandırılıp sonucun CPU'ya kesmeyle dönmesini uçtan uca doğrular.
3. **AXI trafiği protokole uygun mu?** Her koşumda `axi4lite_protocol_checker`
   `bind` ile devrededir; 10 kategoride 40 kural (33 `assert property` +
   7 prosedürel kontrol) simülasyon boyunca canlı denetim yapar.

Bütün testler **self-checking**'dir: sonucu elle incelemek gerekmez, testbench
kendi kararını verir ve başarısızlıkta `$fatal` ile durur.

---

## Klasör yapısı

```
testbench_&_protocol_check/
├── README.md          → bu dosya
├── index.html         → tek giriş sayfası (buradan başlayın)
│
├── Timer/             ┐
├── GPIO/              │
├── I2C/               ├─ çevre birimleri — blok testbench'leri
├── QSPI/              │   (her biri kendi AXI arayüzünü izler)
├── UART_GU/           │
├── UART_YZ/           ┘
│
├── Boot/              ┐ sistem seviyesi testler
└── AI_Accelerator/    ┘  (15 AXI arayüzünün tamamını izler)
```

Her klasörde iki dosya vardır:

| Dosya | İçeriği |
|---|---|
| `README.md` | O koşumdaki testlerin tek tek ne doğruladığı, sonuç tablosu, AXI protokol özeti ve okuma notları |
| `xsim_console.log` | Simülasyonun **ham konsol çıktısının tamamı** — araç sürümü başlığından `$finish` satırına kadar. Raporlardaki bütün sayılar bu dosyadan gelir |

---

## AXI protokol kontrol özetleri

Sekiz koşumun her biri sonunda `axi_chk_pkg::final_report()` çağırır. Aşağıdakiler
`xsim_console.log` dosyalarından **birebir** alınmıştır.

**Blok testleri** — altısında da aynı sonuç (yalnızca izlenen arayüz o bloğun kendisi):

```
======================================================================
            AXI4-LITE PROTOKOL KONTROL OZETI
======================================================================
  Izlenen AXI arayuzu sayisi : 1
  Protokol ihlali            : 0
  Uyari (stall/watchdog)     : 0
  SONUC                      : GECTI  (0 ihlal)
======================================================================
```

| Birim | Gözlenen trafik |
|---|---|
| `TIMER` | `AW=30 W=30 B=30 AR=5 R=5` |
| `GPIO` | `AW=26 W=26 B=26 AR=7 R=7` |
| `I2C` | `AW=54 W=54 B=54 AR=12853 R=12853` |
| `QSPI` | `AW=9408 W=9408 B=9408 AR=118166 R=118166` |
| `UART_GU` | `AW=17 W=17 B=17 AR=5 R=5` |
| `UART_YZ` | `AW=17 W=17 B=17 AR=5 R=5` |

**Sistem testleri** — `Boot/` ve `AI_Accelerator/`, ikisi de aynı özeti basar:

```
======================================================================
            AXI4-LITE PROTOKOL KONTROL OZETI
======================================================================
  Izlenen AXI arayuzu sayisi : 15
  Protokol ihlali            : 0
  Uyari (stall/watchdog)     : 0
  SONUC                      : GECTI  (0 ihlal)
======================================================================
```

En yoğun iki koşum: `AI_Accelerator/` içinde `CPU_INSTR_M` arayüzünde
**8.551.805 okuma**, `QSPI/` blok testinde 118.166 okuma — hepsi 40 kuralın
süzgecinden geçti, hiçbirinde ihlal çıkmadı.

---

## İzlenen AXI4-Lite arayüzleri

Blok testlerinde yalnızca o bloğun arayüzü izlenir. İki sistem testinde ise
`axi4lite_bind.svh` ile **15 arayüzün tamamı** bağlanır:

### Katman 1 — Slave uç noktaları (11)

| # | Arayüz | `Boot/` | `AI_Accelerator/` | Blok testi |
|---|---|:---:|:---:|:---:|
| 1 | `TIMER` | — | — | [`Timer/`](Timer/) |
| 2 | `GPIO` | ✔ | ✔ | [`GPIO/`](GPIO/) |
| 3 | `I2C` | — | — | [`I2C/`](I2C/) |
| 4 | `QSPI` | ✔ | — | [`QSPI/`](QSPI/) |
| 5 | `UART_GU` | ✔ | — | [`UART_GU/`](UART_GU/) |
| 6 | `UART_YZ` | — | ✔ | [`UART_YZ/`](UART_YZ/) |
| 7 | `YZ_ACCEL` (`yz_csr_wrapper`) | — | ✔ | — |
| 8 | `DATA_RAM` | ✔ | ✔ | — |
| 9 | `INSTR_RAM` | ✔ | — | — |
| 10 | `BOOTROM_CPU` | ✔ | ✔ | — |
| 11 | `BOOTROM_ICN` | — | — | — |

### Katman 2 — Master ve fabric (4)

| # | Arayüz | `Boot/` | `AI_Accelerator/` |
|---|---|:---:|:---:|
| 12 | `CPU_INSTR_M` | ✔ | ✔ |
| 13 | `CPU_DATA_M` | ✔ | ✔ |
| 14 | `SPLITTER_S` | ✔ | ✔ |
| 15 | `ICN_S0` | ✔ | ✔ |

`✔` = o koşumda **gerçek trafik gördü**. Trafik görmeyen arayüzler için
kontrolcü `*** TRAFIK YOK -- bu arayuz HIC test edilmedi ***` satırını basar;
böylece "0 ihlal" ile "hiç sürülmedi" karıştırılamaz.

İki sistem senaryosu birleştiğinde 15 arayüzün **14'ü** gerçek trafik altında
denetlenmiş olur. Kapsam dışında kalan tek arayüz `BOOTROM_ICN`'dir: Boot ROM'un
interconnect tarafındaki ikinci okuma portu, CPU komutlarını `BOOTROM_CPU`
portundan aldığı için bu iki senaryoda hiç sürülmez. Timer ve I2C sistem
testlerinde kullanılmaz ama kendi blok testlerinde tam olarak denetlenir.

Interconnect'in `M0…M9` master portları bilinçli olarak bağlanmamıştır:
Katman 1'deki slave portlarının aynı telleridir, ikisini birden bağlamak aynı
sinyali iki kez kontrol etmek olurdu.

---

## Kural seti (ARM IHI 0022)

| Kimlik | Kategori | Ne yakalar |
|---|---|---|
| `RST_01…05` | Reset davranışı | Reset aktifken yüksek kalan VALID |
| `HSK_01…05` | VALID kararlılığı | READY gelmeden VALID'i düşüren FSM |
| `STB_01…07` | Payload kararlılığı | El sıkışma beklerken değişen adres/veri/cevap |
| `XCK_01…07` | X/Z kontrolü | Sıfırlanmamış register, eksik `default`, bağlanmamış port |
| `RSP_01…02` | Cevap legalliği | AXI4-Lite'ta yasak olan `EXOKAY` |
| `ORD_01…03` | Nedensellik | İstek olmadan gelen sahte cevap |
| `OUT_01…02` | Outstanding limiti | Limit aşımı, istekten fazla cevap |
| `WST_01…02` | WSTRB legalliği | X'li veya beklenmeyen kısmi strobe |
| `STL_01…05` | Takılma gözcüsü | Kilitlenme — **uyarı seviyesi, ihlal sayılmaz** |
| `FIN_01…02` | Sim sonu boşaltma | Cevapsız kalan işlem = gizli hang |

Kontrolcünün kendisi, kaynak kodu ve tasarım gerekçeleri:
[`main_codes/testbench/AXI_protocol_check/README.md`](../../../main_codes/testbench/AXI_protocol_check/README.md).

---

## Nasıl üretildi

Vivado'nun kendi proje scriptleri simülasyonu **başlatmaz**, yalnızca projeyi
kurar. Bu yüzden her koşum iki adımdır: önce proje batch modda kurulur, sonra
üretilen XSim scriptleri elle çalıştırılır. Bilinçli olarak depoya kalıcı bir
otomasyon eklenmemiştir — kod kapsamı raporlarında olduğu gibi, koşum
gerektiğinde elle yapılır.

```bash
source /usr/Vivado/2025.2/Vivado/settings64.sh
cd .../FPGA                       # zorunlu: TCL yolları göreli

# 1) Projeyi kur + XSim scriptlerini üret (örnek: GPIO)
printf '%s\n' \
  'set_property top GPIO_testbench [get_filesets sim_1]' \
  'update_compile_order -fileset sim_1' \
  'set_property -name {xsim.simulate.runtime} -value {all} -objects [get_filesets sim_1]' \
  'launch_simulation -scripts_only'  > /tmp/run_gpio.tcl
vivado -mode batch -notrace \
       -source scripts/project_gen/Peripherals/create_GPIO.tcl \
       -source /tmp/run_gpio.tcl

# 2) Dalga kaydını kapat ve koştur
cd Vivado_projects/GPIO_Module/GPIO_Module.sim/sim_1/behav/xsim
printf 'run all\nquit\n' > GPIO_testbench.tcl     # Vivado'nun ürettiği "add_wave /" yerine
./compile.sh && ./elaborate.sh && ./simulate.sh
# konsol çıktısının tamamı -> simulate.log  (bu klasördeki xsim_console.log budur)
```

Birim başına kurulum:

| Klasör | Proje scripti | Sim top |
|---|---|---|
| `Timer/` | `Peripherals/create_Timer.tcl` | `Timer_testbench` |
| `GPIO/` | `Peripherals/create_GPIO.tcl` | `GPIO_testbench` |
| `I2C/` | `Peripherals/create_I2C.tcl` | `I2C_Master_testbench` |
| `QSPI/` | `Peripherals/create_QSPI.tcl` | `QSPI_Master_tb` |
| `UART_GU/` | `Peripherals/create_UART_GU.tcl` | `UART_GU_testbench` |
| `UART_YZ/` | `Peripherals/create_UART_YZ.tcl` | `UART_YZ_testbench` |
| `Boot/` | `System_test/boot_test.tcl` | `boot_test` |
| `AI_Accelerator/` | `System_test/ai_accel_test.tcl` | `ai_accel_test` |

İki sistem testi firmware hex'ine ihtiyaç duyar: `boot_test` için
`make sim_boot`, `ai_accel_test` için `make sim_app`
(`firmware/makefile_outputs/` altına yazarlar).

**Üç ayar önemlidir:**

1. **`xsim.simulate.runtime = all`** — varsayılan 1000 ns'dir; ayarlanmazsa
   simülasyon hiçbir testi koşturmadan biter.
2. **Sim top elle verilir** — çevre birimi scriptleri `set_property top`
   içermez. Özellikle QSPI'da kritiktir: Micron modeli onlarca modül tanımlar,
   otomatik seçim yanlış modülü seçebilir.
3. **`add_wave /` kaldırılır** — Vivado'nun ürettiği TCL bütün sinyalleri
   kaydeder. Sistem testlerinde bu, koşumu saatlerce uzatan devasa bir `.wdb`
   üretir; sonuç raporu için dalga formuna gerek yoktur.

Üretilen Vivado projeleri koşum sonrası silinmiştir — `Vivado_projects/`
üretilen çıktıdır, kanıt bu klasördeki log'lardır.

---

## Okurken dikkat edilecekler

- **Protokol kontrolü ayrı bir koşum değildir.** `axi4lite_protocol_checker`
  her testbench'e `bind` ile bağlıdır ve testin kendi trafiğini izler. Yani
  "12 test geçti" ile "0 protokol ihlali" **aynı simülasyonun** iki çıktısıdır;
  ihlal sayısı testin ürettiği gerçek AXI trafiği üzerinden ölçülür.
- **İşlem sayıları blokların doğasını yansıtır, kalitesini değil.** QSPI'nın
  118.166 okuması, I2C'nin 12.853 okuması yavaş çevre birimlerinin
  tamamlanmasını beklerken yapılan **durum yoklamalarıdır**. Timer'ın 5 okuması
  azlığından değil, register'ının anında cevap vermesindendir.
- **`STL_*` (takılma gözcüsü) uyarı seviyesindedir, ihlal sayılmaz.** Bu
  koşumların hiçbirinde tetiklenmemiştir; "Uyarı" satırının 0 olması bunu
  gösterir.
- **Bu raporlar UVM regresyonunun yerine geçmez, onu tamamlar.** Directed test
  senaryoyu **elle** yazar: "şu register'a şunu yaz, şu olmalı". UVM ortamı
  ([`../../uvm/`](../../uvm/)) aynı bloklara kısıtlı rastgele trafik sürer ve
  bir scoreboard ile karşılaştırır. İkisi farklı hataları yakalar — nitekim
  UVM, blok testbench'lerinin hiç dokunmadığı iki yolu (UART_YZ DMA yan bandı,
  QSPI DMA register'ı) doğrulamış ve directed testlerin görmediği bir GPIO
  kilitlenmesini bulmuştur ([`../../uvm/findings.md`](../../uvm/findings.md)).
- **Checker'ın kendisi ayrıca doğrulanmıştır.** Hiçbir şeyi yakalamayan bir
  kontrolcü de "0 ihlal" raporlar; bu yüzden
  `tb_axi4lite_checker_selftest.sv` her kural için bilerek ihlal üretip
  yakalandığını gösterir (bkz.
  [`AXI_protocol_check/README.md`](../../../main_codes/testbench/AXI_protocol_check/README.md)).

---

Ölçüm tarihi: **2026-08-23**. Vivado / XSim **2025.2**, `xc7a100tcsg324-1`
(çevre birimi blok projeleri `xc7a35tcpg236-1`), sistem saati 50 MHz.
Toplam simülasyon süresi 1 sa 10 dk; en uzun koşum `AI_Accelerator/` (1 sa 06 dk).
