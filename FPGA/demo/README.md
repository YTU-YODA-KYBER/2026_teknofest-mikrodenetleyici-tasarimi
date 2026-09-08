# FPGA Demo — Arayüz Tanım Dokümanı (ICD) ve koşum

Final demosunda yarışma komitesinin `demo_harness.py` aracı bu klasördeki ICD
dosyasıyla kartımıza bağlanır. Araç iki seri portu **aynı anda** açar, 1960
baytlık çıkarım vektörlerini stream portundan gönderir ve sonucu core portundan
okur.

| Dosya | İçerik |
|---|---|
| `ytu_yoda_kyber_icd.json` | Teslim edilecek ICD. `validate` çıktısı uyarısız temizdir. |
| `results/` | Demo koşumlarının zaman damgalı çıktıları (koşum yapılınca oluşur) |

---

## Donanım kurulumu

```
   [ Bilgisayar ]                                   [ Nexys A7-100T ]

   stream port ──── 1960 bayt, 1 Mbps ────►  Pmod JC ─► UART_YZ ─► DMA ─► YZ RAM
                                                                            │
                                                                       hızlandırıcı
                                                                            │
   core port   ◄─── "YZ:<sınıf> S=…", 115200 ──  USB-UART ◄─ UART_GU ◄─ CV32E40P/ISR
```

- **core port** — kart üzerindeki FT2232 kanalı (mikro-USB). Bootloader'ın
  flasher'ı da bu portu kullanır.
- **stream port** — Pmod JC'ye takılan **Pmod USBUART** (FT232R, 3,3 V).
  `UART_YZ_TX` → JC2 (F6), `UART_YZ_RX` → JC3 (J2). Pin eşlemesi
  `main_codes/constraint/nexys_a7_soc.xdc` içindedir.

İki port `ls /dev/ttyUSB*` ile listelenir. Hangisinin hangisi olduğundan emin
değilsen Pmod'u çıkarıp listeyi tekrar al: kaybolan port stream'dir.

---

## ICD'de dikkat edilen noktalar

**`stream.payload.encoding` = `uint8_offset128`.** Aracın belgesi çoğu takım
için `int8` önerir; bizim için **yanlıştır**. Hızlandırıcı girdi zero-point'ini
−128 kabul edip RAM'den okuduğu baytı doğrudan `q + 128` olarak kullanır
(`conv_accelerator.v`), yani tel üzerindeki bayt offset-binary olmalıdır.
`int8` seçilseydi her vektör 0x80 kaydırılmış gelirdi ve tüm sınıflandırma
sessizce bozulurdu.

**Çerçeveleme yok.** Preamble, uzunluk alanı ve sağlama toplamı boştur; hat
üzerinde ham 1960 bayt akar. Senkronizasyon donanımda boşta kalma sayacıyla
kurtarılır: stream hattı 2 ms sessiz kalırsa yarım kalmış kayıt atılır
(`yz_bram_axi_ctrl.sv`). Bu, aracın `truncated_frame` ve `oversized_frame`
senaryolarının sayacı kalıcı olarak kaydırmasını engeller.

**Sonuç satırı** iki çeşittir:

| Satır | Anlamı |
|---|---|
| `YZ:B` | Vektör yüklendi, çıkarım başladı. ICD'de `ignore_regex` ile elenir. |
| `YZ:<sınıf> S=<s0>;<s1>;<s2>;<s3>` | Sınıf ve dört sınıfın softmax skoru (int8). Sıra: sessizlik; bilinmeyen; evet; hayır. |

Skorlar modelin softmax çıkışının nicemlemesindedir (scale 1/256, zp −128), yani
manifest'teki `golden_scores` ile doğrudan karşılaştırılabilir.

**İki farklı baud.** Stream 1 Mbps (`UART_CPB = 50`), core 115200
(`UART_CPB = 434`). Şartname Bölüm 4.2.2/3'ün istediği çok-baud desteği
böylece tek koşumda gösterilir.

---

## Koşum sırası

```bash
cd <demo_program_tr klasoru>

# 1) ICD doğrula -- uyarısız çıkmalı
python3 demo_harness.py validate -c .../FPGA/demo/ytu_yoda_kyber_icd.json

# 2) Sentetik vektörlerle gerçek kart provası -- zaman aşımı olmamalı
python3 demo_harness.py run -c .../ytu_yoda_kyber_icd.json -n 50

# 3) Örnek veri kümesi -- golden uyumu ve skor hatası
python3 demo_harness.py run -c .../ytu_yoda_kyber_icd.json \
        --manifest public_dataset/manifest.csv

# 4) Sağlamlık senaryoları
python3 demo_harness.py run -c .../ytu_yoda_kyber_icd.json --only-robustness

# 5) KRİTİK: 4'ten hemen sonra, kartı RESETLEMEDEN 3'ü tekrar koş.
#    Golden uyumu düşmüyorsa çerçeve senkronizasyon kurtarma çalışıyordur.
```

> `--dry-run` bizim sonuç formatımızı sınamaz: aracın sahte cihazı
> `regex_line` modunda her zaman kendi `RESULT: …` satırını üretir, takımın
> regex'ine uyarlanmaz. Protokolün ICD tarafı bunun yerine aracın kendi
> `ResultParser` ve `FrameBuilder` sınıflarına doğrudan verilerek sınandı.

Her koşum `results/<TAKIM>_<zaman>/` altına `report.md`, `summary.json`,
`samples.csv`, `robustness.csv`, `transcript.log` ve `config_used.json` yazar;
demo dokümanı bölüm 6 bu altı dosyayı ister.

---

## Koşum öncesi simülasyonda ölçülen beklenti

156 örneklik açık veri kümesi, RTL simülasyonunda (`compare_rtl.py`,
iverilog) uçtan uca koşuldu ve hızlandırıcının ürettiği ham FC
akümülatörleri kesme servisindeki requantization + softmax zincirinden
geçirildi:

| Ölçüm | Sonuç |
|---|---|
| Golden sınıf uyumu | **156 / 156 (%100)** |
| Skorların golden ile birebir aynı olduğu örnek | 155 / 156 |
| En büyük tek skor sapması | 4 LSB (1 LSB = 1/256) |
| Golden skor hata oranı (MAE) | **%0,0050** |
| Çıkarım gecikmesi | 45.517 çevrim = 0,910 ms @ 50 MHz |

Sınıfın kesme servisindeki softmax çıkışından türetilmesi bu sonucun bir
parçasıdır: hızlandırıcının ham int32 argmax'ı 155/156 verir. Aradaki tek
örnekte (`go_274c008f_nohash_0`) iki akümülatör requantization sonrası aynı
int8 değerine iner; referans model eşitlikte ilk sınıfı seçer, ham int32
karşılaştırması ise seçmez.

Kart üzerindeki gerçek koşum bu tabloyu doğrulamak içindir.
