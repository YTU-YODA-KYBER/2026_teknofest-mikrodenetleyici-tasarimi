# YZ Hızlandırıcı — Sistem Seviyesi Directed Test Sonucu

Hızlandırıcıyı tek başına değil, **SoC'nin içinde ve gerçek firmware ile**
sınayan self-checking test. Şartnamenin iki zorunlu maddesinin karşılığıdır:

- **Madde 5.2-4:** *"YZ hızlandırıcının en az bir test senaryosuyla
  doğrulanmış olması."* → üç senaryo (evet / hayır / sessizlik).
- **Madde 5.2-3:** *"…AXI arayüzlerinin en azından protocol check düzeyinde
  doğrulanması."* → `axi4lite_bind.svh` ile **15 arayüz**. Bu, `YZ_ACCEL`
  (`yz_csr_wrapper`) arayüzüne trafik üreten **tek** testtir; boot testi o
  arayüze hiç dokunmaz.

Ayrıca EK-1'in iş akışı isterini ve Tablo 3-1'in "Sistem performansı"
başlığını da karşılar (aşağıda).

Testbench yalnızca kartın dışındaki dünyayı modeller: 1960 baytlık ses verisini
gerçek baud zamanlamasıyla (115200 baud, 434 çevrim/bit) UART hattına sürer.
Verinin YZ RAM'ine yazılması, çıkarımın başlatılması, kesmenin işlenmesi ve
sonucun 7-segment'e yazılması **CPU üzerinde koşan `main_app.c`** tarafından
yapılır.

Testbench: [`ai_accel_test.sv`](../../../../main_codes/testbench/System_Test/ai_accel_test.sv) ·
Proje: `scripts/project_gen/System_test/ai_accel_test.tcl` ·
Firmware: `make sim_app` → `sim_app.hex` ·
Simülatör: **XSim 2025.2** · Sistem saati: 50 MHz ·
Simülasyon süresi: **513,111 ms** (gerçek zamanda 1 sa 06 dk)

> **Ham çıktı: [`xsim_console.log`](xsim_console.log)**

---

## Özet

| Ölçüm | Sonuç |
|---|---|
| Senaryo | 3 (evet · hayır · sessizlik) + çerçeve resenkronizasyonu |
| Senaryo başına geçme/kalma kapısı | 6 (zaman aşımı · sınıf · sonuç satırı · `GPIO_ODR` · FC skorları · softmax skorları) |
| Geçen kapı | **24 / 24** |
| Geçen | **4 / 4** (üç sınıf + kurtarma sonrası tekrar) |
| Kalan | 0 |
| FC skor karşılaştırması | **açık** (`CHECK_SCORES=1`), 12 skorun 12'si bit-exact |
| Çıkarım gecikmesi | **45.517 çevrim** (üç senaryoda da aynı) |
| 50 MHz'de | 910,3 µs → **1098,5 çıkarım/s** |
| AXI protokol ihlali | **0** |
| Uyarı (stall/watchdog) | 0 |
| İzlenen AXI arayüzü | **15** |
| Zaman aşımı | yok (1,5 s global watchdog'a girilmedi) |

---

## Senaryolar

| # | Senaryo | Girdi (1960 bayt) | Sınıf | `GPIO_ODR` | FC skorları (bit-exact) | Sonuç |
|---|---|---|:---:|:---:|---|---|
| 1 | EVET | `input_data_yes.hex` | 2 | 7 | `-58032 · 21583 · 48674 · -4777` | **GEÇTİ** |
| 2 | HAYIR | `input_data_no.hex` | 3 | 8 | `-30588 · 7509 · 7419 · 18543` | **GEÇTİ** |
| 3 | SESSİZLİK | `input_data_sessizlik.hex` | 0 | 9 | `427 · -518 · -94 · 186` | **GEÇTİ** |

### Senaryo başına dört kontrol

| Kontrol | Ne doğruluyor |
|---|---|
| **1. Hızlandırıcı sınıfı** | `conv_accelerator`'ın `out_ram_wdata` çıkışı beklenen sınıfı veriyor mu — **donanımın kendi kararı** |
| **2. `GPIO_ODR` (uçtan uca)** | Kesme → ISR → 7-segment eşlemesi zinciri tamamlandı mı; yani **yazılımın okuduğu** sonuç da doğru mu |
| **3. Dört FC skoru — bit-exact** | `fc_scores[0..3]` altın referansla **birebir** eşleşiyor mu. Yalnızca argmax kontrolü requantization (M0/SHR) hatalarını kaçırır: yanlış ölçeklenmiş skorlar da doğru sınıfı verebilir. Skor karşılaştırması kaçırmaz |
| **4. Zaman aşımı gözcüsü** | Çıkarım 400 ms'lik senaryo bütçesi içinde tamamlandı mı — takılan bir boru hattı sessizce "geçti" sayılamaz |

Dördü de `[KALDI]` üretip `n_fail`'i artırabilen **gerçek geçme/kalma
kapılarıdır**; üç senaryoda toplam 12 kapının 12'si geçmiştir. Çıkarım
gecikmesi bunlardan ayrı, bir **ölçümdür** (`[PERF]` satırı) — şartname
Tablo 3-1 "Sistem performansı" başlığının karşılığıdır ve aşağıda raporlanır.

---

## İzlenen boru hattı (EK-1 iş akışı)

Testbench yalnızca sonuca bakmaz, akışın her adımını işaretler. EVET senaryosu
için log'dan:

```
[TB] 1960 bayt gonderiliyor...
[P2] t=170121570000  LOAD_DONE (addr_cnt=0)
[P3] t=170123210000  ACCEL START
[P4] t=171033550000  ACCEL DONE, sinif=2
[P5] t=171033550000  INFER_IRQ -> CPU
[P6] FC_SCORES: [0]=-58032 [1]=21583 [2]=48674 [3]=-4777
[PERF] EVET: cikarim gecikmesi = 45517 cevrim  |  @50 MHz = 910.3 us  |  1098.5 cikarim/s
[GECTI] EVET: sinif=2, GPIO_ODR=7, 45517 cevrim
```

| İşaret | Şartname EK-1 iş akışındaki karşılığı |
|---|---|
| Boot + `UART_YZ_CPB=50` | *"SoC çekirdeği … UART'ın ve YZ hızlandırıcının CSR'larına konfigürasyonları yazmalıdır"* |
| `[TB] … bayt gonderiliyor` | *"UART-stream çevre birimi çıkarım yapılacak veriyi iletecek"* |
| `[P2] LOAD_DONE` | *"…ve bu veri istenilen hızlandırıcı bellek adresine yazılacaktır"* |
| `[P3]` → `[P4]` | *"Modelin veri girişi YZ hızlandırıcısı tarafından alınacak"*, çıkarım |
| `[P5] INFER_IRQ -> CPU` | *"Çıkarım tamamlandıktan sonra SoC çekirdeği bir kesme sinyali ile bilgilendirilecektir"* |
| `GPIO_ODR` + `[P7] YZ:<sınıf> S=…` | *"Son olarak çekirdek, kendi UART arayüzü üzerinden çıkarım sonucunu yazacaktır"* — testbench genel UART'ın TX pinini çözer, yani PC'nin gerçekten gördüğü baytı kontrol eder |
| `[P7]` skorları | EK-1 madde 4 (Softmax): kesme servisi FC akümülatörlerini requantize edip softmax'a çevirir; dört skor da satıra yazılır |
| `RESENKRONIZASYON` bloğu | Kesik çerçeve sonrası girdi RAM'i sayacının boşta kalma eşiğinde sıfırlandığı ve sonraki çerçevenin doğru sınıflandığı doğrulanır |

---

## Performans (Tablo 3-1 "Sistem performansı")

| Ölçüm | Değer |
|---|---|
| Çıkarım gecikmesi | **45.517 çevrim** (start → done) |
| 50 MHz'de süre | **910,3 µs** |
| Çıkarım hızı | **1098,5 çıkarım/s** |
| Girdi başına veri | 1960 bayt |
| Veri hızı | ≈ 2,15 MB/s (1960 B × 1098,5) |

Üç senaryoda da çevrim sayısı **aynıdır** (45.517). Bu beklenen sonuçtur:
hızlandırıcı veriye bağlı dallanma içermez, tap başına 1 çevrim işler; süre
girdinin içeriğine değil yalnızca boyutuna bağlıdır. Yazılım gerçeklemesiyle
kıyaslama ve **276,9× hızlanma** ölçümü ayrı bir koşumdadır:
[`../../../ai_accel_reports/`](../../../ai_accel_reports/).

---

## AXI protokol kontrolü — 15 arayüz

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

Arayüz başına gözlenen trafik:

| Arayüz | Yazma (AW/W/B) | Okuma (AR/R) | İhlal |
|---|---:|---:|---:|
| `CPU_INSTR_M` | 0 | 8.551.805 | 0 |
| `SPLITTER_S` | 0 | 8.551.805 | 0 |
| `BOOTROM_CPU` | 0 | 8.551.805 | 0 |
| `CPU_DATA_M` | 198 | 9.085 | 0 |
| `ICN_S0` | 198 | 9.085 | 0 |
| `UART_YZ` | 79 | 8.992 | 0 |
| `DATA_RAM` | 108 | 90 | 0 |
| `GPIO` | 6 | 0 | 0 |
| **`YZ_ACCEL`** | **5** | **3** | **0** |
| `TIMER` · `I2C` · `QSPI` · `UART_GU` · `INSTR_RAM` · `BOOTROM_ICN` | 0 | 0 | — trafik yok |

---

## Okurken dikkat edilecekler

- **`YZ_ACCEL` arayüzünde yalnızca 8 işlem olması azlık değil, tasarımın
  doğasıdır.** Hızlandırıcının CPU'ya bakan yüzü bir CSR arayüzüdür: yazılım
  birkaç register yazıp çıkarımı başlatır, kesmeyi bekler, sonucu okur. Asıl
  veri hacmi CPU üzerinden değil, **UART_YZ → DMA → YZ RAM** yolundan akar
  (8.992 okuma). Bu arayüzün register davranışı ayrıca UVM ortamında yedi test
  ile sınanır ([`../../../uvm/`](../../../uvm/)).
- **8,55 milyon komut getirme okuması, önbelleksiz mimarinin sonucudur.**
  CV32E40P'nin komut önbelleği yoktur; uygulama üç çıkarım boyunca kesme
  bekleyip durum yoklarken her komut ayrı bir AXI okumasıdır. Protokol
  kontrolcüsü bu okumaların **tamamını** denetlemiştir — bu koşum, tasarımın en
  yoğun AXI trafiği altında yapılan protokol doğrulamasıdır.
- **`INSTR_RAM`'de trafik yoktur, çünkü bu test boot zincirini kullanmaz.**
  Uygulama `sim_app.hex` olarak doğrudan Boot ROM'a yüklenir ve oradan koşar;
  flash → Instruction RAM yolunu doğrulayan test [`../Boot/`](../Boot/)'tur.
- **`FIN_02 BILGI` satırları ihlal değildir.** Simülasyon `$finish` ile
  bittiğinde CPU'nun uçuşta bir komut getirme isteği kalır; kontrolcü bunu
  reset sayısı ve outstanding limitiyle karşılaştırıp *"protokol ihlali DEGIL"*
  diye işaretler.
- **FC skorları eğitilmiş modelden bağımsız bir kanıt değildir.** Buradaki
  `EXP_SCORES` tablosu hızlandırıcının kendi önceki çıktısından dondurulmuştur;
  regresyon koruması için doğrudur, ama "RTL eğitilmiş modelle aynı mı?"
  sorusunu ayrı bir araç cevaplar:
  [`../../../ai_accel_reports/compare_rtl.log`](../../../ai_accel_reports/compare_rtl.log).
- **Koşum süresi.** Dört kez 1960 baytın 1 Mbps'te gerçek zamanlamayla
  sürülmesi 78 ms simülasyon zamanı, çerçeve senkronizasyon testindeki boşta
  bekleme 3 ms daha ekler; çıkarımın kendisi bunun yanında ihmal edilebilir
  (4 × 910 µs). Duvar süresi ~10 dakikadır.
