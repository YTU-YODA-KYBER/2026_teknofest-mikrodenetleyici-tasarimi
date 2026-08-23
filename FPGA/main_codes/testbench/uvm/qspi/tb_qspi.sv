//=============================================================================
//  tb_qspi.sv  --  QSPI Master UVM testbench ust modulu
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  IO0..IO3 cift yonludur: DUT icindeki dort Xilinx IOBUF ile UVM flash
//  agent'i ayni tellere baglidir. IOBUF'un simulasyon karsiligi
//  stubs/IOBUF.sv icindedir; RTL'e dokunulmaz.
//=============================================================================
`timescale 1ns/1ps

`include "axi4lite_bind_qspi.svh"

module tb_qspi;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import qspi_flash_pkg::*;
    import qspi_uvm_pkg::*;

    logic clk   = 1'b0;
    logic por_n = 1'b0;

    always #10ns clk = ~clk;          // 50 MHz

    wire rst_n = por_n & ~axil.rst_req;

    initial begin
        por_n = 1'b0;
        repeat (5) @(posedge clk);
        por_n = 1'b1;
    end

    axil_if axil (.clk(clk), .rst_n(rst_n));
    qspi_if qspi (.clk(clk), .rst_n(rst_n));

    QSPI_Master_AXI4_Lite dut (
        .clk_i     (clk),
        .rst_n     (rst_n),
        .awaddr    (axil.awaddr),
        .awvalid   (axil.awvalid),
        .awready   (axil.awready),
        .wdata     (axil.wdata),
        .wvalid    (axil.wvalid),
        .wready    (axil.wready),
        .bresp     (axil.bresp),
        .bvalid    (axil.bvalid),
        .bready    (axil.bready),
        .araddr    (axil.araddr),
        .arvalid   (axil.arvalid),
        .arready   (axil.arready),
        .rready    (axil.rready),
        .rdata     (axil.rdata),
        .rresp     (axil.rresp),
        .rvalid    (axil.rvalid),
        .QSPI_SCLK (qspi.sclk),
        .QSPI_CS   (qspi.cs),
        .QSPI_IO0  (qspi.io0),
        .QSPI_IO1  (qspi.io1),
        .QSPI_IO2  (qspi.io2),
        .QSPI_IO3  (qspi.io3),
        .dma_data  (qspi.dma_data),
        .dma_valid (qspi.dma_valid)
    );

    initial begin
        uvm_config_db #(virtual axil_if)::set(null, "*", "vif", axil);
        uvm_config_db #(virtual qspi_if)::set(null, "*", "vif", qspi);
        run_test();
    end

    initial begin
        #50ms;
        $display("*** TB ZAMAN ASIMI (50 ms) ***");
        $finish;
    end

endmodule
