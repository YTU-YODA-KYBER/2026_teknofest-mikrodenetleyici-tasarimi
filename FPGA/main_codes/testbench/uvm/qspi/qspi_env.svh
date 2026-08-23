//=============================================================================
//  qspi_env.svh  --  QSPI dogrulama ortami
//=============================================================================
class qspi_env extends axil_base_env;
    `uvm_component_utils(qspi_env)

    qspi_flash_pkg::qspi_flash     flash;
    qspi_flash_pkg::qspi_flash_cfg fcfg;
    uvm_tlm_analysis_fifo #(qspi_flash_pkg::qspi_cmd) flash_fifo;

    qspi_scoreboard qsb;
    qspi_reg_block  qrm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void create_sb();
        qsb = qspi_scoreboard::type_id::create("sb", this);
        sb  = qsb;
    endfunction

    virtual function void create_rm();
        qrm = qspi_reg_block::type_id::create("qrm");
        qrm.build();
        rm = qrm;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(qspi_flash_pkg::qspi_flash_cfg)::get(this, "", "fcfg", fcfg))
            fcfg = qspi_flash_pkg::qspi_flash_cfg::type_id::create("fcfg");
        uvm_config_db#(qspi_flash_pkg::qspi_flash_cfg)::set(this, "flash", "cfg", fcfg);
        flash      = qspi_flash_pkg::qspi_flash::type_id::create("flash", this);
        flash_fifo = new("flash_fifo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        flash.ap.connect(flash_fifo.analysis_export);
    endfunction
endclass
