// =====================================================================
//  ---------------------------------------------------------------
//  SARTNAME KARSILIGI
//  ---------------------------------------------------------------
//   EK-1: "YZ hizlandiricisi ... RISC-V cekirdegi uzerinde calisan
//          yazilim gerceklemesine kiyasla hizlanma elde etmelidir."
//     -> Bu test ikisini de AYNI kosumda, AYNI girdiyle, AYNI sayacla
//        (mcycle) olcer ve orani basar.
//
// =====================================================================
`timescale 1ns / 1ps

module yz_bench_test;

    // =================================================================
    //  1) SAAT VE BAUD
    // =================================================================
    //  CLK_HALF=10 ns -> 20 ns periyot -> 50 MHz sistem saati
    //  (clk_wiz_0: 100 MHz x 10 / 20).
    localparam real CLK_HALF     = 10;
    localparam real CLK_FREQ_HZ  = 50.0e6;
    localparam int  CLKS_PER_BIT = 434;       // 50e6 / 115200

    localparam int N_BYTES = 1960;

    //  Gomulu girdi ile AYNI dosya olmali (bkz. hex_to_carray.py).
    localparam string INPUT_HEX = "input_data_yes.hex";
    localparam int    EXP_CLASS = 2;          // yes

    localparam int DMA_EN_BIT      = 1;               // SW1
    localparam int GLOBAL_TIMEOUT  = 2_000_000_000;   // ns

    // =================================================================
    //  2) SINYALLER
    // =================================================================
    logic        clk_i    = 1'b0;
    logic        rst_ni   = 1'b0;
    logic        UART_RX  = 1'b1;      // idle-high, hic kullanilmiyor
    logic        UART_TX;
    logic [31:0] GPIO_IDR = 32'h0;
    logic [31:0] GPIO_ODR;
    logic [ 7:0] anode, catode;

    wire I2C_SCL, I2C_SDA;
    pullup(I2C_SDA);
    pullup(I2C_SCL);
    wire QSPI_SCLK, QSPI_CS, QSPI_IO0, QSPI_IO1, QSPI_IO2, QSPI_IO3;

    always #(CLK_HALF) clk_i = ~clk_i;

    // =================================================================
    //  3) DUT
    // =================================================================
    //  Bellek genisletmesi YALNIZCA BURADA yapilir -- Top_module.sv'nin
    //  varsayilanlari (1KB / 8KB) sartname sinirlaridir ve ana projede
    //  degistirilmez. firmware/linker_bench.ld ile ayni degerler:
    //      2^13 kelime x 4 bayt = 32KB
    top_module #(
        .INIT_FILE_boot ("sim_bench.hex"),
        .ADDR_WIDTH_boot(13),
        .ADDR_WIDTH_data(13)
    ) dut (
        .clk_i    (clk_i),     .rst_ni  (rst_ni),
        .GPIO_IDR (GPIO_IDR),  .GPIO_ODR(GPIO_ODR),
        .anode    (anode),     .catode  (catode),
        .UART_TX  (UART_TX),   .UART_RX (UART_RX),
        .I2C_SCL  (I2C_SCL),   .I2C_SDA (I2C_SDA),
        .QSPI_SCLK(QSPI_SCLK), .QSPI_CS (QSPI_CS),
        .QSPI_IO0 (QSPI_IO0),  .QSPI_IO1(QSPI_IO1),
        .QSPI_IO2 (QSPI_IO2),  .QSPI_IO3(QSPI_IO3)
    );

    // =================================================================
    //  4) BAGIMSIZ CEVRIM SAYACI
    //     Uygulamanin mcycle ile buldugu sayilari dogrulamak icin.
    // =================================================================
    longint unsigned cyc = 0;
    always @(posedge clk_i) if (rst_ni) cyc <= cyc + 1;

    longint unsigned accel_start_cyc, accel_done_cyc, accel_cycles;
    bit              accel_started, accel_finished;
    int              accel_class;

    always @(posedge clk_i) begin
        if (dut.conv_accelerator_inst.start && !accel_started) begin
            accel_start_cyc <= cyc;
            accel_started   <= 1'b1;
        end
        if (dut.conv_accelerator_inst.done && !accel_finished) begin
            accel_done_cyc <= cyc;
            accel_finished <= 1'b1;
            accel_class    <= dut.conv_accelerator_inst.out_ram_wdata;
            $display("[TB] t=%0t  ACCEL DONE, sinif=%0d, cevrim=%0d", $time,
                     dut.conv_accelerator_inst.out_ram_wdata,
                     cyc - accel_start_cyc);
        end
    end

    // =================================================================
    //  5) YZ RAM'I DMA ARAYUZUNDEN DOLDUR
    //     UART yerine dogrudan surulur; RTL tarafinda yol aynidir
    //     (yz_acclrtr_bram_axi_ctrl: dma_valid_i -> we, addr_cnt++).
    // =================================================================
    logic [7:0] audio [0:N_BYTES-1];

    // DMA surucu sinyalleri MODUL SEVIYESINDE (statik) olmali:
    // `force` surekli bir atamadir, RHS'inde otomatik degisken (task
    // icindeki `k`) kullanilamaz -- VRFC 10-3142. Bu yuzden force'u
    // bir kez kurup asagidaki reg'leri proseduel suruyoruz.
    logic [7:0] dma_data_drv  = 8'h00;
    logic       dma_valid_drv = 1'b0;

    task automatic load_yz_ram();
        int k;
        begin
            for (k = 0; k < N_BYTES; k++) audio[k] = 8'h00;
            $readmemh(INPUT_HEX, audio);

            // $readmemh eksik dosyada SESSIZCE gecer -- kontrol sart.
            if (audio[0] === 8'hxx) begin
                $display("[HATA] %0s okunamadi veya bos", INPUT_HEX);
                $fatal(1);
            end
            $display("[TB] YZ RAM DMA ile dolduruluyor (%0d bayt)...", N_BYTES);

            force dut.yz_dma_data  = dma_data_drv;
            force dut.yz_dma_valid = dma_valid_drv;

            for (k = 0; k < N_BYTES; k++) begin
                @(negedge clk_i);              // veriyi kenar disinda kur
                dma_data_drv  = audio[k];
                dma_valid_drv = 1'b1;
                @(posedge clk_i);              // RTL bu kenarda yazar
            end

            @(negedge clk_i);
            dma_valid_drv = 1'b0;              // once bosalt, sonra birak
            release dut.yz_dma_valid;
            release dut.yz_dma_data;
            $display("[TB] YZ RAM hazir, load_pending bekleniyor...");
        end
    endtask

    // =================================================================
    //  6) UART_TX'I COZ  (uygulamanin rapor cercevesi)
    // =================================================================
    task automatic uart_recv_byte(output logic [7:0] b);
        int i;
        begin
            wait (UART_TX === 1'b1);
            @(negedge UART_TX);                          // start biti
            repeat (CLKS_PER_BIT + CLKS_PER_BIT/2) @(posedge clk_i);
            for (i = 0; i < 8; i++) begin                // LSB once
                b[i] = UART_TX;
                repeat (CLKS_PER_BIT) @(posedge clk_i);
            end
        end
    endtask

    task automatic uart_recv_line(output string line);
        logic [7:0] b;
        begin
            line = "";
            forever begin
                uart_recv_byte(b);
                if (b == 8'h0A) return;                  // '\n'
                // $sformatf("%c", ...) ile ekliyoruz: string'(b) cast'i
                // araclar arasinda tutarli davranmiyor.
                if (b != 8'h0D) line = {line, $sformatf("%c", b)};
            end
        end
    endtask

    // =================================================================
    //  7) ANA AKIS
    // =================================================================
    string line;
    int    hw_cls, sw_cls;
    int unsigned hw_cyc, sw_cyc;
    bit    got_yz = 0, got_sw = 0;
    int    n_lines;
    real   speedup;

    initial begin
        $display("");
        $display("======================================================================");
        $display("  YZ BENCH  --  hizlandirici  vs  yazilim gerceklemesi");
        $display("  girdi: %0s   (beklenen sinif %0d)", INPUT_HEX, EXP_CLASS);
        $display("======================================================================");

        // ---- reset ----
        rst_ni = 1'b0;
        repeat (50) @(posedge clk_i);
        rst_ni = 1'b1;

        // ---- uart_mux'u YZ tarafina al (TX pini UART_YZ'ye baglansin) ----
        GPIO_IDR[DMA_EN_BIT] = 1'b1;
        repeat (100) @(posedge clk_i);

        load_yz_ram();

        // ---- iki rapor satirini oku ----
        n_lines = 0;
        while (!(got_yz && got_sw)) begin
            uart_recv_line(line);
            $display("[UART] %0s", line);
            n_lines++;

            if ($sscanf(line, "YZ:%d", hw_cls) == 1)
                got_yz = 1;
            else if ($sscanf(line, "SW:%d HC:%d SC:%d", sw_cls, hw_cyc, sw_cyc) == 3)
                got_sw = 1;

            // Cerceve kaymasi / baud uyusmazligi bu sekilde erken yakalanir;
            // yoksa global zaman asimina kadar sessizce beklenirdi.
            if (n_lines > 8) begin
                $display("[KALDI] %0d satir okundu ama YZ:/SW: cozulemedi.",
                         n_lines);
                $display("        Baud boleni (UART_CPB=434) ve GPIO_IDR[1:0]==2");
                $display("        kontrol edilmeli.");
                $fatal(1);
            end
        end

        // =============================================================
        //  SONUC
        // =============================================================
        accel_cycles = accel_done_cyc - accel_start_cyc;

        // mcycle hic saymadiysa (mcountinhibit temizlenmemis) sifira
        // bolmeden once yakala -- yoksa rapor NaN basar.
        if (hw_cyc == 0 || sw_cyc == 0) begin
            $display("[KALDI] mcycle 0 dondu (HC=%0d SC=%0d).", hw_cyc, sw_cyc);
            $display("        CV32E40P'de mcountinhibit reset'te 1'dir;");
            $display("        yz_bench.c'deki perf_init() calismamis olabilir.");
            $fatal(1);
        end
        speedup = real'(sw_cyc) / real'(hw_cyc);

        $display("");
        $display("======================================================================");
        $display("  SONUC");
        $display("======================================================================");
        $display("  donanim sinifi (YZ_RESULT)   : %0d", hw_cls);
        $display("  yazilim sinifi (tflite_ref)  : %0d", sw_cls);
        $display("");
        $display("  donanim cevrimi (mcycle)     : %0d  (%.3f ms @ %.0f MHz)",
                 hw_cyc, real'(hw_cyc) / CLK_FREQ_HZ * 1000.0, CLK_FREQ_HZ / 1.0e6);
        $display("  yazilim cevrimi (mcycle)     : %0d  (%.3f ms)",
                 sw_cyc, real'(sw_cyc) / CLK_FREQ_HZ * 1000.0);
        $display("  ----------------------------------------------------------");
        $display("  HIZLANMA                     : %.1f x", speedup);
        $display("  ----------------------------------------------------------");
        $display("  TB'nin bagimsiz olctugu       : %0d cevrim (start->done)",
                 accel_cycles);
        $display("    ^ mcycle'daki donanim sayisi bundan biraz BUYUK olmali:");
        $display("      olcum penceresi START yazmasini ve durum yoklamasini");
        $display("      da kapsiyor (AXI gidis-donusleri).");
        $display("");

        // ---- kontroller ----
        if (hw_cls !== EXP_CLASS) begin
            $display("[KALDI] donanim sinifi %0d, beklenen %0d", hw_cls, EXP_CLASS);
            $fatal(1);
        end
        if (sw_cls !== EXP_CLASS) begin
            $display("[KALDI] yazilim sinifi %0d, beklenen %0d", sw_cls, EXP_CLASS);
            $fatal(1);
        end
        if (accel_cycles > hw_cyc) begin
            $display("[KALDI] mcycle (%0d) TB olcumunden (%0d) kucuk -- sayac calismiyor olabilir (mcountinhibit?)",
                     hw_cyc, accel_cycles);
            $fatal(1);
        end
        if (speedup <= 1.0) begin
            $display("[KALDI] hizlanma yok (%.2fx)", speedup);
            $fatal(1);
        end

        $display("[GECTI] Hizlandirici yazilim gerceklemesinden %.1f kat hizli.",
                 speedup);
        $display("");
        $finish;
    end

    // ---- global zaman asimi ----
    initial begin
        #(GLOBAL_TIMEOUT);
        $display("[KALDI] GLOBAL ZAMAN ASIMI -- rapor satirlari gelmedi.");
        $display("        GPIO_ODR=%0d, accel_done=%0b", GPIO_ODR[15:0], accel_finished);
        $fatal(1);
    end

endmodule
