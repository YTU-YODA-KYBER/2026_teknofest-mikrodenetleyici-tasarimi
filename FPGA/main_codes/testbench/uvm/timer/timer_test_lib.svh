//=============================================================================
//  timer_test_lib.svh  --  Timer test kutuphanesi
//=============================================================================

class timer_base_test extends axil_base_test;
    `uvm_component_utils(timer_base_test)

    timer_env tenv;

    bit [31:0] tum_ofset[$] = '{32'h00, 32'h04, 32'h08, 32'h0C,
                                32'h10, 32'h14, 32'h18, 32'h1C};
    bit [31:0] yaz_ofset[$] = '{32'h00, 32'h04, 32'h0C, 32'h10};
    bit [31:0] ro_ofset [$] = '{32'h14, 32'h18};
    bit [31:0] hrt_ofset[$] = '{32'h20, 32'h24, 32'h40, 32'h80};

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void yapilandir();
        base_addr = 32'h4000_0000;
        blok      = "TIMER";
    endfunction

    function void build_phase(uvm_phase phase);
        axil_base_env::type_id::set_type_override(timer_env::get_type());
        super.build_phase(phase);
        if (!$cast(tenv, env)) `uvm_fatal("ENV", "timer_env cast basarisiz")
    endfunction

    // Sayaci bilinen bir duruma getir
    task automatic timer_kur(bit [31:0] pre, bit [31:0] are, bit yukari);
        uvm_status_e st;
        tenv.trm.TIM_ENA.write(st, 32'h0);
        tenv.trm.TIM_PRE.write(st, pre);
        tenv.trm.TIM_ARE.write(st, are);
        tenv.trm.TIM_MOD.write(st, yukari ? 32'h1 : 32'h0);
        tenv.trm.TIM_CLR.write(st, 32'h1);       // CNT=0, TIM_PRE <= TIM_PRE_m
    endtask
endclass


//---- 1) Reset degerleri -----------------------------------------------------
class timer_reset_test extends timer_base_test;
    `uvm_component_utils(timer_reset_test)
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
class timer_bitwalk_test extends timer_base_test;
    `uvm_component_utils(timer_bitwalk_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_bitwalk_seq s;
        uvm_status_e     st;
        phase.raise_objection(this);
        reset_bekle();
        // Sayac DURSUN: calisirken TIM_PRE/TIM_CNT degisir ve yazma/okuma
        // arasindaki degeri donanim degistirebilir.
        tenv.trm.TIM_ENA.write(st, 32'h0);
        s = axil_bitwalk_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = yaz_ofset;
        diziyi_kostur(s, 5ms);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 3) Salt-okunur register'lar -------------------------------------------
class timer_ro_test extends timer_base_test;
    `uvm_component_utils(timer_ro_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_ro_seq    s;
        uvm_status_e   st;
        uvm_reg_data_t once, sonra;

        phase.raise_objection(this);
        reset_bekle();
        tenv.trm.TIM_ENA.write(st, 32'h0);   // CNT/EVN sabit kalsin

        // TIM_CNT
        tenv.trm.TIM_CNT.read(st, once);
        s = axil_ro_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = '{32'h14};
        diziyi_kostur(s);
        tenv.trm.TIM_CNT.read(st, sonra);
        if (once !== sonra)
            `uvm_error("RO", $sformatf("TIM_CNT salt okunur olmali: 0x%08h -> 0x%08h", once, sonra))

        // TIM_EVN
        tenv.trm.TIM_EVN.read(st, once);
        s = axil_ro_seq::type_id::create("s2");
        s.base_addr = base_addr;
        s.offsets   = '{32'h18};
        diziyi_kostur(s);
        tenv.trm.TIM_EVN.read(st, sonra);
        if (once !== sonra)
            `uvm_error("RO", $sformatf("TIM_EVN salt okunur olmali: 0x%08h -> 0x%08h", once, sonra))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 4) Haritalanmamis ofsetler --------------------------------------------
class timer_unmapped_test extends timer_base_test;
    `uvm_component_utils(timer_unmapped_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_unmapped_seq s;
        phase.raise_objection(this);
        reset_bekle();
        s = axil_unmapped_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = hrt_ofset;
        diziyi_kostur(s);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 5) Kisitli rastgele ----------------------------------------------------
class timer_random_test extends timer_base_test;
    `uvm_component_utils(timer_random_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_random_seq s;
        uvm_status_e    st;
        phase.raise_objection(this);
        reset_bekle();
        tenv.trm.TIM_ENA.write(st, 32'h0);
        repeat (3) begin
            s = axil_random_seq::type_id::create("s");
            s.base_addr  = base_addr;
            s.offsets    = tum_ofset;
            s.wr_offsets = yaz_ofset;
            s.n_items    = $urandom_range(25, 45);
            diziyi_kostur(s);
        end
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 6) Islem ortasinda reset -----------------------------------------------
class timer_reset_mid_test extends timer_base_test;
    `uvm_component_utils(timer_reset_mid_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;
        phase.raise_objection(this);
        reset_bekle();

        tenv.trm.TIM_ARE.write(st, 32'h0000_00FF);
        tenv.trm.TIM_ENA.write(st, 32'h1);

        fork
            begin
                axil_random_seq r;
                r = axil_random_seq::type_id::create("r");
                r.base_addr  = base_addr;
                r.offsets    = tum_ofset;
                r.wr_offsets = yaz_ofset;
                r.n_items    = 30;
                r.start(tenv.agent.sqr);
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

        tenv.trm.TIM_ARE.read(st, d);
        if (d !== 32'h0) `uvm_error("RESET", $sformatf("reset sonrasi TIM_ARE 0 olmali, okunan 0x%08h", d))
        tenv.trm.TIM_ENA.read(st, d);
        if (d !== 32'h0) `uvm_error("RESET", $sformatf("reset sonrasi TIM_ENA 0 olmali, okunan 0x%08h", d))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 7) Stres: ayni VALID uzerinde iki islem --------------------------------
class timer_stress_test extends timer_base_test;
    `uvm_component_utils(timer_stress_test)
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


//---- 8) Sayma davranisi -----------------------------------------------------
class timer_count_test extends timer_base_test;
    `uvm_component_utils(timer_count_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t c1, c2, e1, e2;

        phase.raise_objection(this);
        reset_bekle();

        //---- Yukari sayma ----
        timer_kur(32'h0, 32'd1000, 1'b1);
        tenv.trm.TIM_CNT.read(st, c1);
        if (c1 !== 32'h0)
            `uvm_error("CNT", $sformatf("CLR sonrasi TIM_CNT 0 olmali, okunan %0d", c1))

        tenv.trm.TIM_ENA.write(st, 32'h1);
        repeat (200) @(posedge vif.clk);
        tenv.trm.TIM_ENA.write(st, 32'h0);
        tenv.trm.TIM_CNT.read(st, c1);
        tenv.trm.TIM_CNT.read(st, c2);
        if (c1 !== c2)
            `uvm_error("CNT", $sformatf("ENA=0 iken sayac degismemeli: %0d -> %0d", c1, c2))
        if (c1 == 0 || c1 > 32'd1000)
            `uvm_error("CNT", $sformatf("yukari sayma beklenen aralikta degil: %0d", c1))
        else
            `uvm_info("CNT", $sformatf("yukari sayma: 200 cevrimde TIM_CNT=%0d", c1), UVM_LOW)

        //---- Asagi sayma: ilk tick'te TIM_CNT <= TIM_ARE olur ----
        timer_kur(32'h0, 32'd500, 1'b0);
        tenv.trm.TIM_ENA.write(st, 32'h1);
        repeat (50) @(posedge vif.clk);
        tenv.trm.TIM_ENA.write(st, 32'h0);
        tenv.trm.TIM_CNT.read(st, c1);
        if (c1 == 0 || c1 > 32'd500)
            `uvm_error("CNT", $sformatf("asagi sayma beklenen aralikta degil: %0d", c1))
        else
            `uvm_info("CNT", $sformatf("asagi sayma: 50 cevrimde TIM_CNT=%0d (ARE=500'den geri)", c1), UVM_LOW)

        //---- Prescaler: PRE_m = 9 -> her 10 tick'te bir sayim ----
        timer_kur(32'd9, 32'd1000, 1'b1);
        tenv.trm.TIM_ENA.write(st, 32'h1);
        repeat (200) @(posedge vif.clk);
        tenv.trm.TIM_ENA.write(st, 32'h0);
        tenv.trm.TIM_CNT.read(st, c2);
        if (c2 == 0 || c2 > 40)
            `uvm_error("PRE", $sformatf("prescaler=9 ile 200 cevrimde ~20 sayim beklenir, okunan %0d", c2))
        else
            `uvm_info("PRE", $sformatf("prescaler=9: 200 cevrimde TIM_CNT=%0d", c2), UVM_LOW)

        //---- Olay sayaci: kucuk ARE ile EVN artmali ----
        timer_kur(32'h0, 32'd3, 1'b1);
        tenv.trm.TIM_EVC.write(st, 32'h1);       // EVN = 0
        tenv.trm.TIM_EVN.read(st, e1);
        if (e1 !== 32'h0)
            `uvm_error("EVN", $sformatf("EVC sonrasi TIM_EVN 0 olmali, okunan %0d", e1))
        tenv.trm.TIM_ENA.write(st, 32'h1);
        repeat (200) @(posedge vif.clk);
        tenv.trm.TIM_ENA.write(st, 32'h0);
        tenv.trm.TIM_EVN.read(st, e2);
        if (e2 == 0)
            `uvm_error("EVN", "ARE=3 ile 200 cevrimde olay sayaci artmali")
        else
            `uvm_info("EVN", $sformatf("ARE=3, 200 cevrim -> TIM_EVN=%0d", e2), UVM_LOW)

        // EVC ile temizle
        tenv.trm.TIM_EVC.write(st, 32'h1);
        tenv.trm.TIM_EVN.read(st, e1);
        if (e1 !== 32'h0)
            `uvm_error("EVN", $sformatf("EVC=1 sonrasi TIM_EVN 0 olmali, okunan %0d", e1))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 9) Olay register'larinin bit0 semantigi --------------------------------
//
//  TIM_CLR ve TIM_EVC "olay" register'idir: bit0 = 1 yazildiginda donanim
//  islemi yapar ve REGISTERIN TAMAMINI sifirlar. bit0 = 0 yazilirsa deger
//  oldugu gibi durur ve hicbir sey tetiklenmez. Bu test iki yolu da dogrular.
class timer_event_test extends timer_base_test;
    `uvm_component_utils(timer_event_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;

        phase.raise_objection(this);
        reset_bekle();

        // bit0 = 1 -> kendini sifirlar
        tenv.trm.TIM_CLR.write(st, 32'h0000_0003);
        tenv.trm.TIM_CLR.read (st, d);
        if (d !== 32'h0)
            `uvm_error("EVT", $sformatf("TIM_CLR bit0=1 sonrasi 0 olmali, okunan 0x%08h", d))

        tenv.trm.TIM_EVC.write(st, 32'h0000_0001);
        tenv.trm.TIM_EVC.read (st, d);
        if (d !== 32'h0)
            `uvm_error("EVT", $sformatf("TIM_EVC bit0=1 sonrasi 0 olmali, okunan 0x%08h", d))

        // bit0 = 0 -> deger korunur, hicbir sey tetiklenmez
        tenv.trm.TIM_CLR.write(st, 32'h0000_0002);
        tenv.trm.TIM_CLR.read (st, d);
        if (d !== 32'h0000_0002)
            `uvm_error("EVT", $sformatf("TIM_CLR bit0=0 iken deger korunmali, okunan 0x%08h", d))

        tenv.trm.TIM_EVC.write(st, 32'h0000_0004);
        tenv.trm.TIM_EVC.read (st, d);
        if (d !== 32'h0000_0004)
            `uvm_error("EVT", $sformatf("TIM_EVC bit0=0 iken deger korunmali, okunan 0x%08h", d))

        // Temizle
        tenv.trm.TIM_CLR.write(st, 32'h1);
        tenv.trm.TIM_EVC.write(st, 32'h1);

        // TIM_PRE aynasi: yazilan deger TIM_PRE_m'ye gider ve geri okunur.
        // Calisan sayac TIM_PRE hicbir ofsetten OKUNAMAZ.
        tenv.trm.TIM_PRE.write(st, 32'h0000_0055);
        tenv.trm.TIM_PRE.read (st, d);
        if (d !== 32'h0000_0055)
            `uvm_error("PRE", $sformatf("TIM_PRE aynasi geri okunmali, okunan 0x%08h", d))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass
