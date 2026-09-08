//=============================================================================
//  yz_reg_block.svh  --  YZ hizlandirici CSR register modeli (taban 0x4006_0000)
//
//  Kaynak: firmware/soc.h + yz_csr_wrapper.sv
//
//  | Ofset | Ad        | Erisim | Not                                       |
//  |-------|-----------|--------|-------------------------------------------|
//  | 0x00  | YZ_CTRL   | WO     | HER BIT BIR OLAYDIR, saklanmaz:           |
//  |       |           |        | [0] START -> acc_start darbesi            |
//  |       |           |        | [1] LOAD_CLEAR -> load_clear darbesi      |
//  |       |           |        | [2] INFER_CLEAR -> infer_pending = 0      |
//  |       |           |        | Okuma decode edilmez -> default 0 doner   |
//  | 0x04  | YZ_STATUS | RO     | {29'h0, infer_pending, load_done_irq,     |
//  |       |           |        |         acc_busy}                          |
//  | 0x08  | YZ_RESULT | RO     | {30'h0, result_reg}  (acc_out_wen ile     |
//  |       |           |        |  yakalanan sinif)                          |
//  | 0x10  | YZ_SCORE0 | RO     | FC katmaninin ham int32 akumulatorleri.   |
//  | 0x14  | YZ_SCORE1 | RO     | Sinif ile AYNI cycle'da yakalanir, yani   |
//  | 0x18  | YZ_SCORE2 | RO     | dordu de ayni cikarima aittir. CPU        |
//  | 0x1C  | YZ_SCORE3 | RO     | bunlari requantize edip softmax uygular.  |
//
//  Bu blogun okuma case'inde DEFAULT VARDIR (default: rdata <= 32'h0), yani
//  GPIO/UART'taki "bayat rdata" davranisi BURADA YOKTUR. Haritasiz ofset 0
//  dondurur; yz_unmapped_test bunu dogrular.
//=============================================================================

class yz_reg_ctrl extends uvm_reg;
    `uvm_object_utils(yz_reg_ctrl)
    rand uvm_reg_field VALUE;
    function new(string name = "YZ_CTRL");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        // WO: yazilir, geri okunmaz (donanimda saklanmaz)
        VALUE.configure(this, 32, 0, "WO", 1, 32'h0, 1, 1, 1);
    endfunction
endclass

class yz_reg_ro extends uvm_reg;
    `uvm_object_utils(yz_reg_ro)
    uvm_reg_field VALUE;
    function new(string name = "YZ_RO");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RO", 1, 32'h0, 1, 0, 1);
    endfunction
endclass

class yz_reg_block extends uvm_reg_block;
    `uvm_object_utils(yz_reg_block)

    rand yz_reg_ctrl YZ_CTRL;
    yz_reg_ro        YZ_STATUS;
    yz_reg_ro        YZ_RESULT;
    yz_reg_ro        YZ_SCORE[4];

    function new(string name = "yz_reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);

        YZ_CTRL   = yz_reg_ctrl::type_id::create("YZ_CTRL");
        YZ_STATUS = yz_reg_ro  ::type_id::create("YZ_STATUS");
        YZ_RESULT = yz_reg_ro  ::type_id::create("YZ_RESULT");

        YZ_CTRL  .configure(this, null, ""); YZ_CTRL  .build();
        YZ_STATUS.configure(this, null, ""); YZ_STATUS.build();
        YZ_RESULT.configure(this, null, ""); YZ_RESULT.build();

        default_map.add_reg(YZ_CTRL,   32'h00, "WO");
        default_map.add_reg(YZ_STATUS, 32'h04, "RO");
        default_map.add_reg(YZ_RESULT, 32'h08, "RO");

        foreach (YZ_SCORE[i]) begin
            YZ_SCORE[i] = yz_reg_ro::type_id::create($sformatf("YZ_SCORE%0d", i));
            YZ_SCORE[i].configure(this, null, "");
            YZ_SCORE[i].build();
            default_map.add_reg(YZ_SCORE[i], 32'h10 + i * 4, "RO");
        end

        lock_model();
    endfunction
endclass
