// ---------------------------------------------------------------------------
//  bram_instr (ASIC) -- Instruction RAM, 2048 x 32 bit = 8 KB
//
//  Memory/BRAM_defines/bram_instr_def.sv'nin yerine gecer: modul adi ve
//  parametre listesi aynidir, ic gercekleme FPGA BRAM'i yerine 4 adet SKY130
//  SRAM makrosudur.
//
//  PORT LISTESI TAM OLARAK AYNI DEGILDIR: orijinalde olmayan bir `re` (okuma
//  etkinlestirme) portu EKLENMISTIR. Sebep: OpenRAM makrosunun okuma portu
//  (csb1) surekli acik tutuldugunda, DMA ayni adrese yazarken makro tanimsiz
//  cift-port durumuna giriyordu. Gercek okuma darbesini denetleyici uretir
//  (instr_bram_axi_ctrl_asic.sv:141, patch_rtl.py ile yamalanir) ve ayni-adres
//  cakismasini arbitre eder; bu yuzden bu ornek sram32_bank'i varsayilan
//  RD_COLLISION_SAFE=0 ile kullanir ve DMEM/IMEM->CPU yarim-cevrim kritik
//  yoluna ek mantik girmez.
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
    input  logic                      re,
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
        // Gercek okuma etkinlestirmesi denetleyiciden gelir. Portu surekli
        // acik tutmak, AXI ARVALID=0 iken bile son/adayi adresi okumaya ve
        // DMA ayni adrese yazdiginda OpenRAM'in tanimsiz cift-port durumuna
        // girmeye neden oluyordu.
        .clk(clk), .we(we), .re(re), .be(be),
        .waddr(waddr), .wdata(wdata),
        .raddr(raddr), .rdata(rdata)
    );
endmodule
