# BENIMSENEN KOSUM: `rtl2gds`, 2026-08-31, LAYERS_RC + post-GRT marj 0

Bu kosum `reports/` ve `results/` altindaki teslim paketini uretmistir.
Bir onceki referans: `../baseline_rtl2gds_50ns/` (2026-08-29).

## Degisen yapilandirma
- `LAYERS_RC` eklendi (ORFS sky130 tablosu; PnR tel kapasitans tahminini
  2,23 kat iyimserlikten gercege %7 yakina getirir)
- `GRT_DESIGN_REPAIR_MAX_SLEW_PCT` / `..._CAP_PCT`: 20 -> 0 (duzeltilmis RC ile
  cifte sayima donusmustu)
- `GRT_OVERFLOW_ITERS`: 20 -> 30
- `SYNTH_CLK_DRIVING_CELL`: tanimsiz -> `sky130_fd_sc_hd__clkbuf_16/X`
- RTL: `UART_mux.sv` TX artik her modda genel UART'tan surulur (sartname
  Bolum 4.2.2 madde 5); firmware `main_app.c`/`yz_bench.c` buna uyarlandi

## Sonuc

| Metrik | onceki | bu kosum |
|---|---:|---:|
| DRT / Magic / KLayout DRC | 0 / 0 / 0 | **0 / 0 / 0** |
| XOR / illegal overlap / LVS / PDN | 0 | **0** |
| Setup / hold ihlalli uc | 0 / 0 | **0 / 0** |
| Max slew ihlali | 32.763 | **880** (-%97,3) |
| Max cap ihlali | 2.858 | **628** (-%78,0) |
| Anten net / pin | 2.904 / 4.341 | **1.977 / 2.388** (-%32 / -%45) |
| Setup WS (`max_ss`) | +2,1001 ns | **+3,6236 ns** |
| Hold WS | +0,1924 ns | **+0,1099 ns** |
| Toplam tel | 10.715.050 um | **10.465.589 um** (-%2,3) |
| Sentez alani | 773.264 um2 | **771.435 um2** |
| Std hucre alani | 1,28768 mm2 | 1,51984 mm2 (+%18,0) |
| Timing-repair tampon | 31.350 | 50.141 |
| Lint uyarisi | 891 | 892 (+1: UART_YZ_TX UNUSEDSIGNAL, kasitli) |

`scripts/compare_metrics.py` kabul kapisi: 16 zorunlu metrigin hepsi korundu.
