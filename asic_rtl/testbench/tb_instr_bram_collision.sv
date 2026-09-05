`timescale 1ns/1ps
// Teslimde asic/ altinda testbench bulunmamasi gerektigi icin ASIC RTL test agacindadir.

module tb_instr_bram_collision;
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
    logic [31:0] data_araddr, data_rdata;
    logic [1:0]  data_rresp;
    logic data_arvalid, data_arready, data_rvalid, data_rready;
    logic [31:0] mem_araddr, mem_rdata;
    logic [1:0]  mem_rresp;
    logic mem_arvalid, mem_arready, mem_rvalid, mem_rready;
    logic dma_valid;
    logic [31:0] dma_data;

    axi_read_arbiter2 arb (
        .clk_i(clk), .rst_ni(rst_n),
        .m0_araddr(araddr), .m0_arvalid(arvalid), .m0_arready(arready),
        .m0_rdata(rdata), .m0_rresp(rresp), .m0_rvalid(rvalid), .m0_rready(rready),
        .m1_araddr(data_araddr), .m1_arvalid(data_arvalid), .m1_arready(data_arready),
        .m1_rdata(data_rdata), .m1_rresp(data_rresp),
        .m1_rvalid(data_rvalid), .m1_rready(data_rready),
        .s_araddr(mem_araddr), .s_arvalid(mem_arvalid), .s_arready(mem_arready),
        .s_rdata(mem_rdata), .s_rresp(mem_rresp),
        .s_rvalid(mem_rvalid), .s_rready(mem_rready)
    );

    instr_bram_axi_ctrl #(.DATA_WIDTH(32), .ADDR_WIDTH(AW)) dut (
        .clk_i(clk), .rst_n(rst_n),
        .axi_instr_bram_awaddr(awaddr), .axi_instr_bram_awvalid(awvalid),
        .axi_instr_bram_awready(awready),
        .axi_instr_bram_wdata(wdata), .axi_instr_bram_wstrb(wstrb),
        .axi_instr_bram_wvalid(wvalid), .axi_instr_bram_wready(wready),
        .axi_instr_bram_bresp(bresp), .axi_instr_bram_bvalid(bvalid),
        .axi_instr_bram_bready(bready),
        .axi_instr_bram_araddr(mem_araddr), .axi_instr_bram_arvalid(mem_arvalid),
        .axi_instr_bram_arready(mem_arready),
        .axi_instr_bram_rdata(mem_rdata), .axi_instr_bram_rresp(mem_rresp),
        .axi_instr_bram_rvalid(mem_rvalid), .axi_instr_bram_rready(mem_rready),
        .dma_valid_i(dma_valid), .dma_data_i(dma_data)
    );

    bit failed = 0;
    task automatic fail(input string msg);
        failed = 1;
        $display("HATA: %s", msg);
    endtask

    task automatic data_read_word(
        input logic [AW-1:0] addr,
        output logic [31:0] data
    );
        @(negedge clk);
        data_araddr = {19'd0, addr, 2'b00};
        data_arvalid = 1;
        do @(posedge clk); while (!data_arready);
        #1 data_arvalid = 0;
        while (!data_rvalid) @(posedge clk);
        #1 data = data_rdata;
        data_rready = 1;
        @(posedge clk);
        #1 data_rready = 0;
    endtask

    task automatic dma_write(input logic [31:0] data);
        @(negedge clk);
        dma_data = data;
        dma_valid = 1;
        @(posedge clk);
        #1 dma_valid = 0;
    endtask

    task automatic read_word(
        input logic [AW-1:0] addr,
        output logic [31:0] data
    );
        @(negedge clk);
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
        {awaddr, wdata, araddr, data_araddr, dma_data} = '0;
        {awvalid, wvalid, bready, arvalid, rready,
         data_arvalid, data_rready, dma_valid} = '0;
        wstrb = 4'hF;
        repeat (4) @(posedge clk);
        @(negedge clk);
        rst_n = 1;
        repeat (2) @(posedge clk);

        // ARVALID=0 iken DMA addr0'a yazar. Eski surekli-acik read portu
        // burada raddr=0 ise makronun tanimsiz ayni-adres uyarisini uretiyordu.
        dma_write(32'h1111_0000);
        read_word(11'h000, got);
        if (got !== 32'h1111_0000)
            fail($sformatf("DMA addr0 yazisi/okumasi yanlis: got=%08h", got));

        // DMA addr1'e yazarken CPU ayni adresi okumak ister: DMA'nin ready'si
        // olmadigindan write kabul edilmeli, AR bir cevrim geri basilmali.
        @(negedge clk);
        araddr = {19'd0, 11'h001, 2'b00};
        arvalid = 1;
        dma_data = 32'h2222_0001;
        dma_valid = 1;
        #1 if (arready) fail("ayni-adres DMA/read cakismasinda ARREADY inmedi");
        @(posedge clk);
        #1 dma_valid = 0;
        if (!arready) fail($sformatf("DMA bittikten sonra bekleyen read acilmadi: arready_q=%b conflict=%b we=%b waddr=%h raddr=%h",
                                    dut.arready_q, dut.read_conflict, dut.we, dut.waddr, dut.raddr));
        @(posedge clk);
        #1 arvalid = 0;
        while (!rvalid) @(posedge clk);
        #1 if (rdata !== 32'h2222_0001)
            fail($sformatf("write-oncelikli ayni-adres veri yanlis: got=%08h", rdata));
        rready = 1; @(posedge clk); #1 rready = 0;

        // addr2'yi doldur, sonra addr2 read ile addr3 DMA write'i ayni anda
        // calistir. Iki fiziksel port farkli adreslerde eszamanli kalmali.
        dma_write(32'h3333_0002);
        @(negedge clk);
        araddr = {19'd0, 11'h002, 2'b00};
        arvalid = 1;
        dma_data = 32'h4444_0003;
        dma_valid = 1;
        #1 if (!arready) fail("farkli-adres DMA/read gereksiz bloke edildi");
        @(posedge clk);
        #1 arvalid = 0; dma_valid = 0;
        while (!rvalid) @(posedge clk);
        #1 if (rdata !== 32'h3333_0002)
            fail($sformatf("eszamanli farkli-adres read yanlis: got=%08h", rdata));
        rready = 1; @(posedge clk); #1 rready = 0;
        read_word(11'h003, got);
        if (got !== 32'h4444_0003)
            fail($sformatf("eszamanli farkli-adres DMA write kayboldu: got=%08h", got));

        // DMA ve AXI write ayni cevrimde gelirse DMA geri basilamaz; AXI'nin
        // iki kanali birlikte beklemeli ve DMA bittikten sonra kabul edilmeli.
        @(negedge clk);
        dma_data = 32'h5555_0004; dma_valid = 1;
        awaddr = {19'd0, 11'h005, 2'b00};
        wdata = 32'h6666_0005; wstrb = 4'hF;
        awvalid = 1; wvalid = 1;
        #1 if (awready || wready) fail("DMA aktifken AXI write geri basilmadi");
        @(posedge clk);
        #1 dma_valid = 0;
        #1; // continuous READY atamalarinin yeni dma_valid'i yaymasini bekle
        if (!awready || !wready)
            fail($sformatf("DMA bitince bekleyen AXI write acilmadi: aw=%b w=%b awq=%b wq=%b av=%b wv=%b dma=%b",
                           awready, wready, dut.awready_q, dut.wready_q,
                           awvalid, wvalid, dma_valid));
        @(posedge clk);
        #1 awvalid = 0; wvalid = 0;
        while (!bvalid) @(posedge clk);
        bready = 1; @(posedge clk); #1 bready = 0;
        read_word(11'h004, got);
        if (got !== 32'h5555_0004) fail("DMA/AXI cakismasinda DMA sozcugu kayboldu");
        read_word(11'h005, got);
        if (got !== 32'h6666_0005) fail("DMA/AXI cakismasinda bekleyen AXI write kayboldu");

        // Instruction fetch ve data load ayni cevrimde IMEM isterse data yolu
        // oncelik almali; cevap yalniz dogru master'a gitmeli. Data cevabi
        // bittikten sonra bekleyen instruction fetch kayipsiz kabul edilir.
        @(negedge clk);
        araddr = {19'd0, 11'h004, 2'b00};
        data_araddr = {19'd0, 11'h005, 2'b00};
        arvalid = 1; data_arvalid = 1;
        #1;
        if (!data_arready || arready)
            fail($sformatf("es-zamanli IMEM read onceligi yanlis: iar=%b dar=%b",
                           arready, data_arready));
        @(posedge clk);
        #1 data_arvalid = 0;
        while (!data_rvalid) @(posedge clk);
        #1;
        if (rvalid) fail("data cevabi instruction master'a da yonlendirildi");
        if (data_rdata !== 32'h6666_0005)
            fail($sformatf("data-port IMEM read yanlis: got=%08h", data_rdata));
        data_rready = 1; @(posedge clk); #1 data_rready = 0;

        // arvalid yuksek tutuldu; arbiter IDLE'a donunce istegi almalidir.
        do @(posedge clk); while (!arready);
        #1 arvalid = 0;
        while (!rvalid) @(posedge clk);
        #1;
        if (data_rvalid) fail("instruction cevabi data master'a da yonlendirildi");
        if (rdata !== 32'h5555_0004)
            fail($sformatf("bekleyen instruction IMEM read yanlis: got=%08h", rdata));
        rready = 1; @(posedge clk); #1 rready = 0;

        // Tek basina data-port read de normal AXI handshake ile tamamlanmali.
        data_read_word(11'h000, got);
        if (got !== 32'h1111_0000)
            fail($sformatf("tekil data-port IMEM read yanlis: got=%08h", got));

        // AXI payload-stability: instruction ARVALID downstream'da DMA
        // cakismasi nedeniyle beklerken sonradan data istegi gelsin. Data yolu
        // yalniz IDLE'daki es-zamanli secimde onceliklidir; daha once sunulmus
        // ve ARREADY bekleyen instruction adresini preempt edip degistiremez.
        // Bu noktada DMA sayaci addr5'tedir.
        @(negedge clk);
        araddr = {19'd0, 11'h005, 2'b00};
        arvalid = 1;
        dma_data = 32'h7777_0005;
        dma_valid = 1;
        #1;
        if (!mem_arvalid || mem_arready || mem_araddr !== {19'd0, 11'h005, 2'b00})
            fail($sformatf("stalled instruction AR baslangici yanlis: v=%b r=%b addr=%08h",
                           mem_arvalid, mem_arready, mem_araddr));
        @(posedge clk);
        #1 dma_valid = 0;
        data_araddr = {19'd0, 11'h000, 2'b00};
        data_arvalid = 1;
        #1;
        if (!mem_arvalid || mem_araddr !== {19'd0, 11'h005, 2'b00})
            fail($sformatf("ARREADY beklerken downstream AR payload degisti: v=%b addr=%08h",
                           mem_arvalid, mem_araddr));
        if (!arready || data_arready)
            fail($sformatf("kilitli instruction grant yanlis: iar=%b dar=%b",
                           arready, data_arready));
        @(posedge clk);
        #1 arvalid = 0;
        while (!rvalid) @(posedge clk);
        #1;
        if (data_rvalid)
            fail("kilitli instruction cevabi data master'a yonlendirildi");
        if (rdata !== 32'h7777_0005)
            fail($sformatf("kilitli instruction read verisi yanlis: got=%08h", rdata));
        rready = 1; @(posedge clk); #1 rready = 0;

        // Bekleyen data istegi instruction R handshake'inden sonra alinmali.
        do @(posedge clk); while (!data_arready);
        #1 data_arvalid = 0;
        while (!data_rvalid) @(posedge clk);
        #1;
        if (rvalid) fail("bekleyen data cevabi instruction master'a yonlendirildi");
        if (data_rdata !== 32'h1111_0000)
            fail($sformatf("payload-stability sonrasi data read yanlis: got=%08h", data_rdata));
        data_rready = 1; @(posedge clk); #1 data_rready = 0;

        if (bresp !== 2'b00 || rresp !== 2'b00 || data_rresp !== 2'b00)
            fail("AXI OKAY yanit kodu yanlis");
        if (failed) $display("SONUC: BASARISIZ -- IMEM DMA/iki-master read arbitraji");
        else        $display("SONUC: BASARILI -- IMEM DMA/iki-master read arbitraji");
        $finish;
    end

    initial begin
        #200000;
        fail("timeout");
    end
endmodule
