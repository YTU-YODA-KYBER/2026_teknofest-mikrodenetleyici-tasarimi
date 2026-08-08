# scripts/yz_accuracy — YZ Doğruluk Kıyası (kart üzerinde)

Şartmanenin *"yazılım ile gerçeklenen modelin doğruluğunu %10'luk bir pencere
dahilinde yakalama"* maddesinin kanıt paketi. Etiketli bir ses kümesini karta
gönderip **hızlandırıcının** ve **CPU'da koşan TFLite yazılım gerçeklemesinin**
doğruluk oranlarını karşılaştırır.

```bash
cd scripts/yz_accuracy

# 1) asıl ölçüm: kart bağlı, yz_bench bitstream'i yüklü, SW1=1 SW0=0
python3 run_accuracy.py --dataset dataset --board --port /dev/ttyUSB1

# 2) çapraz kontrol: aynı modeli host'ta koştur (kart gerekmez)
python3 run_accuracy.py --dataset dataset --host

# 3) kaydedilmiş sonuçlardan sadece rapor
python3 run_accuracy.py --dataset dataset --report
```

> Kart koşusundan önce: `cd firmware && make bench`, ardından Vivado'da
> `scripts/project_gen/System_test/yz_bench_test.tcl` ile sentez + bitstream.
> Bu senaryo 32 KB Boot ROM + 32 KB Data RAM ister; ihtiyaç **ana projeye
> yazılmaz**, TCL'in generic'lerinden ve `firmware/linker_bench.ld`'den gelir.

---

## Ölçülen sonuçlar (2026-08-08, 156 örnek)

| Metrik | Yazılım (CV32E40P) | Donanım (YZ accel) |
|---|---|---|
| accuracy | **%91,03** (142/156) | **%91,03** (142/156) |
| çıkarım süresi | 12.608.381 çevrim (252,2 ms) | 45.540 çevrim (0,911 ms) |

- **%10 penceresi:** fark **0,00 puan** / **%0,00 bağıl** → her iki okumada da geçer.
- **Örnek-başı uyum:** %99,36 (155/156). Tek ayrışan örnekte iki taraf da yanlış,
  sadece farklı yanlış — doğruluk oranlarına etkisi yok.
- **Hızlanma:** **276,9×** (aynı koşumdan, aynı sayaçla).

Yazılım tarafı hesap değil **bellek** sınırlıdır: MAC başına ~37,5 çevrim, çünkü
CV32E40P'nin önbelleği yok ve her ağırlık okuması ayrı bir AXI4-Lite
gidiş-dönüşü. Hızlandırıcı ise ağırlıklarını 64-bit geniş kendi BRAM ROM'undan
tek okumada alıp tap başına 1 çevrim işliyor (500×80 + 4000 + kurulum = 45.517).

> Ölçümün kalibrasyonu: testbench'in bağımsız sayacı hızlandırıcıyı 45.517
> çevrim ölçtü, uygulamanın `mcycle`'ı 45.540 dedi. Aradaki 23 çevrim START
> yazması + durum yoklamasının AXI maliyetidir. `mcycle` donanımda tutuyorsa
> aynı sayaçtan gelen yazılım rakamı da kalibredir.

---

## Ne ölçüyor?

**Sınıflandırma doğruluğu** — softmax skorlarının doğruluğu değil:

```
accuracy = doğru sınıflandırılan örnek / toplam örnek
```

Şartname *"iki taraf %90 aynı cevabı versin"* demiyor; **iki tarafın doğruluk
oranları arasındaki fark** %10'u geçmemeli. Yazılım %88, donanım %85 → 3 puan
fark → geçer. Örnek-başı uyum daha güçlü bir metrik olduğu için ayrıca basılır.

Şartname pencerenin hangi okuma olduğunu söylemiyor; rapor ikisini de basar
(mutlak puan farkı ≤ 10 **ve** bağıl düşüş ≤ %10).

> Sınıf başına **50-100 örnek** hedefle. 30 örneklik bir kümede tek örnek 3,33
> puan eder; istatistiksel gürültü %10 penceresini yanıltabilir.
> `run_accuracy.py` 100'ün altında uyarı basar.

---

## Tek gönderim, iki sonuç

YZ RAM'in CPU portu yok — hızlandırıcı veriyi yalnızca UART_YZ → DMA yolundan
alır. Yazılımın **aynı** 1960 baytı görebilmesi için `uart_mux.sv`'de genel
UART'ın RX'i her modda açık bırakıldı. Böylece PC tek gönderim yapar:

```
send_data.py ──► UART_RX pini ──┬──► UART_YZ ──► DMA ──► YZ RAM ──► hızlandırıcı
                                └──► genel UART ──► CPU ──► tflite_ref
```

`yz_bench.c` iki satır döner:

```
YZ:<sınıf>                          <- hızlandırıcı  (send_data.py bunu bekler)
SW:<sınıf> HC:<çevrim> SC:<çevrim>  <- yazılım + iki tarafın çevrim sayısı
```

Yani doğruluk kıyası ile hızlanma ölçümü **aynı koşumdan** çıkar.

---

## Veri kümesi nasıl hazırlanır?

Sınıf adı = klasör adı; ayrı bir etiket dosyası tutulmaz.

```
scripts/yz_accuracy/dataset/
├── sessizlik/   → sınıf 0        ├── yes/   → sınıf 2
└── bilinmeyen/  → sınıf 1        └── no/    → sınıf 3
```

`.wav` koyarsan `wav_to_yz.py` ile otomatik 1960 baytlık hex'e çevrilir (önbellek:
`dataset/.hex_cache/`). Doğrudan `.hex` koyarsan dönüşüm atlanır.

En doğru kaynak **Google Speech Commands v2**'nin test split'idir
(`testing_list.txt`). `bilinmeyen` = yes/no dışındaki kelimeler (on, off, up,
down, stop, go…), `sessizlik` = `_background_noise_/` kayıtlarından 1 s'lik
kesitler.

> Model **İngilizce** eğitilmiştir (TFLite Micro Speech): `yes` / `no`
> kelimeleri kullanılmalıdır. `soc.h`'taki `2=evet 3=hayır` yalnızca Türkçe
> etikettir; Türkçe kayıtla mutlak doğruluk çöker.

---

## Dosyalar

| Dosya | Ne işe yarar |
|---|---|
| `run_accuracy.py` | Veri kümesini tarar, wav→hex çevirir, karta gönderir, %10 penceresi kararını ve karışıklık matrislerini basar |
| `results_board.csv` | Kart koşusu: `dosya, etiket, hw, sw, hw_cevrim, sw_cevrim` |
| `results_host.csv` | Host koşusu (çapraz kontrol): `dosya, etiket, tahmin, tahmin_i32` |

Model ve çıkarım kodu burada değil: **`scripts/yz_tflite/`** (modeli `.tflite`'tan
üretir, RTL ile karşılaştırır) ve **`firmware/yz_model/`** (modelin kendisi).
`--host` koşusu için önce `cd scripts/yz_tflite && make` gerekir.

---

## Neden host koşusu da var?

`tflite_ref.c` tam sayı aritmetiği kullanır, taşma olmaz, tanımsız davranış
yoktur — yani host ile RV32 **aynı** sonucu vermek zorundadır. `--host`, kartın
`SW:` sütunuyla karşılaştırılır: %100 tutuyorsa hem RV32 derlemesi hem bellek
yerleşimi sağlam demektir, hem de ileride kart olmadan büyük kümeler koşulabilir.
Tutmuyorsa gerçek bir hata vardır.
