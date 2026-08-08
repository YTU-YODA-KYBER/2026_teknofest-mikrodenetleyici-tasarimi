`timescale 1ns / 1ps

// ============================================================
// fc_weights_rom_p4 - FC agirliklari, 4 SINIF PARALEL
//
// 4000 x 32-bit = 128000 bit  (eski fc_weights_rom ile AYNI toplam bit)
//
// NEDEN GENIS?
//   FC katmaninda her conv-tamponu degeri 4 cikis sinifinin HEPSI tarafindan
//   kullanilir, sadece agirliklar farklidir. Eski tasarim tamponu 4 kez
//   bastan sona tariyordu (4 x 4000 okuma). Bu ROM bir girdi indeksinin 4
//   sinif agirligini TEK okumada verir -> tampon bir kez taranir, 4 MAC
//   paralel calisir.
//
//   DIKKAT: bu, eski duz dosyanin sadece gruplanmasi degil, GERCEK bir
//   yeniden siralamadir. Duz fc_weights.hex sinif-major'dur
//   (adres = sinif*4000 + idx); buradaki kelimeler girdi-major'dur.
//   Donusumu scripts/yz_weights_pack.py yapar.
//
// Sinif c'nin agirligi: dout[8*c +: 8]  (signed yorumlanir)
// Senkron okuma, 1 cevrim gecikme.
// ============================================================
module fc_weights_rom_p4 (
    input  wire        clk,
    input  wire [11:0] addr,   // 0..3999
    output reg  [31:0] dout
);
    (* ram_style = "block" *)
    reg [31:0] mem [0:3999];

    initial begin
        $readmemh("fc_weights_p4.hex", mem);
    end

    always @(posedge clk) begin
        dout <= mem[addr];
    end
endmodule
