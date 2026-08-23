//=============================================================================
//  axil_driver.svh  --  AXI4-Lite master surucusu
//
//  UC KILIT KISIT (RTL'den cikarildi, pazarliga acik degil):
//
//   1) AW ve W AYNI CEVRIMDE surulur. Yedi slave'in altisi kabul kosulunu
//      "awvalid && wvalid && awready && wready" olarak yazmistir; AW ve W'yi
//      bagimsiz kanallar gibi rastgele gecikmeyle suren klasik bir UVM
//      surucusu bu tasarimi KILITLER.
//
//   2) Uyaran NEGEDGE'de surulur. Posedge'de surmek sifir genislikli VALID
//      darbeleri uretir; mevcut blok testbench'leri bunun QSPI'da 600 binden
//      fazla sahte protokol ihlali dogurdugunu kaydetmisti.
//
//   3) Slave'ler 1 OUTSTANDING'dir; cevap donene kadar *ready dusuktur.
//      Surucu B (veya R) cevabini bekler.
//
//  beats: ayni VALID yukseltmesi uzerinde kac islem yapilacagi.
//    1  = normal master (el sikismadan sonra VALID duser)
//    >1 = boru hatli master: VALID INDIRILMEZ, ayni yukseltme uzerinde
//         pes pese el sikisma beklenir. AXI'de tamamen yasaldir ve gercek
//         bir CPU/DMA master'inin kuyrugu doluyken yaptigi seydir.
//         Kabul kosulunu kendi *ready'siyle nitelemeyen bir slave burada
//         KILITLENIR -- stres testinin amaci tam olarak budur.
//=============================================================================
class axil_driver extends uvm_driver #(axil_item);
    `uvm_component_utils(axil_driver)

    virtual axil_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual axil_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "axil_if handle bulunamadi (uvm_config_db)")
    endfunction

    task run_phase(uvm_phase phase);
        vif.idle_master();
        fork
            reset_gozcusu();
            ana_dongu();
        join
    endtask

    // Reset dustugu ANDA butun master cikislarini indirir.
    // AXI kurali (IHI0022 A3.1.2): reset aktifken hicbir VALID yuksek
    // olamaz. Yalnizca saat kenarinda kontrol etmek yetmez -- reset saat
    // kenarlari arasinda dusebilir ve bir sonraki posedge'de kontrolcunun
    // RST_01..05 kurallari tetiklenir. Bu gozcu olmadan ORTAMIN KENDISI
    // protokol ihlali uretir.
    task automatic reset_gozcusu();
        forever begin
            @(negedge vif.rst_n);
            vif.idle_master();
        end
    endtask

    task automatic ana_dongu();
        forever begin
            if (!vif.rst_n) begin
                vif.idle_master();
                @(posedge vif.rst_n);
                @(negedge vif.clk);
            end
            seq_item_port.get_next_item(req);
            drive(req);
            seq_item_port.item_done(req);
        end
    endtask

    task automatic drive(axil_item it);
        // Bosluk beklenirken reset dusebilir; her cevrimde kontrol edilir.
        // Aksi halde surucu reset AKTIFKEN VALID kaldirir ve ORTAMIN KENDISI
        // kontrolcunun RST_01..05 kurallarini ihlal eder.
        for (int i = 0; i < it.gap; i++) begin
            @(negedge vif.clk);
            if (!vif.rst_n) return;
        end
        if (!vif.rst_n) return;
        if (it.kind == AXIL_WRITE) drive_write(it);
        else                       drive_read(it);
    endtask

    task automatic drive_write(axil_item it);
        int unsigned n = (it.beats == 0) ? 1 : it.beats;

        @(negedge vif.clk);
        if (!vif.rst_n) return;
        vif.awaddr  <= it.addr;
        vif.wdata   <= it.wdata;
        vif.awvalid <= 1'b1;
        vif.wvalid  <= 1'b1;
        vif.bready  <= 1'b1;

        for (int i = 0; i < n; i++) begin
            // DUT'un ornekledigi kenari bekle
            forever begin
                @(posedge vif.clk);
                if (!vif.rst_n) begin vif.idle_master(); return; end
                if (vif.awready && vif.wready) break;
            end
            // Son beat degilse VALID INDIRILMEZ, yeni adres/veri sunulur
            if (i < n-1) begin
                @(negedge vif.clk);
                vif.awaddr <= it.addr;
                vif.wdata  <= it.wdata + 32'h1;
            end
        end

        @(negedge vif.clk);
        vif.awvalid <= 1'b0;
        vif.wvalid  <= 1'b0;

        forever begin
            @(posedge vif.clk);
            if (!vif.rst_n) begin vif.idle_master(); return; end
            if (vif.bvalid) break;
        end
        it.resp = vif.bresp;

        @(negedge vif.clk);
        vif.bready <= 1'b0;
    endtask

    task automatic drive_read(axil_item it);
        int unsigned n = (it.beats == 0) ? 1 : it.beats;

        @(negedge vif.clk);
        if (!vif.rst_n) return;
        vif.araddr  <= it.addr;
        vif.arvalid <= 1'b1;
        vif.rready  <= 1'b1;

        for (int i = 0; i < n; i++) begin
            forever begin
                @(posedge vif.clk);
                if (!vif.rst_n) begin vif.idle_master(); return; end
                if (vif.arready) break;
            end
            if (i < n-1) begin
                @(negedge vif.clk);
                vif.araddr <= it.addr;
            end
        end

        @(negedge vif.clk);
        vif.arvalid <= 1'b0;

        forever begin
            @(posedge vif.clk);
            if (!vif.rst_n) begin vif.idle_master(); return; end
            if (vif.rvalid) break;
        end
        it.rdata = vif.rdata;
        it.resp  = vif.rresp;

        @(negedge vif.clk);
        vif.rready <= 1'b0;
    endtask
endclass
