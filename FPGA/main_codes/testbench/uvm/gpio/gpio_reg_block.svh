//=============================================================================
//  gpio_reg_block.svh  --  GPIO register modeli  (taban 0x4001_0000)
//
//  Kaynak: firmware/soc.h  (adres/bit tanimlarinin TEK kaynagi)
//
//  | Ofset | Ad       | Erisim | Not                                        |
//  |-------|----------|--------|--------------------------------------------|
//  | 0x00  | GPIO_IDR | RO     | switch girisi; donanim surer -> volatile   |
//  | 0x04  | GPIO_ODR | RW     | yalniz [15:0] saklanir, [31:16] sifir bagli|
//
//  DIKKAT: RTL adres decode'u yalnizca addr[3:0]'a bakar; register'lar her
//  16 baytta bir TEKRAR EDER (0x10 -> IDR, 0x14 -> ODR ...). Bu, register
//  modeliyle degil, gpio_unmapped_test ile dogrulanir.
//=============================================================================

class reg_gpio_idr extends uvm_reg;
    `uvm_object_utils(reg_gpio_idr)
    uvm_reg_field VALUE;

    function new(string name = "GPIO_IDR");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        //              parent, size, lsb, access, volatile, reset, has_reset, is_rand, indiv
        VALUE.configure(this,   32,   0,   "RO",   1,        32'h0, 1,         0,       1);
    endfunction
endclass


class reg_gpio_odr extends uvm_reg;
    `uvm_object_utils(reg_gpio_odr)
    rand uvm_reg_field VALUE;   // [15:0]  yazilabilir
    uvm_reg_field      RSVD;    // [31:16] donanimda sifir bagli

    function new(string name = "GPIO_ODR");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        RSVD  = uvm_reg_field::type_id::create("RSVD");
        VALUE.configure(this, 16,  0, "RW", 0, 16'h0, 1, 1, 1);
        RSVD .configure(this, 16, 16, "RO", 0, 16'h0, 1, 0, 1);
    endfunction
endclass


class gpio_reg_block extends uvm_reg_block;
    `uvm_object_utils(gpio_reg_block)

    rand reg_gpio_idr GPIO_IDR;
    rand reg_gpio_odr GPIO_ODR;

    function new(string name = "gpio_reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);

        GPIO_IDR = reg_gpio_idr::type_id::create("GPIO_IDR");
        GPIO_IDR.configure(this, null, "");
        GPIO_IDR.build();
        default_map.add_reg(GPIO_IDR, 32'h00, "RO");

        GPIO_ODR = reg_gpio_odr::type_id::create("GPIO_ODR");
        GPIO_ODR.configure(this, null, "");
        GPIO_ODR.build();
        default_map.add_reg(GPIO_ODR, 32'h04, "RW");

        lock_model();
    endfunction
endclass
