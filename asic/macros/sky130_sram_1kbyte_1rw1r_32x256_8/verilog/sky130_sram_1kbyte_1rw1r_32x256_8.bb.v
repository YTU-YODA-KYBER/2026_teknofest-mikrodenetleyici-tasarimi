// ---------------------------------------------------------------------------
//  sky130_sram_1kbyte_1rw1r_32x256_8 -- KARA KUTU (black-box) modeli
//
//  Yalnizca port listesini tanimlar; islevsel gövdesi yoktur. Verilator lint
//  adiminda makronun arayuzunu tanitmak icin kullanilir (MACROS[*].vh).
//  Sentezde makro LEF + Liberty'den gelen kara kutudur, simulasyonda ise
//  ayni dizindeki islevsel OpenRAM modeli kullanilir.
//
//  Port listesi PDK'daki islevsel modelden birebir alinmistir:
//    sky130A/libs.ref/sky130_sram_macros/verilog/
// ---------------------------------------------------------------------------
module sky130_sram_1kbyte_1rw1r_32x256_8 (
`ifdef USE_POWER_PINS
    inout  vccd1,
    inout  vssd1,
`endif
    // Port 0: RW
    input         clk0,
    input         csb0,
    input         web0,
    input  [3:0]  wmask0,
    input  [7:0]  addr0,
    input  [31:0] din0,
    output [31:0] dout0,
    // Port 1: R
    input         clk1,
    input         csb1,
    input  [7:0]  addr1,
    output [31:0] dout1
);
endmodule
