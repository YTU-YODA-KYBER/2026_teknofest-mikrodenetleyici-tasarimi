`timescale 1ns / 1ps

module ai_system_top (
    input wire clk,           // Sistemin ana saati (Örn: 100 MHz)
    input wire reset,         // Reset butonu (Active-High)
    input wire rx,            // PC'den gelen UART (USB) veri pini
    output reg [1:0] result,  // Tahmin sonucu (LED'lere bağlanacak 0,1,2,3)
    output wire ai_done       // İşlem bitti sinyali (Bunu da bir LED'e bağlayabilirsin)
);

    // --- İÇ KABLOLAR (Modülleri birbirine bağlayan yollar) ---
    wire [7:0] rx_data_wire;
    wire rx_done_wire;
    
    wire ai_start_wire;
    wire [10:0] mem_read_addr_wire;
    wire [7:0] mem_read_data_wire;
    
    wire [12:0] out_addr_wire;
    wire out_wen_wire;
    wire [7:0] out_data_wire;

    // 1. UART ALICISI (Kulak - PC'den .hex okur)
    uart_rx #(
        .CLK_FREQ(100_000_000), 
        .BAUD_RATE(115200)
    ) receiver_inst (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data_out(rx_data_wire),
        .rx_done(rx_done_wire)
    );

    // 2. ÖZELLİK BELLEĞİ (BRAM - 1960 veriyi depolar)
    feature_memory memory_inst (
        .clk(clk),
        .reset(reset),
        .uart_rx_done(rx_done_wire),
        .uart_data(rx_data_wire),
        .ai_start(ai_start_wire),               // 1960. byte gelince Çekirdeği tetikler
        .read_addr(mem_read_addr_wire),         
        .read_data(mem_read_data_wire)          
    );

    // 3. YAPAY ZEKA ÇEKİRDEĞİ (Senin Eserin!)
    // AXI wrapper'ı aradan çıkardık, doğrudan beyni bağladık.
    conv_accelerator ai_core_inst (
        .clk(clk),
        .rst_n(~reset),                      // Çekirdeğin active-low reset beklediği için tersledik
        .start(ai_start_wire),               // BRAM'den gelen başla emri
        .done(ai_done),                      // Bittiğinde 1 olur
        .busy(),                             // İstersen dışarı alabilirsin
        
        // BRAM'den Veri Çekme Arayüzü
        .ram_addr(mem_read_addr_wire),       // Çekirdek adresi sorar
        .ram_rdata(mem_read_data_wire),      // BRAM o adresteki veriyi verir
        
        // Sonuçları Yazma Arayüzü
        .out_ram_addr(out_addr_wire),
        .out_ram_wen(out_wen_wire),
        .out_ram_wdata(out_data_wire)
    );

    // 4. SONUÇ YAKALAYICI (Tahmin sonucunu LED'lere aktar)
    always @(posedge clk) begin
        if (reset) begin
            result <= 2'b00;
        end else if (out_wen_wire) begin
            // Hızlandırıcın bir sonuç yazdığında o veriyi "result" çıkışına (LED'lere) kilitler
            result <= out_data_wire[1:0]; 
        end
    end

endmodule