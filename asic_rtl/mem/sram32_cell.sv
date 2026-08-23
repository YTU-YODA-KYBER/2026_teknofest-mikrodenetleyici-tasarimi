// ---------------------------------------------------------------------------
//  sram32_cell -- tek bir SKY130 SRAM makrosunun ince sarmalayicisi
//
//  Makro: sky130_sram_2kbyte_1rw1r_32x512_8  (512 kelime x 32 bit, 2048 bayt)
//         Port 0 = 1RW (burada YALNIZCA yazma icin kullanilir)
//         Port 1 = 1R  (okuma)
//         8-bit yazma granulariteli (wmask0), aktif-dusuk csb/web.
//
//  Neden ayri bir sarmalayici?
//    OpenRAM'in davranissal modeli her erisimde $display eder (VERBOSE) ve
//    ilklendirilmemis icerik X'tir. Bu iki simulasyon ayrintisini `SRAM_SIM`
//    tanimi altinda burada tek yerden hallediyoruz; sentez tarafi bunlari
//    hic gormez (makro sentezde LEF/Liberty'den gelen bir kara kutudur).
// ---------------------------------------------------------------------------
module sram32_cell #(
    parameter bit INIT_ZERO = 1'b0   // 1 -> simulasyonda icerigi 0'la (FPGA BRAM davranisi)
)(
    input  logic        clk,
    input  logic        wsel,        // 1 = bu bankaya yazilacak
    input  logic [3:0]  be,          // bayt yazma maskesi (aktif-yuksek)
    input  logic [8:0]  waddr,
    input  logic [31:0] wdata,
    input  logic        rsel,        // 1 = bu bankadan okunacak
    input  logic [8:0]  raddr,
    output logic [31:0] rdata
);

    sky130_sram_2kbyte_1rw1r_32x512_8 u_sram (
        // ---- Port 0: yalnizca yazma ----
        .clk0   (clk),
        .csb0   (~wsel),      // aktif-dusuk cip secimi
        .web0   (1'b0),       // aktif-dusuk yazma: sabit yazma modu
        .wmask0 (be),
        .addr0  (waddr),
        .din0   (wdata),
        .dout0  (),           // port 0'dan okuma yapilmiyor
        // ---- Port 1: yalnizca okuma ----
        .clk1   (clk),
        .csb1   (~rsel),
        .addr1  (raddr),
        .dout1  (rdata)
    );

`ifdef SRAM_SIM
    // Modelin her erisimde bastigi $display'i sustur (aksi halde sistem
    // simulasyonu milyonlarca satir log uretir).
    defparam u_sram.VERBOSE = 0;

    initial begin
        if (INIT_ZERO) begin
            for (int i = 0; i < 512; i++) u_sram.mem[i] = 32'h0000_0000;
        end
    end
`endif

endmodule
