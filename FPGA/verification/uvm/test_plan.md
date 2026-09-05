# UVM Test Planı

Hangi testin neyi kapsadığı. Yedi bloğun tamamında **aynı yedi test** koşar
(ortak dizi kütüphanesinden gelir, blok başına yalnızca adres haritası
değişir); üstüne her bloğun kendi işlevsel testleri eklenir.

Toplam **73 test**, blok başına **3 tohum** → **219 koşum**.

---

## Bütün bloklarda ortak yedi test

| Test | Ne yapar | Neyi kanıtlar |
|---|---|---|
| `*_reset_test` | Reset sonrası bütün haritalı register'ları okur | Reset değerleri doğru; `RST_01..05` kuralları temiz |
| `*_bitwalk_test` | Yazılabilir register'larda yürüyen-1, tümü-0, tümü-1 | Her bitin saklanıp saklanmadığı; sabit-0/sabit-1 bit yok |
| `*_ro_test` | Salt-okunur register'lara yazma dener, önce/sonra karşılaştırır | Yazma gerçekten düşürülüyor |
| `*_unmapped_test` | Kod çözülmeyen ofsetlere erişir | Haritalanmamış davranış belgelenen şekilde (bayat `rdata` ya da 0) |
| `*_random_test` | Kısıtlı rastgele okuma/yazma, rastgele boşluklarla | Scoreboard'un referans modeliyle sürekli uyum; kapsam beslemesi |
| `*_reset_mid_test` | Trafik akarken reset uygular, sonra reset değerlerini kontrol eder | Reset kurtarması; `RST_01..05` ihlal üretmiyor |
| `*_stress_test` | `beats = 2` — aynı VALID yükseltmesi üzerinde iki işlem (boru hatlı master) | Kabul koşulunun kendi `*ready`'siyle nitelendiği |

`gpio_stress_test`, düzeltilen GPIO kabul koşulunun regresyon korumasıdır;
diğer bloklardaki stres testleri gibi kilitlenmeden ve ihlalsiz geçmelidir.
Ayrıntı [`findings.md`](findings.md).

---

## Bloğa özgü testler

### GPIO — `0x4001_0000` (9 test)

| Test | Kapsadığı |
|---|---|
| `gpio_pad_test` | `GPIO_ODR[31:16]` donanımda sıfır bağlı; IDR geçirgenliği; `dma_enable_o` aynası (pad monitörü `PAD_02`); gösterim açık/kapalı geçişi |
| `gpio_display_test` | 7-segment mesaj tablolarının tamamı: `IDR=1` → ERASE/SNDING/FINISH/ERROR/BOOT, `IDR=2` → SNDING/INFRNC/EVET/HAYIR/SESSIZLK/BILINMYN/YZUART. Her mesaj için 8×2048 çevrimlik tam basamak taraması |
| `gpio_unmapped_test` | Okuma `case`'inde `default` olmadığı için bayat `rdata`; ayrıca `addr[3:0]` kod çözmesinin 16 baytlık takma adı |

### Timer — `0x4000_0000` (9 test)

| Test | Kapsadığı |
|---|---|
| `timer_count_test` | Yukarı sayma, aşağı sayma (ARE'den geri), prescaler bölmesi, olay sayacı (`TIM_EVN`) artışı ve `TIM_EVC` ile temizlenmesi. Ölçülen değerler: 200 çevrimde `TIM_CNT=203`; prescaler 9 ile 200 çevrimde 20 sayım; `ARE=3` ile 200 çevrimde `TIM_EVN=50` |
| `timer_event_test` | `TIM_CLR` / `TIM_EVC` olay semantiği (bit0 = 1 → registerin tamamı sıfırlanır, bit0 = 0 → değer korunur); `TIM_PRE` aynası |

### UART_GU — `0x4004_0000` · UART_YZ — `0x4005_0000` (12 + 13 test)

İki UART register bazında birebir aynıdır; ortak test kütüphanesi ikisinde de
koşar. UART_YZ'ye tek ek test DMA yan bandıdır.

| Test | Kapsadığı |
|---|---|
| `*_tx_test` | Altı bayt gönderilir, **gerçek baud zamanlamalı** seri monitör hattan çözer ve karşılaştırır |
| `*_rx_test` | Seri sürücü hattan bayt basar, `UART_CFG[1]` (RXREADY) beklenir, `UART_RDR` karşılaştırılır |
| `*_baud_test` | CPB süpürmesi: 64, 160, 320 ve **434** (gerçek firmware değeri, 50 MHz / 434 = 115200). Her değerde TX çerçevesi doğrulanır. Ardından stop biti 0/1/2/3 varyantları |
| `*_duplex_test` | Eşzamanlı TX + RX |
| `*_cpb_zero_test` | `UART_CPB = 0` tuzağı: gönderim başlamaz; CPB programlandıktan sonra başlar |
| `uart_yz_dma_test` | **UART_YZ'ye özgü.** `dma_enable_i = 1` iken her alınan bayt `dma_data_o`/`dma_valid_o`'dan doğru çıkıyor; `= 0` iken yol sessiz kalıyor; aynı bayt `UART_RDR`'den de okunabiliyor (RX fan-out) |

### I2C Master — `0x4002_0000` (12 test)

Karşı tarafta protokol seviyesinde bir UVM slave vardır: START/STOP/repeated-START
koşullarını hattan çözer, adres eşleştirir, ACK/NACK sürer.

| Test | Kapsadığı |
|---|---|
| `i2c_nby_test` | Donanımın `I2C_NBY` kırpması: `{0,1,2,3,4,5,17,255}` → `{1,1,2,3,4,4,4,4}` |
| `i2c_write_test` | 1–4 baytlık yazma; slave'in gördüğü adres, R/W biti ve bayt dizisi karşılaştırılır |
| `i2c_read_test` | 1–4 baytlık okuma (repeated-START ile); `I2C_RDR`'ye düşen değerler slave'in gönderdikleriyle karşılaştırılır. Ölçülen: `NBY=4` → `I2C_RDR = 0xD3D2D1D0` |
| `i2c_nack_test` | Adres fazında ve veri fazında NACK enjeksiyonu; her ikisinde de transferin **sessizce** iptal edildiği ve hiçbir DONE bayrağının set edilmediği doğrulanır |
| `i2c_flags_test` | `I2C_CLR` W1C davranışı; `I2C_CLR` okumasının 0 dönmesi; `TXEN + RXEN` birlikte iken yazma önceliği |

### QSPI Master — `0x4003_0000` (11 test)

Karşı tarafta hafif bir flash responder vardır.

| Test | Kapsadığı |
|---|---|
| `qspi_fifo_test` | Boş RX okuması → hata kodu 1; 64 kelime ile TXFULL; dolu TX'e yazma → hata kodu 2; flush sonrası TXEMPTY; `QSPI_FCR`'nin kendini sıfırlaması |
| `qspi_dma_test` | Boşta `dma_valid = 0`; `0x14`'e yazma sonrası `dma_valid` darbesi |
| `qspi_flash_test` | RDID (JEDEC `0x20BA19`), PP ile 4 bayt yazma, READ ile geri okuma. Tam tur: flash belleğine yazılan `44 33 22 11`, RX FIFO'dan `0x44332211` olarak geri okundu |
| `qspi_modes_test` | `QSPI_CCR` geri okuması; **x4** okuma (QOR `0x6B`, dummy 8) → `0xA0A1A2A3`; **x2** okuma (DOR `0x3B`) → `0xA0A1A2A3`; **x4** yazma (QPP `0x32`); 8 baytlık uzun transfer (`data_byte_size > 4` dalı); 32-bit adres modu (`QSPI_FCR[2]`) |

### YZ hızlandırıcı CSR — `0x4006_0000` (7 test)

Şartnamenin "YZ hızlandırıcının AXI arayüzü de doğrulanmalıdır" maddesinin
karşılığı. `yz_csr_wrapper`, hızlandırıcının CPU'ya bakan tek AXI4-Lite
arayüzüdür.

| Test | Kapsadığı |
|---|---|
| `yz_csr_test` | `YZ_CTRL[0]` → tam 1 çevrimlik `acc_start` darbesi; `YZ_CTRL[1]` → `load_clear` darbesi; `YZ_STATUS` bit dizilimi (`{infer_pending, load_done_irq, acc_busy}`); `acc_done` → `infer_pending` + `infer_irq`; `YZ_CTRL[2]` ile temizleme; `acc_out_wen` ile dört sınıfın `YZ_RESULT`'a doğru yakalanması ve üst bitlerin sızmaması |

---

## Şartname maddeleriyle eşleme

| Şartname beklentisi | Karşılığı |
|---|---|
| Çevre birimlerinin AXI/AXI-Lite arayüzlerinin SystemVerilog + UVM ile doğrulanması | Altı çevre birimi (GPIO, Timer, UART_GU, UART_YZ, I2C, QSPI) için tam UVM ortamı: agent, sequencer, sürücü, monitör, scoreboard, `uvm_reg` modeli |
| YZ hızlandırıcının AXI arayüzünün doğrulanması | `yz_csr` bloğu — 7 test |
| "Regression" sonuçlarının raporlanması | [`regression_summary.md`](regression_summary.md) — 73 test × 3 tohum = 219 koşum |
| "Coverage" sonuçlarının raporlanması | [`coverage/functional.md`](coverage/functional.md) (fonksiyonel) + [`coverage/index.html`](coverage/index.html) (satır) |
| AXI işlemlerinin transaction halinde paketlenmesi | `axil_monitor` her AXI işlemini `axil_item` olarak paketler; scoreboard ve kapsam toplayıcı yalnızca bu akışı görür |
| Protokol kontrolü | Mevcut `axi4lite_protocol_checker` (40 kural) `bind` ile her bloğa bağlı; sayaç `report_phase`'de UVM hatasına çevriliyor |
| Sistem seviyesinde yönlendirilmiş testler | Bu ortamın dışında, `main_codes/testbench/System_Test/` altında (boot, ai_accel, yz_bench) |
