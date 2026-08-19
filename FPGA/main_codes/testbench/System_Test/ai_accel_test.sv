// =====================================================================
//  yz_accel_test.sv  --  YZ Hizlandirici Sistem Seviyesi Testi
//
//  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi
//
//  ---------------------------------------------------------------
//  SARTNAME KARSILIGI
//  ---------------------------------------------------------------
//   Madde 5.2-3 (ZORUNLU): "Cevre birimleri ve YZ hizlandiricinin
//     AXI/AXI-Lite arayuzlerinin en azindan protocol check duzeyinde
//     dogrulanmasi."
//     -> axi4lite_bind.svh ile 15 arayuz izlenir. Bu test, YZ_ACCEL
//        (yz_csr_wrapper) arayuzune trafik ureten TEK testtir;
//        boot_test o arayuze hic dokunmaz.
//
//   Madde 5.2-4 (ZORUNLU): "YZ hizlandiricinin en az bir test
//     senaryosuyla dogrulanmis olmasi."
//     -> 3 sinif (yes / no / sessizlik), self-checking, $fatal'li.
//
//   Tablo 3-1 "Sistem performansi":
//     -> Hizlandirici start->done cevrim sayisi ve sentezlenmis
//        frekansta cikarim/saniye otomatik raporlanir.
//
//   EK-1 "%10 dogruluk penceresi":
//     -> CHECK_SCORES=1 iken 4 FC skoru altin referansla bit-exact
//        karsilastirilir. Sadece argmax kontrolu requantization
//        (M0/SHR) hatalarini KACIRIR; skorlar kacirmaz.
//
// =====================================================================
`timescale 1ns / 1ps

`include "axi4lite_bind.svh"

module ai_accel_test;

    // =================================================================
    //  1) SAAT VE BAUD
    // =================================================================
    //  CLK_HALF=10 ns  ->  20 ns periyot  ->  50 MHz. Sistem saati budur
    //  (clk_wiz_0: 100 MHz x 10 / 20, bkz. CLAUDE.md).
    //  DUZELTME: burada eskiden "48e6 / 115200" yaziyordu ve asagidaki
    //  performans matematigi de 48 MHz varsayiyordu -- eski bir tasarimdan
    //  kalinti. Bolen dogruydu (50e6/434 = 115207 baud, %0.006 hata) ama
    //  raporlanan us/cikarim-per-saniye degerleri %4 yanlisti.
    localparam real CLK_HALF     = 10;
    localparam real CLK_FREQ_HZ  = 50.0e6;
    localparam int  CLKS_PER_BIT = 434;       // 50e6 / 115200 = 434.03

    // =================================================================
    //  2) TEST VEKTORLERI
    // =================================================================
    localparam int N_BYTES  = 1960;
    localparam int N_TESTS  = 3;

    //  Sinif indeksleri (conv_accelerator out_ram_wdata):
    //    0 = sessizlik, 1 = bilinmeyen, 2 = evet, 3 = hayir
    //  GPIO_ODR degerleri app'in 7-segment eslemesidir.
    typedef struct {
        string       hex_file;
        int          exp_class;    // conv_accelerator cikisi
        int          exp_odr;      // GPIO_ODR[15:0]
        string       label;
    } test_vec_t;

    test_vec_t tests [N_TESTS] = '{
        '{"input_data_yes.hex",       2, 7, "EVET"      },
        '{"input_data_no.hex",        3, 8, "HAYIR"     },
        '{"input_data_sessizlik.hex", 0, 9, "SESSIZLIK" }
    };

    // ---- Altin FC skorlari ----------------------------------------
    //  Argmax dogru cikan ama skorlari kaymis bir hizlandirici (yanlis
    //  M0/SHR, bozuk requantization, kayan pipeline) yalnizca burada
    //  yakalanir. Bu yuzden optimizasyon calismalarinda ZORUNLU aciktir.
    //
    //  KAYNAK VE KAPSAM -- dikkat:
    //    Bu degerler, hizlandiricinin OPTIMIZASYON ONCESI (v1) surumu
    //    bagimsiz bir Icarus Verilog kosumunda calistirilarak alindi
    //    (2026-07-31). Yani "donanimin o gunku davranisi"nin dondurulmus
    //    halidir ve REGRESYON KORUMASI icin birebir dogru referanstir:
    //    conv_accelerator v2 (pipeline + paralel datapath) bu tabloyu
    //    bit-exact gecmistir.
    //
    //    ANCAK bunlar TFLite referans modelinden BAGIMSIZ olarak
    //    uretilmemistir. Yani "RTL, egitilmis modelle ayni sayilari
    //    uretiyor mu?" sorusunu kanitlamazlar -- sadece "RTL, dun ne
    //    uretiyorduysa bugun de onu uretiyor mu?" sorusunu kanitlarlar.
    //    EK-1'deki "%10 dogruluk penceresi" isteri icin TFLite'tan
    //    bagimsiz altin deger uretilmesi hala yapilacaklar listesindedir.
    localparam bit CHECK_SCORES = 1;
    localparam int EXP_SCORES [N_TESTS][4] = '{
        '{-58032,  21583,  48674,  -4777},   // yes        -> argmax = 2
        '{-30588,   7509,   7419,  18543},   // no         -> argmax = 3
        '{    427,  -518,    -94,    186}    // sessizlik  -> argmax = 0
    };

    // ---- Zamanlama ----
    localparam int DMA_EN_BIT     = 1;             // SW1: uart_mux select + dma_enable
    localparam int TEST_TIMEOUT   = 400_000_000;   // tek test icin ust sinir (ns)
    localparam int GLOBAL_TIMEOUT = 1_500_000_000; // tum kosum icin ust sinir (ns)

    // =================================================================
    //  3) SINYALLER
    // =================================================================
    logic        clk_i    = 1'b0;
    logic        rst_ni   = 1'b0;
    logic        UART_RX  = 1'b1;      // idle-high
    logic        UART_TX;
    logic [31:0] GPIO_IDR = 32'h0;
    logic [31:0] GPIO_ODR;
    logic [ 7:0] anode, catode;

    wire I2C_SCL, I2C_SDA;
    pullup(I2C_SDA);                   // I2C idle-high
    pullup(I2C_SCL);
    wire QSPI_SCLK, QSPI_CS, QSPI_IO0, QSPI_IO1, QSPI_IO2, QSPI_IO3;

    always #(CLK_HALF) clk_i = ~clk_i;

    // =================================================================
    //  4) DUT
    // =================================================================
    top_module #(
        .INIT_FILE_boot("sim_app.hex")
    ) dut 
    (
        .clk_i    (clk_i),   .rst_ni   (rst_ni),
        .GPIO_IDR (GPIO_IDR),.GPIO_ODR (GPIO_ODR),
        .anode    (anode),   .catode   (catode),
        .UART_TX  (UART_TX), .UART_RX  (UART_RX),
        .I2C_SCL  (I2C_SCL), .I2C_SDA  (I2C_SDA),
        .QSPI_SCLK(QSPI_SCLK), .QSPI_CS (QSPI_CS),
        .QSPI_IO0 (QSPI_IO0), .QSPI_IO1(QSPI_IO1),
        .QSPI_IO2 (QSPI_IO2), .QSPI_IO3(QSPI_IO3)
    );

    // =================================================================
    //  5) SONUC TAKIBI
    // =================================================================
    int unsigned n_pass = 0;
    int unsigned n_fail = 0;
    logic [7:0]  audio [0:N_BYTES-1];

    // Cevrim sayaci -- performans olcumu icin
    longint unsigned cyc = 0;
    always @(posedge clk_i) if (rst_ni) cyc <= cyc + 1;

    longint unsigned t_start_cyc, t_done_cyc;
    longint unsigned perf_cycles [N_TESTS];
    bit              accel_started, accel_finished;
    int              observed_class;

    // Hizlandirici start/done yakalama
    always @(posedge clk_i) begin
        if (dut.conv_accelerator_inst.start && !accel_started) begin
            t_start_cyc   <= cyc;
            accel_started <= 1'b1;
            $display("[P3] t=%0t  ACCEL START", $time);
        end
        if (dut.conv_accelerator_inst.done && !accel_finished) begin
            t_done_cyc     <= cyc;
            accel_finished <= 1'b1;
            observed_class <= dut.conv_accelerator_inst.out_ram_wdata;
            $display("[P4] t=%0t  ACCEL DONE, sinif=%0d", $time,
                     dut.conv_accelerator_inst.out_ram_wdata);
        end
    end

    always @(posedge dut.yz_bram_ctrl_inst.load_done_irq)
        $display("[P2] t=%0t  LOAD_DONE (addr_cnt=%0d)", $time,
                 dut.yz_bram_ctrl_inst.addr_cnt);

    always @(posedge dut.yz_csr_wrapper_inst.infer_irq)
        $display("[P5] t=%0t  INFER_IRQ -> CPU", $time);

    // =================================================================
    //  6) UART GONDERME
    // =================================================================
    task automatic uart_send_byte(input logic [7:0] b);
        int i;
        begin
            UART_RX = 1'b0;                        // start
            repeat (CLKS_PER_BIT) @(posedge clk_i);
            for (i = 0; i < 8; i++) begin          // 8 veri biti, LSB once
                UART_RX = b[i];
                repeat (CLKS_PER_BIT) @(posedge clk_i);
            end
            UART_RX = 1'b1;                        // stop
            repeat (CLKS_PER_BIT) @(posedge clk_i);
        end
    endtask

    // =================================================================
    //  7) TEK CIKARIM KOSUMU  (self-checking)
    // =================================================================
    task automatic run_inference(input int idx);
        int  k, s;
        bit  timed_out;
        bit  scores_ok;
        longint unsigned lat;
        real  inf_per_sec;
        begin
            $display("");
            $display("======================================================================");
            $display(" TEST %0d/%0d : %0s   (%0s)", idx+1, N_TESTS,
                     tests[idx].label, tests[idx].hex_file);
            $display("======================================================================");

            // ---- TB tarafi durum sifirlama (DUT resetlenmez!) ----
            //  Uygulama kesme guduml­udur ve for(;;) icinde bekler; ard arda
            //  cikarim yapabilmesi icin CPU'yu her testte resetlemeye gerek
            //  yok. Ama bu bayraklar temizlenmezse 2. ve 3. test, 1. testin
            //  accel_finished/observed_class degerlerini gorup aninda "gecti"
            //  der -- yani sessizce yanlis sonuc uretirdi.
            accel_started  = 1'b0;
            accel_finished = 1'b0;
            observed_class = -1;
            UART_RX        = 1'b1;

            // ---- ses verisini yukle ----
            for (k = 0; k < N_BYTES; k++) audio[k] = 8'h00;
            $readmemh(tests[idx].hex_file, audio);

            // Bos dosya kontrolu: $readmemh eksik dosyada SESSIZCE gecer.
            // Bu kontrol olmadan test "calisiyor" gorunup cop veri isler.
            if (audio[0] === 8'hxx) begin
                $display("[HATA] %0s okunamadi veya bos -- dosya yolunu kontrol edin",
                         tests[idx].hex_file);
                n_fail++;
                return;
            end

            // ---- DMA + uart_mux'u YZ tarafina al ----
            GPIO_IDR[DMA_EN_BIT] = 1'b1;
            repeat (20) @(posedge clk_i);

            // ---- 1960 bayt gonder ----
            $display("[TB] %0d bayt gonderiliyor...", N_BYTES);
            for (k = 0; k < N_BYTES; k++) begin
                uart_send_byte(audio[k]);
                if ((k % 500) == 0 && k != 0)
                    $display("[TB]   %0d/%0d bayt", k, N_BYTES);
            end
            $display("[TB] Gonderim tamam, cikarim bekleniyor...");

            // ---- sonuc bekle (zaman asimi korumali) ----
            timed_out = 1'b0;
            fork
                begin : wait_result
                    wait (GPIO_ODR[15:0] == tests[idx].exp_odr || accel_finished);
                    repeat (200) @(posedge clk_i);   // ODR yerlesene kadar
                end
                begin : wait_timeout
                    #(TEST_TIMEOUT);
                    timed_out = 1'b1;
                end
            join_any
            disable fork;

            // =========================================================
            //  KONTROLLER
            // =========================================================
            if (timed_out) begin
                $display("[KALDI] %0s: ZAMAN ASIMI. GPIO_ODR=%0d (beklenen %0d), accel_done=%0b",
                         tests[idx].label, GPIO_ODR[15:0], tests[idx].exp_odr, accel_finished);
                n_fail++;
                return;
            end

            // 1) Hizlandirici sinif cikisi
            if (observed_class !== tests[idx].exp_class) begin
                $display("[KALDI] %0s: hizlandirici sinifi=%0d, beklenen=%0d",
                         tests[idx].label, observed_class, tests[idx].exp_class);
                n_fail++;
                return;
            end

            // 2) GPIO_ODR (7-segment) -- uctan uca yol dogru mu
            if (GPIO_ODR[15:0] !== tests[idx].exp_odr) begin
                $display("[KALDI] %0s: GPIO_ODR=%0d, beklenen=%0d",
                         tests[idx].label, GPIO_ODR[15:0], tests[idx].exp_odr);
                n_fail++;
                return;
            end

            // 3) FC skorlari (opsiyonel, ama requantization hatalarini
            //    yakalayan TEK kontrol budur)
            scores_ok = 1'b1;
            $display("[P6] FC_SCORES: [0]=%0d [1]=%0d [2]=%0d [3]=%0d",
                     $signed(dut.conv_accelerator_inst.fc_scores[0]),
                     $signed(dut.conv_accelerator_inst.fc_scores[1]),
                     $signed(dut.conv_accelerator_inst.fc_scores[2]),
                     $signed(dut.conv_accelerator_inst.fc_scores[3]));
            if (CHECK_SCORES) begin
                for (s = 0; s < 4; s++) begin
                    if ($signed(dut.conv_accelerator_inst.fc_scores[s]) !== EXP_SCORES[idx][s]) begin
                        $display("[KALDI] %0s: fc_scores[%0d]=%0d, beklenen=%0d",
                                 tests[idx].label, s,
                                 $signed(dut.conv_accelerator_inst.fc_scores[s]),
                                 EXP_SCORES[idx][s]);
                        scores_ok = 1'b0;
                    end
                end
                if (!scores_ok) begin n_fail++; return; end
            end

            // =========================================================
            //  PERFORMANS  (Tablo 3-1 "Sistem performansi")
            // =========================================================
            lat = t_done_cyc - t_start_cyc;
            perf_cycles[idx] = lat;
            inf_per_sec = CLK_FREQ_HZ / real'(lat);
            $display("[PERF] %0s: cikarim gecikmesi = %0d cevrim  |  @%0.0f MHz = %0.1f us  |  %0.1f cikarim/s",
                     tests[idx].label, lat, CLK_FREQ_HZ / 1.0e6,
                     real'(lat) / (CLK_FREQ_HZ / 1.0e6), inf_per_sec);

            $display("[GECTI] %0s: sinif=%0d, GPIO_ODR=%0d, %0d cevrim",
                     tests[idx].label, observed_class, GPIO_ODR[15:0], lat);
            n_pass++;
        end
    endtask

    // =================================================================
    //  8) ANA AKIS
    // =================================================================
    int t;
    initial begin
        $display("======================================================================");
        $display("   YZ HIZLANDIRICI SISTEM SEVIYESI TESTI");
        $display("   Sartname madde 5.2-3 ve 5.2-4 (zorunlu)");
        $display("   Saat: 50 MHz  |  UART: %0d clk/bit (115200 baud)", CLKS_PER_BIT);
        $display("======================================================================");

        // =============================================================
        //  RESET + CPU BOOT  (tum kosum icin BIR KERE)
        //    rst_ni tanimda 0 baslar; burada birakilmazsa CPU sonsuza
        //    kadar resette kalir. O durumda Boot ROM icerigi $readmemh
        //    ile dolu gorunur ama tek bir buyruk bile yurutulmez ve
        //    uart_yz_init() hic calismadigi icin UART_YZ register'lari
        //    (UART_CPB dahil) reset degeri 0'da kalir -> DMA'ya hicbir
        //    bayt ulasmaz.
        // =============================================================
        rst_ni   = 1'b0;
        GPIO_IDR = 32'h0;
        UART_RX  = 1'b1;
        repeat (20) @(posedge clk_i);
        rst_ni = 1'b1;

        // Uygulamanin uart_yz_init()'i bitirmesini bekle. Sabit gecikme
        // yerine register'in kendisine bakiyoruz: yazilim buyudukce bu
        // bekleme kendini ayarlar, sessizce kisa kalmaz.
        fork
            begin : wait_cpu_ready
                wait (dut.uart_yz_inst.UART_CPB != 0);
                $display("[TB] t=%0t  CPU boot tamam, UART_YZ_CPB=%0d",
                         $time, dut.uart_yz_inst.UART_CPB);
            end
            begin : wait_cpu_timeout
                #(1_000_000);   // 1 ms: 50 MHz'de 50k cevrim, boot icin fazlasiyla yeterli
                $fatal(1, "[TB] CPU UART_YZ'yi konfigure etmedi (UART_CPB=0). Boot ROM'da dogru hex var mi? (make sim_app)");
            end
        join_any
        disable fork;

        if (dut.uart_yz_inst.UART_CPB != CLKS_PER_BIT)
            $display("[TB] UYARI: UART_YZ_CPB=%0d, testbench %0d clk/bit gonderiyor -- baud uyusmuyor.",
                     dut.uart_yz_inst.UART_CPB, CLKS_PER_BIT);

        for (t = 0; t < N_TESTS; t++) run_inference(t);

        // ---- Ozet ----
        $display("");
        $display("======================================================================");
        $display("   YZ HIZLANDIRICI TEST OZETI");
        $display("======================================================================");
        $display("   Gecen : %0d / %0d", n_pass, N_TESTS);
        $display("   Kalan : %0d / %0d", n_fail, N_TESTS);
        if (n_pass > 0) begin
            $display("   Ortalama cikarim gecikmesi: %0d cevrim",
                     (perf_cycles[0] + perf_cycles[1] + perf_cycles[2]) / n_pass);
        end
        if (!CHECK_SCORES)
            $display("   NOT: FC skor karsilastirmasi KAPALI (CHECK_SCORES=0).");
        $display("======================================================================");

        // ---- AXI protokol ozeti ----
        //  Askida kalan islemlerin (FIN_01/FIN_02) bosalmasi icin once
        //  birkac cevrim bekle; erken $finish yanlis alarm uretir.
        repeat (100) @(posedge clk_i);

        if (axi_chk_pkg::final_report() != 0)
            $fatal(1, "[TB] AXI protokol ihlali tespit edildi.");
        if (n_fail != 0)
            $fatal(1, "[TB] %0d hizlandirici testi basarisiz.", n_fail);

        $display("[TB] >>> YZ HIZLANDIRICI TESTI: BASARILI <<<");
        $finish;
    end

    // =================================================================
    //  9) GLOBAL WATCHDOG
    //     $finish DEGIL $fatal: zaman asimi bir BASARISIZLIKTIR ve
    //     regresyonun sifirdan farkli cikis kodu vermesi gerekir.
    // =================================================================
    initial begin
        #(GLOBAL_TIMEOUT);
        $display("[TB] GLOBAL ZAMAN ASIMI -- test takildi.");
        void'(axi_chk_pkg::final_report());
        $fatal(1, "[TB] Global zaman asimi.");
    end

endmodule
