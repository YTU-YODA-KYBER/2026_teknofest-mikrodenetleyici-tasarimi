//=============================================================================
//  tb_uart_yz.sv  --  UART_YZ UVM testbench ust modulu
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  UART_GU testbench'inden tek farki: DMA yan bandi (dma_enable_i,
//  dma_data_o, dma_valid_o) baglanir. Sistemde dma_enable_i ust seviyede
//  GPIO_IDR[1]'den beslenir; burada testin surdugu bir arayuz sinyalidir.
//=============================================================================
`timescale 1ns/1ps

`include "axi4lite_bind_uart_yz.svh"

module tb_uart_yz;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import uart_pkg::*;
    import uart_uvm_pkg::*;
    import uart_yz_uvm_pkg::*;

    logic clk   = 1'b0;
    logic por_n = 1'b0;

    always #10ns clk = ~clk;          // 50 MHz

    wire rst_n = por_n & ~axil.rst_req;

    initial begin
        por_n = 1'b0;
        repeat (5) @(posedge clk);
        por_n = 1'b1;
    end

    axil_if     axil (.clk(clk), .rst_n(rst_n));
    uart_if     ser  (.clk(clk), .rst_n(rst_n));
    uart_dma_if dma  (.clk(clk), .rst_n(rst_n));

    initial dma.enable = 1'b0;

    UART_YZ_AXI4_Lite dut (
        .clk          (clk),
        .rst_n        (rst_n),
        .awaddr       (axil.awaddr),
        .awvalid      (axil.awvalid),
        .awready      (axil.awready),
        .wdata        (axil.wdata),
        .wvalid       (axil.wvalid),
        .wready       (axil.wready),
        .bresp        (axil.bresp),
        .bvalid       (axil.bvalid),
        .bready       (axil.bready),
        .araddr       (axil.araddr),
        .arvalid      (axil.arvalid),
        .arready      (axil.arready),
        .rready       (axil.rready),
        .rdata        (axil.rdata),
        .rresp        (axil.rresp),
        .rvalid       (axil.rvalid),
        .rx           (ser.rx),
        .tx           (ser.tx),
        .dma_enable_i (dma.enable),
        .dma_data_o   (dma.data),
        .dma_valid_o  (dma.valid)
    );

    initial begin
        uvm_config_db #(virtual axil_if)    ::set(null, "*", "vif", axil);
        uvm_config_db #(virtual uart_if)    ::set(null, "*", "vif", ser);
        uvm_config_db #(virtual uart_dma_if)::set(null, "*", "vif", dma);
        run_test();
    end

    initial begin
        #50ms;
        $display("*** TB ZAMAN ASIMI (50 ms) ***");
        $finish;
    end

endmodule
