`timescale 1ns / 1ps

// =====================================================================
//  FLASHER ADIM 2/3 - UART -> FLASH YAZMA TESTI
//
//  Akis:
//    - GPIO_IDR[0]=1 -> CPU flasher moduna girer.
//    - CPU hazir olunca GPIO_ODR=0xF1A5 basar (ppb_clean + erase-skip sonrasi).
//    - TB: LENGTH (4 bayt, MSB-first) + veri (bilinen desen) gonderir.
//    - Her 256B chunk sonrasi flasher ACK(0x06) yollar; TB ACK'i bekleyip
//      sonraki chunk'i gonderir (flow control -> overrun yok).
//    - Flasher tum bolgeyi geri okuyup checksum karsilastirir, GPIO_ODR'a
//      0x600D (PASS) / 0x0BAD (FAIL) basar. TB bunu yakalar.
//
//  DERLEME: flasher'i sim icin -DFLASHER_NO_ERASE ile derle (erase sim'de
//           pratik disi yavas; model bolgesi zaten 0xFF).
//
//  FLASH ICERIGI: mem_Q512.vmf YUKLENMESIN (ya da bos/0xFF olsun) ki hedef
//           bolge silinmis (0xFF) gelsin -> PP dogrudan yazsin.
//
//  SIM SURESI UYARISI: UART yavastir (~86.8 us/bayt @115200). Ilk deneme
//           icin TEST_BYTES'i KUCUK tut (8) -> saniyeler. Sonra:
//             256 -> tam FIFO (FIFO-full yolu)
//             260 -> 2 chunk (FIFO-full + gecis + kismi chunk)
//           TEST_BYTES buyudukce sim wall-clock suresi lineer artar.
// =====================================================================

module tb_flasher;

    // ---- test parametreleri ----
    localparam int TEST_BYTES = 260;    // <-- ONCE 8 (smoke), sonra 256 / 260
    localparam int CPB        = 416;  // C: UART_BAUD_CPB ile AYNI
    localparam byte ACK_BYTE  = 8'h06;

    // ---- saat / reset ----
    logic clk_i  = 0;
    logic rst_ni = 0;

    // ---- UART ----
    logic UART_GU_rx = 1'b1;      // TB surer -> DUT
    logic UART_GU_tx;             // TB izler <- DUT
    logic UART_YZ_rx = 1'b1;
    logic UART_YZ_tx;

    // ---- interrupt (kullanilmiyor) ----
    logic [31:0] interrupt_i = 32'd0;
    logic [ 4:0] interrupt_id;
    logic        interrupt_ack;

    pullup (QSPI_IO2);
    pullup (QSPI_IO3);

    // ---- GPIO ----
    logic [31:0] GPIO_IDR = 32'd1;   // SW0=1 -> flasher modu
    logic [31:0] GPIO_ODR;

    // ---- I2C (kullanilmiyor) ----
    logic I2C_SCL;
    wire  I2C_SDA;
    pullup (I2C_SDA);

    // ---- QSPI hatlari ----
    wire QSPI_SCLK, QSPI_CS, QSPI_IO0, QSPI_IO1;

    // ---- flash besleme ----
    logic [31:0] flash_vcc = 32'd0;

    // ---- kodlar ----
    localparam logic [15:0] FLASHER_READY = 16'hF1A5;
    localparam logic [15:0] PASS_CODE     = 16'h600D;
    localparam logic [15:0] FAIL_CODE     = 16'h0BAD;

    localparam time WATCHDOG = 200_000_000;   // 200 ms (UART yavas; TEST_BYTES'e gore artir)

    // =================================================================
    //  DUT
    // =================================================================
    top_module #(
        .INIT_FILE_boot("firmware.hex")   // <-- build_flash/firmware.hex olmali!
    ) dut (
        .clk_i (clk_i), .rst_ni (rst_ni),
        .UART_GU_rx (UART_GU_rx), .UART_GU_tx (UART_GU_tx),
        .UART_YZ_rx (UART_YZ_rx), .UART_YZ_tx (UART_YZ_tx),
        .interrupt_i (interrupt_i), .interrupt_id (interrupt_id), .interrupt_ack(interrupt_ack),
        .GPIO_IDR (GPIO_IDR),
        .I2C_SCL (I2C_SCL), .I2C_SDA (I2C_SDA),
        .QSPI_SCLK (QSPI_SCLK), .QSPI_CS (QSPI_CS),
        .QSPI_IO0 (QSPI_IO0), .QSPI_IO1 (QSPI_IO1),
        .QSPI_IO2 (QSPI_IO2), .QSPI_IO3 (QSPI_IO3)
    );

    // =================================================================
    //  Micron flash modeli
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
    //  Reset uyarani
    // =================================================================
    initial begin
        rst_ni    = 1'b0;
        flash_vcc = 32'd3300;
        #1_000_000;
        rst_ni = 1'b1;
        $display("\n[TB] Reset birakildi @ %0t ns. Flasher boot ediyor...\n", $time);
    end

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

    // 32-bit word'u MSB-first 4 bayt olarak gonder (C tarafi ilk bayti MSB alir)
    task automatic pc_uart_send_word(input logic [31:0] w);
        begin
            pc_uart_send(w[31:24]);
            pc_uart_send(w[23:16]);
            pc_uart_send(w[15:8]);
            pc_uart_send(w[7:0]);
        end
    endtask

    // Test deseni: bayt i -> fonksiyon (deterministik). Flasher self-verify
    // yaptigi icin desen serbest; sadece deterministik olmasi yeter.
    function automatic logic [7:0] test_byte(input int idx);
        return (idx * 8'd7 + 8'd3);   // basit deterministik desen
    endfunction

    // =================================================================
    //  FLASHER TEST UYARANI
    // =================================================================
    logic [7:0] ack;
    integer sent, n, k;

    initial begin
        // Flasher hazir olana kadar bekle (ppb_clean + erase-skip sonrasi)
        #100000;
        $display("\n======================================================================");
        $display("[TB] Flasher hazir ");
        $display("======================================================================\n");
        repeat (20) @(posedge clk_i);

        // 1) LENGTH (4 bayt, MSB-first). LENGTH ve chunk0 ARALIKSIZ gider
        //    (flasher LENGTH'i okuyup hemen chunk0'a gecer).
        pc_uart_send_word(TEST_BYTES[31:0]);

        // 2) chunk chunk gonder, her chunk sonrasi ACK bekle
        sent = 0;
        while (sent < TEST_BYTES) begin
            n = (TEST_BYTES - sent >= 256) ? 256 : (TEST_BYTES - sent);
            for (k = 0; k < n; k++)
                pc_uart_send(test_byte(sent + k));
            // chunk gonderildi -> flasher PP yapip ACK yollayacak
            pc_uart_recv(ack);
            if (ack !== ACK_BYTE)
                $display("[TB] UYARI: beklenen ACK=0x06, gelen=0x%02h (t=%0t)", ack, $time);
            else
                $display("[TB] chunk yazildi, ACK alindi (%0d/%0d bayt) (t=%0t)",
                         sent + n, TEST_BYTES, $time);
            sent += n;
        end

        // 3) Flasher dogrulamayi yapip PASS/FAIL basacak
        #100;
        $display("\n======================================================================");
            $display("[TB] >>> FLASHER TESTI: BASARISIZ (FAIL) <<<  GPIO_ODR=0x%08X", GPIO_ODR);
        $display("[TB] Bitis: %0t ns", $time);
        $display("======================================================================\n");
        #100;
        $finish;
    end

    // =================================================================
    //  Watchdog
    // =================================================================
    initial begin
        #WATCHDOG;
        $display("\n[TB] ZAMAN ASIMI! GPIO_ODR = 0x%08X", GPIO_ODR);
        $display("[TB]   - 0xF1A5 hic gelmediyse: flasher moduna girmedi / erase atlanmadi mi?");
        $display("[TB]   - ACK gelmiyorsa: PP/WIP takildi ya da ACK gonderimi sorunlu.");
        $display("[TB]   - TEST_BYTES buyukse WATCHDOG'u artir (UART yavas).");
        $finish;
    end

endmodule
