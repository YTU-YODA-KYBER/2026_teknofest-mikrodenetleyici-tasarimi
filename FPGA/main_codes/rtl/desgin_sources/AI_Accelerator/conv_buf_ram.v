`timescale 1ns / 1ps

// ============================================================
// conv_buf_ram - Konvolüsyon çıktı tamponu için Block RAM
// 4000 × 8-bit = 32000 bit
// Hem yazma hem okuma var → Simple Dual Port BRAM
// ============================================================
module conv_buf_ram (
    input  wire        clk,

    // Yazma portu (conv_accelerator WRITE_CONV state'inde yazar)
    input  wire        wen,
    input  wire [11:0] waddr,  // 0..3999
    input  wire signed [7:0] wdata,

    // Okuma portu (CALC_FC state'inde okur)
    input  wire [11:0] raddr,  // 0..3999
    output reg  signed [7:0] rdata
);
    (* ram_style = "block" *)
    reg signed [7:0] mem [0:3999];

    integer j;
    initial begin
        for (j = 0; j < 4000; j = j + 1)
            mem[j] = 8'h00;
    end

    // Yazma
    always @(posedge clk) begin
        if (wen)
            mem[waddr] <= wdata;
    end

    // Okuma
    always @(posedge clk) begin
        rdata <= mem[raddr];
    end
endmodule
