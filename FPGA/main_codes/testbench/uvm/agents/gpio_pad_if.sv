//=============================================================================
//  gpio_pad_if.sv  --  GPIO'nun AXI disi (fiziksel) tarafi
//
//  IDR    : 16 switch girisi -- testbench surer
//  ODR    : LED / 7-segment degeri -- DUT surer
//  anode / catode : 7-segment tarama cikislari -- DUT surer
//=============================================================================
`ifndef GPIO_PAD_IF_SV
`define GPIO_PAD_IF_SV
`timescale 1ns/1ps

interface gpio_pad_if (input logic clk, input logic rst_n);
    logic [31:0] idr;         // TB -> DUT
    logic [31:0] odr;         // DUT -> TB
    logic [ 7:0] anode;       // DUT -> TB
    logic [ 7:0] catode;      // DUT -> TB
endinterface

`endif
