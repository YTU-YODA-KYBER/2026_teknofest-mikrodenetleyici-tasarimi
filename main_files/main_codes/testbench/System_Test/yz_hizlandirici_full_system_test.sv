// =====================================================================
//  tb_system_diag.sv  -  Ucdan uca tanisal testbench  (DUZELTILMIS)
//
//  DUZELTME OZETI:
//   (1) GPIO_IDR[DMA_EN_BIT] = 1  satiri ARTIK GERCEKTEN SURULUYOR.
//       Eski kodda bu satir yorumdaydi ($display yaliyordu). Sonucu:
//       uart_mux, fiziksel UART_RX'i UART_YZ_RX yerine UART_GU_RX'e
//       yonlendiriyordu -> UART_YZ_RX sabit 1'de kaliyor, hicbir bayt
//       YZ tarafina ulasmıyor, DMA da (dma_enable_i=0) yazmiyordu.
//   (2) I2C/QSPI inout portlari acikca tie-off edildi (elaborasyon +
//       'z/x kaynakli takilmalari onlemek icin).
//   (3) fc_scores[0..3] PROBE'u eklendi: ARGMAX aninda 4 sinif skorunu
//       basar. Kart uzerindeki ILA ciktisi ile BUNU karsilastiracaksin.
// =====================================================================
`timescale 1ns / 1ps

module tb_system_diag;

    // ---- AYARLA 1: sistem saati ve UART bit suresi ----
    localparam int CLK_PERIOD   = 20;      // 50 MHz -> 20 ns
    localparam int CLKS_PER_BIT = 434;     // 50e6/115200 ~= 434

    // ---- AYARLA 2: hangi ses dosyasi + beklenen 7-seg degeri ----
    localparam string HEX_FILE     = "input_data_yes.hex";
    localparam int    EXPECTED_ODR = 7;    // yes->7, no->8, sessizlik->9

    // ---- AYARLA 3: dma_enable'i (SW1) suren GPIO_IDR biti ----
    //  DIKKAT: bu bit HEM uart_mux'in select'ini HEM de GPIO'nun
    //  dma_enable_o'sunu suren bit ile AYNI olmali. uart_mux ve
    //  GPIO_AXI4_Lite kodunda hangi biti okuyorsan onu yaz.
    localparam int DMA_EN_BIT = 1;

    localparam int N_BYTES = 1960;
    localparam int TIMEOUT_NS = 500_000_000;

    // ---- Sinyaller ----
    logic clk_i = 0;
    logic rst_ni = 0;
    logic UART_RX = 1;          // FPGA RX (idle = 1)
    logic UART_TX;
    logic [31:0] GPIO_IDR = 0;
    logic [31:0] GPIO_ODR;
    logic [7:0]  anode, catode;

    // I2C / QSPI tie-off (inout'lari serbest birakma)
    wire  I2C_SCL;
    wire  I2C_SDA;
    pullup(I2C_SDA);            // I2C hatti idle=1
    wire  QSPI_SCLK, QSPI_CS, QSPI_IO0, QSPI_IO1, QSPI_IO2, QSPI_IO3;

    // ---- Saat ----
    always #(CLK_PERIOD/2) clk_i = ~clk_i;

    // =================================================================
    //  DUT
    // =================================================================
    top_module dut (
        .clk_i    (clk_i),
        .rst_ni   (rst_ni),
        .GPIO_IDR (GPIO_IDR),
        .GPIO_ODR (GPIO_ODR),
        .anode    (anode),
        .catode   (catode),
        .UART_TX  (UART_TX),
        .UART_RX  (UART_RX),
        .I2C_SCL  (I2C_SCL),
        .I2C_SDA  (I2C_SDA),
        .QSPI_SCLK(QSPI_SCLK),
        .QSPI_CS  (QSPI_CS),
        .QSPI_IO0 (QSPI_IO0),
        .QSPI_IO1 (QSPI_IO1),
        .QSPI_IO2 (QSPI_IO2),
        .QSPI_IO3 (QSPI_IO3)
    );

    // ---- Ses verisi (1960 bayt) ----
    logic [7:0] audio [0:N_BYTES-1];
    initial $readmemh(HEX_FILE, audio);

    // ---- UART TX task: 1 bayt, 8N1, LSB-first ----
    task automatic uart_send_byte(input [7:0] b);
        int i;
        begin
            UART_RX = 1'b0;                                 // start bit
            repeat (CLKS_PER_BIT) @(posedge clk_i);
            for (i = 0; i < 8; i++) begin                   // 8 veri biti (LSB first)
                UART_RX = b[i];
                repeat (CLKS_PER_BIT) @(posedge clk_i);
            end
            UART_RX = 1'b1;                                 // stop bit
            repeat (CLKS_PER_BIT) @(posedge clk_i);
        end
    endtask

    // =================================================================
    //  ANA SENARYO
    // =================================================================
    integer k;
    initial begin
        $display("[TB] Reset...");
        UART_RX = 1'b1;                 // idle
        rst_ni  = 1'b0;
        repeat (20) @(posedge clk_i);
        rst_ni  = 1'b1;
        repeat (50) @(posedge clk_i);   // CPU boot + irq_init + for(;;)

        // >>> KRITIK DUZELTME: SW1'i GERCEKTEN sur (eskiden yorumdaydi) <<<
        GPIO_IDR[DMA_EN_BIT] = 1'b1;    // SW1=1 -> uart_mux YZ'ye baglar + dma_enable
        $display("[TB] dma_enable (GPIO_IDR[%0d]) = 1  [ARTIK GERCEKTEN SURULUYOR]", DMA_EN_BIT);
        repeat (10) @(posedge clk_i);

        $display("[TB] %0d bayt gonderiliyor (%s)...", N_BYTES, HEX_FILE);
        for (k = 0; k < N_BYTES; k++) begin
            uart_send_byte(audio[k]);
            if (k % 400 == 0) $display("[TB]   %0d/%0d bayt", k, N_BYTES);
        end
        $display("[TB] Tum baytlar gonderildi. Sonuc bekleniyor...");

        wait (GPIO_ODR[15:0] == EXPECTED_ODR);
        $display("[TB] ====== BASARILI: GPIO_ODR = %0d (beklenen %0d) ======",
                 GPIO_ODR[15:0], EXPECTED_ODR);
        repeat (100) @(posedge clk_i);
        $finish;
    end

    // ---- Timeout watchdog ----
    initial begin
        #(TIMEOUT_NS);
        $display("[TB] ====== TIMEOUT: GPIO_ODR son deger = %0d (beklenen %0d) ======",
                 GPIO_ODR[15:0], EXPECTED_ODR);
        $finish;
    end

    // ---- GPIO_ODR her degistiginde bas ----
    initial $monitor("[TB] t=%0t  GPIO_ODR=%0d", $time, GPIO_ODR[15:0]);

    // =================================================================
    //  PROBE  (kendi hiyerarsine gore instance isimlerini dogrula)
    // =================================================================
    // 1) UART -> bellek: DMA gercekten yaziyor mu?
    always @(posedge clk_i)
        if (dut.uart_yz_inst.dma_valid_o)
            $display("[P1] t=%0t  dma_valid, data=%02x", $time, dut.uart_yz_inst.dma_data_o);

    // 1b) uart_mux dogru yonlendirdi mi? (RX gercekten YZ'ye gidiyor mu)
    always @(posedge clk_i)
        if (dut.UART_YZ_RX !== 1'b1)   // idle'dan ciktiysa veri geliyor demektir
            ; // istersen buraya display koy; spam yapmasin diye bos

    // 2) 1960 bayt doldu mu, load_done atesledi mi?
    always @(posedge dut.yz_bram_ctrl_inst.load_done_irq)
        $display("[P2] t=%0t  LOAD_DONE atesledi (addr_cnt=%0d)", $time,
                 dut.yz_bram_ctrl_inst.addr_cnt);

    // 3) CPU hizlandiriciyi baslatti mi?
    always @(posedge dut.conv_accelerator_inst.start)
        $display("[P3] t=%0t  ACCEL START", $time);

    // 4) Cikarim bitti mi?
    always @(posedge dut.conv_accelerator_inst.done)
        $display("[P4] t=%0t  ACCEL DONE, sinif=%0d", $time,
                 dut.conv_accelerator_inst.out_ram_wdata);

    // 5) infer interrupt CPU'ya gitti mi?
    always @(posedge dut.yz_csr_wrapper_inst.infer_irq)
        $display("[P5] t=%0t  INFER_IRQ (CPU'ya)", $time);

    // >>> 6) KART ILE KARSILASTIRMA ICIN: 4 sinif skoru (ARGMAX aninda) <<<
    //  ARGMAX state'ine girildigi cycle'da fc_scores dolu olur.
    //  localparam ARGMAX=12 (conv_accelerator.v'deki deger).
    always @(posedge clk_i)
        if (dut.conv_accelerator_inst.state == 4'd12) begin
            $display("[P6] t=%0t  FC_SCORES: [0]=%0d  [1]=%0d  [2]=%0d  [3]=%0d",
                     $time,
                     $signed(dut.conv_accelerator_inst.fc_scores[0]),
                     $signed(dut.conv_accelerator_inst.fc_scores[1]),
                     $signed(dut.conv_accelerator_inst.fc_scores[2]),
                     $signed(dut.conv_accelerator_inst.fc_scores[3]));
        end

    // ---- Dalga formu ----
    initial begin
        $dumpfile("tb_system_diag.vcd");
        $dumpvars(0, tb_system_diag);
    end

endmodule