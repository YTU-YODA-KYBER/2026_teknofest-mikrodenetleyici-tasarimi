`timescale 1ns / 1ps

// =====================================================================
//  TAM SISTEM TESTI  -  FLASHER + BOOT (ucdan uca, tek simulasyon)
//
//  Faz 1 (SW0=1, FLASHER):
//    - CPU flasher moduna girer, ppb_clean yapar, hazir olunca GPIO_ODR=0x0002.
//    - TB: LENGTH + minik app'i (4 komut) UART'tan yollar, chunk ACK'ini bekler.
//    - Flasher yazip dogrular: GPIO_ODR = 0x0003 (PASS) / 0x0004 (FAIL).
//
//  Faz 2 (SW0=0, BOOT):
//    - CPU reset'lenir (flash_vcc korunur -> flash icerigi kalir; non-volatile).
//    - Boot flash'tan minik app'i QOR ile okur, DMA ile INSTRRAM'e yazar,
//      0x10000000'a atlar.
//    - Minik app kosar: GPIO_ODR = 0x0123 yazip sonsuz donguye girer.
//    - TB GPIO_ODR=0x0123 gorurse: flasher->flash->boot->DMA->jump->execute
//      zincirinin TAMAMI dogrulanmis olur.
//
//  MINIK APP (flash'a yazilip INSTRRAM'de kosacak):
//    lui  a0,0x40010 ; addi a1,x0,0x123 ; sw a1,4(a0) ; j .
//    -> GPIO_ODR (0x40010004) = 0x123, sonra sonsuz dongu.
//
//  HAZIRLIK:
//    1) main.c'yi SIM icin derle:  make sim_main   (-DFLASHER_NO_ERASE)
//    2) build_main_sim/firmware.hex'i sim dizinine 'firmware.hex' olarak koy.
//    3) mem_Q512.vmf'i sim dizinine KOYMA! Flash 0xFF baslamali ki flasher
//       PP ile temiz yazabilsin (sim'de erase atlaniyor).
// =====================================================================

module tb_system;

    // ---- parametreler ----
    localparam int          CPB      = 416;        // clk/bit (C: UART_BAUD ile ayni)
    localparam logic [7:0]  ACK      = 8'h06;
    localparam logic [15:0] ST_READY = 16'h0002;   // flasher: LENGTH+veri bekliyorum
    localparam logic [15:0] ST_PASS  = 16'h0003;   // flasher: dogrulama OK
    localparam logic [15:0] ST_FAIL  = 16'h0004;   // flasher: dogrulama FAIL
    localparam logic [15:0] APP_MARK = 16'h0123;   // minik app'in yazdigi imza
    localparam time         WATCHDOG = 100_000_000;// 100 ms

    // ---- minik app: 4 komut, MSB-first gonderilecek ----
    localparam int APP_WORDS = 4;
    localparam int APP_LEN   = APP_WORDS * 4;      // 16 bayt
    logic [31:0] app_prog [0:APP_WORDS-1] = '{
        32'h40010537,   // lui  a0, 0x40010
        32'h12300593,   // addi a1, x0, 0x123
        32'h00B52223,   // sw   a1, 4(a0)
        32'h0000006F    // j    .
    };

    // ---- saat / reset ----
    logic clk_i  = 0;
    logic rst_ni = 0;

    // ---- UART ----
    logic UART_GU_rx = 1'b1;      // TB surer -> DUT
    logic UART_GU_tx;             // TB izler <- DUT

    // ---- interrupt (kullanilmiyor) ----
    logic [31:0] interrupt_i = 32'd0;
    logic [ 4:0] interrupt_id;
    logic        interrupt_ack;

    pullup (QSPI_IO2);
    pullup (QSPI_IO3);

    // ---- GPIO ----
    logic [31:0] GPIO_IDR = 32'd1;   // Faz 1: SW0=1 (flasher). Faz 2'de 0 yapilacak.
    logic [31:0] GPIO_ODR;

    // ---- I2C (kullanilmiyor) ----
    logic I2C_SCL;
    wire  I2C_SDA;
    pullup (I2C_SDA);

    // ---- QSPI ----
    wire QSPI_SCLK, QSPI_CS, QSPI_IO0, QSPI_IO1;

    // ---- flash besleme (Faz 2'de KORUNUR ki flash icerigi kalsin) ----
    logic [31:0] flash_vcc = 32'd0;

    // =================================================================
    //  DUT
    // =================================================================
    top_module #(
        .INIT_FILE_boot("firmware.hex")   // <-- build_main_sim/firmware.hex olmali!
    ) dut (
        .clk_i (clk_i), .rst_ni (rst_ni),
        .UART_RX (UART_GU_rx), .UART_TX (UART_GU_tx),
        .interrupt_i (interrupt_i), .interrupt_id (interrupt_id), .interrupt_ack(interrupt_ack),
        .GPIO_IDR (GPIO_IDR), .GPIO_ODR (GPIO_ODR),
        .I2C_SCL (I2C_SCL), .I2C_SDA (I2C_SDA),
        .QSPI_SCLK (QSPI_SCLK), .QSPI_CS (QSPI_CS),
        .QSPI_IO0 (QSPI_IO0), .QSPI_IO1 (QSPI_IO1),
        .QSPI_IO2 (QSPI_IO2), .QSPI_IO3 (QSPI_IO3)
    );

    // =================================================================
    //  Micron flash modeli  (Faz 1'de flasher yazar, Faz 2'de boot okur)
    // =================================================================
    N25Qxxx u_flash (
        .S (QSPI_CS), .C_ (QSPI_SCLK),
        .DQ0 (QSPI_IO0), .DQ1 (QSPI_IO1),
        .Vpp_W_DQ2 (QSPI_IO2), .HOLD_DQ3 (QSPI_IO3),
        .Vcc (flash_vcc), .RESET2 (1'b1)
    );

    // =================================================================
    //  48 MHz saat
    // =================================================================
    always #10.4166 clk_i = ~clk_i;

    // =================================================================
    //  UART task'lari (PC simulasyonu)
    // =================================================================
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

    task automatic pc_uart_recv(output logic [7:0] data);
        int i;
        begin
            @(negedge UART_GU_tx);
            repeat (CPB + CPB/2) @(posedge clk_i);
            for (i = 0; i < 8; i++) begin
                data[i] = UART_GU_tx;
                repeat (CPB) @(posedge clk_i);
            end
        end
    endtask

    // 32-bit word'u MSB-first 4 bayt gonder (flasher ilk bayti MSB alir)
    task automatic pc_uart_send_word(input logic [31:0] w);
        begin
            pc_uart_send(w[31:24]);
            pc_uart_send(w[23:16]);
            pc_uart_send(w[15:8]);
            pc_uart_send(w[7:0]);
        end
    endtask

    // =================================================================
    //  ANA TEST AKISI
    // =================================================================
    logic [7:0] ack;
    integer k;

    initial begin
        // ---------------- FAZ 1: FLASHER ----------------
        UART_GU_rx = 1'b1;
        GPIO_IDR   = 32'd1;          // SW0 = 1  -> flasher modu
        rst_ni     = 1'b0;
        flash_vcc  = 32'd3300;
        #1_000_000;
        rst_ni     = 1'b1;
        $display("\n[TB] === FAZ 1: FLASHER ===  reset birakildi @ %0t ns", $time);

        wait (GPIO_ODR[15:0] === ST_READY);
        $display("[TB] Flasher hazir (0x%04h). Minik app (%0d bayt) gonderiliyor...",
                 GPIO_ODR[15:0], APP_LEN);
        repeat (20) @(posedge clk_i);

        // LENGTH (MSB-first) + tek chunk (16 bayt) araliksiz
        pc_uart_send_word(APP_LEN);
        for (k = 0; k < APP_WORDS; k++)
            pc_uart_send_word(app_prog[k]);

        // chunk ACK
        pc_uart_recv(ack);
        if (ack !== ACK) $display("[TB] UYARI: ACK=0x06 bekleniyordu, gelen=0x%02h", ack);
        else             $display("[TB] chunk yazildi, ACK alindi @ %0t ns", $time);

        // flasher dogrulama sonucu
        wait (GPIO_ODR[15:0] === ST_PASS || GPIO_ODR[15:0] === ST_FAIL);
        if (GPIO_ODR[15:0] === ST_PASS)
            $display("[TB] FLASHER PASS (0x0003): app flash'a yazildi + dogrulandi.\n");
        else begin
            $display("[TB] FLASHER FAIL (0x0004)! Zincir burada kesildi.\n");
            #100; $finish;
        end

        // ---------------- FAZ 2: BOOT ----------------
        $display("[TB] === FAZ 2: BOOT ===");
        GPIO_IDR = 32'd0;            // SW0 = 0  -> boot modu
        // CPU'yu reset'le AMA flash_vcc'yi KORU (flash icerigi kalir)
        rst_ni = 1'b0;
        repeat (50) @(posedge clk_i);
        rst_ni = 1'b1;
        $display("[TB] CPU reset'lendi (flash korundu), boot basliyor @ %0t ns", $time);

        // boot: flash -> DMA -> INSTRRAM -> jump -> minik app kosar -> GPIO=0x123
        wait (GPIO_ODR[15:0] === APP_MARK);
        $display("[TB] Minik app kosuyor: GPIO_ODR=0x%04h @ %0t ns", GPIO_ODR[15:0], $time);

        $display("\n======================================================================");
        $display("[TB] >>> TAM SISTEM TESTI: BASARILI <<<");
        $display("[TB]   flasher -> flash -> boot -> DMA -> INSTRRAM -> jump -> execute");
        $display("======================================================================\n");
        #100;
        $finish;
    end

    // =================================================================
    //  Watchdog
    // =================================================================
    initial begin
        #WATCHDOG;
        $display("\n[TB] ZAMAN ASIMI! GPIO_ODR = 0x%08X @ %0t ns", GPIO_ODR, $time);
        $display("[TB]   Faz 1'de takildiysa: 0x0002 geldi mi? ACK/PASS? boot ROM'a sim_main mi yuklendi?");
        $display("[TB]   Faz 2'de takildiysa: 0x0123 gelmedi -> boot/DMA/jump zincirinde sorun,");
        $display("[TB]                        ya da flash reset'te icerigini kaybetti (flash_vcc?).");
        $finish;
    end

endmodule
