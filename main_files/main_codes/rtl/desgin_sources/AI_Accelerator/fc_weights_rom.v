`timescale 1ns / 1ps

// ============================================================
// fc_weights_rom - Fully Connected ağırlıkları için Block RAM
// 16000 × 8-bit = 128000 bit  ← En büyük dizi, LUT'ların %80'i buradan
// ============================================================
module fc_weights_rom (
    input  wire        clk,
    input  wire [13:0] addr,   // 0..15999
    output reg  signed [7:0] dout
);
    (* ram_style = "block" *)
    reg signed [7:0] mem [0:15999];

    initial begin
        $readmemh("fc_weights.hex", mem);
    end

    always @(posedge clk) begin
        dout <= mem[addr];
    end
endmodule
