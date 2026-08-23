//=============================================================================
//  qspi_flash_pkg.sv  --  Hafif QSPI flash responder'i
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  AMAC: QSPI master'in URETTIGI komut akisini protokol seviyesinde cozmek,
//  okuma komutlarina veri dondurmek ve yazma komutlarinin verisini yakalamak.
//
//  KAPSAM NOTU -- bu model Micron MT25QL256'nin YERINE GECMEZ. Flash
//  protokolunun tam dogrulamasi, gercek uretici modeliyle (Micron_sim_model.v)
//  XSim tarafinda yapilmistir ve o kanit yerinde durmaktadir. Buradaki model
//  Bu ortamda kosabilen, hata enjekte edilebilen ve rastgele veriyle
//  beslenebilen hafif bir karsilik olarak AXI/register/FIFO katmanini ve
//  komut uretimini dogrular.
//
//  Desteklenen komutlar:
//    0x9F RDID   JEDEC kimlik (x1)          0x06 WREN   yazma izni
//    0x05 RDSR1  durum register'i (x1)      0x04 WRDI   izni kaldir
//    0x03 READ   normal oku (x1)            0x02 PP     sayfa yaz (x1)
//    0x6B QOR    quad output read (x4)      0x32 QPP    quad sayfa yaz (x4)
//    0x3B DOR    dual output read (x2)      0x20 SSE    4 KB sektor sil
//                                           0xD8 SE     64 KB sektor sil
//=============================================================================
`ifndef QSPI_FLASH_PKG_SV
`define QSPI_FLASH_PKG_SV
`timescale 1ns/1ps

package qspi_flash_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //---- Flash'in gordugu komut --------------------------------------------
    class qspi_cmd extends uvm_sequence_item;
        bit [7:0]  komut;
        bit [23:0] adres;
        bit        adres_var;
        bit [7:0]  veri[$];      // yazilan ya da okunan baytlar

        `uvm_object_utils_begin(qspi_cmd)
            `uvm_field_int(komut,      UVM_ALL_ON | UVM_HEX)
            `uvm_field_int(adres,      UVM_ALL_ON | UVM_HEX)
            `uvm_field_int(adres_var,  UVM_ALL_ON)
            `uvm_field_queue_int(veri, UVM_ALL_ON | UVM_HEX)
        `uvm_object_utils_end

        function new(string name = "qspi_cmd");
            super.new(name);
        endfunction
    endclass


    class qspi_flash_cfg extends uvm_object;
        `uvm_object_utils(qspi_flash_cfg)

        bit [23:0]   jedec_id = 24'h20_BA_19;   // Micron MT25QL256 benzeri
        bit [7:0]    durum    = 8'h00;          // RDSR1 cevabi (bit0 = WIP)

        // Okuma komutlarindaki dummy cevrim sayisi. Master'in CCR[15:11]
        // alanina yazdigi degerle ESLESMELIDIR (asagidaki nota bakiniz).
        int unsigned dummy = 8;

        function new(string name = "qspi_flash_cfg");
            super.new(name);
        endfunction
    endclass


    class qspi_flash extends uvm_component;
        `uvm_component_utils(qspi_flash)

        virtual qspi_if                vif;
        qspi_flash_cfg                 cfg;
        uvm_analysis_port #(qspi_cmd)  ap;

        // Seyrek bellek: yalnizca yazilan/okunan adresler tutulur
        bit [7:0] bellek [bit [23:0]];

        bit          wren    = 1'b0;
        int unsigned n_komut = 0;

        // Calisma degiskenleri (IEEE 1800 13.2.2: zaman kontrolunden sonra
        // otomatik output argumana yazilamaz, bu yuzden sinif uyesi)
        bit [31:0] m_al;
        qspi_cmd   m_cmd;

        function new(string name, uvm_component parent);
            super.new(name, parent);
            ap = new("ap", this);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual qspi_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "qspi_if handle bulunamadi")
            if (!uvm_config_db#(qspi_flash_cfg)::get(this, "", "cfg", cfg))
                cfg = qspi_flash_cfg::type_id::create("cfg");
        endfunction

        function bit [7:0] bellek_oku(bit [23:0] a);
            return bellek.exists(a) ? bellek[a] : 8'hFF;   // silinmis flash 0xFF
        endfunction

        //---- Alma: yukselen SCLK kenarinda ornekle -------------------------
        task automatic al_x1(int n);
            m_al = 0;
            repeat (n) begin
                @(posedge vif.sclk);
                m_al = {m_al[30:0], vif.io0};
            end
        endtask

        task automatic al_x4(int n_bit);
            m_al = 0;
            repeat (n_bit / 4) begin
                @(posedge vif.sclk);
                m_al = {m_al[27:0], vif.io3, vif.io2, vif.io1, vif.io0};
            end
        endtask

        //---- Gonderme: dusen SCLK kenarinda sur ---------------------------
        task automatic gonder_x1(bit [7:0] b);
            for (int i = 7; i >= 0; i--) begin
                @(negedge vif.sclk);
                vif.drv_val = {2'b00, b[i], 1'b0};   // IO1 = MISO
                vif.drv_oe  = 4'b0010;
            end
        endtask

        task automatic gonder_x2(bit [7:0] b);
            for (int i = 3; i >= 0; i--) begin
                @(negedge vif.sclk);
                vif.drv_val = {2'b00, b[i*2+1], b[i*2]};
                vif.drv_oe  = 4'b0011;
            end
        endtask

        task automatic gonder_x4(bit [7:0] b);
            for (int i = 1; i >= 0; i--) begin
                @(negedge vif.sclk);
                vif.drv_val = b[i*4 +: 4];
                vif.drv_oe  = 4'b1111;
            end
        endtask

        //---- Dummy cevrimler: hat serbest --------------------------------
        //
        //  Master LOAD durumunda her DUSEN kenarda dummy_cycle'i azaltir;
        //  sifira ulastigi kenarda veri fazina gecer ve BIR SONRAKI yukselen
        //  kenarda ilk veriyi ornekler. gonder_* gorevleri kendi ilk bitini
        //  bir dusen kenar bekledikten SONRA surdugu icin burada tam N kenar
        //  beklenir; N+1 beklenirse master ilk nibble'i hat bosken ornekler
        //  ve veri bir nibble kayar.
        task automatic dummy_bekle(int n);
            vif.drv_oe = 4'b0000;
            repeat (n) @(negedge vif.sclk);
        endtask

        //---- Ana dongu -----------------------------------------------------
        task run_phase(uvm_phase phase);
            vif.drv_oe  = 4'b0000;
            vif.drv_val = 4'b0000;
            forever begin
                @(negedge vif.cs);
                fork
                    komut_isle();
                    @(posedge vif.cs);
                join_any
                disable fork;
                vif.drv_oe = 4'b0000;
                if (m_cmd != null) begin
                    n_komut++;
                    ap.write(m_cmd);
                    m_cmd = null;
                end
            end
        endtask

        task automatic komut_isle();
            bit [7:0]  cmd;
            bit [23:0] adr;

            m_cmd = qspi_cmd::type_id::create("qspi_cmd");

            al_x1(8);
            cmd         = m_al[7:0];
            m_cmd.komut = cmd;

            case (cmd)
                8'h9F: begin                                   // RDID
                    gonder_x1(cfg.jedec_id[23:16]); m_cmd.veri.push_back(cfg.jedec_id[23:16]);
                    gonder_x1(cfg.jedec_id[15: 8]); m_cmd.veri.push_back(cfg.jedec_id[15: 8]);
                    gonder_x1(cfg.jedec_id[ 7: 0]); m_cmd.veri.push_back(cfg.jedec_id[ 7: 0]);
                    forever gonder_x1(8'hFF);
                end

                8'h05: begin                                   // RDSR1
                    forever begin
                        gonder_x1(cfg.durum);
                        m_cmd.veri.push_back(cfg.durum);
                    end
                end

                8'h06: wren = 1'b1;                            // WREN
                8'h04: wren = 1'b0;                            // WRDI

                8'h03: begin                                   // READ (x1)
                    al_x1(24); adr = m_al[23:0];
                    m_cmd.adres = adr; m_cmd.adres_var = 1'b1;
                    forever begin
                        gonder_x1(bellek_oku(adr));
                        m_cmd.veri.push_back(bellek_oku(adr));
                        adr = adr + 1;
                    end
                end

                8'h3B: begin                                   // DOR (x2)
                    al_x1(24); adr = m_al[23:0];
                    m_cmd.adres = adr; m_cmd.adres_var = 1'b1;
                    dummy_bekle(cfg.dummy);
                    forever begin
                        gonder_x2(bellek_oku(adr));
                        m_cmd.veri.push_back(bellek_oku(adr));
                        adr = adr + 1;
                    end
                end

                8'h6B: begin                                   // QOR (x4)
                    al_x1(24); adr = m_al[23:0];
                    m_cmd.adres = adr; m_cmd.adres_var = 1'b1;
                    dummy_bekle(cfg.dummy);
                    forever begin
                        gonder_x4(bellek_oku(adr));
                        m_cmd.veri.push_back(bellek_oku(adr));
                        adr = adr + 1;
                    end
                end

                8'h02: begin                                   // PP (x1)
                    al_x1(24); adr = m_al[23:0];
                    m_cmd.adres = adr; m_cmd.adres_var = 1'b1;
                    forever begin
                        al_x1(8);
                        bellek[adr] = m_al[7:0];
                        m_cmd.veri.push_back(m_al[7:0]);
                        adr = adr + 1;
                    end
                end

                8'h32: begin                                   // QPP (x4)
                    al_x1(24); adr = m_al[23:0];
                    m_cmd.adres = adr; m_cmd.adres_var = 1'b1;
                    forever begin
                        al_x4(8);
                        bellek[adr] = m_al[7:0];
                        m_cmd.veri.push_back(m_al[7:0]);
                        adr = adr + 1;
                    end
                end

                8'h20, 8'hD8: begin                            // SSE / SE
                    int unsigned boy;
                    bit [23:0]   taban;
                    boy = (cmd == 8'h20) ? 4096 : 65536;
                    al_x1(24); adr = m_al[23:0];
                    m_cmd.adres = adr; m_cmd.adres_var = 1'b1;
                    taban = adr & ~bit'(24'(boy - 1));
                    // Silinen bolgedeki kayitlari sil -> geri okuma 0xFF verir
                    for (int unsigned i = 0; i < boy; i++)
                        bellek.delete(taban + i[23:0]);
                end

                default: ;   // desteklenmeyen komut: sessizce yut
            endcase
        endtask

        function void report_phase(uvm_phase phase);
            `uvm_info("QSPI_FLASH", $sformatf(
                "QSPI flash: %0d komut isledi, bellekte %0d bayt",
                n_komut, bellek.size()), UVM_LOW)
        endfunction
    endclass

endpackage : qspi_flash_pkg

`endif
