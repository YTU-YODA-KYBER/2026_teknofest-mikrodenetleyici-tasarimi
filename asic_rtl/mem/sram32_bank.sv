// ---------------------------------------------------------------------------
//  sram32_bank -- 32-bit genisliginde, bayt-yazma maskeli, 1 yazma + 1 okuma
//                 portlu bellegin SKY130 SRAM makrolarindan kurulmus hali.
//
//  Yapisi:  NBANK2K adet 2 KB makro (512 kelime)  [+ istege bagli 1 adet
//           1 KB makro (256 kelime)].  Her banka kelime adres uzayinda 512
//           kelimelik bir yuva kaplar; 1 KB banka yuvasinin yalnizca alt
//           yarisini doldurur (ust yarisi kullanilmaz).
//
//  ZAMANLAMA SOZLESMESI (orijinal bram_* modulleriyle BIREBIR ayni):
//     raddr N. cevrimde ornekleir  ->  rdata N+1. cevrimin saat kenarinda gecerli.
//     Makronun dout1'i saat kenarindan ~0,4 ns sonra gecerlidir ve bir sonraki
//     okumaya kadar sabit kalir; bu, kayitli BRAM cikisiyla ayni sozlesmedir.
//
//  OKUMA/YAZMA CAKISMASI: OpenRAM makrosunda ayni adrese ayni cevrimde
//  yazip okumak tanimsizdir (model uyari basar). Bu tasarimda CPU veri portu
//  OBI uzerinden tek kanallidir; ayni cevrimde hem okuma hem yazma uretemez.
//  Simulasyonda modelin uyarisi izlenir (bkz. asic/scripts/check_sim.py).
// ---------------------------------------------------------------------------
module sram32_bank #(
    parameter int NBANK2K   = 4,      // 2 KB'lik makro sayisi
    parameter int HAS_1K    = 0,      // 1 ise sona 1 KB'lik makro eklenir
    parameter int WAW       = 11,     // kelime adres genisligi
    parameter bit INIT_ZERO = 1'b0    // simulasyonda icerigi 0'la
)(
    input  logic           clk,
    input  logic           we,
    input  logic [3:0]     be,
    input  logic [WAW-1:0] waddr,
    input  logic [31:0]    wdata,
    input  logic [WAW-1:0] raddr,
    output logic [31:0]    rdata
);
    localparam int NB = NBANK2K + HAS_1K;      // toplam banka sayisi (>= 2)
    localparam int BW = WAW - 9;               // banka secim bit sayisi

    logic [BW-1:0]        wbank, rbank, rbank_q;
    logic [NB-1:0][31:0]  dout;

    assign wbank = waddr[WAW-1:9];
    assign rbank = raddr[WAW-1:9];

    // Okunan bankanin secimi, veriyle birlikte bir cevrim gecikir.
    always_ff @(posedge clk) rbank_q <= rbank;

    genvar b;
    generate
        for (b = 0; b < NBANK2K; b = b + 1) begin : g_2k
            sram32_cell #(.INIT_ZERO(INIT_ZERO)) u_cell (
                .clk   (clk),
                .wsel  (we && (wbank == BW'(b))),
                .be    (be),
                .waddr (waddr[8:0]),
                .wdata (wdata),
                .rsel  (rbank == BW'(b)),
                .raddr (raddr[8:0]),
                .rdata (dout[b])
            );
        end
        if (HAS_1K != 0) begin : g_1k
            sram32_cell_1k #(.INIT_ZERO(INIT_ZERO)) u_cell (
                .clk   (clk),
                .wsel  (we && (wbank == BW'(NBANK2K))),
                .be    (be),
                .waddr (waddr[7:0]),
                .wdata (wdata),
                .rsel  (rbank == BW'(NBANK2K)),
                .raddr (raddr[7:0]),
                .rdata (dout[NBANK2K])
            );
        end
    endgenerate

    // Banka yuvasi sayisi 2'nin kuvveti degilse (or. 5 banka -> 3 bit) gecersiz
    // kod cozumlerinde X yayilmasin diye 0 dondurulur.  Karsilastirma int
    // uzerinden yapilir: BW'(NB) daralmasi NB=2^BW oldugunda 0 verirdi.
    assign rdata = (int'(rbank_q) < NB) ? dout[rbank_q] : 32'h0000_0000;

endmodule
