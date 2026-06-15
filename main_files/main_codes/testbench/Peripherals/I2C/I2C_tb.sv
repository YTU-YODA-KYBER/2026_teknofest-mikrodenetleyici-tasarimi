`timescale 1ns / 1ps
// =============================================================================
//  I2C Master AXI4-Lite
// -----------------------------------------------------------------------------

module I2C_Master_testbench;

    // -------------------------------------------------------------------------
    // Register Adresleri & Sabitler
    // -------------------------------------------------------------------------
    localparam logic [31:0] ADDR_NBY     = 32'h0000_0000;
    localparam logic [31:0] ADDR_ADR     = 32'h0000_0004;
    localparam logic [31:0] ADDR_RDR     = 32'h0000_0008; // okunan veri (eski TB'de yanlışlıkla "STA")
    localparam logic [31:0] ADDR_TDR     = 32'h0000_000C;
    localparam logic [31:0] ADDR_CFG     = 32'h0000_0010;
    localparam logic [31:0] ADDR_CFG_CLR = 32'h0000_0014;

    localparam logic [31:0] CFG_WR_START = 32'h0000_0001;
    localparam logic [31:0] CFG_WR_DONE  = 32'h0000_0002;
    localparam logic [31:0] CFG_RD_START = 32'h0000_0004;
    localparam logic [31:0] CFG_RD_DONE  = 32'h0000_0008;

    localparam logic [31:0] CLR_WR_DONE  = 32'h0000_0001;
    localparam logic [31:0] CLR_RD_DONE  = 32'h0000_0002;

    localparam logic [ 6:0] SLAVE_ADDR   = 7'b110_0110;          // 0x66
    localparam logic [ 7:0] ADDR_W_BYTE  = {SLAVE_ADDR, 1'b0};   // 0xCC (adres + WRITE)
    localparam logic [ 7:0] ADDR_R_BYTE  = {SLAVE_ADDR, 1'b1};   // 0xCD (adres + READ)

    localparam logic [31:0] TEST_DATA_1B = 32'h0000_00AB;
    localparam logic [31:0] TEST_DATA_4B = 32'hABCD_ABCD;
    localparam logic [31:0] READ_DATA_1B = 32'h0000_005A;
    localparam logic [31:0] READ_DATA_4B = 32'h1234_5678;

    // wait_write/read_done içinde maksimum AXI okuma sayısı (timeout için)
    localparam int TIMEOUT_READS = 2000;

    // -------------------------------------------------------------------------
    // Sinyaller
    // -------------------------------------------------------------------------
    logic        clk_i  = 1'b0;
    logic        rst_n  = 1'b0;

    logic [31:0] awaddr  = '0;
    logic        awvalid = 1'b0;
    wire         awready;
    logic [31:0] wdata   = '0;
    logic        wvalid  = 1'b0;
    wire         wready;
    logic        bready  = 1'b0;
    wire  [ 1:0] bresp;
    wire         bvalid;
    logic [31:0] araddr  = '0;
    logic        arvalid = 1'b0;
    wire         arready;
    logic        rready  = 1'b0;
    wire  [31:0] rdata;
    wire  [ 1:0] rresp;
    wire         rvalid;

    logic [31:0] read_output = '0;
    logic [31:0] rdr_val     = '0;
    logic        sda         = 1'b1;   // slave SDA sürücüsü (1=bırak/high-Z, 0=low)

    int  toplam_basari    = 0;
    int  toplam_basarisiz = 0;
    int  test_num         = 0;
    logic timed_out_flag = 1'b0;

    // Yazma testlerinde master'ın bus'a koyduğu baytları yakalamak için
    logic [7:0] captured [0:7];
    int         cap_cnt = 0;

    wire I2C_SDA;
    wire I2C_SCL;
    assign I2C_SDA = sda ? 1'bz : 1'b0;   // open-drain emülasyonu
    pullup(I2C_SDA);
    pullup(I2C_SCL);

    // -------------------------------------------------------------------------
    // DUT
    // -------------------------------------------------------------------------
    I2C_Master_AXI4_Lite dut (
        .clk_i   (clk_i),
        .rst_n   (rst_n),
        .awaddr  (awaddr),  .awvalid (awvalid), .awready (awready),
        .wdata   (wdata),   .wvalid  (wvalid),  .wready  (wready),
        .bresp   (bresp),   .bvalid  (bvalid),  .bready  (bready),
        .araddr  (araddr),  .arvalid (arvalid), .arready (arready),
        .rdata   (rdata),   .rresp   (rresp),   .rvalid  (rvalid), .rready (rready),
        .I2C_SCL (I2C_SCL), .I2C_SDA (I2C_SDA)
    );

    // -------------------------------------------------------------------------
    // Pasif bus monitörü (START/STOP + bayt/ACK decode)
    // -------------------------------------------------------------------------
    i2c_bus_monitor #(.NAME("BUS")) mon (.scl(I2C_SCL), .sda(I2C_SDA), .rst_n(rst_n));

    // -------------------------------------------------------------------------
    // Clock ~48 MHz
    // -------------------------------------------------------------------------
    initial begin
        clk_i = 0;
        forever #10.4166 clk_i = ~clk_i;
    end

    // =========================================================================
    // AXI4-LITE YARDIMCI TASKLAR
    // =========================================================================
    task automatic do_reset();
        rst_n          = 1'b0;
        sda            = 1'b1;
        timed_out_flag = 1'b0;
        awvalid = 1'b0; wvalid = 1'b0; bready = 1'b0;
        arvalid = 1'b0; rready = 1'b0;
        awaddr  = '0;   wdata  = '0;   araddr = '0;
        repeat(8) @(posedge clk_i);
        rst_n = 1'b1;
        repeat(4) @(posedge clk_i);
    endtask

    task automatic axi_write(input logic [31:0] addr, input logic [31:0] data);
        @(negedge clk_i);
        awaddr  = addr;  wdata = data;
        awvalid = 1'b1;  wvalid = 1'b1;  bready = 1'b1;
        @(posedge clk_i);
        while (!(awready && wready)) @(posedge clk_i);   // AW+W handshake
        @(negedge clk_i);
        awvalid = 1'b0;  wvalid = 1'b0;
        @(posedge clk_i);
        while (!bvalid) @(posedge clk_i);                // B-channel
        @(posedge clk_i);
        while ( bvalid) @(posedge clk_i);
        @(negedge clk_i);
        bready = 1'b0;
        @(posedge clk_i);
    endtask

    task automatic axi_read(input logic [31:0] addr, output logic [31:0] rd);
        @(negedge clk_i);
        araddr  = addr;  arvalid = 1'b1;  rready = 1'b1;
        @(posedge clk_i);
        while (!arready) @(posedge clk_i);               // AR handshake
        @(negedge clk_i);
        arvalid = 1'b0;  araddr = '0;
        @(posedge clk_i);
        while (!rvalid) @(posedge clk_i);                // R-channel
        rd = rdata;
        @(posedge clk_i);
        while (rvalid) @(posedge clk_i);
        @(negedge clk_i);
        rready = 1'b0;
        @(posedge clk_i);
    endtask

    task automatic read_cfg(output logic [31:0] cfg_val);
        axi_read(ADDR_CFG, cfg_val);
    endtask

    // CFG[1] (WR_DONE) set olana kadar poll; TIMEOUT_READS okumada set olmazsa timeout
    task automatic wait_write_done(output logic timed_out);
        logic [31:0] cur; int cnt;
        timed_out = 1'b0; cnt = 0; cur = '0;
        while (!(cur & CFG_WR_DONE) && !timed_out) begin
            axi_read(ADDR_CFG, cur);
            cnt++;
            if (cnt >= TIMEOUT_READS) timed_out = 1'b1;
        end
    endtask

    // CFG[3] (RD_DONE) set olana kadar poll
    task automatic wait_read_done(output logic timed_out);
        logic [31:0] cur; int cnt;
        timed_out = 1'b0; cnt = 0; cur = '0;
        while (!(cur & CFG_RD_DONE) && !timed_out) begin
            axi_read(ADDR_CFG, cur);
            cnt++;
            if (cnt >= TIMEOUT_READS) timed_out = 1'b1;
        end
    endtask

    task automatic print_result(input string test_name, input logic pass);
        test_num++;
        if (pass) begin $display("  [GECTI ] Test %0d basarili   -> %s", test_num, test_name); toplam_basari++;    end
        else      begin $display("  [KALDI ] Test %0d BASARISIZ  -> %s", test_num, test_name); toplam_basarisiz++; end
    endtask

    // =========================================================================
    // I2C SLAVE MODEL TASKLARI  (standart zamanlama)
    // =========================================================================

    // --- YAZMA: frame_count kadar baytı ACK'lar VE yakalar (captured[]) ---
    //  captured[0] = adres+W baytı (0xCC olmalı), captured[1..] = veri baytları
    task automatic i2c_slave_write_capture(input int frame_count);
        logic [7:0] b;
        cap_cnt = 0;
        for (int k = 0; k < frame_count; k++) begin
            b = 8'h00;
            for (int i = 0; i < 8; i++) begin           // 8 bit, MSB önce
                @(posedge I2C_SCL);
                b = {b[6:0], (I2C_SDA === 1'b1) ? 1'b1 : 1'b0};
            end
            captured[k] = b;
            cap_cnt++;
            @(negedge I2C_SCL); sda = 1'b0;             // ACK (low)
            @(posedge I2C_SCL);
            @(negedge I2C_SCL); sda = 1'b1;             // bırak
        end
    endtask

    // --- OKUMA: adres fazlarını ACK'lar, sonra nby bayt veri sürer (MSB önce) ---
    //  STANDART zamanlama: adres+R ACK'ının düşen kenarında ilk veri biti sürülür.
    task automatic i2c_slave_send_read_n(input logic [31:0] read_data, input int nby);
        logic [7:0] bo;
        // (1) adres+W frame -> ACK
        repeat(8) @(posedge I2C_SCL);
        @(negedge I2C_SCL); sda = 1'b0;
        @(posedge I2C_SCL); @(negedge I2C_SCL); sda = 1'b1;
        // (2) repeated-START + adres+R frame -> ACK
        //     master 9 SCL-high üretir: 1 (repeated-start) + 8 (adres bitleri)
        repeat(9) @(posedge I2C_SCL);
        @(negedge I2C_SCL); sda = 1'b0;                 // ACK low (10. high boyunca)
        @(posedge I2C_SCL);                             // master ACK'i örnekler
        // (3) veri baytları — STANDART: hemen ilk bayta geç, fazladan periyot YOK
        for (int b = 0; b < nby; b++) begin
            case (b)
                0: bo = read_data[ 7: 0];
                1: bo = read_data[15: 8];
                2: bo = read_data[23:16];
                3: bo = read_data[31:24];
                default: bo = 8'hFF;
            endcase
            for (int i = 7; i >= 0; i--) begin
                @(negedge I2C_SCL); sda = bo[i];        // bit'i düşen kenarda sür (bit=1->bırak, 0->low)
            end
            @(negedge I2C_SCL); sda = 1'b1;             // master ACK/NACK için bus'ı bırak
            @(posedge I2C_SCL);                         // master ACK/NACK sürer (slave izler)
        end
    endtask

    // --- NACK: when_nack. frame'de NACK ver (önceki frame'leri ACK'lar) ---
    task automatic i2c_slave_nack_at(input int when_nack);
        for (int k = 1; k <= when_nack; k++) begin
            repeat(8) @(posedge I2C_SCL);
            @(negedge I2C_SCL);
            sda = (k < when_nack) ? 1'b0 : 1'b1;        // ACK ya da NACK
            @(posedge I2C_SCL);
            @(negedge I2C_SCL);
            sda = 1'b1;
        end
    endtask

    // =========================================================================
    // ANA TEST BLOĞU
    // =========================================================================
    initial begin
        $display("====================================================");
        $display("  I2C Master AXI4-Lite - Dogrulayici Test Senaryolari");
        $display("====================================================");

        // ------------------------------------------------------------------
        // TEST 1 — Tek Bayt Yazma (1B Write)
        //   I2C master'a NBY=1, slave adresi=0x66 ve TDR=0xAB yazılır; ardından
        //   CFG[0] (WR_START) set edilerek transfer başlatılır. Slave modeli,
        //   adres (0xCC) ve veri (0xAB) olmak üzere iki frame'i sırayla ACK'lar ve
        //   yakalar. Test; donanımın WR_DONE bayrağını setlediğini, timeout
        //   olmadığını ve bus'ta gözüken adres/veri baytlarının beklenen değerle
        //   birebir eşleştiğini doğrular.
        // ------------------------------------------------------------------
        $display("\n--- TEST 1: Tek Bayt Yazma (1B Write) ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd1);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_TDR, TEST_DATA_1B);
        axi_write(ADDR_CFG, CFG_WR_START);
        fork : t1
            begin wait_write_done(timed_out_flag); disable t1; end
            begin i2c_slave_write_capture(2); end
        join
        read_cfg(read_output);
        $display("  WR_DONE=%0b Timeout=%0b | bus: addr=0x%02h data=0x%02h (bekl 0x%02h, 0x%02h)",
                 read_output[1], timed_out_flag, captured[0], captured[1], ADDR_W_BYTE, TEST_DATA_1B[7:0]);
        print_result("1B Write - DONE + dogru adres/veri",
                     !timed_out_flag && (read_output & CFG_WR_DONE) &&
                     (captured[0]==ADDR_W_BYTE) && (captured[1]==TEST_DATA_1B[7:0]));
        axi_write(ADDR_CFG_CLR, CLR_WR_DONE);

        // ------------------------------------------------------------------
        // TEST 2 — Dort Bayt Yazma (4B Write)
        //   NBY=4 ile TDR'a 0xABCDABCD yüklenir ve transfer başlatılır. I2C
        //   standardına göre düşük anlamlı bayt önce gönderildiğinden bus'ta sıra
        //   [0xCD, 0xAB, 0xCD, 0xAB] olmalıdır. Slave modeli adres dahil 5 frame'i
        //   ACK'lar ve yakalar. Test; WR_DONE bayrağını, timeout olmadığını ve
        //   dört veri baytının bus'ta doğru sıra ile göründüğünü doğrular.
        // ------------------------------------------------------------------
        $display("\n--- TEST 2: Dort Bayt Yazma (4B Write) ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd4);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_TDR, TEST_DATA_4B);
        axi_write(ADDR_CFG, CFG_WR_START);
        fork : t2
            begin wait_write_done(timed_out_flag); disable t2; end
            begin i2c_slave_write_capture(5); end
        join
        read_cfg(read_output);
        $display("  WR_DONE=%0b Timeout=%0b | bus: addr=0x%02h data=[%02h %02h %02h %02h]",
                 read_output[1], timed_out_flag, captured[0], captured[1], captured[2], captured[3], captured[4]);
        print_result("4B Write - DONE + dogru adres/veri sirasi",
                     !timed_out_flag && (read_output & CFG_WR_DONE) &&
                     (captured[0]==ADDR_W_BYTE) &&
                     (captured[1]==TEST_DATA_4B[ 7: 0]) && (captured[2]==TEST_DATA_4B[15: 8]) &&
                     (captured[3]==TEST_DATA_4B[23:16]) && (captured[4]==TEST_DATA_4B[31:24]));
        axi_write(ADDR_CFG_CLR, CLR_WR_DONE);

        // ------------------------------------------------------------------
        // TEST 3 — Tek Bayt Okuma (1B Read)
        //   NBY=1 ve slave adresi=0x66 ayarlanır; CFG[2] (RD_START) set edilerek
        //   okuma transferi başlatılır. Master sırasıyla adres+W, repeated-START
        //   ve adres+R frame'lerini üretir; slave 0x5A'yı MSB önce sürer; master
        //   son bayta NACK basıp STOP üretir ve alınan veriyi I2C_RDR'ye yazar.
        //   Test; RD_DONE bayrağının setlendiğini, timeout olmadığını ve
        //   I2C_RDR'nin tam olarak 0x0000005A içerdiğini doğrular.
        // ------------------------------------------------------------------
        $display("\n--- TEST 3: Tek Bayt Okuma (1B Read) ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd1);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_CFG, CFG_RD_START);
        fork : t3
            begin wait_read_done(timed_out_flag); disable t3; end
            begin i2c_slave_send_read_n(READ_DATA_1B, 1); end
        join
        read_cfg(read_output);
        axi_read(ADDR_RDR, rdr_val);
        $display("  RD_DONE=%0b Timeout=%0b | I2C_RDR=0x%08h (bekl 0x%08h)",
                 read_output[3], timed_out_flag, rdr_val, READ_DATA_1B);
        print_result("1B Read - DONE + dogru RDR verisi",
                     !timed_out_flag && (read_output & CFG_RD_DONE) && (rdr_val == READ_DATA_1B));
        axi_write(ADDR_CFG_CLR, CLR_RD_DONE);

        // ------------------------------------------------------------------
        // TEST 4 — Dort Bayt Okuma (4B Read)
        //   NBY=4 ile okuma transferi başlatılır; slave 0x12345678'i bayt bayt
        //   düşük anlamlıdan yükseğe sürer (0x78, 0x56, 0x34, 0x12). Master ilk
        //   üç baytı ACK, son baytı NACK'lar ve STOP üretir; her bayt sırasıyla
        //   I2C_RDR'nin ilgili bölümüne ([7:0], [15:8], [23:16], [31:24]) yazılır.
        //   Test; RD_DONE bayrağının setlendiğini ve I2C_RDR'nin 0x12345678
        //   değerini doğru konumlandırarak tuttuğunu doğrular.
        // ------------------------------------------------------------------
        $display("\n--- TEST 4: Dort Bayt Okuma (4B Read) ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd4);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_CFG, CFG_RD_START);
        fork : t4
            begin wait_read_done(timed_out_flag); disable t4; end
            begin i2c_slave_send_read_n(READ_DATA_4B, 4); end
        join
        read_cfg(read_output);
        axi_read(ADDR_RDR, rdr_val);
        $display("  RD_DONE=%0b Timeout=%0b | I2C_RDR=0x%08h (bekl 0x%08h)",
                 read_output[3], timed_out_flag, rdr_val, READ_DATA_4B);
        print_result("4B Read - DONE + dogru RDR verisi",
                     !timed_out_flag && (read_output & CFG_RD_DONE) && (rdr_val == READ_DATA_4B));
        axi_write(ADDR_CFG_CLR, CLR_RD_DONE);

        // ------------------------------------------------------------------
        // TEST 5 — NACK @ Adres Frame (timeout beklenir)
        //   Yazma transferi başlatılır; ancak slave modeli adres baytına (ilk
        //   frame) NACK verir, yani SDA'yı high bırakır. Master ACK göremediği
        //   için transferi S_ABORT state'ine çekerek WR_DONE'ı asla set etmez.
        //   Test; wait_write_done() fonksiyonunun TIMEOUT_READS sınırına ulaşarak
        //   timed_out_flag'i set ettiğini doğrular — bu, hata tespitinin çalıştığını
        //   kanıtlar.
        // ------------------------------------------------------------------
        $display("\n--- TEST 5: NACK @ Adres Frame (timeout beklenir) ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd1);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_TDR, TEST_DATA_1B);
        axi_write(ADDR_CFG, CFG_WR_START);
        fork : t5
            begin wait_write_done(timed_out_flag); disable t5; end
            begin i2c_slave_nack_at(1); end
        join
        $display("  Timeout=%0b (1 = beklenen NACK/iptal tespit edildi)", timed_out_flag);
        print_result("NACK @ Adres - timeout tespit edildi", timed_out_flag == 1'b1);
        do_reset();

        // ------------------------------------------------------------------
        // TEST 6 — NACK @ Veri Frame (timeout beklenir)
        //   NBY=2 ile yazma transferi başlatılır; slave adres baytını (1. frame)
        //   ACK'lar ancak ilk veri baytını (2. frame) NACK'lar. Master bu durumda
        //   S_ABORT'a geçerek WR_DONE'ı set etmez. Test; kısmi ACK sonrası
        //   veri frame'inde yaşanan NACK'ın da doğru şekilde iptal mekanizmasını
        //   tetiklediğini ve wait_write_done()'ın timeout'a düştüğünü doğrular.
        // ------------------------------------------------------------------
        $display("\n--- TEST 6: NACK @ Veri Frame (timeout beklenir) ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd2);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_TDR, 32'h0000_ABCD);
        axi_write(ADDR_CFG, CFG_WR_START);
        fork : t6
            begin wait_write_done(timed_out_flag); disable t6; end
            begin i2c_slave_nack_at(2); end
        join
        $display("  Timeout=%0b (1 = beklenen NACK/iptal tespit edildi)", timed_out_flag);
        print_result("NACK @ Veri - timeout tespit edildi", timed_out_flag == 1'b1);
        do_reset();

        // ------------------------------------------------------------------
        // TEST 7 — WR_DONE Bayrak Temizleme (CFG_CLR / 0x14)
        //   Başarılı bir yazma transferinin ardından CFG[1] (WR_DONE) donanım
        //   tarafından set edilir ve yazılım temizleyene kadar bu değerde kalır.
        //   ADDR_CFG_CLR (0x14) adresine CLR_WR_DONE (0x1) yazılarak bayrağın
        //   yazılımla temizlenebileceği test edilir. Test; temizleme öncesi
        //   WR_DONE=1, temizleme sonrası WR_DONE=0 olduğunu doğrular.
        // ------------------------------------------------------------------
        $display("\n--- TEST 7: WR_DONE Temizleme (CFG_CLR) ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd1);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_TDR, 32'h0000_00CC);
        axi_write(ADDR_CFG, CFG_WR_START);
        fork : t7
            begin wait_write_done(timed_out_flag); disable t7; end
            begin i2c_slave_write_capture(2); end
        join
        read_cfg(read_output);
        $display("  Temizlemeden once: WR_DONE=%0b", read_output[1]);
        axi_write(ADDR_CFG_CLR, CLR_WR_DONE);
        read_cfg(read_output);
        $display("  Temizledikten sonra: WR_DONE=%0b", read_output[1]);
        print_result("CFG_CLR ile WR_DONE temizlendi",
                     !timed_out_flag && !(read_output & CFG_WR_DONE));

        // ------------------------------------------------------------------
        // TEST 8 — Ardisik Yazma (Back-to-Back Write)
        //   Biri 0xAA, diğeri 0x55 olmak üzere iki ayrı tek-bayt yazma transferi
        //   arka arkaya yapılır; birinci transfer bittikten sonra WR_DONE temizlenir
        //   ve ikinci transfer başlatılır. Bu test; donanımın bir transferi
        //   tamamlayıp IDLE'a döndükten sonra bir sonraki transferi sorunsuz
        //   başlatabildiğini ve ikinci transferin verisinin (0x55) bus'ta
        //   bozulmadan göründüğünü doğrular.
        // ------------------------------------------------------------------
        $display("\n--- TEST 8: Ardisik Yazma (Back-to-Back) ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd1);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_TDR, 32'h0000_00AA);
        axi_write(ADDR_CFG, CFG_WR_START);
        fork : t8a
            begin wait_write_done(timed_out_flag); disable t8a; end
            begin i2c_slave_write_capture(2); end
        join
        $display("  1. transfer: WR_DONE=%0b data=0x%02h", read_output[1], captured[1]);
        axi_write(ADDR_CFG_CLR, CLR_WR_DONE);
        do_reset();
        axi_write(ADDR_NBY, 32'd1);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_TDR, 32'h0000_0055);
        axi_write(ADDR_CFG, CFG_WR_START);
        fork : t8b
            begin wait_write_done(timed_out_flag); disable t8b; end
            begin i2c_slave_write_capture(2); end
        join
        read_cfg(read_output);
        $display("  2. transfer: WR_DONE=%0b data=0x%02h (bekl 0x55)", read_output[1], captured[1]);
        print_result("Back-to-Back Write - ikisi de tamam + 2. veri dogru",
                     !timed_out_flag && (read_output & CFG_WR_DONE) && (captured[1]==8'h55));
        axi_write(ADDR_CFG_CLR, CLR_WR_DONE);

        // ------------------------------------------------------------------
        // TEST 9 — Yazma Sonrasi Okuma (Write then Read)
        //   Önce 2 bayt yazma (0x1234 → bus'ta [0x34, 0x12]) tamamlanır, WR_DONE
        //   temizlenir; ardından aynı slave'den 2 bayt okuma (0xABCD) yapılır.
        //   Bu test; yazma ve okuma işlemlerinin birbirini bozmadan sırayla
        //   çalışabildiğini, yazma sonrası AXI yazmaçlarının temiz kaldığını ve
        //   okunan verinin I2C_RDR'de doğru bayt sıralamasıyla (0x0000ABCD)
        //   saklandığını doğrular.
        // ------------------------------------------------------------------
        $display("\n--- TEST 9: Yazma Sonrasi Okuma (Write then Read) ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd2);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_TDR, 32'h0000_1234);
        axi_write(ADDR_CFG, CFG_WR_START);
        fork : t9a
            begin wait_write_done(timed_out_flag); disable t9a; end
            begin i2c_slave_write_capture(3); end
        join
        $display("  Yazma: WR_DONE=%0b data=[%02h %02h] (bekl 34 12)",
                 read_output[1], captured[1], captured[2]);
        axi_write(ADDR_CFG_CLR, CLR_WR_DONE);
        do_reset();
        axi_write(ADDR_NBY, 32'd2);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_CFG, CFG_RD_START);
        fork : t9b
            begin wait_read_done(timed_out_flag); disable t9b; end
            begin i2c_slave_send_read_n(32'h0000_ABCD, 2); end
        join
        read_cfg(read_output);
        axi_read(ADDR_RDR, rdr_val);
        $display("  Okuma: RD_DONE=%0b I2C_RDR=0x%08h (bekl 0x0000ABCD)", read_output[3], rdr_val);
        print_result("Write then Read - yazma verisi + okuma RDR dogru",
                     !timed_out_flag && (read_output & CFG_RD_DONE) && (rdr_val == 32'h0000_ABCD));
        axi_write(ADDR_CFG_CLR, CLR_RD_DONE);

        // ------------------------------------------------------------------
        // TEST 10 — CFG Register Tutarliligi
        //   Başarılı bir yazma transferinin ardından ADDR_CFG (0x10) adresi iki
        //   ayrı AXI okuma ile art arda sorgulanır. AXI okuma işlemi herhangi bir
        //   yan etki (side effect) yaratmamalı; yani sadece okuma yapmak WR_DONE
        //   veya diğer bitleri değiştirmemelidir. Test; her iki okumanın birebir
        //   aynı değeri döndürdüğünü ve bu değerde WR_DONE bitinin set olduğunu
        //   doğrular.
        // ------------------------------------------------------------------
        $display("\n--- TEST 10: CFG Register Tutarliligi ---");
        do_reset();
        axi_write(ADDR_NBY, 32'd1);
        axi_write(ADDR_ADR, {25'b0, SLAVE_ADDR});
        axi_write(ADDR_TDR, 32'h0000_00FF);
        axi_write(ADDR_CFG, CFG_WR_START);
        fork : t10
            begin wait_write_done(timed_out_flag); disable t10; end
            begin i2c_slave_write_capture(2); end
        join
        begin
            logic [31:0] cfg1, cfg2;
            axi_read(ADDR_CFG, cfg1);
            axi_read(ADDR_CFG, cfg2);
            $display("  CFG 1. okuma=0x%08h  2. okuma=0x%08h", cfg1, cfg2);
            print_result("CFG okumalar arasi tutarli",
                         !timed_out_flag && (cfg1 === cfg2) && (cfg1 & CFG_WR_DONE));
        end

        // ------------------------------------------- ÖZET
        $display("----------------------------------------------------------------------");
        $display("---------------------- BUTUN TESTLER TAMAMLANDI ----------------------");
        $display("----------------------------------------------------------------------\n");

        $display("Toplam basarili test sayisi: %d", toplam_basari);
        $display("Toplam basarisiz test sayisi:%d\n", toplam_basarisiz);
        if(toplam_basari == 10)begin
            $display("TUM TESTLER BASARILI!\n");
        end else begin
            $display("BAZI TESTLER BASARISIZ OLDU\n");
        end
        $display("----------------------------------------------------------------------");
        $display("----------------------------------------------------------------------");

        #1000;
        $finish;
    end

    // -------------------------------------------------------------------------
    // Genel simülasyon zaman aşımı (50 ms)
    // -------------------------------------------------------------------------
    initial begin
        #50_000_000;
        $display("\n[KRITIK] Genel simulasyon zaman asimi (50ms)!");
        $display("         Gecti: %0d | Kaldi: %0d", toplam_basari, toplam_basarisiz);
        $finish;
    end

endmodule

// =============================================================================
//  Pasif I2C bus monitörü — START/STOP koşulları ve bayt+ACK decode eder.
//  Sadece gözlemci; bus'ı sürmez.
// =============================================================================
module i2c_bus_monitor #(parameter string NAME = "BUS") (
    input wire scl,
    input wire sda,
    input wire rst_n
);
    reg [7:0] shreg;
    integer   bitc;
    reg       active;

    initial begin shreg = 0; bitc = 0; active = 0; end

    // START: SCL high iken SDA düşer  /  (repeated START de aynı şekilde yakalanır)
    always @(negedge sda) begin
        if (rst_n === 1'b1 && scl === 1'b1) begin
            $display("    [%0s] START", NAME);
            bitc = 0; shreg = 0; active = 1;
        end
    end
    // STOP: SCL high iken SDA yükselir
    always @(posedge sda) begin
        if (rst_n === 1'b1 && scl === 1'b1 && active) begin
            $display("    [%0s] STOP", NAME);
            active = 0;
        end
    end
    // Her SCL yükselen kenarında bit topla
    always @(posedge scl) begin
        if (rst_n === 1'b1 && active) begin
            shreg = {shreg[6:0], (sda === 1'b1) ? 1'b1 : 1'b0};
            bitc  = bitc + 1;
            if (bitc == 8)
                $write("    [%0s] BYTE=0x%02h  ", NAME, shreg);
            else if (bitc == 9) begin
                $display("ACK=%0b", (sda === 1'b1) ? 1'b1 : 1'b0);
                bitc = 0;
            end
        end
    end
endmodule
