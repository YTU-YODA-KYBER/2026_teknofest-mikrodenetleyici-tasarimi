//=============================================================================
//  uart_pkg.sv  --  UART seri taraf agent'i
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  Surucu : DUT'un rx hattina GERCEK baud zamanlamasiyla cerceve basar
//           (start + 8 veri LSB-once + stop)
//  Monitor: DUT'un tx hattini dinler, cerceveyi cozer ve yayinlar;
//           ayrica start/stop bit yapisini kontrol eder.
//
//  Zamanlama tamamen cpb (clock-per-bit) uzerinden yurur; DUT'un ic
//  sinyallerine bakilmaz.
//=============================================================================
`ifndef UART_PKG_SV
`define UART_PKG_SV
`timescale 1ns/1ps

package uart_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class uart_item extends uvm_sequence_item;
        rand bit [7:0] data;
        bit            cerceve_hatasi;   // monitor doldurur (stop biti dusuk)

        `uvm_object_utils_begin(uart_item)
            `uvm_field_int(data,           UVM_ALL_ON | UVM_HEX)
            `uvm_field_int(cerceve_hatasi, UVM_ALL_ON)
        `uvm_object_utils_end

        function new(string name = "uart_item");
            super.new(name);
        endfunction
    endclass


    //---- Surucu: DUT'un rx hattina cerceve basar ----------------------------
    class uart_driver extends uvm_driver #(uart_item);
        `uvm_component_utils(uart_driver)

        virtual uart_if vif;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual uart_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "uart_if handle bulunamadi")
        endfunction

        task run_phase(uvm_phase phase);
            vif.rx <= 1'b1;                 // bosta yuksek
            forever begin
                seq_item_port.get_next_item(req);
                cerceve_gonder(req.data);
                seq_item_port.item_done(req);
            end
        endtask

        task automatic cerceve_gonder(bit [7:0] d);
            int unsigned bit_suresi = vif.cpb;
            // start biti
            @(negedge vif.clk);
            vif.rx <= 1'b0;
            repeat (bit_suresi) @(posedge vif.clk);
            // 8 veri biti, LSB once
            for (int i = 0; i < 8; i++) begin
                @(negedge vif.clk);
                vif.rx <= d[i];
                repeat (bit_suresi) @(posedge vif.clk);
            end
            // stop biti (iki bit suresi bekle: alici REPORT'ta rx_sync=1 arar)
            @(negedge vif.clk);
            vif.rx <= 1'b1;
            repeat (2 * bit_suresi) @(posedge vif.clk);
        endtask
    endclass


    //---- Monitor: DUT'un tx hattini cozer ----------------------------------
    class uart_monitor extends uvm_monitor;
        `uvm_component_utils(uart_monitor)

        virtual uart_if                vif;
        uvm_analysis_port #(uart_item) ap;

        int unsigned n_cerceve = 0;
        int unsigned n_hata    = 0;

        function new(string name, uvm_component parent);
            super.new(name, parent);
            ap = new("ap", this);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual uart_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "uart_if handle bulunamadi")
        endfunction

        task run_phase(uvm_phase phase);
            uart_item    it;
            bit [7:0]    d;
            int unsigned bs;

            forever begin
                // start biti: tx'in dusen kenari
                @(negedge vif.tx);
                if (!vif.rst_n) continue;
                bs = vif.cpb;

                // start bitinin ortasina git ve dusuk oldugunu dogrula
                repeat (bs / 2) @(posedge vif.clk);
                if (vif.tx !== 1'b0) begin
                    // sahte kenar -- cerceve degil
                    continue;
                end

                // her veri bitinin ortasinda ornekle
                for (int i = 0; i < 8; i++) begin
                    repeat (bs) @(posedge vif.clk);
                    d[i] = vif.tx;
                end

                // stop biti
                repeat (bs) @(posedge vif.clk);

                it                = uart_item::type_id::create("uart_rx");
                it.data           = d;
                it.cerceve_hatasi = (vif.tx !== 1'b1);
                n_cerceve++;
                if (it.cerceve_hatasi) begin
                    n_hata++;
                    `uvm_error("UART_FRAME",
                        $sformatf("cerceve hatasi: 0x%02h icin stop biti dusuk", d))
                end
                ap.write(it);
            end
        endtask

        function void report_phase(uvm_phase phase);
            `uvm_info("UART_MON", $sformatf(
                "seri monitor: %0d cerceve cozuldu, %0d cerceve hatasi",
                n_cerceve, n_hata), UVM_LOW)
        endfunction
    endclass


    typedef uvm_sequencer #(uart_item) uart_sequencer;

    class uart_agent extends uvm_agent;
        `uvm_component_utils(uart_agent)

        uart_sequencer sqr;
        uart_driver    drv;
        uart_monitor   mon;

        uvm_analysis_port #(uart_item) ap;

        function new(string name, uvm_component parent);
            super.new(name, parent);
            ap = new("ap", this);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            mon = uart_monitor  ::type_id::create("mon", this);
            sqr = uart_sequencer::type_id::create("sqr", this);
            drv = uart_driver   ::type_id::create("drv", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            mon.ap.connect(ap);
            drv.seq_item_port.connect(sqr.seq_item_export);
        endfunction
    endclass


    //---- Dizi: bir bayt gonder ---------------------------------------------
    class uart_send_seq extends uvm_sequence #(uart_item);
        `uvm_object_utils(uart_send_seq)

        rand bit [7:0] data;

        function new(string name = "uart_send_seq"); super.new(name); endfunction

        task body();
            uart_item it;
            it = uart_item::type_id::create("s");
            start_item(it);
            it.data = data;
            finish_item(it);
        endtask
    endclass


    //=========================================================================
    //  DMA yan bandi (yalnizca UART_YZ)
    //
    //  RTL davranisi (UART_YZ_AXI4-Lite.sv, RX FSM):
    //    REPORT durumunda stop biti gorulunce, dma_enable_i 1 ise
    //        dma_data_o  <= UART_RDR
    //        dma_valid_o <= 1
    //    IDLE'a donunce dma_valid_o <= 0
    //  dma_enable_i 0 ise DMA yolu HIC tetiklenmez.
    //
    //  Bu uc port mevcut UART_YZ_tb.sv'de HIC baglanmamistir; UART_YZ'yi
    //  UART_GU'dan ayiran tek ozellik blok seviyesinde ilk kez burada
    //  dogrulanmaktadir.
    //=========================================================================
    class uart_dma_item extends uvm_sequence_item;
        bit [7:0] data;

        `uvm_object_utils_begin(uart_dma_item)
            `uvm_field_int(data, UVM_ALL_ON | UVM_HEX)
        `uvm_object_utils_end

        function new(string name = "uart_dma_item");
            super.new(name);
        endfunction
    endclass


    class uart_dma_monitor extends uvm_monitor;
        `uvm_component_utils(uart_dma_monitor)

        virtual uart_dma_if                vif;
        uvm_analysis_port #(uart_dma_item) ap;

        int unsigned n_darbe = 0;

        function new(string name, uvm_component parent);
            super.new(name, parent);
            ap = new("ap", this);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual uart_dma_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "uart_dma_if handle bulunamadi")
        endfunction

        task run_phase(uvm_phase phase);
            uart_dma_item it;
            bit           gec = 1'b0;
            forever begin
                @(posedge vif.clk);
                if (!vif.rst_n) begin gec = 1'b0; continue; end
                // valid'in yukselen kenarinda bir kez yayinla
                if (vif.valid && !gec) begin
                    it      = uart_dma_item::type_id::create("dma");
                    it.data = vif.data;
                    n_darbe++;
                    ap.write(it);
                end
                gec = vif.valid;
            end
        endtask

        function void report_phase(uvm_phase phase);
            `uvm_info("DMA_MON", $sformatf("DMA yan bandi: %0d darbe", n_darbe), UVM_LOW)
        endfunction
    endclass


    class uart_dma_agent extends uvm_agent;
        `uvm_component_utils(uart_dma_agent)

        uart_dma_monitor mon;
        uvm_analysis_port #(uart_dma_item) ap;

        function new(string name, uvm_component parent);
            super.new(name, parent);
            ap = new("ap", this);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            mon = uart_dma_monitor::type_id::create("mon", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            mon.ap.connect(ap);
        endfunction
    endclass

endpackage : uart_pkg

`endif
