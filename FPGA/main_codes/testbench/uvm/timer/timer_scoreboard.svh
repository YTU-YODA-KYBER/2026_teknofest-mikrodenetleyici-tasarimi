//=============================================================================
//  timer_scoreboard.svh  --  Timer referans modeli
//
//  Register semantigi kontrol edilir; sayma davranisi timer_count_test
//  icinde dogrulanir (sayac degeri saat-dogru modellenmez, cunku scoreboard
//  saati gormez -- okunan degerin MANTIKLI olup olmadigi testte bakilir).
//
//  Yan etkiler:
//    0x08 TIM_CLR : bit0 = 1 yazilirsa donanim registeri TAMAMEN sifirlar
//    0x1C TIM_EVC : ayni sekilde
//    0x14 / 0x18  : salt okunur ve donanim surer -> tahmin edilemez
//    0x00 TIM_PRE : yazma TIM_PRE_m'ye gider, okuma da ondan gelir
//=============================================================================
class timer_scoreboard extends axil_scoreboard;
    `uvm_component_utils(timer_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function bit is_mapped(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h08, 8'h0C,
                                 8'h10, 8'h14, 8'h18, 8'h1C});
    endfunction

    virtual function bit is_writable(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h08, 8'h0C, 8'h10, 8'h1C});
    endfunction

    // TIM_CNT ve TIM_EVN donanim surer -> tahmin edilemez.
    // TIM_CLR / TIM_EVC kontrol edilebilir cunku bit0 kurali kesindir.
    virtual function bit checkable_read(bit [31:0] off);
        return (off[7:0] inside {8'h00, 8'h04, 8'h08, 8'h0C, 8'h10, 8'h1C});
    endfunction

    virtual function void on_write(bit [31:0] off, bit [31:0] data);
        bit [7:0] o = off[7:0];
        case (o)
            8'h08, 8'h1C: shadow[o] = data[0] ? 32'h0 : data;  // olay register'i
            8'h00, 8'h04, 8'h0C, 8'h10: shadow[o] = data;
            default: ;   // 0x14 / 0x18 salt okunur, yazma dusurulur
        endcase
    endfunction

    virtual function bit [31:0] expected_read(bit [31:0] off);
        bit [7:0] o = off[7:0];
        return shadow.exists(o) ? shadow[o] : 32'h0;
    endfunction

    virtual function void do_reset();
        super.do_reset();
        shadow[8'h00] = 32'h0;
        shadow[8'h04] = 32'h0;
        shadow[8'h08] = 32'h0;
        shadow[8'h0C] = 32'h0;
        shadow[8'h10] = 32'h0;
        shadow[8'h1C] = 32'h0;
    endfunction
endclass
