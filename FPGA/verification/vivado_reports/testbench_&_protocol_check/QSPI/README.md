# QSPI Master — Directed Testbench Sonucu

`QSPI_Master_AXI4_Lite` bloğunun **yönlendirilmiş (directed)** blok
testbench'i. Diğer beş çevre biriminden farkı: karşı tarafta testbench'in
yazdığı basit bir model değil, **Micron'un kendi flash simülasyon modeli**
(`Micron_sim_model.v`, `MT25QL256ABA8E0`) durur. Bu yüzden komut kodları,
adres/dummy çevrim sayıları, silme/programlama süreleri ve koruma register'ları
gerçek aygıtın davranışına göre denetlenir. `axi4lite_protocol_checker` aynı
koşumda AXI arayüzüne `bind` ile bağlıdır.

Testbench: [`QSPI_tb.sv`](../../../../main_codes/testbench/Peripherals/QSPI/QSPI_tb.sv) ·
Flash modeli: [`Micron_sim_model.v`](../../../../main_codes/testbench/Peripherals/QSPI/Micron_sim_model.v) ·
Proje: `scripts/project_gen/Peripherals/create_QSPI.tcl` ·
Simülatör: **XSim 2025.2** · TB saati: 100 MHz · Simülasyon süresi: **6,339 ms**

> **Ham çıktı: [`xsim_console.log`](xsim_console.log)** — `[... ns] ==INFO==`
> ve `Command execution` satırları flash modelinin kendi çıktısıdır.

---

## Özet

| Ölçüm | Sonuç |
|---|---|
| Test bloğu | 2 (8 + 4 alt kontrol) |
| Sayılan kontrol | **12** |
| Geçen | **12 / 12** |
| Kalan | 0 |
| AXI protokol ihlali | **0** |
| Uyarı (stall/watchdog) | 0 |
| İzlenen AXI arayüzü | 1 (`QSPI`) |
| Gözlenen işlem | 9.408 yazma · 118.166 okuma |

---

## Testler

### TEST 1 — FIFO bayrakları ve QSPI çekirdeği (8 kontrol)

| # | Alt test | Ne doğruluyor | Sonuç |
|---|---|---|---|
| 1.1 | Reset sonrası başlangıç durumu | Reset bırakıldığında TX ve RX FIFO'ları **boş** (`empty=1`), meşguliyet yok, hata kodu `0000` | GEÇTİ (2 kontrol) |
| 1.2 | Doluluk bayrakları | Her iki FIFO 64 veriyle doldurulunca `full` bayrakları kalkıyor, `empty` düşüyor | GEÇTİ (2 kontrol) |
| 1.3 | Hata bayrakları | **Boş RX FIFO'dan okuma** ve **dolu TX FIFO'ya yazma** denenince `QSPI_STA` hata alanı `0011` oluyor — taşma/boşalma korumaları çalışıyor | GEÇTİ (2 kontrol) |
| 1.4 | FIFO flush | `QSPI_FCR` (`0x10`) ile flush sonrası her iki FIFO'nun sayacı ve işaretçileri sıfırlanıyor | GEÇTİ (2 kontrol) |

### TEST 2 — Gerçek flash modeliyle uçtan uca senaryolar (4 kontrol)

| # | Alt test | Ne doğruluyor | Sonuç |
|---|---|---|---|
| 2.1 | JEDEC tanımlama okuma | `RDID` komutu gerçek modele gönderiliyor, dönen kimlik `0x20BA19` (beklenen değer) | GEÇTİ |
| 2.2 | Sektör silme | `WREN` → PPB koruma temizleme → sektör silme → `Clear Flag Status` zinciri; silinen bölge `0xFF`'e dönüyor | GEÇTİ |
| 2.3 | Farklı frekans ve veri modlarında **yazma** | **12 MHz / x4** ile 256 bayt Quad Program (`QPP`) ve **4 MHz / x1** ile 256 bayt Page Program (`PP`); iki farklı bölen, iki farklı hat genişliği | GEÇTİ |
| 2.4 | Farklı frekans ve veri modlarında **okuma** | **6 MHz / x4** Quad Output Read (`QOR`, `0x6B`) 256 bayt · **12 MHz / x2** Dual Output Read (`DOR`, `0x3B`) 128 bayt · **24 MHz / x1** normal okuma 128 bayt; üçünde de yazılan veri birebir geri okunuyor (dummy çevrim sayıları dahil) | GEÇTİ |

Register haritası: `0x00` `QSPI_CCR` (komut — **yazma transfer başlatır**),
`0x04` `QSPI_ADR`, `0x08` `QSPI_DR` (FIFO penceresi — **okuma yıkıcıdır**),
`0x0C` `QSPI_STA` (salt-okunur), `0x10` `QSPI_FCR`, `0x14` DMA.

---

## AXI protokol kontrolü

`Bind_for_peripherals/axi4lite_bind_qspi.svh` ile `NAME("QSPI")`,
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

[AXI-CHK]           QSPI | AW=9408 W=9408 B=9408 AR=118166 R=118166 | ihlal=0 uyari=0
```

Bu, altı çevre birimi arasındaki **en yoğun AXI trafiğidir**: 127.574 işlemin
tamamı 40 kuralın süzgecinden geçmiştir.

---

## Okurken dikkat edilecekler

- **AXI işlemleri neden bu kadar çok?** Flash komutları uzun sürer (bir sektör
  silme modelde 2 ms); testbench bitişi `QSPI_STA` ve flash durum
  register'larını AXI'den yoklayarak bekler. 118.166 okumanın büyük kısmı bu
  yoklamadır — protokol kontrolcüsü hepsini denetlemiştir.
- **Log'daki üç `WARNING` ve bir `--TIMING VIOLATION--` bizim RTL'imize ait
  değildir.** İki uyarı Micron modelinin isteğe bağlı içerik dosyalarınadır
  (`mem_Q512.vmf`, `sfdp.vmf` — depoda yok, model bunlarsız da boş bellekle
  çalışır); `tSHCH` ihlali ise modelin kendi zamanlama kontrolüdür ve test
  başlangıcında CS yükselirken bir kez tetiklenir. Hiçbiri testin sonucunu
  etkilemez, hiçbiri AXI protokol ihlali değildir.
- **Micron modeli kod kapsamı ölçümünün dışında tutulur.** 182.652 satırlık
  üçüncü taraf model rapora girseydi yüzdeleri anlamsızlaştırırdı; ayrıntı
  [`../../code_coverage/README.md`](../../code_coverage/README.md).
- **`QSPI_CCR`'a yazmak bir olaydır.** Register alan alan değil, sekiz alanı
  birden içeren tek 32-bit yazmayla sürülür (`firmware/soc.h`'taki
  `QSPI_CCR_MAKE()` makrosu bunun içindir).
- **DMA register'ı (`0x14`) bu testbench'te sürülmez.** O yol UVM
  `qspi_dma_test` ile kapsanır ([`../../../uvm/`](../../../uvm/)).
