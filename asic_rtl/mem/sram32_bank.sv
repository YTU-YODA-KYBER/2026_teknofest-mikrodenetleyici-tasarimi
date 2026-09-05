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
//  ------------------------------------------------------------------------
//  OKUMA YOLU BUTUNLUGU  (2026-08-25 duzeltmesi -- GERCEK HATA IDI)
//  ------------------------------------------------------------------------
//  Onceki surumde `rbank_q <= rbank` KOSULSUZ isliyordu, ama okunan veri
//  (`dout`) yalnizca `rsel` yuksekken gecerliydi. Sonuc: `re` bir cevrim
//  dusunce banka secici ILERLIYOR, veri ise ilerlemiyordu -> bir sonraki
//  cevrimde ESKI kelimeden YANLIS BANKA seciliyordu. sram8_bank'teki
//  `rlane_q` icin de ayni sey gecerliydi (orada yanlis BAYT seciliyordu).
//
//  Ustelik OpenRAM davranissal modeli (macros/.../*.v) her `posedge clk1`de
//  kosulsuz `dout1 = 32'bx` yapar ve yalniz `!csb1_reg` iken negedge'de geri
//  surer; yani deselect edilen cevrimde cikis TUTULMAZ, X olur.
//
//  Duzeltme iki parcali:
//    1) `rbank_q` (ve sram8_bank'te `rlane_q`) artik `re_eff` ile gate'lenir
//       -- secici veriyle her zaman hizali kalir. Maliyeti SIFIRDIR (register
//       enable), kritik yola hicbir sey eklemez.
//    2) RD_COLLISION_SAFE=1 olan ornekler icin cikis, son GECERLI okuma
//       verisini tutan bir kayitla mux'lanir -> `re` dustugunde X disari
//       sizmaz.
//
//  RD_COLLISION_SAFE neden parametre?
//    bram_instr / bram_data denetleyicileri ayni-adres cakismasini ZATEN
//    arbitre ediyor (bkz. instr_bram_axi_ctrl_asic.sv:141, data_bram_axi_ctrl_asic.sv:52)
//    ve okuma yolunda kendi `rdata_latch`leri var. Onlarda parametre 0 kalir,
//    boylece DMEM->CPU yarim-cevrim kritik yoluna EK MUX GIRMEZ.
//    bram_yz / conv_buf_ram ise orijinal FPGA modullerinde KOSULSUZ okuyordu
//    (bram_yz_def.sv:36, conv_buf_ram.v:36-38) ve denetleyici arbitrasyonu
//    yok; onlar `re=1` + RD_COLLISION_SAFE=1 ile kullanilir.
//
//  Ayni adrese ayni cevrimde yaz+oku:
//    RD_COLLISION_SAFE=1 iken o cevrimde ilgili makronun `rsel`i dusurulur
//    (OpenRAM'in tanimsiz cift-port durumuna HIC girilmez) ve cikis son
//    gecerli okuma verisini tutar. Bu, FPGA'nin read-first semantiginin
//    BIREBIR ayni degildir (o, o adresin yazma ONCESI degerini dondururdu);
//    fark asic/README.md "Bilinen sorunlar" bolumunde belgelenmistir.
//    RD_COLLISION_SAFE=0 iken sozlesme denetleyicide korunur; asagidaki
//    assertion regresyonda bunu dogrular.
// ---------------------------------------------------------------------------
module sram32_bank #(
    parameter int NBANK2K   = 4,      // 2 KB'lik makro sayisi
    parameter int HAS_1K    = 0,      // 1 ise sona 1 KB'lik makro eklenir
    parameter int WAW       = 11,     // kelime adres genisligi
    parameter bit INIT_ZERO = 1'b0,   // simulasyonda icerigi 0'la
    parameter bit RD_COLLISION_SAFE = 1'b0  // bkz. yukaridaki aciklama
)(
    input  logic           clk,
    input  logic           we,
    input  logic           re,
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
    logic                 rd_coll, re_eff, re_eff_q;
    logic [31:0]          rdata_sel;

    assign wbank = waddr[WAW-1:9];
    assign rbank = raddr[WAW-1:9];

    // Ayni kelimeye ayni cevrimde yazma+okuma. Tam kelime adresi karsilastirmasi
    // hem ayni bankayi hem makro ici ayni adresi kapsar.
    assign rd_coll = RD_COLLISION_SAFE && we && re && (waddr == raddr);
    assign re_eff  = re && !rd_coll;

    // Okunan bankanin secimi veriyle birlikte bir cevrim gecikir; SADECE
    // gercek bir okuma cevriminde ilerler (bkz. basliktaki 1. madde).
    always_ff @(posedge clk) begin
        if (re_eff) rbank_q <= rbank;
        re_eff_q <= re_eff;
    end

    genvar b;
    generate
        for (b = 0; b < NBANK2K; b = b + 1) begin : g_2k
            sram32_cell #(.INIT_ZERO(INIT_ZERO)) u_cell (
                .clk   (clk),
                .wsel  (we && (wbank == BW'(b))),
                .be    (be),
                .waddr (waddr[8:0]),
                .wdata (wdata),
                .rsel  (re_eff && (rbank == BW'(b))),
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
                .rsel  (re_eff && (rbank == BW'(NBANK2K))),
                .raddr (raddr[7:0]),
                .rdata (dout[NBANK2K])
            );
        end
    endgenerate

    // Banka yuvasi sayisi 2'nin kuvveti degilse (or. 5 banka -> 3 bit) gecersiz
    // kod cozumlerinde X yayilmasin diye 0 dondurulur.  Karsilastirma int
    // uzerinden yapilir: BW'(NB) daralmasi NB=2^BW oldugunda 0 verirdi.
    assign rdata_sel = (int'(rbank_q) < NB) ? dout[rbank_q] : 32'h0000_0000;

    generate
        if (RD_COLLISION_SAFE) begin : g_rd_hold
            // Son GECERLI okuma verisini tutar; `re` dusuk gectiginde makronun
            // X'i yerine bu deger surulur. Gecikme EKLEMEZ: gecerli okuma
            // cevriminde dogrudan rdata_sel gecer.
            logic [31:0] rdata_hold_q;
            always_ff @(posedge clk) if (re_eff_q) rdata_hold_q <= rdata_sel;
            assign rdata = re_eff_q ? rdata_sel : rdata_hold_q;
        end else begin : g_rd_direct
            // Denetleyici tarafindan arbitre edilen ornekler: kritik yola
            // hicbir sey eklenmez, davranis onceki surumle ayni.
            assign rdata = rdata_sel;
        end
    endgenerate

`ifdef SRAM_ASSERTIONS
    always_ff @(posedge clk) begin
        // RD_COLLISION_SAFE=0 ornekleri icin cakismayi denetleyici onlemelidir;
        // burada gorulmesi gercek bir sozlesme ihlalidir.
        if (!RD_COLLISION_SAFE && we && re && (waddr == raddr))
            $error("sram32_bank: ayni cevrimde ayni adrese read/write (arbitrasyon eksik): %0h", waddr);
    end
`endif

endmodule
