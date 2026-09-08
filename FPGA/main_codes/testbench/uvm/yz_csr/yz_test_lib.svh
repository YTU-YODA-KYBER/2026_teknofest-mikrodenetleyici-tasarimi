//=============================================================================
//  yz_test_lib.svh  --  YZ hizlandirici CSR test kutuphanesi
//=============================================================================

class yz_base_test extends axil_base_test;
    `uvm_component_utils(yz_base_test)

    yz_env               yenv;
    virtual yz_accel_if  avif;

    bit [31:0] tum_ofset[$] = '{32'h00, 32'h04, 32'h08,
                                32'h10, 32'h14, 32'h18, 32'h1C};
    bit [31:0] ro_ofset [$] = '{32'h04, 32'h08,
                                32'h10, 32'h14, 32'h18, 32'h1C};
    //  0x0C: CTRL ile SCORE0 arasindaki bosluk. 0x20 ve 0x24: son SCORE'un
    //  ustu. Ucu de okuma case'inin default daline duser -> 0 dondurmeli.
    bit [31:0] hrt_ofset[$] = '{32'h0C, 32'h20, 32'h24};

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void yapilandir();
        base_addr = 32'h4006_0000;
        blok      = "YZ_CSR";
    endfunction

    function void build_phase(uvm_phase phase);
        axil_base_env::type_id::set_type_override(yz_env::get_type());
        super.build_phase(phase);
        if (!$cast(yenv, env)) `uvm_fatal("ENV", "yz_env cast basarisiz")
        if (!uvm_config_db#(virtual yz_accel_if)::get(this, "", "vif", avif))
            `uvm_fatal("NOVIF", "yz_accel_if handle bulunamadi")
    endfunction

    // Hizlandirici tarafina komut gonder
    task automatic accel_op(yz_accel_pkg::yz_op_e op,
                            bit [7:0] deger = 8'h0,
                            int unsigned cevrim = 1,
                            bit [127:0] skorlar = 128'h0);
        yz_accel_pkg::yz_accel_seq s;
        s = yz_accel_pkg::yz_accel_seq::type_id::create("a");
        s.op      = op;
        s.deger   = deger;
        s.skorlar = skorlar;
        s.cevrim  = cevrim;
        s.start(yenv.accel.sqr);
    endtask
endclass


//---- 1) Reset degerleri -----------------------------------------------------
class yz_reset_test extends yz_base_test;
    `uvm_component_utils(yz_reset_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;

        phase.raise_objection(this);
        reset_bekle();

        yenv.yrm.YZ_STATUS.read(st, d);
        if (d !== 32'h0)
            `uvm_error("RESET", $sformatf("reset sonrasi YZ_STATUS 0 olmali, okunan 0x%08h", d))
        yenv.yrm.YZ_RESULT.read(st, d);
        if (d !== 32'h0)
            `uvm_error("RESET", $sformatf("reset sonrasi YZ_RESULT 0 olmali, okunan 0x%08h", d))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 2) Salt-okunur register'lar -------------------------------------------
class yz_ro_test extends yz_base_test;
    `uvm_component_utils(yz_ro_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_ro_seq    s;
        uvm_status_e   st;
        uvm_reg_data_t once, sonra;

        phase.raise_objection(this);
        reset_bekle();

        yenv.yrm.YZ_STATUS.read(st, once);
        s = axil_ro_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = ro_ofset;
        diziyi_kostur(s);
        yenv.yrm.YZ_STATUS.read(st, sonra);
        if (once !== sonra)
            `uvm_error("RO", $sformatf("YZ_STATUS salt okunur olmali: 0x%08h -> 0x%08h", once, sonra))

        yenv.yrm.YZ_RESULT.read(st, sonra);
        if (sonra !== 32'h0)
            `uvm_error("RO", $sformatf("YZ_RESULT'a yazma etkisiz olmali, okunan 0x%08h", sonra))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 3) Haritalanmamis ofsetler --------------------------------------------
//
//  Bu blogun okuma case'inde DEFAULT VARDIR, bu yuzden haritasiz ofset
//  daima 0 dondurur -- GPIO/UART'taki "bayat rdata" davranisi burada YOK.
class yz_unmapped_test extends yz_base_test;
    `uvm_component_utils(yz_unmapped_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_unmapped_seq s;
        axil_single_seq   t;

        phase.raise_objection(this);
        reset_bekle();

        // Once bilinen sifir olmayan bir deger okut (RESULT'a sinif yaz)
        accel_op(yz_accel_pkg::YZ_WRITE_RESULT, 8'h03);
        t = axil_single_seq::type_id::create("r");
        t.kind = AXIL_READ; t.addr = base_addr + 32'h08;
        t.wdata = 0; t.gap = 1; t.beats = 1;
        t.start(yenv.agent.sqr);
        if (t.rdata !== 32'h3)
            `uvm_error("RESULT", $sformatf("YZ_RESULT 3 olmali, okunan 0x%08h", t.rdata))

        // Haritasiz ofset 0 dondurmeli (bayat deger DEGIL)
        t = axil_single_seq::type_id::create("ru");
        t.kind = AXIL_READ; t.addr = base_addr + 32'h0C;
        t.wdata = 0; t.gap = 1; t.beats = 1;
        t.start(yenv.agent.sqr);
        if (t.rdata !== 32'h0)
            `uvm_error("UNMAP", $sformatf(
                "haritasiz ofset 0 dondurmeli (RTL'de default var), okunan 0x%08h", t.rdata))
        else
            `uvm_info("UNMAP", "haritasiz ofset 0 dondurdu -- default dali dogru calisiyor", UVM_LOW)

        s = axil_unmapped_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = hrt_ofset;
        diziyi_kostur(s);

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 4) Kisitli rastgele ----------------------------------------------------
class yz_random_test extends yz_base_test;
    `uvm_component_utils(yz_random_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_random_seq s;
        phase.raise_objection(this);
        reset_bekle();
        repeat (3) begin
            s = axil_random_seq::type_id::create("s");
            s.base_addr  = base_addr;
            s.offsets    = tum_ofset;
            s.wr_offsets = '{32'h00};
            s.n_items    = $urandom_range(25, 45);
            diziyi_kostur(s);
        end
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 5) Islem ortasinda reset -----------------------------------------------
class yz_reset_mid_test extends yz_base_test;
    `uvm_component_utils(yz_reset_mid_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;

        phase.raise_objection(this);
        reset_bekle();

        accel_op(yz_accel_pkg::YZ_WRITE_RESULT, 8'h02);
        accel_op(yz_accel_pkg::YZ_PULSE_DONE);

        fork
            begin
                axil_random_seq r;
                r = axil_random_seq::type_id::create("r");
                r.base_addr  = base_addr;
                r.offsets    = tum_ofset;
                r.wr_offsets = '{32'h00};
                r.n_items    = 30;
                r.start(yenv.agent.sqr);
            end
            begin
                repeat (40) @(posedge vif.clk);
                reset_uygula(6);
            end
        join

        // Iki kol da tamamlansin; boylece surucude sahipsiz islem kalmadan
        // son kosul temiz bir resetle denetlenir.
        reset_uygula(6);

        yenv.yrm.YZ_RESULT.read(st, d);
        if (d !== 32'h0)
            `uvm_error("RESET", $sformatf("reset sonrasi YZ_RESULT 0 olmali, okunan 0x%08h", d))
        yenv.yrm.YZ_STATUS.read(st, d);
        if (d[2] !== 1'b0)
            `uvm_error("RESET", $sformatf("reset sonrasi infer_pending 0 olmali, STATUS=0x%08h", d))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 6) Stres: ayni VALID uzerinde iki islem --------------------------------
class yz_stress_test extends yz_base_test;
    `uvm_component_utils(yz_stress_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_stress_seq s;
        phase.raise_objection(this);
        reset_bekle();
        s = axil_stress_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = tum_ofset;
        s.n_items   = 6;
        s.beats     = 2;
        diziyi_kostur(s, 500us);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 7) CSR islevi: darbeler, durum bitleri, sonuc latch'i -----------------
class yz_csr_test extends yz_base_test;
    `uvm_component_utils(yz_csr_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;
        int unsigned   n0;
        bit [31:0]     skor_bekle [4];

        phase.raise_objection(this);
        reset_bekle();

        //---- YZ_CTRL[0] = START -> acc_start darbesi ----
        n0 = yenv.accel.mon.n_start;
        yenv.yrm.YZ_CTRL.write(st, 32'h1);
        repeat (10) @(posedge vif.clk);
        if (yenv.accel.mon.n_start != n0 + 1)
            `uvm_error("CTRL", $sformatf(
                "YZ_CTRL[0] tam 1 acc_start darbesi uretmeli (%0d -> %0d)",
                n0, yenv.accel.mon.n_start))
        else
            `uvm_info("CTRL", "YZ_CTRL[0] -> acc_start darbesi dogru", UVM_LOW)

        //---- YZ_CTRL[1] = LOAD_CLEAR -> load_clear darbesi ----
        n0 = yenv.accel.mon.n_load_clear;
        yenv.yrm.YZ_CTRL.write(st, 32'h2);
        repeat (10) @(posedge vif.clk);
        if (yenv.accel.mon.n_load_clear != n0 + 1)
            `uvm_error("CTRL", $sformatf(
                "YZ_CTRL[1] tam 1 load_clear darbesi uretmeli (%0d -> %0d)",
                n0, yenv.accel.mon.n_load_clear))
        else
            `uvm_info("CTRL", "YZ_CTRL[1] -> load_clear darbesi dogru", UVM_LOW)

        //---- YZ_STATUS bit dizilimi: {infer_pending, load_done_irq, acc_busy} ----
        accel_op(yz_accel_pkg::YZ_SET_BUSY, 8'h1);
        yenv.yrm.YZ_STATUS.read(st, d);
        if (d[0] !== 1'b1)
            `uvm_error("STATUS", $sformatf("acc_busy=1 iken STATUS[0] 1 olmali, 0x%08h", d))

        accel_op(yz_accel_pkg::YZ_SET_BUSY, 8'h0);
        accel_op(yz_accel_pkg::YZ_SET_LOAD_IRQ, 8'h1);
        yenv.yrm.YZ_STATUS.read(st, d);
        if (d[1] !== 1'b1)
            `uvm_error("STATUS", $sformatf("load_done_irq=1 iken STATUS[1] 1 olmali, 0x%08h", d))
        if (d[0] !== 1'b0)
            `uvm_error("STATUS", $sformatf("acc_busy=0 iken STATUS[0] 0 olmali, 0x%08h", d))

        accel_op(yz_accel_pkg::YZ_SET_LOAD_IRQ, 8'h0);

        //---- acc_done -> infer_pending = 1 -> infer_irq = 1 ----
        accel_op(yz_accel_pkg::YZ_PULSE_DONE);
        repeat (5) @(posedge vif.clk);
        yenv.yrm.YZ_STATUS.read(st, d);
        if (d[2] !== 1'b1)
            `uvm_error("IRQ", $sformatf("acc_done sonrasi STATUS[2] 1 olmali, 0x%08h", d))
        if (avif.infer_irq !== 1'b1)
            `uvm_error("IRQ", "acc_done sonrasi infer_irq yuksek olmali")

        //---- YZ_CTRL[2] = INFER_CLEAR -> infer_pending = 0 ----
        yenv.yrm.YZ_CTRL.write(st, 32'h4);
        repeat (5) @(posedge vif.clk);
        yenv.yrm.YZ_STATUS.read(st, d);
        if (d[2] !== 1'b0)
            `uvm_error("IRQ", $sformatf("INFER_CLEAR sonrasi STATUS[2] 0 olmali, 0x%08h", d))
        if (avif.infer_irq !== 1'b0)
            `uvm_error("IRQ", "INFER_CLEAR sonrasi infer_irq dusuk olmali")

        //---- YZ_RESULT: acc_out_wen ile yakalanan sinif (dort sinif) ----
        for (int c = 0; c < 4; c++) begin
            accel_op(yz_accel_pkg::YZ_WRITE_RESULT, c[7:0]);
            repeat (3) @(posedge vif.clk);
            yenv.yrm.YZ_RESULT.read(st, d);
            if (d[1:0] !== c[1:0])
                `uvm_error("RESULT", $sformatf(
                    "sinif %0d yazildi, YZ_RESULT 0x%08h okundu", c, d))
        end
        `uvm_info("RESULT", "dort sinifin dordu de YZ_RESULT'ta dogru yakalandi", UVM_LOW)

        //---- Ust bitler sizmamali: acc_out_wdata = 0xFF -> RESULT = 3 ----
        accel_op(yz_accel_pkg::YZ_WRITE_RESULT, 8'hFF);
        repeat (3) @(posedge vif.clk);
        yenv.yrm.YZ_RESULT.read(st, d);
        if (d !== 32'h3)
            `uvm_error("RESULT", $sformatf(
                "acc_out_wdata=0xFF icin YZ_RESULT 3 olmali (yalniz [1:0]), okunan 0x%08h", d))

        //---- YZ_SCORE0..3: sinif ile AYNI cevrimde yakalanmali ----
        //  Isaretli degerler bilerek secildi: 32 bitin tamami sizsin, isaret
        //  uzatma ya da bit kaymasi olursa yakalansin.
        skor_bekle = '{32'h0000_0001, 32'hFFFF_FFFF,
                       32'h7FFF_FFFF, 32'h8000_0000};
        accel_op(yz_accel_pkg::YZ_WRITE_RESULT, 8'h2, 1,
                 {skor_bekle[3], skor_bekle[2], skor_bekle[1], skor_bekle[0]});
        repeat (3) @(posedge vif.clk);
        for (int k = 0; k < 4; k++) begin
            yenv.yrm.YZ_SCORE[k].read(st, d);
            if (d !== skor_bekle[k])
                `uvm_error("SCORE", $sformatf(
                    "YZ_SCORE%0d: yazilan 0x%08h, okunan 0x%08h",
                    k, skor_bekle[k], d))
        end
        //  Sonraki yakalamada dordu de birlikte guncellenmeli (bayat kalmamali)
        skor_bekle = '{32'h0000_0000, 32'h0000_0000,
                       32'h0000_0000, 32'h0000_0000};
        accel_op(yz_accel_pkg::YZ_WRITE_RESULT, 8'h0, 1, 128'h0);
        repeat (3) @(posedge vif.clk);
        for (int k = 0; k < 4; k++) begin
            yenv.yrm.YZ_SCORE[k].read(st, d);
            if (d !== skor_bekle[k])
                `uvm_error("SCORE", $sformatf(
                    "YZ_SCORE%0d bayat kaldi: okunan 0x%08h", k, d))
        end
        `uvm_info("SCORE", "dort skor da sinifla ayni cevrimde yakalandi", UVM_LOW)

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass
