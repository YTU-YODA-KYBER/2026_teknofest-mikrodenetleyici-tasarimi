# Boot Zinciri — Sistem Seviyesi Directed Test Sonucu

Tek bir bloğu değil, **SoC'nin tamamını uçtan uca** süren self-checking test.
Şartname madde 5.2-2'nin doğrudan karşılığıdır: *"En azından bir adet
self-checking test ile boot akışı, bir çevre birimi programlaması ve çevre
birimi çalışmasının doğrulanması."*

Test iki fazlıdır ve ikisi de **gerçek firmware** koşturur — testbench yalnızca
kartın dışındaki dünyayı (UART hattı, QSPI flash yongası) modeller:

- **Faz 1 — Flasher** (`GPIO_IDR=1`, kartta SW0=1): CPU Boot ROM'daki flasher'ı
  koşturur, `GPIO_ODR=0x0002` ile hazır olduğunu bildirir, testbench UART'tan
  16 baytlık minik bir uygulama gönderir, flasher onu QSPI flash'a yazar, geri
  okuyup doğrular ve `0x0003` (PASS) basar.
- **Faz 2 — Boot** (`GPIO_IDR=0`, SW0=0): flash içeriği korunarak CPU
  reset'lenir; boot kodu uygulamayı flash'tan QSPI Quad Output Read ile okur,
  Instruction RAM'e DMA eder ve `0x1000_0000`'a atlar. Minik uygulama
  `GPIO_ODR=0x0123` yazıp döngüye girer — testbench bu imzayı bekler.

Bu koşumda `axi4lite_protocol_checker` **`axi4lite_bind.svh` ile tasarımdaki
15 AXI4-Lite arayüzünün tamamına** bağlıdır.

Testbench: [`boot_test.sv`](../../../../main_codes/testbench/System_Test/boot_test.sv) ·
Proje: `scripts/project_gen/System_test/boot_test.tcl` ·
Firmware: `make sim_boot` → `sim_boot.hex` ·
Simülatör: **XSim 2025.2** · Sistem saati: 50 MHz · Simülasyon süresi: **10,908 ms**

> **Ham çıktı: [`xsim_console.log`](xsim_console.log)**

---

## Özet

| Ölçüm | Sonuç |
|---|---|
| Faz | 2 (flasher + boot) |
| Sonuç | **BAŞARILI** — zincirin tamamı |
| AXI protokol ihlali | **0** |
| Uyarı (stall/watchdog) | 0 |
| İzlenen AXI arayüzü | **15** |
| İzlenen el sıkışma | 16.401 yazma · 615.504 okuma ¹ |
| Zaman aşımı | yok (100 ms watchdog'a girilmedi) |

¹ Aynı işlem hem master hem slave ucunda sayılır (ör. `CPU_INSTR_M` ile
`SPLITTER_S` aynı telleri farklı uçlardan izler), bu yüzden toplam benzersiz
işlem sayısından büyüktür. Arayüz başına dağılım aşağıdadır.

---

## Doğrulanan kilometre taşları

| # | Kilometre taşı | Ne kanıtlıyor | Log |
|---|---|---|---|
| 1 | Flasher hazır (`GPIO_ODR=0x0002`) | Boot ROM'dan reset vektörü çalıştı, CPU komut getirebiliyor, GPIO programlandı | `[TB] Flasher hazir (0x0002)` |
| 2 | UART chunk + `0x06` ACK | UART_GU alım yolu ve firmware'in LENGTH + 256 baytlık chunk protokolü çalışıyor | `[TB] chunk yazildi, ACK alindi @ 5818330000 ns` |
| 3 | Flasher PASS (`0x0003`) | QSPI Master yazma yolu çalışıyor **ve** firmware geri okuyup doğruladı | `[TB] FLASHER PASS (0x0003)` |
| 4 | Reset sonrası flash içeriği korunuyor | Kalıcı bellek davranışı doğru modellendi ve boot yolu gerçekten flash'tan okuyor | `[TB] CPU reset'lendi (flash korundu)` |
| 5 | Uygulama koşuyor (`GPIO_ODR=0x0123`) | Boot → QSPI okuma → DMA → Instruction RAM → `0x1000_0000`'a atlama → yürütme zincirinin tamamı | `[TB] Minik app kosuyor: GPIO_ODR=0x0123` |

Testbench zaman aşımına düşerse `$finish` ile biter ve son satırı basmaz;
**`>>> TAM SISTEM TESTI: BASARILI <<<`** satırı ancak beşinci kilometre taşına
ulaşıldığında yazılır.

---

## AXI protokol kontrolü — 15 arayüz

```
======================================================================
            AXI4-LITE PROTOKOL KONTROL OZETI
======================================================================
  Izlenen AXI arayuzu sayisi : 15
  Protokol ihlali            : 0
  Uyari (stall/watchdog)     : 0
  SONUC                      : GECTI  (0 ihlal)
======================================================================
```

Arayüz başına gözlenen trafik (log'un son satırları):

| Arayüz | Yazma (AW/W/B) | Okuma (AR/R) | İhlal |
|---|---:|---:|---:|
| `CPU_INSTR_M` | 0 | 165.118 | 0 |
| `SPLITTER_S` | 0 | 165.118 | 0 |
| `BOOTROM_CPU` | 0 | 163.448 | 0 |
| `CPU_DATA_M` | 5.467 | 40.050 | 0 |
| `ICN_S0` | 5.467 | 40.050 | 0 |
| `QSPI` | 5.418 | 34.232 | 0 |
| `UART_GU` | 24 | 5.793 | 0 |
| `INSTR_RAM` | 0 | 1.670 | 0 |
| `DATA_RAM` | 21 | 23 | 0 |
| `GPIO` | 4 | 2 | 0 |
| `BOOTROM_ICN` | 0 | 0 | 0 |
| `TIMER` · `I2C` · `UART_YZ` · `YZ_ACCEL` | 0 | 0 | — trafik yok |

---

## Okurken dikkat edilecekler

- **Dört arayüzde "TRAFIK YOK" yazması beklenen sonuçtur.** Boot senaryosu
  Timer, I2C, UART_YZ ve YZ hızlandırıcıya hiç dokunmaz. Kontrolcü bunu
  sessizce geçmez, açıkça `*** TRAFIK YOK -- bu arayuz HIC test edilmedi ***`
  diye raporlar — böylece "0 ihlal" ile "hiç sürülmedi" karıştırılamaz.
  Bu dördünden ikisi ([`../AI_Accelerator/`](../AI_Accelerator/)) YZ sistem
  testinde, diğer ikisi kendi blok testlerinde
  ([`../Timer/`](../Timer/), [`../I2C/`](../I2C/)) sürülür.
- **`FIN_02 BILGI` satırları ihlal değildir.** `BOOTROM_CPU`, `CPU_INSTR_M` ve
  `SPLITTER_S` arayüzlerinde simülasyon biterken 1'er cevapsız okuma kalır.
  Kontrolcü bunu reset sayısı ve outstanding limitiyle karşılaştırıp
  *"...ile aciklanabilir, protokol ihlali DEGIL"* diye işaretler: CPU
  `$finish` anında uçuşta olan bir komut getirme isteğine sahiptir, bu doğaldır.
- **`BOOTROM_CPU`'da 163.448 okuma neden var?** Boot kodu bir döngüdür ve
  komutlarını Boot ROM'dan getirir; her komut getirme bir AXI okumasıdır.
  Önbellek yoktur, bu yüzden sayı doğrudan koşturulan komut sayısıyla orantılıdır.
- **Log'da flash modelinin kendi çıktısı yoğundur.** `Command execution`,
  `Address latched`, `Dummy clock cycles` satırları Micron modelinden gelir ve
  boot'un flash'ı gerçekten sayfa sayfa okuduğunu gösterir. Ayrıca dört adet
  `[GPIO-B]` satırı testbench'in kendi hata ayıklama monitöründendir.
