// ===========================================================================
//  OTOMATIK URETILMIS YAMALI KOPYA -- ELLE DUZENLEME
//
//  Ureten : asic/scripts/patch_rtl.py
//  Kaynak : main_codes/rtl/desgin_sources/Peripherals/UART_GU/UART_GU_AXI4-Lite.sv
//  SHA256 : 2d540c7d2768e414cdda057eeac1348763ec0251e95cda0c73ab21f16c88466a
//
//  Orijinal dosyaya DOKUNULMAMISTIR. ASIC akisi (asic/filelist.f) orijinalin
//  yerine bu kopyayi kullanir; FPGA/Vivado akisi orijinali kullanmaya devam eder.
//
//  YAPILAN DEGISIKLIK: AXI4-Lite yanit kodlari (RRESP/BRESP) yalnizca reset dalinda 0 atanmisti,
//    baska hicbir yerde atanmadigi icin cikislar SURULMEYEN sinyal olarak
//    kaliyordu. Reset atamalari kaldirilip yerine surekli atama konuldu:
//    deger her zaman 2'b00 (OKAY) -- yani davranis birebir aynidir, ama
//    artik cikisin acik bir surucusu var.
// ===========================================================================

module UART_GU_AXI4_Lite (
    // clock ve reset sinyalleri
    input  logic clk,
    input  logic rst_n,

    // AW Portları
    input  logic [31:0] awaddr,
    input  logic        awvalid,
    output logic        awready,

    // WD Portları
    input  logic [31:0] wdata,
    input  logic        wvalid,
    output logic        wready,

    // B Portları
    output logic [ 1:0] bresp,
    output logic        bvalid,
    input  logic        bready,

    // AR Portları
    input  logic [31:0] araddr,
    input  logic        arvalid,
    output logic        arready,

    // R Portları
    input  logic        rready,
    output logic [31:0] rdata,
    output logic [ 1:0] rresp,
    output logic        rvalid,

    input  logic  rx,
    output logic  tx
);
    
    localparam [1:0] IDLE   = 0;
    localparam [1:0] WAIT   = 1;
    localparam [1:0] DATA   = 2;
    localparam [1:0] STOP   = 3;
    localparam [1:0] REPORT = 3;

    logic [ 2:0] UART_CFG;
    logic [ 7:0] UART_TDR;
    logic [ 7:0] UART_RDR;
    logic [31:0] UART_CPB;
    logic [ 1:0] UART_STP;


    logic [1:0] tx_state;         // TX FSM'sinin durumu
    logic [1:0] rx_state;         // RX FSM'sinin durumu
    
    logic [ 3:0] tx_shift_cnt;    // Gönderilen bit sayısını saymak için kullanılır
    logic [ 3:0] rx_shift_cnt;    // Alınan bit sayısını saymak için kullanılır

    logic [15:0] tx_tick_cnt;        // Baud rate'i belirlemek için kullanılan sayaç
    logic [31:0] rx_tick_cnt;        // Baud rate'i belirlemek için kullanılan sayaç
    logic [15:0] tx_tick_cnt_limit;  // Baud rate'i belirlemek için kullanılan sayaç limiti

    logic [ 1:0] stop_bit;        // Stop bit sayısını takip etmek için kullanılır
    
    logic        tx_middle_alert;    // TX işlemi sırasında orta noktaya gelindiğinde uyarı vermek için kullanılır
    logic        rx_middle_alert;    // RX işlemi sırasında orta noktaya gelindiğinde uyarı vermek için kullanılır
    logic        tx_zero_alert;      // TX işlemi sırasında bit sayısı sıfırlandığında uyarı vermek için kullanılır
    logic rx_meta, rx_sync;

    // ---------------------------------------------------------
    //                  TX BAUDRATE GENERATOR
    // ---------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            tx_tick_cnt     <= 0;
            tx_zero_alert   <= 0;
            tx_middle_alert <= 0;
        end
        else begin
            if (tx_tick_cnt >= UART_CPB - 1) begin
                tx_tick_cnt     <= 0;
                tx_zero_alert   <= 1'b1;   // bit sınırı: her TAM UART_CPB clock'ta bir (1 cycle pulse)
                tx_middle_alert <= 1'b0;
            end
            else begin
                tx_tick_cnt     <= tx_tick_cnt + 1;
                tx_zero_alert   <= 1'b0;
                tx_middle_alert <= (tx_tick_cnt == (UART_CPB >> 1)); // bit ortası (sadece STP>0 için lazım)
            end
        end
    end

    // ---------------------------------------------------------
    //                  RX BAUDRATE GENERATOR
    // ---------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rx_tick_cnt     <= 0;
            rx_middle_alert <= 0;
        end
        else begin
            rx_middle_alert <= 0;
            case (rx_state)
                IDLE: rx_tick_cnt <= 0;
                WAIT: begin
                    if (UART_CPB != 0 && rx_tick_cnt >= UART_CPB + (UART_CPB >> 1) - 1) begin
                        rx_tick_cnt     <= 0;
                        rx_middle_alert <= 1;
                    end else begin
                        rx_tick_cnt <= rx_tick_cnt + 1;
                    end
                end
                DATA: begin
                    if (UART_CPB != 0 && rx_tick_cnt >= UART_CPB - 1) begin
                        rx_tick_cnt     <= 0;
                        rx_middle_alert <= 1;
                    end else begin
                        rx_tick_cnt <= rx_tick_cnt + 1;
                    end
                end
                default: rx_tick_cnt <= 0;
            endcase
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rx_meta <= 1'b1;      // idle-high ile başla
            rx_sync <= 1'b1;
        end else begin
            rx_meta <= rx;        // 1. kademe (metastable olabilir)
            rx_sync <= rx_meta;   // 2. kademe (kararlı)
        end
    end

    // ---------------------------------------------------------
    //                  AXI YAZMA/OKUMA IŞLEMLERİ           
    // ---------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            UART_CFG <= 0;
            UART_TDR <= 0;
            UART_RDR <= 0;
            UART_CPB <= 0;
            UART_STP <= 0;

            stop_bit <= 0;

            tx_shift_cnt <= 0;
            rx_shift_cnt <= 0;

            tx_state <= IDLE;
            rx_state <= IDLE;

            bvalid  <= 0;
            rvalid  <= 0;
            rdata   <= 0;

            awready <= 1;
            wready  <= 1;
            arready <= 1;

            tx      <= 1;

        end else begin

            // --- AXI YAZMA İŞLEMİ ---
            if (awvalid && wvalid && awready && wready) begin
                bvalid  <= 1'b1;
                awready <= 1'b0; 
                wready  <= 1'b0;
                
                case (awaddr[7:0])
                    8'h00: UART_CPB <= wdata;
                    8'h04: UART_STP <= wdata[1:0];
                    8'h0C: UART_TDR <= wdata;
                    8'h10: UART_CFG <= wdata;
                endcase
            end 
            else if (bvalid && bready) begin
                bvalid  <= 1'b0;
                awready <= 1'b1; 
                wready  <= 1'b1;
            end


            // --- AXI OKUMA İŞLEMİ ---
            if (arvalid && arready) begin
                rvalid  <= 1'b1;
                arready <= 1'b0; 
                
                case (araddr[7:0])
                    8'h00: rdata <= UART_CPB;
                    8'h04: rdata <= {29'h0, UART_STP};   
                    8'h08: rdata <= UART_RDR; 
                    8'h0C: rdata <= UART_TDR;
                    8'h10: rdata <= UART_CFG;

                endcase
            end 
            else if (rvalid && rready) begin
                rvalid  <= 1'b0;
                arready <= 1'b1; 
            end



        // ---------------------------------------------------------
        //                        TX BLOĞU
        // ---------------------------------------------------------
        if(!stop_bit) begin
            if(tx_zero_alert)begin
                case (tx_state)
                    IDLE: begin
                        if (UART_CFG[0]) begin
                            tx <= 0;
                            tx_state <= DATA;
                            tx_shift_cnt <= 0;
                        end
                    end
                    DATA: begin
                        if (tx_shift_cnt == 7) tx_state <= STOP;

                        tx <= UART_TDR[tx_shift_cnt];
                        tx_shift_cnt <= tx_shift_cnt + 1;
                    end
                    STOP: begin
                        tx <= 1;
                        UART_CFG[2] <= 1;
                        UART_CFG[0] <= 0;
                        tx_state <= IDLE;
                        if(UART_STP == 3) stop_bit <= 2;
                        else stop_bit <= UART_STP;
                    end
                endcase
            end
        end
        else begin
            if(tx_middle_alert || tx_zero_alert) stop_bit <= stop_bit - 1;
        end


        // ---------------------------------------------------------
        //                         RX BLOĞU
        // ---------------------------------------------------------
            case (rx_state)
                IDLE : begin
                    if(rx_sync == 0) rx_state <= WAIT;
                end

                WAIT : begin
                    if(rx_middle_alert) begin
                        UART_RDR[0] <= rx_sync;
                        rx_state <= DATA;
                        rx_shift_cnt <= 1;
                    end
                end

                DATA: begin
                    if(rx_middle_alert) begin
                        UART_RDR[rx_shift_cnt] <= rx_sync;
                        if(rx_shift_cnt == 7) rx_state <= REPORT;
                        else rx_shift_cnt <= rx_shift_cnt + 1;
                    end
                end

                REPORT: begin
                    if(rx_sync)begin
                        rx_state <= IDLE;
                        UART_CFG[1] <= 1;
                    end
                end
            endcase

        end
    end
    // ASIC yamasi: bkz. dosya basi
    assign bresp = 2'b00;   // AXI OKAY
    // ASIC yamasi: bkz. dosya basi
    assign rresp = 2'b00;   // AXI OKAY

endmodule
