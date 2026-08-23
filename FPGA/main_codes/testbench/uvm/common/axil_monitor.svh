//=============================================================================
//  axil_monitor.svh  --  Pasif AXI4-Lite monitoru
//
//  POSEDGE'de ornekler -- gercek AXI ornekleme kenari budur. Surucunun ne
//  yapmak istedigini degil, telde NE OLDUGUNU raporlar; scoreboard ve kapsam
//  toplayici yalnizca bu akisi gorur.
//=============================================================================
class axil_monitor extends uvm_monitor;
    `uvm_component_utils(axil_monitor)

    virtual axil_if                vif;
    uvm_analysis_port #(axil_item) ap;

    // Islemler arasi GERCEK bos cevrim sayaci: hicbir VALID yokken artar,
    // el sikismada yakalanip sifirlanir. Kapsam "bitisik mi araliklimi"
    // sorusunu boylece olculen degerle cevaplar, surucunun niyetiyle degil.
    int unsigned idle_cnt = 0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual axil_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "axil_if handle bulunamadi (uvm_config_db)")
    endfunction

    task run_phase(uvm_phase phase);
        fork
            mon_idle();
            mon_write();
            mon_read();
        join
    endtask

    task automatic mon_idle();
        forever begin
            @(posedge vif.clk);
            if (!vif.rst_n)                        idle_cnt = 0;
            else if (!vif.awvalid && !vif.arvalid) idle_cnt = idle_cnt + 1;
        end
    endtask

    task automatic mon_write();
        axil_item it;
        forever begin
            @(posedge vif.clk);
            if (vif.rst_n && vif.awvalid && vif.awready &&
                             vif.wvalid  && vif.wready) begin
                it       = axil_item::type_id::create("mon_wr");
                it.kind  = AXIL_WRITE;
                it.addr  = vif.awaddr;
                it.wdata = vif.wdata;
                it.gap   = idle_cnt;
                idle_cnt = 0;
                forever begin
                    @(posedge vif.clk);
                    if (!vif.rst_n) break;
                    if (vif.bvalid && vif.bready) begin
                        it.resp = vif.bresp;
                        ap.write(it);
                        break;
                    end
                end
            end
        end
    endtask

    task automatic mon_read();
        axil_item it;
        forever begin
            @(posedge vif.clk);
            if (vif.rst_n && vif.arvalid && vif.arready) begin
                it       = axil_item::type_id::create("mon_rd");
                it.kind  = AXIL_READ;
                it.addr  = vif.araddr;
                it.gap   = idle_cnt;
                idle_cnt = 0;
                forever begin
                    @(posedge vif.clk);
                    if (!vif.rst_n) break;
                    if (vif.rvalid && vif.rready) begin
                        it.rdata = vif.rdata;
                        it.resp  = vif.rresp;
                        ap.write(it);
                        break;
                    end
                end
            end
        end
    endtask
endclass
