## ============================================================
## TEKNOFEST SoC - Nexys A7-100T (XC7A100T-1CSG324C)
## NOT: Proje part'ını da xc7a100t-csg324-1 yap (board: nexys-a7-100t)
## ============================================================

## ---- Clock: 100 MHz ----
set_property PACKAGE_PIN E3 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]
create_clock -period 10.000 -name sys_clk [get_ports sys_clk]

## ---- Reset: BTNC (C12, active LOW) ----
set_property PACKAGE_PIN C12 [get_ports sys_rst_btn]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_btn]

## ---- USB-UART (FT2232) ----
## UART_TXD_IN(C4) = köprü TX = FPGA RX | UART_RXD_OUT(D4) = köprü RX = FPGA TX
set_property PACKAGE_PIN C4 [get_ports UART_GU_rx]
set_property PACKAGE_PIN D4 [get_ports UART_GU_tx]
set_property IOSTANDARD LVCMOS33 [get_ports UART_GU_rx]
set_property IOSTANDARD LVCMOS33 [get_ports UART_GU_tx]

## 7 Segment Katotları (CA - CG ve DP)
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { catode[0] }]; # CA
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { catode[1] }]; # CB
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { catode[2] }]; # CC
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { catode[3] }]; # CD
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { catode[4] }]; # CE
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { catode[5] }]; # CF
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { catode[6] }]; # CG
set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { catode[7] }]; # DP

## 7 Segment Anotları (AN0 - AN7)
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { anode[0] }];
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { anode[1] }];
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { anode[2] }];
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { anode[3] }];
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { anode[4] }];
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { anode[5] }];
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { anode[6] }];
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { anode[7] }];

## UART Portları
set_property -dict { PACKAGE_PIN C4  IOSTANDARD LVCMOS33 } [get_ports { UART_TX  }]; # FPGA RX
set_property -dict { PACKAGE_PIN D4  IOSTANDARD LVCMOS33 } [get_ports { UART_RX  }]; # FPGA TX

## ---- Switches → GPIO_IDR[15:0] ----
set_property PACKAGE_PIN J15 [get_ports {GPIO_IDR_pins[0]}]
set_property PACKAGE_PIN L16 [get_ports {GPIO_IDR_pins[1]}]
set_property PACKAGE_PIN M13 [get_ports {GPIO_IDR_pins[2]}]
set_property PACKAGE_PIN R15 [get_ports {GPIO_IDR_pins[3]}]
set_property PACKAGE_PIN R17 [get_ports {GPIO_IDR_pins[4]}]
set_property PACKAGE_PIN T18 [get_ports {GPIO_IDR_pins[5]}]
set_property PACKAGE_PIN U18 [get_ports {GPIO_IDR_pins[6]}]
set_property PACKAGE_PIN R13 [get_ports {GPIO_IDR_pins[7]}]
set_property PACKAGE_PIN T8  [get_ports {GPIO_IDR_pins[8]}]
set_property PACKAGE_PIN U8  [get_ports {GPIO_IDR_pins[9]}]
set_property PACKAGE_PIN R16 [get_ports {GPIO_IDR_pins[10]}]
set_property PACKAGE_PIN T13 [get_ports {GPIO_IDR_pins[11]}]
set_property PACKAGE_PIN H6  [get_ports {GPIO_IDR_pins[12]}]
set_property PACKAGE_PIN U12 [get_ports {GPIO_IDR_pins[13]}]
set_property PACKAGE_PIN U11 [get_ports {GPIO_IDR_pins[14]}]
set_property PACKAGE_PIN V10 [get_ports {GPIO_IDR_pins[15]}]
## Önce hepsi
set_property IOSTANDARD LVCMOS33 [get_ports {GPIO_IDR_pins[*]}]
## Sonra 1.8V olanlar
set_property IOSTANDARD LVCMOS18 [get_ports {GPIO_IDR_pins[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {GPIO_IDR_pins[9]}]

## ---- LEDs → GPIO_ODR[15:0] ----
set_property PACKAGE_PIN H17 [get_ports {GPIO_ODR_pins[0]}]
set_property PACKAGE_PIN K15 [get_ports {GPIO_ODR_pins[1]}]
set_property PACKAGE_PIN J13 [get_ports {GPIO_ODR_pins[2]}]
set_property PACKAGE_PIN N14 [get_ports {GPIO_ODR_pins[3]}]
set_property PACKAGE_PIN R18 [get_ports {GPIO_ODR_pins[4]}]
set_property PACKAGE_PIN V17 [get_ports {GPIO_ODR_pins[5]}]
set_property PACKAGE_PIN U17 [get_ports {GPIO_ODR_pins[6]}]
set_property PACKAGE_PIN U16 [get_ports {GPIO_ODR_pins[7]}]
set_property PACKAGE_PIN V16 [get_ports {GPIO_ODR_pins[8]}]
set_property PACKAGE_PIN T15 [get_ports {GPIO_ODR_pins[9]}]
set_property PACKAGE_PIN U14 [get_ports {GPIO_ODR_pins[10]}]
set_property PACKAGE_PIN T16 [get_ports {GPIO_ODR_pins[11]}]
set_property PACKAGE_PIN V15 [get_ports {GPIO_ODR_pins[12]}]
set_property PACKAGE_PIN V14 [get_ports {GPIO_ODR_pins[13]}]
set_property PACKAGE_PIN V12 [get_ports {GPIO_ODR_pins[14]}]
set_property PACKAGE_PIN V11 [get_ports {GPIO_ODR_pins[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {GPIO_ODR_pins[*]}]

## ---- I2C → PMOD JA (JA1=C17 SCL, JA2=D18 SDA) ----
## Harici pull-up (2.2k-4.7k) tavsiye edilir
set_property PACKAGE_PIN C17 [get_ports I2C_SCL]
set_property PACKAGE_PIN D18 [get_ports I2C_SDA]
set_property IOSTANDARD LVCMOS33 [get_ports I2C_SCL]
set_property IOSTANDARD LVCMOS33 [get_ports I2C_SDA]

## ---- QSPI → PMOD JB ----
set_property PACKAGE_PIN D14 [get_ports QSPI_SCLK]
set_property PACKAGE_PIN F16 [get_ports QSPI_CS]
set_property PACKAGE_PIN G16 [get_ports QSPI_IO0]
set_property PACKAGE_PIN H14 [get_ports QSPI_IO1]
set_property PACKAGE_PIN E16 [get_ports QSPI_IO2]
set_property PACKAGE_PIN F13 [get_ports QSPI_IO3]
set_property IOSTANDARD LVCMOS33 [get_ports QSPI_*]

## ---- (Opsiyonel) Asenkron girişleri timing'den çıkar ----
# set_false_path -from [get_ports {sys_rst_btn GPIO_IDR_pins[*]}]

## ---- Configuration (7-series, 3.3V config bank) ----
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
