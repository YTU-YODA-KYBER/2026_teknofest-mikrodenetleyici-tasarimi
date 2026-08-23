//=============================================================================
//  qspi_if.sv  --  QSPI hatti
//
//  sclk / cs : DUT surer
//  io0..io3  : cift yonlu; DUT tarafinda Xilinx IOBUF, TB tarafinda asagidaki
//              drv_val/drv_oe ciftinden surulur. Ikisi de birakirsa pullup
//              hatti yuksege ceker (gercek kartta da boyledir).
//
//  Mod eslemesi (SPI mode 0):
//    x1 : master IO0'dan surer (MOSI), slave IO1'den surer (MISO)
//    x2 : {IO1, IO0}
//    x4 : {IO3, IO2, IO1, IO0}
//=============================================================================
`ifndef QSPI_IF_SV
`define QSPI_IF_SV
`timescale 1ns/1ps

interface qspi_if (input logic clk, input logic rst_n);
    logic sclk;
    logic cs;

    wire io0, io1, io2, io3;

    // Flash (slave) tarafinin surucusu
    logic [3:0] drv_val = 4'h0;
    logic [3:0] drv_oe  = 4'h0;

    assign io0 = drv_oe[0] ? drv_val[0] : 1'bz;
    assign io1 = drv_oe[1] ? drv_val[1] : 1'bz;
    assign io2 = drv_oe[2] ? drv_val[2] : 1'bz;
    assign io3 = drv_oe[3] ? drv_val[3] : 1'bz;

    pullup (io0);
    pullup (io1);
    pullup (io2);
    pullup (io3);

    // QSPI'nin DMA yan bandi (DUT -> TB)
    logic [31:0] dma_data;
    logic        dma_valid;
endinterface

`endif
