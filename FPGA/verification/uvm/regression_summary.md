# UVM Regresyon Sonuclari

Kosum tarihi: **2026-09-05**  
Simulator: **Verilator 5.050**  |  UVM: **2020.3.1 (no-DPI)**  
Blok basina tohum sayisi: **3**  |  Toplam sure: **0.5 dakika**

---

## Blok ozeti

| Blok | Test | Kosum | Gecti | Kaldi | AXI ihlali | Uyari |
|---|---:|---:|---:|---:|---:|---:|
| gpio | 9 | 27 | 27 | 0 | 0 | 0 |
| timer | 9 | 27 | 27 | 0 | 0 | 0 |
| uart_gu | 12 | 36 | 36 | 0 | 0 | 0 |
| uart_yz | 13 | 39 | 39 | 0 | 0 | 0 |
| i2c | 12 | 36 | 36 | 0 | 0 | 0 |
| qspi | 11 | 33 | 33 | 0 | 0 | 0 |
| yz_csr | 7 | 21 | 21 | 0 | 0 | 0 |
| **TOPLAM** | **73** | **219** | **219** | **0** | **0** | **0** |

---

## Test x tohum matrisi

### gpio

| Test | tohum 1 | tohum 2 | tohum 3 | AXI ihlali | Sure (s) |
|---|---|---|---|---:|---:|
| `gpio_reset_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `gpio_bitwalk_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `gpio_ro_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `gpio_unmapped_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `gpio_random_test` | GECTI | GECTI | GECTI | 0 | 3.4 |
| `gpio_reset_mid_test` | GECTI | GECTI | GECTI | 0 | 1.2 |
| `gpio_pad_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `gpio_display_test` | GECTI | GECTI | GECTI | 0 | 3.8 |
| `gpio_stress_test` | GECTI | GECTI | GECTI | 0 | 0.7 |

### timer

| Test | tohum 1 | tohum 2 | tohum 3 | AXI ihlali | Sure (s) |
|---|---|---|---|---:|---:|
| `timer_reset_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `timer_bitwalk_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `timer_ro_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `timer_unmapped_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `timer_random_test` | GECTI | GECTI | GECTI | 0 | 2.6 |
| `timer_reset_mid_test` | GECTI | GECTI | GECTI | 0 | 1.3 |
| `timer_count_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `timer_event_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `timer_stress_test` | GECTI | GECTI | GECTI | 0 | 0.8 |

### uart_gu

| Test | tohum 1 | tohum 2 | tohum 3 | AXI ihlali | Sure (s) |
|---|---|---|---|---:|---:|
| `uart_gu_reset_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_gu_bitwalk_test` | GECTI | GECTI | GECTI | 0 | 0.9 |
| `uart_gu_ro_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_gu_unmapped_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_gu_random_test` | GECTI | GECTI | GECTI | 0 | 3.2 |
| `uart_gu_reset_mid_test` | GECTI | GECTI | GECTI | 0 | 1.3 |
| `uart_gu_tx_test` | GECTI | GECTI | GECTI | 0 | 1.0 |
| `uart_gu_rx_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_gu_baud_test` | GECTI | GECTI | GECTI | 0 | 0.9 |
| `uart_gu_duplex_test` | GECTI | GECTI | GECTI | 0 | 0.9 |
| `uart_gu_cpb_zero_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_gu_stress_test` | GECTI | GECTI | GECTI | 0 | 0.8 |

### uart_yz

| Test | tohum 1 | tohum 2 | tohum 3 | AXI ihlali | Sure (s) |
|---|---|---|---|---:|---:|
| `uart_yz_reset_test` | GECTI | GECTI | GECTI | 0 | 1.0 |
| `uart_yz_bitwalk_test` | GECTI | GECTI | GECTI | 0 | 1.2 |
| `uart_yz_ro_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_yz_unmapped_test` | GECTI | GECTI | GECTI | 0 | 1.2 |
| `uart_yz_random_test` | GECTI | GECTI | GECTI | 0 | 3.4 |
| `uart_yz_reset_mid_test` | GECTI | GECTI | GECTI | 0 | 1.3 |
| `uart_yz_tx_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_yz_rx_test` | GECTI | GECTI | GECTI | 0 | 1.1 |
| `uart_yz_baud_test` | GECTI | GECTI | GECTI | 0 | 1.0 |
| `uart_yz_duplex_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_yz_cpb_zero_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_yz_dma_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `uart_yz_stress_test` | GECTI | GECTI | GECTI | 0 | 1.0 |

### i2c

| Test | tohum 1 | tohum 2 | tohum 3 | AXI ihlali | Sure (s) |
|---|---|---|---|---:|---:|
| `i2c_reset_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `i2c_bitwalk_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `i2c_ro_test` | GECTI | GECTI | GECTI | 0 | 0.9 |
| `i2c_unmapped_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `i2c_random_test` | GECTI | GECTI | GECTI | 0 | 3.3 |
| `i2c_reset_mid_test` | GECTI | GECTI | GECTI | 0 | 1.3 |
| `i2c_nby_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `i2c_write_test` | GECTI | GECTI | GECTI | 0 | 1.0 |
| `i2c_read_test` | GECTI | GECTI | GECTI | 0 | 1.1 |
| `i2c_nack_test` | GECTI | GECTI | GECTI | 0 | 0.9 |
| `i2c_flags_test` | GECTI | GECTI | GECTI | 0 | 1.2 |
| `i2c_stress_test` | GECTI | GECTI | GECTI | 0 | 1.0 |

### qspi

| Test | tohum 1 | tohum 2 | tohum 3 | AXI ihlali | Sure (s) |
|---|---|---|---|---:|---:|
| `qspi_reset_test` | GECTI | GECTI | GECTI | 0 | 2.0 |
| `qspi_bitwalk_test` | GECTI | GECTI | GECTI | 0 | 1.6 |
| `qspi_ro_test` | GECTI | GECTI | GECTI | 0 | 1.1 |
| `qspi_unmapped_test` | GECTI | GECTI | GECTI | 0 | 0.7 |
| `qspi_random_test` | GECTI | GECTI | GECTI | 0 | 3.4 |
| `qspi_reset_mid_test` | GECTI | GECTI | GECTI | 0 | 1.4 |
| `qspi_fifo_test` | GECTI | GECTI | GECTI | 0 | 0.9 |
| `qspi_dma_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `qspi_flash_test` | GECTI | GECTI | GECTI | 0 | 0.9 |
| `qspi_modes_test` | GECTI | GECTI | GECTI | 0 | 0.9 |
| `qspi_stress_test` | GECTI | GECTI | GECTI | 0 | 0.8 |

### yz_csr

| Test | tohum 1 | tohum 2 | tohum 3 | AXI ihlali | Sure (s) |
|---|---|---|---|---:|---:|
| `yz_reset_test` | GECTI | GECTI | GECTI | 0 | 1.6 |
| `yz_ro_test` | GECTI | GECTI | GECTI | 0 | 1.1 |
| `yz_unmapped_test` | GECTI | GECTI | GECTI | 0 | 1.0 |
| `yz_random_test` | GECTI | GECTI | GECTI | 0 | 2.8 |
| `yz_reset_mid_test` | GECTI | GECTI | GECTI | 0 | 1.3 |
| `yz_csr_test` | GECTI | GECTI | GECTI | 0 | 0.8 |
| `yz_stress_test` | GECTI | GECTI | GECTI | 0 | 0.7 |

