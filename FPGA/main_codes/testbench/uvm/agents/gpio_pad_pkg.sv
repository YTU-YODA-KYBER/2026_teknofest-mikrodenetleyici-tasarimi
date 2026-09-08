//=============================================================================
//  gpio_pad_pkg.sv  --  GPIO fiziksel taraf agent'i
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  Aktif taraf: switch'leri (GPIO_IDR) surer.
//  Pasif taraf: ODR / anode / catode'u izler, YAPISAL degismezleri
//  kontrol eder ve degerleri scoreboard'a yayinlar.
//
//  Kontrol edilen yapisal kurallar (RTL'den cikarildi):
//    PAD_01  anode her zaman "one-cold" olmalidir (tam bir bit 0)
//    PAD_03  gosterim kosulu saglanmiyorsa catode 8'hFF (sonuk) olmalidir
//            kosul: (IDR == 1 && ODR[2:0] != 0) || IDR == 2
//=============================================================================
`ifndef GPIO_PAD_PKG_SV
`define GPIO_PAD_PKG_SV
`timescale 1ns/1ps

package gpio_pad_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //---- Transaction --------------------------------------------------------
    class gpio_pad_item extends uvm_sequence_item;
        rand bit [31:0]   idr;          // surulecek switch degeri
        rand int unsigned tut_cevrim;   // kac cevrim tutulacak

        // Monitorun doldurdugu alanlar
        bit [31:0] odr;
        bit [ 7:0] anode;
        bit [ 7:0] catode;

        `uvm_object_utils_begin(gpio_pad_item)
            `uvm_field_int(idr,        UVM_ALL_ON | UVM_HEX)
            `uvm_field_int(odr,        UVM_ALL_ON | UVM_HEX)
            `uvm_field_int(anode,      UVM_ALL_ON | UVM_BIN)
            `uvm_field_int(catode,     UVM_ALL_ON | UVM_BIN)
            `uvm_field_int(tut_cevrim, UVM_ALL_ON | UVM_DEC)
        `uvm_object_utils_end

        constraint c_tut { tut_cevrim inside {[1:20]}; }
        constraint c_idr { idr[31:16] == 16'h0000; }   // donanimda 16 switch var

        function new(string name = "gpio_pad_item");
            super.new(name);
        endfunction
    endclass


    //---- Surucu: switch'leri surer ------------------------------------------
    class gpio_pad_driver extends uvm_driver #(gpio_pad_item);
        `uvm_component_utils(gpio_pad_driver)

        virtual gpio_pad_if vif;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual gpio_pad_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "gpio_pad_if handle bulunamadi")
        endfunction

        task run_phase(uvm_phase phase);
            vif.idr <= 32'h0;
            forever begin
                seq_item_port.get_next_item(req);
                @(negedge vif.clk);
                vif.idr <= req.idr;
                repeat (req.tut_cevrim) @(posedge vif.clk);
                seq_item_port.item_done(req);
            end
        endtask
    endclass


    //---- Monitor: yapisal kurallari kontrol eder ve yayinlar -----------------
    class gpio_pad_monitor extends uvm_monitor;
        `uvm_component_utils(gpio_pad_monitor)

        virtual gpio_pad_if                vif;
        uvm_analysis_port #(gpio_pad_item) ap;

        int unsigned n_pad01 = 0;   // anode one-cold ihlali
        int unsigned n_pad03 = 0;   // sonuk ekran ihlali
        int unsigned n_ornek = 0;

        function new(string name, uvm_component parent);
            super.new(name, parent);
            ap = new("ap", this);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual gpio_pad_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "gpio_pad_if handle bulunamadi")
        endfunction

        task run_phase(uvm_phase phase);
            gpio_pad_item it;
            bit [31:0]    idr_gec;
            bit           ilk = 1'b1;
            bit           goster_gec = 1'b0;
            bit [31:0]    odr_gec;
            bit [ 7:0]    cat_gec;

            forever begin
                @(posedge vif.clk);
                if (!vif.rst_n) begin
                    ilk = 1'b1;
                    continue;
                end

                n_ornek++;

                // PAD_01 -- anode one-cold
                if ($countones(~vif.anode) != 1) begin
                    n_pad01++;
                    if (n_pad01 <= 5)
                        `uvm_error("PAD_01", $sformatf(
                            "anode one-cold degil: %b", vif.anode))
                end

                // PAD_03 -- gosterim kosulu saglanmiyorsa ekran sonuk olmali
                if (!ilk && !goster_gec && (vif.catode !== 8'hFF)) begin
                    n_pad03++;
                    if (n_pad03 <= 5)
                        `uvm_error("PAD_03", $sformatf(
                            "gosterim kapali ama catode=%b (IDR=0x%08h ODR=0x%08h)",
                            vif.catode, idr_gec, vif.odr))
                end

                // Yalnizca DEGISIMDE yayinla. Her cevrim bir UVM nesnesi
                // tahsis etmek 5 milyon cevrimlik ekran testini
                // kullanilmaz hale getirirdi.
                if (ilk || vif.idr !== idr_gec || vif.odr !== odr_gec ||
                    vif.catode !== cat_gec) begin
                    it            = gpio_pad_item::type_id::create("pad");
                    it.idr        = vif.idr;
                    it.odr        = vif.odr;
                    it.anode      = vif.anode;
                    it.catode     = vif.catode;
                    ap.write(it);
                end

                idr_gec    = vif.idr;
                odr_gec    = vif.odr;
                cat_gec    = vif.catode;
                goster_gec = ((vif.idr == 32'd1 && vif.odr[2:0] != 3'd0) ||
                              (vif.idr == 32'd2));
                ilk        = 1'b0;
            end
        endtask

        function void report_phase(uvm_phase phase);
            `uvm_info("PAD", $sformatf(
                "GPIO pad monitoru: %0d ornek | PAD_01=%0d PAD_03=%0d",
                n_ornek, n_pad01, n_pad03), UVM_LOW)
        endfunction
    endclass


    //---- Agent --------------------------------------------------------------
    typedef uvm_sequencer #(gpio_pad_item) gpio_pad_sequencer;

    class gpio_pad_agent extends uvm_agent;
        `uvm_component_utils(gpio_pad_agent)

        gpio_pad_sequencer sqr;
        gpio_pad_driver    drv;
        gpio_pad_monitor   mon;

        uvm_analysis_port #(gpio_pad_item) ap;

        function new(string name, uvm_component parent);
            super.new(name, parent);
            ap = new("ap", this);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            mon = gpio_pad_monitor  ::type_id::create("mon", this);
            sqr = gpio_pad_sequencer::type_id::create("sqr", this);
            drv = gpio_pad_driver   ::type_id::create("drv", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            mon.ap.connect(ap);
            drv.seq_item_port.connect(sqr.seq_item_export);
        endfunction
    endclass


    //---- Switch surme dizisi ------------------------------------------------
    class gpio_switch_seq extends uvm_sequence #(gpio_pad_item);
        `uvm_object_utils(gpio_switch_seq)

        rand bit [31:0]   deger;
        rand int unsigned tut;

        constraint c { tut inside {[1:10]}; deger[31:16] == 16'h0; }

        function new(string name = "gpio_switch_seq"); super.new(name); endfunction

        task body();
            gpio_pad_item it;
            it = gpio_pad_item::type_id::create("sw");
            start_item(it);
            it.idr        = deger;
            it.tut_cevrim = tut;
            finish_item(it);
        endtask
    endclass

endpackage : gpio_pad_pkg

`endif
