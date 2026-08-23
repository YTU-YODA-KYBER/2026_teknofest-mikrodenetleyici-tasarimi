# YZ hızlandırıcı boru hattı yaması — bit-exact eşdeğerlik kanıtı

ASIC akışında `conv_accelerator` MAC yolu iki evreye bölündü (bkz.
`asic/scripts/patch_rtl.py`). Bu dosya, değişikliğin çıkarım sonucunu
**hiç değiştirmediğini** gösterir.

Kullanılan koşum: `main_codes/testbench/AI_Accelerator/tb_conv_accel.v` (iverilog),
referans ses örnekleri `firmware/sound_samples/`.

| Örnek | Sürüm | Sınıf | S0 | S1 | S2 | S3 | Çevrim |
|---|---|---:|---:|---:|---:|---:|---:|
| yes | orijinal | 2 | -58032 | 21583 | 48674 | -4777 | 45517 |
| yes | **boru hatlı (ASIC)** | 2 | -58032 | 21583 | 48674 | -4777 | 46018 |
| no | orijinal | 3 | -30588 | 7509 | 7419 | 18543 | 45517 |
| no | **boru hatlı (ASIC)** | 3 | -30588 | 7509 | 7419 | 18543 | 46018 |
| sessizlik | orijinal | 0 | 427 | -518 | -94 | 186 | 45517 |
| sessizlik | **boru hatlı (ASIC)** | 0 | 427 | -518 | -94 | 186 | 46018 |

**Sonuç:** üç örnekte de sınıf ve dört FC skorunun tamamı birebir aynıdır.
Tek fark çevrim sayısıdır: 45.517 → 46.018 (+501 çevrim, **+%1,1**). Bu artış
boru hattının bir evre uzamasından gelir (500 konvolüsyon pozisyonu + 1 FC
boşaltması). Tap başına 1 çevrimlik verim değişmemiştir.

Yazılım gerçeklemesine göre hızlanma bu nedenle 276,9× yerine
12.608.381 / 46.018 = **274,0×** olur.


---

## Sistem seviyesi doğrulama

Boru hatlı sürüm ayrıca **tam SoC** içinde, ASIC yapılandırmasıyla (SKY130 SRAM
makroları + mask ROM'lar) koşturuldu:

```bash
cd asic && python3 scripts/run_asic_sim.py yz
```

| Test | Sonuç |
|---|---|
| `ai_accel_test` (3 ses örneği, UART üzerinden yükleme + çıkarım) | **BAŞARILI** |
| AXI4-Lite protokol kontrolü (15 arayüz) | **0 ihlal** |

Aynı testbench boru hattı olmayan sürümle de koşturulmuş ve geçmiştir; iki
koşumun sınıflandırma sonuçları aynıdır.
