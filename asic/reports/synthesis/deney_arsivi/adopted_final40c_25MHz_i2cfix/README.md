# BENIMSENEN: `final40c` -- 25 MHz + duzeltilmis I2C + sert hata kapilari

Tarih: 2026-08-31. `reports/` ve `results/` bu kosumdan toplandi.
Onceki: `../adopted_final40b_25MHz/` (ayni fizik, ESKI ve HATALI I2C netlisti).

## Bu kosumda yeni olan

1. **I2C sabit sayac hatasi duzeltildi (P0, islevsel).** Kaynakta SCL
   `HALF_PERIOD`'da sarar ama FSM SABIT `7'd29` bekler
   (`I2C_Master_AXI4_Lite.sv:111,228`). 29 sabiti modulun varsayilan 48 MHz'inin
   orta noktasidir. **20 MHz'de HALF_PERIOD=24 oldugu icin 29'a HIC ULASILMAZ
   ve I2C KILITLENIR** -- bu oturumda daha once teslim edilen 20 MHz paketi bu
   hatayi tasiyordu. ASIC yamasi (kaynak RTL'ye dokunulmadan, patch_rtl.py)
   kesirli Bresenham bolucu kurar ve FSM esigini gercek orta noktaya baglar:
   25 MHz'de 31/32 cevrimler 3:1 dagitilir -> SCL tam 400.000,000 Hz.
   Bulan: bagimsiz ic denetim (bkz. `../../strateji_denemeleri.md`).
2. **`ERROR_ON_*` sert kapilar acildi**: TrDRC, Magic DRC, KLayout DRC, LVS,
   XOR, illegal overlap, PDN. Bu kosum o kapilarla GECTI, yani "kontroller
   kapaliydi" itirazi artik gecersizdir. `ERROR_ON_DISCONNECTED_PINS` (bilinen
   480 kullanilmayan SRAM `dout0`) ve `ERROR_ON_LONG_WIRE` false kaldi.
3. `patch_rtl.py` artik firmware `ASIC_CLK_HZ` ile config frekansini
   karsilastirir; uyusmazlikta sentezden ONCE hata verir.

## Sonuc

| Metrik | `final40b` | **`final40c`** |
|---|---:|---:|
| Setup WS (`max_ss`) | +5,2707 ns | **+6,3149 ns** |
| Hold WS (`min_ff`) | +0,1562 ns | **+0,0570 ns** |
| Max slew / cap | 1.100 / 615 | **991 / 589** |
| Max fanout | 0 | **0** |
| Anten net / pin | 1.950 / 2.399 | **1.935 / 2.364** |
| Std hucre alani | 1,48603 mm2 | 1,49783 mm2 |
| Toplam tel | 9.984.966 um | 10.192.713 um |
| Toplam guc | 39,09 mW | 39,80 mW |
| DRT/Magic/KLayout DRC, LVS, XOR, PDN, overlap | 0 | **0 (sert kapiyla)** |
| I2C | **HATALI netlist** | **duzeltilmis, SCL 400 kHz** |

## DIKKAT: hold payi daraldi

En kotu hold `min_ff_n40C_1v95`'te **+0,057 ns** (periyodun %0,14'u).
`final40b`'de +0,156 ns idi. Dokuz kosenin tamaminda POZITIF, hold TNS = 0 ve
ihlalli uc = 0, yani ihlal YOKTUR -- fakat hizli kose payi dardir ve bu README
Bolum 9.9'da acikca beyan edilmelidir. Muhtemel sebep I2C kesirli bolucusunun
ekledigi akumulator mantiginin yerlesim/CTS'i kaydirmasidir; tek kosumdan kesin
sebep atfedilmemistir.

Kose bazinda hold: ss ~+0,74 ns, tt ~+0,24 ns, ff +0,057..+0,061 ns.

## Dogrulama
- Bes ASIC regresyonu yeni I2C netlistiyle 5/5 GECTI
- `compare_metrics.py`: 16 zorunlu metrigin tamami korundu
- `verify_deliverables.py`: PAKET KAPISI GECTI
