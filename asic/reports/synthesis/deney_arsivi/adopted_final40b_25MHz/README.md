# BENIMSENEN KOSUM: `final40b` -- 25 MHz (40 ns), 2026-08-31

`reports/` ve `results/` bu kosumdan toplandi. Onceki referans:
`../adopted_rtl2gds_layersrc/` (20 MHz).

## Bu kosumda yeni olan

1. **SRAM cikisi kayit kademesi** (`scripts/patch_rtl.py`, kaynak RTL'ye
   dokunulmadi). SRAM Liberty'si `dout`u `falling_edge` tanimlar -> yakalama
   penceresi T/2'ydi ve icinde 8x8 carpma vardi. Carpma bir cevrim ileri alindi.
   Maliyet 112 FF, +501 cevrim (46.018 -> 46.519, %1,09). Bes ASIC regresyonu
   gecti, YZ sinif kararlari bit-exact korundu.
2. **CLOCK_PERIOD 50 -> 40 ns** (20 -> 25 MHz). Taban olculdu (bkz. README
   "Nihai periyot secimi").
3. **CTS_SINK_CLUSTERING_SIZE: 20** -- `final40`'ta kalan tek fanout ihlalini
   sifirladi ve hold'u da IYILESTIRDI (+0,1424 -> +0,1562 ns).
4. **CTS_MAX_CAP: 0.2** -- ihlali 2'den 1'e dusurdu; tek basina yetmedi.
5. **UART bolucusu frekanstan turetiliyor** (soc.h `UART_CPB_115200`), ASIC
   mask ROM'u `asic_boot.hex`'ten uretiliyor. FPGA `boot.hex` SHA'si degismedi.
6. **UART_mux**: TX her modda genel UART'tan (sartname 4.2.2 madde 5).

## Sonuc

| Metrik | onceki (20 MHz) | bu kosum (25 MHz) |
|---|---:|---:|
| **Frekans** | 20 MHz | **25 MHz** |
| Setup WS (`max_ss`) | +3,6236 ns | **+5,2707 ns** |
| Hold WS | +0,1099 ns | **+0,1562 ns** |
| DRT / Magic / KLayout DRC | 0 / 0 / 0 | **0 / 0 / 0** |
| LVS / XOR / PDN / overlap | 0 | **0** |
| **Max fanout ihlali** | 0 | **0** |
| Setup / hold TNS ve ihlalli uc | 0 | **0** |
| Anten net / pin | 1.977 / 2.388 | 1.950 / 2.399 |
| Max slew / cap | 880 / 628 | 1.100 / 615 |
| Toplam tel | 10.465.589 um | **9.984.966 um** (-%4,6) |
| Via | 894.988 | **885.343** |
| Timing-repair tampon | 50.141 | **48.869** |
| Std hucre alani | 1,51984 mm2 | **1,48603 mm2** |
| Toplam guc | 35,0 mW | 39,1 mW (frekansla orantili) |

`scripts/compare_metrics.py`: 16 zorunlu metrigin TAMAMI korundu, kapi GECTI.
`scripts/verify_deliverables.py`: PAKET KAPISI GECTI.
