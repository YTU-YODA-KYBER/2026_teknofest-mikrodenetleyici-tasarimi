//=============================================================================
//  i2c_slave_pkg.sv  --  I2C slave agent'i (protokol seviyesinde)
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  Gercek bir I2C slave gibi davranir: START/STOP/repeated-START kosullarini
//  hattan cozer, adresini eslestirir, ACK/NACK surer, yazma verisini yakalar
//  ve okuma verisini dondurur. Hicbir yerde DUT hiyerarsisine bakmaz ve
//  zamanlama sabiti icermez -- yalnizca SCL kenarlarina bakar:
//
//    * bit ornekleme  : SCL yukselen kenari
//    * bit surme      : SCL dusen kenari
//    * START          : SCL yuksekken SDA dusuyor
//    * STOP           : SCL yuksekken SDA yukseliyor
//
//  Hata enjeksiyonu: adres fazinda ya da istenen veri baytinda NACK.
//=============================================================================
`ifndef I2C_SLAVE_PKG_SV
`define I2C_SLAVE_PKG_SV
`timescale 1ns/1ps

package i2c_slave_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //---- Slave'in gordugu tam bir transfer ---------------------------------
    class i2c_txn extends uvm_sequence_item;
        bit [6:0]  adres;
        bit        okuma;         // adres baytindaki R/W biti
        bit [7:0]  veri[$];       // yazilan (master->slave) ya da okunan baytlar
        bit        adres_nack;    // adres fazinda NACK verildi mi
        int        nack_index;    // kacinci veri baytinda NACK verildi (-1 = yok)
        bit        stop_gorundu;

        `uvm_object_utils_begin(i2c_txn)
            `uvm_field_int(adres,        UVM_ALL_ON | UVM_HEX)
            `uvm_field_int(okuma,        UVM_ALL_ON)
            `uvm_field_queue_int(veri,   UVM_ALL_ON | UVM_HEX)
            `uvm_field_int(adres_nack,   UVM_ALL_ON)
            `uvm_field_int(nack_index,   UVM_ALL_ON | UVM_DEC)
            `uvm_field_int(stop_gorundu, UVM_ALL_ON)
        `uvm_object_utils_end

        function new(string name = "i2c_txn");
            super.new(name);
            nack_index = -1;
        endfunction
    endclass


    //---- Slave yapilandirmasi ----------------------------------------------
    class i2c_slave_cfg extends uvm_object;
        `uvm_object_utils(i2c_slave_cfg)

        bit [6:0] adres = 7'h50;

        // Master okurken dondurulecek baytlar (bittiginde 0xFF doner)
        bit [7:0] okuma_verisi[$];

        // Hata enjeksiyonu
        bit       adres_nack   = 1'b0;   // adres baytina NACK ver
        int       veri_nack_at = -1;     // N. yazma veri baytina NACK ver (-1 = yok)

        function new(string name = "i2c_slave_cfg");
            super.new(name);
        endfunction
    endclass


    //---- Slave: kenar gudumlü durum makinesi -----------------------------
    //
    //  Uc paralel surec:
    //    * START/STOP dedektoru : SCL yuksekken SDA kenari
    //    * posedge SCL          : bit ornekleme (master'in surdugu veri)
    //    * negedge SCL          : bit surme    (slave'in surdugu veri/ACK)
    //
    //  Bu ayrim I2C'nin kendi kuralidir ve kritiktir: ic ice task'larla
    //  yazildiginda ACK penceresi ile ilk veri bitinin arasinda bir SCL
    //  kenari kolayca KAYAR ve okuma verisi bir bit kaymis gelir.
    typedef enum {
        P_BOSTA,      // transfer yok
        P_ADRES,      // adres bayti aliniyor
        P_ACK_SUR,    // ACK/NACK'i suracegimiz cevrimin low fazi
        P_ACK_TUT,    // ACK penceresi bitti; siradaki faza gecis
        P_WVERI,      // master veri gonderiyor (yazma)
        P_RVERI,      // slave veri gonderiyor (okuma)
        P_RACK,       // master'in ACK/NACK'ini okuyacagiz
        P_BEKLE       // NACK sonrasi: STOP bekleniyor
    } i2c_faz_e;

    class i2c_slave extends uvm_component;
        `uvm_component_utils(i2c_slave)

        virtual i2c_if               vif;
        i2c_slave_cfg                cfg;
        uvm_analysis_port #(i2c_txn) ap;

        int unsigned n_transfer = 0;
        int unsigned n_bayt     = 0;

        // Protokol durumu
        i2c_faz_e  faz     = P_BOSTA;
        bit [7:0]  sr      = 8'h0;
        int        bitc    = 0;
        bit        ack_val = 1'b0;
        bit        okuma   = 1'b0;
        int        widx    = 0;
        int        ridx    = 0;
        i2c_txn    t;

        function new(string name, uvm_component parent);
            super.new(name, parent);
            ap = new("ap", this);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "i2c_if handle bulunamadi")
            if (!uvm_config_db#(i2c_slave_cfg)::get(this, "", "cfg", cfg))
                cfg = i2c_slave_cfg::type_id::create("cfg");
        endfunction

        // Okuma verisi bittiginde 0xFF doner
        function bit [7:0] okuma_bayti(int i);
            return (i < cfg.okuma_verisi.size()) ? cfg.okuma_verisi[i] : 8'hFF;
        endfunction

        function void yayinla(bit stop);
            if (t != null) begin
                t.stop_gorundu = stop;
                n_transfer++;
                ap.write(t);
                t = null;
            end
        endfunction

        function void yeni_transfer();
            yayinla(1'b0);                     // varsa oncekini kapat
            t     = i2c_txn::type_id::create("i2c_txn");
            faz   = P_ADRES;
            sr    = 8'h0;
            bitc  = 8;
            widx  = 0;
            ridx  = 0;
            vif.sda_low = 1'b0;
        endfunction

        task run_phase(uvm_phase phase);
            vif.sda_low = 1'b0;
            fork
                start_stop_dedektoru();
                ornekle();
                sur();
            join
        endtask

        //---- START / STOP: SCL yuksekken SDA kenari -------------------------
        task automatic start_stop_dedektoru();
            forever begin
                @(vif.sda);
                if (vif.scl === 1'b1) begin
                    if (vif.sda === 1'b0) yeni_transfer();     // (repeated) START
                    else begin                                  // STOP
                        yayinla(1'b1);
                        faz         = P_BOSTA;
                        vif.sda_low = 1'b0;
                    end
                end
            end
        endtask

        //---- posedge SCL: master'in surdugu biti ornekle --------------------
        task automatic ornekle();
            forever begin
                @(posedge vif.scl);
                case (faz)
                    P_ADRES, P_WVERI: begin
                        sr   = {sr[6:0], vif.sda};
                        bitc = bitc - 1;
                        if (bitc == 0) begin
                            if (faz == P_ADRES) begin
                                t.adres = sr[7:1];
                                t.okuma = sr[0];
                                okuma   = sr[0];
                                ack_val = (sr[7:1] === cfg.adres) && !cfg.adres_nack;
                                if (!ack_val) t.adres_nack = 1'b1;
                            end
                            else begin
                                t.veri.push_back(sr);
                                n_bayt++;
                                ack_val = (cfg.veri_nack_at != widx);
                                if (!ack_val) t.nack_index = widx;
                                widx = widx + 1;
                            end
                            faz = P_ACK_SUR;
                        end
                    end

                    P_RACK: begin
                        if (~vif.sda) begin          // master ACK verdi -> devam
                            ridx = ridx + 1;
                            sr   = okuma_bayti(ridx);
                            bitc = 8;
                            faz  = P_RVERI;
                        end
                        else faz = P_BEKLE;          // master NACK -> STOP gelecek
                    end

                    default: ;
                endcase
            end
        endtask

        //---- negedge SCL: slave'in surecegi biti kur -----------------------
        task automatic sur();
            forever begin
                @(negedge vif.scl);
                case (faz)
                    P_ACK_SUR: begin
                        vif.sda_low = ack_val;       // ACK -> LOW sur, NACK -> birak
                        faz         = P_ACK_TUT;
                    end

                    P_ACK_TUT: begin
                        if (!ack_val) begin
                            vif.sda_low = 1'b0;
                            faz         = P_BEKLE;
                        end
                        else if (okuma) begin
                            // ACK penceresinden CIKAR CIKMAZ ilk veri biti
                            // surulur. Araya bir SCL kenari daha koymak
                            // okuma verisini bir bit kaydirir.
                            ridx        = 0;
                            sr          = okuma_bayti(0);
                            t.veri.push_back(sr);
                            n_bayt++;
                            vif.sda_low = ~sr[7];
                            sr          = sr << 1;
                            bitc        = 7;
                            faz         = P_RVERI;
                        end
                        else begin
                            vif.sda_low = 1'b0;
                            bitc        = 8;
                            faz         = P_WVERI;
                        end
                    end

                    P_RVERI: begin
                        if (bitc == 8) begin         // yeni bayta gecildi
                            t.veri.push_back(sr);
                            n_bayt++;
                            vif.sda_low = ~sr[7];
                            sr          = sr << 1;
                            bitc        = 7;
                        end
                        else if (bitc > 0) begin
                            vif.sda_low = ~sr[7];
                            sr          = sr << 1;
                            bitc        = bitc - 1;
                        end
                        else begin
                            vif.sda_low = 1'b0;      // master'in ACK'i icin birak
                            faz         = P_RACK;
                        end
                    end

                    default: ;
                endcase
            end
        endtask

        function void report_phase(uvm_phase phase);
            `uvm_info("I2C_SLV", $sformatf(
                "I2C slave: %0d transfer, %0d bayt", n_transfer, n_bayt), UVM_LOW)
        endfunction
    endclass

endpackage : i2c_slave_pkg

`endif
