// ---------------------------------------------------------------------------
//  weights_rom_p8 -- OTOMATIK URETILMIS DOSYA, ELLE DUZENLEME.
//
//  Ureten : asic/scripts/gen_rom.py
//  Kaynak : weights_p8.hex
//  Icerik : 80 / 80 kelime x 64 bit  (5120 bit)
//
//  Bu modul ASIC akisinda AI_Accelerator/weights_rom_p8.v dosyasinin
//  yerine gecer (modul adi ve port listesi birebir aynidir). Icerik silikonda
//  mask ROM olarak standart hucrelerden orulur; SRAM makrosu KULLANILMAZ,
//  cunku bu bellek kalicidir ve guc verildiginde hazir olmalidir.
// ---------------------------------------------------------------------------

module weights_rom_p8 (
    input  wire                  clk,
    input  wire [6:0] addr,
    output reg  [63:0] dout
);
    reg [63:0] mem [0:79];

    integer i;
    initial begin
        mem[0] = 64'h0FCFFEEEC428EEFA;
        mem[1] = 64'h83E9ED0D061FF71E;
        mem[2] = 64'h2A2814F9E318C95C;
        mem[3] = 64'hD6EFEA623418F209;
        mem[4] = 64'h3928223BF71EB736;
        mem[5] = 64'h2C1E0B5E07F19DC2;
        mem[6] = 64'h28F34AD8C3FDDD07;
        mem[7] = 64'h27FD05C3F1D516A7;
        mem[8] = 64'h29D43DD7CB1EBACC;
        mem[9] = 64'hB6F3F2FB4428FD00;
        mem[10] = 64'h494145FAF009CF4F;
        mem[11] = 64'hEEF800645D17C505;
        mem[12] = 64'h3F2E4B2EE9F41748;
        mem[13] = 64'h1316F13808E4EEDF;
        mem[14] = 64'h02F436BFC2ED2A2F;
        mem[15] = 64'hE8F613ACFAD2AACF;
        mem[16] = 64'h58DF0ECEB61268B5;
        mem[17] = 64'hD4FAED03151449E4;
        mem[18] = 64'h5E4D00FBCAF6A740;
        mem[19] = 64'h01FCE245301D55E4;
        mem[20] = 64'h3221FC1EF1E98148;
        mem[21] = 64'hFBFAD22FFAED4BED;
        mem[22] = 64'hDBE6DF92C7EDA74D;
        mem[23] = 64'hC5E5F591FAD91FF8;
        mem[24] = 64'h68FEC7D2B90F178C;
        mem[25] = 64'hEB01BD1F492E51D3;
        mem[26] = 64'h625DB8FFEFF01731;
        mem[27] = 64'hFEF9B06A781F0F02;
        mem[28] = 64'h2C1E960AFFD3CC4F;
        mem[29] = 64'hEAF1C8420BF4BCED;
        mem[30] = 64'hD7DCAE99C4EC586E;
        mem[31] = 64'hA2E6C2A206D88712;
        mem[32] = 64'h6B15B6CEACE92481;
        mem[33] = 64'h01FEB629581900BA;
        mem[34] = 64'h5F609C0EECD29625;
        mem[35] = 64'hF6E1B56B69F5F4E9;
        mem[36] = 64'h10189B11E5B1B75E;
        mem[37] = 64'hE5DEA54F0DE0E1E3;
        mem[38] = 64'hB6C9A58299FBE26F;
        mem[39] = 64'h97D6CAC604F3461F;
        mem[40] = 64'h773019F095C01D90;
        mem[41] = 64'h07064D0224FA3CC2;
        mem[42] = 64'h4D672227E7B00215;
        mem[43] = 64'hF6DF403864F4C2F1;
        mem[44] = 64'hFE11150DE1B8433A;
        mem[45] = 64'hFDE43622E5F9ECF5;
        mem[46] = 64'h9FBF15B78E0DBF6D;
        mem[47] = 64'h9BDA148E020AAD16;
        mem[48] = 64'h56517FF5CAA6C38E;
        mem[49] = 64'h0A047FF835D9B3C1;
        mem[50] = 64'h50786819EEBE3F03;
        mem[51] = 64'hE8DB761D7FF7A7F9;
        mem[52] = 64'hF71569E8E7D7B933;
        mem[53] = 64'h06E25BF3E8FEB2F5;
        mem[54] = 64'h8ABF38CCB736096E;
        mem[55] = 64'hB2CB26A7182E1428;
        mem[56] = 64'h446751D7CDAC3795;
        mem[57] = 64'h13006AE904DE31CD;
        mem[58] = 64'h497E24E016DD0C0A;
        mem[59] = 64'hF5DD50015204B5F1;
        mem[60] = 64'hD01B31D6F8F4C926;
        mem[61] = 64'hFDE24FD4C00A03EF;
        mem[62] = 64'h8EC031D7C95AF472;
        mem[63] = 64'hD2C83AB400575E17;
        mem[64] = 64'h2663A6C3D8CB3292;
        mem[65] = 64'h1CF7E99B57E8BCCF;
        mem[66] = 64'h167FB9DBF7F112EA;
        mem[67] = 64'hF1CCEDA27008E0F6;
        mem[68] = 64'hAA34B7A9F704101E;
        mem[69] = 64'hF8EA10B6A62ADB0A;
        mem[70] = 64'hA0D6B9D0DD72065E;
        mem[71] = 64'h01C0E7B1175A9F10;
        mem[72] = 64'hD8469CAFE0E0019D;
        mem[73] = 64'hF6E4BB8A02CEE8AF;
        mem[74] = 64'hCC6E87CBCA0736F3;
        mem[75] = 64'hC0CFD7812A0A9ED6;
        mem[76] = 64'h813395C9CC24EB04;
        mem[77] = 64'hE6F9D6A49C1CADF7;
        mem[78] = 64'hA2F4B0D4CC7F843D;
        mem[79] = 64'h2DCDCFD5EE363CE9;
    end

    always @(posedge clk) begin
        dout <= mem[addr];
    end
endmodule
