//=============================================================================
//  axil_base_test.svh  --  Butun testlerin tabani
//
//  Ustlendigi isler:
//    - ortami kurar, virtual interface'i dagitir
//    - reset uygular (arayuzdeki rst_req kancasi uzerinden)
//    - AXI protokol kontrolcusunun sayacini UVM raporuna baglar
//    - ev stiline uygun tek satirlik sonuc ozeti basar
//    - dizileri zaman asimi ile korur (kilitlenen bir DUT testi sonsuza
//      kadar bekletmesin)
//
//  beklenen_ihlal / beklenen_kilitlenme: bilerek hataya surulen testler
//  (or. GPIO stres testi) icin. Boyle bir testte hatanin ORTAYA CIKMASI
//  basaridir; cikmamasi rapor edilir.
//=============================================================================
class axil_base_test extends uvm_test;
    `uvm_component_utils(axil_base_test)

    axil_base_env   env;
    axil_cfg        cfg;
    virtual axil_if vif;

    // Testin bilerek beklediği durumlar
    bit beklenen_ihlal      = 1'b0;   // AXI protokol ihlali beklenir mi
    bit beklenen_kilitlenme = 1'b0;   // DUT'un kilitlenmesi beklenir mi
    bit kilitlenme_gorundu  = 1'b0;

    // Blok bilgileri -- turetilmis testler doldurur
    bit [31:0] base_addr = 32'h0000_0000;
    string     blok      = "AXIL";

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void yapilandir();
        // Turetilmis testler base_addr / blok degerlerini burada verir
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        yapilandir();

        if (!uvm_config_db#(virtual axil_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "axil_if handle bulunamadi")

        cfg            = axil_cfg::type_id::create("cfg");
        cfg.base_addr  = base_addr;
        cfg.block_name = blok;
        cfg.is_active  = 1;
        uvm_config_db#(axil_cfg)::set(this, "env", "cfg", cfg);

        env = axil_base_env::type_id::create("env", this);
    endfunction

    //---- Yardimcilar -----------------------------------------------------
    task automatic reset_bekle();
        wait (vif.rst_n === 1'b1);
        repeat (3) @(posedge vif.clk);
        if (env.sb != null) env.sb.do_reset();
    endtask

    // Islem ortasinda reset uygulamak icin
    task automatic reset_uygula(int unsigned cevrim = 5);
        // Reset penceresinde scoreboard kontrolleri kapatilir: o anda ucusta
        // olan islemlerin sonucu tanimsizdir.
        if (env.sb != null) env.sb.aktif = 1'b0;
        vif.rst_req = 1'b1;
        repeat (cevrim) @(posedge vif.clk);
        vif.rst_req = 1'b0;
        repeat (10) @(posedge vif.clk);
        if (env.sb != null) begin
            env.sb.do_reset();
            env.sb.aktif = 1'b1;
        end
    endtask

    // Diziyi zaman asimi ile calistir. Zaman asimi = DUT kilitlendi.
    task automatic diziyi_kostur(uvm_sequence #(axil_item) seq,
                                 time limit = 2ms);
        bit bitti = 1'b0;
        fork
            begin
                seq.start(env.agent.sqr);
                bitti = 1'b1;
            end
            begin
                #(limit);
            end
        join_any
        disable fork;

        if (!bitti) begin
            kilitlenme_gorundu = 1'b1;
            if (beklenen_kilitlenme)
                `uvm_info("KILIT", $sformatf(
                    "%s: DUT beklendigi gibi kilitlendi (%0t icinde islem tamamlanmadi)",
                    blok, limit), UVM_LOW)
            else
                `uvm_error("KILIT", $sformatf(
                    "%s: DUT kilitlendi -- %0t icinde islem tamamlanmadi",
                    blok, limit))
        end
    endtask

    //---- Rapor -----------------------------------------------------------
    function void report_phase(uvm_phase phase);
        int unsigned ihlal;
        int unsigned hata;
        uvm_report_server svr = uvm_report_server::get_server();

        ihlal = axi_chk_pkg::final_report();
        hata  = svr.get_severity_count(UVM_ERROR) + svr.get_severity_count(UVM_FATAL);

        if (beklenen_ihlal) begin
            if (ihlal == 0)
                $display("[UVM-OZET] %s / %s : AXI ihlali BEKLENIYORDU ama olusmadi",
                         blok, get_type_name());
        end
        else if (ihlal != 0) begin
            $display("[UVM-OZET] %s / %s : %0d AXI protokol ihlali",
                     blok, get_type_name(), ihlal);
        end

        if (beklenen_kilitlenme && !kilitlenme_gorundu)
            $display("[UVM-OZET] %s / %s : kilitlenme BEKLENIYORDU ama olusmadi",
                     blok, get_type_name());

        $display("");
        $display("======================================================================");
        $display("  UVM TEST OZETI : %s / %s", blok, get_type_name());
        $display("----------------------------------------------------------------------");
        $display("  AXI protokol ihlali : %0d", ihlal);
        $display("  UVM_ERROR + FATAL   : %0d", hata);
        if (env.sb != null)
            $display("  Scoreboard          : yazma=%0d okuma=%0d kontrol=%0d uyusmazlik=%0d",
                     env.sb.n_wr, env.sb.n_rd, env.sb.n_check, env.sb.n_mismatch);
        if (beklenen_kilitlenme)
            $display("  Beklenen kilitlenme : %s", kilitlenme_gorundu ? "OLUSTU" : "OLUSMADI");
        $display("  SONUC               : %s",
                 ((hata == 0) && (beklenen_ihlal || ihlal == 0)) ? "GECTI" : "KALDI");
        $display("======================================================================");
        $display("");
    endfunction
endclass
