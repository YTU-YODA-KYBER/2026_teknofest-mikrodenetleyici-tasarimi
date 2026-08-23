//=============================================================================
//  timer_uvm_pkg.sv  --  Timer UVM ortami
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  DUT: main_codes/rtl/desgin_sources/Peripherals/Timer/Timer_AXI4_Lite.sv
//  Taban adres: 0x4000_0000
//=============================================================================
`ifndef TIMER_UVM_PKG_SV
`define TIMER_UVM_PKG_SV
`timescale 1ns/1ps

package timer_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;

    `include "timer_reg_block.svh"
    `include "timer_scoreboard.svh"
    `include "timer_env.svh"
    `include "timer_test_lib.svh"

endpackage : timer_uvm_pkg

`endif
