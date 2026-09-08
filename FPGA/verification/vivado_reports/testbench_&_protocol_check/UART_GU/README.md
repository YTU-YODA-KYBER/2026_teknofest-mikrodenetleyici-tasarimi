# UART_GU — Directed Testbench Sonucu

`UART_GU_AXI4_Lite` (genel kullanım UART'ı) bloğunun **yönlendirilmiş
(directed)** blok testbench'i. Testbench seri hattın karşı ucunu kendisi
modeller: TX tarafında bloğun ürettiği çerçeveyi bit bit çözer, RX tarafında
gerçek baud zamanlamasıyla bayt sürer. Senaryolar eşzamanlı çift yönlü
(full-duplex) çalışmayı, farklı baud bölenlerini ve stop biti sayılarını,
ardışık gönderim/alım dizilerini kapsar. `axi4lite_protocol_checker` aynı
koşumda AXI arayüzüne `bind` ile bağlıdır.

Testbench: [`UART_GU_tb.sv`](../../../../main_codes/testbench/Peripherals/UART_GU/UART_GU_tb.sv) ·
Proje: `scripts/project_gen/Peripherals/create_UART_GU.tcl` ·
Simülatör: **XSim 2025.2** · TB saati: 100 MHz · Simülasyon süresi: **1,068 ms**

> **Ham çıktı: [`xsim_console.log`](xsim_console.log)**

---

## Özet

| Ölçüm | Sonuç |
|---|---|
| Test bloğu | 4 |
| Sayılan kontrol | **10** |
| Geçen | **10 / 10** |
| Kalan | 0 |
| AXI protokol ihlali | **0** |
| Uyarı (stall/watchdog) | 0 |
| İzlenen AXI arayüzü | 1 (`UART_GU`) |
| Gözlenen işlem | 17 yazma · 5 okuma |

---

## Testler

| # | Test | Ne doğruluyor | Sonuç |
|---|---|---|---|
| 1 | Aynı anda yazma ve okuma | **Full-duplex:** TX ve RX aynı anda çalışıyor. `UART_CPB=375` (128000 baud), `UART_STP=2` (1,5 stop biti). **1a:** hattan gelen `10101101` `UART_RDR`'ye (`0x08`) doğru düşüyor. **1b:** gönderim bitince `UART_CFG[2]` set oluyor | GEÇTİ (2 kontrol) |
| 2 | Asenkron başlatma | RX, TX'in **ortasında** başlatılıyor (`tx_shift_cnt == 4` beklenir). `UART_CPB=417` (115200 baud), `UART_STP=3` (2 stop biti). TX ve RX'in **bağımsız baud sayaçları** olduğunun kanıtı | GEÇTİ (2 kontrol) |
| 3 | Art arda yazma | `UART_CPB=500` (96000 baud), `UART_STP=0` (1 stop biti) ile üç ardışık gönderim (`0x8B`, `0x6D`, `0xF0`); aralarında hata/kayıp olmadan tamamlanıyor | GEÇTİ (3 kontrol) |
| 4 | Art arda okuma | Üç ardışık alım; her birinde `data_received` bayrağı kalkıyor ve `UART_RDR` doğru bayt veriyor (son bayt `11110000`) | GEÇTİ (3 kontrol) |

Register haritası: `0x00` `UART_CPB` (baud böleni), `0x04` `UART_STP`,
`0x08` `UART_RDR` (salt-okunur), `0x0C` `UART_TDR`, `0x10` `UART_CFG`.

---

## AXI protokol kontrolü

`Bind_for_peripherals/axi4lite_bind_uart_gu.svh` ile `NAME("UART_GU")`,
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

[AXI-CHK]        UART_GU | AW=17 W=17 B=17 AR=5 R=5 | ihlal=0 uyari=0
```

---

## Okurken dikkat edilecekler

- **Testlerdeki baud değerleri kart değerleri değildir.** Testbench 100 MHz ile
  koşar ve bilerek üç farklı bölen dener (375 / 417 / 500) — amaç tek bir baud'u
  değil, **bölen mekanizmasını** sınamaktır. Gerçek sistemde saat 50 MHz ve
  `UART_CPB = 434` (50 MHz / 434 = 115200) kullanılır.
- **Stop biti alanı 0 / 2 / 3 olarak sürülür.** `UART_STP` 2 bitliktir ve
  sırasıyla 1 / 1,5 / 2 stop bitine karşılık gelir; üç senaryo da kapsanmıştır.
- **Bu blok genel amaçlı UART'tır.** Kart üzerinde kendi fiziksel pin çiftine
  sahiptir (Nexys A7'de kart üstündeki FT2232 kanalı); demo test harness'inin
  "core UART" arayüzü budur ve çıkarım sonucu buradan çıkar. YZ veri akışı
  UART'ı ayrı bir fiziksel porttur.
- **`UART_CPB = 0` tuzağı bu testbench'te tetiklenmez.** Bölen sıfırken TX
  FSM'i hiç başlamaz (belgelenmiş kısıt, kusur değil); o yolu UVM
  `uart_gu_cpb_zero_test` kapsar ([`../../../uvm/`](../../../uvm/)).
