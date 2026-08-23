//=============================================================================
//  tb_i2c.sv  --  I2C Master UVM testbench ust modulu
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  SDA hatti open-drain'dir: DUT icindeki Xilinx IOBUF primitifi ile UVM
//  slave agent'i ayni tele bagli, ikisi de yalnizca LOW surer, yuksek
//  seviye arayuzun icindeki pullup'tan gelir. IOBUF'un simulasyon
//  karsiligi verilator/stubs/IOBUF.sv'dedir.
//=============================================================================
`timescale 1ns/1ps

`include "axi4lite_bind_i2c.svh"

module tb_i2c;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import i2c_slave_pkg::*;
    import i2c_uvm_pkg::*;

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
    i2c_if  i2c  (.clk(clk), .rst_n(rst_n));

    I2C_Master_AXI4_Lite dut (
        .clk_i   (clk),
        .rst_n   (rst_n),
        .I2C_SCL (i2c.scl),
        .I2C_SDA (i2c.sda),
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
        uvm_config_db #(virtual i2c_if) ::set(null, "*", "vif", i2c);
        run_test();
    end

    initial begin
        #50ms;
        $display("*** TB ZAMAN ASIMI (50 ms) ***");
        $finish;
    end

endmodule
