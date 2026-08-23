//=============================================================================
//  qspi_uvm_pkg.sv  --  QSPI Master UVM ortami
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  DUT: main_codes/rtl/desgin_sources/Peripherals/QSPI/QSPI_Master_AXI4_Lite.sv
//  Taban adres: 0x4003_0000
//=============================================================================
`ifndef QSPI_UVM_PKG_SV
`define QSPI_UVM_PKG_SV
`timescale 1ns/1ps

package qspi_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import qspi_flash_pkg::*;

    `include "qspi_reg_block.svh"
    `include "qspi_scoreboard.svh"
    `include "qspi_env.svh"
    `include "qspi_test_lib.svh"

endpackage : qspi_uvm_pkg

`endif
