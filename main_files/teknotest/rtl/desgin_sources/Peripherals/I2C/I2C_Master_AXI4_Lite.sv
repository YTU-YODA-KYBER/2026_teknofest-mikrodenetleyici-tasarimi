`timescale 1ns / 1ps

// =============================================================================
// I2C Master AXI4-Lite — SystemVerilog
// =============================================================================
module I2C_Master_AXI4_Lite #(
    parameter int CLK_FREQ_HZ = 48_000_000,
    parameter int I2C_FREQ_HZ = 400_000,
    parameter int HALF_PERIOD = (CLK_FREQ_HZ / (2 * I2C_FREQ_HZ)) - 1
)(
    input  logic        clk_i,
    input  logic        rst_n,

    output logic        I2C_SCL,
    inout  wire         I2C_SDA,

    // AW
    input  logic [31:0] awaddr,
    input  logic        awvalid,
    output logic        awready,

    // W
    input  logic [31:0] wdata,
    input  logic        wvalid,
    output logic        wready,

    // B
    output logic [ 1:0] bresp,
    output logic        bvalid,
    input  logic        bready,

    // AR
    input  logic [31:0] araddr,
    input  logic        arvalid,
    output logic        arready,

    // R
    input  logic        rready,
    output logic [31:0] rdata,
    output logic [ 1:0] rresp,
    output logic        rvalid
);

    // -------------------------------------------------------------------------
    // Durum enum'ı
    // -------------------------------------------------------------------------
    typedef enum logic [2:0] {
        ST_ACK_CHECK  = 3'd0,   // orijinal "0" state'i
        ST_LOAD_DATA  = 3'd1,
        ST_PUSH_DATA  = 3'd2,
        ST_DECIDE     = 3'd3,
        ST_ACK        = 3'd4,
        ST_STOP_CLR   = 3'd5,
        ST_IDLE       = 3'd6
    } state_t;

    // -------------------------------------------------------------------------
    // İç Kayıtçılar
    // -------------------------------------------------------------------------
    logic [31:0] I2C_NBY;
    logic [31:0] I2C_ADR;
    logic [31:0] I2C_RDR;
    logic [31:0] I2C_TDR;
    logic [31:0] I2C_CFG;
    logic [ 1:0] I2C_CFG_clr;   // her clock sıfırlanır (latch fix)

    logic [ 6:0] freq_div_cnt;
    logic        freq_div_en;
    state_t      current_state;
    logic [ 7:0] shift_byte;
    logic [ 2:0] shift_cnt;
    logic [ 2:0] nby_cnt;
    logic [ 2:0] byte_cnt;
    logic        restart;
    logic        r_w;
    logic        delay;
    logic        is_read_op;
    logic        sda_out_val;

    // -------------------------------------------------------------------------
    // SDA sürücü: open-drain
    // -------------------------------------------------------------------------
    assign I2C_SDA = sda_out_val ? 1'bz : 1'b0;

    // =========================================================================
    // SCL Bölücü (400 kHz)
    // =========================================================================
    always_ff @(posedge clk_i or negedge rst_n) begin
        if (!rst_n) begin
            I2C_SCL      <= 1'b1;
            freq_div_cnt <= '0;
        end else begin
            if (freq_div_en) begin
                if (freq_div_cnt == HALF_PERIOD[6:0]) begin
                    freq_div_cnt <= '0;
                    I2C_SCL      <= ~I2C_SCL;
                end else begin
                    freq_div_cnt <= freq_div_cnt + 1'b1;
                end
            end else begin
                freq_div_cnt <= '0;
                I2C_SCL      <= 1'b1;
            end
        end
    end

    // =========================================================================
    // Ana Always Bloğu
    // =========================================================================
    always_ff @(posedge clk_i or negedge rst_n) begin

        if (!rst_n) begin
            I2C_NBY       <= '0;
            I2C_ADR       <= '0;
            I2C_RDR       <= '0;
            I2C_TDR       <= '0;
            I2C_CFG       <= '0;
            I2C_CFG_clr   <= '0;
            shift_byte    <= '0;
            shift_cnt     <= '0;
            byte_cnt      <= '0;
            restart       <= 1'b0;
            r_w           <= 1'b0;
            is_read_op    <= 1'b0;
            freq_div_en   <= 1'b0;
            delay         <= 1'b0;
            bresp         <= '0;
            bvalid        <= 1'b0;
            rdata         <= '0;
            rresp         <= '0;
            rvalid        <= 1'b0;
            awready       <= 1'b1;
            wready        <= 1'b1;
            arready       <= 1'b1;
            sda_out_val   <= 1'b1;
            current_state <= ST_PUSH_DATA;

        end else begin

            // Pulse: bir sonraki clock'ta otomatik sıfırla
            I2C_CFG_clr <= '0;

            // -----------------------------------------------------------------
            // AXI Yazma Kanalı
            // -----------------------------------------------------------------
            if (awvalid && wvalid && awready && wready) begin
                awready <= 1'b0;
                wready  <= 1'b0;
                bvalid  <= 1'b1;

                unique case (awaddr[7:0])
                    8'h00: I2C_NBY <= (wdata > 32'd4) ? 32'd4 :
                                      (wdata == '0)   ? 32'd1 : wdata;
                    8'h04: I2C_ADR    <= wdata;
                    8'h0C: I2C_TDR    <= wdata;
                    8'h10: begin
                        // Sadece start bitleri yazılır; done bitleri HW kontrolünde
                        I2C_CFG[0] <= wdata[0];
                        I2C_CFG[2] <= wdata[2];
                    end
                    8'h14: I2C_CFG_clr <= wdata[1:0];
                    default: ;
                endcase

            end else if (bvalid && bready) begin
                bvalid  <= 1'b0;
                awready <= 1'b1;
                wready  <= 1'b1;
            end

            // -----------------------------------------------------------------
            // AXI Okuma Kanalı
            // -----------------------------------------------------------------
            if (arvalid && arready) begin
                arready <= 1'b0;
                rvalid  <= 1'b1;
                unique case (araddr[7:0])
                    8'h00:   rdata <= I2C_NBY;
                    8'h04:   rdata <= I2C_ADR;
                    8'h08:   rdata <= I2C_RDR;
                    8'h0C:   rdata <= I2C_TDR;
                    8'h10:   rdata <= I2C_CFG;
                    default: rdata <= 32'hDEAD_BEEF;
                endcase
            end else if (rvalid && rready) begin
                rvalid  <= 1'b0;
                arready <= 1'b1;
            end

            // -----------------------------------------------------------------
            // I2C Çekirdeği
            // -----------------------------------------------------------------
            if (I2C_CFG[0] || I2C_CFG[2]) begin

                // Transfer başlat
                if (!freq_div_en) begin
                    nby_cnt       <= I2C_CFG[0] ? I2C_NBY[2:0] : 3'd1;
                    sda_out_val   <= 1'b0;
                    byte_cnt      <= '0;
                    r_w           <= 1'b0;
                    is_read_op    <= 1'b0;
                    awready       <= 1'b0;
                    wready        <= 1'b0;
                    freq_div_en   <= 1'b1;
                    shift_byte    <= {I2C_ADR[6:0], 1'b0};
                    shift_cnt     <= 3'd7;
                    current_state <= ST_PUSH_DATA;
                end

                if (freq_div_cnt == 7'd29 && freq_div_en) begin
                    if (restart) begin
                        if (I2C_SCL) begin
                            sda_out_val   <= 1'b0;
                            nby_cnt       <= 3'd0;
                            restart       <= 1'b0;
                            is_read_op    <= 1'b1;
                            shift_byte    <= {I2C_ADR[6:0], 1'b1};
                            current_state <= ST_PUSH_DATA;
                        end
                    end else begin
                        unique case (current_state)

                            ST_ACK_CHECK: begin
                                if (!I2C_SCL) begin
                                    current_state <= ST_LOAD_DATA;
                                    sda_out_val   <= r_w ? 1'b0 : 1'b1;
                                end
                            end

                            ST_LOAD_DATA: begin
                                if (I2C_SCL && !r_w) begin
                                    if (!I2C_SDA) begin
                                        current_state <= ST_PUSH_DATA;
                                        unique case (byte_cnt)
                                            3'd1: shift_byte <= I2C_TDR[ 7: 0];
                                            3'd2: shift_byte <= I2C_TDR[15: 8];
                                            3'd3: shift_byte <= I2C_TDR[23:16];
                                            3'd4: shift_byte <= I2C_TDR[31:24];
                                            default: ;
                                        endcase
                                    end else begin
                                        current_state <= ST_DECIDE;
                                    end
                                end else if (!I2C_SCL && r_w) begin
                                    sda_out_val   <= 1'b1;
                                    current_state <= ST_PUSH_DATA;
                                    unique case (byte_cnt)
                                        3'd1: I2C_RDR[ 7: 0] <= shift_byte;
                                        3'd2: I2C_RDR[15: 8] <= shift_byte;
                                        3'd3: I2C_RDR[23:16] <= shift_byte;
                                        3'd4: I2C_RDR[31:24] <= shift_byte;
                                        default: ;
                                    endcase
                                end
                            end

                            ST_PUSH_DATA: begin
                                if (!r_w) begin
                                    if (!I2C_SCL) begin
                                        sda_out_val <= shift_byte[7];
                                        shift_byte  <= shift_byte << 1;
                                        if (!shift_cnt) begin
                                            shift_cnt <= 3'd7;
                                            if (nby_cnt != '0) begin
                                                byte_cnt      <= byte_cnt + 1'b1;
                                                nby_cnt       <= nby_cnt  - 1'b1;
                                                current_state <= ST_ACK_CHECK;
                                            end else begin
                                                byte_cnt      <= 3'd1;
                                                current_state <= ST_DECIDE;
                                            end
                                        end else begin
                                            shift_cnt <= shift_cnt - 1'b1;
                                        end
                                    end
                                end else begin
                                    if (I2C_SCL) begin
                                        shift_byte <= {shift_byte[6:0], I2C_SDA};
                                        if (!shift_cnt) begin
                                            shift_cnt <= 3'd7;
                                            if (nby_cnt > 3'd1) begin
                                                byte_cnt      <= byte_cnt + 1'b1;
                                                nby_cnt       <= nby_cnt  - 1'b1;
                                                current_state <= ST_ACK_CHECK;
                                            end else begin
                                                byte_cnt      <= '0;
                                                current_state <= ST_DECIDE;
                                            end
                                        end else begin
                                            shift_cnt <= shift_cnt - 1'b1;
                                        end
                                    end
                                end
                            end

                            ST_DECIDE: begin
                                if (!I2C_CFG[0]) begin
                                    if (I2C_SCL && r_w) begin
                                        unique case (I2C_NBY[2:0])
                                            3'd1: I2C_RDR[ 7: 0] <= shift_byte;
                                            3'd2: I2C_RDR[15: 8] <= shift_byte;
                                            3'd3: I2C_RDR[23:16] <= shift_byte;
                                            3'd4: I2C_RDR[31:24] <= shift_byte;
                                            default: ;
                                        endcase
                                        current_state <= ST_STOP_CLR;
                                    end else if (!I2C_SCL && !r_w) begin
                                        if (delay) begin
                                            if (!is_read_op) begin
                                                restart <= 1'b1;
                                            end else begin
                                                r_w     <= 1'b1;
                                                nby_cnt <= I2C_NBY[2:0];
                                            end
                                            byte_cnt      <= '0;
                                            sda_out_val   <= 1'b1;
                                            current_state <= ST_LOAD_DATA;
                                        end else begin
                                            delay <= 1'b1;
                                        end
                                    end
                                end else if (!I2C_SCL) begin
                                    current_state <= ST_ACK;
                                end
                            end

                            ST_ACK: begin
                                if (I2C_SCL && !I2C_SDA)
                                    current_state <= ST_STOP_CLR;
                            end

                            ST_STOP_CLR: begin
                                if (!I2C_SCL) sda_out_val <= 1'b0;
                                if ( I2C_SCL) begin
                                    sda_out_val   <= 1'b1;
                                    shift_cnt     <= 3'd7;
                                    byte_cnt      <= 3'd1;
                                    awready       <= 1'b1;
                                    wready        <= 1'b1;
                                    freq_div_en   <= 1'b0;
                                    delay         <= 1'b0;
                                    current_state <= ST_IDLE;
                                    if (r_w) begin
                                        I2C_CFG[2] <= 1'b0;
                                        I2C_CFG[3] <= 1'b1;
                                    end else begin
                                        I2C_CFG[0] <= 1'b0;
                                        I2C_CFG[1] <= 1'b1;
                                    end
                                end
                            end

                            ST_IDLE: begin
                                if (I2C_CFG_clr[0]) I2C_CFG[1] <= 1'b0;
                                if (I2C_CFG_clr[1]) I2C_CFG[3] <= 1'b0;
                            end

                            default: ;
                        endcase
                    end
                end
            end // I2C çekirdeği

            // Transfer dışında da bayrak temizlemeye izin ver
            if (!freq_div_en && (current_state == ST_IDLE)) begin
                if (I2C_CFG_clr[0]) I2C_CFG[1] <= 1'b0;
                if (I2C_CFG_clr[1]) I2C_CFG[3] <= 1'b0;
            end

        end // else rst_n
    end // always_ff

endmodule
