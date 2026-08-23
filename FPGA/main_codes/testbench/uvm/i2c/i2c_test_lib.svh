//=============================================================================
//  i2c_test_lib.svh  --  I2C test kutuphanesi
//=============================================================================

class i2c_base_test extends axil_base_test;
    `uvm_component_utils(i2c_base_test)

    i2c_env ienv;

    bit [31:0] tum_ofset[$] = '{32'h00, 32'h04, 32'h08, 32'h0C, 32'h10, 32'h14};
    bit [31:0] yaz_ofset[$] = '{32'h04, 32'h0C};    // kirpma/HW olmayanlar
    bit [31:0] ro_ofset [$] = '{32'h08};
    bit [31:0] hrt_ofset[$] = '{32'h18, 32'h1C, 32'h40};

    localparam bit [6:0] SLAVE_ADR = 7'h50;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void yapilandir();
        base_addr = 32'h4002_0000;
        blok      = "I2C";
    endfunction

    function void build_phase(uvm_phase phase);
        axil_base_env::type_id::set_type_override(i2c_env::get_type());
        super.build_phase(phase);
        if (!$cast(ienv, env)) `uvm_fatal("ENV", "i2c_env cast basarisiz")
    endfunction

    // DONE bayragini POLLING ile bekle.
    // Okuma yolu transfer sirasinda BLOKLANMAZ (cekirdek yalnizca awready/
    // wready'yi dusurur, arready'ye dokunmaz), bu yuzden polling calisir.
    // Bir YAZMA denemesi ise transfer boyunca AXI'yi bekletirdi.
    task automatic done_bekle(bit okuma, int unsigned limit = 400);
        uvm_status_e   st;
        uvm_reg_data_t d;
        int unsigned   n = 0;
        forever begin
            ienv.irm.I2C_CFG.read(st, d);
            if (okuma  && d[3]) return;
            if (!okuma && d[1]) return;
            n++;
            if (n > limit) begin
                `uvm_error("DONE", $sformatf("%s DONE zaman asimi (CFG=0x%08h)",
                                             okuma ? "RD" : "WR", d))
                return;
            end
            repeat (100) @(posedge vif.clk);
        end
    endtask

    // Transferin bittigini (CFG[0] ve CFG[2] dusmus) bekle -- NACK durumunda
    // hicbir DONE bayragi set EDILMEZ, bu yuzden ayri bir bekleme gerekir.
    task automatic transfer_bitti_bekle(int unsigned limit = 400);
        uvm_status_e   st;
        uvm_reg_data_t d;
        int unsigned   n = 0;
        forever begin
            ienv.irm.I2C_CFG.read(st, d);
            if (!d[0] && !d[2]) return;
            n++;
            if (n > limit) begin
                `uvm_error("ABORT", $sformatf("transfer bitmedi (CFG=0x%08h)", d));
                return;
            end
            repeat (100) @(posedge vif.clk);
        end
    endtask

    task automatic bayraklari_temizle();
        uvm_status_e st;
        ienv.irm.I2C_CLR.write(st, 32'h3);   // TXDONE + RXDONE
    endtask
endclass


//---- 1) Reset degerleri -----------------------------------------------------
class i2c_reset_test extends i2c_base_test;
    `uvm_component_utils(i2c_reset_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_reset_seq s;
        phase.raise_objection(this);
        reset_bekle();
        s = axil_reset_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = tum_ofset;
        diziyi_kostur(s);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 2) Bit tarama ----------------------------------------------------------
class i2c_bitwalk_test extends i2c_base_test;
    `uvm_component_utils(i2c_bitwalk_test)
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


//---- 3) Salt-okunur I2C_RDR -------------------------------------------------
class i2c_ro_test extends i2c_base_test;
    `uvm_component_utils(i2c_ro_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_ro_seq    s;
        uvm_status_e   st;
        uvm_reg_data_t once, sonra;
        phase.raise_objection(this);
        reset_bekle();
        ienv.irm.I2C_RDR.read(st, once);
        s = axil_ro_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = ro_ofset;
        diziyi_kostur(s);
        ienv.irm.I2C_RDR.read(st, sonra);
        if (once !== sonra)
            `uvm_error("RO", $sformatf("I2C_RDR salt okunur olmali: 0x%08h -> 0x%08h", once, sonra))
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 4) Haritalanmamis ofsetler --------------------------------------------
class i2c_unmapped_test extends i2c_base_test;
    `uvm_component_utils(i2c_unmapped_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_unmapped_seq s;
        axil_single_seq   t;
        phase.raise_objection(this);
        reset_bekle();

        t = axil_single_seq::type_id::create("ru");
        t.kind = AXIL_READ; t.addr = base_addr + 32'h18;
        t.wdata = 0; t.gap = 1; t.beats = 1;
        t.start(ienv.agent.sqr);
        if (t.rdata !== 32'h0)
            `uvm_error("UNMAP", $sformatf(
                "haritasiz ofset 0 dondurmeli (RTL'de default var), okunan 0x%08h", t.rdata))
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
//  DIKKAT: rastgele trafik I2C_CFG'ye YAZAMAZ. CFG[0] ya da CFG[2] set
//  edilirse cekirdek transfer baslatir ve awready/wready'yi transfer boyunca
//  dusuk tutar; rastgele bir yazma dizisi bunu yuzlerce mikrosaniye bekler.
//  Transfer davranisi kendi directed testlerinde dogrulanir.
class i2c_random_test extends i2c_base_test;
    `uvm_component_utils(i2c_random_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_random_seq s;
        phase.raise_objection(this);
        reset_bekle();
        repeat (3) begin
            s = axil_random_seq::type_id::create("s");
            s.base_addr  = base_addr;
            s.offsets    = tum_ofset;
            s.wr_offsets = '{32'h00, 32'h04, 32'h0C, 32'h14};
            s.n_items    = $urandom_range(25, 45);
            diziyi_kostur(s);
        end
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 6) Islem ortasinda reset -----------------------------------------------
class i2c_reset_mid_test extends i2c_base_test;
    `uvm_component_utils(i2c_reset_mid_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;
        phase.raise_objection(this);
        reset_bekle();

        ienv.irm.I2C_ADR.write(st, SLAVE_ADR);
        ienv.irm.I2C_TDR.write(st, 32'h0000_00A5);

        fork
            begin
                axil_random_seq r;
                r = axil_random_seq::type_id::create("r");
                r.base_addr  = base_addr;
                r.offsets    = tum_ofset;
                r.wr_offsets = '{32'h00, 32'h04, 32'h0C};
                r.n_items    = 30;
                r.start(ienv.agent.sqr);
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

        ienv.irm.I2C_ADR.read(st, d);
        if (d !== 32'h0)
            `uvm_error("RESET", $sformatf("reset sonrasi I2C_ADR 0 olmali, okunan 0x%08h", d))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 7) Stres: ayni VALID uzerinde iki islem --------------------------------
class i2c_stress_test extends i2c_base_test;
    `uvm_component_utils(i2c_stress_test)
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


//---- 8) I2C_NBY kirpma semantigi -------------------------------------------
//
//  RTL: if (wdata > 4) I2C_NBY <= 4; else if (!wdata) I2C_NBY <= 1;
//       else I2C_NBY <= wdata;
//  Yazilanla geri okunanin farkli olmasi TASARIM GEREGIDIR.
class i2c_nby_test extends i2c_base_test;
    `uvm_component_utils(i2c_nby_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        int            yaz[$]  = '{0, 1, 2, 3, 4, 5, 17, 255};
        int            bekl[$] = '{1, 1, 2, 3, 4, 4,  4,   4};
        uvm_status_e   st;
        uvm_reg_data_t d;

        phase.raise_objection(this);
        reset_bekle();

        foreach (yaz[i]) begin
            ienv.irm.I2C_NBY.write(st, yaz[i]);
            ienv.irm.I2C_NBY.read (st, d);
            if (d !== bekl[i])
                `uvm_error("NBY", $sformatf(
                    "I2C_NBY kirpmasi: yazilan %0d, beklenen %0d, okunan %0d", yaz[i], bekl[i], d))
        end
        `uvm_info("NBY", "kirpma kurali (>4 -> 4, 0 -> 1) dogrulandi", UVM_LOW)

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 9) Yazma transferi: 1..4 bayt -----------------------------------------
class i2c_write_test extends i2c_base_test;
    `uvm_component_utils(i2c_write_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e            st;
        bit [31:0]              tdr;
        i2c_slave_pkg::i2c_txn  t;

        phase.raise_objection(this);
        reset_bekle();
        ienv.scfg.adres = SLAVE_ADR;

        for (int nby = 1; nby <= 4; nby++) begin
            tdr = 32'h0;
            for (int b = 0; b < nby; b++)
                tdr[b*8 +: 8] = 8'h10 + (nby*16) + b;

            ienv.irm.I2C_ADR.write(st, SLAVE_ADR);
            ienv.irm.I2C_NBY.write(st, nby);
            ienv.irm.I2C_TDR.write(st, tdr);
            bayraklari_temizle();
            ienv.irm.I2C_CFG.write(st, 32'h1);      // TXEN

            done_bekle(1'b0);
            ienv.slave_fifo.get(t);

            if (t.adres !== SLAVE_ADR)
                `uvm_error("WR", $sformatf("slave adresi yanlis: 0x%02h", t.adres))
            if (t.okuma !== 1'b0)
                `uvm_error("WR", "adres baytinda R/W biti 0 (yazma) olmali")
            if (t.veri.size() != nby)
                `uvm_error("WR", $sformatf("NBY=%0d icin %0d bayt bekleniyordu, %0d geldi",
                                           nby, nby, t.veri.size()))
            else begin
                for (int b = 0; b < nby; b++)
                    if (t.veri[b] !== tdr[b*8 +: 8])
                        `uvm_error("WR", $sformatf(
                            "NBY=%0d bayt %0d: gonderilen 0x%02h, slave'de 0x%02h",
                            nby, b, tdr[b*8 +: 8], t.veri[b]))
                `uvm_info("WR", $sformatf("NBY=%0d: %0d bayt dogru iletildi", nby, nby), UVM_LOW)
            end
            bayraklari_temizle();
        end

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 10) Okuma transferi: 1..4 bayt (repeated-START ile) -------------------
class i2c_read_test extends i2c_base_test;
    `uvm_component_utils(i2c_read_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e            st;
        uvm_reg_data_t          d;
        i2c_slave_pkg::i2c_txn  t;

        phase.raise_objection(this);
        reset_bekle();
        ienv.scfg.adres = SLAVE_ADR;

        for (int nby = 1; nby <= 4; nby++) begin
            ienv.scfg.okuma_verisi.delete();
            for (int b = 0; b < nby; b++)
                ienv.scfg.okuma_verisi.push_back(8'hC0 + (nby*4) + b);

            ienv.irm.I2C_ADR.write(st, SLAVE_ADR);
            ienv.irm.I2C_NBY.write(st, nby);
            bayraklari_temizle();
            ienv.irm.I2C_CFG.write(st, 32'h4);      // RXEN

            done_bekle(1'b1);

            // Okumada slave IKI kayit yayinlar: once adres+W fazi, sonra
            // repeated-START'in ardindan gelen adres+R fazi. Okuma kaydi
            // bulunana kadar FIFO bosaltilir. get() yerine try_get()
            // kullanilir; beklenenden az kayit gelirse test KILITLENMEZ.
            begin
                i2c_slave_pkg::i2c_txn tt;
                int deneme = 0;
                t = null;
                while (deneme < 20) begin
                    if (ienv.slave_fifo.try_get(tt)) begin
                        if (tt.okuma) begin t = tt; break; end
                    end
                    else repeat (200) @(posedge vif.clk);
                    deneme++;
                end
            end

            if (t == null) begin
                `uvm_error("RD", $sformatf(
                    "NBY=%0d: repeated-START sonrasi okuma transferi slave'de gorulmedi", nby))
                continue;
            end

            ienv.irm.I2C_RDR.read(st, d);
            for (int b = 0; b < nby; b++) begin
                if (d[b*8 +: 8] !== ienv.scfg.okuma_verisi[b])
                    `uvm_error("RD", $sformatf(
                        "NBY=%0d bayt %0d: slave 0x%02h gonderdi, I2C_RDR'de 0x%02h",
                        nby, b, ienv.scfg.okuma_verisi[b], d[b*8 +: 8]))
            end
            `uvm_info("RD", $sformatf("NBY=%0d: I2C_RDR=0x%08h", nby, d), UVM_LOW)
            bayraklari_temizle();
        end

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 11) NACK: sessiz iptal -------------------------------------------------
//
//  RTL S_ABORT dalinda CFG[0] ve CFG[2] temizlenir ama HICBIR DONE BAYRAGI
//  SET EDILMEZ. Yazilim acisindan bu "sessiz zaman asimi"dir: transfer bitmis
//  ama basarili mi belli degildir. Test bu davranisi acikca dogrular.
class i2c_nack_test extends i2c_base_test;
    `uvm_component_utils(i2c_nack_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e            st;
        uvm_reg_data_t          d;
        i2c_slave_pkg::i2c_txn  t;

        phase.raise_objection(this);
        reset_bekle();
        ienv.scfg.adres = SLAVE_ADR;

        //---- (a) ADRESTE NACK ----
        ienv.scfg.adres_nack = 1'b1;
        ienv.irm.I2C_ADR.write(st, SLAVE_ADR);
        ienv.irm.I2C_NBY.write(st, 2);
        ienv.irm.I2C_TDR.write(st, 32'h0000_1234);
        bayraklari_temizle();
        ienv.irm.I2C_CFG.write(st, 32'h1);

        transfer_bitti_bekle();
        ienv.irm.I2C_CFG.read(st, d);
        if (d[1] || d[3])
            `uvm_error("NACK", $sformatf(
                "adreste NACK sonrasi DONE bayragi SET EDILMEMELI, CFG=0x%08h", d))
        else
            `uvm_info("NACK", "adreste NACK: transfer sessizce iptal edildi (DONE yok) -- belgelenen davranis",
                      UVM_LOW)
        ienv.slave_fifo.get(t);
        if (!t.adres_nack)
            `uvm_error("NACK", "slave adres NACK'i kaydetmeliydi")

        //---- (b) VERIDE NACK ----
        ienv.scfg.adres_nack   = 1'b0;
        ienv.scfg.veri_nack_at = 0;          // ilk veri baytina NACK
        ienv.irm.I2C_NBY.write(st, 3);
        ienv.irm.I2C_TDR.write(st, 32'h00AB_CDEF);
        bayraklari_temizle();
        ienv.irm.I2C_CFG.write(st, 32'h1);

        transfer_bitti_bekle();
        ienv.irm.I2C_CFG.read(st, d);
        if (d[1] || d[3])
            `uvm_error("NACK", $sformatf(
                "veride NACK sonrasi DONE bayragi SET EDILMEMELI, CFG=0x%08h", d))
        else
            `uvm_info("NACK", "veride NACK: transfer sessizce iptal edildi (DONE yok)", UVM_LOW)

        ienv.scfg.veri_nack_at = -1;
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 12) I2C_CLR (W1C) ve TXEN+RXEN oncelik kurali -------------------------
class i2c_flags_test extends i2c_base_test;
    `uvm_component_utils(i2c_flags_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e            st;
        uvm_reg_data_t          d;
        i2c_slave_pkg::i2c_txn  t;

        phase.raise_objection(this);
        reset_bekle();
        ienv.scfg.adres = SLAVE_ADR;

        //---- Bir yazma yap, TXDONE set olsun ----
        ienv.irm.I2C_ADR.write(st, SLAVE_ADR);
        ienv.irm.I2C_NBY.write(st, 1);
        ienv.irm.I2C_TDR.write(st, 32'h0000_0077);
        ienv.irm.I2C_CFG.write(st, 32'h1);
        done_bekle(1'b0);
        ienv.slave_fifo.get(t);

        ienv.irm.I2C_CFG.read(st, d);
        if (!d[1]) `uvm_error("FLAG", "yazma sonrasi TXDONE set olmali")

        //---- I2C_CLR[0] = 1 -> TXDONE temizlenmeli ----
        ienv.irm.I2C_CLR.write(st, 32'h1);
        ienv.irm.I2C_CFG.read(st, d);
        if (d[1]) `uvm_error("FLAG", $sformatf("I2C_CLR[0] TXDONE'u temizlemeli, CFG=0x%08h", d))
        else      `uvm_info("FLAG", "I2C_CLR[0] TXDONE'u temizledi", UVM_LOW)

        //---- I2C_CLR okumasi 0 donmeli (decode edilmiyor) ----
        ienv.irm.I2C_CLR.read(st, d);
        if (d !== 32'h0)
            `uvm_error("FLAG", $sformatf("I2C_CLR okumasi 0 donmeli, okunan 0x%08h", d))

        //---- TXEN + RXEN birlikte -> YAZMA kazanir ----
        //  RTL: is_read_op <= (I2C_CFG[2] && !I2C_CFG[0])
        ienv.scfg.okuma_verisi.delete();
        ienv.scfg.okuma_verisi.push_back(8'hEE);
        ienv.irm.I2C_NBY.write(st, 1);
        ienv.irm.I2C_TDR.write(st, 32'h0000_0088);
        bayraklari_temizle();
        ienv.irm.I2C_CFG.write(st, 32'h5);       // TXEN | RXEN

        done_bekle(1'b0);
        ienv.slave_fifo.get(t);
        if (t.okuma)
            `uvm_error("PRIO", "TXEN+RXEN birlikte iken YAZMA kazanmali (adres+W)")
        else if (t.veri.size() != 1 || t.veri[0] !== 8'h88)
            `uvm_error("PRIO", $sformatf("yazma verisi 0x88 olmali, slave'de %p", t.veri))
        else
            `uvm_info("PRIO", "TXEN+RXEN birlikte: yazma onceligi dogru", UVM_LOW)

        ienv.irm.I2C_CFG.read(st, d);
        if (!d[1]) `uvm_error("PRIO", "yazma tamamlandiginda TXDONE set olmali")

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass
