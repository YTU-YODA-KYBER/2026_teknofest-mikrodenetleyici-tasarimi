//=============================================================================
//  gpio_env.svh  --  GPIO dogrulama ortami
//
//  AXI agent + GPIO register modeli + GPIO scoreboard + fiziksel taraf
//  (pad) agent'i. Pad monitorunun yayinladigi switch degeri scoreboard'a
//  beslenir; GPIO_IDR okumasinin beklenen degeri oradan gelir.
//=============================================================================
class gpio_env extends axil_base_env;
    `uvm_component_utils(gpio_env)

    gpio_pad_pkg::gpio_pad_agent pad;
    gpio_scoreboard              gsb;
    gpio_reg_block               grm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void create_sb();
        gsb = gpio_scoreboard::type_id::create("sb", this);
        sb  = gsb;
    endfunction

    virtual function void create_rm();
        grm = gpio_reg_block::type_id::create("grm");
        grm.build();
        rm = grm;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        pad = gpio_pad_pkg::gpio_pad_agent::type_id::create("pad", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        pad.ap.connect(gsb.pad_export);
    endfunction
endclass
