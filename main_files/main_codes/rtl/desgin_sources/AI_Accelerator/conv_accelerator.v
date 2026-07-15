module conv_accelerator (
    input wire clk,
    input wire rst_n,
    input  wire start,
    output reg  done,
    output reg  busy,
    output reg  [10:0]       ram_addr,
    input  wire [7:0]        ram_rdata,   // YZ RAM'den UINT8 (= feature + 128, offset-binary)
    output reg  [12:0]       out_ram_addr,
    output reg               out_ram_wen,
    output reg  signed [7:0] out_ram_wdata
);

    localparam INPUT_H  = 49;
    localparam INPUT_W  = 40;
    localparam FILTER_H = 10;
    localparam FILTER_W = 8;
    localparam STRIDE   = 2;
    localparam PAD_TOP  = 4;
    localparam PAD_LEFT = 3;

    // ------------------------------------------------------------------
    // DÜZELTME: Giriş zero-point.
    // Model conv terimi (q_in - in_zp), in_zp = -128, yani (q_in + 128).
    // Host'un gönderdiği uint8 zaten = feature + 128 (offset-binary).
    // Dolayısıyla ram_rdata'nın KENDİSİ (q_in+128)'e eşittir -> ZP ÇIKARMA YOK.
    // Eski INPUT_ZP=127 hatalıydı.
    // ------------------------------------------------------------------
    localparam signed [31:0] INPUT_ZP  = 32'sd0;

    // Conv çıkış zero-point (Relu tensörü zp = -128)
    localparam signed [31:0] C_OUT_ZP  = -32'sd128;

    reg signed [31:0] biases    [0:7];
    reg signed [31:0] fc_biases [0:3];
    reg signed [31:0] fc_scores [0:3];

    // ------------------------------------------------------------------
    // DÜZELTME: PER-CHANNEL requantization sabitleri (.tflite'tan üretildi).
    // v = ((acc * M0[co]) + yuvarlama) >>> (15 + SHIFT[co]) + C_OUT_ZP,  clip(C_OUT_ZP,127)
    // Eski tek ACC_SHIFT=9 tamamen yanlıştı; kanallar 2^-11..2^-13 arası.
    // ------------------------------------------------------------------
    reg signed [17:0] M0    [0:7];   // Q15 çarpan (max 65496, 17 bit yeter, signed guard için 18)
    reg        [4:0]  SHR   [0:7];   // 15 + shift

    integer i;
    initial begin
        for (i = 0; i < 8; i = i + 1) biases[i]    = 0;
        for (i = 0; i < 4; i = i + 1) fc_biases[i] = 0;
        for (i = 0; i < 4; i = i + 1) fc_scores[i] = 0;
        $readmemh("biases.hex",    biases);
        $readmemh("fc_biases.hex", fc_biases);

        // M0 (Q15) ve toplam sağa-kaydırma miktarı (15 + per-channel shift)
        M0[0]=18'sd50453; SHR[0]=5'd26;   // shift 11
        M0[1]=18'sd46281; SHR[1]=5'd28;   // shift 13
        M0[2]=18'sd61060; SHR[2]=5'd26;
        M0[3]=18'sd35398; SHR[3]=5'd26;
        M0[4]=18'sd45728; SHR[4]=5'd26;
        M0[5]=18'sd39235; SHR[5]=5'd26;
        M0[6]=18'sd65496; SHR[6]=5'd26;
        M0[7]=18'sd53607; SHR[7]=5'd26;
    end

    reg  [9:0]        w_addr;
    wire signed [7:0] w_dout;
    weights_rom u_weights_rom (.clk(clk), .addr(w_addr), .dout(w_dout));

    reg  [13:0]       fcw_addr;
    wire signed [7:0] fcw_dout;
    fc_weights_rom u_fc_weights_rom (.clk(clk), .addr(fcw_addr), .dout(fcw_dout));

    reg               cbuf_wen;
    reg  [11:0]       cbuf_waddr;
    reg  signed [7:0] cbuf_wdata;
    reg  [11:0]       cbuf_raddr;
    wire signed [7:0] cbuf_rdata;
    conv_buf_ram u_conv_buf_ram (.clk(clk), .wen(cbuf_wen), .waddr(cbuf_waddr), .wdata(cbuf_wdata), .raddr(cbuf_raddr), .rdata(cbuf_rdata));

    localparam IDLE=0, ADDR_SETUP=1, WAIT_MEM=2, WAIT_W=3, CALC_CONV=4, WRITE_CONV=5, NEXT_CONV=6,
               PREP_FC=7, WAIT_FC1=8, WAIT_FC2=9, CALC_FC=10, STORE_FC=11, ARGMAX=12, DONE=13;

    reg [3:0] state;
    reg [4:0] out_y, out_x;
    reg [3:0] filter_ch, k_y, k_x;
    reg [11:0] fc_in_idx;
    reg [2:0]  fc_out_idx;
    reg [13:0] fc_base;

    (* use_dsp = "yes" *) reg signed [31:0] acc;
    reg addr_was_valid;

    wire signed [10:0] cur_row = ($signed({1'b0, out_y}) * STRIDE) + $signed({1'b0, k_y}) - PAD_TOP;
    wire signed [10:0] cur_col = ($signed({1'b0, out_x}) * STRIDE) + $signed({1'b0, k_x}) - PAD_LEFT;
    wire addr_valid   = (cur_row >= 0) && (cur_row < INPUT_H) && (cur_col >= 0) && (cur_col < INPUT_W);
    wire [10:0] flat_addr = cur_row * INPUT_W + cur_col;

    // ------------------------------------------------------------------
    // DÜZELTME: PER-CHANNEL requantization (eski tek-shift ReLU yerine)
    // acc: 32-bit. M0 <=65496 (~2^16). acc*M0 -> 48-bit'e kadar. 64-bit ara kullan.
    // ------------------------------------------------------------------
    wire signed [63:0] rq_prod = $signed(acc) * $signed(M0[filter_ch]);
    wire        [4:0]  rq_shift  = SHR[filter_ch];
    wire signed [63:0] rq_round  = rq_prod + (64'sd1 <<< (rq_shift - 1));
    wire signed [63:0] rq_shifted= rq_round >>> rq_shift;
    wire signed [31:0] scaled_acc= rq_shifted[31:0] + C_OUT_ZP;
    wire signed [7:0]  relu_out  = (scaled_acc >  127)      ?  8'sd127 :
                                   (scaled_acc <  C_OUT_ZP) ? C_OUT_ZP[7:0] :  // fused ReLU: alt sınır = zp (-128)
                                   scaled_acc[7:0];

    reg signed [31:0] max_val;
    reg [7:0] best_class;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE; done <= 0; busy <= 0; out_ram_wen <= 0; cbuf_wen <= 0;
            out_y <= 0; out_x <= 0; filter_ch <= 0; k_y <= 0; k_x <= 0;
            fc_in_idx <= 0; fc_out_idx <= 0; fc_base <= 0; acc <= 0; addr_was_valid <= 0;
            ram_addr <= 0; w_addr <= 0; fcw_addr <= 0; cbuf_waddr <= 0; cbuf_wdata <= 0; cbuf_raddr <= 0;
        end else begin
            cbuf_wen <= 0; out_ram_wen <= 0;
            case (state)
                IDLE: begin done <= 0; if (start) begin busy <= 1; acc <= biases[0]; state <= ADDR_SETUP; end end
                ADDR_SETUP: begin
                    if (addr_valid) begin ram_addr <= flat_addr; addr_was_valid <= 1; end else addr_was_valid <= 0;
                    w_addr <= k_y * 64 + k_x * 8 + filter_ch;
                    state  <= WAIT_MEM;
                end
                WAIT_MEM: state <= WAIT_W;
                WAIT_W:   state <= CALC_CONV;
                CALC_CONV: begin
                    if (addr_was_valid)
                        // (q_in - INPUT_ZP) * w,  INPUT_ZP=0 => ram_rdata dogrudan (offset-binary)
                        acc <= acc + ($signed({1'b0, ram_rdata}) - INPUT_ZP) * $signed(w_dout);

                    if (k_x < FILTER_W - 1) begin k_x <= k_x + 1; state <= ADDR_SETUP; end
                    else begin k_x <= 0; if (k_y < FILTER_H - 1) begin k_y <= k_y + 1; state <= ADDR_SETUP; end else begin k_y <= 0; state <= WRITE_CONV; end end
                end
                WRITE_CONV: begin cbuf_wen <= 1; cbuf_waddr <= (out_y * 20 * 8) + (out_x * 8) + filter_ch; cbuf_wdata <= relu_out; state <= NEXT_CONV; end
                NEXT_CONV: begin
                    if (filter_ch < 7) begin filter_ch <= filter_ch + 1; acc <= biases[filter_ch + 1]; state <= ADDR_SETUP; end
                    else begin filter_ch <= 0; acc <= biases[0]; if (out_x < 19) begin out_x <= out_x + 1; state <= ADDR_SETUP; end
                    else begin out_x <= 0; if (out_y < 24) begin out_y <= out_y + 1; state <= ADDR_SETUP; end else begin fc_in_idx <= 0; fc_out_idx <= 0; fc_base <= 0; acc <= fc_biases[0]; state <= PREP_FC; end end end
                end

                PREP_FC: begin cbuf_raddr <= fc_in_idx; fcw_addr <= fc_base + fc_in_idx; state <= WAIT_FC1; end
                WAIT_FC1: state <= WAIT_FC2;
                WAIT_FC2: state <= CALC_FC;
                CALC_FC: begin
                    // FC girisi conv cikisi; in_zp = C_OUT_ZP. (cbuf_rdata - C_OUT_ZP) * w
                    acc <= acc + ($signed(cbuf_rdata) - C_OUT_ZP) * $signed(fcw_dout);
                    if (fc_in_idx < 3999) begin fc_in_idx <= fc_in_idx + 1; cbuf_raddr <= fc_in_idx + 1; fcw_addr <= fc_base + fc_in_idx + 1; state <= WAIT_FC1; end
                    else state <= STORE_FC;
                end
                STORE_FC: begin
                    fc_scores[fc_out_idx] <= acc;
                    if (fc_out_idx < 3) begin fc_out_idx <= fc_out_idx + 1; fc_base <= fc_base + 14'd4000; fc_in_idx <= 0; acc <= fc_biases[fc_out_idx + 1]; state <= PREP_FC; end else state <= ARGMAX; end
                ARGMAX: begin
                    max_val = fc_scores[0]; best_class = 8'd0;
                    if (fc_scores[1] > max_val) begin max_val = fc_scores[1]; best_class = 8'd1; end
                    if (fc_scores[2] > max_val) begin max_val = fc_scores[2]; best_class = 8'd2; end
                    if (fc_scores[3] > max_val) begin max_val = fc_scores[3]; best_class = 8'd3; end
                    out_ram_addr <= 13'd0; out_ram_wdata <= best_class; out_ram_wen <= 1'b1;
                    state <= DONE;
                end
                DONE: begin done <= 1; busy <= 0; state <= IDLE; end
                default: state <= IDLE;
            endcase
        end
    end
endmodule