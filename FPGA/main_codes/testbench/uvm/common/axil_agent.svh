//=============================================================================
//  axil_agent.svh  --  Sequencer + surucu + monitor + kapsam
//=============================================================================
typedef uvm_sequencer #(axil_item) axil_sequencer;

class axil_agent extends uvm_agent;
    `uvm_component_utils(axil_agent)

    axil_cfg       cfg;
    axil_sequencer sqr;
    axil_driver    drv;
    axil_monitor   mon;
    axil_coverage  cov;

    uvm_analysis_port #(axil_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(axil_cfg)::get(this, "", "cfg", cfg))
            cfg = axil_cfg::type_id::create("cfg");
        mon = axil_monitor::type_id::create("mon", this);
        cov = axil_coverage::type_id::create("cov", this);
        if (cfg.is_active) begin
            sqr = axil_sequencer::type_id::create("sqr", this);
            drv = axil_driver  ::type_id::create("drv", this);
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon.ap.connect(ap);
        mon.ap.connect(cov.analysis_export);
        if (cfg.is_active)
            drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass
