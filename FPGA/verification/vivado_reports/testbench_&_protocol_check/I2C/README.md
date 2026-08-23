# I2C Master — Directed Testbench Sonucu

`I2C_Master_AXI4_Lite` bloğunun **yönlendirilmiş (directed)** blok testbench'i.
Testbench iki parça içerir: AXI tarafını süren senaryolar ve SDA/SCL hattına
bağlı **pasif bir veri yolu monitörü** (`i2c_bus_monitor`) — START/STOP
koşullarını, gönderilen baytları ve ACK/NACK bitlerini çözer. Böylece her test
hem register seviyesinde hem **telin üzerinde** doğrulanır. Karşı taraftaki
köle (slave) de testbench tarafından modellenir; ACK/NACK'i o üretir.
`axi4lite_protocol_checker` aynı koşumda AXI arayüzüne `bind` ile bağlıdır.

Testbench: [`I2C_tb.sv`](../../../../main_codes/testbench/Peripherals/I2C/I2C_tb.sv) ·
Proje: `scripts/project_gen/Peripherals/create_I2C.tcl` ·
Simülatör: **XSim 2025.2** · TB saati: 100 MHz · Simülasyon süresi: **1,080 ms**

> **Ham çıktı: [`xsim_console.log`](xsim_console.log)** — `[BUS]` ile başlayan
> satırlar veri yolu monitörünün çözdüğü gerçek I2C trafiğidir.

---

## Özet

| Ölçüm | Sonuç |
|---|---|
| Test | 10 |
| Geçen | **10 / 10** |
| Kalan | 0 |
| AXI protokol ihlali | **0** |
| Uyarı (stall/watchdog) | 0 |
| İzlenen AXI arayüzü | 1 (`I2C`) |
| Gözlenen işlem | 54 yazma · 12.853 okuma |

---

## Testler

| # | Test | Ne doğruluyor | Sonuç |
|---|---|---|---|
| 1 | Tek bayt yazma (1B Write) | Tam çerçeve: START → adres baytı (`0xCC`, ACK) → veri baytı (`0xAB`, ACK) → STOP; `WR_DONE=1`, timeout yok | GEÇTİ |
| 2 | Dört bayt yazma (4B Write) | `I2C_NBY=4` ile çok baytlı yazma; monitör bayt **sırasının** doğru olduğunu gösterir (`cd ab cd ab`) | GEÇTİ |
| 3 | Tek bayt okuma (1B Read) | **Yinelenen START** (repeated START) ile okuma çerçevesi; gelen bayt `I2C_RDR`'ye (`0x08`) doğru yerleşiyor, son bayta NACK veriliyor | GEÇTİ (`RDR=0x5A`) |
| 4 | Dört bayt okuma (4B Read) | 4 baytın `I2C_RDR`'de doğru sırayla birleşmesi (`0x12345678`) | GEÇTİ |
| 5 | Adres çerçevesinde NACK | Köle adrese NACK verince master **sessizce iptal** ediyor: `Timeout=1` bayrağı kalkıyor, DONE bayrağı **kalkmıyor** — RTL'in `S_ABORT` dalı | GEÇTİ |
| 6 | Veri çerçevesinde NACK | Aynı iptal davranışı, bu kez veri baytında NACK gelince | GEÇTİ |
| 7 | `WR_DONE` temizleme | `I2C_CLR` (`0x14`) yazmaç-ile-temizle (W1C) davranışı: temizlemeden önce `WR_DONE=1`, sonra `0` | GEÇTİ |
| 8 | Ardışık yazma (back-to-back) | Boşta beklemeden iki transfer: birincisi bitmeden ikincisi başlatılabiliyor, ikinci verinin (`0x55`) hattaki değeri doğru | GEÇTİ |
| 9 | Yazma sonrası okuma | Yazma çerçevesini hemen bir okuma çerçevesi izliyor; her ikisinin de verisi doğru (`RDR=0xABCD`) | GEÇTİ |
| 10 | `I2C_CFG` tutarlılığı | Arka arkaya iki `I2C_CFG` (`0x10`) okuması aynı değeri veriyor ve `WR_DONE` biti set — register okuması yan etkisiz | GEÇTİ |

---

## AXI protokol kontrolü

`Bind_for_peripherals/axi4lite_bind_i2c.svh` ile `NAME("I2C")`,
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

[AXI-CHK]            I2C | AW=54 W=54 B=54 AR=12853 R=12853 | ihlal=0 uyari=0
```

---

## Okurken dikkat edilecekler

- **12.853 okuma işlemi bir hata değil, yoklamanın (polling) bedeli.** I2C
  standart hızda çalışır; testbench transferin bitmesini `I2C_CFG`'yi AXI'den
  sürekli okuyarak bekler. Her yoklama bir AR/R çifti üretir. Protokol
  kontrolcüsü bu 12.853 okumanın tamamını denetlemiştir.
- **Test 5 ve 6'da "timeout" beklenen sonuçtur.** RTL'in NACK yanıtı
  DONE bayrağı set etmeden `S_ABORT`'a geçmektir; yazılım bunu bir
  **sessiz zaman aşımı** olarak görür. Testler bu davranışı hata değil,
  **iddia** olarak yazar — kusur olarak okunmamalıdır.
- **`I2C_NBY` yazılan değeri geri vermeyebilir.** RTL `0x00` ofsetinde
  `wdata > 4` ise 4'e, `wdata == 0` ise 1'e kırpar. Bu kasıtlıdır; kırpma
  semantiğini ayrıca UVM `i2c_nby_test`'i sınar ([`../../../uvm/`](../../../uvm/)).
- **Köle modeli testbench'in içindedir.** Gerçek bir I2C çevre biriminin
  zamanlama modeli değildir; amaç master'ın **protokol üretimini** doğrulamaktır.
