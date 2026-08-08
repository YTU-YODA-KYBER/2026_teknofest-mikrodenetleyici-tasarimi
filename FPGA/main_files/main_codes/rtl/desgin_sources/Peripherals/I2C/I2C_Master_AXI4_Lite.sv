// =========================================================
//  I2C_Master_AXI4_Lite  
// ---------------------------------------------------------

module I2C_Master_AXI4_Lite#(

parameter CLK_FREQ_HZ  = 48_000_000,
parameter I2C_FREQ_HZ  = 400_000,
parameter HALF_PERIOD  = (CLK_FREQ_HZ / (2 * I2C_FREQ_HZ)) - 1
)
(
    // clock ve reset sinyalleri
    input logic clk_i,
    input logic rst_n,

    output logic I2C_SCL,
    inout  logic I2C_SDA,

    // AW Portları
    input  logic [31:0] awaddr,
    input  logic        awvalid,
    output logic        awready,

    // WD Portları
    input  logic [31:0] wdata,
    input  logic        wvalid,
    output logic        wready,

    // B Portları
    output logic [ 1:0] bresp,
    output logic        bvalid,
    input  logic        bready,

    // AR Portları
    input  logic [31:0] araddr,
    input  logic        arvalid,
    output logic        arready,

    // R Portları
    input  logic        rready,
    output logic [31:0] rdata,
    output logic [ 1:0] rresp,
    output logic        rvalid
);

    wire I2C_SDA_out;  // I2C_SDA'ya sürülecek değer (her zaman 0; open-drain)
    wire I2C_SDA_oe;   // 1 = sür (low), 0 = serbest bırak (high-Z)
    wire I2C_SDA_in;   // pinden okunan değer

    // =====================================================
    // Bidirectional I/O Buffer (Xilinx primitive)
    // =====================================================
    IOBUF iobuf_i2c_sda (
        .I (I2C_SDA_out),   // sürülecek değer
        .T (~I2C_SDA_oe),   // tristate enable (active LOW: 0=sür, 1=bırak)
        .O (I2C_SDA_in),    // okunan değer
        .IO(I2C_SDA)        // fiziksel pin
    );

    logic [31: 0] I2C_NBY;
    logic [31: 0] I2C_ADR;
    logic [31: 0] I2C_RDR;
    logic [31: 0] I2C_TDR;
    logic [31: 0] I2C_CFG;

    logic [ 6: 0] freq_div_cnt;
    logic         freq_div_en;
    logic [ 3: 0] current_state;
    logic [ 7: 0] shift_byte;     // gönderilen/alınan bayt
    logic [ 2: 0] shift_cnt;      // 8 bit sayacı
    logic [ 2: 0] data_cnt;       // yazmada kaçıncı veri baytında olduğumuz (0..NBY-1)
    logic [ 2: 0] rx_idx;         // okumada kaçıncı baytı aldığımız (0..NBY-1)
    logic [ 1: 0] phase;          // gönderilen bayt türü (aşağıda)
    logic         r_w;            // 0 = iletiyoruz (TX), 1 = alıyoruz (RX)
    logic         is_read_op;     // transfer tipi: 1 = okuma, 0 = yazma
    logic         sda_out_val;    // SDA hedef değeri (0=low sür, 1=serbest bırak)

    // ---- gönderilen bayt türü (phase) ----
    localparam logic [1:0] PH_ADDRW = 2'd0;  // adres + WRITE biti  (her transferin başı)
    localparam logic [1:0] PH_WDATA = 2'd1;  // yazma veri baytı
    localparam logic [1:0] PH_ADDRR = 2'd2;  // adres + READ biti   (okumada repeated-start sonrası)

    // ---- FSM state'leri ----
    localparam logic [3:0]
        S_IDLE    = 4'd0,
        S_TXBYTE  = 4'd1,   // shift_byte'ı 8 bit dışarı kaydır (adres ya da yazma verisi)
        S_TXREL   = 4'd2,   // ACK için SDA'yı serbest bırak (ara durum, off-by-one'ı önler)
        S_TXACK   = 4'd3,   // gönderilen bayttan sonra ACK örnekle ve yönlendir
        S_REPSTA1 = 4'd4,   // repeated-start: SCL low iken SDA'yı bırak
        S_REPSTA2 = 4'd5,   // repeated-start: SCL high iken SDA'yı düşür (START koşulu)
        S_RXBYTE  = 4'd6,   // 8 bit içeri kaydır (slave'den veri al)
        S_RXACK   = 4'd7,   // alınan bayttan sonra ACK/NACK sür
        S_STOP1   = 4'd8,   // STOP: SCL low iken SDA low
        S_STOP2   = 4'd9,   // STOP: SCL high iken SDA high (STOP koşulu) + bitir
        S_ABORT   = 4'd10;  // NACK: transferi temiz iptal et (DONE set etme)

    // SDA sürme: open-drain -> sadece 0 sürülür, 1 için bırakılır
    assign I2C_SDA_out = 1'b0;
    assign I2C_SDA_oe  = ~sda_out_val; // sda_out_val=0 -> oe=1 (low sür); =1 -> oe=0 (bırak)

    // ---------------------------------------------------------
    //                    SCL DIVIDER (400 kHz)
    // ---------------------------------------------------------
    always @(posedge clk_i or negedge rst_n) begin
        if(!rst_n)begin
            I2C_SCL      <= 1;
            freq_div_cnt <= 0;
        end
        else begin
            if (freq_div_en) begin
                if(freq_div_cnt == HALF_PERIOD)begin
                    freq_div_cnt <= 0;
                    I2C_SCL      <= ~I2C_SCL;
                end
                else freq_div_cnt <= freq_div_cnt + 1;
            end
            else begin
                freq_div_cnt <= 0;
                I2C_SCL      <= 1;
            end
        end
    end

    // ---------------------------------------------------------
    //                ANA KONTROL (AXI + I2C çekirdek)
    // ---------------------------------------------------------
    always @(posedge clk_i or negedge rst_n) begin

        if(!rst_n)begin
            I2C_NBY <= 0;
            I2C_ADR <= 0;
            I2C_RDR <= 0;
            I2C_TDR <= 0;
            I2C_CFG <= 0;

            shift_byte    <= 0;
            shift_cnt     <= 0;
            data_cnt      <= 0;
            rx_idx        <= 0;
            phase         <= PH_ADDRW;
            r_w           <= 0;
            is_read_op    <= 0;
            freq_div_en   <= 0;
            bresp         <= 0;
            bvalid        <= 0;
            rdata         <= 0;
            rresp         <= 0;
            rvalid        <= 0;
            awready       <= 1;
            wready        <= 1;
            arready       <= 1;
            sda_out_val   <= 1;
            current_state <= S_IDLE;
        end
        else begin

            // ---------------------------------------------------------
            //                      AXI YAZMA
            // ---------------------------------------------------------
            if (awvalid && wvalid && awready && wready) begin
                awready <= 1'b0;
                wready  <= 1'b0;
                bvalid  <= 1'b1;
                bresp   <= 2'b00;

                case (awaddr[7:0])
                    8'h00:if (wdata > 4)   I2C_NBY <= 4;
                          else if (!wdata) I2C_NBY <= 1;
                          else             I2C_NBY <= wdata;
                    8'h04: I2C_ADR <= wdata;
                    8'h0C: I2C_TDR <= wdata;
                    8'h10: I2C_CFG <= wdata;
                    8'h14: begin
                        if (wdata[0]) I2C_CFG[1] <= 1'b0;  // WR_DONE temizle
                        if (wdata[1]) I2C_CFG[3] <= 1'b0;  // RD_DONE temizle
                    end
                endcase
            end
            else if (bvalid && bready) begin
                bvalid  <= 1'b0;
                awready <= 1'b1;
                wready  <= 1'b1;
            end

            // ---------------------------------------------------------
            //                      AXI OKUMA
            // ---------------------------------------------------------
            if (arvalid && arready) begin
                arready <= 0;
                rvalid  <= 1;
                rresp   <= 2'b00;

                case (araddr[7:0])
                    8'h00: rdata <= I2C_NBY;
                    8'h04: rdata <= I2C_ADR;
                    8'h08: rdata <= I2C_RDR;
                    8'h0C: rdata <= I2C_TDR;
                    8'h10: rdata <= I2C_CFG;
                    default: rdata <= 32'h0;
                endcase
            end
            else if (rvalid && rready) begin
                rvalid  <= 0;
                arready <= 1;
            end

            // ---------------------------------------------------------
            //                       I2C ÇEKİRDEĞİ
            // ---------------------------------------------------------
            if (I2C_CFG[0] || I2C_CFG[2]) begin

                // ---- TRANSFER BAŞLATMA + START koşulu ----
                if (!freq_div_en) begin
                    freq_div_en   <= 1'b1;
                    sda_out_val   <= 1'b0;                       // SCL idle high iken SDA low -> START
                    shift_byte    <= {I2C_ADR[6:0], 1'b0};       // her transfer adres+W ile başlar
                    shift_cnt     <= 3'd7;
                    phase         <= PH_ADDRW;
                    is_read_op    <= (I2C_CFG[2] && !I2C_CFG[0]); // hem yazma hem okuma set ise: yazma önceliği
                    r_w           <= 1'b0;
                    data_cnt      <= 0;
                    rx_idx        <= 0;
                    awready       <= 1'b0;
                    wready        <= 1'b0;
                    current_state <= S_TXBYTE;
                end

                else if (freq_div_cnt == 7'd29) begin
                    case (current_state)

                        // ---------- BAYT GÖNDER (adres ya da yazma verisi) ----------
                        S_TXBYTE: begin
                            if (!I2C_SCL) begin
                                sda_out_val <= shift_byte[7];
                                shift_byte  <= {shift_byte[6:0], 1'b0};
                                if (shift_cnt == 0) begin
                                    shift_cnt     <= 3'd7;
                                    current_state <= S_TXREL;   // 8 bit bitti -> ACK fazına geç
                                end
                                else shift_cnt <= shift_cnt - 1;
                            end
                        end

                        // ---------- ACK için SDA'yı bırak (ara durum) ----------
                        // Son veri bitinin sunulduğu SCL-high'ı atlatır, sonra low'da bırakır.
                        S_TXREL: begin
                            if (!I2C_SCL) begin
                                sda_out_val   <= 1'b1;          // (2) ACK öncesi SDA serbest
                                current_state <= S_TXACK;
                            end
                        end

                        // ---------- GÖNDERİLEN BAYTIN ACK'INI ÖRNEKLE ----------
                        S_TXACK: begin
                            if (I2C_SCL) begin
                                if (!I2C_SDA_in) begin           // ACK alındı
                                    case (phase)
                                        // -- adres+W ACK'landı --
                                        PH_ADDRW: begin
                                            if (is_read_op) begin
                                                current_state <= S_REPSTA1;   // okuma: repeated-start'a git
                                            end
                                            else begin                        // yazma: ilk veri baytını yükle
                                                shift_byte    <= I2C_TDR[7:0];
                                                shift_cnt     <= 3'd7;
                                                data_cnt      <= 0;
                                                phase         <= PH_WDATA;
                                                current_state <= S_TXBYTE;
                                            end
                                        end
                                        // -- yazma veri baytı ACK'landı --
                                        PH_WDATA: begin
                                            if (data_cnt == I2C_NBY[2:0] - 1) begin
                                                current_state <= S_STOP1;     // son bayt -> STOP
                                            end
                                            else begin
                                                data_cnt  <= data_cnt + 1;
                                                shift_cnt <= 3'd7;
                                                case (data_cnt + 1)           // bir sonraki TDR baytı
                                                    1: shift_byte <= I2C_TDR[15: 8];
                                                    2: shift_byte <= I2C_TDR[23:16];
                                                    3: shift_byte <= I2C_TDR[31:24];
                                                    default: shift_byte <= I2C_TDR[7:0];
                                                endcase
                                                current_state <= S_TXBYTE;
                                            end
                                        end
                                        // -- adres+R ACK'landı -> alıma geç --
                                        PH_ADDRR: begin
                                            r_w           <= 1'b1;
                                            shift_cnt     <= 3'd7;
                                            rx_idx        <= 0;
                                            current_state <= S_RXBYTE;
                                        end
                                        default: current_state <= S_ABORT;
                                    endcase
                                end
                                else begin                       // NACK -> iptal
                                    current_state <= S_ABORT;
                                end
                            end
                        end

                        // ---------- REPEATED-START (faz 1: SCL low'da SDA bırak) ----------
                        S_REPSTA1: begin
                            if (!I2C_SCL) begin
                                sda_out_val   <= 1'b1;          // SDA high
                                current_state <= S_REPSTA2;
                            end
                        end

                        // ---------- REPEATED-START (faz 2: SCL high'da SDA düşür) ----------
                        S_REPSTA2: begin
                            if (I2C_SCL) begin
                                sda_out_val   <= 1'b0;                  // SCL high iken SDA düşer = (re)START
                                shift_byte    <= {I2C_ADR[6:0], 1'b1};  // adres + READ biti
                                shift_cnt     <= 3'd7;
                                phase         <= PH_ADDRR;
                                current_state <= S_TXBYTE;
                            end
                        end

                        // ---------- SLAVE'DEN BAYT AL ----------
                        S_RXBYTE: begin
                            if (!I2C_SCL) begin
                                sda_out_val <= 1'b1;            
                            end
                            else begin                        
                                shift_byte <= {shift_byte[6:0], I2C_SDA_in};
                                if (shift_cnt == 0) begin
                                    shift_cnt <= 3'd7;
                                    // tamamlanan baytı doğru konuma yaz (ilk bayt -> RDR[7:0])
                                    case (rx_idx)
                                        0: I2C_RDR[ 7: 0] <= {shift_byte[6:0], I2C_SDA_in};
                                        1: I2C_RDR[15: 8] <= {shift_byte[6:0], I2C_SDA_in};
                                        2: I2C_RDR[23:16] <= {shift_byte[6:0], I2C_SDA_in};
                                        3: I2C_RDR[31:24] <= {shift_byte[6:0], I2C_SDA_in};
                                    endcase
                                    current_state <= S_RXACK;
                                end
                                else shift_cnt <= shift_cnt - 1;
                            end
                        end

                        // ---------- ALINAN BAYT İÇİN ACK/NACK SÜR ----------
                        S_RXACK: begin
                            if (!I2C_SCL) begin
                                // son bayt -> NACK (SDA high/bırak), değilse ACK (SDA low)
                                if (rx_idx == I2C_NBY[2:0] - 1) sda_out_val <= 1'b1;
                                else                            sda_out_val <= 1'b0;
                            end
                            else begin                          // ACK/NACK biti sunuldu -> yönlendir
                                if (rx_idx == I2C_NBY[2:0] - 1) begin
                                    current_state <= S_STOP1;   // son bayt -> STOP
                                end
                                else begin
                                    rx_idx        <= rx_idx + 1;
                                    shift_cnt     <= 3'd7;
                                    current_state <= S_RXBYTE;
                                end
                            end
                        end

                        // ---------- STOP (faz 1: SCL low'da SDA low) ----------
                        S_STOP1: begin
                            if (!I2C_SCL) begin
                                sda_out_val   <= 1'b0;
                                current_state <= S_STOP2;
                            end
                        end

                        // ---------- STOP (faz 2: SCL high'da SDA high) + bitir ----------
                        S_STOP2: begin
                            if (I2C_SCL) begin
                                sda_out_val   <= 1'b1;         
                                freq_div_en   <= 1'b0;
                                awready       <= 1'b1;
                                wready        <= 1'b1;
                                current_state <= S_IDLE;
                                if (is_read_op) begin
                                    I2C_CFG[2] <= 1'b0;         // RD_START temizle
                                    I2C_CFG[3] <= 1'b1;         // RD_DONE set
                                end
                                else begin
                                    I2C_CFG[0] <= 1'b0;         // WR_START temizle
                                    I2C_CFG[1] <= 1'b1;         // WR_DONE set
                                end
                            end
                        end

                        // ---------- NACK / İPTAL ----------
                        S_ABORT: begin
                            if (!I2C_SCL) begin
                                sda_out_val <= 1'b0;
                            end
                            else begin
                                sda_out_val   <= 1'b1;          // temiz STOP
                                freq_div_en   <= 1'b0;
                                awready       <= 1'b1;
                                wready        <= 1'b1;
                                I2C_CFG[0]    <= 1'b0;
                                I2C_CFG[2]    <= 1'b0;
                                current_state <= S_IDLE;
                            end
                        end

                        default: current_state <= S_IDLE;
                    endcase
                end
            end
        end
    end
endmodule
