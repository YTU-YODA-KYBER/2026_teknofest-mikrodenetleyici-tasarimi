# Üst Seviye Doğrulama Planı

Bu plan, TEKNOFEST 2026 Çip Tasarım Yarışması mikrodenetleyici kategorisindeki
tasarımın RTL'den FPGA bitstream'ine ve ASIC fiziksel çıktısına kadar uygulanan
doğrulama faaliyetlerini, kanıtlarını ve tamamlanma ölçütlerini tek yerde
tanımlar. Blok seviyesindeki ayrıntılı UVM senaryoları
[`uvm/test_plan.md`](uvm/test_plan.md) içindedir.

## Kapsam ve tamamlanma ölçütleri

Doğrulama aşağıdaki koşullar birlikte sağlandığında tamamlanmış kabul edilir:

1. Altı çevre birimi ile YZ hızlandırıcının CPU'ya bakan AXI4-Lite arayüzleri
   blok seviyesinde self-checking testlerden geçmelidir.
2. Sistem testlerinde boot ve YZ çıkarım zincirleri gerçek firmware ile uçtan
   uca tamamlanmalıdır.
3. Test sırasında etkin olan AXI4-Lite arayüzlerinde protokol ihlali olmamalıdır.
4. CV32E40P komut izi Spike referans modeliyle farklılık göstermemelidir.
5. YZ hızlandırıcı yazılım referansının doğruluk penceresinde kalmalı, hızlanma
   sağlamalı ve 30 kB bellek sınırını aşmamalıdır.
6. FPGA sentez/implementasyon akışları hatasız bitmeli, bütün yönlendirilebilir
   ağlar yönlendirilmeli, kurulum ve tutma zamanlaması ihlalsiz olmalı ve
   yüklenebilir bitstream üretilmelidir.
7. ASIC yapılandırması SRAM/mask-ROM eşdeğerlik, arbitraj, boot ve YZ sistem
   testlerinden geçmelidir.
8. ASIC tesliminde DRT/Magic/KLayout DRC, LVS, GDS XOR, PDN, illegal overlap,
   kritik bağlantısız pin ve setup/hold ihlal sayıları sıfır olmalı; zorunlu
   dosya kapısı eksiksiz geçmelidir. Sıfır olmayan diğer kalite ölçümleri
   saklanmalı ve gerçek değerleriyle raporlanmalıdır.

## Doğrulama matrisi

| Seviye | Yöntem ve kapsam | Tamamlanma ölçütü | Durum ve kanıt |
|---|---|---|---|
| İşlemci | Spike ISS lockstep; CV32E40P komut izi | Bütün komutlar eşleşir, 0 fark | **Geçti:** 193/193; [`spike_iss/`](spike_iss/) |
| Blok/UVM | GPIO, Timer, UART_GU, UART_YZ, I2C, QSPI, YZ CSR; 73 test × 3 tohum | Bütün koşumlar geçer; UVM hata/fatal, scoreboard uyuşmazlığı ve AXI ihlali 0 | **Geçti:** 219/219; [`uvm/`](uvm/) |
| UART hız | İki UART'ta TX, RX ve full-duplex; 50 MHz'de `UART_CPB=50` | 1 Mbps çerçeveleri kayıpsız alınır/gönderilir | **Geçti:** [`uvm/logs/uart_gu/`](uvm/logs/uart_gu/) · [`uvm/logs/uart_yz/`](uvm/logs/uart_yz/) |
| Blok/directed | Altı çevre birimi, self-checking XSim testbench'leri | Bütün kontroller geçer | **Geçti:** [`vivado_reports/testbench_&_protocol_check/`](vivado_reports/testbench_&_protocol_check/) |
| Protokol | 15 AXI4-Lite arayüzünde 40 SVA kuralı | Etkin trafikte 0 ihlal | **Geçti:** 0 ihlal; [`vivado_reports/testbench_&_protocol_check/`](vivado_reports/testbench_&_protocol_check/) |
| Sistem/boot | Flasher → QSPI flash → Boot ROM → DMA → Instruction RAM → uygulama | Beş kilometre taşı ve self-checking sonuç geçer | **Geçti:** [`.../Boot/`](vivado_reports/testbench_&_protocol_check/Boot/) |
| Sistem/YZ | UART veri akışı → hızlandırıcı → kesme → CPU/UART sonucu | Üç sınıf doğru; sistem testi geçer | **Geçti:** [`.../AI_Accelerator/`](vivado_reports/testbench_&_protocol_check/AI_Accelerator/) |
| YZ kalite | 156 kart örneği, RTL/model karşılaştırması, çevrim ölçümü, bellek bütçesi | Doğruluk farkı ≤ %10; hızlanma > 1; bellek ≤ 30 kB | **Geçti:** 0,00 puan fark, 276,9×, 30,00 kB; [`ai_accel_reports/`](ai_accel_reports/) |
| FPGA yapım | Temiz sentez, place-and-route, DRC, STA, güç ve bitstream | Akış hatasız; 0 yönlendirme ve zamanlama ihlali; bitstream mevcut | **Geçti:** [`vivado_reports/`](vivado_reports/) · [`../bitstream_files/fpga_top.bit`](../bitstream_files/fpga_top.bit) |
| ASIC işlevsel | SRAM çakışması, IMEM iki-master arbitrajı, 12.592 bellek/ROM kontrolü, boot, YZ | Beş test geçer; sistem testlerinde AXI ihlali 0 | **Geçti:** [`../../asic/reports/general/asic_sim/`](../../asic/reports/general/asic_sim/) |
| ASIC fiziksel | Sentez, STA, yerleşim, yönlendirme, DRC/LVS/XOR ve paket kapısı | Kritik signoff ölçütleri 0; dokuz köşede setup/hold 0; zorunlu kalemler eksiksiz | **Geçti:** 79/79; [`../../asic/README.md`](../../asic/README.md) |

## Regresyon ve hata yönetimi

- Testler self-checking'dir; başarı yalnız beklenen işaretlerin bulunmasına
  değil, hata/ihlal sayaçlarının sıfır olmasına da bağlıdır.
- UVM regresyon koşucusu sonuç olarak logdaki son `SONUC` satırını kullanır ve
  koşulan blokların teslim loglarını yeni koşumla birebir değiştirir.
- Bulunan RTL sorunları, etkileri ve regresyon testleri
  [`uvm/findings.md`](uvm/findings.md) içinde tutulur.
- RTL veya testbench davranışını etkileyen değişiklikte ilgili blok testleri;
  ortak AXI/UVM altyapısı değişikliğinde 219 koşumun tamamı yeniden çalıştırılır.
- ASIC fiziksel strateji denemelerinin kabul/ret gerekçeleri
  [`../../asic/reports/synthesis/strateji_denemeleri.md`](../../asic/reports/synthesis/strateji_denemeleri.md)
  içinde korunur.

## Kapsam dışı ve bilinen sapmalar

- JTAG TAP/debug modülü şartnamede opsiyonel bonus kalemidir ve uygulanmamıştır.
- `QSPI_CCR[24]` gerçeklemede adres fazı seçimi için kullanılırken şartnamede
  rezerve gösterilmiştir; bu sapma ana doğrulama özetinde açıkça belirtilir.
- Ekran görüntüleri ölçümün birincil kaynağı değildir; sayısal sonuçların
  doğruluk kaynağı teslim edilen ham rapor ve loglardır.
