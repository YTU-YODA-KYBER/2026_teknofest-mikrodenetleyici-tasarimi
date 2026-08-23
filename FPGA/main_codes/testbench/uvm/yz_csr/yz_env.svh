//=============================================================================
//  yz_env.svh  --  YZ CSR dogrulama ortami
//=============================================================================
class yz_env extends axil_base_env;
    `uvm_component_utils(yz_env)

    yz_accel_pkg::yz_accel_agent accel;
    yz_scoreboard                ysb;
    yz_reg_block                 yrm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void create_sb();
        ysb = yz_scoreboard::type_id::create("sb", this);
        sb  = ysb;
    endfunction

    virtual function void create_rm();
        yrm = yz_reg_block::type_id::create("yrm");
        yrm.build();
        rm = yrm;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        accel = yz_accel_pkg::yz_accel_agent::type_id::create("accel", this);
    endfunction
endclass
