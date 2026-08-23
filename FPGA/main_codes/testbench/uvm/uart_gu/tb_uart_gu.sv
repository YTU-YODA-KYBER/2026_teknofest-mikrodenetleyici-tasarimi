//=============================================================================
//  tb_uart_gu.sv  --  UART_GU UVM testbench ust modulu
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//=============================================================================
`timescale 1ns/1ps

`include "axi4lite_bind_uart_gu.svh"

module tb_uart_gu;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import uart_pkg::*;
    import uart_uvm_pkg::*;
    import uart_gu_uvm_pkg::*;

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
    uart_if ser  (.clk(clk), .rst_n(rst_n));

    UART_GU_AXI4_Lite dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .awaddr  (axil.awaddr),
        .awvalid (axil.awvalid),
        .awready (axil.awready),
        .wdata   (axil.wdata),
        .wvalid  (axil.wvalid),
        .wready  (axil.wready),
        .bresp   (axil.bresp),
        .bvalid  (axil.bvalid),
        .bready  (axil.bready),
        .araddr  (axil.araddr),
        .arvalid (axil.arvalid),
        .arready (axil.arready),
        .rready  (axil.rready),
        .rdata   (axil.rdata),
        .rresp   (axil.rresp),
        .rvalid  (axil.rvalid),
        .rx      (ser.rx),
        .tx      (ser.tx)
    );

    initial begin
        uvm_config_db #(virtual axil_if)::set(null, "*", "vif", axil);
        uvm_config_db #(virtual uart_if)::set(null, "*", "vif", ser);
        run_test();
    end

    initial begin
        #50ms;
        $display("*** TB ZAMAN ASIMI (50 ms) ***");
        $finish;
    end

endmodule
