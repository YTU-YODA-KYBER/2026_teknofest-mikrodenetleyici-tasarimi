//=============================================================================
//  axi4lite_bind_yz_csr.svh  --  Protokol kontrolcusunun YZ CSR'ye baglanmasi
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  Sistem seviyesindeki axi4lite_bind.svh'nin 7. kaydinin blok seviyesi
//  karsiligi. Sarmalayicinin AXI port adlari "YZ_" oneklidir; bind
//  port adlarini HEDEF MODULUN kapsaminda cozdugu icin burada da ayni
//  onekle yazilir.
//
//  NOT: Diger alti bind dosyasi ayni `AXI4LITE_BIND_SVH` guard'ini
//  kullanir ve bu yuzden bir derleme biriminde YALNIZCA BIRI include
//  edilebilir. Bu dosya kendi guard'ini kullanir ki, ileride birden fazla
//  blogu ayni testbench'te toplamak gerekirse engel olmasin.
//
//  KULLANIM (testbench'in en ustunde, modul disinda):
//      `include "axi4lite_bind_yz_csr.svh"
//=============================================================================
`ifndef AXI4LITE_BIND_YZ_CSR_SVH
`define AXI4LITE_BIND_YZ_CSR_SVH

bind yz_csr_wrapper axi4lite_protocol_checker #(
    .NAME("YZ_ACCEL"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(1)
) u_axi_chk (
    .aclk(clk), .aresetn(rst_n),
    .awaddr(YZ_awaddr), .awvalid(YZ_awvalid), .awready(YZ_awready),
    .wdata(YZ_wdata), .wstrb(4'hF), .wvalid(YZ_wvalid), .wready(YZ_wready),
    .bresp(YZ_bresp), .bvalid(YZ_bvalid), .bready(YZ_bready),
    .araddr(YZ_araddr), .arvalid(YZ_arvalid), .arready(YZ_arready),
    .rdata(YZ_rdata), .rresp(YZ_rresp), .rvalid(YZ_rvalid), .rready(YZ_rready)
);

`endif
