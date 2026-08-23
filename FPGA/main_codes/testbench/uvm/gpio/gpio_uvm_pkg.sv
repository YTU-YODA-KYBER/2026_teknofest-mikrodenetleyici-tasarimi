//=============================================================================
//  gpio_uvm_pkg.sv  --  GPIO UVM ortami
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  DUT: main_codes/rtl/desgin_sources/Peripherals/GPIO/GPIO_AXI4_Lite.sv
//  Taban adres: 0x4001_0000  (AXI4_Interconnect.sv ve firmware/soc.h ile ayni)
//=============================================================================
`ifndef GPIO_UVM_PKG_SV
`define GPIO_UVM_PKG_SV
`timescale 1ns/1ps

package gpio_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import gpio_pad_pkg::*;

    // Pad monitorunun scoreboard'a giden ikinci analiz yolu
    `uvm_analysis_imp_decl(_pad)

    `include "gpio_reg_block.svh"
    `include "gpio_scoreboard.svh"
    `include "gpio_env.svh"
    `include "gpio_test_lib.svh"

endpackage : gpio_uvm_pkg

`endif
