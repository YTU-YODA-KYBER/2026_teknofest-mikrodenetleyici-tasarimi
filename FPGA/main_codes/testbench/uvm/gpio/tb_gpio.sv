//=============================================================================
//  tb_gpio.sv  --  GPIO UVM testbench ust modulu
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  Sistem saati 50 MHz (SoC ile ayni). AXI protokol kontrolcusu 'bind' ile
//  baglanir; RTL'e tek satir dokunulmaz.
//
//  rst_n uretimi: power-on reset VE arayuzdeki rst_req kancasi. Test
//  "islem ortasinda reset" senaryosunu bu kanca uzerinden kurar.
//=============================================================================
`timescale 1ns/1ps

`include "axi4lite_bind_gpio.svh"

module tb_gpio;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import gpio_pad_pkg::*;
    import gpio_uvm_pkg::*;

    //---- Saat ve reset ---------------------------------------------------
    logic clk   = 1'b0;
    logic por_n = 1'b0;

    always #10ns clk = ~clk;          // 50 MHz

    wire rst_n = por_n & ~axil.rst_req;

    initial begin
        por_n = 1'b0;
        repeat (5) @(posedge clk);
        por_n = 1'b1;
    end

    //---- Arayuzler -------------------------------------------------------
    axil_if     axil (.clk(clk), .rst_n(rst_n));
    gpio_pad_if pad  (.clk(clk), .rst_n(rst_n));

    //---- DUT -------------------------------------------------------------
    GPIO_AXI4_Lite dut (
        .clk_i        (clk),
        .rst_n        (rst_n),
        .GPIO_IDR     (pad.idr),
        .GPIO_ODR     (pad.odr),
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
        .dma_enable_o (pad.dma_enable),
        .catode       (pad.catode),
        .anode        (pad.anode)
    );

    //---- UVM -------------------------------------------------------------
    initial begin
        uvm_config_db #(virtual axil_if)    ::set(null, "*", "vif", axil);
        uvm_config_db #(virtual gpio_pad_if)::set(null, "*", "vif", pad);
        run_test();
    end

    //---- Guvenlik agi ----------------------------------------------------
    initial begin
        #20ms;
        $display("*** TB ZAMAN ASIMI (20 ms) ***");
        $finish;
    end

endmodule
