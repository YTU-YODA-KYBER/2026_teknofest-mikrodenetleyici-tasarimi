//=============================================================================
//  uart_scoreboard.svh  --  UART referans modeli
//
//  Kontrol edilebilenler:
//    0x00 UART_CPB : 32-bit tam saklanir
//    0x04 UART_STP : yalniz [1:0]
//    0x0C UART_TDR : yalniz [7:0]
//
//  Kontrol EDILEMEYENLER (donanim suruyor):
//    0x08 UART_RDR : alinan bayt
//    0x10 UART_CFG : TX/RX FSM'leri bitleri set/clear ediyor
//
//  Okuma case'inde DEFAULT yoktur -> haritasiz ofsette rdata BAYAT kalir
//  (GPIO ile ayni davranis). uart_unmapped_test bunu ayrica dogrular.
//=============================================================================
class uart_scoreboard extends axil_scoreboard;
    `uvm_component_utils(uart_scoreboard)

    bit [31:0] son_rdata = 32'h0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function bit is_mapped(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h08, 8'h0C, 8'h10});
    endfunction

    virtual function bit is_writable(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h0C, 8'h10});
    endfunction

    virtual function bit [31:0] wr_mask(bit [31:0] off);
        case (off[7:0])
            8'h04:   return 32'h0000_0003;   // UART_STP [1:0]
            8'h0C:   return 32'h0000_00FF;   // UART_TDR [7:0]
            8'h10:   return 32'h0000_0007;   // UART_CFG [2:0]
            default: return 32'hFFFF_FFFF;
        endcase
    endfunction

    virtual function bit checkable_read(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h0C});
    endfunction

    virtual function void on_write(bit [31:0] off, bit [31:0] data);
        if (is_writable(off)) shadow[off[7:0]] = data & wr_mask(off);
    endfunction

    virtual function bit [31:0] expected_read(bit [31:0] off);
        return shadow.exists(off[7:0]) ? shadow[off[7:0]] : 32'h0;
    endfunction

    virtual function void on_read(bit [31:0] off, bit [31:0] data);
        son_rdata = data;
    endfunction

    virtual function void do_reset();
        super.do_reset();
        shadow[8'h00] = 32'h0;
        shadow[8'h04] = 32'h0;
        shadow[8'h0C] = 32'h0;
        shadow[8'h10] = 32'h0;
        son_rdata     = 32'h0;
    endfunction
endclass
