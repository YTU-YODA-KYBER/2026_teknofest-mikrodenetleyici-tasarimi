`timescale 1ns / 1ps

// ============================================================
// feature_bram - 2048x8-bit True Dual Port Block RAM
// Port A: DMA/UART yazma
// Port B: conv_accelerator okuma
//
// initial blogu YOK - Vivado bu pattern'i kesin BRAM cikarir
// Reset yokken ilk degerler 0 (BRAM default davranisi)
// ============================================================

module feature_bram (
    input  wire        clk,

    // Port A - Yazma (DMA veya UART)
    input  wire        ena,
    input  wire        wea,
    input  wire [10:0] addra,
    input  wire [7:0]  dina,

    // Port B - Okuma (conv_accelerator)
    input  wire        enb,
    input  wire [10:0] addrb,
    output reg  [7:0]  doutb
);
    (* ram_style = "block" *)
    reg [7:0] mem [0:2047];

    // Port A: senkron yazma
    always @(posedge clk) begin
        if (ena && wea)
            mem[addra] <= dina;
    end

    // Port B: senkron okuma (1 cycle gecikme)
    always @(posedge clk) begin
        if (enb)
            doutb <= mem[addrb];
    end

endmodule
