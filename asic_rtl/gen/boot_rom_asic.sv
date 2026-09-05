// ---------------------------------------------------------------------------
//  boot_rom -- OTOMATIK URETILMIS DOSYA, ELLE DUZENLEME.
//
//  Ureten : asic/scripts/gen_rom.py
//  Kaynak : asic_boot.hex
//  Kaynak SHA256 : ded4e8aaf5bd259db1bc12ffe62d12ae3a91ffe07cc88fa78af77208650b7fc9
//  Icerik : 193 / 256 kelime x 32 bit  (6176 bit)
//
//  Kaynak hex'in SHA256'si BILEREK bu basliktadir: `gen_rom.py --all --check`
//  uretimi bellekte tekrarlayip diskteki dosyayla metin bazinda karsilastirir.
//  Boylece firmware/agirliklar yeniden uretildiginde ve `make roms`
//  unutuldugunda BAYAT bir ROM sessizce senteze giremez (patch_rtl.py'nin
//  yamali kopyalar icin yaptigi kontrolun ROM karsiligi).
//
//  Bu modul ASIC akisinda Memory/BRAM_defines/boot_rom_def.sv dosyasinin
//  yerine gecer (modul adi ve port listesi birebir aynidir). Icerik silikonda
//  mask ROM olarak standart hucrelerden orulur; SRAM makrosu KULLANILMAZ,
//  cunku bu bellek kalicidir ve guc verildiginde hazir olmalidir.
// ---------------------------------------------------------------------------

module boot_rom #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10,
    parameter INIT_FILE  = "boot_code.mem"   // ASIC'te kullanilmaz, uyum icin korundu
)(
    input  logic                  clk,

    input  logic [ADDR_WIDTH-1:0] addr_a,
    output logic [DATA_WIDTH-1:0] rdata_a,

    input  logic [ADDR_WIDTH-1:0] addr_b,
    output logic [DATA_WIDTH-1:0] rdata_b
);
    localparam int DEPTH = 1 << ADDR_WIDTH;

    logic [DATA_WIDTH-1:0] rom [0:DEPTH-1];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) rom[i] = 32'h0;
        rom[0] = 32'h20002117;
        rom[1] = 32'h00010113;
        rom[2] = 32'h30400293;
        rom[3] = 32'h20000317;
        rom[4] = 32'hFF430313;
        rom[5] = 32'h20000397;
        rom[6] = 32'hFEC38393;
        rom[7] = 32'h00735963;
        rom[8] = 32'h0002AE03;
        rom[9] = 32'h01C32023;
        rom[10] = 32'h03110291;
        rom[11] = 32'h0297BFC5;
        rom[12] = 32'h82932000;
        rom[13] = 32'h0317FD22;
        rom[14] = 32'h03132000;
        rom[15] = 32'hD663FCA3;
        rom[16] = 32'hA0230062;
        rom[17] = 32'h02910002;
        rom[18] = 32'h28BDBFDD;
        rom[19] = 32'h07B7A001;
        rom[20] = 32'h07374003;
        rom[21] = 32'hC3988200;
        rom[22] = 32'h02000737;
        rom[23] = 32'hC3888D59;
        rom[24] = 32'h475C873E;
        rom[25] = 32'hDFF58B85;
        rom[26] = 32'h400307B7;
        rom[27] = 32'h82000737;
        rom[28] = 32'h8082C398;
        rom[29] = 32'h40030737;
        rom[30] = 32'h82000637;
        rom[31] = 32'h020006B7;
        rom[32] = 32'h10568693;
        rom[33] = 32'hC314C310;
        rom[34] = 32'h8B85475C;
        rom[35] = 32'h471CDFF5;
        rom[36] = 32'hFBED8B85;
        rom[37] = 32'h400307B7;
        rom[38] = 32'h82000737;
        rom[39] = 32'h8082C398;
        rom[40] = 32'h40040737;
        rom[41] = 32'h83854B1C;
        rom[42] = 32'hDFED8B85;
        rom[43] = 32'h400407B7;
        rom[44] = 32'h75134788;
        rom[45] = 32'h873E0FF5;
        rom[46] = 32'h9BF54B1C;
        rom[47] = 32'h4B1CCB1C;
        rom[48] = 32'h8B858385;
        rom[49] = 32'h8082FBF5;
        rom[50] = 32'hC686715D;
        rom[51] = 32'h400107B7;
        rom[52] = 32'h8B85439C;
        rom[53] = 32'h1E078963;
        rom[54] = 32'hC2A6C4A2;
        rom[55] = 32'hDE4EC0CA;
        rom[56] = 32'hDA56DC52;
        rom[57] = 32'hD266D85A;
        rom[58] = 32'h400107B7;
        rom[59] = 32'hC3D84705;
        rom[60] = 32'h400407B7;
        rom[61] = 32'h0F300713;
        rom[62] = 32'h0437C398;
        rom[63] = 32'h478D4003;
        rom[64] = 32'h4519C81C;
        rom[65] = 32'h07B737A9;
        rom[66] = 32'hC01C8200;
        rom[67] = 32'h020007B7;
        rom[68] = 32'h0E478793;
        rom[69] = 32'h8722C01C;
        rom[70] = 32'h8B85475C;
        rom[71] = 32'h3F99DFF5;
        rom[72] = 32'h400107B7;
        rom[73] = 32'hC3D84705;
        rom[74] = 32'h4B194481;
        rom[75] = 32'h40030437;
        rom[76] = 32'h82000AB7;
        rom[77] = 32'h03000937;
        rom[78] = 32'h02090913;
        rom[79] = 32'h69896A05;
        rom[80] = 32'h3731855A;
        rom[81] = 32'h01542023;
        rom[82] = 32'h2023C044;
        rom[83] = 32'h445C0124;
        rom[84] = 32'hDFF58B85;
        rom[85] = 32'h94D23705;
        rom[86] = 32'hFF3494E3;
        rom[87] = 32'h400107B7;
        rom[88] = 32'hC3D84709;
        rom[89] = 32'h4B014C91;
        rom[90] = 32'h3F1D0B22;
        rom[91] = 32'h01656B33;
        rom[92] = 32'h9BE31CFD;
        rom[93] = 32'h0663FE0C;
        rom[94] = 32'hD65E140B;
        rom[95] = 32'hD06AD462;
        rom[96] = 32'h8DE6CE6E;
        rom[97] = 32'h8BDA8D66;
        rom[98] = 32'h400309B7;
        rom[99] = 32'hA071C666;
        rom[100] = 32'h3D754519;
        rom[101] = 32'h820007B7;
        rom[102] = 32'h00F9A023;
        rom[103] = 32'hA823478D;
        rom[104] = 32'h5A9300F9;
        rom[105] = 32'h8966002C;
        rom[106] = 32'h8F638A66;
        rom[107] = 32'h4432060A;
        rom[108] = 32'h04224491;
        rom[109] = 32'h8C4935F5;
        rom[110] = 32'hFCE514FD;
        rom[111] = 32'h0089A423;
        rom[112] = 32'h09059A22;
        rom[113] = 32'hFF5915E3;
        rom[114] = 32'h01A9A223;
        rom[115] = 32'hFFFC0793;
        rom[116] = 32'h073707C2;
        rom[117] = 32'h07131700;
        rom[118] = 32'h8FD95027;
        rom[119] = 32'h00F9A023;
        rom[120] = 32'h00C9A783;
        rom[121] = 32'hDFED8B85;
        rom[122] = 32'h9DD23571;
        rom[123] = 32'h400407B7;
        rom[124] = 32'hC7D84719;
        rom[125] = 32'h67134B98;
        rom[126] = 32'hCB980017;
        rom[127] = 32'h4B1C873E;
        rom[128] = 32'h8B858389;
        rom[129] = 32'h0737DFED;
        rom[130] = 32'h4B1C4004;
        rom[131] = 32'hCB1C9BED;
        rom[132] = 32'h8BB39D62;
        rom[133] = 32'h8B63418B;
        rom[134] = 32'h8C5E000B;
        rom[135] = 32'h10000793;
        rom[136] = 32'hF777F8E3;
        rom[137] = 32'hB7AD8C3E;
        rom[138] = 32'hBF798A56;
        rom[139] = 32'h885E88DE;
        rom[140] = 32'h10000E13;
        rom[141] = 32'h40030737;
        rom[142] = 32'h0F37430D;
        rom[143] = 32'h4EB78200;
        rom[144] = 32'h8E930F00;
        rom[145] = 32'hA09136BE;
        rom[146] = 32'h00672823;
        rom[147] = 32'h01E72023;
        rom[148] = 32'h01072223;
        rom[149] = 32'hFFF50793;
        rom[150] = 32'hE7B307C2;
        rom[151] = 32'hC31C01D7;
        rom[152] = 32'h8B85475C;
        rom[153] = 32'h5593DFF5;
        rom[154] = 32'hC58D0025;
        rom[155] = 32'h86DE87DE;
        rom[156] = 32'h96B24710;
        rom[157] = 32'h9DE30785;
        rom[158] = 32'h2823FEF5;
        rom[159] = 32'h98B60067;
        rom[160] = 32'h0B33982A;
        rom[161] = 32'h096340AB;
        rom[162] = 32'h855A000B;
        rom[163] = 32'hFB6E7EE3;
        rom[164] = 32'hBF5D8572;
        rom[165] = 32'hB7D586AE;
        rom[166] = 32'h411D87B3;
        rom[167] = 32'h00F037B3;
        rom[168] = 32'h5BB2078D;
        rom[169] = 32'h5D025C22;
        rom[170] = 32'h07374DF2;
        rom[171] = 32'hC35C4001;
        rom[172] = 32'h44964426;
        rom[173] = 32'h59F24906;
        rom[174] = 32'h5AD25A62;
        rom[175] = 32'h5C925B42;
        rom[176] = 32'h478DA001;
        rom[177] = 32'h4681B7DD;
        rom[178] = 32'h40030737;
        rom[179] = 32'h82000837;
        rom[180] = 32'h0FFF4637;
        rom[181] = 32'h36B60613;
        rom[182] = 32'h65894505;
        rom[183] = 32'h01072023;
        rom[184] = 32'hC310C354;
        rom[185] = 32'h8B85475C;
        rom[186] = 32'hCB48DFF5;
        rom[187] = 32'h8B854B5C;
        rom[188] = 32'h8693FFF5;
        rom[189] = 32'h93E31006;
        rom[190] = 32'h07B7FEB6;
        rom[191] = 32'h97821000;
        rom[192] = 32'h0000B7C1;
    end

    // Iki bagimsiz senkron okuma portu (komut getirme + veri erisimi).
    always_ff @(posedge clk) begin
        rdata_a <= rom[addr_a];
        rdata_b <= rom[addr_b];
    end

endmodule
