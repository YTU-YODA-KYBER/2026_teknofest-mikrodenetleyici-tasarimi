//=============================================================================
//  uart_yz_uvm_pkg.sv  --  UART_YZ UVM ortami
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  Ortak UART ortami (register modeli, scoreboard, seri agent, test
//  kutuphanesi) uart_uvm_pkg'dedir. Burada iki sey eklenir:
//    1) uart_yz_env  -- ortak ortam + DMA yan bandi agent'i
//    2) uart_yz_*    -- ortak testlerin UART_YZ taban adresli turevleri
//                       ve UART_YZ'ye ozgu DMA testi
//
//  DUT: Peripherals/UART_YZ/UART_YZ_AXI4-Lite.sv   taban 0x4005_0000
//=============================================================================
`ifndef UART_YZ_UVM_PKG_SV
`define UART_YZ_UVM_PKG_SV
`timescale 1ns/1ps

package uart_yz_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import uart_pkg::*;
    import uart_uvm_pkg::*;

    `include "uart_yz_env.svh"

    // Ortak testin UART_YZ turevi: taban adres + blok adi + ortam override'i.
    // Fabrika zinciri: axil_base_env -> uart_env -> uart_yz_env
    `define UART_YZ_TEST(AD) \
        class uart_yz_``AD extends uart_``AD; \
            `uvm_component_utils(uart_yz_``AD) \
            function new(string name, uvm_component parent); \
                super.new(name, parent); \
            endfunction \
            virtual function void yapilandir(); \
                base_addr = 32'h4005_0000; \
                blok      = "UART_YZ"; \
            endfunction \
            function void build_phase(uvm_phase phase); \
                uart_env::type_id::set_type_override(uart_yz_env::get_type()); \
                super.build_phase(phase); \
            endfunction \
        endclass

    `UART_YZ_TEST(reset_test)
    `UART_YZ_TEST(bitwalk_test)
    `UART_YZ_TEST(ro_test)
    `UART_YZ_TEST(unmapped_test)
    `UART_YZ_TEST(random_test)
    `UART_YZ_TEST(reset_mid_test)
    `UART_YZ_TEST(stress_test)
    `UART_YZ_TEST(tx_test)
    `UART_YZ_TEST(rx_test)
    `UART_YZ_TEST(baud_test)
    `UART_YZ_TEST(duplex_test)
    `UART_YZ_TEST(cpb_zero_test)

    `include "uart_yz_test_lib.svh"

endpackage : uart_yz_uvm_pkg

`endif
