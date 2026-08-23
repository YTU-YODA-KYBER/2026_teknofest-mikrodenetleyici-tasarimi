//=============================================================================
//  uart_yz_test_lib.svh  --  UART_YZ testleri
//
//  Ortak UART testleri uart_test_lib.svh'de; burada yalnizca UART_YZ'ye ozgu
//  DMA yan bandi testleri ve taban adres/blok adi turevleri var.
//=============================================================================

class uart_yz_base_test extends uart_base_test;
    `uvm_component_utils(uart_yz_base_test)

    uart_yz_env         yenv;
    virtual uart_dma_if dvif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void yapilandir();
        base_addr = 32'h4005_0000;
        blok      = "UART_YZ";
    endfunction

    function void build_phase(uvm_phase phase);
        axil_base_env::type_id::set_type_override(uart_yz_env::get_type());
        uart_env     ::type_id::set_type_override(uart_yz_env::get_type());
        super.build_phase(phase);
        if (!$cast(yenv, env)) `uvm_fatal("ENV", "uart_yz_env cast basarisiz")
        if (!uvm_config_db#(virtual uart_dma_if)::get(this, "", "vif", dvif))
            `uvm_fatal("NOVIF", "uart_dma_if handle bulunamadi")
    endfunction
endclass


//---- DMA yan bandi ----------------------------------------------------------
//
//  UART_YZ'yi UART_GU'dan ayiran TEK ozellik budur ve mevcut blok
//  testbench'inde (UART_YZ_tb.sv) uc DMA portu hic baglanmamistir.
//  Bu test iki yolu da dogrular:
//    dma_enable_i = 1 -> her alinan bayt icin dma_valid_o darbesi ve
//                        dma_data_o == alinan bayt
//    dma_enable_i = 0 -> DMA yolu HIC tetiklenmez
class uart_yz_dma_test extends uart_yz_base_test;
    `uvm_component_utils(uart_yz_dma_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        bit [7:0]                veri[$] = '{8'h55, 8'hAA, 8'h13, 8'hE7};
        uvm_status_e             st;
        uvm_reg_data_t           d;
        uart_pkg::uart_dma_item  di;
        int unsigned             darbe_once;

        phase.raise_objection(this);
        reset_bekle();
        baud_kur(CPB_TEST);

        //---- 1) dma_enable_i = 1 : her bayt DMA'ya dusmeli ----
        dvif.enable = 1'b1;
        repeat (5) @(posedge vif.clk);

        foreach (veri[i]) begin
            rx_al(veri[i]);
            yenv.dma_fifo.get(di);
            if (di.data !== veri[i])
                `uvm_error("DMA", $sformatf(
                    "DMA verisi yanlis: gonderilen 0x%02h, dma_data_o 0x%02h", veri[i], di.data))
            else
                `uvm_info("DMA", $sformatf("0x%02h DMA yan bandindan dogru cikti", veri[i]), UVM_LOW)

            // Ayni bayt UART_RDR'de de olmali (RX yolu fan-out'tur)
            uenv.urm.UART_RDR.read(st, d);
            if (d[7:0] !== veri[i])
                `uvm_error("DMA", $sformatf(
                    "UART_RDR ile DMA ayni bayti gostermeli: RDR=0x%02h DMA=0x%02h",
                    d[7:0], di.data))
            uenv.urm.UART_CFG.write(st, 32'h0);
            repeat (CPB_TEST) @(posedge vif.clk);
        end

        //---- 2) dma_enable_i = 0 : DMA yolu sessiz kalmali ----
        dvif.enable = 1'b0;
        repeat (5) @(posedge vif.clk);
        darbe_once = yenv.dma.mon.n_darbe;

        rx_al(8'h5C);
        // RXREADY bekle -- bayt yine de alinmali
        begin
            int unsigned n = 0;
            forever begin
                uenv.urm.UART_CFG.read(st, d);
                if (d[1]) break;
                n++;
                if (n > 100) begin `uvm_error("DMA", "RXREADY zaman asimi"); break; end
                repeat (20) @(posedge vif.clk);
            end
        end
        uenv.urm.UART_RDR.read(st, d);
        if (d[7:0] !== 8'h5C)
            `uvm_error("DMA", $sformatf("enable=0 iken de bayt alinmali, UART_RDR=0x%02h", d[7:0]))

        repeat (4 * CPB_TEST) @(posedge vif.clk);
        if (yenv.dma.mon.n_darbe != darbe_once)
            `uvm_error("DMA", $sformatf(
                "dma_enable_i=0 iken DMA darbesi olusmamali (%0d -> %0d)",
                darbe_once, yenv.dma.mon.n_darbe))
        else
            `uvm_info("DMA", "dma_enable_i=0 iken DMA yolu sessiz kaldi -- dogru", UVM_LOW)

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass
