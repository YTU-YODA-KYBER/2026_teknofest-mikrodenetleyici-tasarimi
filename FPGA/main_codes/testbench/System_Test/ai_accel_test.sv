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
//   EK-1 madde 4 (Softmax) ve demo arayuzu:
//     -> Genel UART'tan cikan "YZ:<sinif> S=<s0>;..;<s3>" satiri cozulur.
//        Boylece ISR'in requantization + softmax + argmax zinciri de,
//        PC'nin gercekten gordugu bayt uzerinden dogrulanir.
//
//   Demo saglamlik senaryosu 'truncated_frame':
//     -> Kesik cerceve gonderilip girdi RAM'i sayacinin bosta kalma
//        esiginde sifirlandigi, sonraki cercevenin dogru siniflandigi
//        kontrol edilir (run_resync_check).
//
// =====================================================================
`timescale 1ns / 1ps

`include "axi4lite_bind.svh"

module ai_accel_test;

    // =================================================================
    //  1) SAAT VE BAUD
    // =================================================================
    //  CLK_HALF=10 ns  ->  20 ns periyot  ->  50 MHz. Sistem saati budur
    //  (clk_wiz_0: 100 MHz x 10 / 20).
    //  UART bölücüsü ve performans hesabı aynı 50 MHz sistem saatini kullanır.
    localparam real CLK_HALF     = 10;
    localparam real CLK_FREQ_HZ  = 50.0e6;
    //  Iki UART farkli hizda kosar (main_app.c: uart_init):
    //    YZ veri akisi 1 Mbps   -> 50e6 / 1e6    = 50
    //    genel UART    115200   -> 50e6 / 115200 = 434.03
    localparam int  YZ_CLKS_PER_BIT = 50;
    localparam int  GU_CLKS_PER_BIT = 434;

    // =================================================================
    //  2) TEST VEKTORLERI
    // =================================================================
    localparam int N_BYTES  = 1960;
    localparam int N_TESTS  = 3;
    //  Demo harness'inin 'truncated_frame' senaryosu 64 bayt eksik gonderir.
    localparam int TRUNC_BYTES = N_BYTES - 64;

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
    localparam int TEST_TIMEOUT   = 400_000_000;   // tek test icin ust sinir (ns)
    localparam int GLOBAL_TIMEOUT = 1_500_000_000; // tum kosum icin ust sinir (ns)

    // =================================================================
    //  3) SINYALLER
    // =================================================================
    logic        clk_i    = 1'b0;
    logic        rst_ni   = 1'b0;
    logic        UART_YZ_RX = 1'b1;    // idle-high; cikarim vektoru buradan girer
    logic        UART_YZ_TX;
    logic        UART_GU_RX = 1'b1;    // idle-high; bu testte kullanilmaz
    logic        UART_GU_TX;           // ISR'in sonuc satiri buradan cikar
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
    //  Uygulama Boot ROM'dan kosar: flash + flasher + DMA zincirine hic
    //  girilmez. Imaj softmax exp tablosuyla birlikte 1KB'i astigi icin ROM
    //  bu senaryoda 4KB'a ezilir (firmware/linker_app_bootrom.ld ile ayni).
    //  Ana projenin 1KB'lik Boot ROM'u DEGISMEZ.
    top_module #(
        .INIT_FILE_boot ("sim_app.hex"),
        .ADDR_WIDTH_boot(10)
    ) dut 
    (
        .clk_i    (clk_i),   .rst_ni   (rst_ni),
        .GPIO_IDR (GPIO_IDR),.GPIO_ODR (GPIO_ODR),
        .anode    (anode),   .catode   (catode),
        .UART_GU_TX(UART_GU_TX), .UART_GU_RX(UART_GU_RX),
        .UART_YZ_TX(UART_YZ_TX), .UART_YZ_RX(UART_YZ_RX),
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
    longint unsigned perf_sum = 0;   // gecen kosumlarin gecikme toplami
    int unsigned     perf_n   = 0;   // gecen kosum sayisi
    int unsigned     n_runs   = 0;   // toplam cikarim kosumu (resync dahil)
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
            UART_YZ_RX = 1'b0;                     // start
            repeat (YZ_CLKS_PER_BIT) @(posedge clk_i);
            for (i = 0; i < 8; i++) begin          // 8 veri biti, LSB once
                UART_YZ_RX = b[i];
                repeat (YZ_CLKS_PER_BIT) @(posedge clk_i);
            end
            UART_YZ_RX = 1'b1;                     // stop
            repeat (YZ_CLKS_PER_BIT) @(posedge clk_i);
        end
    endtask

    // =================================================================
    //  6b) GENEL UART'I COZ  --  ISR'in sonuc satiri
    // =================================================================
    //  "YZ:B\n" ve "YZ:<sinif> S=<s0>;<s1>;<s2>;<s3>\n" satirlari burada
    //  toplanir. Sinif ve softmax skorlari uctan uca boylece kontrol edilir:
    //  hizlandiricinin ic argmax'i degil, PC'nin GERCEKTEN gordugu deger.
    string       gu_line;
    string       last_result_line;
    int          n_result_lines = 0;

    initial begin : decode_gu_tx
        logic [7:0] b;
        int         i;
        gu_line          = "";
        last_result_line = "";
        forever begin
            @(negedge UART_GU_TX);                       // start biti
            repeat (GU_CLKS_PER_BIT + GU_CLKS_PER_BIT/2) @(posedge clk_i);
            for (i = 0; i < 8; i++) begin
                b[i] = UART_GU_TX;
                repeat (GU_CLKS_PER_BIT) @(posedge clk_i);
            end
            if (b == 8'h0A) begin
                $display("[GU] t=%0t  \"%0s\"", $time, gu_line);
                if (gu_line != "YZ:B") begin
                    last_result_line = gu_line;
                    n_result_lines++;
                end
                gu_line = "";
            end else if (b != 8'h0D) begin
                // $sformatf("%c", ...) ile ekliyoruz: string'(b) cast'i
                // araclar arasinda tutarli davranmiyor.
                gu_line = {gu_line, $sformatf("%c", b)};
            end
        end
    end

    // =================================================================
    //  7) TEK CIKARIM KOSUMU  (self-checking)
    // =================================================================
    task automatic run_inference(input int idx);
        int  k, s;
        int  lines_before;
        bit  timed_out;
        bit  scores_ok;
        int  rep_cls;
        int  rep_scores [4];
        int  score_sum;
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
            n_runs++;
            lines_before   = n_result_lines;
            accel_started  = 1'b0;
            accel_finished = 1'b0;
            observed_class = -1;
            UART_YZ_RX     = 1'b1;

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
                    repeat (200) @(posedge clk_i);   // observed_class yerlessin
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

            // 2) Kesme servisinin BITMESINI bekle.
            //    accel_done, hizlandiricinin isi bittigi andir; CPU o sirada
            //    hala load_done ISR'inda "YZ:B" satirini basiyor olabilir ve
            //    GPIO_ODR'yi henuz yazmamistir. Sabit bir gecikme saymak
            //    yerine PC'ye giden sonuc satirini bekliyoruz: o satir
            //    ciktiysa ISR requantization + softmax + argmax zincirini
            //    tamamlamis ve GPIO_ODR'yi yazmis demektir.
            fork
                begin : wait_line
                    wait (n_result_lines > lines_before);
                end
                begin : wait_line_timeout
                    //  1960 bayt + cikarim + 26 baytlik satir icin genis pay
                    #(50_000_000);   // 50 ms
                end
            join_any
            disable fork;

            if (n_result_lines == lines_before) begin
                $display("[KALDI] %0s: genel UART'tan sonuc satiri gelmedi",
                         tests[idx].label);
                n_fail++;
                return;
            end

            // 3) GPIO_ODR (7-segment) -- uctan uca yol dogru mu
            if (GPIO_ODR[15:0] !== tests[idx].exp_odr) begin
                $display("[KALDI] %0s: GPIO_ODR=%0d, beklenen=%0d",
                         tests[idx].label, GPIO_ODR[15:0], tests[idx].exp_odr);
                n_fail++;
                return;
            end

            // 4) FC skorlari (opsiyonel, ama requantization hatalarini
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

            // 5) PC'nin GERCEKTEN gordugu satir. Yukaridaki kontroller cipin
            //    icine bakar; bu kontrol UART'tan cikan bayta bakar, yani
            //    ISR'in requantization + softmax + argmax zincirini de kapsar.
            if ($sscanf(last_result_line, "YZ:%d S=%d;%d;%d;%d",
                        rep_cls, rep_scores[0], rep_scores[1],
                        rep_scores[2], rep_scores[3]) != 5) begin
                $display("[KALDI] %0s: sonuc satiri cozulemedi: \"%0s\"",
                         tests[idx].label, last_result_line);
                n_fail++;
                return;
            end
            if (rep_cls != tests[idx].exp_class) begin
                $display("[KALDI] %0s: PC'ye giden sinif=%0d, beklenen=%0d (satir: \"%0s\")",
                         tests[idx].label, rep_cls, tests[idx].exp_class,
                         last_result_line);
                n_fail++;
                return;
            end
            // Softmax cikisi int8'dir (scale 1/256, zp -128), dolayisiyla
            // dort skorun (deger + 128) toplami 256 civarinda olmalidir.
            // Her eleman bagimsiz yuvarlandigi icin toplam birkac LSB
            // sapabilir: referans model 156 ornekte 255..257 uretir.
            score_sum = rep_scores[0] + rep_scores[1]
                      + rep_scores[2] + rep_scores[3] + 4*128;
            if (score_sum < 253 || score_sum > 259) begin
                $display("[KALDI] %0s: softmax skorlari 1'e toplanmiyor (toplam=%0d): \"%0s\"",
                         tests[idx].label, score_sum, last_result_line);
                n_fail++;
                return;
            end
            $display("[P7] PC'ye giden satir: \"%0s\"", last_result_line);

            // =========================================================
            //  PERFORMANS  (Tablo 3-1 "Sistem performansi")
            // =========================================================
            lat = t_done_cyc - t_start_cyc;
            perf_sum += lat;
            perf_n++;
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
    //  7b) KESIK CERCEVE SONRASI RESENKRONIZASYON
    // =================================================================
    //  Demo test harness'i 'truncated_frame' senaryosunda 1960 yerine 1896
    //  bayt gonderir. Girdi RAM'inin yazma sayaci yalnizca 1960'ta sifirlansa
    //  bu 64 baytlik kayma KALICI olurdu: sonraki her cikarim kaymis bir
    //  pencere uzerinde yapilirdi ve tek cikis yolu karti resetlemek olurdu.
    //  yz_bram_axi_ctrl'deki bosta kalma sayaci hatti 2 ms sessiz gorunce
    //  yarim kaydi atar. Burada once kesik cerceve gonderilir, sonra normal
    //  bir cikarim kosulur: dogru sinif cikiyorsa kurtarma calisiyordur.
    task automatic run_resync_check(input int idx);
        int k;
        begin
            $display("");
            $display("======================================================================");
            $display(" RESENKRONIZASYON : kesik cerceve (%0d bayt) sonrasi kurtarma", TRUNC_BYTES);
            $display("======================================================================");

            for (k = 0; k < N_BYTES; k++) audio[k] = 8'h00;
            $readmemh(tests[idx].hex_file, audio);

            $display("[TB] %0d bayt gonderiliyor (cerceve bilerek yarim birakiliyor)...",
                     TRUNC_BYTES);
            for (k = 0; k < TRUNC_BYTES; k++) uart_send_byte(audio[k]);

            if (dut.yz_bram_ctrl_inst.addr_cnt != TRUNC_BYTES)
                $display("[TB] UYARI: addr_cnt=%0d, %0d bekleniyordu",
                         dut.yz_bram_ctrl_inst.addr_cnt, TRUNC_BYTES);
            else
                $display("[TB] addr_cnt=%0d -- sayac beklendigi gibi ortada kaldi",
                         dut.yz_bram_ctrl_inst.addr_cnt);

            // Bosta kalma esigini asacak kadar bekle (2 ms + pay)
            #(3_000_000);

            if (dut.yz_bram_ctrl_inst.addr_cnt != 0) begin
                $display("[KALDI] RESENKRONIZASYON: bosta beklemeden sonra addr_cnt=%0d, 0 olmaliydi",
                         dut.yz_bram_ctrl_inst.addr_cnt);
                n_fail++;
                return;
            end
            $display("[GECTI] addr_cnt sifirlandi; simdi tam bir cerceve kosuluyor");

            // Kurtarmanin gercek kaniti: sonraki cerceve DOGRU siniflaniyor mu
            run_inference(idx);
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
        $display("   Saat: 50 MHz  |  YZ UART: %0d clk/bit (1 Mbps)  |  genel UART: %0d clk/bit (115200)",
                 YZ_CLKS_PER_BIT, GU_CLKS_PER_BIT);
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
        rst_ni     = 1'b0;
        GPIO_IDR   = 32'h0;
        UART_YZ_RX = 1'b1;
        UART_GU_RX = 1'b1;
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

        if (dut.uart_yz_inst.UART_CPB != YZ_CLKS_PER_BIT)
            $display("[TB] UYARI: UART_YZ_CPB=%0d, testbench %0d clk/bit gonderiyor -- baud uyusmuyor.",
                     dut.uart_yz_inst.UART_CPB, YZ_CLKS_PER_BIT);
        if (dut.uart_gu_inst.UART_CPB != GU_CLKS_PER_BIT)
            $display("[TB] UYARI: UART_GU_CPB=%0d, testbench %0d clk/bit cozuyor -- baud uyusmuyor.",
                     dut.uart_gu_inst.UART_CPB, GU_CLKS_PER_BIT);

        for (t = 0; t < N_TESTS; t++) run_inference(t);

        // Sagl­amlik: kesik cerceve gonderip kurtarmayi dogrula
        run_resync_check(0);

        // ---- Ozet ----
        $display("");
        $display("======================================================================");
        $display("   YZ HIZLANDIRICI TEST OZETI");
        $display("======================================================================");
        $display("   Gecen : %0d / %0d", n_pass, n_runs);
        $display("   Kalan : %0d / %0d", n_fail, n_runs);
        if (perf_n > 0)
            $display("   Ortalama cikarim gecikmesi: %0d cevrim", perf_sum / perf_n);
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
