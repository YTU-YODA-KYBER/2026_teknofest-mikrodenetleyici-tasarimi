//=============================================================================
//  i2c_scoreboard.svh  --  I2C referans modeli
//
//  Yan etkiler:
//    0x00 I2C_NBY : DONANIM KIRPAR  (>4 -> 4, 0 -> 1)
//    0x08 I2C_RDR : donanim surer -> tahmin edilemez
//    0x10 I2C_CFG : TX/RX FSM'i bitleri set/clear ediyor -> tahmin edilemez
//    0x14 I2C_CLR : yazilir ama saklanmaz; okuma decode edilmez -> 0 doner
//
//  Okuma case'inde DEFAULT VARDIR, bu yuzden haritasiz ofset 0 dondurur
//  (GPIO/UART'taki bayat-rdata davranisi burada YOK).
//=============================================================================
class i2c_scoreboard extends axil_scoreboard;
    `uvm_component_utils(i2c_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function bit is_mapped(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h08, 8'h0C, 8'h10, 8'h14});
    endfunction

    virtual function bit is_writable(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h0C, 8'h10});
    endfunction

    // 0x00 kirpma kuralindan tahmin edilebilir; 0x14 daima 0 doner;
    // haritasiz ofsetler de daima 0 doner.
    virtual function bit checkable_read(bit [31:0] off);
        if (off[7:0] inside {8'h08, 8'h10}) return 1'b0;   // donanim suruyor
        return 1'b1;
    endfunction

    virtual function void on_write(bit [31:0] off, bit [31:0] data);
        case (off[7:0])
            8'h00: begin
                // RTL: if (wdata > 4) 4; else if (!wdata) 1; else wdata
                if      (data > 32'd4) shadow[8'h00] = 32'd4;
                else if (data == 32'd0) shadow[8'h00] = 32'd1;
                else                    shadow[8'h00] = data;
            end
            8'h04: shadow[8'h04] = data;
            8'h0C: shadow[8'h0C] = data;
            8'h10: ;   // CFG donanim tarafindan da degistirilir -> modellenmez
            default: ;
        endcase
    endfunction

    virtual function bit [31:0] expected_read(bit [31:0] off);
        if (!is_mapped(off)) return 32'h0;         // RTL'de default var
        if (off[7:0] == 8'h14) return 32'h0;       // I2C_CLR okuma decode edilmez
        return shadow.exists(off[7:0]) ? shadow[off[7:0]] : 32'h0;
    endfunction

    virtual function void do_reset();
        super.do_reset();
        shadow[8'h00] = 32'h0;
        shadow[8'h04] = 32'h0;
        shadow[8'h0C] = 32'h0;
    endfunction
endclass
