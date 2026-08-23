# UVM Fonksiyonel Kapsam

Uretim tarihi: **2026-08-21**  
Kaynak: `axil_coverage` covergroup'u, butun bloklarin butun kosumlari birlestirilerek.

Toplayici, monitorun paketledigi HER AXI transaction'ini ornekler; yani surucunun ne yapmak istedigini degil, telde ne oldugunu sayar.

---

## `cg_axil`

**Toplam bin: 37  |  dolan: 35  |  erisilemez: 2  |  kapsam: %100.0**

| Coverpoint | Bin | Ornek sayisi | Durum |
|---|---|---:|---|
| `cp_kind` | `okuma` | 6124 | dolu |
| `cp_kind` | `yazma` | 3395 | dolu |
| `cp_offset` | `ofs_00` | 1558 | dolu |
| `cp_offset` | `ofs_04` | 2215 | dolu |
| `cp_offset` | `ofs_08` | 743 | dolu |
| `cp_offset` | `ofs_0C` | 1755 | dolu |
| `cp_offset` | `ofs_10` | 2739 | dolu |
| `cp_offset` | `ofs_14` | 293 | dolu |
| `cp_offset` | `ofs_18` | 85 | dolu |
| `cp_offset` | `ofs_1C` | 68 | dolu |
| `cp_offset` | `haritasiz` | 63 | dolu |
| `cp_resp` | `okay` | 9519 | dolu |
| `cp_resp` | `slverr` | 0 | **erisilemez** (gerekce asagida) |
| `cp_resp` | `decerr` | 0 | **erisilemez** (gerekce asagida) |
| `cp_gap` | `bitisik` | 114 | dolu |
| `cp_gap` | `kisa` | 5155 | dolu |
| `cp_gap` | `orta` | 978 | dolu |
| `cp_gap` | `uzun` | 1772 | dolu |
| `cp_wdata` | `sifir` | 6373 | dolu |
| `cp_wdata` | `tumbir` | 72 | dolu |
| `cp_wdata` | `digeri` | 3074 | dolu |
| `x_kind_offset` | `okuma_x_ofs_00` | 813 | dolu |
| `x_kind_offset` | `okuma_x_ofs_04` | 1180 | dolu |
| `x_kind_offset` | `okuma_x_ofs_08` | 488 | dolu |
| `x_kind_offset` | `okuma_x_ofs_0C` | 1043 | dolu |
| `x_kind_offset` | `okuma_x_ofs_10` | 2263 | dolu |
| `x_kind_offset` | `okuma_x_ofs_14` | 175 | dolu |
| `x_kind_offset` | `okuma_x_ofs_18` | 73 | dolu |
| `x_kind_offset` | `okuma_x_ofs_1C` | 47 | dolu |
| `x_kind_offset` | `yazma_x_ofs_00` | 745 | dolu |
| `x_kind_offset` | `yazma_x_ofs_04` | 1035 | dolu |
| `x_kind_offset` | `yazma_x_ofs_08` | 255 | dolu |
| `x_kind_offset` | `yazma_x_ofs_0C` | 712 | dolu |
| `x_kind_offset` | `yazma_x_ofs_10` | 476 | dolu |
| `x_kind_offset` | `yazma_x_ofs_14` | 118 | dolu |
| `x_kind_offset` | `yazma_x_ofs_18` | 12 | dolu |
| `x_kind_offset` | `yazma_x_ofs_1C` | 21 | dolu |

---

## Erisilemez bin'ler ve gerekceleri

- **`slverr`** — Tasarimdaki hicbir AXI4-Lite slave'i hata cevabi uretmiyor; bresp/rresp sabit OKAY. Adres araligi kontrolu yalnizca interconnect seviyesindedir.
- **`decerr`** — Ayni sebep: slave'ler DECERR uretmiyor.

Bu bin'ler bilerek tanimlanmistir: kapsam raporunun tasarimin hangi davranislari **uretemedigini** de gostermesi icin. Kapsam yuzdesi hesaplanirken paydadan cikarilmislardir.

---

## Tasarim dosyasi bazinda satir kapsami

| Dosya | Satir | Kapsanan | Yuzde |
|---|---:|---:|---:|
| `GPIO_AXI4_Lite.sv` | 212 | 198 | %93.4 |
| `I2C_Master_AXI4_Lite.sv` | 237 | 231 | %97.5 |
| `QSPI_Master_AXI4_Lite.sv` | 399 | 379 | %95.0 |
| `Timer_AXI4_Lite.sv` | 105 | 102 | %97.1 |
| `UART_GU_AXI4-Lite.sv` | 167 | 164 | %98.2 |
| `UART_YZ_AXI4-Lite.sv` | 176 | 173 | %98.3 |
| `yz_csr_wrapper.sv` | 45 | 45 | %100.0 |

> Ayrintili satir satir gorunum icin [`index.html`](index.html).

