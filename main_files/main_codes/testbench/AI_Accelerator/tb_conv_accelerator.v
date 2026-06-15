`timescale 1ns / 1ps

module tb_conv_accelerator();

    // --- Sinyaller ---
    reg clk;
    reg rst_n;
    reg start;
    wire done;
    wire busy;
    
    wire [10:0] ram_addr;
    wire signed [7:0] ram_rdata;
    
    wire [12:0] out_ram_addr;
    wire out_ram_wen;
    wire signed [7:0] out_ram_wdata;

    // --- Sahte Giriş Belleği (1960 byte'lık spektrogram verisi) ---
    reg signed [7:0] input_mem [0:1959];
    
    // Kombinasyonel okuma
    assign ram_rdata = input_mem[ram_addr];

    // --- Modülü Çağır ---
    conv_accelerator uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .done(done),
        .busy(busy),
        .ram_addr(ram_addr),
        .ram_rdata(ram_rdata),
        .out_ram_addr(out_ram_addr),
        .out_ram_wen(out_ram_wen),
        .out_ram_wdata(out_ram_wdata)
    );

    // --- Clock Üreteci (100 MHz) ---
    always #5 clk = ~clk;

    // --- Test Senaryosu ---
    initial begin
        clk   = 0;
        rst_n = 0;
        start = 0;
        
        // Gerçek ses verisini dosyadan oku
        $readmemh("input_data.hex", input_mem);
        $display("Giriş verisi 'input_data.hex' dosyasından yüklendi.");

        #20;
        rst_n = 1;
        
        #20;
        start = 1;
        #10;
        start = 0;

        $display("Hızlandırıcı çalışıyor...");
        wait(done == 1);
        
        #50;
        $display("=== SİMÜLASYON TAMAMLANDI ===");
        $finish;
    end

    // --- Sonucu Yakalama ---
    always @(posedge clk) begin
        if (out_ram_wen && out_ram_addr == 13'd0) begin
            $display("\n---------------------------------------------------");
            $display(">>> HIZLANDIRICI SINIFLANDIRMAYI BİTİRDİ! <<<");
            $display(">>> ÇIKTI DEĞERİ (SKOR): %d", out_ram_wdata);
            
            if      (out_ram_wdata == 0) $display(">>> TAHMİN EDİLEN: Sessizlik");
            else if (out_ram_wdata == 1) $display(">>> TAHMİN EDİLEN: Bilinmeyen Kelime");
            else if (out_ram_wdata == 2) $display(">>> TAHMİN EDİLEN: Evet (Yes)");
            else if (out_ram_wdata == 3) $display(">>> TAHMİN EDİLEN: Hayır (No)");
            else                         $display(">>> HATA: Beklenmeyen sınıf değeri!");
            
            $display("---------------------------------------------------\n");
        end
    end

endmodule