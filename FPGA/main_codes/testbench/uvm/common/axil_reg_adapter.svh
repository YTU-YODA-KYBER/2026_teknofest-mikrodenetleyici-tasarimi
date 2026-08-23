//=============================================================================
//  axil_reg_adapter.svh  --  uvm_reg <-> axil_item cevirici
//
//  Tasarimda WSTRB YOKTUR (butun erisimler 32-bit), bu yuzden
//  supports_byte_enable = 0. Slave'ler ayri bir cevap nesnesi uretmedigi
//  icin provides_responses = 0.
//=============================================================================
class axil_reg_adapter extends uvm_reg_adapter;
    `uvm_object_utils(axil_reg_adapter)

    function new(string name = "axil_reg_adapter");
        super.new(name);
        supports_byte_enable = 0;
        provides_responses   = 0;
    endfunction

    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        axil_item it = axil_item::type_id::create("reg2bus");
        it.kind       = (rw.kind == UVM_WRITE) ? AXIL_WRITE : AXIL_READ;
        it.addr       = rw.addr;
        it.wdata      = rw.data;
        it.gap        = 1;
        it.beats      = 1;
        return it;
    endfunction

    virtual function void bus2reg(uvm_sequence_item bus_item,
                                  ref uvm_reg_bus_op rw);
        axil_item it;
        if (!$cast(it, bus_item))
            `uvm_fatal("ADPT", "bus_item bir axil_item degil")
        rw.kind   = (it.kind == AXIL_WRITE) ? UVM_WRITE : UVM_READ;
        rw.addr   = it.addr;
        rw.data   = (it.kind == AXIL_WRITE) ? it.wdata : it.rdata;
        rw.status = UVM_IS_OK;
    endfunction
endclass
