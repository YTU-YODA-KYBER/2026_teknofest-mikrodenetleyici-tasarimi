//=============================================================================
//  qspi_reg_block.svh  --  QSPI Master register modeli  (taban 0x4003_0000)
//
//  Kaynak: firmware/soc.h + QSPI_Master_AXI4_Lite.sv
//
//  | Ofset | Ad       | Erisim | Not                                         |
//  |-------|----------|--------|---------------------------------------------|
//  | 0x00  | QSPI_CCR | RW     | YAZMAK TRANSFER BASLATIR (wdata[31]=0 ise). |
//  |       |          |        | wdata[31]=1 ise yalnizca QSPI_STA temizler. |
//  | 0x04  | QSPI_ADR | RW     | [23:0] flash adresi                         |
//  | 0x08  | QSPI_DR  | RW     | Yazma -> TX FIFO'ya it; okuma -> RX FIFO'dan|
//  |       |          |        | CEK. Okuma YIKICIDIR: mirror/read-back      |
//  |       |          |        | FIFO'yu bozar.                              |
//  | 0x0C  | QSPI_STA | RO     | durum bayraklari + hata kodu                |
//  | 0x10  | QSPI_FCR | RW     | FIFO flush; DONANIM bir cevrim sonra kendini|
//  |       |          |        | sifirlar -> geri okuma neredeyse hep 0      |
//  | 0x14  | QSPI_DMA | RW     | yazma = dma_start, okuma = {31'b0,dma_valid}|
//
//  QSPI_CCR ve QSPI_DR hazir uvm_reg testlerinin (bit-bash, shared-access)
//  DISINDA tutulur: ikisi de yazildiginda/okundugunda donanimda OLAY tetikler.
//=============================================================================

class qspi_reg_rw extends uvm_reg;
    `uvm_object_utils(qspi_reg_rw)
    rand uvm_reg_field VALUE;
    function new(string name = "QSPI_RW");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
    endfunction
endclass

// Yazildiginda/okundugunda olay tetikleyen register'lar -> volatile
class qspi_reg_evt extends uvm_reg;
    `uvm_object_utils(qspi_reg_evt)
    rand uvm_reg_field VALUE;
    function new(string name = "QSPI_EVT");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        VALUE = uvm_reg_field::type_id::create("VALUE");
        VALUE.configure(this, 32, 0, "RW", 1, 32'h0, 1, 1, 1);
    endfunction
endclass

class qspi_reg_sta extends uvm_reg;
    `uvm_object_utils(qspi_reg_sta)
    uvm_reg_field DONE, BUSY, RSVD0, RXFULL, RXEMPTY, TXFULL, TXEMPTY, ERR, RSVD1;
    function new(string name = "QSPI_STA");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction
    virtual function void build();
        DONE    = uvm_reg_field::type_id::create("DONE");
        BUSY    = uvm_reg_field::type_id::create("BUSY");
        RSVD0   = uvm_reg_field::type_id::create("RSVD0");
        RXFULL  = uvm_reg_field::type_id::create("RXFULL");
        RXEMPTY = uvm_reg_field::type_id::create("RXEMPTY");
        TXFULL  = uvm_reg_field::type_id::create("TXFULL");
        TXEMPTY = uvm_reg_field::type_id::create("TXEMPTY");
        ERR     = uvm_reg_field::type_id::create("ERR");
        RSVD1   = uvm_reg_field::type_id::create("RSVD1");
        DONE   .configure(this,  1,  0, "RO", 1, 1'h0,  1, 0, 1);
        BUSY   .configure(this,  1,  1, "RO", 1, 1'h0,  1, 0, 1);
        RSVD0  .configure(this,  2,  2, "RO", 1, 2'h0,  1, 0, 1);
        RXFULL .configure(this,  1,  4, "RO", 1, 1'h0,  1, 0, 1);
        RXEMPTY.configure(this,  1,  5, "RO", 1, 1'h0,  1, 0, 1);
        TXFULL .configure(this,  1,  6, "RO", 1, 1'h0,  1, 0, 1);
        TXEMPTY.configure(this,  1,  7, "RO", 1, 1'h0,  1, 0, 1);
        ERR    .configure(this,  4,  8, "RO", 1, 4'h0,  1, 0, 1);
        RSVD1  .configure(this, 20, 12, "RO", 1, 20'h0, 1, 0, 1);
    endfunction
endclass


class qspi_reg_block extends uvm_reg_block;
    `uvm_object_utils(qspi_reg_block)

    rand qspi_reg_evt QSPI_CCR;
    rand qspi_reg_rw  QSPI_ADR;
    rand qspi_reg_evt QSPI_DR;
    qspi_reg_sta      QSPI_STA;
    rand qspi_reg_evt QSPI_FCR;
    rand qspi_reg_evt QSPI_DMA;

    function new(string name = "qspi_reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);

        QSPI_CCR = qspi_reg_evt::type_id::create("QSPI_CCR");
        QSPI_ADR = qspi_reg_rw ::type_id::create("QSPI_ADR");
        QSPI_DR  = qspi_reg_evt::type_id::create("QSPI_DR");
        QSPI_STA = qspi_reg_sta::type_id::create("QSPI_STA");
        QSPI_FCR = qspi_reg_evt::type_id::create("QSPI_FCR");
        QSPI_DMA = qspi_reg_evt::type_id::create("QSPI_DMA");

        QSPI_CCR.configure(this, null, ""); QSPI_CCR.build();
        QSPI_ADR.configure(this, null, ""); QSPI_ADR.build();
        QSPI_DR .configure(this, null, ""); QSPI_DR .build();
        QSPI_STA.configure(this, null, ""); QSPI_STA.build();
        QSPI_FCR.configure(this, null, ""); QSPI_FCR.build();
        QSPI_DMA.configure(this, null, ""); QSPI_DMA.build();

        default_map.add_reg(QSPI_CCR, 32'h00, "RW");
        default_map.add_reg(QSPI_ADR, 32'h04, "RW");
        default_map.add_reg(QSPI_DR,  32'h08, "RW");
        default_map.add_reg(QSPI_STA, 32'h0C, "RO");
        default_map.add_reg(QSPI_FCR, 32'h10, "RW");
        default_map.add_reg(QSPI_DMA, 32'h14, "RW");

        lock_model();
    endfunction
endclass
