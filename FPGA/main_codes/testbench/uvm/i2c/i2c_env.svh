//=============================================================================
//  i2c_env.svh  --  I2C dogrulama ortami
//
//  AXI agent + I2C register modeli + I2C scoreboard + protokol seviyesinde
//  bir I2C slave. Slave'in gordugu transfer'ler FIFO'ya dusurulur; testler
//  master'in urettigi trafigi oradan dogrular.
//=============================================================================
class i2c_env extends axil_base_env;
    `uvm_component_utils(i2c_env)

    i2c_slave_pkg::i2c_slave     slave;
    i2c_slave_pkg::i2c_slave_cfg scfg;
    uvm_tlm_analysis_fifo #(i2c_slave_pkg::i2c_txn) slave_fifo;

    i2c_scoreboard isb;
    i2c_reg_block  irm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void create_sb();
        isb = i2c_scoreboard::type_id::create("sb", this);
        sb  = isb;
    endfunction

    virtual function void create_rm();
        irm = i2c_reg_block::type_id::create("irm");
        irm.build();
        rm = irm;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(i2c_slave_pkg::i2c_slave_cfg)::get(this, "", "scfg", scfg))
            scfg = i2c_slave_pkg::i2c_slave_cfg::type_id::create("scfg");
        uvm_config_db#(i2c_slave_pkg::i2c_slave_cfg)::set(this, "slave", "cfg", scfg);
        slave      = i2c_slave_pkg::i2c_slave::type_id::create("slave", this);
        slave_fifo = new("slave_fifo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        slave.ap.connect(slave_fifo.analysis_export);
    endfunction
endclass
