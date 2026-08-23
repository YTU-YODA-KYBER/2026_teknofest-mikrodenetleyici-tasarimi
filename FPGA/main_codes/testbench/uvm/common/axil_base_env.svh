//=============================================================================
//  axil_base_env.svh  --  Butun bloklarin ortak ortami
//
//  Icerik: AXI agent + scoreboard + (varsa) uvm_reg modeli, adapter ve
//  predictor. Blok ortamlari yalnizca create_sb() / create_rm() kancalarini
//  ezerek kendi scoreboard'unu ve register modelini kurar; baglanti mantigi
//  burada tek yerdedir.
//=============================================================================
class axil_base_env extends uvm_env;
    `uvm_component_utils(axil_base_env)

    axil_cfg                       cfg;
    axil_agent                     agent;
    axil_scoreboard                sb;
    axil_reg_adapter               adapter;
    uvm_reg_predictor #(axil_item) predictor;
    uvm_reg_block                  rm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Blok ortamlari bunlari ezer
    virtual function void create_sb();
        sb = axil_scoreboard::type_id::create("sb", this);
    endfunction

    virtual function void create_rm();
        rm = null;      // register modeli olmayan bloklar icin
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(axil_cfg)::get(this, "", "cfg", cfg))
            cfg = axil_cfg::type_id::create("cfg");
        uvm_config_db#(axil_cfg)::set(this, "agent", "cfg", cfg);

        agent = axil_agent::type_id::create("agent", this);

        create_sb();
        if (sb != null) begin
            sb.base_addr = cfg.base_addr;
            sb.blk       = cfg.block_name;
        end

        create_rm();
        if (rm != null) begin
            adapter   = axil_reg_adapter::type_id::create("adapter");
            predictor = uvm_reg_predictor #(axil_item)::type_id::create("predictor", this);
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if (sb != null)
            agent.ap.connect(sb.analysis_export);

        if (rm != null) begin
            rm.default_map.set_sequencer(agent.sqr, adapter);
            rm.default_map.set_base_addr(cfg.base_addr);
            predictor.map     = rm.default_map;
            predictor.adapter = adapter;
            agent.ap.connect(predictor.bus_in);
        end
    endfunction
endclass
