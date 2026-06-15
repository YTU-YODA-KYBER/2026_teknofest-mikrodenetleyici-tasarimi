`timescale 1ns / 1ps

// ============================================================
// weights_rom - Konvolüsyon ağırlıkları için Block RAM
// 640 × 8-bit = 5120 bit
// Vivado BRAM inference için:
//   - synchronous read (posedge clk)
//   - initial ile $readmemh (sentezde ROM olarak tanınır)
//   - ram_style = "block" attribute
// ============================================================
module weights_rom (
    input  wire        clk,
    input  wire [9:0]  addr,   // 0..639
    output reg  signed [7:0] dout
);
    (* ram_style = "block" *)
    reg signed [7:0] mem [0:639];

    initial begin
        $readmemh("weights.hex", mem);
    end

    always @(posedge clk) begin
        dout <= mem[addr];
    end
endmodule
