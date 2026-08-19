# Code Coverage Raporları

Testbench'lerin RTL'in hangi kısımlarını gerçekten çalıştırdığını gösteren
ölçüm sonuçları. Vivado **XSim 2025.2** ile alındı;
dört metrik toplanır: **statement, branch, condition, toggle**.

> **Başlangıç noktası: [`index.html`](index.html)** — bütün blokların skorları
> tek tabloda, her birinin raporuna bağlantı ile.

---

## Klasör yapısı

```
code_coverage/
├── README.md          → bu dosya
├── index.html         → tek giriş sayfası (buradan başlayın)
│
├── GPIO/              ┐
├── Timer/             │
├── UART_GU/           ├─ çevre birimleri — blok testbench'leri ile ölçüldü
├── UART_YZ/           │
├── I2C/               │
├── QSPI/              ┘
└── AI_Accelerator/    → YZ hızlandırıcı — sistem testi ile ölçüldü
```

Her bloğun içinde:

```
<BLOK>/
├── dashboard.html     → giriş sayfası, toplam skorlar
├── modules.html       → modül listesi ve skorları
├── files.html         → kaynak dosya listesi
├── mod*.html          → her modül için satır satır detay
├── file*.html         → her kaynak dosya için satır satır detay
└── cssCodeCov/, jsCodeCov/
```

Detay sayfalarında **yeşil** satır test tarafından çalıştırılmış, **kırmızı**
satır çalıştırılmamış demektir. Bir raporda onlarca HTML olmasının sebebi budur;
hepsi tek bir rapordur, klasör bölünmemelidir.

---

## Çevre birimleri

Kaynak: `main_codes/testbench/Peripherals/` altındaki blok testbench'leri.
Ölçüm tarihi: 2026-08-07.

Yüzdeler **yalnızca tasarım modülüne** aittir — testbench, AXI protokol
kontrolcüsü ve `glbl` dahil değildir.

| Blok | Modül | Statement | Branch | Condition | Toggle | Test | AXI protokol |
|---|---|---:|---:|---:|---:|---|---|
| GPIO | `GPIO_AXI4_Lite` | 100.00 | 92.31 | 100.00 | 60.00 | Geçti | 0 ihlal |
| Timer | `Timer_AXI4_Lite` | 91.30 | 78.12 | 87.50 | 11.11 | Geçti | 0 ihlal |
| UART_GU | `UART_GU_AXI4_Lite` | 96.52 | 83.64 | 100.00 | 10.63 | Geçti | 0 ihlal |
| UART_YZ | `UART_YZ_AXI4_Lite` | 95.04 | 82.14 | 100.00 | 10.63 | Geçti | 0 ihlal |
| I2C | `I2C_Master_AXI4_Lite` | 96.02 | 77.78 | 92.50 | 8.37 | Geçti | 0 ihlal |
| QSPI | `QSPI_Master_AXI4_Lite` | 92.86 | 80.42 | 91.67 | 27.57 | Geçti | 0 ihlal |

---

## YZ hızlandırıcı

Kaynak: `main_codes/testbench/System_Test/ai_accel_test.sv` — blok testi değil,
**sistem testi**. Hızlandırıcı CPU'nun `main_app.c` üzerinden sürdüğü gerçek
akışla çalıştırılır: UART'tan ses verisi → DMA → `YZ_CTRL` → kesme → çıkarım.
Ölçüm tarihi: 2026-08-07.

| Modül | Statement | Branch | Condition | Toggle |
|---|---:|---:|---:|---:|
| `conv_accelerator` | 99.32 | 98.36 | 100.00 | 68.53 |
| `yz_csr_wrapper` | 95.24 | 85.71 | 100.00 | 33.33 |
| `conv_buf_ram` | 100.00 | 100.00 | — | 19.05 |
| `weights_rom_p8` | 100.00 | — | — | — |
| `fc_weights_rom_p4` | 100.00 | — | — | — |

Test sonucu: **başarılı**, AXI protokol ihlali yok. Üç sınıfın üçü de doğru
sınıflandırıldı ve çıkarım her seferinde **45.517 çevrim** sürdü — süre veriden
bağımsız:

| Ses örneği | Beklenen sınıf | Sonuç |
|---|---|---|
| `input_data_yes.hex` | 2 (evet) | ✔ `GPIO_ODR=7` |
| `input_data_no.hex` | 3 (hayır) | ✔ `GPIO_ODR=8` |
| `input_data_sessizlik.hex` | 0 (sessizlik) | ✔ `GPIO_ODR=9` |

---

## Okurken dikkat edilecekler

- **`dashboard.html`'deki toplam skor tasarımın kapsamı değildir.** Testbench,
  AXI protokol kontrolcüsü, `glbl` ve sistem testinde CV32E40P çekirdeği aynı
  kütüphaneye derlendiği için o ortalamaya girer. Yukarıdaki tablolar modül
  bazındadır, doğru okuma odur.

- **`—` işareti "kapsanmadı" değil, "ölçülecek madde yok" demektir.** Ağırlık
  ROM'larında tek bir `if`/`case` bulunmadığından dal ve koşul maddesi sıfırdır.
  Toggle'da da payda ROM dizisinin tamamıdır (`weights_rom_p8` 80×64 = 5.120 bit,
  `fc_weights_rom_p4` 4000×32 = 128.000 bit); bu bitler `$readmemh` ile bir kez
  yüklenip hiç değişmediği için toggle sayacı onları saymaz. Anlamlı gösterge
  statement skorudur.

- **Toggle yüzdeleri genelde düşüktür.** Parametreli ama o blokta kullanılmayan
  port bitleri ve geniş veri yolları paydaya girer; toggle, statement ve branch
  kadar anlamlı bir gösterge değildir.

- **Micron flash modeli kapsam dışıdır.** ~182.000 satırlık üçüncü taraf model,
  ölçüm sırasında `celldefine` içine alınarak enstrümantasyon dışında bırakıldı
  (`xelab --cc_celldefines` varsayılan olarak kapalıdır; modelin tek satırına
  dokunulmadı). Bizim yazmadığımız kod kapsam yüzdesine girmemelidir.

- **Protokol kontrolcüsünün kapsamı raporlarda düşük görünür (~%18).** Beklenen
  durumdur: `axi4lite_protocol_checker` 40 kuralın tamamını içerir, tek bir blok
  testbench'i bunların yalnızca bir kısmını tetikler. Kontrolcünün kendi
  doğrulaması `tb_axi4lite_checker_selftest.sv` ile yapılır.

- **Çevre birimi ve YZ ölçümleri doğrudan kıyaslanmamalıdır.** İlki izole blok
  testbench'i, ikincisi tüm SoC'nin koştuğu sistem testidir.

---
