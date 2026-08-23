// ---------------------------------------------------------------------------
//  sram32_cell_1k -- sky130_sram_1kbyte_1rw1r_32x256_8 sarmalayicisi
//  256 kelime x 32 bit = 1024 bayt.  Arayuzu sram32_cell ile ayni, tek fark
//  adres genisligi (8 bit).  YZ girdi RAM'inin 30 KB butcesine ince ayarla
//  oturmasi icin son banka olarak kullanilir (bkz. bram_yz_asic.sv).
// ---------------------------------------------------------------------------
module sram32_cell_1k #(
    parameter bit INIT_ZERO = 1'b0
)(
    input  logic        clk,
    input  logic        wsel,
    input  logic [3:0]  be,
    input  logic [7:0]  waddr,
    input  logic [31:0] wdata,
    input  logic        rsel,
    input  logic [7:0]  raddr,
    output logic [31:0] rdata
);
    sky130_sram_1kbyte_1rw1r_32x256_8 u_sram (
        .clk0 (clk), .csb0 (~wsel), .web0 (1'b0), .wmask0(be),
        .addr0(waddr), .din0(wdata), .dout0(),
        .clk1 (clk), .csb1 (~rsel), .addr1(raddr), .dout1(rdata)
    );
`ifdef SRAM_SIM
    defparam u_sram.VERBOSE = 0;
    initial begin
        if (INIT_ZERO) for (int i = 0; i < 256; i++) u_sram.mem[i] = 32'h0000_0000;
    end
`endif
endmodule
