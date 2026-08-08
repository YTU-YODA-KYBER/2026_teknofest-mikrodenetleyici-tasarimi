`timescale 1ns / 1ps

// ============================================================
// weights_rom_p8 - Konvolusyon agirliklari, 8 KANAL PARALEL
//
// 80 x 64-bit = 5120 bit  (eski weights_rom ile AYNI toplam bit)
//
// NEDEN GENIS?
//   Katman DepthwiseConv2D: girdi kanali 1, depth multiplier 8. Bir (k_y,k_x)
//   tap'inda 8 cikis kanalinin hepsi ayni girdi pikselini kullanir, sadece
//   agirliklar farklidir. Eski tasarim ayni pencereyi 8 kez tarayip her
//   seferinde tek bayt agirlik okuyordu; bu ROM 8 agirligi TEK okumada verir,
//   boylece 8 MAC paralel calisabilir.
//
//   Eski adresleme zaten w_addr = k_y*64 + k_x*8 + ch idi, yani kanal en hizli
//   degisen boyut. Bu yuzden genisletme sadece "8'li bitisik gruplari tek
//   kelimeye topla" demektir -- agirliklarin sirasi degismedi.
//   (bkz. scripts/yz_weights_pack.py)
//
// Kanal c'nin agirligi: dout[8*c +: 8]  (signed yorumlanir)
// Senkron okuma, 1 cevrim gecikme -- eski ROM ile ayni.
// ============================================================
module weights_rom_p8 (
    input  wire        clk,
    input  wire [6:0]  addr,   // 0..79  = k_y*8 + k_x
    output reg  [63:0] dout
);
    (* ram_style = "block" *)
    reg [63:0] mem [0:79];

    initial begin
        $readmemh("weights_p8.hex", mem);
    end

    always @(posedge clk) begin
        dout <= mem[addr];
    end
endmodule
