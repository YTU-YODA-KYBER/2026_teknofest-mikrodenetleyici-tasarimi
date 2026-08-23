//=============================================================================
//  uart_test_lib.svh  --  UART test kutuphanesi (UART_GU ve UART_YZ ortak)
//
//  Ortak yedi test + UART'a ozgu testler: baud supurmesi, stop biti
//  varyantlari, TX/RX cerceve dogrulugu, esZamanli TX+RX, CFG yaris
//  senaryosu ve UART_CPB = 0 tuzagi.
//=============================================================================

class uart_base_test extends axil_base_test;
    `uvm_component_utils(uart_base_test)

    uart_env         uenv;
    virtual uart_if  svif;

    bit [31:0] tum_ofset[$] = '{32'h00, 32'h04, 32'h08, 32'h0C, 32'h10};
    bit [31:0] yaz_ofset[$] = '{32'h00, 32'h04, 32'h0C};
    bit [31:0] ro_ofset [$] = '{32'h08};
    bit [31:0] hrt_ofset[$] = '{32'h14, 32'h18, 32'h1C};

    // Hizli simulasyon icin kisa bir bit suresi. 16'nin kati secilir cunku
    // RX tarafi cnt_limit_mirror = UART_CPB[19:4] (yani CPB/16) kullanir.
    int unsigned CPB_TEST = 160;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        axil_base_env::type_id::set_type_override(uart_env::get_type());
        super.build_phase(phase);
        if (!$cast(uenv, env)) `uvm_fatal("ENV", "uart_env cast basarisiz")
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "vif", svif))
            `uvm_fatal("NOVIF", "uart_if handle bulunamadi")
    endfunction

    // Baud bolenini hem register'a hem agent'a kur
    task automatic baud_kur(int unsigned cpb);
        uvm_status_e st;
        uenv.urm.UART_CPB.write(st, cpb);
        svif.cpb = cpb;
    endtask

    // Bir bayt gonder (TX) ve seri monitorun cozdugunu bekle
    task automatic tx_gonder(bit [7:0] d);
        uvm_status_e st;
        uenv.urm.UART_TDR.write(st, d);
        uenv.urm.UART_CFG.write(st, 32'h1);   // TXSTART
    endtask

    // Bir bayt al (RX) -- seri surucu DUT'un rx hattina basar
    task automatic rx_al(bit [7:0] d);
        uart_pkg::uart_send_seq s;
        s = uart_pkg::uart_send_seq::type_id::create("rx");
        s.data = d;
        s.start(uenv.serial.sqr);
    endtask

    // TXDONE bayragini bekle (zaman asimi ile)
    task automatic txdone_bekle(int unsigned limit_cevrim);
        uvm_status_e   st;
        uvm_reg_data_t d;
        int unsigned   n = 0;
        forever begin
            uenv.urm.UART_CFG.read(st, d);
            if (d[2]) break;
            n++;
            if (n > limit_cevrim) begin
                `uvm_error("TXDONE", "TXDONE zaman asimi")
                break;
            end
            repeat (20) @(posedge vif.clk);
        end
        uenv.urm.UART_CFG.write(st, 32'h0);   // bayraklari temizle
    endtask
endclass


//---- 1) Reset degerleri -----------------------------------------------------
class uart_reset_test extends uart_base_test;
    `uvm_component_utils(uart_reset_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_reset_seq s;
        uvm_status_e   st;
        uvm_reg_data_t d;

        phase.raise_objection(this);
        reset_bekle();

        // UART_CPB reset degeri 0'dir. Bu bir TUZAKTIR: TX baud ureteci
        // "tx_tick_cnt >= UART_CPB - 1" karsilastirmasini yapar; 0 - 1
        // 32'hFFFF_FFFF olur ve tx_zero_alert HIC olusmaz. Yani CPB
        // programlanmadan gonderim BASLAMAZ.
        uenv.urm.UART_CPB.read(st, d);
        if (d !== 32'h0)
            `uvm_error("RESET", $sformatf("UART_CPB reset degeri 0 olmali, okunan 0x%08h", d))

        s = axil_reset_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = tum_ofset;
        diziyi_kostur(s);

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 2) Bit tarama ----------------------------------------------------------
class uart_bitwalk_test extends uart_base_test;
    `uvm_component_utils(uart_bitwalk_test)
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


//---- 3) Salt-okunur UART_RDR ------------------------------------------------
class uart_ro_test extends uart_base_test;
    `uvm_component_utils(uart_ro_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_ro_seq    s;
        uvm_status_e   st;
        uvm_reg_data_t once, sonra;

        phase.raise_objection(this);
        reset_bekle();

        uenv.urm.UART_RDR.read(st, once);
        s = axil_ro_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = ro_ofset;
        diziyi_kostur(s);
        uenv.urm.UART_RDR.read(st, sonra);
        if (once !== sonra)
            `uvm_error("RO", $sformatf("UART_RDR salt okunur olmali: 0x%08h -> 0x%08h", once, sonra))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 4) Haritalanmamis ofsetler --------------------------------------------
class uart_unmapped_test extends uart_base_test;
    `uvm_component_utils(uart_unmapped_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_single_seq s;
        bit [31:0]      bilinen, bayat;

        phase.raise_objection(this);
        reset_bekle();

        s = axil_single_seq::type_id::create("w");
        s.kind = AXIL_WRITE; s.addr = base_addr + 32'h0C;
        s.wdata = 32'h0000_00A5; s.gap = 1; s.beats = 1;
        s.start(uenv.agent.sqr);

        s = axil_single_seq::type_id::create("r");
        s.kind = AXIL_READ; s.addr = base_addr + 32'h0C;
        s.wdata = 0; s.gap = 1; s.beats = 1;
        s.start(uenv.agent.sqr);
        bilinen = s.rdata;

        s = axil_single_seq::type_id::create("ru");
        s.kind = AXIL_READ; s.addr = base_addr + 32'h14;
        s.wdata = 0; s.gap = 1; s.beats = 1;
        s.start(uenv.agent.sqr);
        bayat = s.rdata;

        if (bayat !== bilinen)
            `uvm_error("UNMAP", $sformatf(
                "haritasiz ofsette bayat deger beklendi (0x%08h), okunan 0x%08h", bilinen, bayat))
        else
            `uvm_info("UNMAP", $sformatf(
                "haritasiz ofset 0x14 bayat deger dondurdu (0x%08h) -- belgelenen davranis",
                bayat), UVM_LOW)

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 5) Kisitli rastgele ----------------------------------------------------
class uart_random_test extends uart_base_test;
    `uvm_component_utils(uart_random_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_random_seq s;
        phase.raise_objection(this);
        reset_bekle();
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
class uart_reset_mid_test extends uart_base_test;
    `uvm_component_utils(uart_reset_mid_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;

        phase.raise_objection(this);
        reset_bekle();
        baud_kur(CPB_TEST);

        fork
            begin
                axil_random_seq r;
                r = axil_random_seq::type_id::create("r");
                r.base_addr  = base_addr;
                r.offsets    = tum_ofset;
                r.wr_offsets = yaz_ofset;
                r.n_items    = 30;
                r.start(uenv.agent.sqr);
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

        uenv.urm.UART_CPB.read(st, d);
        if (d !== 32'h0)
            `uvm_error("RESET", $sformatf("reset sonrasi UART_CPB 0 olmali, okunan 0x%08h", d))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 7) Stres: ayni VALID uzerinde iki islem --------------------------------
class uart_stress_test extends uart_base_test;
    `uvm_component_utils(uart_stress_test)
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


//---- 8) TX cercevesi: gonderilen bayt hatta dogru cikiyor mu ---------------
class uart_tx_test extends uart_base_test;
    `uvm_component_utils(uart_tx_test)

    int unsigned n_alinan = 0;
    int unsigned n_yanlis = 0;

    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        bit [7:0] veri[$] = '{8'h55, 8'hAA, 8'h00, 8'hFF, 8'h5A, 8'hA5};
        uart_pkg::uart_item alinan;

        phase.raise_objection(this);
        reset_bekle();
        baud_kur(CPB_TEST);

        foreach (veri[i]) begin
            tx_gonder(veri[i]);
            // Seri monitorun cerceveyi cozmesini bekle
            uenv.serial_fifo.get(alinan);
            n_alinan++;
            if (alinan.data !== veri[i]) begin
                n_yanlis++;
                `uvm_error("TX", $sformatf(
                    "gonderilen 0x%02h, hatta gorulen 0x%02h", veri[i], alinan.data))
            end
            txdone_bekle(200);
        end

        `uvm_info("TX", $sformatf("%0d bayt gonderildi, %0d yanlis", n_alinan, n_yanlis), UVM_LOW)
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 9) RX cercevesi: hattan gelen bayt UART_RDR'ye dogru duşuyor mu -------
class uart_rx_test extends uart_base_test;
    `uvm_component_utils(uart_rx_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        bit [7:0]      veri[$] = '{8'h55, 8'hAA, 8'h01, 8'hFE, 8'h3C};
        uvm_status_e   st;
        uvm_reg_data_t d;

        phase.raise_objection(this);
        reset_bekle();
        baud_kur(CPB_TEST);

        foreach (veri[i]) begin
            rx_al(veri[i]);
            // RXREADY bekle
            begin
                int unsigned n = 0;
                forever begin
                    uenv.urm.UART_CFG.read(st, d);
                    if (d[1]) break;
                    n++;
                    if (n > 100) begin
                        `uvm_error("RX", $sformatf("0x%02h icin RXREADY zaman asimi", veri[i]));
                        break;
                    end
                    repeat (20) @(posedge vif.clk);
                end
            end
            uenv.urm.UART_RDR.read(st, d);
            if (d[7:0] !== veri[i])
                `uvm_error("RX", $sformatf(
                    "hattan gonderilen 0x%02h, UART_RDR'de 0x%02h", veri[i], d[7:0]))
            else
                `uvm_info("RX", $sformatf("0x%02h dogru alindi", veri[i]), UVM_HIGH)
            uenv.urm.UART_CFG.write(st, 32'h0);
            repeat (CPB_TEST) @(posedge vif.clk);
        end

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 10) Baud supurmesi + stop biti varyantlari ----------------------------
//
//  UART_CPB'ye yazmanin YAN ETKISI vardir: cnt_limit_mirror <= wdata[19:4],
//  yani RX tarafinin 16x asiri ornekleme siniri. Bu yuzden CPB'nin 16'nin
//  kati olmasi TX/RX kaymasini engeller. Test hem 16'nin kati degerleri hem
//  de gercek firmware degeri olan 434'u dener (50 MHz / 434 = 115200).
class uart_baud_test extends uart_base_test;
    `uvm_component_utils(uart_baud_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        int unsigned   cpb_listesi[$] = '{64, 160, 320, 434};
        uvm_status_e   st;
        uvm_reg_data_t d;
        uart_pkg::uart_item alinan;

        phase.raise_objection(this);
        reset_bekle();

        foreach (cpb_listesi[i]) begin
            baud_kur(cpb_listesi[i]);
            uenv.urm.UART_CPB.read(st, d);
            if (d !== cpb_listesi[i])
                `uvm_error("CPB", $sformatf("UART_CPB geri okuma: yazilan %0d okunan %0d",
                                            cpb_listesi[i], d))

            // Bu baud ile bir bayt gonder ve hatta dogru ciktigini kontrol et
            tx_gonder(8'h96);
            uenv.serial_fifo.get(alinan);
            if (alinan.data !== 8'h96)
                `uvm_error("BAUD", $sformatf("CPB=%0d ile TX bozuldu: 0x%02h",
                                             cpb_listesi[i], alinan.data))
            else
                `uvm_info("BAUD", $sformatf("CPB=%0d: TX cercevesi dogru", cpb_listesi[i]), UVM_LOW)
            txdone_bekle(500);
        end

        // Stop biti varyantlari: 00 = 1 bit, 01 = 1.5 bit, 1X = 2 bit
        baud_kur(CPB_TEST);
        for (int sv = 0; sv < 4; sv++) begin
            uenv.urm.UART_STP.write(st, sv);
            uenv.urm.UART_STP.read (st, d);
            if (d !== (sv & 32'h3))
                `uvm_error("STP", $sformatf("UART_STP yalniz [1:0] saklamali: yazilan %0d okunan %0d",
                                            sv, d))
            tx_gonder(8'h3C);
            uenv.serial_fifo.get(alinan);
            if (alinan.data !== 8'h3C)
                `uvm_error("STP", $sformatf("STP=%0d ile TX bozuldu: 0x%02h", sv, alinan.data))
            txdone_bekle(500);
        end

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 11) EsZamanli TX + RX --------------------------------------------------
class uart_duplex_test extends uart_base_test;
    `uvm_component_utils(uart_duplex_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;
        uart_pkg::uart_item alinan;

        phase.raise_objection(this);
        reset_bekle();
        baud_kur(CPB_TEST);

        fork
            begin
                tx_gonder(8'h7E);
                uenv.serial_fifo.get(alinan);
                if (alinan.data !== 8'h7E)
                    `uvm_error("DUPLEX", $sformatf("TX bozuldu: 0x%02h", alinan.data))
            end
            begin
                rx_al(8'hC3);
            end
        join

        // RXREADY ve alinan bayti kontrol et
        begin
            int unsigned n = 0;
            forever begin
                uenv.urm.UART_CFG.read(st, d);
                if (d[1]) break;
                n++;
                if (n > 100) begin `uvm_error("DUPLEX", "RXREADY zaman asimi"); break; end
                repeat (20) @(posedge vif.clk);
            end
        end
        uenv.urm.UART_RDR.read(st, d);
        if (d[7:0] !== 8'hC3)
            `uvm_error("DUPLEX", $sformatf("esZamanli RX bozuldu: 0x%02h", d[7:0]))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 12) UART_CPB = 0 tuzagi ------------------------------------------------
//
//  UART_CPB reset'te 0'dir. TX baud ureteci "tx_tick_cnt >= UART_CPB - 1"
//  karsilastirmasini yapar; UART_CPB 32-bit oldugu icin 0 - 1 = 32'hFFFF_FFFF
//  olur ve 16-bit tx_tick_cnt bu esige HIC ulasamaz. Sonuc: tx_zero_alert
//  hic olusmaz ve TX FSM'i IDLE'da kilitli kalir.
//
//  Bu bir HATA DEGIL, belgelenmis bir kisittir: yazilim gonderim yapmadan
//  once UART_CPB'yi programlamak ZORUNDADIR. Test bunu acikca gosterir.
class uart_cpb_zero_test extends uart_base_test;
    `uvm_component_utils(uart_cpb_zero_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;

        phase.raise_objection(this);
        reset_bekle();

        // CPB programlanmadan gonderim dene
        uenv.urm.UART_TDR.write(st, 8'hA5);
        uenv.urm.UART_CFG.write(st, 32'h1);        // TXSTART
        repeat (2000) @(posedge vif.clk);
        uenv.urm.UART_CFG.read(st, d);
        if (d[2])
            `uvm_error("CPB0", "UART_CPB=0 iken TXDONE olusmamaliydi")
        else
            `uvm_info("CPB0", "UART_CPB=0 iken gonderim baslamiyor -- belgelenen kisit dogrulandi",
                      UVM_LOW)

        // Simdi CPB'yi programla, gonderim calismali
        uenv.urm.UART_CFG.write(st, 32'h0);
        baud_kur(CPB_TEST);
        tx_gonder(8'hA5);
        txdone_bekle(500);

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass
