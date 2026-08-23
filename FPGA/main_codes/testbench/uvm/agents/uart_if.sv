//=============================================================================
//  uart_if.sv  --  UART'in seri (fiziksel) tarafi
//
//  rx : TB -> DUT   (DUT'un aldigi hat)
//  tx : DUT -> TB   (DUT'un gonderdigi hat)
//  cpb: bit suresi, saat cevrimi cinsinden. Test UART_CPB register'ina ne
//       yazdiysa buraya da ayni degeri koyar; agent zamanlamayi ondan alir.
//       Boylece agent DUT hiyerarsisine HIC uzanmaz -- mevcut duz
//       testbench'ler "wait(dut.sixteen_cnt_rx == 15)" ile ic sinyale
//       bakiyordu, burada gercek baud zamanlamasi kullanilir.
//=============================================================================
`ifndef UART_IF_SV
`define UART_IF_SV
`timescale 1ns/1ps

interface uart_if (input logic clk, input logic rst_n);
    logic        rx;
    logic        tx;
    int unsigned cpb = 160;
endinterface

//-----------------------------------------------------------------------------
//  uart_dma_if  --  yalnizca UART_YZ'de bulunan DMA yan bandi
//
//  UART_YZ, aldigi bayti dma_data_o/dma_valid_o uzerinden YZ bellegine
//  aktarir; dma_enable_i ust seviyede GPIO_IDR[1]'den beslenir.
//  Mevcut UART_YZ_tb.sv bu uc portu HIC baglamiyor -- UART_YZ'yi UART_GU'dan
//  ayiran tek ozellik blok seviyesinde dogrulanmamis durumda.
//-----------------------------------------------------------------------------
interface uart_dma_if (input logic clk, input logic rst_n);
    logic       enable;   // TB -> DUT  (dma_enable_i)
    logic [7:0] data;     // DUT -> TB  (dma_data_o)
    logic       valid;    // DUT -> TB  (dma_valid_o)
endinterface

`endif
