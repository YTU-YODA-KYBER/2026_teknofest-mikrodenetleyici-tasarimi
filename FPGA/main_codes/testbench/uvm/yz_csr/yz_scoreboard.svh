//=============================================================================
//  yz_scoreboard.svh  --  YZ CSR referans modeli
//
//  Register'larin hepsi donanim tarafindan surulur ya da saklanmaz; bu yuzden
//  golge register dosyasiyla kontrol edilebilecek bir sey YOKTUR. Kontrol
//  yz_csr_test icinde, hizlandirici arayuzunun surulen degerleriyle
//  STATUS/RESULT okumalari karsilastirilarak yapilir.
//
//  Scoreboard burada iki isi surdurur:
//    1) cevap kodunun daima OKAY olmasi (taban siniftan gelir)
//    2) haritasiz ofsetlerin 0 dondurmesi -- bu blokta okuma case'inde
//       DEFAULT VARDIR, dolayisiyla GPIO/UART'taki bayat-rdata davranisi
//       burada olusmamalidir.
//=============================================================================
class yz_scoreboard extends axil_scoreboard;
    `uvm_component_utils(yz_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function bit is_mapped(bit [31:0] off);
        //  0x00 CTRL, 0x04 STATUS, 0x08 RESULT, 0x10..0x1C SCORE0..3
        return (off[7:0] inside {8'h00, 8'h04, 8'h08,
                                 8'h10, 8'h14, 8'h18, 8'h1C});
    endfunction

    virtual function bit is_writable(bit [31:0] off);
        return 1'b0;   // YZ_CTRL saklanmaz, digerleri salt okunur
    endfunction

    // Haritasiz ofsetler daima 0 donmelidir (RTL'de default var)
    virtual function bit checkable_read(bit [31:0] off);
        return !is_mapped(off);
    endfunction

    virtual function bit [31:0] expected_read(bit [31:0] off);
        return 32'h0000_0000;
    endfunction
endclass
