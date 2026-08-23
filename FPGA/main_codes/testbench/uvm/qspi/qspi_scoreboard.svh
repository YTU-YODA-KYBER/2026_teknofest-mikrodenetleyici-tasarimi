//=============================================================================
//  qspi_scoreboard.svh  --  QSPI referans modeli
//
//  QSPI'nin cogu register'i yan etkilidir; golge dosyayla kontrol edilebilen
//  tek register QSPI_ADR'dir. Digerlerinin dogrulanmasi directed testlerde
//  (FIFO bayraklari, hata kodlari, flush, DMA, flash komutlari) yapilir.
//
//    0x00 QSPI_CCR : yazmak TRANSFER BASLATIR; geri okuma yazilan degeri verir
//                    ama CCR[31]=1 yazildiginda donanim CCR[31]'i temizler
//    0x08 QSPI_DR  : okuma YIKICIDIR (RX FIFO'dan ceker) -> modellenmez
//    0x0C QSPI_STA : donanim surer
//    0x10 QSPI_FCR : bir cevrim sonra kendini sifirlar
//    0x14 QSPI_DMA : okuma dma_valid dondurur, yazma dma_start darbesidir
//
//  Okuma case'inde DEFAULT VARDIR -> haritasiz ofset 0 dondurur.
//=============================================================================
class qspi_scoreboard extends axil_scoreboard;
    `uvm_component_utils(qspi_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function bit is_mapped(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h08, 8'h0C, 8'h10, 8'h14});
    endfunction

    virtual function bit is_writable(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h08, 8'h10, 8'h14});
    endfunction

    virtual function bit checkable_read(bit [31:0] off);
        if (!is_mapped(off)) return 1'b1;          // haritasiz -> 0 beklenir
        return (off[7:0] == 8'h04);                // yalnizca QSPI_ADR
    endfunction

    virtual function void on_write(bit [31:0] off, bit [31:0] data);
        if (off[7:0] == 8'h04) shadow[8'h04] = data;
    endfunction

    virtual function bit [31:0] expected_read(bit [31:0] off);
        if (!is_mapped(off)) return 32'h0;
        return shadow.exists(off[7:0]) ? shadow[off[7:0]] : 32'h0;
    endfunction

    virtual function void do_reset();
        super.do_reset();
        shadow[8'h04] = 32'h0;
    endfunction
endclass
