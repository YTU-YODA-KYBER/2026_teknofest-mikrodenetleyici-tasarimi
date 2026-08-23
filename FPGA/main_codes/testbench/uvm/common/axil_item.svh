//=============================================================================
//  axil_item.svh  --  AXI4-Lite transaction
//=============================================================================

typedef enum bit { AXIL_READ = 1'b0, AXIL_WRITE = 1'b1 } axil_kind_e;

class axil_item extends uvm_sequence_item;

    rand axil_kind_e  kind;
    rand bit [31:0]   addr;
    rand bit [31:0]   wdata;
    rand int unsigned gap;    // islem oncesi bos cevrim (monitor OLCER)

    // Ayni VALID yukseltmesi uzerinde kac islem yapilacagi.
    // 1 = normal (el sikismadan sonra VALID duser).
    // >1 = boru hatli master: VALID indirilmez, ayni yukseltme uzerinde
    //      pes pese el sikisma beklenir. AXI'de tamamen yasaldir.
    rand int unsigned beats;

    // Surucunun / monitorun doldurdugu alanlar
    bit [31:0] rdata;
    bit [1:0]  resp;

    `uvm_object_utils_begin(axil_item)
        `uvm_field_enum(axil_kind_e, kind, UVM_ALL_ON)
        `uvm_field_int(addr,       UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(wdata,      UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(rdata,      UVM_ALL_ON | UVM_HEX)
        `uvm_field_int(resp,       UVM_ALL_ON)
        `uvm_field_int(gap,        UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(beats,      UVM_ALL_ON | UVM_DEC)
    `uvm_object_utils_end

    constraint c_gap        { gap        inside {[0:6]}; }
    constraint c_beats      { beats == 1; }           // stres testi ezer
    constraint c_word_align { addr[1:0]  == 2'b00; }  // AXI4-Lite 32-bit erisim

    function new(string name = "axil_item");
        super.new(name);
    endfunction

    function string convert2string();
        return $sformatf("%s addr=0x%08h wdata=0x%08h rdata=0x%08h resp=%0d gap=%0d beats=%0d",
                         kind.name(), addr, wdata, rdata, resp, gap, beats);
    endfunction
endclass
