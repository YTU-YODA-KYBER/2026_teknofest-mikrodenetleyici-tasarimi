//=============================================================================
//  uart_uvm_pkg.sv  --  UART UVM ortami (UART_GU ve UART_YZ ortak)
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  Iki UART register bazinda BIREBIR AYNIDIR (RTL dosyalarinin farki yalnizca
//  modul adi ve UART_YZ'nin uc DMA portudur), bu yuzden register modeli,
//  scoreboard ve test kutuphanesi ortaktir. UART_YZ ortami bunu genisletir.
//
//  DUT'lar:
//    Peripherals/UART_GU/UART_GU_AXI4-Lite.sv   taban 0x4004_0000
//    Peripherals/UART_YZ/UART_YZ_AXI4-Lite.sv   taban 0x4005_0000
//=============================================================================
`ifndef UART_UVM_PKG_SV
`define UART_UVM_PKG_SV
`timescale 1ns/1ps

package uart_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import uart_pkg::*;

    `include "uart_reg_block.svh"
    `include "uart_scoreboard.svh"
    `include "uart_env.svh"
    `include "uart_test_lib.svh"

endpackage : uart_uvm_pkg

`endif
