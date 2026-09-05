// ---------------------------------------------------------------------------
//  sram8_bank -- BAYT genisliginde 1 yazma + 1 okuma portlu bellegin, 32-bit
//                SRAM makrolari uzerine "bayt-seritli" olarak oturtulmus hali.
//
//  Neden serit?  Onayli SKY130 SRAM makrolarinin bayt-genisligindeki tek
//  secenegi 1024x8'dir (0,203 mm² / KB); 512x32 makro ise 0,139 mm² / KB.
//  Makronun 8-bit yazma granulariteli (wmask) oldugu icin bir bayti dogrudan
//  yazabiliyoruz: bayt adresinin alt 2 biti hangi seridin yazilacagini secer.
//
//  Okuma gecikmesi orijinal modulle ayni kalir (1 cevrim): 32-bit kelime
//  makrodan bir cevrimde gelir, serit secimi ise raddr[1:0]'in kayitli
//  kopyasiyla ayni cevrimde yapilir.
//
//  DIKKAT (2026-08-25 duzeltmesi):  `rlane_q` daha once KOSULSUZ isliyordu.
//  `re` bir cevrim dustugunde kelime (`rdata32`) guncellenmiyor ama serit
//  secici ilerliyordu -> bir sonraki cevrimde ESKI kelimeden YANLIS BAYT
//  seciliyordu. Artik `re` ile gate'lenir; ayrintili gerekce ve sram32_bank
//  tarafindaki tamamlayici duzeltme icin sram32_bank.sv basligina bakin.
// ---------------------------------------------------------------------------
module sram8_bank #(
    parameter int NBANK2K   = 4,
    parameter int HAS_1K    = 0,
    parameter int AW        = 14,     // disaridan gelen BAYT adres genisligi
    parameter bit INIT_ZERO = 1'b0,
    parameter bit RD_COLLISION_SAFE = 1'b0   // sram32_bank'e aynen gecirilir
)(
    input  logic          clk,
    input  logic          we,
    input  logic          re,
    input  logic [AW-1:0] waddr,
    input  logic [7:0]    wdata,
    input  logic [AW-1:0] raddr,
    output logic [7:0]    rdata
);
    localparam int NB  = NBANK2K + HAS_1K;
    localparam int WAW = $clog2(NB * 512);    // kelime adres genisligi

    logic [3:0]  be;
    logic [31:0] rdata32;
    logic [1:0]  rlane_q;
    logic        rd_coll, re_eff;

    // Bayt maskesi: adresin alt 2 biti hangi seride yazilacagini soyler.
    assign be = 4'b0001 << waddr[1:0];

    // sram32_bank'in ic `re_eff`i ile BIREBIR ayni kosul: kelime adresi
    // dilimi asagiya gecirilen dilimin AYNISI olmali, yoksa cakisma
    // cevriminde kelime tutulup serit secici ilerler ve hiza yine bozulur.
    assign rd_coll = RD_COLLISION_SAFE && we && re &&
                     (waddr[WAW+1:2] == raddr[WAW+1:2]);
    assign re_eff  = re && !rd_coll;

    // Serit secici, kelimeyle ayni cevrimde ilerlemeli: yalniz gercek okuma
    // cevriminde guncellenir.
    always_ff @(posedge clk) if (re_eff) rlane_q <= raddr[1:0];

    sram32_bank #(
        .NBANK2K          (NBANK2K),
        .HAS_1K           (HAS_1K),
        .WAW              (WAW),
        .INIT_ZERO        (INIT_ZERO),
        .RD_COLLISION_SAFE(RD_COLLISION_SAFE)
    ) u_mem (
        .clk   (clk),
        .we    (we),
        .re    (re),
        .be    (be),
        .waddr (waddr[WAW+1:2]),
        .wdata ({4{wdata}}),          // ayni bayt dort seride de verilir, maske secer
        .raddr (raddr[WAW+1:2]),
        .rdata (rdata32)
    );

    assign rdata = rdata32[8*rlane_q +: 8];

endmodule
