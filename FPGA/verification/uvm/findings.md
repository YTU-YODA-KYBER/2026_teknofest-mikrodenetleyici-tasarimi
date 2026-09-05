# UVM Ortamının Bulguları

Bu dosya, UVM doğrulama ortamının çalıştırılması sırasında ortaya çıkan RTL
bulgularını ve doğrulanan belgelenmiş davranışları listeler. Her madde için
hangi testin ne gösterdiği ve nasıl tekrar üretileceği yazılıdır.

Regresyon ölçüm tarihi: **2026-09-05** · Verilator 5.050 · UVM 2020.3.1 (no-DPI)

---

## 1. GPIO: kabul koşulu kendi hazır sinyaliyle nitelenmemiş

**Durum: düzeltildi.** `GPIO_AXI4_Lite.sv` kabul koşulu artık kendi
`awready`/`arready`'siyle nitelenmektedir (satır 72 ve 91); diğer altı çevre
birimiyle aynı kalıptadır. `gpio_stress_test` geçmektedir.

Ortam bu bulguyu ilk koşumda tespit etmişti; o sırada `GPIO_AXI4_Lite.sv` işlem
kabul koşulunu kendi `awready`/`arready`'siyle nitelemiyordu:

```systemverilog
if (awvalid && wvalid) begin      // eski GPIO — nitelenmemiş
if (arvalid)           begin      // eski GPIO — nitelenmemiş
```

Şimdi diğer altı çevre birimiyle aynı kalıptadır:

```systemverilog
if (awvalid && wvalid && awready && wready) begin
if (arvalid && arready)                     begin
```

### Hatanın etkisi (düzeltme öncesi)

Boru hatlı bir master — kuyruğunda bekleyen ikinci bir işlem varken `AWVALID`'i
indirmeden yeni adres/veriyi sunan bir CPU ya da DMA — GPIO'yu **kilitler**.
AXI4-Lite'ta bu tamamen yasaldır: master `VALID`'i indirmek zorunda değildir,
slave hazır olmadığında `READY`'yi düşük tutarak beklemesini söyler.

GPIO ise `awvalid && wvalid` doğru olduğu **her çevrimde** yazmayı yeniden
çalıştırır; `bvalid` yukarıda takılı kalır ve serbest bırakma dalına
(`else if (bvalid && bready)`) hiç ulaşılamaz. `awready` bir daha yükselmez.

### Kanıt

`gpio_stress_test` (`beats = 2`, yani aynı VALID yükseltmesi üzerinde iki
işlem). AXI protokol kontrolcüsünün sayacı:

```
[AXI-CHK] GPIO | AW=1 W=1 B=10008 AR=0 R=0 | ihlal=3 uyari=2
[AXI-CHK] ORD_01 IHLAL: karsiliksiz BVALID: bekleyen AW islemi yok
[AXI-CHK] ORD_02 IHLAL: karsiliksiz BVALID: bekleyen W islemi yok
[AXI-CHK] OUT_01 IHLAL: yazma outstanding limiti asildi
```

**Tek bir yazma isteğine karşılık 10.008 yazma cevabı** üretilmiş ve DUT
kilitlenmiştir. Üç ihlalin üçü de DUT tarafındadır; master tarafında ihlal
yoktur (sürücü `VALID`'i erken indirmez).

İlk ölçümde test **beklenen başarısız** olarak işaretlenmişti: kilitlenmenin
oluşması bulguyu doğruluyordu. Düzeltmeden sonra bu işaret kaldırılmıştır;
aynı trafik artık normal regresyon kapısı olarak ihlalsiz geçmelidir.

### Tekrar üretme

```
source /usr/Verilator_uvm/env.sh
make -C main_codes/testbench/uvm build BLK=gpio
make -C main_codes/testbench/uvm run BLK=gpio TEST=gpio_stress_test
```

### Neden mevcut testler bunu göremedi

`GPIO_tb.sv` dahil bütün blok testbench'leri el sıkışmadan hemen sonra
`VALID`'i indirir; boru hatlı master davranışı hiç üretilmez. Aynı stres
testi diğer altı blokta **temiz geçer** — sorun GPIO'ya özgüdür.

### Etki değerlendirmesi

Mevcut SoC'de GPIO'yu süren tek master CV32E40P'nin veri yoludur ve
`cv32e40p_obi_to_axi_wrapper` her işlemden sonra `AWVALID`'i indirir; bu
yüzden kartta ve mevcut sistem testlerinde sorun **görünmez**. Risk,
master'ın değişmesi (DMA eklenmesi, farklı bir çekirdek, ASIC tarafında
farklı bir köprü) durumunda ortaya çıkar.

---

## 2. `bresp` / `rresp` yalnızca reset dalında atanıyor

**Durum: bu ortamda görünmez — kaynağı ASIC akışıdır.**

GPIO, Timer, QSPI, UART_GU ve UART_YZ'de `bresp` ve `rresp` sadece reset
dalında `<= 0` yapılır, başka hiçbir yerde atanmaz. Simülasyonda bu sorunsuz
çalışır (register değerini korur ve daima `OKAY` okunur); sorun sentez
aracının bunu sürülmeyen çıkış olarak sayabilmesidir. Yosys/LibreLane akışı
bu sınıftan 91 sinyal saymıştır.

**Bu ortam bu bulguyu üretemez ve üretmeye çalışmaz.** UVM tarafında
doğrulanan şey davranıştır: `axil_scoreboard` her transaction'da cevabın
`OKAY` olduğunu kontrol eder ve 219 koşumun tamamında (9.696 işlem) sapma
görülmemiştir.

Ayrıca Verilator **iki durumludur**: `X` yoktur. Bu yüzden protokol
kontrolcüsünün `XCK_01..07` (X/Z) kuralları bu ortamda ölüdür ve
`tb_axi4lite_checker_selftest.sv`'nin `XCK_02` senaryosu "ATLANDI" basar —
dosya bunu zaten öngörmüştür. X kontrolü XSim tarafındaki mevcut akışta
yapılmaktadır.

---

## 3. Doğrulanan belgelenmiş davranışlar

Aşağıdakiler hata **değildir**; tasarımın bilinen davranışlarıdır ve UVM
ortamı her birini açıkça doğrular. Bir jüri sorusunda "bu neden böyle?"
sorusuna cevap verecek testler bunlardır.

| Davranış | Blok | Doğrulayan test |
|---|---|---|
| Okuma `case`'inde `default` yok → haritalanmamış ofset **bayat** `rdata` döndürür ama `rvalid` yine yükselir | GPIO, UART_GU, UART_YZ | `gpio_unmapped_test`, `uart_*_unmapped_test` |
| Okuma `case`'inde `default` **var** → haritalanmamış ofset 0 döndürür | Timer, I2C, QSPI, YZ CSR | `*_unmapped_test` |
| Adres kod çözme yalnızca `addr[3:0]`'a bakar → register'lar her 16 baytta bir tekrar eder | GPIO | `gpio_unmapped_test` |
| `I2C_NBY` donanımda kırpılır (`>4 → 4`, `0 → 1`); yazılanla geri okunan farklı olabilir | I2C | `i2c_nby_test` |
| NACK sonrası transfer **sessizce** iptal edilir; hiçbir DONE bayrağı set edilmez | I2C | `i2c_nack_test` |
| `TXEN` ve `RXEN` birlikte set edilirse **yazma** kazanır | I2C | `i2c_flags_test` |
| `UART_CPB = 0` iken gönderim hiç başlamaz (`tx_tick_cnt >= UART_CPB - 1` karşılaştırması `0-1 = 32'hFFFF_FFFF` olur) | UART_GU, UART_YZ | `uart_*_cpb_zero_test` |
| `TIM_CLR` / `TIM_EVC`: bit0 = 1 yazılırsa donanım registerin **tamamını** sıfırlar; bit0 = 0 yazılırsa değer korunur | Timer | `timer_event_test` |
| `TIM_PRE` yazması `TIM_PRE_m` aynasına gider; çalışan sayaç hiçbir ofsetten okunamaz | Timer | `timer_event_test` |
| `QSPI_FCR` bir çevrim sonra kendini sıfırlar → geri okuma 0 | QSPI | `qspi_fifo_test` |
| `QSPI_DR` okuması **yıkıcıdır** (RX FIFO'dan çeker); boş FIFO okuması hata kodu 1, dolu FIFO'ya yazma hata kodu 2 üretir | QSPI | `qspi_fifo_test` |
| `YZ_CTRL`'in her biti 1 çevrimlik **darbe**dir, saklanmaz | YZ CSR | `yz_csr_test` |

---

## 4. Kapatılan doğrulama boşlukları

Mevcut blok testbench'lerinde **hiç bağlanmamış** olan iki yol bu ortamda
ilk kez doğrulanmıştır:

| Boşluk | Önceki durum | Şimdi |
|---|---|---|
| UART_YZ'nin DMA yan bandı (`dma_enable_i`, `dma_data_o`, `dma_valid_o`) | `UART_YZ_tb.sv` bu üç portu hiç bağlamıyordu — UART_YZ'yi UART_GU'dan ayıran **tek** özellik blok seviyesinde doğrulanmamıştı | `uart_yz_dma_test`: `enable=1` iken her alınan bayt DMA'dan doğru çıkıyor, `enable=0` iken yol tamamen sessiz kalıyor |
| QSPI DMA register'ı (ofset `0x14`) | `QSPI_tb.sv` `dma_data`/`dma_valid` portlarını bağlamıyor ve `0x14`'e hiç erişmiyordu | `qspi_dma_test`: boşta `dma_valid = 0`, `dma_start` yazıldıktan sonra `dma_valid` darbesi gözleniyor |

---

## 5. Bulunmayan şeyler

Dürüstlük gereği: güncel 219 koşumun tamamında **hiçbir protokol ihlali, veri
uyuşmazlığı ya da beklenmeyen davranış** görülmemiştir. Yukarıdaki GPIO
bulgusu ilk koşumun tarihsel kaydıdır ve düzeltilmiştir; yedi bloktaki bütün
stres ve reset-mid testleri güncel regresyonda temizdir.

Ortamın göremeyeceği şeyler açıkça şunlardır:

- **X/Z yayılımı** — Verilator iki durumludur (bkz. madde 2).
- **Zamanlama** — bu bir RTL simülasyonudur; kurulum/tutma marjı
  `verification/vivado_reports/timing_report/` içindedir.
- **Flash protokolünün tamamı** — UVM tarafındaki flash modeli hafiftir;
  gerçek Micron MT25QL256 modeliyle doğrulama XSim tarafında yapılmıştır ve
  o kanıt yerinde durmaktadır.
- **Sistem seviyesi etkileşim** — bu ortam blok seviyesindedir. CPU'nun
  sürdüğü uçtan uca akış `main_codes/testbench/System_Test/` altındaki
  testlerle doğrulanır.
