//=============================================================================
//  axil_scoreboard.svh  --  Taban scoreboard (golge register dosyasi)
//
//  Monitorun paketledigi her transaction'i bir referans modele karsi kontrol
//  eder. Referans model burada YALIN bir RW register dosyasidir; her blok
//  kendi scoreboard'unda asagidaki sanal fonksiyonlari ezerek o blogun
//  yan etkilerini (FIFO tuketen okuma, HW'in kirptigi yazma, kendi kendini
//  temizleyen register, HW'in set ettigi bayrak...) tarif eder.
//
//  Ezilecek kancalar:
//    is_mapped(off)       -- ofset decode ediliyor mu
//    is_writable(off)     -- yazma golgeye islenir mi
//    wr_mask(off)         -- yazilan degerin hangi bitleri saklanir
//    checkable_read(off)  -- okunan deger tahmin edilebilir mi (HW surmuyorsa 1)
//    expected_read(off)   -- beklenen okuma degeri
//    on_write / on_read   -- bloga ozgu yan etkiler
//=============================================================================
class axil_scoreboard extends uvm_subscriber #(axil_item);
    `uvm_component_utils(axil_scoreboard)

    bit [31:0] base_addr = 32'h0000_0000;
    string     blk       = "AXIL";

    // Golge register dosyasi (ofset -> deger)
    bit [31:0] shadow [bit [31:0]];

    // Reset penceresinde kontroller KAPATILIR: reset aninda ucusta olan
    // islemlerin sonucu tanimsizdir (DUT sifirlanmis, golge dosya henuz
    // guncellenmemis olabilir). axil_base_test.reset_uygula() bu bayragi
    // kendisi indirip kaldirir.
    bit aktif = 1'b1;

    // Istatistik
    int unsigned n_wr       = 0;
    int unsigned n_rd       = 0;
    int unsigned n_check    = 0;
    int unsigned n_mismatch = 0;
    int unsigned n_badresp  = 0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    //---- Bloga gore ezilen kancalar -------------------------------------
    virtual function bit is_mapped(bit [31:0] off);       return 1'b0; endfunction
    virtual function bit is_writable(bit [31:0] off);     return 1'b0; endfunction
    virtual function bit [31:0] wr_mask(bit [31:0] off);  return 32'hFFFF_FFFF; endfunction
    virtual function bit checkable_read(bit [31:0] off);  return 1'b0; endfunction

    virtual function bit [31:0] expected_read(bit [31:0] off);
        return shadow.exists(off) ? shadow[off] : 32'h0000_0000;
    endfunction

    virtual function void on_write(bit [31:0] off, bit [31:0] data);
        if (is_writable(off)) shadow[off] = data & wr_mask(off);
    endfunction

    virtual function void on_read(bit [31:0] off, bit [31:0] data);
    endfunction

    // Reset degerlerini kur -- test reset kalktiktan sonra cagirir
    virtual function void do_reset();
        shadow.delete();
    endfunction

    //---- Ana kontrol yolu ------------------------------------------------
    virtual function void write(axil_item t);
        bit [31:0] off = t.addr - base_addr;
        bit [31:0] exp;

        if (!aktif) return;

        // Butun slave'ler yalnizca OKAY uretir; baska bir sey ihlaldir.
        if (t.resp !== 2'b00) begin
            n_badresp++;
            `uvm_error("SB_RESP", $sformatf("%s: 0x%08h icin OKAY disi cevap (resp=%0d)",
                                            blk, t.addr, t.resp))
        end

        if (t.kind == AXIL_WRITE) begin
            n_wr++;
            on_write(off, t.wdata);
        end
        else begin
            n_rd++;
            if (checkable_read(off)) begin
                exp = expected_read(off);
                n_check++;
                if (t.rdata !== exp) begin
                    n_mismatch++;
                    `uvm_error("SB_DATA",
                        $sformatf("%s ofset 0x%02h: beklenen 0x%08h, okunan 0x%08h",
                                  blk, off[7:0], exp, t.rdata))
                end
            end
            on_read(off, t.rdata);
        end
    endfunction

    virtual function void report_phase(uvm_phase phase);
        `uvm_info("SB", $sformatf(
            "%s scoreboard: yazma=%0d okuma=%0d kontrol=%0d uyusmazlik=%0d kotu_cevap=%0d",
            blk, n_wr, n_rd, n_check, n_mismatch, n_badresp), UVM_LOW)
    endfunction
endclass
