//=============================================================================
//  i2c_reg_block.svh  --  I2C Master register modeli  (taban 0x4002_0000)
//
//  Kaynak: firmware/soc.h + I2C_Master_AXI4_Lite.sv
//
//  | Ofset | Ad      | Erisim | Not                                          |
//  |-------|---------|--------|----------------------------------------------|
//  | 0x00  | I2C_NBY | RW     | DONANIM KIRPAR: >4 -> 4, 0 -> 1. Yazilanla   |
//  |       |         |        | geri okunan farkli olabilir; bu TASARIM       |
//  |       |         |        | GEREGIDIR, hata degildir. Bu yuzden alan      |
//  |       |         |        | volatile ve hazir bit-bash disinda tutulur.   |
//  | 0x04  | I2C_ADR | RW     | [6:0] slave adresi                           |
//  | 0x08  | I2C_RDR | RO     | okunan veri; ilk bayt [7:0]                  |
//  | 0x0C  | I2C_TDR | RW     | gonderilecek veri; LSB once                  |
//  | 0x10  | I2C_CFG | RW     | [0] TXEN (HW temizler), [1] TXDONE (HW set), |
//  |       |         |        | [2] RXEN (HW temizler), [3] RXDONE (HW set) |
//  | 0x14  | I2C_CLR | WO     | [0] TXDONE'u sil, [1] RXDONE'u sil.          |
//  |       |         |        | Okuma decode edilmez -> default 0 doner.     |
//=============================================================================

class i2c_reg_nby extends uvm_reg;
    `uvm_object_utils(i2c_reg_nby)
    rand uvm_reg_field VALUE;
    function new(string name = "I2C_NBY");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        // volatile: donanim yazilan degeri degistirebilir (kirpma)
        VALUE.configure(this, 32, 0, "RW", 1, 32'h0, 1, 1, 1);
    endfunction
endclass

class i2c_reg_rw extends uvm_reg;
    `uvm_object_utils(i2c_reg_rw)
    rand uvm_reg_field VALUE;
    function new(string name = "I2C_RW");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
    endfunction
endclass

class i2c_reg_rdr extends uvm_reg;
    `uvm_object_utils(i2c_reg_rdr)
    uvm_reg_field VALUE;
    function new(string name = "I2C_RDR");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RO", 1, 32'h0, 1, 0, 1);
    endfunction
endclass

class i2c_reg_cfg extends uvm_reg;
    `uvm_object_utils(i2c_reg_cfg)
    rand uvm_reg_field TXEN;
    rand uvm_reg_field TXDONE;
    rand uvm_reg_field RXEN;
    rand uvm_reg_field RXDONE;
    uvm_reg_field      RSVD;
    function new(string name = "I2C_CFG");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        TXEN   = uvm_reg_field::type_id::create("TXEN");
        TXDONE = uvm_reg_field::type_id::create("TXDONE");
        RXEN   = uvm_reg_field::type_id::create("RXEN");
        RXDONE = uvm_reg_field::type_id::create("RXDONE");
        RSVD   = uvm_reg_field::type_id::create("RSVD");
        TXEN  .configure(this,  1, 0, "RW", 1, 1'h0,  1, 1, 1);
        TXDONE.configure(this,  1, 1, "RW", 1, 1'h0,  1, 1, 1);
        RXEN  .configure(this,  1, 2, "RW", 1, 1'h0,  1, 1, 1);
        RXDONE.configure(this,  1, 3, "RW", 1, 1'h0,  1, 1, 1);
        RSVD  .configure(this, 28, 4, "RO", 0, 28'h0, 1, 0, 1);
    endfunction
endclass

class i2c_reg_clr extends uvm_reg;
    `uvm_object_utils(i2c_reg_clr)
    rand uvm_reg_field VALUE;
    function new(string name = "I2C_CLR");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "WO", 1, 32'h0, 1, 1, 1);
    endfunction
endclass


class i2c_reg_block extends uvm_reg_block;
    `uvm_object_utils(i2c_reg_block)

    rand i2c_reg_nby I2C_NBY;
    rand i2c_reg_rw  I2C_ADR;
    i2c_reg_rdr      I2C_RDR;
    rand i2c_reg_rw  I2C_TDR;
    rand i2c_reg_cfg I2C_CFG;
    rand i2c_reg_clr I2C_CLR;

    function new(string name = "i2c_reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);

        I2C_NBY = i2c_reg_nby::type_id::create("I2C_NBY");
        I2C_ADR = i2c_reg_rw ::type_id::create("I2C_ADR");
        I2C_RDR = i2c_reg_rdr::type_id::create("I2C_RDR");
        I2C_TDR = i2c_reg_rw ::type_id::create("I2C_TDR");
        I2C_CFG = i2c_reg_cfg::type_id::create("I2C_CFG");
        I2C_CLR = i2c_reg_clr::type_id::create("I2C_CLR");

        I2C_NBY.configure(this, null, ""); I2C_NBY.build();
        I2C_ADR.configure(this, null, ""); I2C_ADR.build();
        I2C_RDR.configure(this, null, ""); I2C_RDR.build();
        I2C_TDR.configure(this, null, ""); I2C_TDR.build();
        I2C_CFG.configure(this, null, ""); I2C_CFG.build();
        I2C_CLR.configure(this, null, ""); I2C_CLR.build();

        default_map.add_reg(I2C_NBY, 32'h00, "RW");
        default_map.add_reg(I2C_ADR, 32'h04, "RW");
        default_map.add_reg(I2C_RDR, 32'h08, "RO");
        default_map.add_reg(I2C_TDR, 32'h0C, "RW");
        default_map.add_reg(I2C_CFG, 32'h10, "RW");
        default_map.add_reg(I2C_CLR, 32'h14, "WO");

        lock_model();
    endfunction
endclass
