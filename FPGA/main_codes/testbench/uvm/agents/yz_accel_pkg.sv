//=============================================================================
//  yz_accel_pkg.sv  --  YZ hizlandirici taraf agent'i
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  Surucu : hizlandiricinin urettigi sinyalleri taklit eder
//           (busy seviyesi, done darbesi, sonuc yazma darbesi, load irq)
//  Monitor: CSR'nin urettigi darbeleri izler ve GENISLIKLERINI kontrol eder.
//
//  Kontrol edilen yapisal kural (RTL'den cikarildi):
//    YZ_01  acc_start ve load_clear TAM 1 CEVRIM genisliginde olmalidir.
//           yz_csr_wrapper bunlari her cevrim 0'a cekerek uretir
//           (acc_start <= 0; load_clear <= 0; sonra kosullu 1). Bir darbenin
//           iki cevrim surmesi hizlandiriciyi iki kez tetiklerdi.
//=============================================================================
`ifndef YZ_ACCEL_PKG_SV
`define YZ_ACCEL_PKG_SV
`timescale 1ns/1ps

package yz_accel_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    typedef enum { YZ_SET_BUSY, YZ_PULSE_DONE, YZ_WRITE_RESULT,
                   YZ_SET_LOAD_IRQ, YZ_BEKLE } yz_op_e;

    class yz_accel_item extends uvm_sequence_item;
        rand yz_op_e      op;
        rand bit [7:0]    deger;
        //  YZ_WRITE_RESULT ile birlikte surulen ham FC skorlari: {S3,S2,S1,S0}
        rand bit [127:0]  skorlar;
        rand int unsigned cevrim;

        `uvm_object_utils_begin(yz_accel_item)
            `uvm_field_enum(yz_op_e, op, UVM_ALL_ON)
            `uvm_field_int(deger,   UVM_ALL_ON | UVM_HEX)
            `uvm_field_int(skorlar, UVM_ALL_ON | UVM_HEX)
            `uvm_field_int(cevrim,  UVM_ALL_ON | UVM_DEC)
        `uvm_object_utils_end

        constraint c { cevrim inside {[1:20]}; }

        function new(string name = "yz_accel_item");
            super.new(name);
        endfunction
    endclass


    class yz_accel_driver extends uvm_driver #(yz_accel_item);
        `uvm_component_utils(yz_accel_driver)

        virtual yz_accel_if vif;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual yz_accel_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "yz_accel_if handle bulunamadi")
        endfunction

        task run_phase(uvm_phase phase);
            vif.acc_busy      <= 1'b0;
            vif.acc_done      <= 1'b0;
            vif.acc_out_wen   <= 1'b0;
            vif.acc_out_wdata <= 8'h0;
            vif.acc_fc_scores <= 128'h0;
            vif.load_done_irq <= 1'b0;

            forever begin
                seq_item_port.get_next_item(req);
                case (req.op)
                    YZ_SET_BUSY: begin
                        @(negedge vif.clk);
                        vif.acc_busy <= req.deger[0];
                        repeat (2) @(posedge vif.clk);
                    end
                    YZ_PULSE_DONE: begin
                        @(negedge vif.clk);
                        vif.acc_done <= 1'b1;
                        @(posedge vif.clk);
                        @(negedge vif.clk);
                        vif.acc_done <= 1'b0;
                        repeat (2) @(posedge vif.clk);
                    end
                    YZ_WRITE_RESULT: begin
                        @(negedge vif.clk);
                        vif.acc_out_wdata <= req.deger;
                        vif.acc_fc_scores <= req.skorlar;
                        vif.acc_out_wen   <= 1'b1;
                        @(posedge vif.clk);
                        @(negedge vif.clk);
                        vif.acc_out_wen   <= 1'b0;
                        repeat (2) @(posedge vif.clk);
                    end
                    YZ_SET_LOAD_IRQ: begin
                        @(negedge vif.clk);
                        vif.load_done_irq <= req.deger[0];
                        repeat (2) @(posedge vif.clk);
                    end
                    YZ_BEKLE: begin
                        repeat (req.cevrim) @(posedge vif.clk);
                    end
                endcase
                seq_item_port.item_done(req);
            end
        endtask
    endclass


    class yz_accel_monitor extends uvm_monitor;
        `uvm_component_utils(yz_accel_monitor)

        virtual yz_accel_if vif;

        int unsigned n_start      = 0;   // acc_start darbesi
        int unsigned n_load_clear = 0;   // load_clear darbesi
        int unsigned n_genislik   = 0;   // YZ_01 ihlali

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual yz_accel_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "yz_accel_if handle bulunamadi")
        endfunction

        task run_phase(uvm_phase phase);
            bit start_gec = 1'b0;
            bit clear_gec = 1'b0;
            forever begin
                @(posedge vif.clk);
                if (!vif.rst_n) begin
                    start_gec = 1'b0;
                    clear_gec = 1'b0;
                    continue;
                end

                // YZ_01 -- darbeler TAM 1 cevrim olmali
                if (vif.acc_start && start_gec) begin
                    n_genislik++;
                    `uvm_error("YZ_01", "acc_start darbesi 1 cevrimden uzun")
                end
                if (vif.load_clear && clear_gec) begin
                    n_genislik++;
                    `uvm_error("YZ_01", "load_clear darbesi 1 cevrimden uzun")
                end

                if (vif.acc_start  && !start_gec) n_start++;
                if (vif.load_clear && !clear_gec) n_load_clear++;

                start_gec = vif.acc_start;
                clear_gec = vif.load_clear;
            end
        endtask

        function void report_phase(uvm_phase phase);
            `uvm_info("YZ_MON", $sformatf(
                "hizlandirici arayuzu: acc_start=%0d load_clear=%0d darbe, %0d genislik ihlali",
                n_start, n_load_clear, n_genislik), UVM_LOW)
        endfunction
    endclass


    typedef uvm_sequencer #(yz_accel_item) yz_accel_sequencer;

    class yz_accel_agent extends uvm_agent;
        `uvm_component_utils(yz_accel_agent)

        yz_accel_sequencer sqr;
        yz_accel_driver    drv;
        yz_accel_monitor   mon;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            mon = yz_accel_monitor  ::type_id::create("mon", this);
            sqr = yz_accel_sequencer::type_id::create("sqr", this);
            drv = yz_accel_driver   ::type_id::create("drv", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            drv.seq_item_port.connect(sqr.seq_item_export);
        endfunction
    endclass


    class yz_accel_seq extends uvm_sequence #(yz_accel_item);
        `uvm_object_utils(yz_accel_seq)

        rand yz_op_e      op;
        rand bit [7:0]    deger;
        rand bit [127:0]  skorlar;
        rand int unsigned cevrim;

        function new(string name = "yz_accel_seq"); super.new(name); endfunction

        task body();
            yz_accel_item it;
            it = yz_accel_item::type_id::create("it");
            start_item(it);
            it.op      = op;
            it.deger   = deger;
            it.skorlar = skorlar;
            it.cevrim  = cevrim;
            finish_item(it);
        endtask
    endclass

endpackage : yz_accel_pkg

`endif
