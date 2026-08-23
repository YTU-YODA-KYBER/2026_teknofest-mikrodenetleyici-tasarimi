//=============================================================================
//  axil_cfg.svh  --  Agent yapilandirmasi
//=============================================================================
class axil_cfg extends uvm_object;
    `uvm_object_utils(axil_cfg)

    bit        is_active  = 1;
    bit [31:0] base_addr  = 32'h0000_0000;   // blogun taban adresi
    string     block_name = "AXIL";

    function new(string name = "axil_cfg");
        super.new(name);
    endfunction
endclass
