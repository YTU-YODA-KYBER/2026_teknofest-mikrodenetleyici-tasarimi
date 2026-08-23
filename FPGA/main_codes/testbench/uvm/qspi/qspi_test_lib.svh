//=============================================================================
//  qspi_test_lib.svh  --  QSPI test kutuphanesi
//=============================================================================

class qspi_base_test extends axil_base_test;
    `uvm_component_utils(qspi_base_test)

    qspi_env         qenv;
    virtual qspi_if  qvif;

    bit [31:0] tum_ofset[$] = '{32'h00, 32'h04, 32'h08, 32'h0C, 32'h10, 32'h14};
    bit [31:0] yaz_ofset[$] = '{32'h04};                  // yan etkisiz tek register
    bit [31:0] ro_ofset [$] = '{32'h0C};
    bit [31:0] hrt_ofset[$] = '{32'h18, 32'h1C, 32'h40};

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void yapilandir();
        base_addr = 32'h4003_0000;
        blok      = "QSPI";
    endfunction

    function void build_phase(uvm_phase phase);
        axil_base_env::type_id::set_type_override(qspi_env::get_type());
        super.build_phase(phase);
        if (!$cast(qenv, env)) `uvm_fatal("ENV", "qspi_env cast basarisiz")
        if (!uvm_config_db#(virtual qspi_if)::get(this, "", "vif", qvif))
            `uvm_fatal("NOVIF", "qspi_if handle bulunamadi")
    endfunction

    //---- CCR degerini tek seferde kur (soc.h'taki QSPI_CCR_MAKE ile ayni) ----
    function bit [31:0] ccr_yap(bit clr, bit [5:0] presc, bit addr_en,
                                bit [7:0] size_m1, bit [4:0] dummy,
                                bit rw, bit [1:0] mode, bit [7:0] instr);
        return {clr, presc, addr_en, size_m1, dummy, rw, mode, instr};
    endfunction

    task automatic sta_oku(output bit [31:0] d);
        axil_single_seq s;
        s = axil_single_seq::type_id::create("sta");
        s.kind = AXIL_READ; s.addr = base_addr + 32'h0C;
        s.wdata = 0; s.gap = 1; s.beats = 1;
        s.start(qenv.agent.sqr);
        d = s.rdata;
    endtask

    task automatic reg_yaz(bit [31:0] off, bit [31:0] d);
        axil_single_seq s;
        s = axil_single_seq::type_id::create("w");
        s.kind = AXIL_WRITE; s.addr = base_addr + off;
        s.wdata = d; s.gap = 1; s.beats = 1;
        s.start(qenv.agent.sqr);
    endtask

    task automatic reg_oku(bit [31:0] off, output bit [31:0] d);
        axil_single_seq s;
        s = axil_single_seq::type_id::create("r");
        s.kind = AXIL_READ; s.addr = base_addr + off;
        s.wdata = 0; s.gap = 1; s.beats = 1;
        s.start(qenv.agent.sqr);
        d = s.rdata;
    endtask

    // Transferin bitmesini bekle (QSPI_STA[0] = DONE)
    task automatic done_bekle(int unsigned limit = 300);
        bit [31:0]   d;
        int unsigned n = 0;
        forever begin
            sta_oku(d);
            if (d[0]) return;
            n++;
            if (n > limit) begin
                `uvm_error("DONE", $sformatf("QSPI DONE zaman asimi (STA=0x%08h)", d))
                return;
            end
            repeat (50) @(posedge vif.clk);
        end
    endtask

    // Durum bayraklarini ve hata kodunu temizle (CCR[31] = 1)
    task automatic sta_temizle();
        reg_yaz(32'h00, 32'h8000_0000);
        repeat (5) @(posedge vif.clk);
    endtask

    task automatic fifo_flush();
        reg_yaz(32'h10, 32'h0000_0003);   // RXFLUSH | TXFLUSH
        repeat (5) @(posedge vif.clk);
    endtask

    // Flash agent'inin analiz FIFO'sunu bosalt. Her directed adim kendi
    // komutunu gormeli; onceki adimdan artan kayit sonrakini yaniltir.
    task automatic flash_fifo_bosalt();
        qspi_flash_pkg::qspi_cmd c;
        while (qenv.flash_fifo.try_get(c)) ;
    endtask
endclass


//---- 1) Reset degerleri -----------------------------------------------------
class qspi_reset_test extends qspi_base_test;
    `uvm_component_utils(qspi_reset_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        bit [31:0] d;
        phase.raise_objection(this);
        reset_bekle();

        // Reset sonrasi: her iki FIFO da BOS olmali
        sta_oku(d);
        if (!d[5]) `uvm_error("RESET", $sformatf("reset sonrasi RX FIFO bos olmali, STA=0x%08h", d))
        if (!d[7]) `uvm_error("RESET", $sformatf("reset sonrasi TX FIFO bos olmali, STA=0x%08h", d))
        if (d[4])  `uvm_error("RESET", "reset sonrasi RX FIFO dolu olmamali")
        if (d[6])  `uvm_error("RESET", "reset sonrasi TX FIFO dolu olmamali")
        if (d[11:8] != 4'h0) `uvm_error("RESET", "reset sonrasi hata kodu 0 olmali")

        reg_oku(32'h04, d);
        if (d !== 32'h0) `uvm_error("RESET", $sformatf("QSPI_ADR reset degeri 0 olmali, 0x%08h", d))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 2) Bit tarama (yalniz yan etkisiz QSPI_ADR) ---------------------------
class qspi_bitwalk_test extends qspi_base_test;
    `uvm_component_utils(qspi_bitwalk_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_bitwalk_seq s;
        phase.raise_objection(this);
        reset_bekle();
        s = axil_bitwalk_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = yaz_ofset;
        diziyi_kostur(s, 5ms);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 3) Salt-okunur QSPI_STA -----------------------------------------------
class qspi_ro_test extends qspi_base_test;
    `uvm_component_utils(qspi_ro_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        bit [31:0] once, sonra;
        phase.raise_objection(this);
        reset_bekle();
        sta_oku(once);
        reg_yaz(32'h0C, 32'hDEAD_BEEF);
        reg_yaz(32'h0C, 32'hFFFF_FFFF);
        sta_oku(sonra);
        if (once !== sonra)
            `uvm_error("RO", $sformatf("QSPI_STA salt okunur olmali: 0x%08h -> 0x%08h", once, sonra))
        else
            `uvm_info("RO", "QSPI_STA'ya yazma etkisiz -- dogru", UVM_LOW)
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 4) Haritalanmamis ofsetler --------------------------------------------
class qspi_unmapped_test extends qspi_base_test;
    `uvm_component_utils(qspi_unmapped_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_unmapped_seq s;
        bit [31:0]        d;
        phase.raise_objection(this);
        reset_bekle();
        reg_oku(32'h18, d);
        if (d !== 32'h0)
            `uvm_error("UNMAP", $sformatf("haritasiz ofset 0 dondurmeli, okunan 0x%08h", d))
        else
            `uvm_info("UNMAP", "haritasiz ofset 0 dondurdu -- default dali dogru", UVM_LOW)
        s = axil_unmapped_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = hrt_ofset;
        diziyi_kostur(s);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 5) Kisitli rastgele ----------------------------------------------------
//
//  DIKKAT: rastgele trafik QSPI_CCR'ye YAZAMAZ -- yazmak transfer baslatir.
//  QSPI_DR okumasi da yikicidir. Rastgele dizi bu ikisini adres listesinden
//  cikartir; ilgili davranislar directed testlerde dogrulanir.
class qspi_random_test extends qspi_base_test;
    `uvm_component_utils(qspi_random_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_random_seq s;
        phase.raise_objection(this);
        reset_bekle();
        repeat (3) begin
            s = axil_random_seq::type_id::create("s");
            s.base_addr  = base_addr;
            s.offsets    = '{32'h04, 32'h0C, 32'h10, 32'h14};
            s.wr_offsets = '{32'h04, 32'h10, 32'h14};
            s.n_items    = $urandom_range(25, 45);
            diziyi_kostur(s);
        end
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 6) Islem ortasinda reset -----------------------------------------------
class qspi_reset_mid_test extends qspi_base_test;
    `uvm_component_utils(qspi_reset_mid_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        bit [31:0] d;
        phase.raise_objection(this);
        reset_bekle();
        reg_yaz(32'h04, 32'h00AB_CDEF);

        fork
            begin
                axil_random_seq r;
                r = axil_random_seq::type_id::create("r");
                r.base_addr  = base_addr;
                r.offsets    = '{32'h04, 32'h0C, 32'h10};
                r.wr_offsets = '{32'h04, 32'h10};
                r.n_items    = 30;
                r.start(qenv.agent.sqr);
            end
            begin
                repeat (40) @(posedge vif.clk);
                reset_uygula(6);
            end
        join_any
        disable fork;

        // disable fork diziyi oldurur ama SURUCUDE ucusta kalmis bir islem
        // reset'ten SONRA tamamlanabilir; o yazma DUT'u yeniden kirletir.
        // Bu yuzden son kosullara bakmadan once hat bosalir ve TEMIZ bir
        // reset daha uygulanir. Testin amaci (islem ortasinda reset ve
        // kontrolcunun RST_01..05 kurallari) yukaridaki fork'ta zaten
        // gerceklesmistir.
        repeat (40) @(posedge vif.clk);
        reset_uygula(6);

        reg_oku(32'h04, d);
        if (d !== 32'h0)
            `uvm_error("RESET", $sformatf("reset sonrasi QSPI_ADR 0 olmali, okunan 0x%08h", d))
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 7) Stres: ayni VALID uzerinde iki islem --------------------------------
class qspi_stress_test extends qspi_base_test;
    `uvm_component_utils(qspi_stress_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_stress_seq s;
        phase.raise_objection(this);
        reset_bekle();
        s = axil_stress_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = yaz_ofset;
        s.n_items   = 6;
        s.beats     = 2;
        diziyi_kostur(s, 500us);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 8) FIFO bayraklari, hata kodlari ve flush ------------------------------
class qspi_fifo_test extends qspi_base_test;
    `uvm_component_utils(qspi_fifo_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        bit [31:0] d;

        phase.raise_objection(this);
        reset_bekle();

        //---- Bos RX FIFO'dan okuma -> hata kodu 1 ----
        sta_temizle();
        reg_oku(32'h08, d);                       // QSPI_DR okumasi (bos)
        if (d !== 32'h0)
            `uvm_error("FIFO", $sformatf("bos RX FIFO okumasi 0 dondurmeli, okunan 0x%08h", d))
        sta_oku(d);
        if (d[11:8] !== 4'h1)
            `uvm_error("FIFO", $sformatf("bos RX okumasi hata kodu 1 uretmeli, STA=0x%08h", d))
        else
            `uvm_info("FIFO", "bos RX FIFO okumasi hata kodu 1 uretti", UVM_LOW)

        //---- TX FIFO'yu doldur -> TXFULL, sonra tasir -> hata kodu 2 ----
        sta_temizle();
        fifo_flush();
        for (int i = 0; i < 64; i++) reg_yaz(32'h08, 32'h1000_0000 + i);
        sta_oku(d);
        if (!d[6]) `uvm_error("FIFO", $sformatf("64 yazmadan sonra TXFULL olmali, STA=0x%08h", d))
        if (d[7])  `uvm_error("FIFO", "TX FIFO dolu iken TXEMPTY 0 olmali")
        else       `uvm_info("FIFO", "64 kelime sonrasi TXFULL dogru", UVM_LOW)

        reg_yaz(32'h08, 32'hDEAD_BEEF);           // dolu FIFO'ya yazma
        sta_oku(d);
        if (d[11:8] !== 4'h2)
            `uvm_error("FIFO", $sformatf("dolu TX FIFO'ya yazma hata kodu 2 uretmeli, STA=0x%08h", d))
        else
            `uvm_info("FIFO", "dolu TX FIFO'ya yazma hata kodu 2 uretti", UVM_LOW)

        //---- Flush -> FIFO yeniden bos ----
        sta_temizle();
        fifo_flush();
        sta_oku(d);
        if (!d[7]) `uvm_error("FIFO", $sformatf("TXFLUSH sonrasi TXEMPTY olmali, STA=0x%08h", d))
        if (d[6])  `uvm_error("FIFO", "TXFLUSH sonrasi TXFULL olmamali")
        else       `uvm_info("FIFO", "TXFLUSH FIFO'yu bosalti", UVM_LOW)

        //---- QSPI_FCR kendini sifirlar ----
        reg_oku(32'h10, d);
        if (d !== 32'h0)
            `uvm_error("FCR", $sformatf("QSPI_FCR kendini sifirlamali, okunan 0x%08h", d))
        else
            `uvm_info("FCR", "QSPI_FCR bir cevrim sonra kendini sifirladi", UVM_LOW)

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 9) DMA register'i (0x14) ----------------------------------------------
//
//  Mevcut blok testbench'i (QSPI_tb.sv) dma_data/dma_valid portlarini HIC
//  baglamiyor ve 0x14 ofsetine hic erismiyor. Bu test o bosluğu kapatir.
class qspi_dma_test extends qspi_base_test;
    `uvm_component_utils(qspi_dma_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        bit [31:0]   d;
        int unsigned n_valid = 0;

        phase.raise_objection(this);
        reset_bekle();
        sta_temizle();
        fifo_flush();

        // Okuma sirasinda dma_valid dusuk olmali
        reg_oku(32'h14, d);
        if (d[0] !== 1'b0)
            `uvm_error("DMA", $sformatf("bosta dma_valid 0 olmali, okunan 0x%08h", d))

        // RX FIFO'ya veri koy (flash'tan okuyarak), sonra DMA'yi baslat
        reg_yaz(32'h04, 32'h0000_0000);
        reg_yaz(32'h00, ccr_yap(1'b0, 6'd4, 1'b1, 8'd3, 5'd0, 1'b0, 2'd1, 8'h03));
        done_bekle();

        // DMA baslat
        fork
            begin
                reg_yaz(32'h14, 32'h1);
            end
            begin
                repeat (400) begin
                    @(posedge vif.clk);
                    if (qvif.dma_valid) n_valid++;
                end
            end
        join

        if (n_valid == 0)
            `uvm_error("DMA", "dma_start sonrasi dma_valid darbesi bekleniyordu")
        else
            `uvm_info("DMA", $sformatf("dma_start -> %0d cevrim dma_valid yuksek kaldi", n_valid),
                      UVM_LOW)

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 10) Flash komutlari: RDID / READ / PP ---------------------------------
//
//  KAPSAM NOTU: flash protokolunun tam dogrulamasi gercek Micron modeliyle
//  XSim tarafinda yapilmistir. Buradaki hafif model, master'in URETTIGI
//  komut/adres/veri akisinin dogrulugunu ve okuma verisinin RX FIFO'ya
//  dogru dusmesini dogrular.
class qspi_flash_test extends qspi_base_test;
    `uvm_component_utils(qspi_flash_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        qspi_flash_pkg::qspi_cmd c;
        bit [31:0]               d;
        bit [7:0]                bekl[4];

        phase.raise_objection(this);
        reset_bekle();
        qenv.fcfg.jedec_id = 24'h20_BA_19;

        //---- (a) RDID: 3 bayt oku, adres yok ----
        flash_fifo_bosalt();
        sta_temizle(); fifo_flush();
        reg_yaz(32'h00, ccr_yap(1'b0, 6'd4, 1'b0, 8'd2, 5'd0, 1'b0, 2'd1, 8'h9F));
        done_bekle();
        qenv.flash_fifo.get(c);
        if (c.komut !== 8'h9F)
            `uvm_error("RDID", $sformatf("flash'a 0x9F gitmeliydi, gelen 0x%02h", c.komut))
        else
            `uvm_info("RDID", "0x9F komutu flash'a dogru iletildi", UVM_LOW)

        reg_oku(32'h08, d);
        `uvm_info("RDID", $sformatf("RX FIFO'dan okunan JEDEC verisi: 0x%08h", d), UVM_LOW)
        if (d[23:0] === 24'h0 || d === 32'hFFFF_FFFF)
            `uvm_error("RDID", $sformatf("JEDEC verisi anlamsiz: 0x%08h", d))

        //---- (b) PP: 4 bayt yaz ----
        flash_fifo_bosalt();
        sta_temizle(); fifo_flush();
        reg_yaz(32'h04, 32'h0001_0000);
        reg_yaz(32'h08, 32'h4433_2211);          // TX FIFO'ya bir kelime
        reg_yaz(32'h00, ccr_yap(1'b0, 6'd4, 1'b1, 8'd3, 5'd0, 1'b1, 2'd1, 8'h02));
        done_bekle();
        qenv.flash_fifo.get(c);
        if (c.komut !== 8'h02)
            `uvm_error("PP", $sformatf("flash'a 0x02 gitmeliydi, gelen 0x%02h", c.komut))
        else if (c.adres !== 24'h01_0000)
            `uvm_error("PP", $sformatf("PP adresi 0x010000 olmali, gelen 0x%06h", c.adres))
        else if (c.veri.size() < 4)
            `uvm_error("PP", $sformatf("PP 4 bayt yazmaliydi, flash %0d bayt gordu", c.veri.size()))
        else begin
            `uvm_info("PP", $sformatf("PP: adres 0x%06h, veri %p", c.adres, c.veri), UVM_LOW)
        end

        //---- (c) READ: yazdigimiz 4 bayti geri oku ----
        flash_fifo_bosalt();
        sta_temizle(); fifo_flush();
        reg_yaz(32'h04, 32'h0001_0000);
        reg_yaz(32'h00, ccr_yap(1'b0, 6'd4, 1'b1, 8'd3, 5'd0, 1'b0, 2'd1, 8'h03));
        done_bekle();
        qenv.flash_fifo.get(c);
        if (c.komut !== 8'h03)
            `uvm_error("READ", $sformatf("flash'a 0x03 gitmeliydi, gelen 0x%02h", c.komut))
        if (c.adres !== 24'h01_0000)
            `uvm_error("READ", $sformatf("READ adresi 0x010000 olmali, gelen 0x%06h", c.adres))

        reg_oku(32'h08, d);
        for (int i = 0; i < 4; i++) bekl[i] = qenv.flash.bellek_oku(24'h01_0000 + i);
        `uvm_info("READ", $sformatf(
            "flash bellegi: %02h %02h %02h %02h  |  RX FIFO: 0x%08h",
            bekl[0], bekl[1], bekl[2], bekl[3], d), UVM_LOW)

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 11) Veri modlari, dummy cevrimler ve uzun transferler -----------------
//
//  Bu test QSPI cekirdeginin x1 disindaki yollarini kapsar:
//    * x2 (DOR 0x3B) ve x4 (QOR 0x6B) okuma, dummy cevrimlerle
//    * x4 yazma (QPP 0x32)
//    * 4 bayttan uzun transfer (data_byte_size > 4 dali)
//    * 32-bit adres modu (QSPI_FCR[2])
//    * QSPI_CCR'nin geri okunmasi
class qspi_modes_test extends qspi_base_test;
    `uvm_component_utils(qspi_modes_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task automatic flash_doldur(bit [23:0] taban, int n);
        for (int i = 0; i < n; i++)
            qenv.flash.bellek[taban + i[23:0]] = 8'hA0 + i[7:0];
    endtask

    task run_phase(uvm_phase phase);
        qspi_flash_pkg::qspi_cmd c;
        bit [31:0]               ccr, d;

        phase.raise_objection(this);
        reset_bekle();
        qenv.fcfg.dummy = 8;

        //---- (a) QSPI_CCR geri okunabilir olmali ----
        ccr = ccr_yap(1'b0, 6'd4, 1'b1, 8'd3, 5'd8, 1'b0, 2'd3, 8'h6B);
        sta_temizle(); fifo_flush();
        reg_yaz(32'h04, 32'h0002_0000);
        reg_yaz(32'h00, ccr);
        done_bekle();
        reg_oku(32'h00, d);
        if (d[23:0] !== ccr[23:0])
            `uvm_error("CCR", $sformatf("QSPI_CCR geri okunmali: yazilan 0x%08h okunan 0x%08h",
                                        ccr, d))
        else
            `uvm_info("CCR", $sformatf("QSPI_CCR geri okundu: 0x%08h", d), UVM_LOW)

        //---- (b) x4 okuma (QOR) ----
        flash_doldur(24'h03_0000, 8);
        flash_fifo_bosalt();
        sta_temizle(); fifo_flush();
        reg_yaz(32'h04, 32'h0003_0000);
        reg_yaz(32'h00, ccr_yap(1'b0, 6'd4, 1'b1, 8'd3, 5'd8, 1'b0, 2'd3, 8'h6B));
        done_bekle();
        qenv.flash_fifo.get(c);
        if (c.komut !== 8'h6B)
            `uvm_error("QOR", $sformatf("flash'a 0x6B gitmeliydi, gelen 0x%02h", c.komut))
        reg_oku(32'h08, d);
        begin
            bit [31:0] bekl;
            bekl = {qenv.flash.bellek_oku(24'h03_0000), qenv.flash.bellek_oku(24'h03_0001),
                    qenv.flash.bellek_oku(24'h03_0002), qenv.flash.bellek_oku(24'h03_0003)};
            if (d !== bekl)
                `uvm_error("QOR", $sformatf("x4 okuma: beklenen 0x%08h, RX FIFO 0x%08h", bekl, d))
            else
                `uvm_info("QOR", $sformatf("x4 okuma dogru: 0x%08h", d), UVM_LOW)
        end

        //---- (c) x2 okuma (DOR) ----
        flash_fifo_bosalt();
        sta_temizle(); fifo_flush();
        reg_yaz(32'h04, 32'h0003_0000);
        reg_yaz(32'h00, ccr_yap(1'b0, 6'd4, 1'b1, 8'd3, 5'd8, 1'b0, 2'd2, 8'h3B));
        done_bekle();
        qenv.flash_fifo.get(c);
        if (c.komut !== 8'h3B)
            `uvm_error("DOR", $sformatf("flash'a 0x3B gitmeliydi, gelen 0x%02h", c.komut))
        reg_oku(32'h08, d);
        begin
            bit [31:0] bekl;
            bekl = {qenv.flash.bellek_oku(24'h03_0000), qenv.flash.bellek_oku(24'h03_0001),
                    qenv.flash.bellek_oku(24'h03_0002), qenv.flash.bellek_oku(24'h03_0003)};
            if (d !== bekl)
                `uvm_error("DOR", $sformatf("x2 okuma: beklenen 0x%08h, RX FIFO 0x%08h", bekl, d))
            else
                `uvm_info("DOR", $sformatf("x2 okuma dogru: 0x%08h", d), UVM_LOW)
        end

        //---- (d) x4 yazma (QPP) ----
        flash_fifo_bosalt();
        sta_temizle(); fifo_flush();
        reg_yaz(32'h04, 32'h0004_0000);
        reg_yaz(32'h08, 32'h8877_6655);
        reg_yaz(32'h00, ccr_yap(1'b0, 6'd4, 1'b1, 8'd3, 5'd0, 1'b1, 2'd3, 8'h32));
        done_bekle();
        qenv.flash_fifo.get(c);
        if (c.komut !== 8'h32)
            `uvm_error("QPP", $sformatf("flash'a 0x32 gitmeliydi, gelen 0x%02h", c.komut))
        else
            `uvm_info("QPP", $sformatf("x4 yazma: adres 0x%06h, flash'in gordugu %p",
                                       c.adres, c.veri), UVM_LOW)

        //---- (e) 4 bayttan uzun transfer (data_byte_size > 4 dali) ----
        flash_doldur(24'h05_0000, 16);
        sta_temizle(); fifo_flush();
        reg_yaz(32'h04, 32'h0005_0000);
        reg_yaz(32'h00, ccr_yap(1'b0, 6'd4, 1'b1, 8'd7, 5'd0, 1'b0, 2'd1, 8'h03));
        done_bekle();
        reg_oku(32'h08, d);
        `uvm_info("UZUN", $sformatf("8 baytlik okuma, ilk kelime: 0x%08h", d), UVM_LOW)
        reg_oku(32'h08, d);
        `uvm_info("UZUN", $sformatf("8 baytlik okuma, ikinci kelime: 0x%08h", d), UVM_LOW)

        //---- (f) 32-bit adres modu (QSPI_FCR[2]) ----
        sta_temizle(); fifo_flush();
        reg_yaz(32'h10, 32'h0000_0004);          // FCR[2] = 32-bit adres
        reg_yaz(32'h04, 32'h0006_0000);
        reg_yaz(32'h00, ccr_yap(1'b0, 6'd4, 1'b1, 8'd3, 5'd0, 1'b0, 2'd1, 8'h03));
        done_bekle();
        `uvm_info("ADR32", "32-bit adres modunda transfer tamamlandi", UVM_LOW)
        fifo_flush();

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass
