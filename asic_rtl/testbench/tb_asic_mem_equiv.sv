// ---------------------------------------------------------------------------
//  tb_asic_mem_equiv -- ASIC bellek sarmalayicilarinin esdegerlik testi
//
//  ASIC akisinda FPGA BRAM'lerinin yerine SKY130 SRAM makrolari ve mask ROM'lar
//  geciyor (main_codes/rtl/asic_sources/). Bu testbench, sarmalayicilarin
//  ORIJINAL modullerle ayni islevi ve ayni okuma gecikmesini verdigini kanitlar:
//
//    1) sram32_bank  : Instruction/Data RAM yapisi (2048 x 32, bayt-enable)
//    2) sram8_bank   : YZ girdi RAM'i yapisi (9216 x 8, bayt-seritli)
//    3) boot_rom     : uretilmis mask ROM icerigi == boot.hex
//    4) agirlik ROM'lari: uretilmis mask ROM icerigi == kaynak hex'ler
//
//  ORNEKLEME NOKTASI: OpenRAM davranissal modeli dout'u saat kenarindan
//  T_HOLD sonra X'e ceker ve negedge'de yeniler. Gercek donanimda da veriyi
//  yakalayan sey tuketicinin flip-flop'udur; bu yuzden butun karsilastirmalar
//  `always_ff @(posedge clk)` icinde, yani preponed bolgede yapilir.
//
//  Sartname madde 1.3: "Zorunlu SRAM makrosu ... islevsel dogrulama
//  testlerinde kullanilmalidir."  Sistem seviyesi kaniti ayrica ASIC dosya
//  listesiyle kosulan boot_test / ai_accel_test tarafindan saglanir.
// ---------------------------------------------------------------------------
`timescale 1ns/1ps

module tb_asic_mem_equiv;

    localparam int CLK_HALF = 10;   // 50 MHz
    logic clk = 0;
    always #(CLK_HALF) clk = ~clk;

    int errors = 0;
    int checks = 0;

    task automatic chk(input string what, input logic [63:0] got, input logic [63:0] exp);
        checks++;
        if (got !== exp) begin
            errors++;
            if (errors <= 15)
                $display("  HATA %-20s beklenen=%h alinan=%h  (t=%0t)", what, exp, got, $time);
        end
    endtask

    // =====================================================================
    //  1) sram32_bank -- Instruction / Data RAM yapisi
    // =====================================================================
    localparam int W_AW = 11;                       // 2048 kelime x 32 bit = 8 KB
    logic            w_we, w_en;
    logic [3:0]      w_be;
    logic [W_AW-1:0] w_waddr, w_raddr;
    logic [31:0]     w_wdata, w_rdata;

    sram32_bank #(.NBANK2K(4), .HAS_1K(0), .WAW(W_AW), .INIT_ZERO(1'b1)) dut32 (
        .clk(clk), .we(w_we), .re(1'b1), .be(w_be),
        .waddr(w_waddr), .wdata(w_wdata),
        .raddr(w_raddr), .rdata(w_rdata)
    );

    // Altin model = orijinal bram_instr / bram_data davranisi
    logic [31:0] gold32 [0:(1<<W_AW)-1];
    logic [31:0] gold32_rdata;
    always_ff @(posedge clk) begin
        if (w_we) begin
            if (w_be[0]) gold32[w_waddr][ 7: 0] <= w_wdata[ 7: 0];
            if (w_be[1]) gold32[w_waddr][15: 8] <= w_wdata[15: 8];
            if (w_be[2]) gold32[w_waddr][23:16] <= w_wdata[23:16];
            if (w_be[3]) gold32[w_waddr][31:24] <= w_wdata[31:24];
        end
    end
    always_ff @(posedge clk) gold32_rdata <= gold32[w_raddr];
    always_ff @(posedge clk) if (w_en) chk("sram32_bank", {32'h0, w_rdata}, {32'h0, gold32_rdata});

    // =====================================================================
    //  2) sram8_bank -- YZ girdi RAM'i yapisi
    // =====================================================================
    localparam int B_AW    = 14;
    localparam int B_DEPTH = 9216;                  // 4 x 2048 + 1 x 1024
    logic            b_we, b_en;
    logic [B_AW-1:0] b_waddr, b_raddr;
    logic [7:0]      b_wdata, b_rdata;

    sram8_bank #(.NBANK2K(4), .HAS_1K(1), .AW(B_AW), .INIT_ZERO(1'b1)) dut8 (
        .clk(clk), .we(b_we), .re(1'b1),
        .waddr(b_waddr), .wdata(b_wdata),
        .raddr(b_raddr), .rdata(b_rdata)
    );

    logic [7:0] gold8 [0:B_DEPTH-1];
    logic [7:0] gold8_rdata;
    always_ff @(posedge clk) if (b_we) gold8[b_waddr] <= b_wdata;
    always_ff @(posedge clk) gold8_rdata <= gold8[b_raddr];
    always_ff @(posedge clk) if (b_en) chk("sram8_bank", {56'h0, b_rdata}, {56'h0, gold8_rdata});

    // =====================================================================
    //  3) + 4) mask ROM'lar
    // =====================================================================
    logic        rom_en;
    logic [7:0]  rom_addr_a, rom_addr_b;
    logic [31:0] rom_da, rom_db;
    boot_rom #(.DATA_WIDTH(32), .ADDR_WIDTH(8)) dut_boot (
        .clk(clk), .addr_a(rom_addr_a), .rdata_a(rom_da),
                   .addr_b(rom_addr_b), .rdata_b(rom_db)
    );

    logic        wp8_en;
    logic [6:0]  wp8_addr;
    logic [63:0] wp8_dout;
    weights_rom_p8 dut_wp8 (.clk(clk), .addr(wp8_addr), .dout(wp8_dout));

    logic        fcw_en;
    logic [11:0] fcw_addr;
    logic [31:0] fcw_dout;
    fc_weights_rom_p4 dut_fcw (.clk(clk), .addr(fcw_addr), .dout(fcw_dout));

    // Referans icerikler dogrudan kaynak hex'lerden okunur
    logic [31:0] ref_boot [0:255];
    logic [63:0] ref_wp8  [0:79];
    logic [31:0] ref_fcw  [0:3999];

    // ROM cikisi bir cevrim gecikmeli; beklenen adresi de bir cevrim geciktir.
    logic [7:0]  rom_a_q, rom_b_q;
    logic [6:0]  wp8_addr_q;
    logic [11:0] fcw_addr_q;
    always_ff @(posedge clk) begin
        rom_a_q <= rom_addr_a; rom_b_q <= rom_addr_b;
        wp8_addr_q <= wp8_addr; fcw_addr_q <= fcw_addr;
        if (rom_en) begin
            chk("boot_rom.a", {32'h0, rom_da}, {32'h0, ref_boot[rom_a_q]});
            chk("boot_rom.b", {32'h0, rom_db}, {32'h0, ref_boot[rom_b_q]});
        end
        if (wp8_en) chk("weights_p8",    wp8_dout,          ref_wp8[wp8_addr_q]);
        if (fcw_en) chk("fc_weights_p4", {32'h0, fcw_dout}, {32'h0, ref_fcw[fcw_addr_q]});
    end

    // =====================================================================
    int i, a;

    initial begin
        for (i = 0; i < 256;  i++) ref_boot[i] = 32'h0;
        for (i = 0; i < 4000; i++) ref_fcw[i]  = 32'h0;
        $readmemh("boot.hex",          ref_boot);
        $readmemh("weights_p8.hex",    ref_wp8);
        $readmemh("fc_weights_p4.hex", ref_fcw);
        for (i = 0; i < (1<<W_AW); i++) gold32[i] = 32'h0;
        for (i = 0; i < B_DEPTH;   i++) gold8[i]  = 8'h0;

        {w_we, w_en, w_be, w_waddr, w_wdata, w_raddr} = '0;
        {b_we, b_en, b_waddr, b_wdata, b_raddr}       = '0;
        {rom_en, rom_addr_a, rom_addr_b}              = '0;
        {wp8_en, wp8_addr, fcw_en, fcw_addr}          = '0;

        repeat (4) @(posedge clk);

        $display("\n[1/4] sram32_bank -- 4000 rastgele islem (2048 x 32, bayt-enable)");
        @(negedge clk); w_en = 1;
        for (i = 0; i < 4000; i++) begin
            w_we    = ($urandom_range(0,3) != 0);          // %75 yazma
            w_be    = 4'($urandom_range(1,15));
            w_waddr = W_AW'($urandom_range(0, (1<<W_AW)-1));
            w_wdata = $urandom;
            // Ayni cevrimde ayni adrese yazip okumak OpenRAM'de tanimsizdir
            // (bkz. sram32_bank.sv basligi); tasarimda uretilemez, testte de
            // uretilmez.
            do w_raddr = W_AW'($urandom_range(0, (1<<W_AW)-1));
            while (w_we && (w_raddr == w_waddr));
            @(negedge clk);
        end
        w_en = 0; w_we = 0;

        $display("[2/4] sram8_bank  -- 4000 rastgele islem (9216 x 8, bayt-seritli)");
        @(negedge clk); b_en = 1;
        for (i = 0; i < 4000; i++) begin
            b_we    = ($urandom_range(0,3) != 0);
            b_waddr = B_AW'($urandom_range(0, B_DEPTH-1));
            b_wdata = 8'($urandom_range(0,255));
            do b_raddr = B_AW'($urandom_range(0, B_DEPTH-1));
            while (b_we && (b_raddr == b_waddr));
            @(negedge clk);
        end
        b_en = 0; b_we = 0;

        $display("[3/4] boot_rom    -- 256 adresin tamami, iki port birden");
        @(negedge clk); rom_en = 1;
        for (a = 0; a < 256; a++) begin
            rom_addr_a = 8'(a);
            rom_addr_b = 8'(255 - a);
            @(negedge clk);
        end
        rom_en = 0;

        $display("[4/4] agirlik ROM'lari -- 80 + 4000 adresin tamami");
        @(negedge clk); wp8_en = 1;
        for (a = 0; a < 80; a++) begin wp8_addr = 7'(a); @(negedge clk); end
        wp8_en = 0;
        @(negedge clk); fcw_en = 1;
        for (a = 0; a < 4000; a++) begin fcw_addr = 12'(a); @(negedge clk); end
        fcw_en = 0;

        @(posedge clk);
        $display("\n============================================================");
        if (errors == 0)
            $display("  SONUC: BASARILI -- %0d kontrolun tamami gecti", checks);
        else
            $display("  SONUC: BASARISIZ -- %0d/%0d kontrol hatali", errors, checks);
        $display("============================================================\n");
        if (errors != 0) $fatal(1, "esdegerlik testi basarisiz");
        $finish;
    end

    initial begin
        #20_000_000;
        $fatal(1, "TIMEOUT");
    end

endmodule
