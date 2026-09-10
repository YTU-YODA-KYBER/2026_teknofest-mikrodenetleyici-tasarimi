# TEKNOFEST 2026 Çip Tasarım Yarışması — Mikrodenetleyici Kategorisi
## FPGA Demo Test Aracı

Final demosunda tasarımınız bu araca bağlanacak. Elinizdeki sürüm, demo günü
kullanılacak olanla **aynı protokol kodunu** içerir: çerçeveleme, sağlama toplamı,
sonuç ayrıştırma ve ICD doğrulama fonksiyonları birebir aynıdır.

**Amacı:** Arayüz Tanım Dokümanınızı (ICD) doldurup **kendi FPGA'nız üzerinde önceden
test etmeniz**, demo günü çıkabilecek aksaklıkları şimdiden görmeniz.

> Demo gününde kullanılacak vektörler bu pakette **yoktur**. Buradaki testler
> arayüzünüzün doğru çalıştığını gösterir, sınıflandırma başarımınızı değil.

---

## 1. Kurulum

```bash
python -m pip install pyserial
python demo_harness.py --version
```

Python 3.9+ gerekir. Grafik arayüz için `tkinter`: Windows ve macOS kurulumlarında
gömülü gelir, Debian/Ubuntu'da `sudo apt install python3-tk`.

| Dosya | Ne işe yarar |
|---|---|
| `demo_harness.py` | Komut satırı test aracı + ICD şablonu ve doğrulayıcı |
| `demo_gui.py` | Aynı aracın grafik arayüzü |
| `OKUBENI.md` | Bu dosya |

---

## 2. Beş dakikada ilk çalıştırma

```bash
# 1) Boş ICD şablonu üret (her alanın açıklaması içinde)
python demo_harness.py template -o takimadi_icd.json

# 2) Donanım olmadan aracı tanıyın (sahte cihazla çalışır)
python demo_harness.py run --dry-run -n 10

# 3) Grafik arayüz
python demo_harness.py gui -c takimadi_icd.json
```

`--dry-run` modundaki sahte cihaz, `stream.framing` alanındaki preamble, index, length,
checksum ve trailer ayarlarını kullanarak gelen çerçeveyi çözer. Böylece ham 1960 bayt
dahil kendi stream çerçeve yapınızı donanım olmadan sınayabilirsiniz.

Pencere başlığında `[YARISMACI]` ibaresi ve sürüm numarası yazar. Görmüyorsanız
yanlış veya eski bir kopya çalıştırıyorsunuz.

---

## 3. Bağlantı

Araç **iki ayrı seri porta** bağlanır. Şartnamedeki iki UART bunlardır:

```
   [ Bilgisayar ]                              [ FPGA kartınız ]

   UART-stream  ─── 1960 baytlık vektör ───►   YZ hızlandırıcı
                                                     │
                                                 (çıkarım)
                                                     │
   core UART    ◄─── sonuç satırı ──────────   CV32E40P / ISR
```

- **UART-stream** — çıkarım verisinin hızlandırıcıya sürüldüğü arayüz (şartname EK-1).
- **core UART** — çekirdeğin kesme rutininde çıkarım sonucunu yazdırdığı genel amaçlı UART.

İkisi **ayrı fiziksel port** olmalıdır; araç ikisini aynı anda açar. Tek USB-UART
köprüsü kullanıyorsanız demo öncesi ikinci bir kanal çıkarın.

---

## 4. ICD dosyası

`template` komutunun ürettiği JSON kendi kendini açıklar. Her bölümde `_bilgi`
(bölümün ne olduğu) ve `_alanlar` (her alanın anlamı, alabileceği değerler, örnek)
blokları vardır. Alt çizgiyle başlayan anahtarlar program tarafından yok sayılır,
silmeniz gerekmez.

Dosyanın sonundaki `_ornekler` bölümünde hazır kalıplar var: ASCII satır, sayısal
etiketli satır, JSON, CSV, ikili kayıt ve üç çerçeveleme varyantı. Kendi çıktınıza en
yakın olanı ilgili bölüme kopyalayın.

### Doldurmanız gereken dört blok

**`stream.port` / `core.port`** — port adı, baud, parity, stop biti, akış kontrolü.
Port adlarını kendi makinenize göre yazın; demo günü yalnızca bu iki alan hedef
makineye göre değiştirilir, gerisi aynı kalır.

**`stream.framing`** — bir çerçeve şu sırayla kurulur:

```
[preamble] [index] [length] [payload] [checksum] [trailer]
```

Kullanmadığınız alanı boş bırakın (hex için `""`, boyut için `0`). Hiç çerçeveleme
kullanmıyorsanız (ham 1960 bayt): hepsi boş/sıfır ve `checksum: "none"`.

**`stream.payload`** — `length` 1960; `encoding` her elemanın tel üzerindeki biçimidir:
`int8` (TFLite int8 nicemleme; çoğu takım için doğrusu budur), `uint8_offset128`
veya `uint8_raw`.

**`core.result`** — sonucun nasıl okunacağı. Dört mod var, yalnızca kullandığınızın
alanlarını doldurun:

| mod | örnek çıktı |
|---|---|
| `regex_line` | `RESULT: yes scores=-12,3,120,-8` |
| `json_line` | `{"label":"no","scores":[-5,0,10,118]}` |
| `csv_line` | `2,-12,3,120,-8` |
| `binary_fixed` | `5A 5A 02 F4 03 78 F8` |

Cihazınız sayısal etiket yazıyorsa `label_map` doldurun:
`{"0":"silence","1":"unknown","2":"yes","3":"no"}`. `classes` sırası şartname EK-1
ile aynı olmalıdır: **silence, unknown, yes, no**.

`ignore_regex` ile boot ve hata ayıklama satırlarını eleyin (örn. `^(BOOT|INFO|DBG)`),
yoksa bunlar sonuç sanılabilir.

### Doğrulama

```bash
python demo_harness.py validate -c takimadi_icd.json
```

Yakaladıkları: aynı porta atanmış iki arayüz, geçersiz parity/checksum/mod, 1960 baytı
ifade edemeyecek uzunluk alanı, `(?P<label>...)` grubu olmayan regex, `classes` dışında
kalan `label_map` değeri, bozuk hex dizisi, derlenmeyen regex.

**Hatalı bir ICD ile koşum başlamaz.** Teslim edeceğiniz dosyada `validate` çıktısı
temiz olmalıdır.

---

## 5. Çıktı formatınızı tanımlayamıyorsanız

```bash
python demo_harness.py probe --core-port COM4 --core-baud 115200 --seconds 20 --save core.raw
```

Core UART'ı dinler, ham çıktıyı ekrana basar ve dosyaya kaydeder. Gördüğünüz satıra
göre `core.result` bölümünü doldurun. GUI'de aynı işlev "Probe" düğmesindedir.

---

## 6. Gerçek FPGA ile test

Kartınızı bağlayın, ICD'yi doldurun, manifest vermeden çalıştırın — araç sentetik
vektörler üretir:

```bash
python demo_harness.py run -c takimadi_icd.json -n 50
```

Bu koşum şunları doğrular: portlar açılıyor mu, çerçeveniz doğru çözülüyor mu, her
vektöre yanıt geliyor mu, sonuç satırı ayrıştırılabiliyor mu, gecikme ne kadar.

> Sentetik vektörler rastgeledir, sınıflandırma sonucunun bir anlamı yoktur. Burada
> baktığınız şey **zaman aşımı olmaması** ve **her satırın ayrıştırılabilmesi**.

### Örnek veri seti

Bu paketle birlikte küçük bir **etiketli örnek veri seti** verilmektedir. Demo gününde
kullanılacak set değildir; sisteminizi uçtan uca sınamanız içindir.

```bash
python demo_harness.py run -c takimadi_icd.json --manifest public_dataset/manifest.csv
```

Manifest biçimi:

```csv
file,name,truth,golden,golden_scores,golden_probs
vectors/ornek_0001.bin,ornek_0001,yes,yes,-128;-128;127;-128,0.0000;0.0000;0.9961;0.0000
```

| Sütun | Anlamı |
|---|---|
| `file` | Vektör dosyası, manifest'e göre göreli yol (1960 bayt) |
| `name` | Rapor ve CSV'de görünecek ad |
| `truth` | Gerçek etiket — **yalnızca bilgi**, puanlamada kullanılmaz |
| `golden` | Referans modelin bu vektör için ürettiği sınıf — **birincil ölçüt budur** |
| `golden_scores` | Referans modelin dört sınıf için ham int8 çıkışları (silence;unknown;yes;no) |
| `golden_probs` | Aynı çıkışların 0..1 ölçeğindeki karşılığı |

Araç `golden` sütunuyla sınıf uyumunu ölçer. Core UART çıktınız dört skoru da içeriyorsa,
`golden_scores` / `golden_probs` ile sayısal karşılaştırma da otomatik yapılır ve
**golden skor hata oranı (MAE)** ek bilgi olarak rapora yazılır. Bu değer puanlamada
kullanılmaz.

Vektörler `int8` kodludur. ICD'nizde `stream.payload.encoding` farklıysa araç dönüşümü
kendisi yapar, bir şey değiştirmenize gerek yok.

### Skor karşılaştırması

Sınıf uyumu yalnızca argmax'a bakar. Donanımınız core UART üzerinden dört sınıf
skorunu da gönderiyorsa araç bunları manifest'teki referans skorlarla karşılaştırır.
`report.md`, `summary.json` ve `samples.csv` içinde skor hata bilgisi yer alır.

- **0'a yakın hata** sayısal olarak referansa yakın çıkış demektir.
- Argmax aynı olsa bile yüksek skor hatası nicemleme, taşma veya birikeç genişliği
  gibi bir soruna işaret edebilir.
- Karşılaştırma sınıf sırasını `core.result.classes` alanından alır.

UART skorları ham int8 (`-128..127`) veya 0..1 olasılık biçiminde olabilir; araç iki
biçimi de referans olasılık ölçeğine çevirerek ortalama mutlak hata hesaplar.

### Kendi büyük regresyon setinizi kurun

Verilen set küçüktür ve yalnızca örnektir. Ciddi bir doğrulama için binlerce
1960-elemanlı int8 vektörü RTL simülasyonunda kendi bilinen-doğru referansınızla
karşılaştırmanız önerilir. Demo aracı bu harici regresyon akışını zorunlu tutmaz.

---

## 7. Değerlendirme ekseni: golden uyumu

**Ölçülen şey modelin doğruluğu değil, modelin RTL'e doğru implementasyonudur.**

Birincil ölçüt, donanımınızın ürettiği sınıfın *aynı vektör için referans (golden)
modelin ürettiği* sınıfla eşleşmesidir:

- Golden `yes` derken donanımınız da `yes` diyorsa, gerçek etiket `no` olsa bile
  **uyumludur** — modelin hatası size yazılmaz.
- Donanımınız golden'dan sapıyorsa, tesadüfen doğru etiketi tutturmuş olmanız
  sizi kurtarmaz.

Raporda `truth` sütunu görünür ama "puanlamada kullanılmaz" notuyla, yalnızca
bilgi amaçlıdır.

Referans, tflite-micro deposundaki önceden eğitilmiş int8 Micro Speech modelidir
(`models/micro_speech_quantized.tflite`). RTL'inizi bu modele karşı doğrulamanız beklenir.

Girdi biçimi: 49 zaman adımı × 40 frekans bölmesi = **1960 int8**, satır sırası
(time-major) korunur.

---

## 8. Sağlamlık senaryoları

Demoda arayüzünüz aşağıdaki durumlara karşı da denenir. Hepsini şimdiden
çalıştırabilirsiniz:

```bash
python demo_harness.py run -c takimadi_icd.json --only-robustness
```

| Senaryo | Ne yapar | Beklenen |
|---|---|---|
| `silence_zeros` | tamamen sıfır vektör | çökmeden sonuç üretir |
| `silence_dither` | çok düşük seviyeli gürültü | sonuç üretir |
| `saturate_max` / `saturate_min` | tüm değerler +127 / −128 | taşma yaşanmaz |
| `alternating` | +127/−128 dizisi | en kötü durumda çalışır |
| `back_to_back` | beklemesiz 5 çerçeve | hepsi yanıtlanır (FIFO / el sıkışma) |
| `truncated_frame` | eksik çerçeve gönderilir | sonraki geçerli çerçeve yanıtlanır |
| `oversized_frame` | fazladan bayt eklenir | senkronizasyon geri kazanılır |
| `peripheral_interleave` | çıkarımlar arasında çevre birimi kullanılır | **opsiyonel**; tanımlıysa reset'siz dönüş kontrol edilir |
| `determinism` | aynı vektör 10 kez | sonuç her seferinde aynı |
| `recovery_after_idle` | 3 sn boşta bekleme | yanıt vermeye devam eder |

`peripheral_interleave` **opsiyonel** bir ek sağlamlık testidir. Kullanmak isterseniz
`hooks.interleave_core_hex` alanına iki çıkarım arasında çalıştırılacak çevre birimi
komutunun baytlarını yazın. Alan boş bırakılırsa senaryo kaldırılmaz; **SKIP / ATLANDI**
olarak raporlanır ve sağlamlık başarı oranına dahil edilmez.

---

## 9. Kancalar (`hooks`)

Hiçbiri tasarım değişikliği gerektirmez, hepsi isteğe bağlıdır:

| Alan | Ne için |
|---|---|
| `boot_banner_regex` | kart açılışta mesaj yazdırıyorsa; araç koşum öncesi bunu bekler |
| `boot_trigger_core_hex` | kart banner'ı bir komutla yazdırıyorsa (örn. `'v'` → `76`) |
| `core_init_hex` / `stream_init_hex` | koşum başında bir kez gönderilecek baytlar |
| `pre_frame_core_hex` | her çerçeveden önce gönderilecek baytlar |
| `interleave_core_hex` | yukarıdaki sağlamlık senaryosu için |

**Banner uyarısı:** araç portu açarken bekleyen giriş tamponunu temizler. Kartınız
banner'ı bağlantıdan önce basıyorsa yakalanamaz. Üç çözüm: `boot_trigger_core_hex`
tanımlayın, kartı araç başladıktan sonra resetleyin, ya da
`core.port.flush_input_on_open` değerini `false` yapın.

---

## 10. Çıktılar

Her koşum `results/<TAKIM>_<zaman>/` altına yazar:

| Dosya | İçerik |
|---|---|
| `report.md` | özet, uyum matrisi, senaryo tablosu, ayrışan örnekler |
| `samples.csv` | örnek bazlı ham kayıt |
| `robustness.csv` | senaryo sonuçları |
| `summary.json` | makine okunabilir özet |
| `transcript.log` | core UART ham çıktısı |
| `config_used.json` | CLI/GUI değişiklikleri dahil koşumda kullanılan **etkin ICD** |

Sorun ararken en faydalısı `transcript.log`'dur: cihazınızın gerçekte ne yazdığını
gösterir. Sonuçlar boş çıkıyor ama transcript doluysa, sorun neredeyse her zaman
`core.result` ayarlarındadır (satır sonu, regex, `label_map`).

---

## 11. Demo öncesi kontrol listesi

- [ ] `validate` çıktısı hatasız
- [ ] İki ayrı fiziksel UART, ikisi aynı anda açılabiliyor
- [ ] 50+ vektörlük koşumda **hiç zaman aşımı yok**
- [ ] Her sonuç satırı ayrıştırılıyor (`samples.csv`'de boş `predicted` yok)
- [ ] `--only-robustness` ile zorunlu senaryoların tamamı geçiyor
- [ ] İsteniyorsa `peripheral_interleave` için `hooks.interleave_core_hex` doldurulmuş
- [ ] Boot banner'ı yakalanıyor (ya da `boot_banner_regex` bilinçli boş)
- [ ] `stream.payload.encoding`, vektörlerinizi ürettiğiniz kodlamayla aynı
- [ ] Örnek veri setiyle golden uyum oranı ölçülmüş
- [ ] Core UART skor üretiyorsa golden skor hata oranı kontrol edilmiş
- [ ] Kendi büyük regresyon setinizle RTL simülasyonda doğrulama yapılmış
- [ ] Teslim edeceğiniz ICD, bu koşumların yapıldığı dosyanın aynısı

---

## 12. Sık karşılaşılan sorunlar

**"Sonuç gelmiyor ama probe'da görüyorum."** Satır sonu uyuşmazlığı. `line_terminator`
değerinizi (`\n` / `\r\n`) cihazınızın gerçekte yazdığıyla karşılaştırın.

**"İlk çerçeve çalışıyor, sonrakiler zaman aşımı."** Çerçeve senkronizasyonu kayıyor.
`preamble_hex` kullanın ve kesik/fazla bayt durumunda tamponu atacak bir idle zaman
aşımı ekleyin.

**"Uyum çok düşük ama sistem çalışıyor."** Genellikle `payload.encoding`
uyuşmazlığıdır: `int8` yerine `uint8_offset128` beklerseniz tüm vektör 128 kayar.

**"Port açılmıyor."** Başka bir terminal programı (PuTTY, Tera Term, Arduino Serial
Monitor) portu tutuyor olabilir.

**"csv_line modunda saçma sonuçlar görünüyor."** Banner/debug satırlarınız sonuç
sanılıyor olabilir; `ignore_regex` tanımlayın.

---

## 13. Sorular

Yarışma e-posta grubundan iletin. Bu araçla ilgili bir hata bulursanız
`transcript.log`, `config_used.json` ve `summary.json` dosyalarını ekleyin.
