//=============================================================================
//  tb_timer.sv  --  Timer UVM testbench ust modulu
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//=============================================================================
`timescale 1ns/1ps

`include "axi4lite_bind_timer.svh"

module tb_timer;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import timer_uvm_pkg::*;

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

    Timer_AXI4_Lite dut (
        .clk_i   (clk),
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
        .rvalid  (axil.rvalid)
    );

    initial begin
        uvm_config_db #(virtual axil_if)::set(null, "*", "vif", axil);
        run_test();
    end

    initial begin
        #20ms;
        $display("*** TB ZAMAN ASIMI (20 ms) ***");
        $finish;
    end

endmodule
