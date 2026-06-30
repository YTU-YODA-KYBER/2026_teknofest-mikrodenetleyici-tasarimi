`timescale 1ns / 1ps

module uart_rx #(
    parameter CLK_FREQ = 100_000_000, // FPGA Saat frekansın (Örn: 100 MHz)
    parameter BAUD_RATE = 115200
)(
    input wire clk,
    input wire reset,
    input wire rx,              // Bilgisayardan gelen seri pin
    output reg [7:0] data_out,  // Yakalanan 8-bit veri
    output reg rx_done          // "1 byte başarıyla alındı" sinyali
);

    localparam CLK_PER_BIT = CLK_FREQ / BAUD_RATE;
    
    // State Machine (Durum Makinesi)
    localparam IDLE  = 3'b000;
    localparam START = 3'b001;
    localparam DATA  = 3'b010;
    localparam STOP  = 3'b011;
    
    reg [2:0] state = IDLE;
    reg [15:0] clk_count = 0;
    reg [2:0] bit_index = 0;
    reg [7:0] shift_reg = 0;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            rx_done <= 0;
            clk_count <= 0;
            bit_index <= 0;
        end else begin
            rx_done <= 0; // Default olarak 0
            
            case (state)
                IDLE: begin
                    clk_count <= 0;
                    bit_index <= 0;
                    if (rx == 1'b0) begin // Start biti yakalandı
                        state <= START;
                    end
                end
                
                START: begin
                    if (clk_count == (CLK_PER_BIT)/2) begin
                        if (rx == 1'b0) begin // Start biti doğrulandı
                            clk_count <= 0;
                            state <= DATA;
                        end else begin
                            state <= IDLE; // Yanlış alarm
                        end
                    end else begin
                        clk_count <= clk_count + 1;
                    end
                end
                
                DATA: begin
                    if (clk_count < CLK_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        shift_reg[bit_index] <= rx; // Biti kaydet
                        
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            state <= STOP;
                        end
                    end
                end
                
                STOP: begin
                    if (clk_count < CLK_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        rx_done <= 1'b1;     // Veri hazır!
                        data_out <= shift_reg;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule