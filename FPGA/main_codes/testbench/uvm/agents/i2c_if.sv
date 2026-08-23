//=============================================================================
//  i2c_if.sv  --  I2C hatti
//
//  scl : DUT surer (bu tasarimda push-pull cikis, clock stretching yok)
//  sda : open-drain ortak hat. Master IOBUF ile, slave agent'i da ayni
//        sekilde yalnizca LOW surer; yuksek seviye pullup'tan gelir.
//=============================================================================
`ifndef I2C_IF_SV
`define I2C_IF_SV
`timescale 1ns/1ps

interface i2c_if (input logic clk, input logic rst_n);
    logic scl;              // DUT -> TB
    wire  sda;              // ortak open-drain hat
    logic sda_low = 1'b0;   // slave agent'inin surucusu (1 = LOW sur)

    assign sda = sda_low ? 1'b0 : 1'bz;
    pullup (sda);
endinterface

`endif
