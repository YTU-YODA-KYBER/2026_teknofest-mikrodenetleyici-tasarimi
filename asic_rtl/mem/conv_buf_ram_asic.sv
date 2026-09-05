// ---------------------------------------------------------------------------
//  conv_buf_ram (ASIC) -- konvolusyon cikti tamponu, 4096 x 8 bit
//
//  AI_Accelerator/conv_buf_ram.v'nin birebir yerine gecer (modul adi ve port
//  listesi ayni). Gerekli derinlik 4000 bayttir; SRAM makro granulariteside
//  512 kelime (2048 bayt) oldugu icin 2 makro ile 4096 bayt kurulur.
//
//  Orijinaldeki `initial` sifirlama (conv_buf_ram.v:24-27) INIT_ZERO ile
//  korunur; yalnizca simulasyonda etkilidir.
// ---------------------------------------------------------------------------
module conv_buf_ram (
    input  wire              clk,
    input  wire              wen,
    input  wire [11:0]       waddr,
    input  wire signed [7:0] wdata,
    input  wire [11:0]       raddr,
    output wire signed [7:0] rdata
);
    // Okuma portu kosulsuz acik: orijinal conv_buf_ram.v:36-38 de kosulsuz
    // okuyor. Onceki `re(~wen)` bugunku FSM'de tetiklenmiyordu (conv geri-yazma
    // ile FC okuma fazlari ayrik) ama tek bir FSM degisikliginde sessiz veri
    // bozulmasi uretecek kirilgan bir sozlesmeydi. Ayrintili gerekce:
    // asic_rtl/mem/sram32_bank.sv basligi.
    sram8_bank #(
        .NBANK2K          (2),        // 2 x 2048 B = 4096 B
        .HAS_1K           (0),
        .AW               (12),
        .INIT_ZERO        (1'b1),
        .RD_COLLISION_SAFE(1'b1)
    ) u_mem (
        .clk(clk), .we(wen), .re(1'b1),
        .waddr(waddr), .wdata(wdata),
        .raddr(raddr), .rdata(rdata)
    );
endmodule
