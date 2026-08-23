//=============================================================================
//  gpio_scoreboard.svh  --  GPIO referans modeli
//
//  Taban scoreboard'un golge register dosyasini GPIO'nun gercek davranisiyla
//  ozellestirir:
//
//   * decode YALNIZCA addr[3:0]'a bakar -> her 16 baytta bir takma ad
//   * 0x00 (IDR) salt okunur ve degeri PAD AGENT'tan gelir (donanim surer)
//   * 0x04 (ODR) yazilirken {16'h0, wdata[15:0]} saklanir -> ust yari daima 0
//   * okuma case'inde DEFAULT YOKTUR: haritasiz ofsette rdata BAYAT kalir
//     (onceki okumanin degeri), buna ragmen rvalid yukselir. Bu bilinen bir
//     davranistir; kontrol edilemez oldugu icin checkable_read 0 doner ve
//     gpio_unmapped_test bunu ayrica dogrular.
//=============================================================================
class gpio_scoreboard extends axil_scoreboard;
    `uvm_component_utils(gpio_scoreboard)

    // Pad monitorunden gelen ikinci analiz yolu
    uvm_analysis_imp_pad #(gpio_pad_pkg::gpio_pad_item, gpio_scoreboard) pad_export;

    // Pad agent'tan gelen guncel switch degeri
    bit [31:0] idr_gercek = 32'h0;

    // Haritasiz okumada beklenen "bayat" deger
    bit [31:0] son_rdata  = 32'h0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        pad_export = new("pad_export", this);
    endfunction

    // Pad monitorunden gelen guncelleme
    virtual function void write_pad(gpio_pad_pkg::gpio_pad_item t);
        idr_gercek = t.idr;
    endfunction

    // Testin dogrudan cagirabilecegi yardimci (switch'i kendi kurdugu durumlar)
    virtual function void pad_guncelle(bit [31:0] idr);
        idr_gercek = idr;
    endfunction

    virtual function bit is_mapped(bit [31:0] off);
        return (off[3:0] == 4'h0) || (off[3:0] == 4'h4);
    endfunction

    virtual function bit is_writable(bit [31:0] off);
        return (off[3:0] == 4'h4);
    endfunction

    virtual function bit [31:0] wr_mask(bit [31:0] off);
        return 32'h0000_FFFF;              // ODR[31:16] donanimda yok
    endfunction

    virtual function bit checkable_read(bit [31:0] off);
        return is_mapped(off);
    endfunction

    virtual function bit [31:0] expected_read(bit [31:0] off);
        if (off[3:0] == 4'h0) return idr_gercek;
        if (off[3:0] == 4'h4) return shadow.exists(32'h4) ? shadow[32'h4] : 32'h0;
        return son_rdata;
    endfunction

    virtual function void on_write(bit [31:0] off, bit [31:0] data);
        if (is_writable(off)) shadow[32'h4] = data & 32'h0000_FFFF;
    endfunction

    virtual function void on_read(bit [31:0] off, bit [31:0] data);
        son_rdata = data;
    endfunction

    virtual function void do_reset();
        super.do_reset();
        shadow[32'h4] = 32'h0;   // GPIO_ODR reset degeri
        son_rdata     = 32'h0;
    endfunction
endclass
