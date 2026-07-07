`timescale 1ns / 1ps

// =====================================================================
//  FLASHER ADIM 1 - UART ECHO TESTI  (tb_qspi_system.sv'den turetildi)
//
//  - top_module boot ROM'dan (build_echo/firmware.hex) boot eder.
//  - GPIO_IDR[0] = 1 verildigi icin CPU FLASHER MODUNA girer ve
//    UART'tan gelen her bayti oldugu gibi geri yollar (echo).
//  - CPU flasher moduna girip uart_init()'i bitirince GPIO_ODR = 0xF1A5
//    basar; bu, TB'nin bayt gondermeye baslamasi icin HANDSHAKE'tir
//    (baud ayarlanmadan bayt gonderirsek RX bozuk ornekler).
//  - TB, PC + seri kablo rolunu oynar: rx'e frame surer, tx'i orta-
//    noktadan ornekler, echo'yu karsilastirir.
//
//  DIKKAT: boot ROM init dosyasi (INIT_FILE_boot) 'firmware.hex' olarak
//          duruyor. Echo testi icin sim calisma dizinindeki firmware.hex
//          = build_echo/firmware.hex OLMALI (make echo ciktisi). Yani:
//              cp build_echo/firmware.hex <xsim_calisma_dizini>/firmware.hex
//
//  Flash modeli (N25Qxxx) echo'da KULLANILMIYOR; bagli kalmasi zararsiz
//  (QSPI'a hic komut gitmiyor).
// =====================================================================

module tb_uart_echo;

    // ---- saat / reset ----
    logic clk_i  = 0;
    logic rst_ni = 0;

    // ---- UART ----
    //   UART_GU_rx : TB SURER  -> DUT girisi (PC'nin TX'i)   [echo'da task suruyor]
    //   UART_GU_tx : TB IZLER  <- DUT cikisi (PC'nin RX'i)
    logic        UART_GU_rx = 1'b1;      // idle = HIGH (task devralinca surecek)
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
    //   GPIO_IDR[0] = 1  -> FLASHER MODU (fiziksel SW0'in sim karsiligi)
    //   GPIO_ODR        -> C kodu flasher moduna girince 0xF1A5 basar (handshake)
    logic [31:0] GPIO_IDR = 32'd1;   // <-- SW0=1: flasher modu (echo)
    logic [31:0] GPIO_ODR;

    // ---- I2C (kullanilmiyor) ----
    logic        I2C_SCL;
    wire         I2C_SDA;
    pullup (I2C_SDA);

    // ---- QSPI hatlari (echo'da kullanilmiyor, bagli kalsin) ----
    wire QSPI_SCLK;
    wire QSPI_CS;
    wire QSPI_IO0;
    wire QSPI_IO1;

    // ---- flash besleme ----
    logic [31:0] flash_vcc = 32'd0;

    // ---- flasher modu isareti (C kodundaki GPIO_ODR = 0xF1A5) ----
    localparam logic [15:0] FLASHER_READY = 16'hF1A5;

    // sim-zamani ust siniri
    localparam time WATCHDOG = 20_000_000;   // 20 ms (echo icin bol bol yeter)

    // UART bit suresi (clock cycle cinsinden) - C koddaki UART_BAUD_CPB ile AYNI
    localparam int CPB = 416;

    // =================================================================
    //  DUT
    // =================================================================
    top_module #(
        .INIT_FILE_boot("firmware.hex")   // <-- build_echo/firmware.hex olmali!
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

        .GPIO_IDR     (00000001),
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
    //  Micron MT25QL256 flash modeli (echo'da pasif; bagli kalsin)
    // =================================================================
    N25Qxxx u_flash (
        .S         (QSPI_CS),
        .C_        (QSPI_SCLK),
        .DQ0       (QSPI_IO0),
        .DQ1       (QSPI_IO1),
        .Vpp_W_DQ2 (QSPI_IO2),
        .HOLD_DQ3  (QSPI_IO3),
        .Vcc       (flash_vcc),
        .RESET2    (1'b1)
    );

    // =================================================================
    //  48 MHz saat (periyot ~20.833 ns)
    // =================================================================
    always #10.4166 clk_i = ~clk_i;

    // =================================================================
    //  Reset uyarani: flash'i ayaga kaldir, sonra CPU'yu birak
    // =================================================================
    initial begin
        rst_ni    = 1'b0;
        flash_vcc = 32'd3300;
        #1_000_000;                  // flash stabilize (echo icin sart degil ama zarari yok)
        rst_ni = 1'b1;
        $display("\n[TB] Reset birakildi @ %0t ns. CPU boot ediyor (flasher modu)...\n", $time);
    end

    // =================================================================
    //  UART TASK'LARI  (PC + seri kablo simulasyonu)
    // =================================================================

    // PC -> DUT: bir bayt gonder (LSB-first, 1 start + 8 data + 1 stop)
    task automatic pc_uart_send(input logic [7:0] data);
        int i;
        begin
            UART_GU_rx = 1'b0;                       // START
            repeat (CPB) @(posedge clk_i);
            for (i = 0; i < 8; i++) begin            // 8 DATA, LSB once
                UART_GU_rx = data[i];
                repeat (CPB) @(posedge clk_i);
            end
            UART_GU_rx = 1'b1;                        // STOP
            repeat (CPB) @(posedge clk_i);
        end
    endtask

    // DUT -> PC: bir bayt yakala (tx'i orta-noktadan ornekle)
    task automatic pc_uart_recv(output logic [7:0] data);
        int i;
        begin
            @(negedge UART_GU_tx);                   // START'i yakala (1->0)
            repeat (CPB + CPB/2) @(posedge clk_i);   // ilk data bitinin ORTASINA (1.5 bit)
            for (i = 0; i < 8; i++) begin            // 8 DATA, LSB once
                data[i] = UART_GU_tx;
                repeat (CPB) @(posedge clk_i);
            end
        end
    endtask

    // Ust seviye: gonder + echo'yu yakala (PARALEL -> yaris kapali)
    task automatic pc_uart_echo_check(input logic [7:0] tx_byte);
        logic [7:0] rx_byte;
        begin
            // recv ONCE silahlanir (@(negedge tx)'te bekler), send paralelde surer.
            fork
                pc_uart_recv(rx_byte);
                pc_uart_send(tx_byte);
            join
            if (rx_byte === tx_byte)
                $display("[TB] echo OK   : gonderilen=0x%02h  alinan=0x%02h  (t=%0t)",
                         tx_byte, rx_byte, $time);
            else
                $display("[TB] echo FAIL : gonderilen=0x%02h  alinan=0x%02h  (t=%0t)",
                         tx_byte, rx_byte, $time);
        end
    endtask

    // =================================================================
    //  ECHO TEST UYARANI
    // =================================================================
    initial begin
        // CPU'nun boot edip flasher moduna girmesini + uart_init()'i
        // bitirmesini bekle (baud ayarlanmadan bayt gondermeyelim).
        wait (GPIO_ODR[15:0] === FLASHER_READY);
        $display("\n======================================================================");
        $display("[TB] Flasher modu aktif (GPIO_ODR=0x%04h). UART echo testi basliyor...", GPIO_ODR[15:0]);
        $display("======================================================================\n");
        repeat (20) @(posedge clk_i);

        // MSB=0 ve MSB=1 KARISIK (REPORT-hold penceresinin iki halini de test et)
        pc_uart_echo_check(8'h55);   // 0101_0101  MSB=0 (uzun REPORT)
        pc_uart_echo_check(8'hA3);   // 1010_0011  MSB=1 (kisa REPORT)
        pc_uart_echo_check(8'h00);   // tum 0
        pc_uart_echo_check(8'hFF);   // tum 1
        pc_uart_echo_check(8'h7E);   // MSB=0
        pc_uart_echo_check(8'h81);   // MSB=1

        $display("\n======================================================================");
        $display("[TB] UART echo testi bitti. Yukarida FAIL yoksa: baud + TX/RX + bayrak");
        $display("[TB] temizleme sirasi DOGRU calisiyor.");
        $display("======================================================================\n");
        #100000000000;
        $finish;
    end

    // =================================================================
    //  Watchdog: takilirsa kilitlenmeden bitir
    // =================================================================
    initial begin
        #WATCHDOG;
        $display("\n======================================================================");
        $error("[TB] ZAMAN ASIMI! Echo tamamlanmadi. GPIO_ODR = 0x%08X", GPIO_ODR);
        $display("[TB]   - GPIO_ODR hic 0xF1A5 olmadiysa: CPU flasher moduna girmedi");
        $display("[TB]     (GPIO_IDR[0]=1 mi? boot ROM'a echo hex'i mi yuklendi?).");
        $display("[TB]   - Handshake gecti ama takildiysa: baud (CPB=416) ya da UART");
        $display("[TB]     bayrak temizleme sirasinda sorun olabilir.");
        $display("======================================================================\n");
        $finish;
    end

endmodule