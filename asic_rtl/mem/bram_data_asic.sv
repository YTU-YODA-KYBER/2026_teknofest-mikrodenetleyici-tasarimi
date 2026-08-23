// ---------------------------------------------------------------------------
//  bram_data (ASIC) -- Data RAM, 2048 x 32 bit = 8 KB
//
//  Memory/BRAM_defines/bram_data_def.sv'nin birebir yerine gecer.
//  Orijinalde `initial` sifirlama YOKTUR (yazilim kendi .bss'ini temizler),
//  bu davranis burada da korunur: INIT_ZERO = 0.
// ---------------------------------------------------------------------------
module bram_data #(
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
        .INIT_ZERO(1'b0)
    ) u_mem (
        .clk(clk), .we(we), .be(be),
        .waddr(waddr), .wdata(wdata),
        .raddr(raddr), .rdata(rdata)
    );
endmodule
