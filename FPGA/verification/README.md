# verification — Doğrulama Sonuçları

Tasarladığımız MCU'nun doğrulama kanıtları. Bu dosya  **özettir**; her doğrulamanın
ayrıntılı açıklaması kendi klasöründeki README'dedir.

Hedef aygıt: **xc7a100tcsg324-1** (Nexys A7), sistem saati **50 MHz**.

---

## Özet

| Doğrulama | Ne kapsıyor | Sonuç | Rapor |
|---|---|---|---|
| Sentez | `fpga_top`, tüm SoC | hatasız | [`vivado_reports/synthesis/`](vivado_reports/synthesis/) |
| Implementasyon | yerleştirme + yollama | hatasız, 14575/14575 net yollandı, 0 hata | [`vivado_reports/implementation/`](vivado_reports/implementation/) |
| Zamanlama | 50 MHz kısıtı | **WNS +0,564 ns**, WHS +0,037 ns, 0 ihlal (14322 uç) | [`vivado_reports/timing_report/`](vivado_reports/timing_report/) |
| Kaynak kullanımı | — | LUT %15,76 · FF %3,56 · BRAM %14,07 · DSP %2,50 ¹ | [`vivado_reports/synthesis/`](vivado_reports/synthesis/) |
| Kod kapsamı | 6 çevre birimi + YZ hızlandırıcı | statement %91–100 | [`vivado_reports/code_coverage/`](vivado_reports/code_coverage/) |
| AXI4-Lite protokol | 15 arayüz | **0 ihlal** | [`vivado_reports/code_coverage/`](vivado_reports/code_coverage/) |
| YZ — fonksiyonel | 3 sınıf, sistem testi | 3/3 doğru, 45.517 çevrim/çıkarım | [`vivado_reports/code_coverage/`](vivado_reports/code_coverage/) |
| YZ — bellek bütçesi | hızlandırıcının tüm RAM/ROM'ları | **30.720 B = 30,00 KB** (sınır 30 KB) | [`ai_accel_reports/`](ai_accel_reports/) |
| YZ — doğruluk | 156 ses örneği, kart üzerinde | yazılım %91,03 · donanım %91,03 → fark **0,00 puan** | [`ai_accel_reports/`](ai_accel_reports/) |
| YZ — hızlanma | Vivado simülasyonu | **276,9×** (12.608.381 → 45.540 çevrim) | [`ai_accel_reports/`](ai_accel_reports/) |

¹ YZ girdi RAM'i 32.768 → 9.904 bayta indirildikten sonra yeniden sentez
bekliyor; BRAM oranı düşecek.

Şartnamenin iki YZ maddesi de karşılanmıştır: hızlanma sağlanmış, doğruluk farkı
%10'luk pencerenin içinde kalmıştır (mutlak 0,00 puan / bağıl %0,00).

---
### Çıktı Görselleri:

**Code Coverage Sonuçları:**
![](.images/coverage_results.png)

**Design Route Status:**
![](.images/design_route_status.png)

**Timing Özeti:**
![](.images/timing_summary.png)

**FPGA Üzerindeki Yerleşim:**
![](.images/layout.png)

---

## Klasörler

| Klasör | İçeriği |
|---|---|
| [`vivado_reports/`](vivado_reports/) | Sentez, implementasyon, zamanlama, kaynak kullanımı ve kod kapsamı raporları |
| [`ai_accel_reports/`](ai_accel_reports/) | YZ hızlandırıcının yazılım gerçeklemesine karşı doğruluk ve hız ölçümleri |

---

## Planlanan doğrulamalar

| Doğrulama | Kapsam | Durum |
|---|---|---|
| UVM | Çevre birimi ve arayüz seviyesinde kısıt-güdümlü rastgele doğrulama | planlandı |
| Spike ISS | CV32E40P'nin komut seviyesinde referans simülatörle karşılaştırılması | planlandı |

Eklendiklerinde bu klasörün altına kendi alt klasörleriyle gelecek ve
yukarıdaki özet tablosuna birer satır eklenecektir.

---

Ölçüm tarihi: 2026-08-08. Araç: Vivado / XSim **2025.2**.
