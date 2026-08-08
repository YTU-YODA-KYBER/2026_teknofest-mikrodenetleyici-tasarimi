`timescale 1ns / 1ps
// =====================================================================
//  tb_conv_accel.v -- conv_accelerator BAGIMSIZ dogrulama kosumu
//
//  Amac: sistem testini (Vivado) beklemeden, hizlandiricinin tek basina
//  fonksiyonel cikisini (4 FC skoru + sinif) ve start->done cevrim
//  sayisini olcmek. Optimizasyon oncesi/sonrasi BIT-EXACT karsilastirma
//  bu kosum uzerinden yapilir.
//
//  Girdi RAM'i, top_module'deki bram_yz ile ayni davranisi taklit eder:
//  senkron okuma, 1 cevrim gecikme.
//
//  Kullanim:
//    iverilog -o sim tb_conv_accel.v rtl/*.v
//    vvp sim +INPUT=input_data_yes.hex
// =====================================================================
module tb_conv_accel;

    localparam RAM_ADDR_W = 15;
    localparam N_BYTES    = 1960;

    reg clk = 1'b0;
    reg rst_n = 1'b0;
    always #10 clk = ~clk;          // 50 MHz (20 ns periyot), sistem TB ile ayni

    reg  start = 1'b0;
    wire done, busy;
    wire [RAM_ADDR_W-1:0] ram_addr;
    reg  [7:0]            ram_rdata;
    wire [12:0]           out_ram_addr;
    wire                  out_ram_wen;
    wire signed [7:0]     out_ram_wdata;

    // ---- Girdi RAM modeli (bram_yz ile ayni: senkron okuma, 1 cevrim) ----
    reg [7:0] ram [0:(1<<RAM_ADDR_W)-1];
    always @(posedge clk) ram_rdata <= ram[ram_addr];

    conv_accelerator #(.RAM_ADDR_W(RAM_ADDR_W)) dut (
        .clk(clk), .rst_n(rst_n),
        .start(start), .done(done), .busy(busy),
        .ram_addr(ram_addr), .ram_rdata(ram_rdata),
        .out_ram_addr(out_ram_addr), .out_ram_wen(out_ram_wen),
        .out_ram_wdata(out_ram_wdata)
    );

    // ---- Cevrim sayaci (sistem TB'siyle ayni yontem) ----
    integer cyc = 0;
    always @(posedge clk) if (rst_n) cyc <= cyc + 1;

    integer t_start_cyc, t_done_cyc;
    reg     started = 0, finished = 0;
    integer observed_class;

    always @(posedge clk) begin
        if (start && !started) begin
            t_start_cyc <= cyc; started <= 1'b1;
        end
        if (done && !finished) begin
            t_done_cyc <= cyc; finished <= 1'b1;
            observed_class <= out_ram_wdata;
        end
    end

    // ---- Kosum ----
    integer k;
    reg [1023:0] infile;
    integer run;
    initial begin
        if (!$value$plusargs("INPUT=%s", infile)) begin
            $display("HATA: +INPUT=<hex> verilmedi"); $finish;
        end

        for (k = 0; k < (1<<RAM_ADDR_W); k = k + 1) ram[k] = 8'h00;
        $readmemh(infile, ram, 0, N_BYTES-1);
        if (ram[0] === 8'hxx) begin
            $display("HATA: %0s okunamadi", infile); $finish;
        end

        repeat (5) @(posedge clk);
        rst_n = 1'b1;
        repeat (5) @(posedge clk);

        // ---- ARD ARDA IKI CIKARIM ----
        //  Ikincisi, devir notundaki "out_y son dalda sifirlanmali" tuzagini
        //  yakalar: durum sifirlanmazsa 2. cikarim 1.'den farkli cikar.
        for (run = 0; run < 2; run = run + 1) begin
            started = 0; finished = 0; observed_class = -1;

            @(posedge clk); start <= 1'b1;
            @(posedge clk); start <= 1'b0;

            wait (finished);
            @(posedge clk);

            $display("RUN=%0d FILE=%0s CLASS=%0d CYCLES=%0d S0=%0d S1=%0d S2=%0d S3=%0d",
                     run, infile, observed_class, t_done_cyc - t_start_cyc,
                     $signed(dut.fc_scores[0]), $signed(dut.fc_scores[1]),
                     $signed(dut.fc_scores[2]), $signed(dut.fc_scores[3]));

            repeat (10) @(posedge clk);
        end

        $finish;
    end

    // ---- Watchdog ----
    initial begin
        #200_000_000;   // 200 ms sim zamani = 10M cevrim
        $display("HATA: ZAMAN ASIMI");
        $finish;
    end

endmodule
