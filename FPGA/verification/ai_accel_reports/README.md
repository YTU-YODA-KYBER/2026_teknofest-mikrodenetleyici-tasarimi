# ai_accel_reports — YZ Hızlandırıcı: Doğruluk ve Hız Ölçümleri

Şartnamenin iki YZ maddesinin kanıtı. Her iki ölçüm de **aynı uygulamadan**
(`firmware/yz_bench.c`) çıkar: uygulama aynı 1960 baytlık ses özelliğini hem
hızlandırıcıya hem de CPU'da koşan TFLite yazılım gerçeklemesine verir, ikisinin
sınıfını ve `mcycle` çevrim sayısını raporlar.

| Madde | Sınır | Ölçülen | Sonuç |
|---|---|---|---|
| Hızlanma | > 1× | **276,9×** | geçti |
| Doğruluk penceresi | ≤ %10 | **0,00 puan** (bağıl %0,00) | geçti |

| | Yazılım (CV32E40P) | Donanım (YZ hızlandırıcı) |
|---|---|---|
| accuracy | **%91,03** (142/156) | **%91,03** (142/156) |
| çıkarım | 12.608.381 çevrim (252,2 ms) | 45.540 çevrim (0,911 ms) |

---

## Bellek bütçesi

Şartname hızlandırıcının **toplam** belleğini 30 KB ile sınırlar. Aşağıdaki
tablo RTL'deki her dizinin bildirilmiş boyutudur (`main_codes/rtl/desgin_sources/`
altındaki modüllerden birebir okunur):

| Bellek | Derinlik × Genişlik | Bayt |
|---|---:|---:|
| YZ girdi RAM (`bram_yz`) | 9904 × 8 | 9.904 |
| `fc_weights_rom_p4` (FC ağırlıkları) | 4000 × 32 | 16.000 |
| `conv_buf_ram` (conv→FC aktivasyon tamponu) | 4000 × 8 | 4.000 |
| `weights_rom_p8` (conv ağırlıkları) | 80 × 64 | 640 |
| `biases` + `fc_biases` + `fc_scores` | 16 × 32 | 64 |
| `acc` + `fc_acc` + `wb_prod` + `wb_bytes` | — | 112 |
| **TOPLAM** | | **30.720 = 30,00 KB** |

Girdi RAM dışındaki her dizi **%100 adreslenir** (FC ağırlıkları 0..3999, conv
tamponu 0..3999, conv ağırlıkları 0..79) — kırpılacak fazlalık yoktur. Model
girdisi her zaman 1960 bayt olduğu için girdi RAM'inin ilk 1960 adresi
kullanılır; derinliği 30 KB bütçesinden **artan pay** olarak belirlenmiştir
(30.720 − 20.816 = 9.904). Register dizileri (son iki satır) bilerek dahil
edildi: "bellek" en geniş yorumuyla sayıldığında bile toplam sınırı aşmıyor.

Derinlik beş yerde kilitli tutulur — biri değişirse hepsi değişmeli:
`Top_module.sv` (`ADDR_WIDTH_yz`/`DEPTH_yz`), `Top_module_for_app_code.sv`,
`bram_yz_def.sv`, `yz_bram_axi_ctrl.sv`, `conv_accelerator.v` (`RAM_ADDR_W`).

---

## Dosyalar

| Dosya | Neyi raporlar |
|---|---|
| `accuracy_board.log` | Kart koşusunun konsol çıktısı: doğruluk oranları, %10 penceresi kararı, örnek-başı uyum, karışıklık matrisleri |
| `results_board.csv` | Aynı koşumun ham verisi — örnek başına `dosya, etiket, hw, sw, hw_cevrim, sw_cevrim` (156 satır) |
| `speedup_sim.log` | Vivado simülasyon konsolu: hızlanma ölçümü, testbench'in bağımsız çevrim sayacıyla birlikte |
| `compare_rtl.log` | RTL ↔ yazılım referansı karşılaştırması (iverilog). Hızlandırıcının **eğitilmiş modelle** aynı sayıları ürettiğini gösterir |
| `images/` | Yukarıdaki iki koşumun ekran görüntüleri |

---

## Nasıl üretildi

Yazılım gerçeklemesi (`firmware/yz_model/tflite_ref.c`) TFLite Micro'nun
reference kernel'lerinin portudur; sabitleri doğrudan
`micro_speech_quantized.tflite`'tan çıkarılır.

```bash
# doğruluk — kart üzerinde (SW1=1, SW0=0)
cd firmware && make bench            # + yz_bench_test.tcl ile bitstream
python3 ../scripts/yz_accuracy/run_accuracy.py --dataset dataset --board \
        --outdir ../verification/ai_accel_reports

# hızlanma — Vivado simülasyonu (~12 dk)
cd firmware && make sim_bench        # + yz_bench_test.tcl ile "Run Simulation"

# RTL ↔ referans karşılaştırması (iverilog, ~15 sn, donanım gerekmez)
cd scripts/yz_tflite && make data && make && python3 compare_rtl.py
```

**Veri kümesi:** Google Speech Commands v2 **test split**'i (modelin eğitimde
görmediği kayıtlar) — 156 örnek: sessizlik 32, bilinmeyen 37, yes 50, no 37.
Ses dosyaları depoda tutulmaz; hangi kaydın kullanıldığı `results_board.csv`
içindeki yollardan izlenir.

---

## Okurken dikkat edilecekler

- **Hızlanma neden bu kadar büyük?** Yazılım tarafı hesap değil **bellek**
  sınırlıdır: MAC başına ~37,5 çevrim, çünkü CV32E40P'nin önbelleği yok ve her
  ağırlık okuması ayrı bir AXI4-Lite gidiş-dönüşü. Kısıtlanmış bir baseline
  değil, SoC'nin gerçek mimarisidir.

- **Baseline daha hızlı yazılabilir miydi?** Evet — reference kernel yapısı aynı
  girdi pikselini 8 kanal için 8 kez okur. Elle optimize edilse ~165×, bütün
  hesap bedava olsa (yalnızca AXI maliyeti) ~220× kalırdı. Sonuç hiçbir durumda
  değişmez.

- **Tek ayrışan örnekte iki taraf da yanlış** (yazılım `bilinmeyen`, donanım
  `yes`, gerçek `no`) — bu yüzden doğruluk oranlarına etkisi yoktur.

- **45.540 ≠ 45.517.** İlki uygulamanın `mcycle` ölçümü, ikincisi testbench'in
  bağımsız sayacı; aradaki 23 çevrim START yazması ve durum yoklamasının AXI
  maliyetidir. `mcycle`'ın donanımda tutması, aynı sayaçtan gelen yazılım
  rakamının da kalibre olduğunu gösterir.

- **Bu senaryo 32 KB Boot ROM + 32 KB Data RAM ister**, çünkü yazılım modelinin
  16 KB'lık FC ağırlığı `.rodata`'da durur. Bu ihtiyaç ana projeye yazılmaz:
  `firmware/linker_bench.ld` ve `yz_bench_test.tcl` parametreleri dışarıdan
  ezer, `Top_module.sv` ile `linker.ld` şartname değerlerinde kalır.

- `speedup_sim.log`'daki `unique case … 0ns` uyarıları reset öncesi CV32E40P
  artığıdır, zararsızdır.

---

Ölçüm tarihi: 2026-08-08. Kart: Nexys A7 (xc7a100tcsg324-1) @ 50 MHz.
