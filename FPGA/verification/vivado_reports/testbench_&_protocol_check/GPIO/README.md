# GPIO — Directed Testbench Sonucu

`GPIO_AXI4_Lite` bloğunun **yönlendirilmiş (directed)** blok testbench'i. Blok
yalnızca giriş/çıkış register'ı değil, aynı zamanda **7-segment sürücüsüdür**:
gösterilecek değeri `GPIO_ODR`'den, gösterim modunu `GPIO_IDR[1:0]`'dan alır.
Testbench her iki tarafı da sürer — AXI register davranışı ve ekran sürücüsünün
tarama/kod çözme kuralları. `axi4lite_protocol_checker` aynı koşumda bloğun AXI
arayüzüne `bind` ile bağlıdır.

Testbench: [`GPIO_tb.sv`](../../../../main_codes/testbench/Peripherals/GPIO/GPIO_tb.sv) ·
Proje: `scripts/project_gen/Peripherals/create_GPIO.tcl` ·
Simülatör: **XSim 2025.2** · TB saati: 100 MHz · Simülasyon süresi: **31,07 µs**

> **Ham çıktı: [`xsim_console.log`](xsim_console.log)**

---

## Özet

| Ölçüm | Sonuç |
|---|---|
| Test bloğu | 15 |
| Sayılan kontrol | **50** |
| Geçen | **50 / 50** |
| Kalan | 0 |
| AXI protokol ihlali | **0** |
| Uyarı (stall/watchdog) | 0 |
| İzlenen AXI arayüzü | 1 (`GPIO`) |
| Gözlenen işlem | 26 yazma · 7 okuma |

---

## Testler

| # | Test | Ne doğruluyor | Sonuç |
|---|---|---|---|
| 1 | Reset sonrası başlangıç değerleri | Reset bırakıldığında AXI boşta: `awready`/`wready`/`arready`=1, `bvalid`/`rvalid`=0 ve `GPIO_ODR`=0 | GEÇTİ |
| 2 | `GPIO_ODR` yazma ve geri okuma | Ofset `0x4`'e yazılan değer hem çıkış pinlerine yansıyor hem de geri okunuyor | GEÇTİ (2 kontrol) |
| 3 | `GPIO_ODR[31:16]` etkisiz | **EK-2 isteri:** üst 16 bit donanımda yok; yazılan `0xFFFF_1234` hem pinlerde hem geri okumada `0x0000_1234` olarak görünmeli | GEÇTİ (2 kontrol) |
| 4 | `GPIO_IDR` okuma | Ofset `0x0`'dan sürülen giriş değeri (switch'ler) doğru okunuyor | GEÇTİ |
| 5 | `GPIO_IDR` salt-okunur koruması | IDR'ye yazma denemesi ne IDR'yi ne de ODR'yi bozuyor | GEÇTİ (2 kontrol) |
| 6 | `dma_enable_o` türetimi | `GPIO_IDR[1]` (YZ-UART modu anahtarı) doğrudan `dma_enable_o` çıkışını sürüyor; 1 ve 0 için ayrı doğrulanır | GEÇTİ (2 kontrol) |
| 7 | Anode one-cold + tarama | **7a:** 2000 saat vuruşu boyunca `anode` her zaman tek-`0` (one-cold) kalıyor — iki hane aynı anda yanamaz. **7b:** `anode_select` ilerliyor, yani tarama sayacı çalışıyor | GEÇTİ (2 kontrol) |
| 8 | Ekran sönük (blank) koşulları | `IDR=0` ve `IDR=1 & ODR=0` durumlarında `catode=0xFF` (bütün segmentler sönük) | GEÇTİ (2 kontrol) |
| 9 | 7-segment mesaj tabloları | **13 mesajın tamamı, her hanesiyle** taranır: `ERASE`, `SNDING`, `FINISH`, `ERROR`, `BOOT`(varsayılan), `INFRNC`, `EVET`, `HAYIR`, `SESSIZLK`, `BILINMYN`, `YZUART`(varsayılan) — `IDR`/`ODR` kombinasyonlarıyla | GEÇTİ (12 kontrol) |
| 10 | Sistem adresiyle erişim | RTL adres kod çözmeyi yalnızca **alt 4 bit** üzerinden yapar; tam sistem adresi `0x4001_0004` ile de yazma/okuma çalışmalı | GEÇTİ (2 kontrol) |
| 11 | Arka arkaya yazma | Aralıksız iki AXI yazmasından sonra son değer geçerli | GEÇTİ |
| 12 | Tanımsız adres davranışı | **12a:** tanımsız ofsete yazma `GPIO_ODR`'yi bozmuyor. **12b:** tanımsız ofsetten okumada `rdata` **bayat kalıyor** (`case`'de `default` yok) ama `rvalid` yine yükseliyor — belgelenmiş, bilinçli davranış | GEÇTİ (1 sayılan kontrol + bilgi satırları) |
| 13 | Çalışma sırasında reset | Ortada verilen reset `GPIO_ODR`'yi sıfırlıyor, AXI tekrar boşa dönüyor ve blok sonrasında yeniden yazılabiliyor | GEÇTİ (2 kontrol) |
| 14 | Animasyon deseni | `anode_select` 0 ve 1 için 8 animasyon karesinin `catode` desenleri tek tek | GEÇTİ (16 kontrol) |
| 15 | Sayaç sarması (wrap) | **15a:** `anode_select` 7'den 0'a sarıyor. **15b:** `anim_select` 7'den 0'a sarıyor | GEÇTİ (2 kontrol) |

GPIO testbench'i geçme ölçütü olarak sabit bir sayı değil `toplam_basarisiz == 0`
kullanır; bu yüzden 15 test bloğundan 50 ayrı kontrol çıkar.

---

## AXI protokol kontrolü

`Bind_for_peripherals/axi4lite_bind_gpio.svh` ile `NAME("GPIO")`,
`MAX_OUTSTANDING(1)`:

```
======================================================================
            AXI4-LITE PROTOKOL KONTROL OZETI
======================================================================
  Izlenen AXI arayuzu sayisi : 1
  Protokol ihlali            : 0
  Uyari (stall/watchdog)     : 0
  SONUC                      : GECTI  (0 ihlal)
======================================================================

[AXI-CHK]           GPIO | AW=26 W=26 B=26 AR=7 R=7 | ihlal=0 uyari=0
```

---

## Okurken dikkat edilecekler

- **Test 12b bir kusuru gizlemiyor, belgeliyor.** GPIO'nun okuma `case`'inde
  `default` dalı yoktur (`araddr[3:0]` yalnız `4'h0` ve `4'h4` için atama
  yapar), dolayısıyla tanımsız ofsette `rdata` önceki değerinde kalır. AXI
  açısından yasal — `rvalid` ve `rresp=OKAY` üretilir — ama yazılımın buna
  güvenmemesi gerekir. Test bu davranışı **açıkça iddia eder**.
- **`GPIO_IDR[31:16]=0` isteri bu blokta değil, `fpga_top.sv`'de sağlanır.**
  Log'daki `[BILGI]` satırı bunu söyler: testbench IDR'ye `0xFFFF_5A5A` sürünce
  blok bunu olduğu gibi geri verir; kırpma kart sarmalayıcısındaki
  `{16'h0, GPIO_IDR_pins}` bağlantısındadır.
- **Animasyon kareleri burada `force` ile sürülür.** Gerçek zamanlamayla
  taranmaları 40 M çevrim (≈800 ms) alırdı; blok testi bunun yerine iç
  sinyalleri doğrudan konumlandırıp kod çözmeyi doğrular.
