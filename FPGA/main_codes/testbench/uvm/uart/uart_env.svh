//=============================================================================
//  uart_env.svh  --  UART dogrulama ortami (UART_GU ve UART_YZ ortak)
//
//  AXI agent + UART register modeli + UART scoreboard + seri taraf agent'i.
//  UART_YZ ortami bunu genisletip DMA yan bandi agent'ini ekler.
//=============================================================================
class uart_env extends axil_base_env;
    `uvm_component_utils(uart_env)

    uart_pkg::uart_agent serial;
    uart_scoreboard      usb;
    uart_reg_block       urm;

    // Seri monitorun cozdugu cerceveleri testin bekleyebilmesi icin FIFO
    uvm_tlm_analysis_fifo #(uart_pkg::uart_item) serial_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void create_sb();
        usb = uart_scoreboard::type_id::create("sb", this);
        sb  = usb;
    endfunction

    virtual function void create_rm();
        urm = uart_reg_block::type_id::create("urm");
        urm.build();
        rm = urm;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        serial      = uart_pkg::uart_agent::type_id::create("serial", this);
        serial_fifo = new("serial_fifo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        serial.ap.connect(serial_fifo.analysis_export);
    endfunction
endclass
