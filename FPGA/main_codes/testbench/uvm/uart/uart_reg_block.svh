//=============================================================================
//  uart_reg_block.svh  --  UART register modeli
//
//  UART_GU (0x4004_0000) ve UART_YZ (0x4005_0000) register bazinda
//  BIREBIR AYNIDIR; ayni model ikisinde de kullanilir. Tek fark UART_YZ'nin
//  DMA yan bandidir, o da register haritasinda yer almaz.
//
//  Kaynak: firmware/soc.h
//
//  | Ofset | Ad       | Erisim | Not                                        |
//  |-------|----------|--------|--------------------------------------------|
//  | 0x00  | UART_CPB | RW     | 32-bit; YAN ETKI: cnt_limit_mirror <=      |
//  |       |          |        | wdata[19:4] (RX 16x asiri ornekleme siniri)|
//  | 0x04  | UART_STP | RW     | yalniz [1:0] saklanir                      |
//  | 0x08  | UART_RDR | RO     | alinan bayt; donanim surer -> volatile     |
//  | 0x0C  | UART_TDR | RW     | yalniz [7:0] saklanir                      |
//  | 0x10  | UART_CFG | RW     | [0] TXSTART (HW temizler), [1] RXREADY     |
//  |       |          |        | (HW set eder), [2] TXDONE (HW set eder)    |
//=============================================================================

class uart_reg_cpb extends uvm_reg;
    `uvm_object_utils(uart_reg_cpb)
    rand uvm_reg_field VALUE;
    function new(string name = "UART_CPB");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
    endfunction
endclass

class uart_reg_stp extends uvm_reg;
    `uvm_object_utils(uart_reg_stp)
    rand uvm_reg_field VALUE;   // [1:0]
    uvm_reg_field      RSVD;    // [31:2] donanimda yok
    function new(string name = "UART_STP");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        RSVD  = uvm_reg_field::type_id::create("RSVD");
        VALUE.configure(this,  2, 0, "RW", 0, 2'h0,  1, 1, 1);
        RSVD .configure(this, 30, 2, "RO", 0, 30'h0, 1, 0, 1);
    endfunction
endclass

class uart_reg_rdr extends uvm_reg;
    `uvm_object_utils(uart_reg_rdr)
    uvm_reg_field VALUE;
    function new(string name = "UART_RDR");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RO", 1, 32'h0, 1, 0, 1);
    endfunction
endclass

class uart_reg_tdr extends uvm_reg;
    `uvm_object_utils(uart_reg_tdr)
    rand uvm_reg_field VALUE;   // [7:0]
    uvm_reg_field      RSVD;
    function new(string name = "UART_TDR");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        RSVD  = uvm_reg_field::type_id::create("RSVD");
        VALUE.configure(this,  8, 0, "RW", 0, 8'h0,  1, 1, 1);
        RSVD .configure(this, 24, 8, "RO", 0, 24'h0, 1, 0, 1);
    endfunction
endclass

class uart_reg_cfg extends uvm_reg;
    `uvm_object_utils(uart_reg_cfg)
    rand uvm_reg_field TXSTART;   // [0]
    rand uvm_reg_field RXREADY;   // [1]
    rand uvm_reg_field TXDONE;    // [2]
    uvm_reg_field      RSVD;
    function new(string name = "UART_CFG");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        TXSTART = uvm_reg_field::type_id::create("TXSTART");
        RXREADY = uvm_reg_field::type_id::create("RXREADY");
        TXDONE  = uvm_reg_field::type_id::create("TXDONE");
        RSVD    = uvm_reg_field::type_id::create("RSVD");
        // Ucu de donanim tarafindan degistirilir -> volatile
        TXSTART.configure(this,  1, 0, "RW", 1, 1'h0,  1, 1, 1);
        RXREADY.configure(this,  1, 1, "RW", 1, 1'h0,  1, 1, 1);
        TXDONE .configure(this,  1, 2, "RW", 1, 1'h0,  1, 1, 1);
        RSVD   .configure(this, 29, 3, "RO", 0, 29'h0, 1, 0, 1);
    endfunction
endclass


class uart_reg_block extends uvm_reg_block;
    `uvm_object_utils(uart_reg_block)

    rand uart_reg_cpb UART_CPB;
    rand uart_reg_stp UART_STP;
    uart_reg_rdr      UART_RDR;
    rand uart_reg_tdr UART_TDR;
    rand uart_reg_cfg UART_CFG;

    function new(string name = "uart_reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);

        UART_CPB = uart_reg_cpb::type_id::create("UART_CPB");
        UART_STP = uart_reg_stp::type_id::create("UART_STP");
        UART_RDR = uart_reg_rdr::type_id::create("UART_RDR");
        UART_TDR = uart_reg_tdr::type_id::create("UART_TDR");
        UART_CFG = uart_reg_cfg::type_id::create("UART_CFG");

        UART_CPB.configure(this, null, ""); UART_CPB.build();
        UART_STP.configure(this, null, ""); UART_STP.build();
        UART_RDR.configure(this, null, ""); UART_RDR.build();
        UART_TDR.configure(this, null, ""); UART_TDR.build();
        UART_CFG.configure(this, null, ""); UART_CFG.build();

        default_map.add_reg(UART_CPB, 32'h00, "RW");
        default_map.add_reg(UART_STP, 32'h04, "RW");
        default_map.add_reg(UART_RDR, 32'h08, "RO");
        default_map.add_reg(UART_TDR, 32'h0C, "RW");
        default_map.add_reg(UART_CFG, 32'h10, "RW");

        lock_model();
    endfunction
endclass
