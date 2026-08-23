// ---------------------------------------------------------------------------
//  bram_instr (ASIC) -- Instruction RAM, 2048 x 32 bit = 8 KB
//
//  Memory/BRAM_defines/bram_instr_def.sv'nin yerine gecer: modul adi, parametre
//  listesi ve port listesi BIREBIR aynidir; yalnizca ic gerceklemesi FPGA
//  BRAM'i yerine 4 adet SKY130 SRAM makrosudur.
//
//     ADDR_WIDTH = 11  ->  2048 kelime  ->  4 x sky130_sram_2kbyte_1rw1r_32x512_8
//
//  Orijinaldeki `initial` sifirlama (bram_instr_def.sv:21-26, CV32E40P'nin
//  spekulatif getirmelerinin AXI okuma kanalina X tasimasini onlemek icin)
//  INIT_ZERO ile korunur ve YALNIZCA simulasyonda etkilidir.
// ---------------------------------------------------------------------------
module bram_instr #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10
)(
    input  logic                      clk,
    input  logic                      we,
    input  logic [(DATA_WIDTH/8)-1:0] be,
    input  logic [ADDR_WIDTH-1:0]     waddr,
    input  logic [DATA_WIDTH-1:0]     wdata,
    input  logic [ADDR_WIDTH-1:0]     raddr,
    output logic [DATA_WIDTH-1:0]     rdata
);
    localparam int NBANK = (1 << ADDR_WIDTH) / 512;   // ADDR_WIDTH=11 -> 4 banka

    sram32_bank #(
        .NBANK2K  (NBANK),
        .HAS_1K   (0),
        .WAW      (ADDR_WIDTH),
        .INIT_ZERO(1'b1)
    ) u_mem (
        .clk(clk), .we(we), .be(be),
        .waddr(waddr), .wdata(wdata),
        .raddr(raddr), .rdata(rdata)
    );
endmodule
