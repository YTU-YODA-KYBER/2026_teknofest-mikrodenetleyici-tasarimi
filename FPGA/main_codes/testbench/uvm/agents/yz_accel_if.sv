//=============================================================================
//  yz_accel_if.sv  --  YZ CSR sarmalayicisinin hizlandirici tarafi
//
//  yz_csr_wrapper.sv'nin AXI disi portlari. Sistemde bu portlarin karsiligi
//  conv_accelerator ve YZ bellek kontrolcusudur; blok seviyesinde onlarin
//  yerine bu arayuz uzerinden UVM agent'i gecer.
//
//  DUT -> TB : acc_start, load_clear, infer_irq
//  TB -> DUT : acc_busy, acc_done, acc_out_wen, acc_out_wdata, acc_fc_scores,
//              load_done_irq
//=============================================================================
`ifndef YZ_ACCEL_IF_SV
`define YZ_ACCEL_IF_SV
`timescale 1ns/1ps

interface yz_accel_if (input logic clk, input logic rst_n);
    logic       acc_start;       // DUT -> TB  (1 cevrimlik darbe)
    logic       acc_busy;        // TB -> DUT
    logic       acc_done;        // TB -> DUT  (1 cevrimlik darbe)
    logic       acc_out_wen;     // TB -> DUT  (1 cevrimlik darbe)
    logic [7:0] acc_out_wdata;   // TB -> DUT
    //  FC katmaninin dort ham int32 akumulatoru, sinif ile AYNI cevrimde
    //  (acc_out_wen) yakalanir -> {S3, S2, S1, S0}
    logic [127:0] acc_fc_scores; // TB -> DUT
    logic       load_done_irq;   // TB -> DUT  (seviye)
    logic       load_clear;      // DUT -> TB  (1 cevrimlik darbe)
    logic       infer_irq;       // DUT -> TB  (seviye)
endinterface

`endif
