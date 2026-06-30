`timescale 1ns / 1ps

// ============================================================
// feature_memory - BRAM tabanlı, LUT sorunu düzeltildi
//
// DÜZELTME: inline "reg [7:0] ram[0:2047]" kaldırıldı.
// Yerine feature_bram modülü kullanılıyor (initial yok → BRAM).
//
// DMA 4-byte yazma: byte_sel sayacıyla her byte ayrı cycle'da
// yazılıyor. DMA hızı UART'tan çok yüksek olmadığı varsayımıyla
// bu yaklaşım işlevsel olarak doğrudur.
// ============================================================

module feature_memory (
    input wire clk,
    input wire reset,

    input wire [7:0] uart_data,
    input wire       uart_rx_done,

    input  wire [31:0] s00_axis_tdata,
    input  wire        s00_axis_tvalid,
    output reg         s00_axis_tready,
    input  wire        s00_axis_tlast,

    output reg         ai_start,
    input  wire [10:0] read_addr,
    output wire [7:0]  read_data
);

    reg [10:0] write_addr;   // Sonraki boş adres (byte cinsinden)
    reg [1:0]  byte_sel;     // DMA burst içinde hangi byte: 0,1,2,3
    reg [31:0] dma_hold;     // Gelen DMA word'ü tut

    // BRAM yazma sinyalleri
    reg        bram_we;
    reg [10:0] bram_waddr;
    reg [7:0]  bram_wdata;

    feature_bram u_feature_bram (
        .clk   (clk),
        .ena   (1'b1),
        .wea   (bram_we),
        .addra (bram_waddr),
        .dina  (bram_wdata),
        .enb   (1'b1),
        .addrb (read_addr),
        .doutb (read_data)
    );

    always @(posedge clk) begin
        if (reset) begin
            write_addr     <= 0;
            byte_sel       <= 0;
            ai_start       <= 0;
            bram_we        <= 0;
            bram_waddr     <= 0;
            bram_wdata     <= 0;
            s00_axis_tready<= 0;
            dma_hold       <= 0;
        end else begin

            bram_we  <= 0;
            ai_start <= 0;

            // tready: hafıza dolmadıysa ve burst içinde değilsek hazır
            s00_axis_tready <= (write_addr < 1960) && (byte_sel == 0);

            // === DMA burst byte yazma ===
            // byte_sel > 0 ise önceki word'ün devam byte'larını yaz
            if (byte_sel != 0) begin
                bram_we    <= 1;
                bram_waddr <= write_addr;

                case (byte_sel)
                    2'd1: bram_wdata <= dma_hold[15:8];
                    2'd2: bram_wdata <= dma_hold[23:16];
                    2'd3: bram_wdata <= dma_hold[31:24];
                    default: bram_wdata <= 0;
                endcase

                if (write_addr + 1 >= 1960) begin
                    ai_start   <= 1'b1;
                    write_addr <= 0;
                    byte_sel   <= 0;
                end else begin
                    write_addr <= write_addr + 1;
                    byte_sel   <= (byte_sel == 3) ? 2'd0 : byte_sel + 1;
                end
            end

            // === Yeni DMA beat al ===
            else if (s00_axis_tvalid && s00_axis_tready) begin
                dma_hold   <= s00_axis_tdata;
                bram_we    <= 1;
                bram_waddr <= write_addr;
                bram_wdata <= s00_axis_tdata[7:0];  // byte 0 hemen yaz

                if (write_addr + 1 >= 1960) begin
                    ai_start   <= 1'b1;
                    write_addr <= 0;
                    byte_sel   <= 0;
                end else begin
                    write_addr <= write_addr + 1;
                    byte_sel   <= 2'd1;  // byte 1,2,3 sırayla gelecek
                end
            end

            // === UART yedek yol ===
            else if (uart_rx_done && (write_addr < 1960) && (byte_sel == 0)) begin
                bram_we    <= 1;
                bram_waddr <= write_addr;
                bram_wdata <= uart_data;

                if (write_addr == 1959) begin
                    ai_start   <= 1'b1;
                    write_addr <= 0;
                end else begin
                    write_addr <= write_addr + 1;
                end
            end

        end
    end

endmodule