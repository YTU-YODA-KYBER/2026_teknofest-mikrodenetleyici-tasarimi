`timescale 1ns/1ps
// Teslimde asic/ altinda testbench bulunmamasi gerektigi icin ASIC RTL test agacindadir.

module tb_data_bram_collision;
    localparam int AW = 11;
    logic clk = 0;
    logic rst_n = 0;
    always #10 clk = ~clk;

    logic [31:0] awaddr, wdata, araddr;
    logic awvalid, awready, wvalid, wready, bvalid, bready;
    logic [3:0] wstrb;
    logic [1:0] bresp, rresp;
    logic arvalid, arready, rvalid, rready;
    logic [31:0] rdata;

    data_bram_axi_ctrl #(.DATA_WIDTH(32), .ADDR_WIDTH(AW)) dut (
        .clk_i(clk), .rst_n(rst_n),
        .axi_data_bram_awaddr(awaddr), .axi_data_bram_awvalid(awvalid),
        .axi_data_bram_awready(awready),
        .axi_data_bram_wdata(wdata), .axi_data_bram_wstrb(wstrb),
        .axi_data_bram_wvalid(wvalid), .axi_data_bram_wready(wready),
        .axi_data_bram_bresp(bresp), .axi_data_bram_bvalid(bvalid),
        .axi_data_bram_bready(bready),
        .axi_data_bram_araddr(araddr), .axi_data_bram_arvalid(arvalid),
        .axi_data_bram_arready(arready),
        .axi_data_bram_rdata(rdata), .axi_data_bram_rresp(rresp),
        .axi_data_bram_rvalid(rvalid), .axi_data_bram_rready(rready)
    );

    task automatic fail(input string msg);
        $display("HATA: %s", msg);
        $fatal(1);
    endtask

    task automatic write_word(
        input logic [AW-1:0] addr,
        input logic [31:0] data,
        input logic [3:0] strb
    );
        awaddr = {19'd0, addr, 2'b00};
        wdata = data;
        wstrb = strb;
        awvalid = 1;
        wvalid = 1;
        do @(posedge clk); while (!(awready && wready));
        #1 awvalid = 0; wvalid = 0;
        while (!bvalid) @(posedge clk);
        bready = 1;
        @(posedge clk);
        #1 bready = 0;
    endtask

    task automatic read_word(
        input logic [AW-1:0] addr,
        output logic [31:0] data
    );
        araddr = {19'd0, addr, 2'b00};
        arvalid = 1;
        do @(posedge clk); while (!arready);
        #1 arvalid = 0;
        while (!rvalid) @(posedge clk);
        #1 data = rdata;
        rready = 1;
        @(posedge clk);
        #1 rready = 0;
    endtask

    logic [31:0] got;
    initial begin
        {awaddr, wdata, araddr} = '0;
        {awvalid, wvalid, bready, arvalid, rready} = '0;
        wstrb = 4'hF;
        repeat (4) @(posedge clk);
        rst_n = 1;
        repeat (2) @(posedge clk);

        write_word(11'h012, 32'h1122_3344, 4'hF);
        write_word(11'h155, 32'hA5A5_5A5A, 4'hF);

        // AXI4-Lite AW ve W bagimsiz kanallardir. Adres once geldiginde tek
        // basina handshake olmamali; veri daha sonra gelince ikisi birlikte
        // kayipsiz kabul edilmelidir.
        awaddr = {19'd0, 11'h020, 2'b00};
        awvalid = 1; wvalid = 0;
        #1 if (awready) fail("AW tek basina erken handshake oldu");
        @(posedge clk);
        wdata = 32'hABCD_0020; wstrb = 4'hF; wvalid = 1;
        #1 if (!awready || !wready) fail("gec gelen W ile ortak handshake acilmadi");
        @(posedge clk);
        #1 awvalid = 0; wvalid = 0;
        while (!bvalid) @(posedge clk);
        bready = 1; @(posedge clk); #1 bready = 0;
        read_word(11'h020, got);
        if (got !== 32'hABCD_0020) fail("AW-once write kayboldu");

        // Ayni denetimin ters sirasi: W once, AW sonra.
        wdata = 32'hABCD_0021; wstrb = 4'hF; wvalid = 1; awvalid = 0;
        #1 if (wready) fail("W tek basina erken handshake oldu");
        @(posedge clk);
        awaddr = {19'd0, 11'h021, 2'b00}; awvalid = 1;
        #1 if (!awready || !wready) fail("gec gelen AW ile ortak handshake acilmadi");
        @(posedge clk);
        #1 awvalid = 0; wvalid = 0;
        while (!bvalid) @(posedge clk);
        bready = 1; @(posedge clk); #1 bready = 0;
        read_word(11'h021, got);
        if (got !== 32'hABCD_0021) fail("W-once write kayboldu");

        // Ayni IDLE cevriminde ayni adrese read+write: read once kabul
        // edilmeli, write read cevabi bitene kadar kayipsiz beklemeli.
        araddr = {19'd0, 11'h012, 2'b00};
        awaddr = araddr;
        wdata = 32'hDEAD_BEEF;
        wstrb = 4'hF;
        arvalid = 1; awvalid = 1; wvalid = 1;
        #1;
        if (!arready || awready || wready)
            fail("ayni-adres IDLE arbitraji read onceligi vermedi");
        @(posedge clk);
        #1 arvalid = 0;
        while (!rvalid) begin
            if (awready || wready) fail("write R_WAIT sirasinda acildi");
            @(posedge clk);
        end
        #1;
        if (rdata !== 32'h1122_3344) fail("read-first eski veri yanlis");
        got = rdata;
        repeat (2) begin
            @(posedge clk);
            #1 if (awready || wready) fail("write stalled R_VALID sirasinda acildi");
            if (rdata !== got) fail("RDATA stall sirasinda degisti veya X oldu");
        end
        rready = 1;
        @(posedge clk);
        #1 rready = 0;
        do @(posedge clk); while (!(awready && wready));
        #1 awvalid = 0; wvalid = 0;
        while (!bvalid) @(posedge clk);
        bready = 1; @(posedge clk); #1 bready = 0;
        read_word(11'h012, got);
        if (got !== 32'hDEAD_BEEF) fail("bekletilen write kayboldu");

        // Farkli adresler ayni cevrimde iki fiziksel portu kullanabilmeli.
        araddr = {19'd0, 11'h155, 2'b00};
        awaddr = {19'd0, 11'h012, 2'b00};
        wdata = 32'hCAFE_1234;
        wstrb = 4'b0011;
        arvalid = 1; awvalid = 1; wvalid = 1;
        #1;
        if (!arready || !awready || !wready)
            fail("farkli-adres eszamanli read/write bloke edildi");
        @(posedge clk);
        #1 arvalid = 0; awvalid = 0; wvalid = 0;
        while (!rvalid) @(posedge clk);
        #1 if (rdata !== 32'hA5A5_5A5A) fail("eszamanli read verisi yanlis");
        rready = 1; @(posedge clk); #1 rready = 0;
        while (!bvalid) @(posedge clk);
        bready = 1; @(posedge clk); #1 bready = 0;
        read_word(11'h012, got);
        if (got !== 32'hDEAD_1234) fail("byte strobe write sonucu yanlis");

        $display("SONUC: BASARILI -- SRAM ayni-adres arbitraji ve read-enable");
        $finish;
    end

    initial begin
        #200000;
        fail("timeout");
    end
endmodule
