# Baseline: `run/rtl2gds`, 50 ns, 4200 x 3600 um

**Kosum tarihi:** 2026-08-29 17:50 -> 20:31 (160 dk, 80 adimin tamami)
**Arsivlenme tarihi:** 2026-08-30
**Neden burada:** `asic/run/` teslim sirasinda BOSALTILACAK (Final Istenen
Ciktilar Bolum 4). Optimizasyon fazinda bu kosumun ustune yazilacagi icin,
karsilastirma referansinin kalici tek kopyasi burasidir.

## Bu dizin ne icin var

Optimizasyon fazindaki her deney, calisan bir teslim paketini riske atar.
`gate_metrics.json` bu paketin **kabul kapisidir**:

```bash
python3 scripts/compare_metrics.py \
    reports/synthesis/deney_arsivi/baseline_rtl2gds_50ns/gate_metrics.json \
    run/<yeni_etiket>/final/metrics.json
```

Betik ZORUNLU listedeki metriklerden biri kotulesirse **RED** dondurur
(cikis kodu 1). Bu metrikler zaten sifirdir ve sifir kalmalidir.

## Referans degerler

### Zorunlu -- hepsi sifir, sifir kalmali

| Metrik | Deger |
|---|---:|
| OpenROAD detailed-route DRC | 0 |
| Magic DRC / KLayout DRC | 0 / 0 |
| Magic-KLayout XOR farki | 0 |
| Magic illegal overlap | 0 |
| Netgen LVS hata / device / net farki | 0 / 0 / 0 |
| PDN ihlali | 0 |
| Kritik baglantisiz pin | 0 |
| Setup / hold ihlalli uc | 0 / 0 |
| Max fanout ihlali | 0 |
| Lint error / inferred latch / timing construct | 0 / 0 / 0 |
| Unmapped cell | 0 |

### Dusurulmesi hedeflenen

| Metrik | Deger |
|---|---:|
| Anten ihlalli net / pin | 2.904 / 4.341 |
| Max slew ihlali (`max_ss_100C_1v60`) | 32.763 |
| Max cap ihlali (`max_ss_100C_1v60`) | 2.858 |
| Lint uyarisi | 891 |
| Die alani | 15.120.000 um2 = 15,12 mm2 |
| Toplam instance | 1.336.189 |
| Filler instance | 1.088.528 |
| Timing-repair tamponu | 31.350 |
| Toplam yollanmis tel | 10.715.050 um = 10,7 m |
| En uzun tek net | 6.346,48 um |
| Toplam guc | 34,13 mW |

### Yukseltilmesi hedeflenen

| Metrik | Deger |
|---|---:|
| En kotu setup slack (`max_ss_100C_1v60`) | +2,1001477 ns |
| En kotu hold slack (`max_ff_n40C_1v95`) | +0,1924372 ns |
| Std-hucre doluluk | %11,914 |

### Beklenen, kritik olmayan

| Metrik | Deger | Aciklama |
|---|---:|---|
| Toplam baglantisiz pin | 480 | 15 SRAM x 32 bit kullanilmayan `dout0[31:0]`; okuma `dout1` uzerinden. Kritik baglantisiz pin 0. |

## Dizin icerigi

| Dosya | Icerik |
|---|---|
| `gate_metrics.json` | `compare_metrics.py` icin kabul kapisi ozeti |
| `final_metrics.json` | `run/rtl2gds/final/metrics.json` tam kopyasi (322 metrik) |
| `resolved.json` | Akista fiilen kullanilan cozumlenmis yapilandirma |
| `config.yaml` | Bu kosumu ureten `asic/config.yaml` |
| `macro_placement.cfg` | Bu kosumun makro yerlesimi (4200 x 3600 ring) |
| `timing_summary.rpt` | 9 kose STAPostPNR ozeti |
| `timing/<corner>/` | Kose basina ws/wns/tns raporlari |
| `grt_congestion.txt` | GRT son congestion tablosu (met1 %33,3 ... taşma 0) |
| `drt_convergence.txt` | DRT iterasyon yakinsamasi |
| `antenna_summary.rpt.gz` | 4.626 satirlik anten ihlal tablosu |
| `manufacturability.rpt`, `xor.xml`, `full_disconnected_pins_table.txt` | Signoff ozetleri |
| `<adim>.metrics.json` | Adim basina OpenROAD metrikleri |
| `flow.tail.log`, `warning.log`, `error.log` | Kosum gunlukleri |
