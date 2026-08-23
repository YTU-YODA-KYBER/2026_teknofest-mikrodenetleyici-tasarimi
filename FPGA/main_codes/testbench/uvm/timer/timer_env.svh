//=============================================================================
//  timer_env.svh  --  Timer dogrulama ortami
//
//  Timer'in AXI disi portu yoktur (yalnizca clk/rst_n), bu yuzden ek bir
//  fiziksel taraf agent'i gerekmez.
//=============================================================================
class timer_env extends axil_base_env;
    `uvm_component_utils(timer_env)

    timer_scoreboard tsb;
    timer_reg_block  trm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void create_sb();
        tsb = timer_scoreboard::type_id::create("sb", this);
        sb  = tsb;
    endfunction

    virtual function void create_rm();
        trm = timer_reg_block::type_id::create("trm");
        trm.build();
        rm = trm;
    endfunction
endclass
