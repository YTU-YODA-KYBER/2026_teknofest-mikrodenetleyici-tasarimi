# UVM Fonksiyonel Kapsam

Uretim tarihi: **2026-09-07**  
Kaynak: `axil_coverage` covergroup'u, butun bloklarin butun kosumlari birlestirilerek.

Toplayici, monitorun paketledigi HER AXI transaction'ini ornekler; yani surucunun ne yapmak istedigini degil, telde ne oldugunu sayar.

---

## `cg_axil`

**Toplam bin: 37  |  dolan: 35  |  erisilemez: 2  |  kapsam: %100.0**

| Coverpoint | Bin | Ornek sayisi | Durum |
|---|---|---:|---|
| `cp_kind` | `okuma` | 6257 | dolu |
| `cp_kind` | `yazma` | 3583 | dolu |
| `cp_offset` | `ofs_00` | 1620 | dolu |
| `cp_offset` | `ofs_04` | 2286 | dolu |
| `cp_offset` | `ofs_08` | 721 | dolu |
| `cp_offset` | `ofs_0C` | 1826 | dolu |
| `cp_offset` | `ofs_10` | 2644 | dolu |
| `cp_offset` | `ofs_14` | 376 | dolu |
| `cp_offset` | `ofs_18` | 159 | dolu |
| `cp_offset` | `ofs_1C` | 136 | dolu |
| `cp_offset` | `haritasiz` | 72 | dolu |
| `cp_resp` | `okay` | 9840 | dolu |
| `cp_resp` | `slverr` | 0 | **erisilemez** (gerekce asagida) |
| `cp_resp` | `decerr` | 0 | **erisilemez** (gerekce asagida) |
| `cp_gap` | `bitisik` | 126 | dolu |
| `cp_gap` | `kisa` | 5397 | dolu |
| `cp_gap` | `orta` | 1116 | dolu |
| `cp_gap` | `uzun` | 1635 | dolu |
| `cp_wdata` | `sifir` | 6512 | dolu |
| `cp_wdata` | `tumbir` | 84 | dolu |
| `cp_wdata` | `digeri` | 3244 | dolu |
| `x_kind_offset` | `okuma_x_ofs_00` | 813 | dolu |
| `x_kind_offset` | `okuma_x_ofs_04` | 1220 | dolu |
| `x_kind_offset` | `okuma_x_ofs_08` | 466 | dolu |
| `x_kind_offset` | `okuma_x_ofs_0C` | 1075 | dolu |
| `x_kind_offset` | `okuma_x_ofs_10` | 2139 | dolu |
| `x_kind_offset` | `okuma_x_ofs_14` | 246 | dolu |
| `x_kind_offset` | `okuma_x_ofs_18` | 141 | dolu |
| `x_kind_offset` | `okuma_x_ofs_1C` | 109 | dolu |
| `x_kind_offset` | `yazma_x_ofs_00` | 807 | dolu |
| `x_kind_offset` | `yazma_x_ofs_04` | 1066 | dolu |
| `x_kind_offset` | `yazma_x_ofs_08` | 255 | dolu |
| `x_kind_offset` | `yazma_x_ofs_0C` | 751 | dolu |
| `x_kind_offset` | `yazma_x_ofs_10` | 505 | dolu |
| `x_kind_offset` | `yazma_x_ofs_14` | 130 | dolu |
| `x_kind_offset` | `yazma_x_ofs_18` | 18 | dolu |
| `x_kind_offset` | `yazma_x_ofs_1C` | 27 | dolu |

---

## Erisilemez bin'ler ve gerekceleri

- **`slverr`** — Tasarimdaki hicbir AXI4-Lite slave'i hata cevabi uretmiyor; bresp/rresp sabit OKAY. Adres araligi kontrolu yalnizca interconnect seviyesindedir.
- **`decerr`** — Ayni sebep: slave'ler DECERR uretmiyor.

Bu bin'ler bilerek tanimlanmistir: kapsam raporunun tasarimin hangi davranislari **uretemedigini** de gostermesi icin. Kapsam yuzdesi hesaplanirken paydadan cikarilmislardir.

---

## Tasarim dosyasi bazinda satir kapsami

| Dosya | Satir | Kapsanan | Yuzde |
|---|---:|---:|---:|
| `GPIO_AXI4_Lite.sv` | 207 | 193 | %93.2 |
| `I2C_Master_AXI4_Lite.sv` | 249 | 243 | %97.6 |
| `QSPI_Master_AXI4_Lite.sv` | 399 | 379 | %95.0 |
| `Timer_AXI4_Lite.sv` | 105 | 102 | %97.1 |
| `UART_GU_AXI4-Lite.sv` | 164 | 161 | %98.2 |
| `UART_YZ_AXI4-Lite.sv` | 173 | 170 | %98.3 |
| `yz_csr_wrapper.sv` | 53 | 53 | %100.0 |

> Ayrintili satir satir gorunum icin [`index.html`](index.html).

