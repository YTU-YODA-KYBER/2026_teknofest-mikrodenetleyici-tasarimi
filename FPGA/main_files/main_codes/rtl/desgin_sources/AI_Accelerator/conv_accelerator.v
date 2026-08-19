`timescale 1ns / 1ps
// =====================================================================
//  conv_accelerator  --  TFLite Micro Speech ("Tiny Conv") hizlandirici
//                        v2: PIPELINELI + PARALEL datapath
//
//  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
//
//  Model: 49x40x1 girdi -> DepthwiseConv2D (8 filtre, 10x8 cekirdek,
//         stride 2, per-channel requant + fused ReLU) -> 25x20x8 = 4000
//         -> FC (4000 -> 4) -> argmax
//
//  ---------------------------------------------------------------
//  v1 -> v2 DEGISIKLIGI (fonksiyonel cikis BIT-EXACT AYNI)
//  ---------------------------------------------------------------
//  v1: 1.336.011 cevrim   |   v2: ~45.500 cevrim   ->  ~29x hizlanma
//
//  (F1) filter_ch dongusu KALDIRILDI. Katman depthwise oldugu icin 8 cikis
//       kanali AYNI girdi pikselini kullanir. v1 her pencereyi 8 kez
//       tariyordu; v2 bir kez tarar ve 8 akumulatorde paralel MAC yapar.
//       Agirliklar weights_rom_p8'den 64-bit (8 kanal) tek okumada gelir.
//
//  (F2) Tap basina 4 cevrim -> 1 cevrim. v1'in
//       ADDR_SETUP -> WAIT_MEM -> WAIT_W -> CALC_CONV zinciri 3 evreli bir
//       pipeline'a donustu:
//          evre 0 : adres uret (k_x/k_y sayaclari her cevrim ilerler)
//          evre 1 : BRAM okuma gecikmesi
//          evre 2 : MAC (8 kanal paralel)
//       Sinir kosulu (addr_valid) adresle birlikte v_s1/v_s2 uzerinden
//       pipeline'da tasinir.
//
//  (F3) FC katmani 4 sinifi paralel hesaplar; agirliklar
//       fc_weights_rom_p4'ten 32-bit (4 sinif) tek okumada gelir. Conv
//       tamponu 4 kez degil BIR kez taranir, tap basina 1 cevrim.
//
//  (F4) Requantization zinciri (32x18 carpma + degisken kaydirma + doyum)
//       artik PIPELINELI: carpim sonrasi register var. Bu zincir v1'de tek
//       cevrimde yapiliyordu ve WNS = +0.184 ns ile kritik yoldu.
//       Ayrica 8 kanalin requantization'i paralel yapilir, boylece
//       cevrim maliyeti pozisyon basina 2 cevrime duser.
//
//  Ayrica: M0/SHR sabitleri initial blogundan localparam'a tasindi
//  (ASIC sentezi initial blogu ceviremez).
//
//  ---------------------------------------------------------------
//  CEVRIM BUTCESI (v2)
//  ---------------------------------------------------------------
//    Cikis pozisyonu basina : 80 tap + 2 pipeline bosaltma + 1 requant = 83
//    Conv toplam            : 500 pozisyon x 83            = 41.500
//    FC                     : 4000 tap + 2 bosaltma + 1    =  4.003
//    TOPLAM                                                ~ 45.500
// =====================================================================
module conv_accelerator #(
    // YZ RAM adres genisligi -- top_module'deki ADDR_WIDTH_yz ile ayni olmali.
    // Girdi her zaman 1960 bayt oldugu icin adres degerleri 11 bite sigar;
    // port genisligi RAM ile ayni tutulur ki ust adres bitleri sabit 0'a
    // baglanip sentezde BRAM'lerin bir kismi optimize edilerek atilmasin.
    // RAM derinligi 9.904 bayt: sartnamenin 30 KB'lik TOPLAM hizlandirici
    // bellek butcesinden bu modulun kendi bellekleri (16.000 + 4.000 + 640 +
    // 176 = 20.816 B) dusuldukten sonra kalan pay. bkz. bram_yz_def.sv
    parameter RAM_ADDR_W = 14
)(
    input wire clk,
    input wire rst_n,
    input  wire start,
    output reg  done,
    output reg  busy,
    output reg  [RAM_ADDR_W-1:0] ram_addr,
    input  wire [7:0]        ram_rdata,   // YZ RAM'den UINT8 (= feature + 128, offset-binary)
    output reg  [12:0]       out_ram_addr,
    output reg               out_ram_wen,
    output reg signed [7:0]  out_ram_wdata
);

    localparam INPUT_H  = 49;
    localparam INPUT_W  = 40;
    localparam FILTER_H = 10;
    localparam FILTER_W = 8;
    localparam STRIDE   = 2;
    localparam PAD_TOP  = 4;
    localparam PAD_LEFT = 3;

    localparam OUT_H    = 25;   // (49 + 4 + 5 - 10)/2 + 1
    localparam OUT_W    = 20;
    localparam N_CH     = 8;    // depth multiplier
    localparam N_CLASS  = 4;
    localparam FC_IN    = OUT_H * OUT_W * N_CH;   // 4000

    // ------------------------------------------------------------------
    // Giris zero-point.
    // Model conv terimi (q_in - in_zp), in_zp = -128, yani (q_in + 128).
    // Host'un gonderdigi uint8 zaten = feature + 128 (offset-binary).
    // Dolayisiyla ram_rdata'nin KENDISI (q_in+128)'e esittir -> ZP CIKARMA YOK.
    // ------------------------------------------------------------------
    localparam signed [31:0] INPUT_ZP  = 32'sd0;

    // Conv cikis zero-point (Relu tensoru zp = -128)
    localparam signed [31:0] C_OUT_ZP  = -32'sd128;

    // ------------------------------------------------------------------
    // PER-CHANNEL requantization sabitleri (.tflite'tan uretildi).
    //   v = ((acc * M0[co]) + yuvarlama) >>> SHR[co] + C_OUT_ZP,
    //       clip(C_OUT_ZP, 127)
    //
    // v1'de bunlar bir `initial` blogunda atanıyordu. Vivado bunu tolere
    // ediyor ama ASIC sentezi `initial` cevirmez -- bu yuzden duz
    // localparam'a tasindi. Diziler Verilog-2005'te localparam olamadigi
    // icin duzlestirilmis vektor + parcali secim kullanildi:
    //     M0 [c] = M0_FLAT [18*c +: 18]
    //     SHR[c] = SHR_FLAT[ 5*c +:  5]
    // Sira: en soldaki kanal 7, en sagdaki kanal 0.
    // ------------------------------------------------------------------
    localparam [N_CH*18-1:0] M0_FLAT = {
        18'd53607,   // ch7
        18'd65496,   // ch6
        18'd39235,   // ch5
        18'd45728,   // ch4
        18'd35398,   // ch3
        18'd61060,   // ch2
        18'd46281,   // ch1
        18'd50453    // ch0
    };
    localparam [N_CH*5-1:0] SHR_FLAT = {
        5'd26,       // ch7
        5'd26,       // ch6
        5'd26,       // ch5
        5'd26,       // ch4
        5'd26,       // ch3
        5'd26,       // ch2
        5'd28,       // ch1  (shift 13)
        5'd26        // ch0  (shift 11)
    };

    // ------------------------------------------------------------------
    // Requantization ara genisligi.
    //   acc  : 32 bit signed
    //   M0   : 18 bit signed
    //   -> carpim tam olarak 50 bite sigar; yuvarlama terimi (<= 2^30)
    //      eklenince 51 bit. 56 bit secildi: hem 5 bit pay birakir hem de
    //      v1'in 64-bit ara degeriyle BIT-EXACT ayni sonucu verir
    //      (ust bitler her zaman isaret uzatmasidir, `>>> SHR` sonrasi
    //      [31:0] parcasi degismez). 64 yerine 56 kullanmak 8 adet
    //      barrel-shifter'in maliyetini gozle gorulur sekilde dusurur.
    // ------------------------------------------------------------------
    localparam integer RQ_W = 56;

    // ------------------------------------------------------------------
    // Bias'lar hala dosyadan okunuyor: bunlar model export akisinin ciktisi
    // ve elle yazilmis sabitler degil. (ASIC'e gecerken bu iki `initial`
    // da ROM makrosuna/localparam'a donusmeli.)
    // ------------------------------------------------------------------
    reg signed [31:0] biases    [0:N_CH-1];
    reg signed [31:0] fc_biases [0:N_CLASS-1];
    reg signed [31:0] fc_scores [0:N_CLASS-1];   // <-- testbench hiyerarsik olarak okur

    integer i;
    initial begin
        for (i = 0; i < N_CH;    i = i + 1) biases[i]    = 0;
        for (i = 0; i < N_CLASS; i = i + 1) fc_biases[i] = 0;
        for (i = 0; i < N_CLASS; i = i + 1) fc_scores[i] = 0;
        $readmemh("biases.hex",    biases);
        $readmemh("fc_biases.hex", fc_biases);
    end

    // ==================================================================
    //  BELLEKLER
    // ==================================================================
    reg  [6:0]  w_addr;          // 0..79 = k_y*8 + k_x
    wire [63:0] w_dout;          // 8 kanalin agirligi: kanal c -> w_dout[8*c +: 8]
    weights_rom_p8 u_weights_rom (.clk(clk), .addr(w_addr), .dout(w_dout));

    reg  [11:0] fcw_addr;        // 0..3999
    wire [31:0] fcw_dout;        // 4 sinifin agirligi: sinif c -> fcw_dout[8*c +: 8]
    fc_weights_rom_p4 u_fc_weights_rom (.clk(clk), .addr(fcw_addr), .dout(fcw_dout));

    reg               cbuf_wen;
    reg  [11:0]       cbuf_waddr;
    reg  signed [7:0] cbuf_wdata;
    reg  [11:0]       cbuf_raddr;
    wire signed [7:0] cbuf_rdata;
    conv_buf_ram u_conv_buf_ram (
        .clk(clk), .wen(cbuf_wen), .waddr(cbuf_waddr), .wdata(cbuf_wdata),
        .raddr(cbuf_raddr), .rdata(cbuf_rdata)
    );

    // ==================================================================
    //  DURUMLAR
    // ==================================================================
    localparam S_IDLE       = 4'd0,
               S_CONV_TAP   = 4'd1,   // her cevrim bir tap adresi uret
               S_CONV_DRAIN = 4'd2,   // MAC pipeline'ini bosalt (2 cevrim)
               S_CONV_RQ    = 4'd3,   // acc -> requant pipeline, pozisyon ilerlet
               S_CONV_WAIT  = 4'd4,   // son pozisyonun geri-yazmasi bitsin
               S_FC_ISSUE   = 4'd5,   // her cevrim bir FC girdisi
               S_FC_DRAIN   = 4'd6,
               S_FC_STORE   = 4'd7,
               S_ARGMAX     = 4'd8,
               S_DONE       = 4'd9;

    reg [3:0] state;

    // ---- conv sayaclari ----
    reg [4:0] out_y, out_x;      // 0..24 / 0..19
    reg [3:0] k_y;               // 0..9
    reg [2:0] k_x;               // 0..7
    reg [1:0] drain_cnt;

    // ---- conv akumulatorleri (8 kanal paralel) ----
    (* use_dsp = "yes" *) reg signed [31:0] acc [0:N_CH-1];

    // Adres pipeline'inin gecerlilik bayraklari.
    //   v_s1 : bir onceki cevrimde uretilen adres gecerli miydi
    //   v_s2 : su anki cevrimde BRAM cikisindaki veri gecerli mi (MAC gate'i)
    reg v_s1, v_s2;

    // ---- FC ----
    reg  [11:0] fc_idx;
    reg  [1:0]  fc_drain;
    (* use_dsp = "yes" *) reg signed [31:0] fc_acc [0:N_CLASS-1];
    reg f_v1, f_v2;

    // ==================================================================
    //  ADRES URETIMI (kombinasyonel, evre 0)
    // ==================================================================
    wire signed [10:0] cur_row = ($signed({1'b0, out_y}) * STRIDE) + $signed({1'b0, k_y}) - PAD_TOP;
    wire signed [10:0] cur_col = ($signed({1'b0, out_x}) * STRIDE) + $signed({1'b0, k_x}) - PAD_LEFT;
    wire addr_valid = (cur_row >= 0) && (cur_row < INPUT_H) &&
                      (cur_col >= 0) && (cur_col < INPUT_W);
    //  addr_valid=0 iken cur_row/cur_col negatif olabilir; genis flat_addr'de
    //  bu isaret uzatmasi ust bitlere tasar. ram_addr yalnizca addr_valid
    //  iken yuklendigi icin RAM'e hicbir zaman ulasmaz.
    wire [RAM_ADDR_W-1:0] flat_addr = cur_row * INPUT_W + cur_col;

    // ==================================================================
    //  REQUANTIZATION (F4) -- 8 kanal paralel, 2 evre
    //
    //   evre 1 (kayitli) : wb_prod[c] = acc[c] * M0[c]      <- eski kritik yol
    //   evre 2 (kombin.) : yuvarla -> kaydir -> zp ekle -> doyur
    //
    //  Ifade bicimleri v1 ile birebir aynidir (isaretli/isaretsiz baglam
    //  dahil) -- amac bit-exact esdegerlik.
    // ==================================================================
    reg  signed [RQ_W-1:0] wb_prod [0:N_CH-1];
    wire        [N_CH*8-1:0] rq_bytes_w;

    // M0'i bir wire'a kopyala: asagidaki dongu parametreyi DEGISKEN indeksle
    // dilimliyor; parametre yerine net dilimlemek her arac tarafindan
    // sorunsuz desteklenir (sentezde 8:1 sabit mux'a coker).
    wire [N_CH*18-1:0] m0_w = M0_FLAT;

    genvar c;
    generate
        for (c = 0; c < N_CH; c = c + 1) begin : g_rq
            localparam [4:0] SHR_C = SHR_FLAT[5*c +: 5];

            wire signed [RQ_W-1:0] rq_round =
                    wb_prod[c] + $signed({{(RQ_W-1){1'b0}}, 1'b1} << (SHR_C - 5'd1));
            wire signed [RQ_W-1:0] rq_shifted = rq_round >>> SHR_C;
            wire signed [31:0]     scaled_acc = rq_shifted[31:0] + C_OUT_ZP;

            // fused ReLU: alt sinir = zero-point (-128), ust sinir = 127
            assign rq_bytes_w[8*c +: 8] = (scaled_acc >  32'sd127) ? 8'sd127        :
                                          (scaled_acc <  C_OUT_ZP) ? C_OUT_ZP[7:0]  :
                                                                     scaled_acc[7:0];
        end
    endgenerate

    // ==================================================================
    //  CONV TAMPONUNA GERI YAZMA
    //  8 sonuc tek cevrimde uretilir, conv_buf_ram bayt genisliginde
    //  oldugu icin 8 cevrimde damla damla yazilir. Bu yazma bir sonraki
    //  pozisyonun tap'lariyla ORTUSUR (yazma portu o sirada bostur),
    //  yani pozisyon basina ek cevrim maliyeti YOKTUR.
    // ==================================================================
    reg         wb_v1, wb_v2;
    reg [11:0]  wb_base1, wb_base2;
    reg [63:0]  wb_bytes;
    reg [3:0]   wb_cnt;                    // 0..7 yaziyor, 8 = bosta

    wire wb_busy = wb_v1 | wb_v2 | (wb_cnt != 4'd8);

    // ==================================================================
    //  ARGMAX
    // ==================================================================
    reg signed [31:0] max_val;
    reg [7:0] best_class;

    integer ci;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE; done <= 0; busy <= 0; out_ram_wen <= 0; cbuf_wen <= 0;
            out_y <= 0; out_x <= 0; k_y <= 0; k_x <= 0; drain_cnt <= 0;
            v_s1 <= 0; v_s2 <= 0;
            fc_idx <= 0; fc_drain <= 0; f_v1 <= 0; f_v2 <= 0;
            ram_addr <= 0; w_addr <= 0; fcw_addr <= 0;
            cbuf_waddr <= 0; cbuf_wdata <= 0; cbuf_raddr <= 0;
            out_ram_addr <= 0; out_ram_wdata <= 0;
            wb_v1 <= 0; wb_v2 <= 0; wb_base1 <= 0; wb_base2 <= 0;
            wb_bytes <= 0; wb_cnt <= 4'd8;
            for (ci = 0; ci < N_CH;    ci = ci + 1) acc[ci]      <= 0;
            for (ci = 0; ci < N_CH;    ci = ci + 1) wb_prod[ci]  <= 0;
            for (ci = 0; ci < N_CLASS; ci = ci + 1) fc_acc[ci]   <= 0;
        end else begin
            cbuf_wen    <= 1'b0;
            out_ram_wen <= 1'b0;

            // ==========================================================
            //  PIPELINE EVRE 2 -- MAC'ler
            //  Durum makinesinden BAGIMSIZ calisir; sadece gecerlilik
            //  bayragiyla kapilanir. case blogundan ONCE yazildi ki
            //  S_CONV_RQ'daki akumulator sifirlama uzerine yazabilsin
            //  (o cevrimde v_s2 zaten 0'dir, bosaltma bunu garanti eder).
            // ==========================================================
            v_s2 <= v_s1;
            if (v_s2) begin
                // (q_in - INPUT_ZP) * w,  INPUT_ZP=0 => ram_rdata dogrudan
                for (ci = 0; ci < N_CH; ci = ci + 1)
                    acc[ci] <= acc[ci] +
                        ($signed({1'b0, ram_rdata}) - INPUT_ZP) * $signed(w_dout[8*ci +: 8]);
            end

            f_v2 <= f_v1;
            if (f_v2) begin
                // FC girisi conv cikisi; in_zp = C_OUT_ZP. (cbuf_rdata - C_OUT_ZP) * w
                for (ci = 0; ci < N_CLASS; ci = ci + 1)
                    fc_acc[ci] <= fc_acc[ci] +
                        ($signed(cbuf_rdata) - C_OUT_ZP) * $signed(fcw_dout[8*ci +: 8]);
            end

            // ==========================================================
            //  GERI YAZMA BIRIMI (durum makinesinden bagimsiz)
            // ==========================================================
            wb_v1 <= 1'b0;
            wb_v2 <= wb_v1;

            if (wb_v1) begin
                wb_bytes <= rq_bytes_w;
                wb_base2 <= wb_base1;
            end

            if (wb_v2) begin
                wb_cnt <= 4'd0;
            end else if (wb_cnt != 4'd8) begin
                wb_cnt     <= wb_cnt + 4'd1;
                cbuf_wen   <= 1'b1;
                cbuf_waddr <= wb_base2 + {8'd0, wb_cnt};
                cbuf_wdata <= wb_bytes[8*wb_cnt +: 8];
            end

            // ==========================================================
            //  DURUM MAKINESI
            // ==========================================================
            case (state)

                S_IDLE: begin
                    done <= 1'b0;
                    if (start) begin
                        busy  <= 1'b1;
                        out_y <= 5'd0; out_x <= 5'd0; k_y <= 4'd0; k_x <= 3'd0;
                        for (ci = 0; ci < N_CH; ci = ci + 1) acc[ci] <= biases[ci];
                        state <= S_CONV_TAP;
                    end
                end

                // ------ evre 0: tap adresi uret, sayaclari ilerlet ------
                S_CONV_TAP: begin
                    if (addr_valid) ram_addr <= flat_addr;
                    v_s1   <= addr_valid;
                    // k_y*8 + k_x -- k_y 4 bit (0..9), k_x 3 bit (0..7),
                    // birlestirme tam 7 bit = 0..79.
                    w_addr <= {k_y, k_x};

                    if (k_x != FILTER_W - 1) begin
                        k_x <= k_x + 3'd1;
                    end else begin
                        k_x <= 3'd0;
                        if (k_y != FILTER_H - 1) begin
                            k_y <= k_y + 4'd1;
                        end else begin
                            k_y       <= 4'd0;
                            drain_cnt <= 2'd0;
                            state     <= S_CONV_DRAIN;
                        end
                    end
                end

                // ------ pipeline bosaltma: son 2 tap'in MAC'i insin ------
                S_CONV_DRAIN: begin
                    v_s1 <= 1'b0;
                    if (drain_cnt == 2'd1) state <= S_CONV_RQ;
                    else drain_cnt <= drain_cnt + 2'd1;
                end

                // ------ akumulatorleri requant pipeline'ina al ------
                S_CONV_RQ: begin
                    wb_v1    <= 1'b1;
                    wb_base1 <= (out_y * (OUT_W*N_CH)) + (out_x * N_CH);
                    for (ci = 0; ci < N_CH; ci = ci + 1)
                        wb_prod[ci] <= $signed(acc[ci]) * $signed(m0_w[18*ci +: 18]);

                    // sonraki pozisyon icin akumulatorleri bias'a dondur
                    for (ci = 0; ci < N_CH; ci = ci + 1) acc[ci] <= biases[ci];

                    if (out_x != OUT_W - 1) begin
                        out_x <= out_x + 5'd1;
                        state <= S_CONV_TAP;
                    end else begin
                        out_x <= 5'd0;
                        // out_y son dalda SIFIRLANMALI: aksi halde kosum
                        // bitiminde out_y=24'te kalir ve bir sonraki start'ta
                        // konvolusyon sadece son satiri hesaplar.
                        if (out_y != OUT_H - 1) begin
                            out_y <= out_y + 5'd1;
                            state <= S_CONV_TAP;
                        end else begin
                            out_y <= 5'd0;
                            state <= S_CONV_WAIT;
                        end
                    end
                end

                // ------ son pozisyonun 8 baytlik yazmasi bitsin ------
                S_CONV_WAIT: begin
                    if (!wb_busy) begin
                        fc_idx   <= 12'd0;
                        fc_drain <= 2'd0;
                        for (ci = 0; ci < N_CLASS; ci = ci + 1) fc_acc[ci] <= fc_biases[ci];
                        state    <= S_FC_ISSUE;
                    end
                end

                // ------ FC: her cevrim bir girdi, 4 sinif paralel ------
                S_FC_ISSUE: begin
                    cbuf_raddr <= fc_idx;
                    fcw_addr   <= fc_idx;
                    f_v1       <= 1'b1;
                    if (fc_idx == FC_IN - 1) begin
                        fc_drain <= 2'd0;
                        state    <= S_FC_DRAIN;
                    end else begin
                        fc_idx <= fc_idx + 12'd1;
                    end
                end

                S_FC_DRAIN: begin
                    f_v1 <= 1'b0;
                    if (fc_drain == 2'd1) state <= S_FC_STORE;
                    else fc_drain <= fc_drain + 2'd1;
                end

                S_FC_STORE: begin
                    for (ci = 0; ci < N_CLASS; ci = ci + 1) fc_scores[ci] <= fc_acc[ci];
                    state <= S_ARGMAX;
                end

                S_ARGMAX: begin
                    max_val = fc_scores[0]; best_class = 8'd0;
                    if (fc_scores[1] > max_val) begin max_val = fc_scores[1]; best_class = 8'd1; end
                    if (fc_scores[2] > max_val) begin max_val = fc_scores[2]; best_class = 8'd2; end
                    if (fc_scores[3] > max_val) begin max_val = fc_scores[3]; best_class = 8'd3; end
                    out_ram_addr  <= 13'd0;
                    out_ram_wdata <= best_class;
                    out_ram_wen   <= 1'b1;
                    state <= S_DONE;
                end

                S_DONE: begin
                    done  <= 1'b1;
                    busy  <= 1'b0;
                    state <= S_IDLE;
                end

                default: state <= S_IDLE;
            endcase
        end
    end
endmodule
