`timescale 1ns / 1ps

// =====================================================================
//  Sistem Seviyesi QSPI Flash Yazma/Okuma Testi  -  DTR Deneyi
//
//  - top_module boot ROM'dan (qspi_flash_test.hex) boot eder.
//  - CPU, qspi_flash_test.c'yi kosturur: flash'a yazar, geri okur, dogrular.
//  - C kodu sonucu GPIO_ODR'a yazar (0x600D = PASS, 0x0BAD = FAIL).
//  - Bu TB GPIO_ODR'i izler ve sonucu konsola (Questa transcript) basar.
//
//  Flash modeli (N25Qxxx) standalone QSPI_tb.sv ile birebir ayni baglanir.
//
//  NOT: QSPI_Master icindeki Xilinx IOBUF primitifi icin ya unisims
//       kutuphanesini derle, ya da yanindaki iobuf_sim.sv stub'ini ekle.
// =====================================================================

module tb_qspi_system;

    // ---- saat / reset ----
    logic clk_i  = 0;
    logic rst_ni = 0;

    // ---- UART (bu testte kullanilmiyor; portlar baglanmali) ----
    logic        UART_GU_rx = 1'b1;
    logic        UART_GU_tx;
    logic        UART_YZ_rx = 1'b1;
    logic        UART_YZ_tx;

    // ---- interrupt (kullanilmiyor) ----
    logic [31:0] interrupt_i = 32'd0;
    logic [ 4:0] interrupt_id;
    logic        interrupt_ack;


    pullup (QSPI_IO2);
    pullup (QSPI_IO3);


    // ---- GPIO ----
    logic [31:0] GPIO_IDR = 32'd0;
    logic [31:0] GPIO_ODR;          // <-- sonucu buradan okuyacagiz

    // ---- I2C (kullanilmiyor) ----
    logic        I2C_SCL;
    wire         I2C_SDA;
    pullup (I2C_SDA);

    // ---- QSPI hatlari (tri-state -> wire) ----
    wire QSPI_SCLK;
    wire QSPI_CS;
    wire QSPI_IO0;
    wire QSPI_IO1;
    wire QSPI_IO2;
    wire QSPI_IO3;

    // ---- flash besleme ----
    logic [31:0] flash_vcc = 32'd0;

    // ---- PASS/FAIL kodlari (qspi_flash_test.c ile AYNI olmali) ----
    localparam logic [15:0] PASS_CODE = 16'h600D;
    localparam logic [15:0] FAIL_CODE = 16'h0BAD;

    // sim-zamani ust siniri (gerekirse artir; erase suresi modele bagli)
    localparam time WATCHDOG = 20_000_000;   // 50 us (4KB subsector icin bol bol yeter)

    // =================================================================
    //  DUT
    // =================================================================
    top_module #(
        .INIT_FILE_boot("firmware.hex")   // boot ROM init dosyasi
    ) dut (
        .clk_i        (clk_i),
        .rst_ni       (rst_ni),

        .UART_GU_rx   (UART_GU_rx),
        .UART_GU_tx   (UART_GU_tx),
        .UART_YZ_rx   (UART_YZ_rx),
        .UART_YZ_tx   (UART_YZ_tx),

        .interrupt_i  (interrupt_i),
        .interrupt_id (interrupt_id),
        .interrupt_ack(interrupt_ack),

        .GPIO_IDR     (GPIO_IDR),
        .GPIO_ODR     (GPIO_ODR),

        .I2C_SCL      (I2C_SCL),
        .I2C_SDA      (I2C_SDA),

        .QSPI_SCLK    (QSPI_SCLK),
        .QSPI_CS      (QSPI_CS),
        .QSPI_IO0     (QSPI_IO0),
        .QSPI_IO1     (QSPI_IO1),
        .QSPI_IO2     (QSPI_IO2),
        .QSPI_IO3     (QSPI_IO3)
    );

    // =================================================================
    //  Micron MT25QL256 flash modeli (standalone TB ile ayni baglanti)
    // =================================================================
    N25Qxxx u_flash (
        .S         (QSPI_CS),       // CS (active low)
        .C_        (QSPI_SCLK),     // SCLK
        .DQ0       (QSPI_IO0),      // IO0
        .DQ1       (QSPI_IO1),      // IO1
        .Vpp_W_DQ2 (QSPI_IO2),      // IO2 / WP
        .HOLD_DQ3  (QSPI_IO3),      // IO3 / HOLD
        .Vcc       (flash_vcc),     // 3.3V
        .RESET2    (1'b1)           // yazilimla reset - 1'de tut
    );

    // =================================================================
    //  48 MHz saat (periyot ~20.833 ns, standalone TB ile ayni)
    // =================================================================
    always #10.4166 clk_i = ~clk_i;

    // =================================================================
    //  Uyaran: once flash'i ayaga kaldir, sonra CPU'yu reset'ten birak
    //  (CPU reset altindayken QSPI_CS=1 idle, flash sorunsuz power-up eder)
    // =================================================================
    initial begin
        rst_ni    = 1'b0;
        flash_vcc = 32'd3300;       // 3.3V uygula
        #1_000_000;                  // flash stabilize olsun (1 us... model 1ms istiyorsa artir)
        rst_ni = 1'b1;               // CPU boot etsin
        $display("\n[TB] Reset birakildi @ %0t ns. CPU boot ediyor, C kodu kosuyor...\n", $time);
    end

    // =================================================================
    //  Sonuc yakalama: C kodu GPIO_ODR'a PASS/FAIL kodu yazinca bas
    // =================================================================
    initial begin
        @(posedge rst_ni);
        wait (GPIO_ODR[15:0] == PASS_CODE || GPIO_ODR[15:0] == FAIL_CODE);

        $display("\n======================================================================");
        if (GPIO_ODR[15:0] == PASS_CODE) begin
            $display("[TB] >>> QSPI FLASH YAZMA/OKUMA TESTI: BASARILI (PASS) <<<");
            $display("[TB]     PP(x1) ile yazildi, QOR(x4) ile okundu, veri dogru dondu.");
            $display("[TB]     GPIO_ODR = 0x%08X  (kod: 0x600D)", GPIO_ODR);
        end
        else begin
            $display("[TB] >>> QSPI FLASH YAZMA/OKUMA TESTI: BASARISIZ (FAIL) <<<");
            $display("[TB]     Okunan veri yazilan ile eslesmedi.");
            $display("[TB]     GPIO_ODR = 0x%08X  (kod: 0x0BAD)", GPIO_ODR);
        end
        $display("[TB] Bitis zamani: %0t ns", $time);
        $display("======================================================================\n");
        #100;
        $finish;
    end

    // =================================================================
    //  Watchdog: sonuc gelmezse simulasyonu kilitlenmeden bitir
    // =================================================================
    initial begin
        #WATCHDOG;
        $display("\n======================================================================");
        $error("[TB] ZAMAN ASIMI! Sonuc kodu gelmedi. GPIO_ODR = 0x%08X", GPIO_ODR);
        $display("[TB]   - Erase modele gore uzun suruyorsa WATCHDOG'u artir,");
        $display("[TB]     ya da C'de CMD_SSE'yi (0x20) koru / 0xD8 yerine 0x20 kullan.");
        $display("[TB]   - hex dosyasi boot ROM'a yuklendi mi? (INIT_FILE_boot)");
        $display("======================================================================\n");
        $finish;
    end

endmodule
