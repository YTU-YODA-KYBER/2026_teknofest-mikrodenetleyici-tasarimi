// ---------------------------------------------------------------------------
//  bram_yz (ASIC) -- YZ hizlandiricisinin girdi RAM'i (ses ozellik haritasi)
//
//  Memory/BRAM_defines/bram_yz_def.sv'nin birebir yerine gecer.
//
//  KAPASITE NEDEN 9.216 BAYT?
//    Sartname hizlandiricinin TOPLAM bellegini 30 KB (30.720 B) olarak
//    belirliyor. ASIC'te kalici bellekler (agirlik/bias) ROM, degisken
//    bellekler SRAM makrosu olur:
//
//       fc_weights_rom_p4   16.000 B   mask ROM (std hucre)
//       weights_rom_p8         640 B   mask ROM (std hucre)
//       bias/skor registerlari 176 B   flip-flop
//       conv_buf_ram         4.096 B   2 x 2 KB SRAM makrosu
//       bram_yz (bu modul)   9.216 B   4 x 2 KB + 1 x 1 KB SRAM makrosu
//       ------------------------------------------------------------
//       TOPLAM              30.128 B   (30.720 B sinirinin %98,1'i)
//
//    Makro granulariteleri 2048 ve 1024 bayt oldugu icin 30.720 B'a tam
//    oturan bir kombinasyon yok; 30.128 B sinirin altindaki EN BUYUK
//    ulasilabilir degerdir. FPGA'daki 9.904 baytlik derinlik yerine 9.216
//    kullanilmasinin islevsel etkisi yoktur: girdi her zaman 1960 bayttir
//    (yz_bram_axi_ctrl.sv:55 sayaci 1959'da sarar) ve hizlandirici da
//    yalnizca bu araligi okur.
//
//  DEPTH parametresi ust modulden geldigi gibi kabul edilir ama fiziksel
//  derinligi NBANK2K/HAS_1K belirler; yukaridaki gerekce nedeniyle DEPTH
//  yalnizca belgeleme amaclidir.
// ---------------------------------------------------------------------------
module bram_yz #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 14,
    parameter DEPTH      = 9904,
    // --- ASIC'e ozgu, ust modul bunlari SET ETMEZ (varsayilanlar gecerlidir) ---
    parameter int NBANK2K = 4,     // 4 x 2048 B
    parameter int HAS_1K  = 1      // + 1 x 1024 B  = 9.216 B
)(
    input  logic                  clk,
    input  logic                  we,
    input  logic [ADDR_WIDTH-1:0] waddr,
    input  logic [DATA_WIDTH-1:0] wdata,
    input  logic [ADDR_WIDTH-1:0] raddr,
    output logic [DATA_WIDTH-1:0] rdata
);
    // OKUMA PORTU KOSULSUZ ACIK  (2026-08-25 duzeltmesi)
    //   Orijinal bram_yz_def.sv:36 `always_ff @(posedge clk) rdata <= ram[raddr];`
    //   yani her cevrim KOSULSUZ okur. Onceki ASIC surumu `re(~we)` yaziyordu;
    //   `we` = dma_valid_i (yz_bram_axi_ctrl.sv:42) oldugu icin UART'tan gelen
    //   HER DMA bayti okuma portunu bir cevrim kapatiyordu. Sonuc: o cevrimin
    //   okumasi dusuyor VE serit/banka secicileri veriyle hizasini kaybediyordu
    //   -> hizlandirici, cikarim sirasinda gelen bir DMA baytindan sonra ESKI
    //   kelimeden YANLIS BAYT okuyabiliyordu (sessiz yanlis sinif).
    //   Artik `re=1`; ayni-kelime cakismasi RD_COLLISION_SAFE ile ele alinir
    //   (o cevrimde makro deselect edilir, cikis son gecerli veriyi tutar).
    sram8_bank #(
        .NBANK2K          (NBANK2K),
        .HAS_1K           (HAS_1K),
        .AW               (ADDR_WIDTH),
        .INIT_ZERO        (1'b0),
        .RD_COLLISION_SAFE(1'b1)
    ) u_mem (
        .clk(clk), .we(we), .re(1'b1),
        .waddr(waddr), .wdata(wdata),
        .raddr(raddr), .rdata(rdata)
    );
endmodule
