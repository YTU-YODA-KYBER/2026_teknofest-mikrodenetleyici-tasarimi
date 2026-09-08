//=============================================================================
//  t_smoke_gpio.sv  --  Adim 0 / Madde 2,3,4,5
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  Gercek GPIO RTL'i uzerinde dort seyi birden kanitlar:
//    Madde 2 : bind calisiyor mu  (axi4lite_bind_gpio.svh)
//    Madde 3 : SVA calisiyor mu   (kontrolcunun 33 assert property'si)
//    Madde 4 : covergroup calisiyor mu (axil_coverage)
//    Madde 5 : uvm_reg ayakta mi  (2 register'lik model + adapter + predictor)
//=============================================================================
`timescale 1ns/1ps

`include "axi4lite_bind_gpio.svh"

module t_smoke_gpio;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;

    //---------------------------------------------------------------------
    //  Saat / reset
    //---------------------------------------------------------------------
    logic clk   = 1'b0;
    logic rst_n = 1'b0;

    always #10ns clk = ~clk;          // 50 MHz -- sistem saatiyle ayni

    initial begin
        rst_n = 1'b0;
        repeat (5) @(posedge clk);
        rst_n = 1'b1;
    end

    //---------------------------------------------------------------------
    //  Arayuz + DUT
    //---------------------------------------------------------------------
    axil_if axil (.clk(clk), .rst_n(rst_n));

    logic [31:0] gpio_idr = 32'h0000_0000;
    logic [31:0] gpio_odr;
    logic [ 7:0] catode, anode;

    GPIO_AXI4_Lite dut (
        .clk_i        (clk),
        .rst_n        (rst_n),
        .GPIO_IDR     (gpio_idr),
        .GPIO_ODR     (gpio_odr),
        .awaddr       (axil.awaddr),
        .awvalid      (axil.awvalid),
        .awready      (axil.awready),
        .wdata        (axil.wdata),
        .wvalid       (axil.wvalid),
        .wready       (axil.wready),
        .bresp        (axil.bresp),
        .bvalid       (axil.bvalid),
        .bready       (axil.bready),
        .araddr       (axil.araddr),
        .arvalid      (axil.arvalid),
        .arready      (axil.arready),
        .rready       (axil.rready),
        .rdata        (axil.rdata),
        .rresp        (axil.rresp),
        .rvalid       (axil.rvalid),
        .catode       (catode),
        .anode        (anode)
    );

    //=====================================================================
    //  Madde 5: minimal uvm_reg modeli
    //=====================================================================
    class reg_gpio_idr extends uvm_reg;
        `uvm_object_utils(reg_gpio_idr)
        uvm_reg_field VALUE;
        function new(string name = "GPIO_IDR");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction
        virtual function void build();
            VALUE = uvm_reg_field::type_id::create("VALUE");
            //          parent, size, lsb, access, volatile, reset, has_reset, is_rand, indiv
            VALUE.configure(this, 32, 0, "RO", 1, 32'h0, 1, 0, 1);
        endfunction
    endclass

    class reg_gpio_odr extends uvm_reg;
        `uvm_object_utils(reg_gpio_odr)
        rand uvm_reg_field VALUE;    // [15:0]  yazilabilir
        uvm_reg_field      RSVD;     // [31:16] donanimda sifir bagli
        function new(string name = "GPIO_ODR");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction
        virtual function void build();
            VALUE = uvm_reg_field::type_id::create("VALUE");
            RSVD  = uvm_reg_field::type_id::create("RSVD");
            VALUE.configure(this, 16,  0, "RW", 0, 16'h0, 1, 1, 1);
            RSVD .configure(this, 16, 16, "RO", 0, 16'h0, 1, 0, 1);
        endfunction
    endclass

    class gpio_reg_block extends uvm_reg_block;
        `uvm_object_utils(gpio_reg_block)
        rand reg_gpio_idr GPIO_IDR;
        rand reg_gpio_odr GPIO_ODR;

        function new(string name = "gpio_reg_block");
            super.new(name, UVM_NO_COVERAGE);
        endfunction

        virtual function void build();
            default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);
            GPIO_IDR = reg_gpio_idr::type_id::create("GPIO_IDR");
            GPIO_IDR.configure(this, null, "");
            GPIO_IDR.build();
            default_map.add_reg(GPIO_IDR, 32'h00, "RO");

            GPIO_ODR = reg_gpio_odr::type_id::create("GPIO_ODR");
            GPIO_ODR.configure(this, null, "");
            GPIO_ODR.build();
            default_map.add_reg(GPIO_ODR, 32'h04, "RW");

            lock_model();
        endfunction
    endclass

    // NOT: adapter'in kendisi artik axil_pkg icindedir (axil_reg_adapter.svh);
    // burada ikinci bir kopya TUTULMAZ. Smoke testi de ortak katmani kullanir,
    // boylece kapi testi gercekten kullanilacak kodu dogrular.

    //=====================================================================
    //  Test
    //=====================================================================
    class smoke_test extends uvm_test;
        `uvm_component_utils(smoke_test)

        axil_agent       agent;
        gpio_reg_block   rm;
        axil_reg_adapter adapter;
        uvm_reg_predictor #(axil_item) predictor;

        int madde_gecen = 0;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            agent     = axil_agent::type_id::create("agent", this);
            rm        = gpio_reg_block::type_id::create("rm");
            rm.build();
            adapter   = axil_reg_adapter::type_id::create("adapter");
            predictor = uvm_reg_predictor#(axil_item)::type_id::create("predictor", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            rm.default_map.set_sequencer(agent.sqr, adapter);
            rm.default_map.set_base_addr(32'h4001_0000);
            predictor.map     = rm.default_map;
            predictor.adapter = adapter;
            agent.ap.connect(predictor.bus_in);
        endfunction

        task run_phase(uvm_phase phase);
            uvm_status_e   status;
            uvm_reg_data_t data;

            phase.raise_objection(this);
            wait (rst_n === 1'b1);
            repeat (3) @(posedge clk);

            // ---- Madde 5a: uvm_reg write/read ----
            rm.GPIO_ODR.write(status, 32'h0000_ABCD);
            if (status != UVM_IS_OK) `uvm_error("REG", "ODR yazmasi basarisiz")

            rm.GPIO_ODR.read(status, data);
            if (status != UVM_IS_OK) `uvm_error("REG", "ODR okumasi basarisiz")
            if (data !== 32'h0000_ABCD)
                `uvm_error("REG", $sformatf("ODR geri okuma yanlis: 0x%08h", data))
            else begin
                `uvm_info("SMOKE", "uvm_reg write/read calisti", UVM_LOW)
                madde_gecen++;
            end

            // ---- Madde 5b: mirror (predictor yolu) ----
            rm.GPIO_ODR.mirror(status, UVM_CHECK);
            if (status != UVM_IS_OK)
                `uvm_error("REG", "mirror basarisiz")
            else begin
                `uvm_info("SMOKE", "uvm_reg mirror + predictor calisti", UVM_LOW)
                madde_gecen++;
            end

            // ---- Madde 5c: RO alan -- ust 16 bit donanimda sifir bagli ----
            rm.GPIO_ODR.write(status, 32'hFFFF_1234);
            rm.GPIO_ODR.read(status, data);
            if (data !== 32'h0000_1234)
                `uvm_error("REG", $sformatf("ODR[31:16] sifir bagli olmali, okunan 0x%08h", data))
            else begin
                `uvm_info("SMOKE", "ODR[31:16] sifir bagi dogrulandi", UVM_LOW)
                madde_gecen++;
            end

            // ---- Madde 4: kapsam toplayiciyi besle (farkli ofsetler) ----
            begin
                axil_single_seq s;
                for (int i = 0; i < 8; i++) begin
                    s = axil_single_seq::type_id::create("cov_rd");
                    s.kind       = AXIL_READ;
                    s.addr       = 32'h4001_0000 + (i*4);
                    s.wdata      = 32'h0;
                    s.gap        = 1;
                    s.beats      = 1;
                    s.start(agent.sqr);
                end
            end

            repeat (10) @(posedge clk);
            phase.drop_objection(this);
        endtask

        function void report_phase(uvm_phase phase);
            int unsigned ihlal;
            uvm_report_server svr = uvm_report_server::get_server();

            ihlal = axi_chk_pkg::final_report();

            $display("======================================================================");
            $display("            ADIM 0 SMOKE SONUCU");
            $display("======================================================================");
            $display("  Madde 2 (bind)       : %s",
                     (axi_chk_pkg::g_check_count > 0) ? "GECTI" : "KALDI");
            $display("  Madde 3 (SVA)        : %s",
                     (axi_chk_pkg::g_check_count > 0) ? "GECTI (assert'ler derlendi ve kosturuldu)" : "KALDI");
            $display("  Madde 5 (uvm_reg)    : %s  (%0d/3 alt kontrol)",
                     (madde_gecen == 3) ? "GECTI" : "KALDI", madde_gecen);
            $display("  AXI protokol ihlali  : %0d", ihlal);
            $display("  UVM_ERROR            : %0d", svr.get_severity_count(UVM_ERROR));
            $display("======================================================================");
        endfunction
    endclass

    //---------------------------------------------------------------------
    initial begin
        uvm_config_db #(virtual axil_if)::set(null, "*", "vif", axil);
        run_test("smoke_test");
    end

    // Guvenlik agi
    initial begin
        #5ms;
        $display("*** ZAMAN ASIMI ***");
        $finish;
    end

endmodule
