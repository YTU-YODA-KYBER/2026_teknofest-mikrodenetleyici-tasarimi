//=============================================================================
//  axi4lite_bind.svh  --  Protokol kontrolcusunun tum AXI arayuzlerine baglanmasi
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  RTL'e TEK SATIR DOKUNULMADAN, 'bind' ile tasarimdaki 15 AXI4-Lite
//  arayuzunun tamamina ayni kontrolcu baglanir. Sadece testbench derlemesine
//  dahil edilir; sentez akisina girmez.
//
//  KULLANIM (testbench'in en ustunde, modul disinda):
//      `include "axi4lite_bind.svh"
//=============================================================================
`ifndef AXI4LITE_BIND_SVH
`define AXI4LITE_BIND_SVH

//---- 1) Timer -----------------------------------------------------------
bind Timer_AXI4_Lite axi4lite_protocol_checker #(
    .NAME("TIMER"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(1)
) u_axi_chk (
    .aclk(clk_i), .aresetn(rst_n),
    .awaddr(awaddr), .awvalid(awvalid), .awready(awready),
    .wdata(wdata), .wstrb(4'hF), .wvalid(wvalid), .wready(wready),
    .bresp(bresp), .bvalid(bvalid), .bready(bready),
    .araddr(araddr), .arvalid(arvalid), .arready(arready),
    .rdata(rdata), .rresp(rresp), .rvalid(rvalid), .rready(rready)
);


`endif
