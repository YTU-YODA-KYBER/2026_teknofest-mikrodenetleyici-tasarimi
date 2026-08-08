# scripts/yz_tflite — TFLite Yazılım Gerçeklemesi

Şartnamenin *"RISC-V çekirdeği üzerinde çalışan yazılım gerçeklemesi"* dediği
baseline'ı üretir: `micro_speech_quantized.tflite`'ın kendisinden çıkarılmış
sabitlerle, TFLite Micro'nun **reference kernel**'lerine sadık bir C modeli.
Hem host'ta hem CV32E40P'de aynı kod koşar.

```bash
cd scripts/yz_tflite
make data      # .tflite -> firmware/yz_model/tflite_model_data.h + 5 çapraz kontrol
make           # -> ./ref_run  (host sürücüsü)

./ref_run ../../firmware/sound_samples/*.hex   # sınıf + skor CSV
python3 compare_rtl.py                          # RTL ile karşılaştır (Vivado/kart gerekmez)
```

> `compare_rtl.py` için **iverilog** gerekir: `sudo apt install iverilog`

---

## Ne yapıyor?

Model dosyası `../../../tflite_files/micro_speech_quantized.tflite`. Grafiği:

```
INT8 [1,1960]  zp=-128
  → Reshape → [1,49,40,1]
  → DepthwiseConv2D  10x8, stride 2, SAME, depth_multiplier 8, fused ReLU
                     per-channel requant           → [1,25,20,8]  zp=-128
  → FullyConnected   4000 → 4                      → [1,4]        zp=14
  → Softmax                    (argmax'ı değiştirmez, uygulanmaz)
```

`tflite_ref.c`, `reference_integer_ops::DepthwiseConvPerChannel` ve
`FullyConnected`'ın döngü düzenini korur; requant için gemmlowp'un iki adımlı
`SaturatingRoundingDoublingHighMul` + `RoundingDivideByPOT` çiftini kullanır.
Donanıma özgü hiçbir kısayol yok — ölçülmek istenen fark zaten o.

Sabitler elle kopyalanmaz: `gen_tflite_data.py` ağırlıkları, bias'ları,
zero-point'leri ve `QuantizeMultiplier` ile üretilen (Q31 çarpan, shift)
ikililerini doğrudan `.tflite`'tan okur.

---

## Doğrulanmış olanlar

`make data` her koşumda beş çapraz kontrol yapar; biri tutmazsa durur:

| Kontrol | Sonuç |
|---|---|
| `.tflite` ağırlıkları ↔ `weights.hex`, `fc_weights.hex` | bayt bayt aynı |
| `.tflite` bias'ları ↔ `biases.hex`, `fc_biases.hex` | aynı |
| `.tflite` ↔ RTL'in okuduğu `weights_p8.hex`, `fc_weights_p4.hex` | aynı (paketlemeler güncel) |
| TFLite çarpanları ↔ RTL `M0_FLAT`/`SHR_FLAT` | en büyük bağıl hata **8,4e−6** |
| Geometri (dolgu dahil) ↔ `conv_accelerator.v` localparam'ları | tam uyum |

`compare_rtl.py` 3 referans örnekte: **sınıf uyumu 3/3**, en büyük skor sapması
skor aralığının **%0,07**'si, hızlandırıcı **45.517 çevrim** (0,910 ms @ 50 MHz).

Bu sapma kart üzerinde 156 örneklik kümede doğrulandı: iki tarafın doğruluğu da
**%91,03**, örnek-başı uyum %99,36 (bkz. `scripts/yz_accuracy/README.md`).

Sessizlik örneğinde skorlar *tam olarak* tutuyor — o örnekte conv çıkışı tabanda
kalıyor, requant hiç devreye girmiyor, FC akümülatörleri doğrudan FC bias'ına
eşit oluyor.

---

## Dosyalar

| Dosya | Ne işe yarar |
|---|---|
| `tflite_parse.py` | Saf Python FlatBuffer okuyucu — tensör/operatör/kuantizasyon çıkarır (`--dump` ile döküm) |
| `gen_tflite_data.py` | `tflite_model_data.h` üretir + beş çapraz kontrolü koşar (`--check` ile sadece doğrular) |
| `hex_to_carray.py` | Bir girdi hex'ini `sim_input.h`'e çevirir (simülasyonda gömülü test vektörü) |
| `ref_run.c` | Host sürücüsü: hex oku → `dosya,sınıf,sınıf_acc,acc0..3,out0..3` CSV bas |
| `compare_rtl.py` | iverilog ile RTL'i koşturup C referansıyla karşılaştırır; donanım çevrim sayısını verir |
| `Makefile` | `make` → `ref_run`, `make data` → başlığı üret, `make check-data` → doğrula |

Modelin kendisi burada değil, **`firmware/yz_model/tflite_ref.{c,h}`** içinde —
aynı dosya `firmware/yz_bench.c` ile RV32'ye derlenip hızlanma ölçümünün yazılım
tarafını da oluşturuyor. Bu yüzden `soc.h`, kesme, stdlib bağımlılığı yoktur.

---

## Bilinmesi gereken iki şey

**Ağırlık düzenleri birbirinin tersidir.** Conv tap-major, FC sınıf-major:

```
conv : yz_conv_w[(fy * YZ_FILTER_W + fx) * YZ_N_CH + ch]     tap dışta
FC   : yz_fc_w[sınıf * YZ_FC_IN + i]                          SINIF dışta
FC girdi indeksi:  i = (oy * YZ_OUT_W + ox) * YZ_N_CH + ch
```

**Hızlandırıcı FC çıkışını requantize etmez.** TFLite akümülatörleri int8'e
sıkıştırır (`add_1`, zp=14), donanım ham int32'de argmax alır. Normalde ikisi
aynı sınıfı verir, ama int8 doygunluğunda ayrışabilirler — `ref_run` bu yüzden
her iki argmax'ı da basar (`sinif` = TFLite, `sinif_acc` = donanımın kuralı).

> Model **İngilizce** eğitilmiştir: `yes` / `no` kayıtları gerekir.
> `soc.h`'taki `2=evet 3=hayır` yalnızca Türkçe etikettir.
