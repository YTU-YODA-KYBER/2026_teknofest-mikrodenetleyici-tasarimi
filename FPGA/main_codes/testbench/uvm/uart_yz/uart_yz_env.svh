//=============================================================================
//  uart_yz_env.svh  --  UART_YZ ortami = ortak UART ortami + DMA yan bandi
//=============================================================================
class uart_yz_env extends uart_env;
    `uvm_component_utils(uart_yz_env)

    uart_pkg::uart_dma_agent dma;
    uvm_tlm_analysis_fifo #(uart_pkg::uart_dma_item) dma_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        dma      = uart_pkg::uart_dma_agent::type_id::create("dma", this);
        dma_fifo = new("dma_fifo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        dma.ap.connect(dma_fifo.analysis_export);
    endfunction
endclass
