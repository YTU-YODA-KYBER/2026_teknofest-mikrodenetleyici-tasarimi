//=============================================================================
//  timer_reg_block.svh  --  Timer register modeli  (taban 0x4000_0000)
//
//  Kaynak: firmware/soc.h
//
//  | Ofset | Ad      | Erisim | Not                                          |
//  |-------|---------|--------|----------------------------------------------|
//  | 0x00  | TIM_PRE | RW     | yazma TIM_PRE_m aynasina gider, okuma da     |
//  |       |         |        | ondan gelir. Calisan sayac TIM_PRE OKUNAMAZ. |
//  | 0x04  | TIM_ARE | RW     | otomatik yeniden yukleme siniri              |
//  | 0x08  | TIM_CLR | RW     | bit0 = 1 yazilirsa DONANIM registeri sifirlar|
//  | 0x0C  | TIM_ENA | RW     | bit0 = say / dur                             |
//  | 0x10  | TIM_MOD | RW     | bit0 = 1 yukari, 0 asagi                     |
//  | 0x14  | TIM_CNT | RO     | donanim surer -> volatile                    |
//  | 0x18  | TIM_EVN | RO     | donanim surer -> volatile                    |
//  | 0x1C  | TIM_EVC | RW     | bit0 = 1 yazilirsa DONANIM registeri sifirlar|
//
//  TIM_CLR ve TIM_EVC "olay" register'laridir: bit0 = 1 yazildiginda donanim
//  islemi yapar ve REGISTERIN TAMAMINI sifirlar. bit0 = 0 yazilirsa deger
//  oldugu gibi kalir. Bu yuzden ikisi de volatile isaretlenir ve hazir
//  uvm_reg_bit_bash_seq disinda tutulur.
//=============================================================================

class timer_reg_rw extends uvm_reg;
    `uvm_object_utils(timer_reg_rw)
    rand uvm_reg_field VALUE;
    function new(string name = "TIMER_RW");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
    endfunction
endclass

class timer_reg_ro extends uvm_reg;
    `uvm_object_utils(timer_reg_ro)
    uvm_reg_field VALUE;
    function new(string name = "TIMER_RO");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RO", 1, 32'h0, 1, 0, 1);
    endfunction
endclass

// Olay register'i: bit0 = 1 yazilinca donanim tumunu sifirlar
class timer_reg_evt extends uvm_reg;
    `uvm_object_utils(timer_reg_evt)
    rand uvm_reg_field VALUE;
    function new(string name = "TIMER_EVT");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RW", 1, 32'h0, 1, 1, 1);   // volatile
    endfunction
endclass


class timer_reg_block extends uvm_reg_block;
    `uvm_object_utils(timer_reg_block)

    rand timer_reg_rw  TIM_PRE;
    rand timer_reg_rw  TIM_ARE;
    rand timer_reg_evt TIM_CLR;
    rand timer_reg_rw  TIM_ENA;
    rand timer_reg_rw  TIM_MOD;
    timer_reg_ro       TIM_CNT;
    timer_reg_ro       TIM_EVN;
    rand timer_reg_evt TIM_EVC;

    function new(string name = "timer_reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);

        TIM_PRE = timer_reg_rw ::type_id::create("TIM_PRE");
        TIM_ARE = timer_reg_rw ::type_id::create("TIM_ARE");
        TIM_CLR = timer_reg_evt::type_id::create("TIM_CLR");
        TIM_ENA = timer_reg_rw ::type_id::create("TIM_ENA");
        TIM_MOD = timer_reg_rw ::type_id::create("TIM_MOD");
        TIM_CNT = timer_reg_ro ::type_id::create("TIM_CNT");
        TIM_EVN = timer_reg_ro ::type_id::create("TIM_EVN");
        TIM_EVC = timer_reg_evt::type_id::create("TIM_EVC");

        TIM_PRE.configure(this, null, ""); TIM_PRE.build();
        TIM_ARE.configure(this, null, ""); TIM_ARE.build();
        TIM_CLR.configure(this, null, ""); TIM_CLR.build();
        TIM_ENA.configure(this, null, ""); TIM_ENA.build();
        TIM_MOD.configure(this, null, ""); TIM_MOD.build();
        TIM_CNT.configure(this, null, ""); TIM_CNT.build();
        TIM_EVN.configure(this, null, ""); TIM_EVN.build();
        TIM_EVC.configure(this, null, ""); TIM_EVC.build();

        default_map.add_reg(TIM_PRE, 32'h00, "RW");
        default_map.add_reg(TIM_ARE, 32'h04, "RW");
        default_map.add_reg(TIM_CLR, 32'h08, "RW");
        default_map.add_reg(TIM_ENA, 32'h0C, "RW");
        default_map.add_reg(TIM_MOD, 32'h10, "RW");
        default_map.add_reg(TIM_CNT, 32'h14, "RO");
        default_map.add_reg(TIM_EVN, 32'h18, "RO");
        default_map.add_reg(TIM_EVC, 32'h1C, "RW");

        lock_model();
    endfunction
endclass
