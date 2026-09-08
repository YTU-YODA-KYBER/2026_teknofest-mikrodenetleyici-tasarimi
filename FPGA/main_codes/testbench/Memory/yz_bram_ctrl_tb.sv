// =====================================================================
//  yz_bram_ctrl_tb.sv  --  YZ girdi RAM kontrolcusu, yonlendirilmis test
//
//  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi
//
//  ---------------------------------------------------------------
//  NE DOGRULANIYOR
//  ---------------------------------------------------------------
//  yz_acclrtr_bram_axi_ctrl, UART_YZ'den DMA ile gelen baytlari girdi
//  RAM'ine yazar ve 1960. baytta CPU'ya seviye kesme kaldirir. Kritik
//  davranis, yazma sayacinin KENDINI TOPARLAYABILMESIDIR:
//
//    Demo test harness'i 'truncated_frame' senaryosunda 1960 yerine 1896
//    bayt, 'oversized_frame' senaryosunda ise 1960 + 32 bayt gonderir.
//    Sayac yalnizca 1960'ta sifirlansa bu kayma KALICI olurdu -- o andan
//    sonra her cikarim kaymis bir pencere uzerinde yapilir ve tek cikis
//    yolu karti resetlemek olurdu. Demo dokumani adim 5 tam bunu yasaklar.
//
//  Kurtarma bosta kalma sayacindadir: hat IDLE_LIMIT cevrim boyunca sessiz
//  kalirsa yarim kalan kayit atilir ve sonraki cerceve yeniden hizalanir.
//
//  TESTLER
//    1  Tam cerceve  : 1960 bayt -> IRQ, sayac basa doner, veri RAM'de
//    2  cpu_clear_i  : seviye kesme yalnizca CPU temizleyince duser
//    3  Kesik cerceve: 1896 bayt sonrasi bosta kalma -> sayac sifirlanir
//    4  Kurtarma     : kesikten sonraki TAM cerceve dogru hizalanir
//    5  Fazla bayt   : 1960 + 32 sonrasi bosta kalma -> sayac sifirlanir
//    6  Erken susma  : esik ALTINDA susmak cerceveyi BOZMAMALI
//
//  Test 6 sinir kosuludur: esik cok kucuk secilirse cerceve ortasindaki
//  normal bayt araliklari yanlislikla "cerceve bitti" sayilir ve tasarim
//  hicbir vektoru dogru okuyamaz. Bu yuzden hem tetiklenmesi hem de
//  ERKEN tetiklenmemesi test edilir.
//
//  Kosum (Vivado gerektirmez):
//    iverilog -g2012 -o tb.out \
//        rtl/desgin_sources/Memory/BRAM_defines/bram_yz_def.sv \
//        rtl/desgin_sources/Memory/YZ_RAM_AXI4-Lite/yz_bram_axi_ctrl.sv \
//        testbench/Memory/yz_bram_ctrl_tb.sv
//    vvp tb.out
// =====================================================================
`timescale 1ns / 1ps

module yz_bram_ctrl_tb;

    localparam int DATA_WIDTH = 8;
    localparam int ADDR_WIDTH = 14;
    localparam int DEPTH      = 9904;
    localparam int N_BYTES    = 1960;

    //  Gercek tasarimda 100.000 (50 MHz'de 2 ms). Burada simulasyon suresi
    //  makul kalsin diye kisaltildi; dogrulanan MANTIK ayni, yalnizca esik
    //  olceklenir. Testler bu parametreye gore yazilmistir, sabit sayiya
    //  gore degil.
    localparam int IDLE_LIMIT  = 200;

    logic clk = 1'b0;
    logic rst_n = 1'b0;
    always #5 clk = ~clk;               // 100 MHz -> 10 ns periyot

    logic [ADDR_WIDTH-1:0] raddr = '0;
    logic [DATA_WIDTH-1:0] rdata;
    logic                  dma_valid = 1'b0;
    logic [DATA_WIDTH-1:0] dma_data  = '0;
    logic                  cpu_clear = 1'b0;
    logic                  irq;

    int unsigned n_pass = 0;
    int unsigned n_fail = 0;

    yz_acclrtr_bram_axi_ctrl #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .DEPTH     (DEPTH),
        .IDLE_LIMIT(IDLE_LIMIT)
    ) dut (
        .clk_i        (clk),
        .rst_n        (rst_n),
        .yz_bram_raddr(raddr),
        .yz_bram_rdata(rdata),
        .dma_valid_i  (dma_valid),
        .dma_data_i   (dma_data),
        .cpu_clear_i  (cpu_clear),
        .load_done_irq(irq)
    );

    task automatic kontrol(input string ad, input int bekleneni, input int okunan);
        begin
            if (bekleneni === okunan) begin
                $display("  [GECTI] %0s", ad);
                n_pass++;
            end else begin
                $display("  [KALDI] %0s: beklenen %0d, okunan %0d",
                         ad, bekleneni, okunan);
                n_fail++;
            end
        end
    endtask

    //  Tek bayt sur: dma_valid_i bir cevrim yuksek kalir (UART_YZ'nin
    //  dma_valid_o darbesiyle ayni sekil).
    task automatic bayt_gonder(input logic [7:0] b);
        begin
            @(negedge clk);
            dma_data  = b;
            dma_valid = 1'b1;
            @(negedge clk);
            dma_valid = 1'b0;
        end
    endtask

    //  n bayt gonder; icerik adresten turetilir ki hizalama kaymasi
    //  okunan veriden anlasilabilsin.
    task automatic cerceve_gonder(input int n, input int ofset = 0);
        int i;
        begin
            for (i = 0; i < n; i++) bayt_gonder((i + ofset) & 8'hFF);
        end
    endtask

    task automatic bosta_bekle(input int cevrim);
        begin
            repeat (cevrim) @(posedge clk);
        end
    endtask

    task automatic ram_oku(input int adr, output logic [7:0] v);
        begin
            @(negedge clk);
            raddr = adr[ADDR_WIDTH-1:0];
            @(posedge clk);       // BRAM okumasi kayitli
            @(negedge clk);
            v = rdata;
        end
    endtask

    logic [7:0] v;

    initial begin
        $display("======================================================================");
        $display("   YZ GIRDI RAM KONTROLCUSU -- CERCEVE SENKRONIZASYON TESTI");
        $display("   IDLE_LIMIT = %0d cevrim", IDLE_LIMIT);
        $display("======================================================================");

        repeat (5) @(posedge clk);
        rst_n = 1'b1;
        repeat (5) @(posedge clk);

        // =============================================================
        //  TEST 1: Tam cerceve -> IRQ + sayac basa doner
        // =============================================================
        $display("\n--- TEST 1: tam cerceve (%0d bayt) ---", N_BYTES);
        cerceve_gonder(N_BYTES);
        @(posedge clk);
        kontrol("1a IRQ kalkti",          1, irq);
        kontrol("1b sayac basa dondu",    0, dut.addr_cnt);

        ram_oku(0,    v); kontrol("1c RAM[0]",    8'h00, v);
        ram_oku(1959, v); kontrol("1d RAM[1959]", (1959 & 8'hFF), v);

        // =============================================================
        //  TEST 2: Seviye kesme yalnizca cpu_clear_i ile duser
        // =============================================================
        $display("\n--- TEST 2: kesme temizleme ---");
        bosta_bekle(20);
        kontrol("2a IRQ hala yuksek", 1, irq);
        @(negedge clk); cpu_clear = 1'b1;
        @(negedge clk); cpu_clear = 1'b0;
        @(posedge clk);
        kontrol("2b cpu_clear sonrasi IRQ dustu", 0, irq);

        // =============================================================
        //  TEST 3: Kesik cerceve + bosta kalma -> sayac sifirlanir
        //          (demo harness 'truncated_frame': 64 bayt eksik)
        // =============================================================
        $display("\n--- TEST 3: kesik cerceve (%0d bayt) ---", N_BYTES - 64);
        cerceve_gonder(N_BYTES - 64);
        @(posedge clk);
        kontrol("3a sayac ortada kaldi", N_BYTES - 64, dut.addr_cnt);
        kontrol("3b IRQ kalkmadi",       0, irq);

        bosta_bekle(IDLE_LIMIT + 10);
        kontrol("3c bosta kalma sonrasi sayac sifirlandi", 0, dut.addr_cnt);
        kontrol("3d IRQ hala dusuk",                       0, irq);

        // =============================================================
        //  TEST 4: KURTARMA -- kesikten sonraki tam cerceve hizali mi
        //          Ofset 100 ile gonderiyoruz: eski kayma surseydi
        //          RAM[0] eski cercevenin baytini tutardi.
        // =============================================================
        $display("\n--- TEST 4: kesik cerceve sonrasi kurtarma ---");
        cerceve_gonder(N_BYTES, 100);
        @(posedge clk);
        kontrol("4a IRQ kalkti",       1, irq);
        kontrol("4b sayac basa dondu", 0, dut.addr_cnt);
        ram_oku(0,    v); kontrol("4c RAM[0] yeni cerceveden",    8'd100, v);
        ram_oku(1959, v); kontrol("4d RAM[1959] yeni cerceveden", ((1959 + 100) & 8'hFF), v);

        @(negedge clk); cpu_clear = 1'b1;
        @(negedge clk); cpu_clear = 1'b0;

        // =============================================================
        //  TEST 5: Fazla bayt + bosta kalma -> sayac sifirlanir
        //          (demo harness 'oversized_frame': 32 fazla bayt)
        // =============================================================
        $display("\n--- TEST 5: fazladan bayt (%0d + 32) ---", N_BYTES);
        cerceve_gonder(N_BYTES);
        @(posedge clk);
        kontrol("5a tam cerceve IRQ kaldirdi", 1, irq);
        @(negedge clk); cpu_clear = 1'b1;
        @(negedge clk); cpu_clear = 1'b0;

        cerceve_gonder(32);                       // artik baytlar
        @(posedge clk);
        kontrol("5b artik baytlar sayaci ilerletti", 32, dut.addr_cnt);

        bosta_bekle(IDLE_LIMIT + 10);
        kontrol("5c bosta kalma sonrasi sayac sifirlandi", 0, dut.addr_cnt);

        //  Ve sonraki cerceve yine hizali
        cerceve_gonder(N_BYTES, 55);
        @(posedge clk);
        kontrol("5d sonraki cerceve IRQ kaldirdi", 1, irq);
        ram_oku(0, v); kontrol("5e RAM[0] hizali", 8'd55, v);
        @(negedge clk); cpu_clear = 1'b1;
        @(negedge clk); cpu_clear = 1'b0;

        // =============================================================
        //  TEST 6: SINIR -- esik ALTINDA susmak cerceveyi bozmamali
        //  Gercek sistemde cerceve ici bayt araligi bir bayt suresidir
        //  (1 Mbps'te 10 us); esik bunun cok ustundedir. Burada esigin
        //  hemen altinda bir duraklama verip sayacin KORUNDUGUNU
        //  dogruluyoruz -- yoksa hicbir vektor dogru okunamazdi.
        // =============================================================
        $display("\n--- TEST 6: esik altinda duraklama cerceveyi bozmamali ---");
        cerceve_gonder(1000);
        bosta_bekle(IDLE_LIMIT - 20);             // esigin ALTINDA
        kontrol("6a sayac korundu", 1000, dut.addr_cnt);

        cerceve_gonder(N_BYTES - 1000, 0);        // cerceveyi tamamla
        @(posedge clk);
        kontrol("6b cerceve tamamlandi, IRQ kalkti", 1, irq);
        kontrol("6c sayac basa dondu",               0, dut.addr_cnt);

        // ---- Ozet ----
        $display("\n======================================================================");
        $display("   OZET: %0d gecti, %0d kaldi", n_pass, n_fail);
        $display("======================================================================");
        if (n_fail != 0)
            $fatal(1, "[TB] %0d kontrol basarisiz.", n_fail);
        $display("[TB] >>> CERCEVE SENKRONIZASYON TESTI: BASARILI <<<");
        $finish;
    end

    //  Watchdog: takilma bir BASARISIZLIKTIR, sessizce beklenmez.
    initial begin
        #20_000_000;
        $fatal(1, "[TB] Global zaman asimi.");
    end

endmodule
