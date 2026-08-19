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
//
//  ------------------------------------------------------------------------
//  KAPSAM HARITASI  (neden 15 arayuz?)
//  ------------------------------------------------------------------------
//   KATMAN 1 - Slave uc noktalari (11)
//     1  Timer            6  UART_YZ
//     2  GPIO             7  YZ hizlandirici CSR
//     3  I2C Master       8  Data RAM      (WSTRB var)
//     4  QSPI Master      9  Instruction RAM (WSTRB var)
//     5  UART_GU         10  Boot ROM  - CPU portu        (salt okunur)
//                        11  Boot ROM  - interconnect portu (salt okunur)
//
//   KATMAN 2 - Master ve fabric (4)
//    12  CPU instruction master (OBI->AXI kopru cikisi)
//    13  CPU data master        (OBI->AXI kopru cikisi)
//    14  Instruction Splitter slave tarafi (salt okunur, kombinasyonel blok)
//    15  Interconnect S0 slave portu (WSTRB var)
//
//   NOT: Interconnect'in M0..M9 master portlari, KATMAN 1'deki slave
//   portlarinin ta kendisidir (ayni teller). Ikisini birden bind etmek
//   ayni sinyali iki kez kontrol etmek olurdu; bu yuzden bilincli olarak
//   sadece slave ucundan izleniyorlar. S0 ise baska hicbir yerde
//   kapsanmadigi icin ayrica bind edilmistir.
//=============================================================================
`ifndef AXI4LITE_BIND_SVH
`define AXI4LITE_BIND_SVH

//-----------------------------------------------------------------------------
//  Ortak parametre secimleri
//-----------------------------------------------------------------------------
//  MAX_OUTSTANDING : Cevre birimlerimiz tek islemlik basit slave'ler oldugu
//                    icin 1 ile baslayin. Yanlis alarm verirse tasarimin
//                    gercek pipeline derinligine yukseltin -- ama DAR bir
//                    limitle gecen assertion, genis limitten daha guclu bir
//                    uygunluk beyanidir. Sunumda bu degeri gerekcelendirin.
//  ERR_IS_FATAL    : 0 = say ve devam et (regresyon icin dogru secim).
//                    TB sonda axi_chk_pkg::final_report() ile toplu bakar.
//-----------------------------------------------------------------------------

//=============================================================================
//  KATMAN 1 -- SLAVE UC NOKTALARI
//=============================================================================

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

//---- 2) GPIO ------------------------------------------------------------
bind GPIO_AXI4_Lite axi4lite_protocol_checker #(
    .NAME("GPIO"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(1)
) u_axi_chk (
    .aclk(clk_i), .aresetn(rst_n),
    .awaddr(awaddr), .awvalid(awvalid), .awready(awready),
    .wdata(wdata), .wstrb(4'hF), .wvalid(wvalid), .wready(wready),
    .bresp(bresp), .bvalid(bvalid), .bready(bready),
    .araddr(araddr), .arvalid(arvalid), .arready(arready),
    .rdata(rdata), .rresp(rresp), .rvalid(rvalid), .rready(rready)
);

//---- 3) I2C Master ------------------------------------------------------
bind I2C_Master_AXI4_Lite axi4lite_protocol_checker #(
    .NAME("I2C"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(1)
) u_axi_chk (
    .aclk(clk_i), .aresetn(rst_n),
    .awaddr(awaddr), .awvalid(awvalid), .awready(awready),
    .wdata(wdata), .wstrb(4'hF), .wvalid(wvalid), .wready(wready),
    .bresp(bresp), .bvalid(bvalid), .bready(bready),
    .araddr(araddr), .arvalid(arvalid), .arready(arready),
    .rdata(rdata), .rresp(rresp), .rvalid(rvalid), .rready(rready)
);

//---- 4) QSPI Master -----------------------------------------------------
bind QSPI_Master_AXI4_Lite axi4lite_protocol_checker #(
    .NAME("QSPI"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(1)
) u_axi_chk (
    .aclk(clk_i), .aresetn(rst_n),
    .awaddr(awaddr), .awvalid(awvalid), .awready(awready),
    .wdata(wdata), .wstrb(4'hF), .wvalid(wvalid), .wready(wready),
    .bresp(bresp), .bvalid(bvalid), .bready(bready),
    .araddr(araddr), .arvalid(arvalid), .arready(arready),
    .rdata(rdata), .rresp(rresp), .rvalid(rvalid), .rready(rready)
);

//---- 5) UART Genel Kullanim --------------------------------------------
bind UART_GU_AXI4_Lite axi4lite_protocol_checker #(
    .NAME("UART_GU"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(1)
) u_axi_chk (
    .aclk(clk), .aresetn(rst_n),
    .awaddr(awaddr), .awvalid(awvalid), .awready(awready),
    .wdata(wdata), .wstrb(4'hF), .wvalid(wvalid), .wready(wready),
    .bresp(bresp), .bvalid(bvalid), .bready(bready),
    .araddr(araddr), .arvalid(arvalid), .arready(arready),
    .rdata(rdata), .rresp(rresp), .rvalid(rvalid), .rready(rready)
);

//---- 6) UART YZ ---------------------------------------------------------
bind UART_YZ_AXI4_Lite axi4lite_protocol_checker #(
    .NAME("UART_YZ"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(1)
) u_axi_chk (
    .aclk(clk), .aresetn(rst_n),
    .awaddr(awaddr), .awvalid(awvalid), .awready(awready),
    .wdata(wdata), .wstrb(4'hF), .wvalid(wvalid), .wready(wready),
    .bresp(bresp), .bvalid(bvalid), .bready(bready),
    .araddr(araddr), .arvalid(arvalid), .arready(arready),
    .rdata(rdata), .rresp(rresp), .rvalid(rvalid), .rready(rready)
);

//---- 7) YZ Hizlandirici CSR  (YZ_ onekli portlar) -----------------------
//  ZORUNLU MADDE: sartname 5.2-3 hizlandiricinin AXI arayuzunu ismen sayar.
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

//---- 8) Data RAM  (WSTRB VAR) -------------------------------------------
bind data_bram_axi_ctrl axi4lite_protocol_checker #(
    .NAME("DATA_RAM"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(1),
    .REQUIRE_FULL_WSTRB(0), .MAX_OUTSTANDING(1)
) u_axi_chk (
    .aclk(clk_i), .aresetn(rst_n),
    .awaddr(axi_data_bram_awaddr), .awvalid(axi_data_bram_awvalid), .awready(axi_data_bram_awready),
    .wdata(axi_data_bram_wdata), .wstrb(axi_data_bram_wstrb),
    .wvalid(axi_data_bram_wvalid), .wready(axi_data_bram_wready),
    .bresp(axi_data_bram_bresp), .bvalid(axi_data_bram_bvalid), .bready(axi_data_bram_bready),
    .araddr(axi_data_bram_araddr), .arvalid(axi_data_bram_arvalid), .arready(axi_data_bram_arready),
    .rdata(axi_data_bram_rdata), .rresp(axi_data_bram_rresp),
    .rvalid(axi_data_bram_rvalid), .rready(axi_data_bram_rready)
);

//---- 9) Instruction RAM  (WSTRB VAR) ------------------------------------
bind instr_bram_axi_ctrl axi4lite_protocol_checker #(
    .NAME("INSTR_RAM"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(1),
    .REQUIRE_FULL_WSTRB(0), .MAX_OUTSTANDING(1)
) u_axi_chk (
    .aclk(clk_i), .aresetn(rst_n),
    .awaddr(axi_instr_bram_awaddr), .awvalid(axi_instr_bram_awvalid), .awready(axi_instr_bram_awready),
    .wdata(axi_instr_bram_wdata), .wstrb(axi_instr_bram_wstrb),
    .wvalid(axi_instr_bram_wvalid), .wready(axi_instr_bram_wready),
    .bresp(axi_instr_bram_bresp), .bvalid(axi_instr_bram_bvalid), .bready(axi_instr_bram_bready),
    .araddr(axi_instr_bram_araddr), .arvalid(axi_instr_bram_arvalid), .arready(axi_instr_bram_arready),
    .rdata(axi_instr_bram_rdata), .rresp(axi_instr_bram_rresp),
    .rvalid(axi_instr_bram_rvalid), .rready(axi_instr_bram_rready)
);

//---- 10) Boot ROM  -- CPU portu  (SALT OKUNUR) --------------------------
bind boot_rom_axi_ctrl axi4lite_protocol_checker #(
    .NAME("BOOTROM_CPU"), .HAS_WRITE(0), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(1)
) u_axi_chk_cpu (
    .aclk(clk_i), .aresetn(rst_n),
    // yazma kanali bu arayuzde YOK -> sabitlenir, HAS_WRITE(0) ile assertion'lar kapali
    .awaddr(32'h0), .awvalid(1'b0), .awready(1'b0),
    .wdata(32'h0), .wstrb(4'h0), .wvalid(1'b0), .wready(1'b0),
    .bresp(2'b00), .bvalid(1'b0), .bready(1'b0),
    .araddr(axi_boot_rom_araddr), .arvalid(axi_boot_rom_arvalid), .arready(axi_boot_rom_arready),
    .rdata(axi_boot_rom_rdata), .rresp(axi_boot_rom_rresp),
    .rvalid(axi_boot_rom_rvalid), .rready(axi_boot_rom_rready)
);

//---- 11) Boot ROM  -- interconnect portu  (SALT OKUNUR) -----------------
bind boot_rom_axi_ctrl axi4lite_protocol_checker #(
    .NAME("BOOTROM_ICN"), .HAS_WRITE(0), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(1)
) u_axi_chk_icn (
    .aclk(clk_i), .aresetn(rst_n),
    .awaddr(32'h0), .awvalid(1'b0), .awready(1'b0),
    .wdata(32'h0), .wstrb(4'h0), .wvalid(1'b0), .wready(1'b0),
    .bresp(2'b00), .bvalid(1'b0), .bready(1'b0),
    .araddr(axi_boot_rom_interconnect_araddr),
    .arvalid(axi_boot_rom_interconnect_arvalid),
    .arready(axi_boot_rom_interconnect_arready),
    .rdata(axi_boot_rom_interconnect_rdata),
    .rresp(axi_boot_rom_interconnect_rresp),
    .rvalid(axi_boot_rom_interconnect_rvalid),
    .rready(axi_boot_rom_interconnect_rready)
);

//=============================================================================
//  KATMAN 2 -- MASTER VE FABRIC
//=============================================================================

//---- 12) CPU instruction master (SALT OKUNUR) --------------------------
//  Komut getirme yolu yalnizca okuma yapar. Wrapper'da yazma kanali
//  portlari var ama Instr_Splitter salt-okunur oldugu icin awready/wready/
//  bvalid/bresp girisleri HIC SURULMEZ (Z). Bu yuzden HAS_WRITE(0) ve
//  yazma kanali sabitlenir.
bind cv32e40p_obi_to_axi_wrapper axi4lite_protocol_checker #(
    .NAME("CPU_INSTR_M"), .HAS_WRITE(0), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(2)
) u_axi_chk_instr (
    .aclk(clk_i), .aresetn(rst_ni),
    .awaddr(32'h0), .awvalid(1'b0), .awready(1'b0),
    .wdata(32'h0), .wstrb(4'h0), .wvalid(1'b0), .wready(1'b0),
    .bresp(2'b00), .bvalid(1'b0), .bready(1'b0),
    .araddr(axi_instr_araddr), .arvalid(axi_instr_arvalid), .arready(axi_instr_arready),
    .rdata(axi_instr_rdata), .rresp(axi_instr_rresp),
    .rvalid(axi_instr_rvalid), .rready(axi_instr_rready)
);

//---- 13) CPU data master ------------------------------------------------
bind cv32e40p_obi_to_axi_wrapper axi4lite_protocol_checker #(
    .NAME("CPU_DATA_M"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(1),
    .MAX_OUTSTANDING(2)
) u_axi_chk_data (
    .aclk(clk_i), .aresetn(rst_ni),
    .awaddr(axi_data_awaddr), .awvalid(axi_data_awvalid), .awready(axi_data_awready),
    .wdata(axi_data_wdata), .wstrb(axi_data_wstrb),
    .wvalid(axi_data_wvalid), .wready(axi_data_wready),
    .bresp(axi_data_bresp), .bvalid(axi_data_bvalid), .bready(axi_data_bready),
    .araddr(axi_data_araddr), .arvalid(axi_data_arvalid), .arready(axi_data_arready),
    .rdata(axi_data_rdata), .rresp(axi_data_rresp),
    .rvalid(axi_data_rvalid), .rready(axi_data_rready)
);

//---- 14) Instruction Splitter -- slave tarafi (SALT OKUNUR) -------------
//  Instr_Splitter tamamen KOMBINASYONELdir (kendi saat/reset portu yok),
//  bu yuzden checker top_module seviyesinden hiyerarsik referansla baglanir.
bind top_module axi4lite_protocol_checker #(
    .NAME("SPLITTER_S"), .HAS_WRITE(0), .HAS_READ(1), .HAS_WSTRB(0),
    .MAX_OUTSTANDING(2)
) u_axi_chk_splitter (
    .aclk(clk_i), .aresetn(rst_ni),
    .awaddr(32'h0), .awvalid(1'b0), .awready(1'b0),
    .wdata(32'h0), .wstrb(4'h0), .wvalid(1'b0), .wready(1'b0),
    .bresp(2'b00), .bvalid(1'b0), .bready(1'b0),
    .araddr (instr_splitter_inst.axi_araddr),
    .arvalid(instr_splitter_inst.axi_arvalid),
    .arready(instr_splitter_inst.axi_arready),
    .rdata  (instr_splitter_inst.axi_rdata),
    .rresp  (instr_splitter_inst.axi_rresp),
    .rvalid (instr_splitter_inst.axi_rvalid),
    .rready (instr_splitter_inst.axi_rready)
);

//---- 15) Interconnect S0 slave portu (WSTRB VAR) ------------------------
bind AXI4_Interconnect axi4lite_protocol_checker #(
    .NAME("ICN_S0"), .HAS_WRITE(1), .HAS_READ(1), .HAS_WSTRB(1),
    .REQUIRE_FULL_WSTRB(0), .MAX_OUTSTANDING(2)
) u_axi_chk_s0 (
    .aclk(clk_i), .aresetn(rst_ni),
    .awaddr(axi_s0_awaddr), .awvalid(axi_s0_awvalid), .awready(axi_s0_awready),
    .wdata(axi_s0_wdata), .wstrb(axi_s0_wstrb),
    .wvalid(axi_s0_wvalid), .wready(axi_s0_wready),
    .bresp(axi_s0_bresp), .bvalid(axi_s0_bvalid), .bready(axi_s0_bready),
    .araddr(axi_s0_araddr), .arvalid(axi_s0_arvalid), .arready(axi_s0_arready),
    .rdata(axi_s0_rdata), .rresp(axi_s0_rresp),
    .rvalid(axi_s0_rvalid), .rready(axi_s0_rready)
);

`endif
