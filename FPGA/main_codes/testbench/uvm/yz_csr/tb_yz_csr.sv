//=============================================================================
//  tb_yz_csr.sv  --  YZ CSR UVM testbench ust modulu
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  NOT: yz_csr_wrapper'in AXI port adlari "YZ_" onekli oldugu icin sistem
//  bind dosyasindaki (#7) esleme kullanilir; burada da ayni onek baglanir.
//=============================================================================
`timescale 1ns/1ps

`include "axi4lite_bind_yz_csr.svh"

module tb_yz_csr;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import yz_accel_pkg::*;
    import yz_uvm_pkg::*;

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
    yz_accel_if acc  (.clk(clk), .rst_n(rst_n));

    yz_csr_wrapper dut (
        .clk           (clk),
        .rst_n         (rst_n),
        .YZ_awaddr     (axil.awaddr),
        .YZ_awvalid    (axil.awvalid),
        .YZ_awready    (axil.awready),
        .YZ_wdata      (axil.wdata),
        .YZ_wvalid     (axil.wvalid),
        .YZ_wready     (axil.wready),
        .YZ_bresp      (axil.bresp),
        .YZ_bvalid     (axil.bvalid),
        .YZ_bready     (axil.bready),
        .YZ_araddr     (axil.araddr),
        .YZ_arvalid    (axil.arvalid),
        .YZ_arready    (axil.arready),
        .YZ_rdata      (axil.rdata),
        .YZ_rresp      (axil.rresp),
        .YZ_rvalid     (axil.rvalid),
        .YZ_rready     (axil.rready),
        .acc_start     (acc.acc_start),
        .acc_busy      (acc.acc_busy),
        .acc_done      (acc.acc_done),
        .acc_out_wen   (acc.acc_out_wen),
        .acc_out_wdata (acc.acc_out_wdata),
        .acc_fc_scores (acc.acc_fc_scores),
        .load_done_irq (acc.load_done_irq),
        .load_clear    (acc.load_clear),
        .infer_irq     (acc.infer_irq)
    );

    initial begin
        uvm_config_db #(virtual axil_if)    ::set(null, "*", "vif", axil);
        uvm_config_db #(virtual yz_accel_if)::set(null, "*", "vif", acc);
        run_test();
    end

    initial begin
        #20ms;
        $display("*** TB ZAMAN ASIMI (20 ms) ***");
        $finish;
    end

endmodule
