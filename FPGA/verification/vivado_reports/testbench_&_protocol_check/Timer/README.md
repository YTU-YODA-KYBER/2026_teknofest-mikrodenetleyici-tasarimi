# Timer — Directed Testbench Sonucu

`Timer_AXI4_Lite` bloğunun **yönlendirilmiş (directed)** blok testbench'i. Elle
yazılmış senaryolarla yukarı/aşağı sayma modları, olay (event) üretimi ve
temizlenmesi, AXI4-Lite register erişimi ve tanımsız adres davranışı sürülür.
Aynı koşumda `axi4lite_protocol_checker` bloğun AXI arayüzüne `bind` ile
bağlıdır — protokol kontrolü ayrı bir koşum değil, bu testin içindedir.

Testbench: [`Timer_tb.sv`](../../../../main_codes/testbench/Peripherals/Timer/Timer_tb.sv) ·
Proje: `scripts/project_gen/Peripherals/create_Timer.tcl` ·
Simülatör: **XSim 2025.2** · TB saati: 100 MHz · Simülasyon süresi: **50,14 µs**

> **Ham çıktı: [`xsim_console.log`](xsim_console.log)** — aşağıdaki bütün
> sayılar o dosyadan alınmıştır.

---

## Özet

| Ölçüm | Sonuç |
|---|---|
| Test bloğu | 6 |
| Sayılan kontrol | **8** |
| Geçen | **8 / 8** |
| Kalan | 0 |
| AXI protokol ihlali | **0** |
| Uyarı (stall/watchdog) | 0 |
| İzlenen AXI arayüzü | 1 (`TIMER`) |
| Gözlenen işlem | 30 yazma · 5 okuma |

---

## Testler

| # | Test | Ne doğruluyor | Sonuç |
|---|---|---|---|
| 1 | `TIM_PRE_m = 0`, hedef 1453 | Bölücüsüz (maksimum hız) **yukarı sayma**: `TIM_MOD=1` ile sayaç `TIM_ARE`'ye ulaşınca `TIM_EVN` artıyor mu | GEÇTİ (`TIM_EVN=1`) |
| 2 | `TIM_PRE_m = 0`, hedef 0 | **Aşağı sayma** modu (`TIM_MOD=0`): sayaç 0'a inince yeniden yükleniyor ve olay üretiyor mu | GEÇTİ (`TIM_EVN=2`) |
| 3 | `TIM_ARE = 0xFFFF_FFFF` | 32-bit sınırda **rollover**: sayaç en büyük değere dayanınca `TIM_CNT` 0'a dönüyor mu (`force` ile sınıra taşınıp beklenir) | GEÇTİ |
| 4 | AXI okuma testi | **4a:** `TIM_ARE`'ye (`0x04`) yazılan 1981 geri okunuyor mu. **4b:** sayaç **koşarken** `TIM_CNT` (`0x14`) anlık okunabiliyor mu (canlı değer > 0) | GEÇTİ (1981 · `TIM_CNT=24`) |
| 5 | Olay okuma + temizleme | `TIM_EVN` (`0x18`) AXI'den okunuyor, `TIM_EVC`'ye (`0x1C`) 1 yazılınca olay sayacı sıfırlanıyor, sonraki olaylar için 0'a geri alınabiliyor mu | GEÇTİ (okunan 0) |
| 6 | AXI hata senaryoları | **6a:** tanımsız adrese (`0xF0`) yazma. **6b:** tanımsız adresten okuma. **6c:** salt-okunur `TIM_CNT`'ye (`0x14`) yazma. Üçü de RTL'deki `default` dallarını tetikler ve blok kilitlenmeden AXI cevabı üretmelidir | GEÇTİ (3 kontrol) |

Sayaç `toplam_basari`, Test 4'ün iki alt kontrolünü **tek** kontrol sayar; bu
yüzden 6 test bloğundan 8 kontrol çıkar.

---

## AXI protokol kontrolü

`Bind_for_peripherals/axi4lite_bind_timer.svh` ile `NAME("TIMER")`,
`MAX_OUTSTANDING(1)` olarak bağlanır. Simülasyon sonunda:

```
======================================================================
            AXI4-LITE PROTOKOL KONTROL OZETI
======================================================================
  Izlenen AXI arayuzu sayisi : 1
  Protokol ihlali            : 0
  Uyari (stall/watchdog)     : 0
  SONUC                      : GECTI  (0 ihlal)
======================================================================

[AXI-CHK]          TIMER | AW=30 W=30 B=30 AR=5 R=5 | ihlal=0 uyari=0
```

Kural setinin tamamı (10 kategori, 40 kural) için:
[`AXI_protocol_check/README.md`](../../../../main_codes/testbench/AXI_protocol_check/README.md).

---

## Okurken dikkat edilecekler

- **Test 6 "hata" testi değil, `default` dalı testidir.** Timer'ın adres kod
  çözmesi `awaddr[7:0]`/`araddr[7:0]` üzerinde `case` ile yapılır ve tanımsız
  ofset sessizce yutulur (`default: ;` / `rdata <= 0`). Test bu davranışın
  **kilitlenmeye yol açmadığını** gösterir — AXI cevabı yine üretilir.
- **Testbench saati 100 MHz'dir, sistem saati 50 MHz.** Blok testbench'i
  bloğun kendi zamanlamasını sınar; sistemdeki gerçek saatle koşan hâli
  [`../AI_Accelerator/`](../AI_Accelerator/) altındaki sistem testindedir.
- **Sayaç değerleri koşuma bağlıdır.** `TIM_EVN=1`, `TIM_EVN=2` ve
  `TIM_CNT=24` gibi sayılar bekleme noktalarının nereye denk geldiğine
  bağlıdır; testin kararı bu değerlerin **eşitliğine değil, aralığına** bakar.
