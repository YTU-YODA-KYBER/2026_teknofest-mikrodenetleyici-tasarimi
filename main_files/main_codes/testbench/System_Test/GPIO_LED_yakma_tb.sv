`timescale 1ns / 1ps
// =====================================================================
//  sim_deneme.sv  -  top_module dogrudan simulasyon testbench'i
//  CV32E40P SoC - circle.c (BootROM LED demosu) icin
//
//  AMAC:
//    fpga_top'taki clk_wiz IP'sini atlayip clk'yi dogrudan surmek.
//    CPU, BootROM'daki circle.hex'i kosar; biz GPIO_ODR'yi izleriz.
//
//  ONEMLI:
//    - Vivado'da bu modulu "Set as Top" yap (top_module'u DEGIL).
//    - BootROM INIT_FILE_boot = "circle.hex"; sim calisma dizininde
//      build_circle_sim/circle.hex bulunmali (make sim_circle ciktisi).
//      Gerekirse top_module instance'inda INIT_FILE_boot'u tam path ver.
// =====================================================================
module sim_deneme;

    // --- Saat ve reset (rst_ni AKTIF-DUSUK) ---
    logic clk_i = 1'b0;          // X'ten kacinmak icin init SART
    logic rst_ni;

    // --- Tie-off girisler (X yerine guvenli sabitler) ---
    logic        uart_gu_rx = 1'b1;   // UART idle = HIGH
    logic        uart_yz_rx = 1'b1;
    logic [31:0] interrupt_i = 32'h0; // kesme yok
    logic [31:0] gpio_idr    = 32'h0; // switch'ler kapali

    // --- Cikislar (izlemek icin) ---
    logic        uart_gu_tx;
    logic        uart_yz_tx;
    logic [ 4:0] interrupt_id;
    logic        interrupt_ack;
    logic [31:0] gpio_odr;            // <-- IZLENECEK ANA SINYAL
    logic        i2c_scl;
    logic        qspi_sclk;
    logic        qspi_cs;

    // --- inout hatlar (program bunlara dokunmuyor; pull-up ile Z'den kurtar) ---
    wire i2c_sda;
    wire qspi_io0, qspi_io1, qspi_io2, qspi_io3;
    pullup (i2c_sda);
    pullup (qspi_io0);
    pullup (qspi_io1);
    pullup (qspi_io2);
    pullup (qspi_io3);

    // -----------------------------------------------------------------
    //  DUT
    // -----------------------------------------------------------------
    top_module dut (
        .clk_i        (clk_i),
        .rst_ni       (rst_ni),

        .UART_GU_rx   (uart_gu_rx),
        .UART_GU_tx   (uart_gu_tx),
        .UART_YZ_rx   (uart_yz_rx),
        .UART_YZ_tx   (uart_yz_tx),

        .interrupt_i  (interrupt_i),
        .interrupt_id (interrupt_id),
        .interrupt_ack(interrupt_ack),

        .GPIO_IDR     (gpio_idr),
        .GPIO_ODR     (gpio_odr),

        .I2C_SCL      (i2c_scl),
        .I2C_SDA      (i2c_sda),
        .QSPI_SCLK    (qspi_sclk),
        .QSPI_CS      (qspi_cs),
        .QSPI_IO0     (qspi_io0),
        .QSPI_IO1     (qspi_io1),
        .QSPI_IO2     (qspi_io2),
        .QSPI_IO3     (qspi_io3)
    );

    // -----------------------------------------------------------------
    //  Saat uretimi - 100 MHz (10 ns periyot)
    //  Bu blok DUT'tan tamamen bagimsiz; clk DUZ kaliyorsa sorun burada
    //  veya sim-top ayarinda demektir.
    // -----------------------------------------------------------------
    always #5 clk_i = ~clk_i;

    // -----------------------------------------------------------------
    //  Reset: birkac kenar boyunca dusuk tut, sonra birak
    // -----------------------------------------------------------------
    initial begin
        rst_ni = 1'b0;
        repeat (10) @(posedge clk_i);
        rst_ni = 1'b1;
    end

    // -----------------------------------------------------------------
    //  GPIO_ODR her degistiginde yazdir (animasyonu konsoldan da gor)
    // -----------------------------------------------------------------
    initial $timeformat(-9, 1, " ns", 10);

    always @(gpio_odr)
        $display("[%t] GPIO_ODR = %04h  (LED = %016b)",
                 $time, gpio_odr[15:0], gpio_odr[15:0]);

    // -----------------------------------------------------------------
    //  Zaman limiti (sonsuz while(1) programi: $finish ile durdur)
    //  Sim modunda (kucuk delay) birkac yuz us birkac animasyon gosterir.
    // -----------------------------------------------------------------
    initial begin
        #30000000;   // 300 us
        $display("=== Sim zaman limiti, bitiriliyor ===");
        $finish;
    end

endmodule