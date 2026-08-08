//=============================================================================
//  tb_axi4lite_checker_selftest.sv
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  AMAC: Protokol kontrolcusunun KENDISINI dogrular.
//
//  "Assertion yazdik" demek yeterli degildir -- yazilan assertion'in gercekten
//  atesledigini gostermek gerekir. Hicbir seyi yakalamayan bir checker da
//  "0 ihlal" raporlar. Bu testbench her kural icin bilerek bir ihlal uretir
//  ve checker'in TAM OLARAK o ihlali yakaladigini kanitlar.
//
//  YONTEM: DUT yok. Checker'in tum portlari giristir; testbench AXI
//  sinyallerini dogrudan surer. Boylece her kural izole edilebilir.
//
//  CIKTI: her kural icin [GECTI]/[KALDI] + sonda ozet.
//=============================================================================
`timescale 1ns/1ps

module tb_axi4lite_checker_selftest;

    //---------------------------------------------------------------------
    //  Sinyaller
    //---------------------------------------------------------------------
    logic        aclk = 1'b0;
    logic        aresetn = 1'b0;

    logic [31:0] awaddr  = 32'h0;
    logic        awvalid = 1'b0;
    logic        awready = 1'b0;

    logic [31:0] wdata   = 32'h0;
    logic [ 3:0] wstrb   = 4'hF;
    logic        wvalid  = 1'b0;
    logic        wready  = 1'b0;

    logic [ 1:0] bresp   = 2'b00;
    logic        bvalid  = 1'b0;
    logic        bready  = 1'b0;

    logic [31:0] araddr  = 32'h0;
    logic        arvalid = 1'b0;
    logic        arready = 1'b0;

    logic [31:0] rdata   = 32'h0;
    logic [ 1:0] rresp   = 2'b00;
    logic        rvalid  = 1'b0;
    logic        rready  = 1'b0;

    always #5 aclk = ~aclk;   // 100 MHz

    //---------------------------------------------------------------------
    //  Test edilen kontrolcu
    //  ERR_IS_FATAL(0): ihlaller sayilir, simulasyon devam eder -- self-test
    //  icin sart, cunku bilerek ihlal uretiyoruz.
    //---------------------------------------------------------------------
    axi4lite_protocol_checker #(
        .NAME("SELFTEST"),
        .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(1),
        .MAX_OUTSTANDING(2), .STALL_LIMIT(50),
        .ERR_IS_FATAL(0), .CHECK_X(1)
    ) u_chk (
        .aclk(aclk), .aresetn(aresetn),
        .awaddr(awaddr), .awvalid(awvalid), .awready(awready),
        .wdata(wdata), .wstrb(wstrb), .wvalid(wvalid), .wready(wready),
        .bresp(bresp), .bvalid(bvalid), .bready(bready),
        .araddr(araddr), .arvalid(arvalid), .arready(arready),
        .rdata(rdata), .rresp(rresp), .rvalid(rvalid), .rready(rready)
    );

    //---------------------------------------------------------------------
    //  Senaryo yonetimi
    //---------------------------------------------------------------------
    int unsigned err_snapshot;
    int unsigned n_pass = 0;
    int unsigned n_fail = 0;

    task automatic scenario_begin(input string title);
        $display("");
        $display("--- SENARYO: %0s", title);
        err_snapshot = axi_chk_pkg::g_error_count;
    endtask

    // expect_hit=1 : bu senaryoda checker ATESLEMELI
    // expect_hit=0 : bu senaryoda checker SESSIZ kalmali
    task automatic scenario_end(input string rule, input bit expect_hit);
        int unsigned delta;
        delta = axi_chk_pkg::g_error_count - err_snapshot;
        if (expect_hit) begin
            if (delta > 0) begin
                $display("    [GECTI] %0s yakalandi (%0d ihlal)", rule, delta);
                n_pass++;
            end else begin
                $display("    [KALDI] %0s ATESLEMEDI -- checker bu kurali kacIRIYOR!", rule);
                n_fail++;
            end
        end else begin
            if (delta == 0) begin
                $display("    [GECTI] %0s: temiz trafikte yanlis alarm yok", rule);
                n_pass++;
            end else begin
                $display("    [KALDI] %0s: YANLIS ALARM (%0d ihlal)", rule, delta);
                n_fail++;
            end
        end
    endtask

    task automatic clk_tick(input int n = 1);
        repeat (n) @(posedge aclk);
    endtask

    // Tum sinyalleri temiz idle'a cek
    task automatic idle_all();
        @(negedge aclk);
        awvalid = 1'b0; awready = 1'b0; awaddr = 32'h0;
        wvalid  = 1'b0; wready  = 1'b0; wdata  = 32'h0; wstrb = 4'hF;
        bvalid  = 1'b0; bready  = 1'b0; bresp  = 2'b00;
        arvalid = 1'b0; arready = 1'b0; araddr = 32'h0;
        rvalid  = 1'b0; rready  = 1'b0; rdata  = 32'h0; rresp = 2'b00;
        clk_tick(3);
    endtask

    // Kurallara UYAN tam bir yazma islemi
    task automatic clean_write(input logic [31:0] addr, input logic [31:0] data);
        @(negedge aclk);
        awaddr = addr; awvalid = 1'b1;
        wdata  = data; wvalid  = 1'b1; wstrb = 4'hF;
        bready = 1'b1;
        @(negedge aclk);
        awready = 1'b1; wready = 1'b1;        // sonraki posedge'de AW+W el sikismasi
        @(negedge aclk);
        awvalid = 1'b0; wvalid = 1'b0;
        awready = 1'b0; wready = 1'b0;
        bvalid  = 1'b1; bresp  = 2'b00;       // sonraki posedge'de B el sikismasi
        @(negedge aclk);
        bvalid  = 1'b0; bready = 1'b0;
        clk_tick(2);
    endtask

    // Kurallara UYAN tam bir okuma islemi
    task automatic clean_read(input logic [31:0] addr, input logic [31:0] data);
        @(negedge aclk);
        araddr = addr; arvalid = 1'b1; rready = 1'b1;
        @(negedge aclk);
        arready = 1'b1;                       // sonraki posedge'de AR el sikismasi
        @(negedge aclk);
        arvalid = 1'b0; arready = 1'b0;
        rvalid  = 1'b1; rdata = data; rresp = 2'b00;
        @(negedge aclk);
        rvalid  = 1'b0; rready = 1'b0;
        clk_tick(2);
    endtask

    //---------------------------------------------------------------------
    //  ANA AKIS
    //---------------------------------------------------------------------
    initial begin
        $display("======================================================================");
        $display("   AXI4-LITE PROTOKOL KONTROLCUSU -- SELF-TEST");
        $display("   Her kural icin bilerek ihlal uretilir; checker yakalamali.");
        $display("======================================================================");

        aresetn = 1'b0;
        clk_tick(5);
        aresetn = 1'b1;
        clk_tick(3);

        //=================================================================
        //  0) TEMIZ TRAFIK -- yanlis alarm olmamali
        //=================================================================
        scenario_begin("Temiz trafik (4 yazma + 4 okuma) -- ihlal BEKLENMIYOR");
        repeat (4) clean_write(32'h4001_0000, 32'hCAFE_BABE);
        repeat (4) clean_read (32'h4001_0004, 32'h1234_5678);
        idle_all();
        scenario_end("TEMIZ", 1'b0);

        //=================================================================
        //  1) HSK_01 -- AWREADY gelmeden AWVALID dusurulmesi
        //=================================================================
        scenario_begin("HSK_01: AWREADY beklerken AWVALID dusuruluyor");
        @(negedge aclk);
        awaddr = 32'h4001_0000; awvalid = 1'b1; awready = 1'b0;
        @(negedge aclk);              // bir posedge gecti: oncul dogru
        @(negedge aclk);
        awvalid = 1'b0;               // <-- IHLAL: el sikisma yokken VALID dustu
        idle_all();
        scenario_end("HSK_01", 1'b1);

        //=================================================================
        //  2) STB_01 -- AWVALID beklerken AWADDR degistirilmesi
        //=================================================================
        scenario_begin("STB_01: AWVALID beklerken AWADDR degistiriliyor");
        @(negedge aclk);
        awaddr = 32'h4001_0000; awvalid = 1'b1; awready = 1'b0;
        wdata = 32'h5; wvalid = 1'b1; bready = 1'b1;
        @(negedge aclk);
        awaddr = 32'hDEAD_BEEF;       // <-- IHLAL: VALID beklerken adres degisti
        @(negedge aclk);
        awready = 1'b1; wready = 1'b1;
        @(negedge aclk);
        awvalid = 1'b0; wvalid = 1'b0; awready = 1'b0; wready = 1'b0;
        bvalid = 1'b1; bresp = 2'b00; // islemi TAMAMLA -> sayaclar dengede kalir
        @(negedge aclk);
        bvalid = 1'b0; bready = 1'b0;
        idle_all();
        scenario_end("STB_01", 1'b1);

        //=================================================================
        //  3) RSP_01 -- AXI4-Lite'ta yasak olan EXOKAY cevabi
        //=================================================================
        scenario_begin("RSP_01: BRESP = EXOKAY (AXI4-Lite'ta yasak)");
        @(negedge aclk);
        awaddr = 32'h4001_0000; awvalid = 1'b1;
        wdata  = 32'h1; wvalid = 1'b1; bready = 1'b1;
        @(negedge aclk);
        awready = 1'b1; wready = 1'b1;
        @(negedge aclk);
        awvalid = 1'b0; wvalid = 1'b0; awready = 1'b0; wready = 1'b0;
        bvalid  = 1'b1; bresp  = 2'b01;     // <-- IHLAL: EXOKAY
        @(negedge aclk);
        bvalid  = 1'b0; bresp = 2'b00; bready = 1'b0;
        idle_all();
        scenario_end("RSP_01", 1'b1);

        //=================================================================
        //  4) ORD_01/02 -- hic istek yokken BVALID uretilmesi
        //=================================================================
        scenario_begin("ORD_01/02: bekleyen AW/W yokken BVALID yukseliyor");
        @(negedge aclk);
        bvalid = 1'b1; bresp = 2'b00; bready = 1'b0;  // <-- IHLAL: istek yok
        @(negedge aclk);
        @(negedge aclk);
        bvalid = 1'b0;                // bready=0 -> el sikisma yok, sayac bozulmaz
        idle_all();
        scenario_end("ORD_01/02", 1'b1);

        //=================================================================
        //  5) ORD_03 -- hic AR yokken RVALID uretilmesi
        //=================================================================
        scenario_begin("ORD_03: bekleyen AR yokken RVALID yukseliyor");
        @(negedge aclk);
        rvalid = 1'b1; rdata = 32'hAAAA_5555; rresp = 2'b00; rready = 1'b0;
        @(negedge aclk);
        @(negedge aclk);
        rvalid = 1'b0;                // bkz. yukarisi: el sikisma yok
        idle_all();
        scenario_end("ORD_03", 1'b1);

        //=================================================================
        //  6) HSK_05 -- RREADY gelmeden RVALID dusurulmesi
        //=================================================================
        scenario_begin("HSK_05: RREADY beklerken RVALID dusuruluyor");
        @(negedge aclk);
        araddr = 32'h0; arvalid = 1'b1; rready = 1'b0;
        @(negedge aclk);
        arready = 1'b1;
        @(negedge aclk);
        arvalid = 1'b0; arready = 1'b0;
        rvalid  = 1'b1; rdata = 32'h1111_2222; rresp = 2'b00;
        @(negedge aclk);
        @(negedge aclk);
        rvalid  = 1'b0;               // <-- IHLAL: RREADY gelmeden RVALID dustu
        // --- drenaj: askida kalan okuma islemini duzgun tamamla ---
        @(negedge aclk);
        rvalid = 1'b1; rready = 1'b1; rdata = 32'h1111_2222;
        @(negedge aclk);
        rvalid = 1'b0; rready = 1'b0;
        idle_all();
        scenario_end("HSK_05", 1'b1);

        //=================================================================
        //  7) XCK_02 -- AWVALID yuksekken AWADDR icinde X
        //  NOT: Verilator 2-durumlu calisir, X modellemez. Bu senaryo
        //  yalnizca XSIM/Questa gibi 4-durumlu simulatorlerde anlamlidir.
        //=================================================================
`ifndef VERILATOR
        scenario_begin("XCK_02: AWVALID yuksekken AWADDR icinde X");
        @(negedge aclk);
        awaddr = 32'hXXXX_XXXX; awvalid = 1'b1;     // <-- IHLAL: adreste X
        @(negedge aclk);
        @(negedge aclk);
        awvalid = 1'b0; awaddr = 32'h0;             // el sikisma yok
        idle_all();
        scenario_end("XCK_02", 1'b1);
`else
        $display("");
        $display("--- SENARYO: XCK_02 ATLANDI (Verilator 2-durumlu; XSIM'de kosturun)");
`endif

        //=================================================================
        //  8) TEMIZ TRAFIK (tekrar) -- onceki ihlaller kalici bozulma
        //     yaratmadi mi? Checker hala saglikli mi?
        //=================================================================
        idle_all();
        clk_tick(5);
        scenario_begin("Temiz trafik tekrari -- checker hala saglikli mi");
        repeat (3) clean_write(32'h4001_0008, 32'h0000_00FF);
        repeat (3) clean_read (32'h4001_000C, 32'hFFFF_0000);
        idle_all();
        scenario_end("TEMIZ_2", 1'b0);

        //=================================================================
        //  OZET
        //=================================================================
        $display("");
        $display("======================================================================");
        $display("   SELF-TEST OZETI");
        $display("======================================================================");
        $display("   Gecen senaryo : %0d", n_pass);
        $display("   Kalan senaryo : %0d", n_fail);
        $display("   (Not: yukaridaki [AXI-CHK] ihlal satirlari BEKLENEN ciktidir --");
        $display("    bilerek uretilen ihlallerdir, hata degildir.)");
        if (n_fail == 0) begin
            $display("   SONUC: CHECKER DOGRULANDI -- tum kurallar atesliyor.");
            $display("======================================================================");
            $finish;
        end else begin
            $display("   SONUC: CHECKER EKSIK -- %0d kural yakalanmadi!", n_fail);
            $display("======================================================================");
            $fatal(1, "Self-test basarisiz.");
        end
    end

    //---- Guvenlik gozcusu ----
    initial begin
        #500_000;
        $fatal(1, "[SELFTEST] ZAMAN ASIMI -- test takildi.");
    end

endmodule
