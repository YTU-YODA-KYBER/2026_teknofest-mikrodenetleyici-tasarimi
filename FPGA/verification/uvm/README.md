# UVM Doğrulama Sonuçları

Yedi AXI4-Lite bloğu (altı çevre birimi + YZ hızlandırıcının CSR arayüzü) için
kurulan UVM ortamının **regresyon ve kapsam çıktıları**. Doğrulama kodunun
kendisi burada değil, [`main_codes/testbench/uvm/`](../../main_codes/testbench/uvm/)
altındadır; bu klasör yalnızca kanıt tutar.

Simülatör: **Verilator 5.050** · UVM: **2020.3.1 (no-DPI)** · Ölçüm tarihi: **2026-08-21**

> **Başlangıç noktaları:** regresyon için [`regression_summary.md`](regression_summary.md),
> kapsam için [`coverage/index.html`](coverage/index.html) ve
> [`coverage/functional.md`](coverage/functional.md), bulunan RTL sorunları için
> [`findings.md`](findings.md).

---

## Özet

| Ölçüm | Sonuç |
|---|---|
| Blok | **7** (GPIO, Timer, UART_GU, UART_YZ, I2C, QSPI, YZ CSR) |
| Test | **73** |
| Koşum | **219** (test × 3 tohum) |
| Geçen | **219 / 219** |
| AXI protokol ihlali | **0** ¹ |
| Uyarı (stall watchdog) | 6 ¹ |
| Fonksiyonel kapsam | **35 / 35 ölçülebilir bin → %100** ² |
| Satır kapsamı (tasarım) | **1292 / 1341 → %96,3** |
| Toplam regresyon süresi | 0,6 dakika (20 çekirdek, 7 paralel iş) |

¹ Sayılara `gpio_stress_test` dahil değildir. O test bilerek başarısızdır ve
  bir RTL bulgusunu gösterir; ürettiği 3 ihlal ile 2 uyarı bulgunun kendisidir
  ([`findings.md`](findings.md) madde 1).

² İki bin (`slverr`, `decerr`) **erişilemez** olarak işaretlenmiştir ve paydadan
  çıkarılmıştır; gerekçesi aşağıda.

---

## Klasör yapısı

```
verification/uvm/
├── README.md                → bu dosya
├── regression_summary.md    → test × tohum matrisi, blok özeti, süreler
├── regression_results.csv   → aynı veri makine okunur halde
├── test_plan.md             → hangi test neyi kapsıyor, şartname eşlemesi
├── findings.md              → bulunan RTL sorunları ve tekrar üretme adımları
│
├── coverage/
│   ├── index.html           → satır kapsamı raporu (genhtml) — buradan başlayın
│   ├── functional.md        → covergroup bin tablosu + dosya bazında satır kapsamı
│   ├── tasarim.info         → lcov biçiminde ham kapsam verisi
│   ├── AI_Accelerator/      ┐
│   └── Peripherals/         ┘ satır satır HTML detay
│
└── logs/
    ├── smoke/               → araç kapı testlerinin çıktısı (aşağıda)
    ├── gpio/  timer/  uart_gu/  uart_yz/  i2c/  qspi/  yz_csr/
    └── <blok>/<test>_seed<N>.log
```

---

## Blok bazında sonuçlar

| Blok | Taban adres | Test | Koşum | Geçen | AXI ihlali | Satır kapsamı |
|---|---|---:|---:|---:|---:|---:|
| GPIO | `0x4001_0000` | 9 | 27 | 27 | 0 ¹ | %93,4 |
| Timer | `0x4000_0000` | 9 | 27 | 27 | 0 | %97,1 |
| UART_GU | `0x4004_0000` | 12 | 36 | 36 | 0 | %98,2 |
| UART_YZ | `0x4005_0000` | 13 | 39 | 39 | 0 | %98,3 |
| I2C Master | `0x4002_0000` | 12 | 36 | 36 | 0 | %97,5 |
| QSPI Master | `0x4003_0000` | 11 | 33 | 33 | 0 | %95,0 |
| YZ CSR | `0x4006_0000` | 7 | 21 | 21 | 0 | %100,0 |
| **Toplam** | — | **73** | **219** | **219** | **0** | **%96,3** |

Test listesi ve her testin ne kapsadığı [`test_plan.md`](test_plan.md)'dedir.

---

## Bu dosyalar neyi kanıtlıyor

Şartname, çevre birimlerinin ve YZ hızlandırıcının AXI arayüzlerinin
SystemVerilog + UVM ile doğrulanmasını, regresyon ve kapsam sonuçlarının
raporlanmasını istiyor. Karşılığı şudur:

- **Her AXI işlemi transaction olarak paketlenir.** Pasif monitör, telde ne
  olduğunu (sürücünün ne yapmak istediğini değil) okur ve `axil_item` nesnesi
  üretir. Scoreboard ve kapsam toplayıcı yalnızca bu akışı görür.
- **Scoreboard bir referans modele karşı kontrol eder.** Gölge register
  dosyası her bloğun gerçek semantiğiyle özelleştirilmiştir: donanımın
  kırptığı yazma (`I2C_NBY`), kendini sıfırlayan register (`QSPI_FCR`,
  `TIM_CLR`), tüketen okuma (`QSPI_DR`), donanımın sürdüğü bayraklar.
- **Register modeli `uvm_reg`'dir.** `firmware/soc.h`'tan birebir türetilmiş
  blok modelleri, adapter ve predictor ile bağlanır.
- **Karşı taraf gerçek protokol konuşur.** I2C slave'i START/STOP/repeated-START
  koşullarını hattan çözer; UART agent'ı gerçek baud zamanlamasıyla çerçeve
  basar; QSPI flash responder'ı x1/x2/x4 komutları işler.
- **Rastgele uyaranla regresyon koşulur** ve fonksiyonel + satır kapsamı
  toplanır.
- **Mevcut AXI protokol kontrolcüsü ortamın içine alınmıştır:** 40 kurallık
  `axi4lite_protocol_checker` her bloğa `bind` ile bağlıdır ve sayacı
  testin `report_phase`'inde UVM hatasına çevrilir.

---

## Nasıl üretildi

### Araçlar

Verilator, **5.050** sürümünden itibaren covergroup / coverpoint / bins
desteklediği için bu sürüm kaynaktan derlenmiştir (`/usr/Verilator_uvm`).
UVM olarak Verilator deposunun kendi düzleştirilmiş **UVM 2020.3.1 (no-DPI)**
paketi kullanılır — Verilator ekibinin kendi sürekli tümleştirmesinde koşturduğu
sürüm olduğu için uyumluluk riski en düşük seçenektir. Kısıtlı randomizasyon
için **z3** SAT çözücüsü gerekir.

### Koşum

```
source /usr/Verilator_uvm/env.sh
cd main_codes/testbench/uvm

make smoke                                  # araç kapı testleri (5 madde)
make build BLK=gpio                         # tek blok derle
make run   BLK=gpio TEST=gpio_reset_test    # tek test koştur
make regression                             # 7 blok × 73 test × 3 tohum
make coverage                               # kapsam raporunu üret
```

`make regression` bu klasördeki `regression_summary.md` ve
`regression_results.csv` dosyalarını; `make coverage` ise `coverage/`
altındakileri yeniden üretir. Loglar buraya elle kopyalanır (proje bilerek
otomasyonsuzdur; koşucu betikler testbench altyapısıdır, rapor üreteci değil).

### Araç kapı testleri (smoke)

Yedi bloğun ortamı yazılmadan önce, simülatörün bu tasarımın ihtiyaç duyduğu
beş dil özelliğini gerçekten kaldırdığı kanıtlanmıştır. Çıktısı
[`logs/smoke/`](logs/smoke/) altındadır.

| # | Ne kanıtlıyor | Sonuç |
|---|---|---|
| 1 | UVM çekirdeği ayakta (faz, factory, objection, raporlama) | GEÇTİ |
| 2 | `bind` çalışıyor — protokol kontrolcüsü gerçek GPIO RTL'ine bağlanıyor | GEÇTİ |
| 3 | SVA çalışıyor — kontrolcünün 33 `assert property`'si derlenip koşuyor | GEÇTİ |
| 4 | covergroup çalışıyor — 37 bin kapsam çıktısında görünüyor | GEÇTİ |
| 5 | `uvm_reg` ayakta — `write` / `read` / `mirror` + predictor | GEÇTİ |

---

## Okurken dikkat edilecekler

- **`gpio_stress_test` bilerek başarısızdır.** GPIO'nun işlem kabul koşulu
  kendi `awready`/`arready`'siyle nitelenmemiştir; boru hatlı bir master
  bloğu kilitler. Test bu kilitlenmeyi gösterir, dolayısıyla KALDI çıkması
  **doğru** sonuçtur. Aynı stres testi diğer altı blokta temiz geçer —
  sorun GPIO'ya özgüdür. Ayrıntı ve tekrar üretme adımları
  [`findings.md`](findings.md)'dedir.

- **`slverr` ve `decerr` bin'leri hiçbir zaman dolmaz.** Tasarımdaki hiçbir
  AXI4-Lite slave'i hata cevabı üretmiyor; `bresp`/`rresp` sabit `OKAY`.
  Adres aralığı kontrolü yalnızca interconnect seviyesindedir. Bu bin'ler
  kapsam raporunun tasarımın hangi davranışları **üretemediğini** de
  göstermesi için bilerek tanımlanmıştır ve yüzde hesabında paydadan
  çıkarılmıştır.

- **Verilator iki durumludur; `X` yoktur.** Bu yüzden protokol kontrolcüsünün
  `XCK_01..07` (X/Z) kuralları bu ortamda ölüdür ve sürülmeyen `bresp`/`rresp`
  sınıfındaki sorunlar burada **görünmez**. O bulgunun kaynağı ASIC
  (Yosys/LibreLane) akışıdır; X kontrolü XSim tarafında yapılmaktadır.

- **Bu kapsam, `vivado_reports/code_coverage/`'ın yerine geçmez.** İkisi
  farklı araçla (Verilator ↔ XSim), farklı uyaranla ve farklı metriklerle
  ölçülmüştür; doğrudan kıyaslanmamalıdır. İki bağımsız aracın aynı bloklar
  için uyumlu sonuç vermesi kanıtın gücünü artırır, birbirinin yerini almaz.

- **GPIO'nun satır kapsamı (%93,4) 7-segment animasyonu yüzünden %100 değildir.**
  Mesaj tablolarının tamamı `gpio_display_test` ile taranır, ancak ilk iki
  basamaktaki animasyon kareleri `anim_select`'e bağlıdır ve o sayaç 5 milyon
  çevrimde bir ilerler: sekiz karenin tamamı 40 milyon çevrim (50 MHz'de
  800 ms) simülasyon ister. Regresyona konmamıştır; animasyon kareleri XSim
  tarafındaki mevcut blok testbench'inde iç sinyaller zorlanarak taranır.

- **QSPI flash modeli hafiftir.** Flash protokolünün tam doğrulaması gerçek
  Micron MT25QL256 modeliyle XSim tarafında yapılmıştır ve o kanıt yerinde
  durmaktadır. Buradaki model, master'ın **ürettiği** komut/adres/veri
  akışının doğruluğunu ve okunan verinin RX FIFO'ya doğru düşmesini
  doğrular; hata enjeksiyonu ve rastgele veri için Verilator'da koşabilen
  bir karşılık olarak yazılmıştır.

- **I2C testlerinin uzun sürmesi normaldir.** SCL 400 kHz civarındadır ve
  bir transfer yüzlerce mikrosaniye alır. Ayrıca çekirdek transfer boyunca
  `awready`/`wready`'yi düşük tutar; bu yüzden testler durum bayraklarını
  **okuma** ile yoklar (okuma yolu bloklanmaz).

- **Log dosyaları koşum başınadır.** `logs/<blok>/<test>_seed<N>.log`
  düzenindedir; her birinin sonunda AXI protokol özeti ve UVM test özeti
  bulunur.
