// =====================================================================
//  UART ECHO TESTI - Testbench task'lari + hazir sablon (PC simulasyonu)
//
//  Simulasyonda fiziksel switch/PC/USB YOK. Bu task'lar PC + seri kablo
//  rolunu oynar: rx'e frame surer, tx'i orta-noktadan ornekler.
//
//  KULLANIM: calisan tb_qspi_system.sv'ni kopyala, asagidaki 4 seyi ekle:
//    (1) uart_rx / uart_tx / sw_in TB sinyalleri
//    (2) DUT baglanti satirlari (.GPIO_IDR/.GPIO_ODR/.UART_GU_RX/.UART_GU_TX)
//    (3) bu task'lar
//    (4) alttaki initial blogu (mevcut stimulus initial'inin YERINE)
//    ve boot ROM $readmemh'ini build_echo/firmware.hex'e cevir.
//
//  NOT: 'clk' bu task'larda DUT saat neti olmali (senin TB'ndeki saat
//       sinyalinin adiyla ayni). Farkliysa ya rename et ya alias ver.
//       Saat PERIYODU echo dogrulugunu ETKILEMEZ: hem TB hem DUT bit
//       suresini CLOCK CYCLE cinsinden (CPB=416) sayiyor, ns cinsinden
//       degil. Yani 48 MHz de olsa baska bir deger de olsa, 416 cycle/bit
//       eslesmesi tuttugu surece echo dogru cikar.
// =====================================================================

localparam int CPB = 416;   // clock cycles per UART bit (C: UART_BAUD_CPB ile AYNI)

// ---- PC -> DUT: bir bayt gonder (LSB-first, 1 start + 8 data + 1 stop) ----
task automatic pc_uart_send(input logic [7:0] data);
    int i;
    begin
        uart_rx = 1'b0;                          // START
        repeat (CPB) @(posedge clk);
        for (i = 0; i < 8; i++) begin            // 8 DATA, LSB once
            uart_rx = data[i];
            repeat (CPB) @(posedge clk);
        end
        uart_rx = 1'b1;                          // STOP
        repeat (CPB) @(posedge clk);
    end
endtask

// ---- DUT -> PC: bir bayt yakala (tx'i orta-noktadan ornekle) ----
task automatic pc_uart_recv(output logic [7:0] data);
    int i;
    begin
        @(negedge uart_tx);                      // START'i yakala (1->0)
        repeat (CPB + CPB/2) @(posedge clk);     // ilk data bitinin ORTASINA (1.5 bit)
        for (i = 0; i < 8; i++) begin            // 8 DATA, LSB once
            data[i] = uart_tx;
            repeat (CPB) @(posedge clk);
        end
    end
endtask

// ---- Ust seviye: gonder + echo'yu yakala (PARALEL: yaris kapali) ----
task automatic pc_uart_echo_check(input logic [7:0] tx_byte);
    logic [7:0] rx_byte;
    begin
        // fork: recv ONCE silahlanir (@(negedge tx)'te bekler), send paralelde surer.
        // Echo en erken ~8.5 bit sonra basladigi icin recv coktan hazir olur.
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

