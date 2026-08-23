//=============================================================================
//  t_uvm_hello.sv  --  Adim 0 / Madde 1: UVM cekirdegi ayakta mi?
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  UVM'in bu simulatorde calisip calismadigini olcen en kucuk test.
//  Faz mekanizmasi, factory, raporlama ve objection'lari dener.
//=============================================================================
`timescale 1ns/1ps

module t_uvm_hello;

    import uvm_pkg::*;

    class hello_test extends uvm_test;
        `uvm_component_utils(hello_test)

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        task run_phase(uvm_phase phase);
            phase.raise_objection(this);
            `uvm_info("SMOKE", "UVM fazlari calisiyor", UVM_LOW)
            #100ns;
            `uvm_info("SMOKE", "objection birakiliyor", UVM_LOW)
            phase.drop_objection(this);
        endtask

        function void report_phase(uvm_phase phase);
            uvm_report_server svr = uvm_report_server::get_server();
            if (svr.get_severity_count(UVM_FATAL) +
                svr.get_severity_count(UVM_ERROR) == 0)
                $display("\n*** MADDE 1 GECTI: UVM cekirdegi ayakta ***\n");
            else
                $display("\n*** MADDE 1 KALDI ***\n");
        endfunction
    endclass

    initial run_test("hello_test");

endmodule
