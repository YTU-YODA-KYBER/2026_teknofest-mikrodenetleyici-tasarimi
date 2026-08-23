//=============================================================================
//  IOBUF.sv  --  Xilinx IOBUF primitifinin simulasyon karsiligi
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  I2C (SDA) ve QSPI (IO0..IO3) RTL'i Xilinx'in IOBUF primitifini dogrudan
//  ornekler. Vivado/XSim bunu unisim kutuphanesinden alir; acik kaynakli
//  akista boyle bir kutuphane yok, bu yuzden ayni davranisi yazan bu sarmalayici
//  YALNIZCA UVM derlemesine eklenir. RTL'e tek satir dokunulmaz ve bu dosya
//  hicbir sentez akisina girmez.
//
//  Davranis (UG953):
//     T = 0  ->  IO = I      (surucu aktif)
//     T = 1  ->  IO = z      (yuksek empedans, disaridan surulur)
//     O      =  IO           (pinden okunan deger, her zaman)
//=============================================================================
`ifndef IOBUF_SV
`define IOBUF_SV
`timescale 1ns/1ps

module IOBUF (
    output wire O,
    inout  wire IO,
    input  wire I,
    input  wire T
);
    assign IO = T ? 1'bz : I;
    assign O  = IO;
endmodule

`endif
