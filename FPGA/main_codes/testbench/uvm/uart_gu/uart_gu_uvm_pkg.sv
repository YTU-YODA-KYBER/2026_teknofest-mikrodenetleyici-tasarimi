//=============================================================================
//  uart_gu_uvm_pkg.sv  --  UART_GU'ya ozel test tabani
//
//  Ortak UART ortami uart_uvm_pkg'dedir; burada yalnizca taban adres ve
//  blok adi verilir.
//=============================================================================
`ifndef UART_GU_UVM_PKG_SV
`define UART_GU_UVM_PKG_SV
`timescale 1ns/1ps

package uart_gu_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import uart_pkg::*;
    import uart_uvm_pkg::*;

    // UART_GU icin tek yapmamiz gereken taban adresi ve blok adini vermek.
    // Test isimleri "uart_gu_*" olsun diye her testin ince bir turevi var.
    `define UART_GU_TEST(AD, TABAN) \
        class uart_gu_``AD extends uart_``AD; \
            `uvm_component_utils(uart_gu_``AD) \
            function new(string name, uvm_component parent); \
                super.new(name, parent); \
            endfunction \
            virtual function void yapilandir(); \
                base_addr = TABAN; \
                blok      = "UART_GU"; \
            endfunction \
        endclass

    `UART_GU_TEST(reset_test,      32'h4004_0000)
    `UART_GU_TEST(bitwalk_test,    32'h4004_0000)
    `UART_GU_TEST(ro_test,         32'h4004_0000)
    `UART_GU_TEST(unmapped_test,   32'h4004_0000)
    `UART_GU_TEST(random_test,     32'h4004_0000)
    `UART_GU_TEST(reset_mid_test,  32'h4004_0000)
    `UART_GU_TEST(stress_test,     32'h4004_0000)
    `UART_GU_TEST(tx_test,         32'h4004_0000)
    `UART_GU_TEST(rx_test,         32'h4004_0000)
    `UART_GU_TEST(baud_test,       32'h4004_0000)
    `UART_GU_TEST(duplex_test,     32'h4004_0000)
    `UART_GU_TEST(cpb_zero_test,   32'h4004_0000)

endpackage : uart_gu_uvm_pkg

`endif
