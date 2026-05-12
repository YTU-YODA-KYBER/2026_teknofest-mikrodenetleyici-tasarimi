// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat May  9 17:15:06 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_QSPI_Master_AXI4_Lite_0_0/design_1_QSPI_Master_AXI4_Lite_0_0_sim_netlist.v
// Design      : design_1_QSPI_Master_AXI4_Lite_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_QSPI_Master_AXI4_Lite_0_0,QSPI_Master_AXI4_Lite,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "QSPI_Master_AXI4_Lite,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_QSPI_Master_AXI4_Lite_0_0
   (clk_i,
    rst_n,
    awaddr,
    awvalid,
    awready,
    wdata,
    wvalid,
    wready,
    bresp,
    bvalid,
    bready,
    araddr,
    arvalid,
    arready,
    rready,
    rdata,
    rresp,
    rvalid,
    QSPI_SCLK,
    QSPI_CS,
    QSPI_IO0,
    QSPI_IO1,
    QSPI_IO2,
    QSPI_IO3);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk_i CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk_i, FREQ_TOLERANCE_HZ 0, ASSOCIATED_BUSIF interface_aximm, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, ASSOCIATED_RESET rst_n, INSERT_VIP 0" *) input rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm AWADDR" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interface_aximm, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [31:0]awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm AWVALID" *) input awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm AWREADY" *) output awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm WDATA" *) input [31:0]wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm WVALID" *) input wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm WREADY" *) output wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm BRESP" *) output [1:0]bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm BVALID" *) output bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm BREADY" *) input bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm ARADDR" *) input [31:0]araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm ARVALID" *) input arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm ARREADY" *) output arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm RREADY" *) input rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm RDATA" *) output [31:0]rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm RRESP" *) output [1:0]rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm RVALID" *) output rvalid;
  output QSPI_SCLK;
  output QSPI_CS;
  inout QSPI_IO0;
  inout QSPI_IO1;
  inout QSPI_IO2;
  inout QSPI_IO3;

  wire \<const0> ;
  wire QSPI_CS;
  wire QSPI_IO0;
  wire QSPI_IO0_INST_0_i_1_n_0;
  wire QSPI_IO1;
  wire QSPI_IO1_INST_0_i_1_n_0;
  wire QSPI_IO2;
  wire QSPI_IO2_INST_0_i_1_n_0;
  wire QSPI_IO3;
  wire QSPI_SCLK;
  wire [31:0]araddr;
  wire arready;
  wire arvalid;
  wire [31:0]awaddr;
  wire awready;
  wire awvalid;
  wire bready;
  wire bvalid;
  wire clk_i;
  wire inst_n_0;
  wire inst_n_7;
  wire inst_n_8;
  wire inst_n_9;
  wire [31:0]rdata;
  wire rready;
  wire rst_n;
  wire rvalid;
  wire [31:0]wdata;
  wire wvalid;

  assign bresp[1] = \<const0> ;
  assign bresp[0] = \<const0> ;
  assign rresp[1] = \<const0> ;
  assign rresp[0] = \<const0> ;
  assign wready = awready;
  GND GND
       (.G(\<const0> ));
  FDCE #(
    .INIT(1'b1)) 
    QSPI_IO0_INST_0_i_1
       (.C(clk_i),
        .CE(1'b1),
        .CLR(inst_n_0),
        .D(inst_n_7),
        .Q(QSPI_IO0_INST_0_i_1_n_0));
  FDCE #(
    .INIT(1'b1)) 
    QSPI_IO1_INST_0_i_1
       (.C(clk_i),
        .CE(1'b1),
        .CLR(inst_n_0),
        .D(inst_n_9),
        .Q(QSPI_IO1_INST_0_i_1_n_0));
  FDCE #(
    .INIT(1'b1)) 
    QSPI_IO2_INST_0_i_1
       (.C(clk_i),
        .CE(1'b1),
        .CLR(inst_n_0),
        .D(inst_n_8),
        .Q(QSPI_IO2_INST_0_i_1_n_0));
  design_1_QSPI_Master_AXI4_Lite_0_0_QSPI_Master_AXI4_Lite inst
       (.QSPI_CS_reg_0(QSPI_CS),
        .QSPI_IO0(QSPI_IO0),
        .QSPI_IO0_INST_0_i_1(QSPI_IO0_INST_0_i_1_n_0),
        .QSPI_IO1(QSPI_IO1),
        .QSPI_IO1_INST_0_i_1(inst_n_9),
        .QSPI_IO1_INST_0_i_1_0(QSPI_IO1_INST_0_i_1_n_0),
        .QSPI_IO2(QSPI_IO2),
        .QSPI_IO2_INST_0_i_1(inst_n_8),
        .QSPI_IO2_INST_0_i_1_0(QSPI_IO2_INST_0_i_1_n_0),
        .QSPI_IO3(QSPI_IO3),
        .QSPI_SCLK_reg_0(QSPI_SCLK),
        .araddr(araddr[7:0]),
        .arready(arready),
        .arvalid(arvalid),
        .awaddr(awaddr[7:0]),
        .awready(awready),
        .awvalid(awvalid),
        .bready(bready),
        .bvalid(bvalid),
        .clk_i(clk_i),
        .\fifo_status_reg[1]_0 (inst_n_7),
        .rdata(rdata),
        .rready(rready),
        .rst_n(rst_n),
        .rst_n_0(inst_n_0),
        .rvalid(rvalid),
        .wdata(wdata),
        .wvalid(wvalid));
endmodule

(* ORIG_REF_NAME = "QSPI_Master_AXI4_Lite" *) 
module design_1_QSPI_Master_AXI4_Lite_0_0_QSPI_Master_AXI4_Lite
   (rst_n_0,
    bvalid,
    awready,
    rvalid,
    arready,
    QSPI_CS_reg_0,
    QSPI_SCLK_reg_0,
    \fifo_status_reg[1]_0 ,
    QSPI_IO2_INST_0_i_1,
    QSPI_IO1_INST_0_i_1,
    rdata,
    QSPI_IO0,
    QSPI_IO1,
    QSPI_IO2,
    QSPI_IO3,
    clk_i,
    wdata,
    awaddr,
    rst_n,
    wvalid,
    awvalid,
    bready,
    arvalid,
    rready,
    QSPI_IO0_INST_0_i_1,
    QSPI_IO2_INST_0_i_1_0,
    QSPI_IO1_INST_0_i_1_0,
    araddr);
  output rst_n_0;
  output bvalid;
  output awready;
  output rvalid;
  output arready;
  output QSPI_CS_reg_0;
  output QSPI_SCLK_reg_0;
  output \fifo_status_reg[1]_0 ;
  output QSPI_IO2_INST_0_i_1;
  output QSPI_IO1_INST_0_i_1;
  output [31:0]rdata;
  inout QSPI_IO0;
  inout QSPI_IO1;
  inout QSPI_IO2;
  inout QSPI_IO3;
  input clk_i;
  input [31:0]wdata;
  input [7:0]awaddr;
  input rst_n;
  input wvalid;
  input awvalid;
  input bready;
  input arvalid;
  input rready;
  input QSPI_IO0_INST_0_i_1;
  input QSPI_IO2_INST_0_i_1_0;
  input QSPI_IO1_INST_0_i_1_0;
  input [7:0]araddr;

  wire [0:0]QSPI_ADR;
  wire \QSPI_ADR_reg_n_0_[0] ;
  wire \QSPI_ADR_reg_n_0_[10] ;
  wire \QSPI_ADR_reg_n_0_[11] ;
  wire \QSPI_ADR_reg_n_0_[12] ;
  wire \QSPI_ADR_reg_n_0_[13] ;
  wire \QSPI_ADR_reg_n_0_[14] ;
  wire \QSPI_ADR_reg_n_0_[15] ;
  wire \QSPI_ADR_reg_n_0_[16] ;
  wire \QSPI_ADR_reg_n_0_[17] ;
  wire \QSPI_ADR_reg_n_0_[18] ;
  wire \QSPI_ADR_reg_n_0_[19] ;
  wire \QSPI_ADR_reg_n_0_[1] ;
  wire \QSPI_ADR_reg_n_0_[20] ;
  wire \QSPI_ADR_reg_n_0_[21] ;
  wire \QSPI_ADR_reg_n_0_[22] ;
  wire \QSPI_ADR_reg_n_0_[23] ;
  wire \QSPI_ADR_reg_n_0_[24] ;
  wire \QSPI_ADR_reg_n_0_[25] ;
  wire \QSPI_ADR_reg_n_0_[26] ;
  wire \QSPI_ADR_reg_n_0_[27] ;
  wire \QSPI_ADR_reg_n_0_[28] ;
  wire \QSPI_ADR_reg_n_0_[29] ;
  wire \QSPI_ADR_reg_n_0_[2] ;
  wire \QSPI_ADR_reg_n_0_[30] ;
  wire \QSPI_ADR_reg_n_0_[31] ;
  wire \QSPI_ADR_reg_n_0_[3] ;
  wire \QSPI_ADR_reg_n_0_[4] ;
  wire \QSPI_ADR_reg_n_0_[5] ;
  wire \QSPI_ADR_reg_n_0_[6] ;
  wire \QSPI_ADR_reg_n_0_[7] ;
  wire \QSPI_ADR_reg_n_0_[8] ;
  wire \QSPI_ADR_reg_n_0_[9] ;
  wire [0:0]QSPI_CCR;
  wire \QSPI_CCR[31]_i_2_n_0 ;
  wire \QSPI_CCR_reg_n_0_[0] ;
  wire \QSPI_CCR_reg_n_0_[10] ;
  wire \QSPI_CCR_reg_n_0_[11] ;
  wire \QSPI_CCR_reg_n_0_[12] ;
  wire \QSPI_CCR_reg_n_0_[13] ;
  wire \QSPI_CCR_reg_n_0_[14] ;
  wire \QSPI_CCR_reg_n_0_[15] ;
  wire \QSPI_CCR_reg_n_0_[16] ;
  wire \QSPI_CCR_reg_n_0_[17] ;
  wire \QSPI_CCR_reg_n_0_[18] ;
  wire \QSPI_CCR_reg_n_0_[19] ;
  wire \QSPI_CCR_reg_n_0_[1] ;
  wire \QSPI_CCR_reg_n_0_[20] ;
  wire \QSPI_CCR_reg_n_0_[21] ;
  wire \QSPI_CCR_reg_n_0_[22] ;
  wire \QSPI_CCR_reg_n_0_[23] ;
  wire \QSPI_CCR_reg_n_0_[24] ;
  wire \QSPI_CCR_reg_n_0_[2] ;
  wire \QSPI_CCR_reg_n_0_[3] ;
  wire \QSPI_CCR_reg_n_0_[4] ;
  wire \QSPI_CCR_reg_n_0_[5] ;
  wire \QSPI_CCR_reg_n_0_[6] ;
  wire \QSPI_CCR_reg_n_0_[7] ;
  wire QSPI_CS_i_1_n_0;
  wire QSPI_CS_i_2_n_0;
  wire QSPI_CS_reg_0;
  wire [0:0]QSPI_DR;
  wire \QSPI_DR[31]_i_2_n_0 ;
  wire \QSPI_DR_read[31]_i_1_n_0 ;
  wire \QSPI_DR_read_reg_n_0_[0] ;
  wire \QSPI_DR_read_reg_n_0_[10] ;
  wire \QSPI_DR_read_reg_n_0_[11] ;
  wire \QSPI_DR_read_reg_n_0_[12] ;
  wire \QSPI_DR_read_reg_n_0_[13] ;
  wire \QSPI_DR_read_reg_n_0_[14] ;
  wire \QSPI_DR_read_reg_n_0_[15] ;
  wire \QSPI_DR_read_reg_n_0_[16] ;
  wire \QSPI_DR_read_reg_n_0_[17] ;
  wire \QSPI_DR_read_reg_n_0_[18] ;
  wire \QSPI_DR_read_reg_n_0_[19] ;
  wire \QSPI_DR_read_reg_n_0_[1] ;
  wire \QSPI_DR_read_reg_n_0_[20] ;
  wire \QSPI_DR_read_reg_n_0_[21] ;
  wire \QSPI_DR_read_reg_n_0_[22] ;
  wire \QSPI_DR_read_reg_n_0_[23] ;
  wire \QSPI_DR_read_reg_n_0_[24] ;
  wire \QSPI_DR_read_reg_n_0_[25] ;
  wire \QSPI_DR_read_reg_n_0_[26] ;
  wire \QSPI_DR_read_reg_n_0_[27] ;
  wire \QSPI_DR_read_reg_n_0_[28] ;
  wire \QSPI_DR_read_reg_n_0_[29] ;
  wire \QSPI_DR_read_reg_n_0_[2] ;
  wire \QSPI_DR_read_reg_n_0_[30] ;
  wire \QSPI_DR_read_reg_n_0_[31] ;
  wire \QSPI_DR_read_reg_n_0_[3] ;
  wire \QSPI_DR_read_reg_n_0_[4] ;
  wire \QSPI_DR_read_reg_n_0_[5] ;
  wire \QSPI_DR_read_reg_n_0_[6] ;
  wire \QSPI_DR_read_reg_n_0_[7] ;
  wire \QSPI_DR_read_reg_n_0_[8] ;
  wire \QSPI_DR_read_reg_n_0_[9] ;
  wire \QSPI_DR_reg_n_0_[0] ;
  wire \QSPI_DR_reg_n_0_[10] ;
  wire \QSPI_DR_reg_n_0_[11] ;
  wire \QSPI_DR_reg_n_0_[12] ;
  wire \QSPI_DR_reg_n_0_[13] ;
  wire \QSPI_DR_reg_n_0_[14] ;
  wire \QSPI_DR_reg_n_0_[15] ;
  wire \QSPI_DR_reg_n_0_[16] ;
  wire \QSPI_DR_reg_n_0_[17] ;
  wire \QSPI_DR_reg_n_0_[18] ;
  wire \QSPI_DR_reg_n_0_[19] ;
  wire \QSPI_DR_reg_n_0_[1] ;
  wire \QSPI_DR_reg_n_0_[20] ;
  wire \QSPI_DR_reg_n_0_[21] ;
  wire \QSPI_DR_reg_n_0_[22] ;
  wire \QSPI_DR_reg_n_0_[23] ;
  wire \QSPI_DR_reg_n_0_[24] ;
  wire \QSPI_DR_reg_n_0_[25] ;
  wire \QSPI_DR_reg_n_0_[26] ;
  wire \QSPI_DR_reg_n_0_[27] ;
  wire \QSPI_DR_reg_n_0_[28] ;
  wire \QSPI_DR_reg_n_0_[29] ;
  wire \QSPI_DR_reg_n_0_[2] ;
  wire \QSPI_DR_reg_n_0_[30] ;
  wire \QSPI_DR_reg_n_0_[31] ;
  wire \QSPI_DR_reg_n_0_[3] ;
  wire \QSPI_DR_reg_n_0_[4] ;
  wire \QSPI_DR_reg_n_0_[5] ;
  wire \QSPI_DR_reg_n_0_[6] ;
  wire \QSPI_DR_reg_n_0_[7] ;
  wire \QSPI_DR_reg_n_0_[8] ;
  wire \QSPI_DR_reg_n_0_[9] ;
  wire [0:0]QSPI_FCR;
  wire \QSPI_FCR_reg_n_0_[10] ;
  wire \QSPI_FCR_reg_n_0_[11] ;
  wire \QSPI_FCR_reg_n_0_[12] ;
  wire \QSPI_FCR_reg_n_0_[13] ;
  wire \QSPI_FCR_reg_n_0_[14] ;
  wire \QSPI_FCR_reg_n_0_[15] ;
  wire \QSPI_FCR_reg_n_0_[16] ;
  wire \QSPI_FCR_reg_n_0_[17] ;
  wire \QSPI_FCR_reg_n_0_[18] ;
  wire \QSPI_FCR_reg_n_0_[19] ;
  wire \QSPI_FCR_reg_n_0_[1] ;
  wire \QSPI_FCR_reg_n_0_[20] ;
  wire \QSPI_FCR_reg_n_0_[21] ;
  wire \QSPI_FCR_reg_n_0_[22] ;
  wire \QSPI_FCR_reg_n_0_[23] ;
  wire \QSPI_FCR_reg_n_0_[24] ;
  wire \QSPI_FCR_reg_n_0_[25] ;
  wire \QSPI_FCR_reg_n_0_[26] ;
  wire \QSPI_FCR_reg_n_0_[27] ;
  wire \QSPI_FCR_reg_n_0_[28] ;
  wire \QSPI_FCR_reg_n_0_[29] ;
  wire \QSPI_FCR_reg_n_0_[2] ;
  wire \QSPI_FCR_reg_n_0_[30] ;
  wire \QSPI_FCR_reg_n_0_[31] ;
  wire \QSPI_FCR_reg_n_0_[3] ;
  wire \QSPI_FCR_reg_n_0_[4] ;
  wire \QSPI_FCR_reg_n_0_[5] ;
  wire \QSPI_FCR_reg_n_0_[6] ;
  wire \QSPI_FCR_reg_n_0_[7] ;
  wire \QSPI_FCR_reg_n_0_[8] ;
  wire \QSPI_FCR_reg_n_0_[9] ;
  wire QSPI_IO0;
  wire QSPI_IO0_INST_0_i_1;
  wire QSPI_IO1;
  wire QSPI_IO1_INST_0_i_1;
  wire QSPI_IO1_INST_0_i_1_0;
  wire QSPI_IO1_INST_0_i_3_n_0;
  wire QSPI_IO2;
  wire QSPI_IO2_INST_0_i_1;
  wire QSPI_IO2_INST_0_i_1_0;
  wire QSPI_IO3;
  wire QSPI_SCLK_i_1_n_0;
  wire QSPI_SCLK_reg_0;
  wire \QSPI_STA[1]_i_1_n_0 ;
  wire \QSPI_STA[4]_i_1_n_0 ;
  wire \QSPI_STA[5]_i_1_n_0 ;
  wire \QSPI_STA[6]_i_1_n_0 ;
  wire \QSPI_STA[7]_i_1_n_0 ;
  wire \QSPI_STA[8]_i_1_n_0 ;
  wire \QSPI_STA[9]_i_1_n_0 ;
  wire \QSPI_STA_reg_n_0_[1] ;
  wire \QSPI_STA_reg_n_0_[4] ;
  wire \QSPI_STA_reg_n_0_[5] ;
  wire \QSPI_STA_reg_n_0_[7] ;
  wire \QSPI_STA_reg_n_0_[8] ;
  wire \QSPI_STA_reg_n_0_[9] ;
  wire address;
  wire address_i_1_n_0;
  wire address_i_2_n_0;
  wire [7:0]araddr;
  wire arready;
  wire arready_i_1_n_0;
  wire arvalid;
  wire [7:0]awaddr;
  wire awready;
  wire awready_i_1_n_0;
  wire awvalid;
  wire bready;
  wire busy0;
  wire busy_i_1_n_0;
  wire bvalid;
  wire bvalid_i_1_n_0;
  wire clk_i;
  wire [1:0]data2;
  wire \data_byte_size[0]_i_1_n_0 ;
  wire \data_byte_size[1]_i_1_n_0 ;
  wire \data_byte_size[2]_i_1_n_0 ;
  wire \data_byte_size[3]_i_1_n_0 ;
  wire \data_byte_size[3]_i_2_n_0 ;
  wire \data_byte_size[4]_i_1_n_0 ;
  wire \data_byte_size[4]_i_2_n_0 ;
  wire \data_byte_size[5]_i_1_n_0 ;
  wire \data_byte_size[5]_i_2_n_0 ;
  wire \data_byte_size[6]_i_1_n_0 ;
  wire \data_byte_size[6]_i_2_n_0 ;
  wire \data_byte_size[7]_i_1_n_0 ;
  wire \data_byte_size[7]_i_2_n_0 ;
  wire \data_byte_size[7]_i_3_n_0 ;
  wire \data_byte_size[7]_i_4_n_0 ;
  wire \data_byte_size[7]_i_5_n_0 ;
  wire \data_mode[0]_i_1_n_0 ;
  wire \data_mode[1]_i_1_n_0 ;
  wire \data_mode[2]_i_1_n_0 ;
  wire \data_mode[2]_i_2_n_0 ;
  wire [2:0]data_mode__0;
  wire \dummy_cycle[0]_i_1_n_0 ;
  wire \dummy_cycle[1]_i_1_n_0 ;
  wire \dummy_cycle[2]_i_1_n_0 ;
  wire \dummy_cycle[3]_i_1_n_0 ;
  wire \dummy_cycle[4]_i_1_n_0 ;
  wire \dummy_cycle[4]_i_2_n_0 ;
  wire \dummy_cycle[4]_i_3_n_0 ;
  wire \dummy_cycle[4]_i_4_n_0 ;
  wire \dummy_cycle[4]_i_5_n_0 ;
  wire [4:0]dummy_cycle__0;
  wire [1:0]fifo_error;
  wire \fifo_error[0]_i_1_n_0 ;
  wire \fifo_error[1]_i_1_n_0 ;
  wire \fifo_rx_cnt[0]_i_1_n_0 ;
  wire \fifo_rx_cnt[1]_i_1_n_0 ;
  wire \fifo_rx_cnt[2]_i_1_n_0 ;
  wire \fifo_rx_cnt[3]_i_1_n_0 ;
  wire \fifo_rx_cnt[4]_i_1_n_0 ;
  wire \fifo_rx_cnt[4]_i_2_n_0 ;
  wire \fifo_rx_cnt[4]_i_3_n_0 ;
  wire \fifo_rx_cnt[5]_i_1_n_0 ;
  wire \fifo_rx_cnt[5]_i_2_n_0 ;
  wire \fifo_rx_cnt[5]_i_3_n_0 ;
  wire \fifo_rx_cnt[6]_i_1_n_0 ;
  wire \fifo_rx_cnt[6]_i_2_n_0 ;
  wire \fifo_rx_cnt[6]_i_3_n_0 ;
  wire \fifo_rx_cnt[6]_i_4_n_0 ;
  wire \fifo_rx_cnt_reg_n_0_[0] ;
  wire \fifo_rx_cnt_reg_n_0_[1] ;
  wire \fifo_rx_cnt_reg_n_0_[2] ;
  wire \fifo_rx_cnt_reg_n_0_[3] ;
  wire \fifo_rx_cnt_reg_n_0_[4] ;
  wire \fifo_rx_cnt_reg_n_0_[5] ;
  wire \fifo_rx_cnt_reg_n_0_[6] ;
  wire fifo_rx_pull_data;
  wire fifo_rx_pull_data_i_1_n_0;
  wire [31:0]fifo_rx_rdata;
  wire [31:0]fifo_rx_rdata0;
  wire [31:0]fifo_rx_wdata;
  wire \fifo_rx_wdata[31]_i_1_n_0 ;
  wire fifo_rx_wr_en;
  wire fifo_rx_wr_en_i_1_n_0;
  wire \fifo_status[0]_i_1_n_0 ;
  wire \fifo_status[1]_i_1_n_0 ;
  wire \fifo_status[1]_i_2_n_0 ;
  wire \fifo_status[1]_i_3_n_0 ;
  wire \fifo_status_reg[1]_0 ;
  wire \fifo_status_reg_n_0_[0] ;
  wire \fifo_status_reg_n_0_[1] ;
  wire \fifo_tx_cnt[0]_i_1_n_0 ;
  wire \fifo_tx_cnt[1]_i_1_n_0 ;
  wire \fifo_tx_cnt[2]_i_1_n_0 ;
  wire \fifo_tx_cnt[3]_i_1_n_0 ;
  wire \fifo_tx_cnt[4]_i_1_n_0 ;
  wire \fifo_tx_cnt[4]_i_2_n_0 ;
  wire \fifo_tx_cnt[4]_i_3_n_0 ;
  wire \fifo_tx_cnt[5]_i_1_n_0 ;
  wire \fifo_tx_cnt[5]_i_2_n_0 ;
  wire \fifo_tx_cnt[5]_i_3_n_0 ;
  wire \fifo_tx_cnt[6]_i_1_n_0 ;
  wire \fifo_tx_cnt[6]_i_2_n_0 ;
  wire \fifo_tx_cnt[6]_i_3_n_0 ;
  wire \fifo_tx_cnt[6]_i_4_n_0 ;
  wire \fifo_tx_cnt_reg_n_0_[0] ;
  wire \fifo_tx_cnt_reg_n_0_[1] ;
  wire \fifo_tx_cnt_reg_n_0_[2] ;
  wire \fifo_tx_cnt_reg_n_0_[3] ;
  wire \fifo_tx_cnt_reg_n_0_[4] ;
  wire \fifo_tx_cnt_reg_n_0_[5] ;
  wire \fifo_tx_cnt_reg_n_0_[6] ;
  wire fifo_tx_push_data;
  wire fifo_tx_push_data_i_1_n_0;
  wire [31:0]fifo_tx_rdata;
  wire [31:0]fifo_tx_rdata0;
  wire [31:0]fifo_tx_wdata;
  wire \fifo_tx_wdata[31]_i_1_n_0 ;
  wire fifo_tx_wr_en;
  wire fifo_tx_wr_en0;
  wire fifo_tx_wr_en_i_1_n_0;
  wire [7:0]instr_shadow;
  wire \instr_shadow[7]_i_1_n_0 ;
  wire \instr_shadow[7]_i_2_n_0 ;
  wire \instr_shadow[7]_i_3_n_0 ;
  wire \instr_shadow[7]_i_4_n_0 ;
  wire io0_val_tristate_oe_i_1_n_0;
  wire io0_val_tristate_oe_i_2_n_0;
  wire io0_val_tristate_oe_i_3_n_0;
  wire io0_val_tristate_oe_i_4_n_0;
  wire io0_val_tristate_oe_reg_n_0;
  wire io1_val_tristate_oe_i_1_n_0;
  wire io1_val_tristate_oe_i_2_n_0;
  wire io1_val_tristate_oe_i_3_n_0;
  wire io1_val_tristate_oe_reg_n_0;
  wire io2_val_tristate_oe_i_1_n_0;
  wire io2_val_tristate_oe_i_2_n_0;
  wire io2_val_tristate_oe_i_3_n_0;
  wire io2_val_tristate_oe_reg_n_0;
  wire io3_val_tristate_oe_i_1_n_0;
  wire io3_val_tristate_oe_reg_n_0;
  wire [1:0]p_0_in;
  wire p_0_in0;
  wire p_0_in27_in;
  wire [5:0]p_0_in_0;
  wire p_11_in;
  wire p_1_in;
  wire [1:1]p_2_in;
  wire prscl_cnt1;
  wire prscl_cnt1_carry__0_i_1_n_0;
  wire prscl_cnt1_carry__0_i_2_n_0;
  wire prscl_cnt1_carry__0_i_3_n_0;
  wire prscl_cnt1_carry__0_i_4_n_0;
  wire prscl_cnt1_carry__0_n_0;
  wire prscl_cnt1_carry__0_n_1;
  wire prscl_cnt1_carry__0_n_2;
  wire prscl_cnt1_carry__0_n_3;
  wire prscl_cnt1_carry__1_i_1_n_0;
  wire prscl_cnt1_carry__1_i_2_n_0;
  wire prscl_cnt1_carry__1_i_3_n_0;
  wire prscl_cnt1_carry__1_n_2;
  wire prscl_cnt1_carry__1_n_3;
  wire prscl_cnt1_carry_i_1_n_0;
  wire prscl_cnt1_carry_i_2_n_0;
  wire prscl_cnt1_carry_i_3_n_0;
  wire prscl_cnt1_carry_i_4_n_0;
  wire prscl_cnt1_carry_i_5_n_0;
  wire prscl_cnt1_carry_i_6_n_0;
  wire prscl_cnt1_carry_i_7_n_0;
  wire prscl_cnt1_carry_n_0;
  wire prscl_cnt1_carry_n_1;
  wire prscl_cnt1_carry_n_2;
  wire prscl_cnt1_carry_n_3;
  wire \prscl_cnt[2]_i_1_n_0 ;
  wire \prscl_cnt[3]_i_1_n_0 ;
  wire \prscl_cnt[4]_i_1_n_0 ;
  wire \prscl_cnt[5]_i_1_n_0 ;
  wire \prscl_cnt[5]_i_2_n_0 ;
  wire [5:0]prscl_cnt_reg;
  wire qspi_falling_edge;
  wire qspi_falling_edge_i_2_n_0;
  wire qspi_falling_edge_i_3_n_0;
  wire qspi_falling_edge_i_4_n_0;
  wire qspi_falling_edge_i_5_n_0;
  wire qspi_falling_edge_i_6_n_0;
  wire qspi_falling_edge_i_7_n_0;
  wire qspi_rising_edge;
  wire qspi_rising_edge_i_1_n_0;
  wire r_w_i_1_n_0;
  wire r_w_reg_n_0;
  wire [31:0]rdata;
  wire \rdata[0]_i_1_n_0 ;
  wire \rdata[0]_i_2_n_0 ;
  wire \rdata[10]_i_1_n_0 ;
  wire \rdata[10]_i_2_n_0 ;
  wire \rdata[11]_i_1_n_0 ;
  wire \rdata[11]_i_2_n_0 ;
  wire \rdata[12]_i_1_n_0 ;
  wire \rdata[12]_i_2_n_0 ;
  wire \rdata[13]_i_1_n_0 ;
  wire \rdata[13]_i_2_n_0 ;
  wire \rdata[14]_i_1_n_0 ;
  wire \rdata[14]_i_2_n_0 ;
  wire \rdata[15]_i_1_n_0 ;
  wire \rdata[15]_i_2_n_0 ;
  wire \rdata[16]_i_1_n_0 ;
  wire \rdata[16]_i_2_n_0 ;
  wire \rdata[17]_i_1_n_0 ;
  wire \rdata[17]_i_2_n_0 ;
  wire \rdata[18]_i_1_n_0 ;
  wire \rdata[18]_i_2_n_0 ;
  wire \rdata[19]_i_1_n_0 ;
  wire \rdata[19]_i_2_n_0 ;
  wire \rdata[1]_i_1_n_0 ;
  wire \rdata[1]_i_2_n_0 ;
  wire \rdata[20]_i_1_n_0 ;
  wire \rdata[20]_i_2_n_0 ;
  wire \rdata[21]_i_1_n_0 ;
  wire \rdata[21]_i_2_n_0 ;
  wire \rdata[22]_i_1_n_0 ;
  wire \rdata[22]_i_2_n_0 ;
  wire \rdata[23]_i_1_n_0 ;
  wire \rdata[23]_i_2_n_0 ;
  wire \rdata[24]_i_1_n_0 ;
  wire \rdata[24]_i_2_n_0 ;
  wire \rdata[25]_i_1_n_0 ;
  wire \rdata[25]_i_2_n_0 ;
  wire \rdata[26]_i_1_n_0 ;
  wire \rdata[26]_i_2_n_0 ;
  wire \rdata[27]_i_1_n_0 ;
  wire \rdata[27]_i_2_n_0 ;
  wire \rdata[28]_i_1_n_0 ;
  wire \rdata[28]_i_2_n_0 ;
  wire \rdata[29]_i_1_n_0 ;
  wire \rdata[29]_i_2_n_0 ;
  wire \rdata[2]_i_1_n_0 ;
  wire \rdata[2]_i_2_n_0 ;
  wire \rdata[30]_i_1_n_0 ;
  wire \rdata[30]_i_2_n_0 ;
  wire \rdata[31]_i_1_n_0 ;
  wire \rdata[31]_i_2_n_0 ;
  wire \rdata[31]_i_3_n_0 ;
  wire \rdata[3]_i_1_n_0 ;
  wire \rdata[3]_i_2_n_0 ;
  wire \rdata[4]_i_1_n_0 ;
  wire \rdata[4]_i_2_n_0 ;
  wire \rdata[5]_i_1_n_0 ;
  wire \rdata[5]_i_2_n_0 ;
  wire \rdata[6]_i_1_n_0 ;
  wire \rdata[6]_i_2_n_0 ;
  wire \rdata[7]_i_1_n_0 ;
  wire \rdata[7]_i_2_n_0 ;
  wire \rdata[8]_i_1_n_0 ;
  wire \rdata[8]_i_2_n_0 ;
  wire \rdata[9]_i_1_n_0 ;
  wire \rdata[9]_i_2_n_0 ;
  wire rready;
  wire rst_n;
  wire rst_n_0;
  wire rvalid;
  wire rvalid_i_1_n_0;
  wire rx_pull_once_i_1_n_0;
  wire rx_pull_once_reg_n_0;
  wire [5:0]rx_rd_ptr;
  wire \rx_rd_ptr[0]_i_1_n_0 ;
  wire \rx_rd_ptr[1]_i_1_n_0 ;
  wire \rx_rd_ptr[2]_i_1_n_0 ;
  wire \rx_rd_ptr[3]_i_1_n_0 ;
  wire \rx_rd_ptr[4]_i_1_n_0 ;
  wire \rx_rd_ptr[4]_i_2_n_0 ;
  wire \rx_rd_ptr[5]_i_1_n_0 ;
  wire \rx_rd_ptr[5]_i_2_n_0 ;
  wire \rx_rd_ptr[5]_i_3_n_0 ;
  wire [5:0]rx_wr_ptr;
  wire \rx_wr_ptr[0]_i_1_n_0 ;
  wire \rx_wr_ptr[1]_i_1_n_0 ;
  wire \rx_wr_ptr[2]_i_1_n_0 ;
  wire \rx_wr_ptr[3]_i_1_n_0 ;
  wire \rx_wr_ptr[4]_i_1_n_0 ;
  wire \rx_wr_ptr[5]_i_1_n_0 ;
  wire \rx_wr_ptr[5]_i_2_n_0 ;
  wire \rx_wr_ptr[5]_i_3_n_0 ;
  wire [7:0]sel0;
  wire [31:0]shift_byte;
  wire \shift_byte[0]_i_1_n_0 ;
  wire \shift_byte[10]_i_1_n_0 ;
  wire \shift_byte[10]_i_2_n_0 ;
  wire \shift_byte[11]_i_1_n_0 ;
  wire \shift_byte[11]_i_2_n_0 ;
  wire \shift_byte[12]_i_1_n_0 ;
  wire \shift_byte[12]_i_2_n_0 ;
  wire \shift_byte[13]_i_1_n_0 ;
  wire \shift_byte[13]_i_2_n_0 ;
  wire \shift_byte[14]_i_1_n_0 ;
  wire \shift_byte[14]_i_2_n_0 ;
  wire \shift_byte[15]_i_1_n_0 ;
  wire \shift_byte[15]_i_2_n_0 ;
  wire \shift_byte[16]_i_1_n_0 ;
  wire \shift_byte[16]_i_2_n_0 ;
  wire \shift_byte[17]_i_1_n_0 ;
  wire \shift_byte[17]_i_2_n_0 ;
  wire \shift_byte[18]_i_1_n_0 ;
  wire \shift_byte[18]_i_2_n_0 ;
  wire \shift_byte[19]_i_1_n_0 ;
  wire \shift_byte[19]_i_2_n_0 ;
  wire \shift_byte[1]_i_1_n_0 ;
  wire \shift_byte[1]_i_2_n_0 ;
  wire \shift_byte[20]_i_1_n_0 ;
  wire \shift_byte[20]_i_2_n_0 ;
  wire \shift_byte[21]_i_1_n_0 ;
  wire \shift_byte[21]_i_2_n_0 ;
  wire \shift_byte[22]_i_1_n_0 ;
  wire \shift_byte[22]_i_2_n_0 ;
  wire \shift_byte[23]_i_1_n_0 ;
  wire \shift_byte[23]_i_2_n_0 ;
  wire \shift_byte[24]_i_1_n_0 ;
  wire \shift_byte[24]_i_2_n_0 ;
  wire \shift_byte[24]_i_3_n_0 ;
  wire \shift_byte[24]_i_4_n_0 ;
  wire \shift_byte[25]_i_1_n_0 ;
  wire \shift_byte[25]_i_2_n_0 ;
  wire \shift_byte[25]_i_3_n_0 ;
  wire \shift_byte[26]_i_1_n_0 ;
  wire \shift_byte[26]_i_2_n_0 ;
  wire \shift_byte[26]_i_3_n_0 ;
  wire \shift_byte[27]_i_1_n_0 ;
  wire \shift_byte[27]_i_2_n_0 ;
  wire \shift_byte[27]_i_3_n_0 ;
  wire \shift_byte[28]_i_1_n_0 ;
  wire \shift_byte[28]_i_2_n_0 ;
  wire \shift_byte[28]_i_3_n_0 ;
  wire \shift_byte[29]_i_1_n_0 ;
  wire \shift_byte[29]_i_2_n_0 ;
  wire \shift_byte[29]_i_3_n_0 ;
  wire \shift_byte[2]_i_1_n_0 ;
  wire \shift_byte[2]_i_2_n_0 ;
  wire \shift_byte[30]_i_1_n_0 ;
  wire \shift_byte[30]_i_2_n_0 ;
  wire \shift_byte[30]_i_3_n_0 ;
  wire \shift_byte[31]_i_1_n_0 ;
  wire \shift_byte[31]_i_2_n_0 ;
  wire \shift_byte[31]_i_3_n_0 ;
  wire \shift_byte[31]_i_4_n_0 ;
  wire \shift_byte[3]_i_1_n_0 ;
  wire \shift_byte[3]_i_2_n_0 ;
  wire \shift_byte[4]_i_1_n_0 ;
  wire \shift_byte[4]_i_2_n_0 ;
  wire \shift_byte[5]_i_1_n_0 ;
  wire \shift_byte[5]_i_2_n_0 ;
  wire \shift_byte[6]_i_1_n_0 ;
  wire \shift_byte[6]_i_2_n_0 ;
  wire \shift_byte[7]_i_1_n_0 ;
  wire \shift_byte[7]_i_2_n_0 ;
  wire \shift_byte[7]_i_3_n_0 ;
  wire \shift_byte[7]_i_4_n_0 ;
  wire \shift_byte[7]_i_5_n_0 ;
  wire \shift_byte[8]_i_1_n_0 ;
  wire \shift_byte[8]_i_2_n_0 ;
  wire \shift_byte[9]_i_1_n_0 ;
  wire \shift_byte[9]_i_2_n_0 ;
  wire \shift_cnt[0]_i_1_n_0 ;
  wire \shift_cnt[1]_i_1_n_0 ;
  wire \shift_cnt[2]_i_1_n_0 ;
  wire \shift_cnt[2]_i_2_n_0 ;
  wire \shift_cnt[3]_i_1_n_0 ;
  wire \shift_cnt[3]_i_2_n_0 ;
  wire \shift_cnt[3]_i_3_n_0 ;
  wire \shift_cnt[4]_i_1_n_0 ;
  wire \shift_cnt[4]_i_2_n_0 ;
  wire \shift_cnt[5]_i_1_n_0 ;
  wire \shift_cnt[5]_i_2_n_0 ;
  wire \shift_cnt[5]_i_3_n_0 ;
  wire \shift_cnt[5]_i_4_n_0 ;
  wire \shift_cnt[5]_i_5_n_0 ;
  wire [5:0]shift_cnt__0;
  wire \to_do_list[0]_i_1_n_0 ;
  wire \to_do_list[0]_i_2_n_0 ;
  wire \to_do_list[0]_i_3_n_0 ;
  wire \to_do_list[0]_i_4_n_0 ;
  wire \to_do_list[1]_i_1_n_0 ;
  wire \to_do_list[1]_i_2_n_0 ;
  wire \to_do_list[1]_i_3_n_0 ;
  wire \to_do_list[2]_i_1_n_0 ;
  wire \to_do_list[2]_i_2_n_0 ;
  wire \to_do_list[2]_i_3_n_0 ;
  wire \to_do_list[2]_i_4_n_0 ;
  wire \to_do_list[2]_i_5_n_0 ;
  wire \to_do_list[2]_i_6_n_0 ;
  wire \to_do_list[2]_i_7_n_0 ;
  wire \to_do_list[3]_i_1_n_0 ;
  wire \to_do_list[3]_i_2_n_0 ;
  wire \to_do_list[3]_i_3_n_0 ;
  wire \to_do_list_reg_n_0_[0] ;
  wire \to_do_list_reg_n_0_[1] ;
  wire \to_do_list_reg_n_0_[2] ;
  wire \to_do_list_reg_n_0_[3] ;
  wire [5:0]tx_rd_ptr;
  wire \tx_rd_ptr[0]_i_1_n_0 ;
  wire \tx_rd_ptr[1]_i_1_n_0 ;
  wire \tx_rd_ptr[2]_i_1_n_0 ;
  wire \tx_rd_ptr[3]_i_1_n_0 ;
  wire \tx_rd_ptr[4]_i_1_n_0 ;
  wire \tx_rd_ptr[5]_i_1_n_0 ;
  wire \tx_rd_ptr[5]_i_2_n_0 ;
  wire \tx_rd_ptr[5]_i_3_n_0 ;
  wire \tx_rd_ptr[5]_i_4_n_0 ;
  wire [5:0]tx_wr_ptr;
  wire \tx_wr_ptr[0]_i_1_n_0 ;
  wire \tx_wr_ptr[1]_i_1_n_0 ;
  wire \tx_wr_ptr[2]_i_1_n_0 ;
  wire \tx_wr_ptr[3]_i_1_n_0 ;
  wire \tx_wr_ptr[4]_i_1_n_0 ;
  wire \tx_wr_ptr[5]_i_1_n_0 ;
  wire \tx_wr_ptr[5]_i_2_n_0 ;
  wire \tx_wr_ptr[5]_i_3_n_0 ;
  wire [31:0]wdata;
  wire wvalid;
  wire NLW_FIFO_RX_reg_0_63_0_2_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_12_14_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_15_17_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_18_20_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_21_23_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_24_26_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_27_29_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_30_31_DOC_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_30_31_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_3_5_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_6_8_DOD_UNCONNECTED;
  wire NLW_FIFO_RX_reg_0_63_9_11_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_0_2_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_12_14_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_15_17_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_18_20_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_21_23_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_24_26_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_27_29_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_30_31_DOC_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_30_31_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_3_5_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_6_8_DOD_UNCONNECTED;
  wire NLW_FIFO_TX_reg_0_63_9_11_DOD_UNCONNECTED;
  wire [3:0]NLW_prscl_cnt1_carry_O_UNCONNECTED;
  wire [3:0]NLW_prscl_cnt1_carry__0_O_UNCONNECTED;
  wire [3:3]NLW_prscl_cnt1_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_prscl_cnt1_carry__1_O_UNCONNECTED;

  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M FIFO_RX_reg_0_63_0_2
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[0]),
        .DIB(fifo_rx_wdata[1]),
        .DIC(fifo_rx_wdata[2]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[0]),
        .DOB(fifo_rx_rdata0[1]),
        .DOC(fifo_rx_rdata0[2]),
        .DOD(NLW_FIFO_RX_reg_0_63_0_2_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "14" *) 
  RAM64M FIFO_RX_reg_0_63_12_14
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[12]),
        .DIB(fifo_rx_wdata[13]),
        .DIC(fifo_rx_wdata[14]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[12]),
        .DOB(fifo_rx_rdata0[13]),
        .DOC(fifo_rx_rdata0[14]),
        .DOD(NLW_FIFO_RX_reg_0_63_12_14_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "17" *) 
  RAM64M FIFO_RX_reg_0_63_15_17
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[15]),
        .DIB(fifo_rx_wdata[16]),
        .DIC(fifo_rx_wdata[17]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[15]),
        .DOB(fifo_rx_rdata0[16]),
        .DOC(fifo_rx_rdata0[17]),
        .DOD(NLW_FIFO_RX_reg_0_63_15_17_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "20" *) 
  RAM64M FIFO_RX_reg_0_63_18_20
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[18]),
        .DIB(fifo_rx_wdata[19]),
        .DIC(fifo_rx_wdata[20]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[18]),
        .DOB(fifo_rx_rdata0[19]),
        .DOC(fifo_rx_rdata0[20]),
        .DOD(NLW_FIFO_RX_reg_0_63_18_20_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "23" *) 
  RAM64M FIFO_RX_reg_0_63_21_23
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[21]),
        .DIB(fifo_rx_wdata[22]),
        .DIC(fifo_rx_wdata[23]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[21]),
        .DOB(fifo_rx_rdata0[22]),
        .DOC(fifo_rx_rdata0[23]),
        .DOD(NLW_FIFO_RX_reg_0_63_21_23_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "26" *) 
  RAM64M FIFO_RX_reg_0_63_24_26
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[24]),
        .DIB(fifo_rx_wdata[25]),
        .DIC(fifo_rx_wdata[26]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[24]),
        .DOB(fifo_rx_rdata0[25]),
        .DOC(fifo_rx_rdata0[26]),
        .DOD(NLW_FIFO_RX_reg_0_63_24_26_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "29" *) 
  RAM64M FIFO_RX_reg_0_63_27_29
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[27]),
        .DIB(fifo_rx_wdata[28]),
        .DIC(fifo_rx_wdata[29]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[27]),
        .DOB(fifo_rx_rdata0[28]),
        .DOC(fifo_rx_rdata0[29]),
        .DOD(NLW_FIFO_RX_reg_0_63_27_29_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM64M FIFO_RX_reg_0_63_30_31
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[30]),
        .DIB(fifo_rx_wdata[31]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[30]),
        .DOB(fifo_rx_rdata0[31]),
        .DOC(NLW_FIFO_RX_reg_0_63_30_31_DOC_UNCONNECTED),
        .DOD(NLW_FIFO_RX_reg_0_63_30_31_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M FIFO_RX_reg_0_63_3_5
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[3]),
        .DIB(fifo_rx_wdata[4]),
        .DIC(fifo_rx_wdata[5]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[3]),
        .DOB(fifo_rx_rdata0[4]),
        .DOC(fifo_rx_rdata0[5]),
        .DOD(NLW_FIFO_RX_reg_0_63_3_5_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "8" *) 
  RAM64M FIFO_RX_reg_0_63_6_8
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[6]),
        .DIB(fifo_rx_wdata[7]),
        .DIC(fifo_rx_wdata[8]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[6]),
        .DOB(fifo_rx_rdata0[7]),
        .DOC(fifo_rx_rdata0[8]),
        .DOD(NLW_FIFO_RX_reg_0_63_6_8_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "11" *) 
  RAM64M FIFO_RX_reg_0_63_9_11
       (.ADDRA(rx_rd_ptr),
        .ADDRB(rx_rd_ptr),
        .ADDRC(rx_rd_ptr),
        .ADDRD(rx_wr_ptr),
        .DIA(fifo_rx_wdata[9]),
        .DIB(fifo_rx_wdata[10]),
        .DIC(fifo_rx_wdata[11]),
        .DID(1'b0),
        .DOA(fifo_rx_rdata0[9]),
        .DOB(fifo_rx_rdata0[10]),
        .DOC(fifo_rx_rdata0[11]),
        .DOD(NLW_FIFO_RX_reg_0_63_9_11_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_rx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M FIFO_TX_reg_0_63_0_2
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[0]),
        .DIB(fifo_tx_wdata[1]),
        .DIC(fifo_tx_wdata[2]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[0]),
        .DOB(fifo_tx_rdata0[1]),
        .DOC(fifo_tx_rdata0[2]),
        .DOD(NLW_FIFO_TX_reg_0_63_0_2_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "14" *) 
  RAM64M FIFO_TX_reg_0_63_12_14
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[12]),
        .DIB(fifo_tx_wdata[13]),
        .DIC(fifo_tx_wdata[14]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[12]),
        .DOB(fifo_tx_rdata0[13]),
        .DOC(fifo_tx_rdata0[14]),
        .DOD(NLW_FIFO_TX_reg_0_63_12_14_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "17" *) 
  RAM64M FIFO_TX_reg_0_63_15_17
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[15]),
        .DIB(fifo_tx_wdata[16]),
        .DIC(fifo_tx_wdata[17]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[15]),
        .DOB(fifo_tx_rdata0[16]),
        .DOC(fifo_tx_rdata0[17]),
        .DOD(NLW_FIFO_TX_reg_0_63_15_17_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "20" *) 
  RAM64M FIFO_TX_reg_0_63_18_20
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[18]),
        .DIB(fifo_tx_wdata[19]),
        .DIC(fifo_tx_wdata[20]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[18]),
        .DOB(fifo_tx_rdata0[19]),
        .DOC(fifo_tx_rdata0[20]),
        .DOD(NLW_FIFO_TX_reg_0_63_18_20_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "23" *) 
  RAM64M FIFO_TX_reg_0_63_21_23
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[21]),
        .DIB(fifo_tx_wdata[22]),
        .DIC(fifo_tx_wdata[23]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[21]),
        .DOB(fifo_tx_rdata0[22]),
        .DOC(fifo_tx_rdata0[23]),
        .DOD(NLW_FIFO_TX_reg_0_63_21_23_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "26" *) 
  RAM64M FIFO_TX_reg_0_63_24_26
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[24]),
        .DIB(fifo_tx_wdata[25]),
        .DIC(fifo_tx_wdata[26]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[24]),
        .DOB(fifo_tx_rdata0[25]),
        .DOC(fifo_tx_rdata0[26]),
        .DOD(NLW_FIFO_TX_reg_0_63_24_26_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "29" *) 
  RAM64M FIFO_TX_reg_0_63_27_29
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[27]),
        .DIB(fifo_tx_wdata[28]),
        .DIC(fifo_tx_wdata[29]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[27]),
        .DOB(fifo_tx_rdata0[28]),
        .DOC(fifo_tx_rdata0[29]),
        .DOD(NLW_FIFO_TX_reg_0_63_27_29_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM64M FIFO_TX_reg_0_63_30_31
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[30]),
        .DIB(fifo_tx_wdata[31]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[30]),
        .DOB(fifo_tx_rdata0[31]),
        .DOC(NLW_FIFO_TX_reg_0_63_30_31_DOC_UNCONNECTED),
        .DOD(NLW_FIFO_TX_reg_0_63_30_31_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M FIFO_TX_reg_0_63_3_5
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[3]),
        .DIB(fifo_tx_wdata[4]),
        .DIC(fifo_tx_wdata[5]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[3]),
        .DOB(fifo_tx_rdata0[4]),
        .DOC(fifo_tx_rdata0[5]),
        .DOD(NLW_FIFO_TX_reg_0_63_3_5_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "8" *) 
  RAM64M FIFO_TX_reg_0_63_6_8
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[6]),
        .DIB(fifo_tx_wdata[7]),
        .DIC(fifo_tx_wdata[8]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[6]),
        .DOB(fifo_tx_rdata0[7]),
        .DOC(fifo_tx_rdata0[8]),
        .DOD(NLW_FIFO_TX_reg_0_63_6_8_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg" *) 
  (* RTL_RAM_STYLE = "distributed" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "11" *) 
  RAM64M FIFO_TX_reg_0_63_9_11
       (.ADDRA(tx_rd_ptr),
        .ADDRB(tx_rd_ptr),
        .ADDRC(tx_rd_ptr),
        .ADDRD(tx_wr_ptr),
        .DIA(fifo_tx_wdata[9]),
        .DIB(fifo_tx_wdata[10]),
        .DIC(fifo_tx_wdata[11]),
        .DID(1'b0),
        .DOA(fifo_tx_rdata0[9]),
        .DOB(fifo_tx_rdata0[10]),
        .DOC(fifo_tx_rdata0[11]),
        .DOD(NLW_FIFO_TX_reg_0_63_9_11_DOD_UNCONNECTED),
        .WCLK(clk_i),
        .WE(fifo_tx_wr_en));
  LUT5 #(
    .INIT(32'h01000000)) 
    \QSPI_ADR[31]_i_1 
       (.I0(awaddr[0]),
        .I1(awaddr[4]),
        .I2(awaddr[1]),
        .I3(awaddr[2]),
        .I4(\QSPI_CCR[31]_i_2_n_0 ),
        .O(QSPI_ADR));
  FDCE \QSPI_ADR_reg[0] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[0]),
        .Q(\QSPI_ADR_reg_n_0_[0] ));
  FDCE \QSPI_ADR_reg[10] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[10]),
        .Q(\QSPI_ADR_reg_n_0_[10] ));
  FDCE \QSPI_ADR_reg[11] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[11]),
        .Q(\QSPI_ADR_reg_n_0_[11] ));
  FDCE \QSPI_ADR_reg[12] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[12]),
        .Q(\QSPI_ADR_reg_n_0_[12] ));
  FDCE \QSPI_ADR_reg[13] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[13]),
        .Q(\QSPI_ADR_reg_n_0_[13] ));
  FDCE \QSPI_ADR_reg[14] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[14]),
        .Q(\QSPI_ADR_reg_n_0_[14] ));
  FDCE \QSPI_ADR_reg[15] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[15]),
        .Q(\QSPI_ADR_reg_n_0_[15] ));
  FDCE \QSPI_ADR_reg[16] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[16]),
        .Q(\QSPI_ADR_reg_n_0_[16] ));
  FDCE \QSPI_ADR_reg[17] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[17]),
        .Q(\QSPI_ADR_reg_n_0_[17] ));
  FDCE \QSPI_ADR_reg[18] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[18]),
        .Q(\QSPI_ADR_reg_n_0_[18] ));
  FDCE \QSPI_ADR_reg[19] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[19]),
        .Q(\QSPI_ADR_reg_n_0_[19] ));
  FDCE \QSPI_ADR_reg[1] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[1]),
        .Q(\QSPI_ADR_reg_n_0_[1] ));
  FDCE \QSPI_ADR_reg[20] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[20]),
        .Q(\QSPI_ADR_reg_n_0_[20] ));
  FDCE \QSPI_ADR_reg[21] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[21]),
        .Q(\QSPI_ADR_reg_n_0_[21] ));
  FDCE \QSPI_ADR_reg[22] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[22]),
        .Q(\QSPI_ADR_reg_n_0_[22] ));
  FDCE \QSPI_ADR_reg[23] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[23]),
        .Q(\QSPI_ADR_reg_n_0_[23] ));
  FDCE \QSPI_ADR_reg[24] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[24]),
        .Q(\QSPI_ADR_reg_n_0_[24] ));
  FDCE \QSPI_ADR_reg[25] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[25]),
        .Q(\QSPI_ADR_reg_n_0_[25] ));
  FDCE \QSPI_ADR_reg[26] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[26]),
        .Q(\QSPI_ADR_reg_n_0_[26] ));
  FDCE \QSPI_ADR_reg[27] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[27]),
        .Q(\QSPI_ADR_reg_n_0_[27] ));
  FDCE \QSPI_ADR_reg[28] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[28]),
        .Q(\QSPI_ADR_reg_n_0_[28] ));
  FDCE \QSPI_ADR_reg[29] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[29]),
        .Q(\QSPI_ADR_reg_n_0_[29] ));
  FDCE \QSPI_ADR_reg[2] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[2]),
        .Q(\QSPI_ADR_reg_n_0_[2] ));
  FDCE \QSPI_ADR_reg[30] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[30]),
        .Q(\QSPI_ADR_reg_n_0_[30] ));
  FDCE \QSPI_ADR_reg[31] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[31]),
        .Q(\QSPI_ADR_reg_n_0_[31] ));
  FDCE \QSPI_ADR_reg[3] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[3]),
        .Q(\QSPI_ADR_reg_n_0_[3] ));
  FDCE \QSPI_ADR_reg[4] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[4]),
        .Q(\QSPI_ADR_reg_n_0_[4] ));
  FDCE \QSPI_ADR_reg[5] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[5]),
        .Q(\QSPI_ADR_reg_n_0_[5] ));
  FDCE \QSPI_ADR_reg[6] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[6]),
        .Q(\QSPI_ADR_reg_n_0_[6] ));
  FDCE \QSPI_ADR_reg[7] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[7]),
        .Q(\QSPI_ADR_reg_n_0_[7] ));
  FDCE \QSPI_ADR_reg[8] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[8]),
        .Q(\QSPI_ADR_reg_n_0_[8] ));
  FDCE \QSPI_ADR_reg[9] 
       (.C(clk_i),
        .CE(QSPI_ADR),
        .CLR(rst_n_0),
        .D(wdata[9]),
        .Q(\QSPI_ADR_reg_n_0_[9] ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \QSPI_CCR[31]_i_1 
       (.I0(awaddr[0]),
        .I1(awaddr[4]),
        .I2(awaddr[1]),
        .I3(awaddr[2]),
        .I4(\QSPI_CCR[31]_i_2_n_0 ),
        .O(QSPI_CCR));
  LUT6 #(
    .INIT(64'h0000000000000040)) 
    \QSPI_CCR[31]_i_2 
       (.I0(awaddr[3]),
        .I1(awvalid),
        .I2(wvalid),
        .I3(awaddr[5]),
        .I4(awaddr[7]),
        .I5(awaddr[6]),
        .O(\QSPI_CCR[31]_i_2_n_0 ));
  FDCE \QSPI_CCR_reg[0] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[0]),
        .Q(\QSPI_CCR_reg_n_0_[0] ));
  FDCE \QSPI_CCR_reg[10] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[10]),
        .Q(\QSPI_CCR_reg_n_0_[10] ));
  FDCE \QSPI_CCR_reg[11] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[11]),
        .Q(\QSPI_CCR_reg_n_0_[11] ));
  FDCE \QSPI_CCR_reg[12] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[12]),
        .Q(\QSPI_CCR_reg_n_0_[12] ));
  FDCE \QSPI_CCR_reg[13] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[13]),
        .Q(\QSPI_CCR_reg_n_0_[13] ));
  FDCE \QSPI_CCR_reg[14] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[14]),
        .Q(\QSPI_CCR_reg_n_0_[14] ));
  FDCE \QSPI_CCR_reg[15] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[15]),
        .Q(\QSPI_CCR_reg_n_0_[15] ));
  FDCE \QSPI_CCR_reg[16] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[16]),
        .Q(\QSPI_CCR_reg_n_0_[16] ));
  FDCE \QSPI_CCR_reg[17] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[17]),
        .Q(\QSPI_CCR_reg_n_0_[17] ));
  FDCE \QSPI_CCR_reg[18] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[18]),
        .Q(\QSPI_CCR_reg_n_0_[18] ));
  FDCE \QSPI_CCR_reg[19] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[19]),
        .Q(\QSPI_CCR_reg_n_0_[19] ));
  FDCE \QSPI_CCR_reg[1] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[1]),
        .Q(\QSPI_CCR_reg_n_0_[1] ));
  FDCE \QSPI_CCR_reg[20] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[20]),
        .Q(\QSPI_CCR_reg_n_0_[20] ));
  FDCE \QSPI_CCR_reg[21] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[21]),
        .Q(\QSPI_CCR_reg_n_0_[21] ));
  FDCE \QSPI_CCR_reg[22] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[22]),
        .Q(\QSPI_CCR_reg_n_0_[22] ));
  FDCE \QSPI_CCR_reg[23] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[23]),
        .Q(\QSPI_CCR_reg_n_0_[23] ));
  FDCE \QSPI_CCR_reg[24] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[24]),
        .Q(\QSPI_CCR_reg_n_0_[24] ));
  FDCE \QSPI_CCR_reg[25] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[25]),
        .Q(p_0_in_0[0]));
  FDCE \QSPI_CCR_reg[26] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[26]),
        .Q(p_0_in_0[1]));
  FDCE \QSPI_CCR_reg[27] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[27]),
        .Q(p_0_in_0[2]));
  FDCE \QSPI_CCR_reg[28] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[28]),
        .Q(p_0_in_0[3]));
  FDCE \QSPI_CCR_reg[29] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[29]),
        .Q(p_0_in_0[4]));
  FDCE \QSPI_CCR_reg[2] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[2]),
        .Q(\QSPI_CCR_reg_n_0_[2] ));
  FDCE \QSPI_CCR_reg[30] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[30]),
        .Q(p_0_in_0[5]));
  FDCE \QSPI_CCR_reg[31] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[31]),
        .Q(p_0_in0));
  FDCE \QSPI_CCR_reg[3] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[3]),
        .Q(\QSPI_CCR_reg_n_0_[3] ));
  FDCE \QSPI_CCR_reg[4] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[4]),
        .Q(\QSPI_CCR_reg_n_0_[4] ));
  FDCE \QSPI_CCR_reg[5] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[5]),
        .Q(\QSPI_CCR_reg_n_0_[5] ));
  FDCE \QSPI_CCR_reg[6] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[6]),
        .Q(\QSPI_CCR_reg_n_0_[6] ));
  FDCE \QSPI_CCR_reg[7] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[7]),
        .Q(\QSPI_CCR_reg_n_0_[7] ));
  FDCE \QSPI_CCR_reg[8] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[8]),
        .Q(data2[0]));
  FDCE \QSPI_CCR_reg[9] 
       (.C(clk_i),
        .CE(QSPI_CCR),
        .CLR(rst_n_0),
        .D(wdata[9]),
        .Q(data2[1]));
  LUT6 #(
    .INIT(64'hFF05FFDDAA00AAC8)) 
    QSPI_CS_i_1
       (.I0(QSPI_CS_i_2_n_0),
        .I1(qspi_falling_edge),
        .I2(\fifo_status_reg_n_0_[0] ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(busy0),
        .I5(QSPI_CS_reg_0),
        .O(QSPI_CS_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000040)) 
    QSPI_CS_i_2
       (.I0(r_w_reg_n_0),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\fifo_status_reg_n_0_[0] ),
        .I3(\to_do_list_reg_n_0_[3] ),
        .I4(\to_do_list_reg_n_0_[1] ),
        .I5(\to_do_list_reg_n_0_[2] ),
        .O(QSPI_CS_i_2_n_0));
  LUT4 #(
    .INIT(16'h00FD)) 
    QSPI_CS_i_3
       (.I0(\instr_shadow[7]_i_4_n_0 ),
        .I1(\instr_shadow[7]_i_3_n_0 ),
        .I2(\instr_shadow[7]_i_2_n_0 ),
        .I3(\QSPI_STA_reg_n_0_[1] ),
        .O(busy0));
  FDPE QSPI_CS_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(QSPI_CS_i_1_n_0),
        .PRE(rst_n_0),
        .Q(QSPI_CS_reg_0));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \QSPI_DR[31]_i_1 
       (.I0(awaddr[2]),
        .I1(awaddr[1]),
        .I2(awaddr[0]),
        .I3(awaddr[4]),
        .I4(awaddr[3]),
        .I5(\QSPI_DR[31]_i_2_n_0 ),
        .O(QSPI_DR));
  LUT5 #(
    .INIT(32'hFEFFFFFF)) 
    \QSPI_DR[31]_i_2 
       (.I0(awaddr[6]),
        .I1(awaddr[7]),
        .I2(awaddr[5]),
        .I3(wvalid),
        .I4(awvalid),
        .O(\QSPI_DR[31]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0E00)) 
    \QSPI_DR_read[31]_i_1 
       (.I0(rx_pull_once_reg_n_0),
        .I1(fifo_rx_pull_data),
        .I2(\QSPI_STA_reg_n_0_[5] ),
        .I3(rst_n),
        .O(\QSPI_DR_read[31]_i_1_n_0 ));
  FDRE \QSPI_DR_read_reg[0] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[0]),
        .Q(\QSPI_DR_read_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[10] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[10]),
        .Q(\QSPI_DR_read_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[11] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[11]),
        .Q(\QSPI_DR_read_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[12] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[12]),
        .Q(\QSPI_DR_read_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[13] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[13]),
        .Q(\QSPI_DR_read_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[14] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[14]),
        .Q(\QSPI_DR_read_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[15] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[15]),
        .Q(\QSPI_DR_read_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[16] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[16]),
        .Q(\QSPI_DR_read_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[17] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[17]),
        .Q(\QSPI_DR_read_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[18] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[18]),
        .Q(\QSPI_DR_read_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[19] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[19]),
        .Q(\QSPI_DR_read_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[1] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[1]),
        .Q(\QSPI_DR_read_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[20] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[20]),
        .Q(\QSPI_DR_read_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[21] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[21]),
        .Q(\QSPI_DR_read_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[22] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[22]),
        .Q(\QSPI_DR_read_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[23] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[23]),
        .Q(\QSPI_DR_read_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[24] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[24]),
        .Q(\QSPI_DR_read_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[25] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[25]),
        .Q(\QSPI_DR_read_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[26] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[26]),
        .Q(\QSPI_DR_read_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[27] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[27]),
        .Q(\QSPI_DR_read_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[28] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[28]),
        .Q(\QSPI_DR_read_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[29] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[29]),
        .Q(\QSPI_DR_read_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[2] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[2]),
        .Q(\QSPI_DR_read_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[30] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[30]),
        .Q(\QSPI_DR_read_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[31] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[31]),
        .Q(\QSPI_DR_read_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[3] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[3]),
        .Q(\QSPI_DR_read_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[4] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[4]),
        .Q(\QSPI_DR_read_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[5] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[5]),
        .Q(\QSPI_DR_read_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[6] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[6]),
        .Q(\QSPI_DR_read_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[7] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[7]),
        .Q(\QSPI_DR_read_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[8] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[8]),
        .Q(\QSPI_DR_read_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \QSPI_DR_read_reg[9] 
       (.C(clk_i),
        .CE(\QSPI_DR_read[31]_i_1_n_0 ),
        .D(fifo_rx_rdata[9]),
        .Q(\QSPI_DR_read_reg_n_0_[9] ),
        .R(1'b0));
  FDCE \QSPI_DR_reg[0] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[0]),
        .Q(\QSPI_DR_reg_n_0_[0] ));
  FDCE \QSPI_DR_reg[10] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[10]),
        .Q(\QSPI_DR_reg_n_0_[10] ));
  FDCE \QSPI_DR_reg[11] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[11]),
        .Q(\QSPI_DR_reg_n_0_[11] ));
  FDCE \QSPI_DR_reg[12] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[12]),
        .Q(\QSPI_DR_reg_n_0_[12] ));
  FDCE \QSPI_DR_reg[13] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[13]),
        .Q(\QSPI_DR_reg_n_0_[13] ));
  FDCE \QSPI_DR_reg[14] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[14]),
        .Q(\QSPI_DR_reg_n_0_[14] ));
  FDCE \QSPI_DR_reg[15] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[15]),
        .Q(\QSPI_DR_reg_n_0_[15] ));
  FDCE \QSPI_DR_reg[16] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[16]),
        .Q(\QSPI_DR_reg_n_0_[16] ));
  FDCE \QSPI_DR_reg[17] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[17]),
        .Q(\QSPI_DR_reg_n_0_[17] ));
  FDCE \QSPI_DR_reg[18] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[18]),
        .Q(\QSPI_DR_reg_n_0_[18] ));
  FDCE \QSPI_DR_reg[19] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[19]),
        .Q(\QSPI_DR_reg_n_0_[19] ));
  FDCE \QSPI_DR_reg[1] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[1]),
        .Q(\QSPI_DR_reg_n_0_[1] ));
  FDCE \QSPI_DR_reg[20] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[20]),
        .Q(\QSPI_DR_reg_n_0_[20] ));
  FDCE \QSPI_DR_reg[21] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[21]),
        .Q(\QSPI_DR_reg_n_0_[21] ));
  FDCE \QSPI_DR_reg[22] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[22]),
        .Q(\QSPI_DR_reg_n_0_[22] ));
  FDCE \QSPI_DR_reg[23] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[23]),
        .Q(\QSPI_DR_reg_n_0_[23] ));
  FDCE \QSPI_DR_reg[24] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[24]),
        .Q(\QSPI_DR_reg_n_0_[24] ));
  FDCE \QSPI_DR_reg[25] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[25]),
        .Q(\QSPI_DR_reg_n_0_[25] ));
  FDCE \QSPI_DR_reg[26] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[26]),
        .Q(\QSPI_DR_reg_n_0_[26] ));
  FDCE \QSPI_DR_reg[27] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[27]),
        .Q(\QSPI_DR_reg_n_0_[27] ));
  FDCE \QSPI_DR_reg[28] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[28]),
        .Q(\QSPI_DR_reg_n_0_[28] ));
  FDCE \QSPI_DR_reg[29] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[29]),
        .Q(\QSPI_DR_reg_n_0_[29] ));
  FDCE \QSPI_DR_reg[2] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[2]),
        .Q(\QSPI_DR_reg_n_0_[2] ));
  FDCE \QSPI_DR_reg[30] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[30]),
        .Q(\QSPI_DR_reg_n_0_[30] ));
  FDCE \QSPI_DR_reg[31] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[31]),
        .Q(\QSPI_DR_reg_n_0_[31] ));
  FDCE \QSPI_DR_reg[3] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[3]),
        .Q(\QSPI_DR_reg_n_0_[3] ));
  FDCE \QSPI_DR_reg[4] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[4]),
        .Q(\QSPI_DR_reg_n_0_[4] ));
  FDCE \QSPI_DR_reg[5] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[5]),
        .Q(\QSPI_DR_reg_n_0_[5] ));
  FDCE \QSPI_DR_reg[6] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[6]),
        .Q(\QSPI_DR_reg_n_0_[6] ));
  FDCE \QSPI_DR_reg[7] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[7]),
        .Q(\QSPI_DR_reg_n_0_[7] ));
  FDCE \QSPI_DR_reg[8] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[8]),
        .Q(\QSPI_DR_reg_n_0_[8] ));
  FDCE \QSPI_DR_reg[9] 
       (.C(clk_i),
        .CE(QSPI_DR),
        .CLR(rst_n_0),
        .D(wdata[9]),
        .Q(\QSPI_DR_reg_n_0_[9] ));
  LUT5 #(
    .INIT(32'h00001000)) 
    \QSPI_FCR[31]_i_1 
       (.I0(awaddr[1]),
        .I1(awaddr[2]),
        .I2(\QSPI_CCR[31]_i_2_n_0 ),
        .I3(awaddr[4]),
        .I4(awaddr[0]),
        .O(QSPI_FCR));
  FDCE \QSPI_FCR_reg[0] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[0]),
        .Q(p_1_in));
  FDCE \QSPI_FCR_reg[10] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[10]),
        .Q(\QSPI_FCR_reg_n_0_[10] ));
  FDCE \QSPI_FCR_reg[11] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[11]),
        .Q(\QSPI_FCR_reg_n_0_[11] ));
  FDCE \QSPI_FCR_reg[12] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[12]),
        .Q(\QSPI_FCR_reg_n_0_[12] ));
  FDCE \QSPI_FCR_reg[13] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[13]),
        .Q(\QSPI_FCR_reg_n_0_[13] ));
  FDCE \QSPI_FCR_reg[14] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[14]),
        .Q(\QSPI_FCR_reg_n_0_[14] ));
  FDCE \QSPI_FCR_reg[15] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[15]),
        .Q(\QSPI_FCR_reg_n_0_[15] ));
  FDCE \QSPI_FCR_reg[16] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[16]),
        .Q(\QSPI_FCR_reg_n_0_[16] ));
  FDCE \QSPI_FCR_reg[17] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[17]),
        .Q(\QSPI_FCR_reg_n_0_[17] ));
  FDCE \QSPI_FCR_reg[18] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[18]),
        .Q(\QSPI_FCR_reg_n_0_[18] ));
  FDCE \QSPI_FCR_reg[19] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[19]),
        .Q(\QSPI_FCR_reg_n_0_[19] ));
  FDCE \QSPI_FCR_reg[1] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[1]),
        .Q(\QSPI_FCR_reg_n_0_[1] ));
  FDCE \QSPI_FCR_reg[20] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[20]),
        .Q(\QSPI_FCR_reg_n_0_[20] ));
  FDCE \QSPI_FCR_reg[21] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[21]),
        .Q(\QSPI_FCR_reg_n_0_[21] ));
  FDCE \QSPI_FCR_reg[22] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[22]),
        .Q(\QSPI_FCR_reg_n_0_[22] ));
  FDCE \QSPI_FCR_reg[23] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[23]),
        .Q(\QSPI_FCR_reg_n_0_[23] ));
  FDCE \QSPI_FCR_reg[24] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[24]),
        .Q(\QSPI_FCR_reg_n_0_[24] ));
  FDCE \QSPI_FCR_reg[25] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[25]),
        .Q(\QSPI_FCR_reg_n_0_[25] ));
  FDCE \QSPI_FCR_reg[26] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[26]),
        .Q(\QSPI_FCR_reg_n_0_[26] ));
  FDCE \QSPI_FCR_reg[27] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[27]),
        .Q(\QSPI_FCR_reg_n_0_[27] ));
  FDCE \QSPI_FCR_reg[28] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[28]),
        .Q(\QSPI_FCR_reg_n_0_[28] ));
  FDCE \QSPI_FCR_reg[29] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[29]),
        .Q(\QSPI_FCR_reg_n_0_[29] ));
  FDCE \QSPI_FCR_reg[2] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[2]),
        .Q(\QSPI_FCR_reg_n_0_[2] ));
  FDCE \QSPI_FCR_reg[30] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[30]),
        .Q(\QSPI_FCR_reg_n_0_[30] ));
  FDCE \QSPI_FCR_reg[31] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[31]),
        .Q(\QSPI_FCR_reg_n_0_[31] ));
  FDCE \QSPI_FCR_reg[3] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[3]),
        .Q(\QSPI_FCR_reg_n_0_[3] ));
  FDCE \QSPI_FCR_reg[4] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[4]),
        .Q(\QSPI_FCR_reg_n_0_[4] ));
  FDCE \QSPI_FCR_reg[5] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[5]),
        .Q(\QSPI_FCR_reg_n_0_[5] ));
  FDCE \QSPI_FCR_reg[6] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[6]),
        .Q(\QSPI_FCR_reg_n_0_[6] ));
  FDCE \QSPI_FCR_reg[7] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[7]),
        .Q(\QSPI_FCR_reg_n_0_[7] ));
  FDCE \QSPI_FCR_reg[8] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[8]),
        .Q(\QSPI_FCR_reg_n_0_[8] ));
  FDCE \QSPI_FCR_reg[9] 
       (.C(clk_i),
        .CE(QSPI_FCR),
        .CLR(rst_n_0),
        .D(wdata[9]),
        .Q(\QSPI_FCR_reg_n_0_[9] ));
  LUT2 #(
    .INIT(4'h8)) 
    QSPI_IO0_INST_0
       (.I0(io0_val_tristate_oe_reg_n_0),
        .I1(QSPI_IO0_INST_0_i_1),
        .O(QSPI_IO0));
  LUT6 #(
    .INIT(64'hF4F4F4FFF4F4F400)) 
    QSPI_IO0_INST_0_i_2
       (.I0(\fifo_status_reg_n_0_[1] ),
        .I1(busy0),
        .I2(\shift_cnt[5]_i_4_n_0 ),
        .I3(io0_val_tristate_oe_i_3_n_0),
        .I4(io0_val_tristate_oe_i_4_n_0),
        .I5(QSPI_IO0_INST_0_i_1),
        .O(\fifo_status_reg[1]_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    QSPI_IO1_INST_0
       (.I0(io1_val_tristate_oe_reg_n_0),
        .I1(QSPI_IO1_INST_0_i_1_0),
        .O(QSPI_IO1));
  LUT5 #(
    .INIT(32'hBABB8A88)) 
    QSPI_IO1_INST_0_i_2
       (.I0(\shift_cnt[5]_i_4_n_0 ),
        .I1(\data_mode[2]_i_2_n_0 ),
        .I2(QSPI_IO1_INST_0_i_3_n_0),
        .I3(io2_val_tristate_oe_i_3_n_0),
        .I4(QSPI_IO1_INST_0_i_1_0),
        .O(QSPI_IO1_INST_0_i_1));
  LUT6 #(
    .INIT(64'hA88AAAAAAAAAAAAA)) 
    QSPI_IO1_INST_0_i_3
       (.I0(\to_do_list[1]_i_3_n_0 ),
        .I1(data_mode__0[0]),
        .I2(data_mode__0[1]),
        .I3(data_mode__0[2]),
        .I4(qspi_falling_edge),
        .I5(r_w_reg_n_0),
        .O(QSPI_IO1_INST_0_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'h8)) 
    QSPI_IO2_INST_0
       (.I0(io2_val_tristate_oe_reg_n_0),
        .I1(QSPI_IO2_INST_0_i_1_0),
        .O(QSPI_IO2));
  LUT5 #(
    .INIT(32'hBABB8A88)) 
    QSPI_IO2_INST_0_i_2
       (.I0(\shift_cnt[5]_i_4_n_0 ),
        .I1(\data_mode[2]_i_2_n_0 ),
        .I2(io2_val_tristate_oe_i_2_n_0),
        .I3(io2_val_tristate_oe_i_3_n_0),
        .I4(QSPI_IO2_INST_0_i_1_0),
        .O(QSPI_IO2_INST_0_i_1));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'h8)) 
    QSPI_IO3_INST_0
       (.I0(io3_val_tristate_oe_reg_n_0),
        .I1(QSPI_IO2_INST_0_i_1_0),
        .O(QSPI_IO3));
  LUT3 #(
    .INIT(8'hB4)) 
    QSPI_SCLK_i_1
       (.I0(QSPI_CS_reg_0),
        .I1(prscl_cnt1),
        .I2(QSPI_SCLK_reg_0),
        .O(QSPI_SCLK_i_1_n_0));
  FDCE QSPI_SCLK_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(QSPI_SCLK_i_1_n_0),
        .Q(QSPI_SCLK_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \QSPI_STA[1]_i_1 
       (.I0(p_2_in),
        .I1(p_0_in0),
        .O(\QSPI_STA[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \QSPI_STA[4]_i_1 
       (.I0(p_0_in0),
        .I1(\fifo_rx_cnt[6]_i_3_n_0 ),
        .I2(\fifo_rx_cnt_reg_n_0_[6] ),
        .O(\QSPI_STA[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \QSPI_STA[5]_i_1 
       (.I0(\fifo_rx_cnt[6]_i_3_n_0 ),
        .I1(p_0_in0),
        .I2(\fifo_rx_cnt_reg_n_0_[6] ),
        .O(\QSPI_STA[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \QSPI_STA[6]_i_1 
       (.I0(\fifo_tx_cnt[6]_i_4_n_0 ),
        .I1(\fifo_tx_cnt_reg_n_0_[6] ),
        .I2(p_0_in0),
        .O(\QSPI_STA[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \QSPI_STA[7]_i_1 
       (.I0(p_0_in0),
        .I1(\fifo_tx_cnt[6]_i_4_n_0 ),
        .I2(\fifo_tx_cnt_reg_n_0_[6] ),
        .O(\QSPI_STA[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \QSPI_STA[8]_i_1 
       (.I0(fifo_error[0]),
        .I1(p_0_in0),
        .O(\QSPI_STA[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \QSPI_STA[9]_i_1 
       (.I0(fifo_error[1]),
        .I1(p_0_in0),
        .O(\QSPI_STA[9]_i_1_n_0 ));
  FDCE \QSPI_STA_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\QSPI_STA[1]_i_1_n_0 ),
        .Q(\QSPI_STA_reg_n_0_[1] ));
  FDCE \QSPI_STA_reg[4] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\QSPI_STA[4]_i_1_n_0 ),
        .Q(\QSPI_STA_reg_n_0_[4] ));
  FDCE \QSPI_STA_reg[5] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\QSPI_STA[5]_i_1_n_0 ),
        .Q(\QSPI_STA_reg_n_0_[5] ));
  FDCE \QSPI_STA_reg[6] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\QSPI_STA[6]_i_1_n_0 ),
        .Q(p_0_in27_in));
  FDCE \QSPI_STA_reg[7] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\QSPI_STA[7]_i_1_n_0 ),
        .Q(\QSPI_STA_reg_n_0_[7] ));
  FDCE \QSPI_STA_reg[8] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\QSPI_STA[8]_i_1_n_0 ),
        .Q(\QSPI_STA_reg_n_0_[8] ));
  FDCE \QSPI_STA_reg[9] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\QSPI_STA[9]_i_1_n_0 ),
        .Q(\QSPI_STA_reg_n_0_[9] ));
  LUT5 #(
    .INIT(32'hFFBF0080)) 
    address_i_1
       (.I0(wdata[0]),
        .I1(address_i_2_n_0),
        .I2(awaddr[4]),
        .I3(awaddr[0]),
        .I4(address),
        .O(address_i_1_n_0));
  LUT3 #(
    .INIT(8'h08)) 
    address_i_2
       (.I0(\QSPI_CCR[31]_i_2_n_0 ),
        .I1(awaddr[2]),
        .I2(awaddr[1]),
        .O(address_i_2_n_0));
  FDCE address_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(address_i_1_n_0),
        .Q(address));
  LUT4 #(
    .INIT(16'h5540)) 
    arready_i_1
       (.I0(arvalid),
        .I1(rready),
        .I2(rvalid),
        .I3(arready),
        .O(arready_i_1_n_0));
  FDPE arready_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(arready_i_1_n_0),
        .PRE(rst_n_0),
        .Q(arready));
  LUT5 #(
    .INIT(32'h77777000)) 
    awready_i_1
       (.I0(wvalid),
        .I1(awvalid),
        .I2(bready),
        .I3(bvalid),
        .I4(awready),
        .O(awready_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    awready_i_2
       (.I0(rst_n),
        .O(rst_n_0));
  FDPE awready_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(awready_i_1_n_0),
        .PRE(rst_n_0),
        .Q(awready));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hEFFF2020)) 
    busy_i_1
       (.I0(busy0),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\fifo_status_reg_n_0_[0] ),
        .I3(qspi_falling_edge),
        .I4(p_2_in),
        .O(busy_i_1_n_0));
  FDCE busy_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(busy_i_1_n_0),
        .Q(p_2_in));
  LUT4 #(
    .INIT(16'h8F88)) 
    bvalid_i_1
       (.I0(wvalid),
        .I1(awvalid),
        .I2(bready),
        .I3(bvalid),
        .O(bvalid_i_1_n_0));
  FDCE bvalid_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(bvalid_i_1_n_0),
        .Q(bvalid));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hA3)) 
    \data_byte_size[0]_i_1 
       (.I0(sel0[0]),
        .I1(\QSPI_CCR_reg_n_0_[16] ),
        .I2(\fifo_status_reg_n_0_[1] ),
        .O(\data_byte_size[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'h8BB8)) 
    \data_byte_size[1]_i_1 
       (.I0(sel0[1]),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\QSPI_CCR_reg_n_0_[16] ),
        .I3(\QSPI_CCR_reg_n_0_[17] ),
        .O(\data_byte_size[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h47747474)) 
    \data_byte_size[2]_i_1 
       (.I0(sel0[2]),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\QSPI_CCR_reg_n_0_[18] ),
        .I3(\QSPI_CCR_reg_n_0_[16] ),
        .I4(\QSPI_CCR_reg_n_0_[17] ),
        .O(\data_byte_size[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h9F90909F)) 
    \data_byte_size[3]_i_1 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\fifo_status_reg_n_0_[1] ),
        .I3(\QSPI_CCR_reg_n_0_[19] ),
        .I4(\data_byte_size[3]_i_2_n_0 ),
        .O(\data_byte_size[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \data_byte_size[3]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[17] ),
        .I1(\QSPI_CCR_reg_n_0_[16] ),
        .I2(\QSPI_CCR_reg_n_0_[18] ),
        .O(\data_byte_size[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hE1FFE100E100E1FF)) 
    \data_byte_size[4]_i_1 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(sel0[4]),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\data_byte_size[4]_i_2_n_0 ),
        .I5(\QSPI_CCR_reg_n_0_[20] ),
        .O(\data_byte_size[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \data_byte_size[4]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[18] ),
        .I1(\QSPI_CCR_reg_n_0_[16] ),
        .I2(\QSPI_CCR_reg_n_0_[17] ),
        .I3(\QSPI_CCR_reg_n_0_[19] ),
        .O(\data_byte_size[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hE100E1FFE1FFE100)) 
    \data_byte_size[5]_i_1 
       (.I0(sel0[4]),
        .I1(\data_byte_size[5]_i_2_n_0 ),
        .I2(sel0[5]),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\QSPI_CCR_reg_n_0_[21] ),
        .I5(\data_byte_size[7]_i_5_n_0 ),
        .O(\data_byte_size[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \data_byte_size[5]_i_2 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .O(\data_byte_size[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h909F9F909F909F90)) 
    \data_byte_size[6]_i_1 
       (.I0(\data_byte_size[6]_i_2_n_0 ),
        .I1(sel0[6]),
        .I2(\fifo_status_reg_n_0_[1] ),
        .I3(\QSPI_CCR_reg_n_0_[22] ),
        .I4(\data_byte_size[7]_i_5_n_0 ),
        .I5(\QSPI_CCR_reg_n_0_[21] ),
        .O(\data_byte_size[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \data_byte_size[6]_i_2 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(sel0[4]),
        .I3(sel0[5]),
        .O(\data_byte_size[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAABAAAAAAAAAAA)) 
    \data_byte_size[7]_i_1 
       (.I0(\instr_shadow[7]_i_1_n_0 ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(\fifo_status_reg_n_0_[1] ),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\to_do_list[2]_i_3_n_0 ),
        .I5(\data_byte_size[7]_i_3_n_0 ),
        .O(\data_byte_size[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8BB8B8B8B8B8B8B8)) 
    \data_byte_size[7]_i_2 
       (.I0(\data_byte_size[7]_i_4_n_0 ),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\QSPI_CCR_reg_n_0_[23] ),
        .I3(\QSPI_CCR_reg_n_0_[21] ),
        .I4(\data_byte_size[7]_i_5_n_0 ),
        .I5(\QSPI_CCR_reg_n_0_[22] ),
        .O(\data_byte_size[7]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \data_byte_size[7]_i_3 
       (.I0(qspi_falling_edge),
        .I1(\dummy_cycle[4]_i_4_n_0 ),
        .I2(\to_do_list_reg_n_0_[2] ),
        .I3(\to_do_list_reg_n_0_[3] ),
        .O(\data_byte_size[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000001)) 
    \data_byte_size[7]_i_4 
       (.I0(sel0[6]),
        .I1(sel0[5]),
        .I2(sel0[4]),
        .I3(sel0[3]),
        .I4(sel0[2]),
        .I5(sel0[7]),
        .O(\data_byte_size[7]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \data_byte_size[7]_i_5 
       (.I0(\QSPI_CCR_reg_n_0_[20] ),
        .I1(\QSPI_CCR_reg_n_0_[19] ),
        .I2(\QSPI_CCR_reg_n_0_[17] ),
        .I3(\QSPI_CCR_reg_n_0_[16] ),
        .I4(\QSPI_CCR_reg_n_0_[18] ),
        .O(\data_byte_size[7]_i_5_n_0 ));
  FDCE \data_byte_size_reg[0] 
       (.C(clk_i),
        .CE(\data_byte_size[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\data_byte_size[0]_i_1_n_0 ),
        .Q(sel0[0]));
  FDCE \data_byte_size_reg[1] 
       (.C(clk_i),
        .CE(\data_byte_size[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\data_byte_size[1]_i_1_n_0 ),
        .Q(sel0[1]));
  FDCE \data_byte_size_reg[2] 
       (.C(clk_i),
        .CE(\data_byte_size[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\data_byte_size[2]_i_1_n_0 ),
        .Q(sel0[2]));
  FDCE \data_byte_size_reg[3] 
       (.C(clk_i),
        .CE(\data_byte_size[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\data_byte_size[3]_i_1_n_0 ),
        .Q(sel0[3]));
  FDCE \data_byte_size_reg[4] 
       (.C(clk_i),
        .CE(\data_byte_size[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\data_byte_size[4]_i_1_n_0 ),
        .Q(sel0[4]));
  FDCE \data_byte_size_reg[5] 
       (.C(clk_i),
        .CE(\data_byte_size[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\data_byte_size[5]_i_1_n_0 ),
        .Q(sel0[5]));
  FDCE \data_byte_size_reg[6] 
       (.C(clk_i),
        .CE(\data_byte_size[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\data_byte_size[6]_i_1_n_0 ),
        .Q(sel0[6]));
  FDCE \data_byte_size_reg[7] 
       (.C(clk_i),
        .CE(\data_byte_size[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\data_byte_size[7]_i_2_n_0 ),
        .Q(sel0[7]));
  LUT6 #(
    .INIT(64'h4F4F4FFF4F4F4F00)) 
    \data_mode[0]_i_1 
       (.I0(data2[1]),
        .I1(data2[0]),
        .I2(\fifo_status_reg_n_0_[1] ),
        .I3(\data_mode[2]_i_2_n_0 ),
        .I4(\to_do_list[1]_i_2_n_0 ),
        .I5(data_mode__0[0]),
        .O(\data_mode[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404000)) 
    \data_mode[1]_i_1 
       (.I0(data2[0]),
        .I1(data2[1]),
        .I2(\fifo_status_reg_n_0_[1] ),
        .I3(\data_mode[2]_i_2_n_0 ),
        .I4(\to_do_list[1]_i_2_n_0 ),
        .I5(data_mode__0[1]),
        .O(\data_mode[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h808080FF80808000)) 
    \data_mode[2]_i_1 
       (.I0(data2[0]),
        .I1(data2[1]),
        .I2(\fifo_status_reg_n_0_[1] ),
        .I3(\data_mode[2]_i_2_n_0 ),
        .I4(\to_do_list[1]_i_2_n_0 ),
        .I5(data_mode__0[2]),
        .O(\data_mode[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0040)) 
    \data_mode[2]_i_2 
       (.I0(\fifo_status_reg_n_0_[1] ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(qspi_falling_edge),
        .I3(busy0),
        .O(\data_mode[2]_i_2_n_0 ));
  FDPE \data_mode_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .D(\data_mode[0]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(data_mode__0[0]));
  FDCE \data_mode_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\data_mode[1]_i_1_n_0 ),
        .Q(data_mode__0[1]));
  FDCE \data_mode_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\data_mode[2]_i_1_n_0 ),
        .Q(data_mode__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h74)) 
    \dummy_cycle[0]_i_1 
       (.I0(dummy_cycle__0[0]),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\QSPI_CCR_reg_n_0_[11] ),
        .O(\dummy_cycle[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h9F90)) 
    \dummy_cycle[1]_i_1 
       (.I0(dummy_cycle__0[0]),
        .I1(dummy_cycle__0[1]),
        .I2(\fifo_status_reg_n_0_[1] ),
        .I3(\QSPI_CCR_reg_n_0_[12] ),
        .O(\dummy_cycle[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hE1FFE100)) 
    \dummy_cycle[2]_i_1 
       (.I0(dummy_cycle__0[0]),
        .I1(dummy_cycle__0[1]),
        .I2(dummy_cycle__0[2]),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\QSPI_CCR_reg_n_0_[13] ),
        .O(\dummy_cycle[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE01FFFFFE010000)) 
    \dummy_cycle[3]_i_1 
       (.I0(dummy_cycle__0[2]),
        .I1(dummy_cycle__0[1]),
        .I2(dummy_cycle__0[0]),
        .I3(dummy_cycle__0[3]),
        .I4(\fifo_status_reg_n_0_[1] ),
        .I5(\QSPI_CCR_reg_n_0_[14] ),
        .O(\dummy_cycle[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEAAAAAAAAAAAAAAA)) 
    \dummy_cycle[4]_i_1 
       (.I0(\instr_shadow[7]_i_1_n_0 ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(qspi_falling_edge),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\dummy_cycle[4]_i_3_n_0 ),
        .I5(\dummy_cycle[4]_i_4_n_0 ),
        .O(\dummy_cycle[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFD55FFFFFD550000)) 
    \dummy_cycle[4]_i_2 
       (.I0(\dummy_cycle[4]_i_4_n_0 ),
        .I1(dummy_cycle__0[3]),
        .I2(\dummy_cycle[4]_i_5_n_0 ),
        .I3(dummy_cycle__0[4]),
        .I4(\fifo_status_reg_n_0_[1] ),
        .I5(\QSPI_CCR_reg_n_0_[15] ),
        .O(\dummy_cycle[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dummy_cycle[4]_i_3 
       (.I0(\to_do_list_reg_n_0_[2] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .O(\dummy_cycle[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \dummy_cycle[4]_i_4 
       (.I0(dummy_cycle__0[0]),
        .I1(dummy_cycle__0[1]),
        .I2(dummy_cycle__0[2]),
        .I3(dummy_cycle__0[3]),
        .I4(dummy_cycle__0[4]),
        .O(\dummy_cycle[4]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \dummy_cycle[4]_i_5 
       (.I0(dummy_cycle__0[2]),
        .I1(dummy_cycle__0[1]),
        .I2(dummy_cycle__0[0]),
        .O(\dummy_cycle[4]_i_5_n_0 ));
  FDCE \dummy_cycle_reg[0] 
       (.C(clk_i),
        .CE(\dummy_cycle[4]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\dummy_cycle[0]_i_1_n_0 ),
        .Q(dummy_cycle__0[0]));
  FDCE \dummy_cycle_reg[1] 
       (.C(clk_i),
        .CE(\dummy_cycle[4]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\dummy_cycle[1]_i_1_n_0 ),
        .Q(dummy_cycle__0[1]));
  FDCE \dummy_cycle_reg[2] 
       (.C(clk_i),
        .CE(\dummy_cycle[4]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\dummy_cycle[2]_i_1_n_0 ),
        .Q(dummy_cycle__0[2]));
  FDCE \dummy_cycle_reg[3] 
       (.C(clk_i),
        .CE(\dummy_cycle[4]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\dummy_cycle[3]_i_1_n_0 ),
        .Q(dummy_cycle__0[3]));
  FDCE \dummy_cycle_reg[4] 
       (.C(clk_i),
        .CE(\dummy_cycle[4]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\dummy_cycle[4]_i_2_n_0 ),
        .Q(dummy_cycle__0[4]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'hFFE0)) 
    \fifo_error[0]_i_1 
       (.I0(rx_pull_once_reg_n_0),
        .I1(fifo_rx_pull_data),
        .I2(\QSPI_STA_reg_n_0_[4] ),
        .I3(fifo_error[0]),
        .O(\fifo_error[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    \fifo_error[1]_i_1 
       (.I0(fifo_tx_wr_en),
        .I1(p_0_in27_in),
        .I2(fifo_error[1]),
        .O(\fifo_error[1]_i_1_n_0 ));
  FDCE \fifo_error_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\fifo_error[0]_i_1_n_0 ),
        .Q(fifo_error[0]));
  FDCE \fifo_error_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\fifo_error[1]_i_1_n_0 ),
        .Q(fifo_error[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h0000BBBA)) 
    \fifo_rx_cnt[0]_i_1 
       (.I0(fifo_rx_wr_en_i_1_n_0),
        .I1(\QSPI_STA_reg_n_0_[5] ),
        .I2(fifo_rx_pull_data),
        .I3(rx_pull_once_reg_n_0),
        .I4(\fifo_rx_cnt_reg_n_0_[0] ),
        .O(\fifo_rx_cnt[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6666666600009990)) 
    \fifo_rx_cnt[1]_i_1 
       (.I0(\fifo_rx_cnt_reg_n_0_[1] ),
        .I1(\fifo_rx_cnt_reg_n_0_[0] ),
        .I2(rx_pull_once_reg_n_0),
        .I3(fifo_rx_pull_data),
        .I4(\QSPI_STA_reg_n_0_[5] ),
        .I5(fifo_rx_wr_en_i_1_n_0),
        .O(\fifo_rx_cnt[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h3CCC8882)) 
    \fifo_rx_cnt[2]_i_1 
       (.I0(\rx_rd_ptr[4]_i_2_n_0 ),
        .I1(\fifo_rx_cnt_reg_n_0_[2] ),
        .I2(\fifo_rx_cnt_reg_n_0_[0] ),
        .I3(\fifo_rx_cnt_reg_n_0_[1] ),
        .I4(fifo_rx_wr_en_i_1_n_0),
        .O(\fifo_rx_cnt[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2CE0E0E0E0E0E0C2)) 
    \fifo_rx_cnt[3]_i_1 
       (.I0(\rx_rd_ptr[4]_i_2_n_0 ),
        .I1(fifo_rx_wr_en_i_1_n_0),
        .I2(\fifo_rx_cnt_reg_n_0_[3] ),
        .I3(\fifo_rx_cnt_reg_n_0_[0] ),
        .I4(\fifo_rx_cnt_reg_n_0_[1] ),
        .I5(\fifo_rx_cnt_reg_n_0_[2] ),
        .O(\fifo_rx_cnt[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF80408F4)) 
    \fifo_rx_cnt[4]_i_1 
       (.I0(\fifo_rx_cnt[4]_i_2_n_0 ),
        .I1(\rx_rd_ptr[4]_i_2_n_0 ),
        .I2(fifo_rx_wr_en_i_1_n_0),
        .I3(\fifo_rx_cnt_reg_n_0_[4] ),
        .I4(\fifo_rx_cnt[4]_i_3_n_0 ),
        .O(\fifo_rx_cnt[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \fifo_rx_cnt[4]_i_2 
       (.I0(\fifo_rx_cnt_reg_n_0_[3] ),
        .I1(\fifo_rx_cnt_reg_n_0_[1] ),
        .I2(\fifo_rx_cnt_reg_n_0_[0] ),
        .I3(\fifo_rx_cnt_reg_n_0_[2] ),
        .O(\fifo_rx_cnt[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \fifo_rx_cnt[4]_i_3 
       (.I0(\fifo_rx_cnt_reg_n_0_[2] ),
        .I1(\fifo_rx_cnt_reg_n_0_[1] ),
        .I2(\fifo_rx_cnt_reg_n_0_[0] ),
        .I3(\fifo_rx_cnt_reg_n_0_[3] ),
        .O(\fifo_rx_cnt[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hF00F8844)) 
    \fifo_rx_cnt[5]_i_1 
       (.I0(\fifo_rx_cnt[5]_i_2_n_0 ),
        .I1(\rx_rd_ptr[4]_i_2_n_0 ),
        .I2(\fifo_rx_cnt[5]_i_3_n_0 ),
        .I3(\fifo_rx_cnt_reg_n_0_[5] ),
        .I4(fifo_rx_wr_en_i_1_n_0),
        .O(\fifo_rx_cnt[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \fifo_rx_cnt[5]_i_2 
       (.I0(\fifo_rx_cnt_reg_n_0_[4] ),
        .I1(\fifo_rx_cnt_reg_n_0_[2] ),
        .I2(\fifo_rx_cnt_reg_n_0_[0] ),
        .I3(\fifo_rx_cnt_reg_n_0_[1] ),
        .I4(\fifo_rx_cnt_reg_n_0_[3] ),
        .O(\fifo_rx_cnt[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \fifo_rx_cnt[5]_i_3 
       (.I0(\fifo_rx_cnt_reg_n_0_[3] ),
        .I1(\fifo_rx_cnt_reg_n_0_[0] ),
        .I2(\fifo_rx_cnt_reg_n_0_[1] ),
        .I3(\fifo_rx_cnt_reg_n_0_[2] ),
        .I4(\fifo_rx_cnt_reg_n_0_[4] ),
        .O(\fifo_rx_cnt[5]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFF0E)) 
    \fifo_rx_cnt[6]_i_1 
       (.I0(rx_pull_once_reg_n_0),
        .I1(fifo_rx_pull_data),
        .I2(\QSPI_STA_reg_n_0_[5] ),
        .I3(fifo_rx_wr_en_i_1_n_0),
        .I4(p_1_in),
        .O(\fifo_rx_cnt[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0FF04488)) 
    \fifo_rx_cnt[6]_i_2 
       (.I0(\fifo_rx_cnt[6]_i_3_n_0 ),
        .I1(\rx_rd_ptr[4]_i_2_n_0 ),
        .I2(\fifo_rx_cnt[6]_i_4_n_0 ),
        .I3(\fifo_rx_cnt_reg_n_0_[6] ),
        .I4(fifo_rx_wr_en_i_1_n_0),
        .O(\fifo_rx_cnt[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \fifo_rx_cnt[6]_i_3 
       (.I0(\fifo_rx_cnt_reg_n_0_[5] ),
        .I1(\fifo_rx_cnt_reg_n_0_[3] ),
        .I2(\fifo_rx_cnt_reg_n_0_[1] ),
        .I3(\fifo_rx_cnt_reg_n_0_[0] ),
        .I4(\fifo_rx_cnt_reg_n_0_[2] ),
        .I5(\fifo_rx_cnt_reg_n_0_[4] ),
        .O(\fifo_rx_cnt[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \fifo_rx_cnt[6]_i_4 
       (.I0(\fifo_rx_cnt_reg_n_0_[5] ),
        .I1(\fifo_rx_cnt_reg_n_0_[4] ),
        .I2(\fifo_rx_cnt_reg_n_0_[2] ),
        .I3(\fifo_rx_cnt_reg_n_0_[1] ),
        .I4(\fifo_rx_cnt_reg_n_0_[0] ),
        .I5(\fifo_rx_cnt_reg_n_0_[3] ),
        .O(\fifo_rx_cnt[6]_i_4_n_0 ));
  FDCE \fifo_rx_cnt_reg[0] 
       (.C(clk_i),
        .CE(\fifo_rx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_rx_cnt[0]_i_1_n_0 ),
        .Q(\fifo_rx_cnt_reg_n_0_[0] ));
  FDCE \fifo_rx_cnt_reg[1] 
       (.C(clk_i),
        .CE(\fifo_rx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_rx_cnt[1]_i_1_n_0 ),
        .Q(\fifo_rx_cnt_reg_n_0_[1] ));
  FDCE \fifo_rx_cnt_reg[2] 
       (.C(clk_i),
        .CE(\fifo_rx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_rx_cnt[2]_i_1_n_0 ),
        .Q(\fifo_rx_cnt_reg_n_0_[2] ));
  FDCE \fifo_rx_cnt_reg[3] 
       (.C(clk_i),
        .CE(\fifo_rx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_rx_cnt[3]_i_1_n_0 ),
        .Q(\fifo_rx_cnt_reg_n_0_[3] ));
  FDCE \fifo_rx_cnt_reg[4] 
       (.C(clk_i),
        .CE(\fifo_rx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_rx_cnt[4]_i_1_n_0 ),
        .Q(\fifo_rx_cnt_reg_n_0_[4] ));
  FDCE \fifo_rx_cnt_reg[5] 
       (.C(clk_i),
        .CE(\fifo_rx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_rx_cnt[5]_i_1_n_0 ),
        .Q(\fifo_rx_cnt_reg_n_0_[5] ));
  FDCE \fifo_rx_cnt_reg[6] 
       (.C(clk_i),
        .CE(\fifo_rx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_rx_cnt[6]_i_2_n_0 ),
        .Q(\fifo_rx_cnt_reg_n_0_[6] ));
  LUT5 #(
    .INIT(32'h04000000)) 
    fifo_rx_pull_data_i_1
       (.I0(araddr[4]),
        .I1(araddr[3]),
        .I2(araddr[2]),
        .I3(arvalid),
        .I4(\rdata[31]_i_2_n_0 ),
        .O(fifo_rx_pull_data_i_1_n_0));
  FDCE fifo_rx_pull_data_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(fifo_rx_pull_data_i_1_n_0),
        .Q(fifo_rx_pull_data));
  FDRE \fifo_rx_rdata_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[0]),
        .Q(fifo_rx_rdata[0]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[10] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[10]),
        .Q(fifo_rx_rdata[10]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[11] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[11]),
        .Q(fifo_rx_rdata[11]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[12] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[12]),
        .Q(fifo_rx_rdata[12]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[13] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[13]),
        .Q(fifo_rx_rdata[13]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[14] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[14]),
        .Q(fifo_rx_rdata[14]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[15] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[15]),
        .Q(fifo_rx_rdata[15]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[16] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[16]),
        .Q(fifo_rx_rdata[16]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[17] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[17]),
        .Q(fifo_rx_rdata[17]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[18] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[18]),
        .Q(fifo_rx_rdata[18]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[19] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[19]),
        .Q(fifo_rx_rdata[19]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[1]),
        .Q(fifo_rx_rdata[1]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[20] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[20]),
        .Q(fifo_rx_rdata[20]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[21] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[21]),
        .Q(fifo_rx_rdata[21]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[22] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[22]),
        .Q(fifo_rx_rdata[22]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[23] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[23]),
        .Q(fifo_rx_rdata[23]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[24] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[24]),
        .Q(fifo_rx_rdata[24]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[25] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[25]),
        .Q(fifo_rx_rdata[25]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[26] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[26]),
        .Q(fifo_rx_rdata[26]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[27] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[27]),
        .Q(fifo_rx_rdata[27]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[28] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[28]),
        .Q(fifo_rx_rdata[28]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[29] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[29]),
        .Q(fifo_rx_rdata[29]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[2]),
        .Q(fifo_rx_rdata[2]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[30] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[30]),
        .Q(fifo_rx_rdata[30]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[31] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[31]),
        .Q(fifo_rx_rdata[31]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[3] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[3]),
        .Q(fifo_rx_rdata[3]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[4] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[4]),
        .Q(fifo_rx_rdata[4]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[5] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[5]),
        .Q(fifo_rx_rdata[5]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[6] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[6]),
        .Q(fifo_rx_rdata[6]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[7] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[7]),
        .Q(fifo_rx_rdata[7]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[8] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[8]),
        .Q(fifo_rx_rdata[8]),
        .R(1'b0));
  FDRE \fifo_rx_rdata_reg[9] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_rx_rdata0[9]),
        .Q(fifo_rx_rdata[9]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    \fifo_rx_wdata[31]_i_1 
       (.I0(fifo_rx_wr_en_i_1_n_0),
        .I1(rst_n),
        .O(\fifo_rx_wdata[31]_i_1_n_0 ));
  FDRE \fifo_rx_wdata_reg[0] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[24]),
        .Q(fifo_rx_wdata[0]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[10] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[18]),
        .Q(fifo_rx_wdata[10]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[11] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[19]),
        .Q(fifo_rx_wdata[11]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[12] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[20]),
        .Q(fifo_rx_wdata[12]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[13] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[21]),
        .Q(fifo_rx_wdata[13]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[14] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[22]),
        .Q(fifo_rx_wdata[14]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[15] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[23]),
        .Q(fifo_rx_wdata[15]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[16] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[8]),
        .Q(fifo_rx_wdata[16]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[17] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[9]),
        .Q(fifo_rx_wdata[17]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[18] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[10]),
        .Q(fifo_rx_wdata[18]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[19] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[11]),
        .Q(fifo_rx_wdata[19]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[1] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[25]),
        .Q(fifo_rx_wdata[1]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[20] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[12]),
        .Q(fifo_rx_wdata[20]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[21] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[13]),
        .Q(fifo_rx_wdata[21]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[22] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[14]),
        .Q(fifo_rx_wdata[22]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[23] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[15]),
        .Q(fifo_rx_wdata[23]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[24] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[0]),
        .Q(fifo_rx_wdata[24]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[25] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[1]),
        .Q(fifo_rx_wdata[25]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[26] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[2]),
        .Q(fifo_rx_wdata[26]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[27] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[3]),
        .Q(fifo_rx_wdata[27]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[28] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[4]),
        .Q(fifo_rx_wdata[28]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[29] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[5]),
        .Q(fifo_rx_wdata[29]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[2] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[26]),
        .Q(fifo_rx_wdata[2]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[30] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[6]),
        .Q(fifo_rx_wdata[30]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[31] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[7]),
        .Q(fifo_rx_wdata[31]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[3] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[27]),
        .Q(fifo_rx_wdata[3]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[4] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[28]),
        .Q(fifo_rx_wdata[4]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[5] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[29]),
        .Q(fifo_rx_wdata[5]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[6] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[30]),
        .Q(fifo_rx_wdata[6]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[7] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[31]),
        .Q(fifo_rx_wdata[7]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[8] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[16]),
        .Q(fifo_rx_wdata[8]),
        .R(1'b0));
  FDRE \fifo_rx_wdata_reg[9] 
       (.C(clk_i),
        .CE(\fifo_rx_wdata[31]_i_1_n_0 ),
        .D(shift_byte[17]),
        .Q(fifo_rx_wdata[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000002000000)) 
    fifo_rx_wr_en_i_1
       (.I0(\to_do_list_reg_n_0_[3] ),
        .I1(\to_do_list_reg_n_0_[2] ),
        .I2(\to_do_list_reg_n_0_[1] ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\fifo_status_reg_n_0_[0] ),
        .I5(r_w_reg_n_0),
        .O(fifo_rx_wr_en_i_1_n_0));
  FDCE fifo_rx_wr_en_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(fifo_rx_wr_en_i_1_n_0),
        .Q(fifo_rx_wr_en));
  LUT6 #(
    .INIT(64'h0100FFFFFF000000)) 
    \fifo_status[0]_i_1 
       (.I0(\to_do_list_reg_n_0_[3] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(\to_do_list_reg_n_0_[2] ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\fifo_status[1]_i_2_n_0 ),
        .I5(\fifo_status_reg_n_0_[0] ),
        .O(\fifo_status[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFFFFFFFF0000)) 
    \fifo_status[1]_i_1 
       (.I0(\to_do_list_reg_n_0_[2] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(\to_do_list_reg_n_0_[3] ),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\fifo_status[1]_i_2_n_0 ),
        .I5(\fifo_status_reg_n_0_[1] ),
        .O(\fifo_status[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEEEEEEEEEEEEFFEF)) 
    \fifo_status[1]_i_2 
       (.I0(\instr_shadow[7]_i_1_n_0 ),
        .I1(\fifo_status[1]_i_3_n_0 ),
        .I2(r_w_reg_n_0),
        .I3(qspi_falling_edge),
        .I4(\shift_byte[7]_i_3_n_0 ),
        .I5(\to_do_list[1]_i_3_n_0 ),
        .O(\fifo_status[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hD0D00000F0D00000)) 
    \fifo_status[1]_i_3 
       (.I0(\to_do_list_reg_n_0_[2] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(\fifo_status_reg_n_0_[1] ),
        .I3(qspi_falling_edge),
        .I4(\fifo_status_reg_n_0_[0] ),
        .I5(\dummy_cycle[4]_i_4_n_0 ),
        .O(\fifo_status[1]_i_3_n_0 ));
  FDPE \fifo_status_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .D(\fifo_status[0]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(\fifo_status_reg_n_0_[0] ));
  FDCE \fifo_status_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\fifo_status[1]_i_1_n_0 ),
        .Q(\fifo_status_reg_n_0_[1] ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h00AE)) 
    \fifo_tx_cnt[0]_i_1 
       (.I0(\tx_rd_ptr[5]_i_3_n_0 ),
        .I1(fifo_tx_push_data),
        .I2(p_0_in27_in),
        .I3(\fifo_tx_cnt_reg_n_0_[0] ),
        .O(\fifo_tx_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hF00F0440)) 
    \fifo_tx_cnt[1]_i_1 
       (.I0(p_0_in27_in),
        .I1(fifo_tx_push_data),
        .I2(\fifo_tx_cnt_reg_n_0_[1] ),
        .I3(\fifo_tx_cnt_reg_n_0_[0] ),
        .I4(\tx_rd_ptr[5]_i_3_n_0 ),
        .O(\fifo_tx_cnt[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAABABA10100000AA)) 
    \fifo_tx_cnt[2]_i_1 
       (.I0(\tx_rd_ptr[5]_i_3_n_0 ),
        .I1(p_0_in27_in),
        .I2(fifo_tx_push_data),
        .I3(\fifo_tx_cnt_reg_n_0_[1] ),
        .I4(\fifo_tx_cnt_reg_n_0_[0] ),
        .I5(\fifo_tx_cnt_reg_n_0_[2] ),
        .O(\fifo_tx_cnt[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAEEEEEE44000000A)) 
    \fifo_tx_cnt[3]_i_1 
       (.I0(\tx_rd_ptr[5]_i_3_n_0 ),
        .I1(fifo_tx_wr_en0),
        .I2(\fifo_tx_cnt_reg_n_0_[0] ),
        .I3(\fifo_tx_cnt_reg_n_0_[1] ),
        .I4(\fifo_tx_cnt_reg_n_0_[2] ),
        .I5(\fifo_tx_cnt_reg_n_0_[3] ),
        .O(\fifo_tx_cnt[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8B88888844444744)) 
    \fifo_tx_cnt[4]_i_1 
       (.I0(\fifo_tx_cnt[4]_i_2_n_0 ),
        .I1(\tx_rd_ptr[5]_i_3_n_0 ),
        .I2(p_0_in27_in),
        .I3(fifo_tx_push_data),
        .I4(\fifo_tx_cnt[4]_i_3_n_0 ),
        .I5(\fifo_tx_cnt_reg_n_0_[4] ),
        .O(\fifo_tx_cnt[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \fifo_tx_cnt[4]_i_2 
       (.I0(\fifo_tx_cnt_reg_n_0_[3] ),
        .I1(\fifo_tx_cnt_reg_n_0_[1] ),
        .I2(\fifo_tx_cnt_reg_n_0_[0] ),
        .I3(\fifo_tx_cnt_reg_n_0_[2] ),
        .O(\fifo_tx_cnt[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \fifo_tx_cnt[4]_i_3 
       (.I0(\fifo_tx_cnt_reg_n_0_[2] ),
        .I1(\fifo_tx_cnt_reg_n_0_[1] ),
        .I2(\fifo_tx_cnt_reg_n_0_[0] ),
        .I3(\fifo_tx_cnt_reg_n_0_[3] ),
        .O(\fifo_tx_cnt[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8B88888844444744)) 
    \fifo_tx_cnt[5]_i_1 
       (.I0(\fifo_tx_cnt[5]_i_2_n_0 ),
        .I1(\tx_rd_ptr[5]_i_3_n_0 ),
        .I2(p_0_in27_in),
        .I3(fifo_tx_push_data),
        .I4(\fifo_tx_cnt[5]_i_3_n_0 ),
        .I5(\fifo_tx_cnt_reg_n_0_[5] ),
        .O(\fifo_tx_cnt[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \fifo_tx_cnt[5]_i_2 
       (.I0(\fifo_tx_cnt_reg_n_0_[4] ),
        .I1(\fifo_tx_cnt_reg_n_0_[2] ),
        .I2(\fifo_tx_cnt_reg_n_0_[0] ),
        .I3(\fifo_tx_cnt_reg_n_0_[1] ),
        .I4(\fifo_tx_cnt_reg_n_0_[3] ),
        .O(\fifo_tx_cnt[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \fifo_tx_cnt[5]_i_3 
       (.I0(\fifo_tx_cnt_reg_n_0_[3] ),
        .I1(\fifo_tx_cnt_reg_n_0_[0] ),
        .I2(\fifo_tx_cnt_reg_n_0_[1] ),
        .I3(\fifo_tx_cnt_reg_n_0_[2] ),
        .I4(\fifo_tx_cnt_reg_n_0_[4] ),
        .O(\fifo_tx_cnt[5]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFFF4)) 
    \fifo_tx_cnt[6]_i_1 
       (.I0(p_0_in27_in),
        .I1(fifo_tx_push_data),
        .I2(\tx_rd_ptr[5]_i_3_n_0 ),
        .I3(\QSPI_FCR_reg_n_0_[1] ),
        .O(\fifo_tx_cnt[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00FFFF0010201020)) 
    \fifo_tx_cnt[6]_i_2 
       (.I0(\fifo_tx_cnt[6]_i_3_n_0 ),
        .I1(p_0_in27_in),
        .I2(fifo_tx_push_data),
        .I3(\fifo_tx_cnt_reg_n_0_[6] ),
        .I4(\fifo_tx_cnt[6]_i_4_n_0 ),
        .I5(\tx_rd_ptr[5]_i_3_n_0 ),
        .O(\fifo_tx_cnt[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \fifo_tx_cnt[6]_i_3 
       (.I0(\fifo_tx_cnt_reg_n_0_[5] ),
        .I1(\fifo_tx_cnt_reg_n_0_[4] ),
        .I2(\fifo_tx_cnt_reg_n_0_[2] ),
        .I3(\fifo_tx_cnt_reg_n_0_[1] ),
        .I4(\fifo_tx_cnt_reg_n_0_[0] ),
        .I5(\fifo_tx_cnt_reg_n_0_[3] ),
        .O(\fifo_tx_cnt[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \fifo_tx_cnt[6]_i_4 
       (.I0(\fifo_tx_cnt_reg_n_0_[5] ),
        .I1(\fifo_tx_cnt_reg_n_0_[3] ),
        .I2(\fifo_tx_cnt_reg_n_0_[1] ),
        .I3(\fifo_tx_cnt_reg_n_0_[0] ),
        .I4(\fifo_tx_cnt_reg_n_0_[2] ),
        .I5(\fifo_tx_cnt_reg_n_0_[4] ),
        .O(\fifo_tx_cnt[6]_i_4_n_0 ));
  FDCE \fifo_tx_cnt_reg[0] 
       (.C(clk_i),
        .CE(\fifo_tx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_tx_cnt[0]_i_1_n_0 ),
        .Q(\fifo_tx_cnt_reg_n_0_[0] ));
  FDCE \fifo_tx_cnt_reg[1] 
       (.C(clk_i),
        .CE(\fifo_tx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_tx_cnt[1]_i_1_n_0 ),
        .Q(\fifo_tx_cnt_reg_n_0_[1] ));
  FDCE \fifo_tx_cnt_reg[2] 
       (.C(clk_i),
        .CE(\fifo_tx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_tx_cnt[2]_i_1_n_0 ),
        .Q(\fifo_tx_cnt_reg_n_0_[2] ));
  FDCE \fifo_tx_cnt_reg[3] 
       (.C(clk_i),
        .CE(\fifo_tx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_tx_cnt[3]_i_1_n_0 ),
        .Q(\fifo_tx_cnt_reg_n_0_[3] ));
  FDCE \fifo_tx_cnt_reg[4] 
       (.C(clk_i),
        .CE(\fifo_tx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_tx_cnt[4]_i_1_n_0 ),
        .Q(\fifo_tx_cnt_reg_n_0_[4] ));
  FDCE \fifo_tx_cnt_reg[5] 
       (.C(clk_i),
        .CE(\fifo_tx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_tx_cnt[5]_i_1_n_0 ),
        .Q(\fifo_tx_cnt_reg_n_0_[5] ));
  FDCE \fifo_tx_cnt_reg[6] 
       (.C(clk_i),
        .CE(\fifo_tx_cnt[6]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\fifo_tx_cnt[6]_i_2_n_0 ),
        .Q(\fifo_tx_cnt_reg_n_0_[6] ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    fifo_tx_push_data_i_1
       (.I0(awaddr[2]),
        .I1(awaddr[1]),
        .I2(awaddr[0]),
        .I3(awaddr[4]),
        .I4(awaddr[3]),
        .I5(\QSPI_DR[31]_i_2_n_0 ),
        .O(fifo_tx_push_data_i_1_n_0));
  FDCE fifo_tx_push_data_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(fifo_tx_push_data_i_1_n_0),
        .Q(fifo_tx_push_data));
  FDRE \fifo_tx_rdata_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[0]),
        .Q(fifo_tx_rdata[0]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[10] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[10]),
        .Q(fifo_tx_rdata[10]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[11] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[11]),
        .Q(fifo_tx_rdata[11]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[12] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[12]),
        .Q(fifo_tx_rdata[12]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[13] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[13]),
        .Q(fifo_tx_rdata[13]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[14] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[14]),
        .Q(fifo_tx_rdata[14]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[15] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[15]),
        .Q(fifo_tx_rdata[15]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[16] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[16]),
        .Q(fifo_tx_rdata[16]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[17] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[17]),
        .Q(fifo_tx_rdata[17]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[18] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[18]),
        .Q(fifo_tx_rdata[18]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[19] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[19]),
        .Q(fifo_tx_rdata[19]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[1]),
        .Q(fifo_tx_rdata[1]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[20] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[20]),
        .Q(fifo_tx_rdata[20]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[21] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[21]),
        .Q(fifo_tx_rdata[21]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[22] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[22]),
        .Q(fifo_tx_rdata[22]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[23] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[23]),
        .Q(fifo_tx_rdata[23]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[24] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[24]),
        .Q(fifo_tx_rdata[24]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[25] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[25]),
        .Q(fifo_tx_rdata[25]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[26] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[26]),
        .Q(fifo_tx_rdata[26]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[27] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[27]),
        .Q(fifo_tx_rdata[27]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[28] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[28]),
        .Q(fifo_tx_rdata[28]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[29] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[29]),
        .Q(fifo_tx_rdata[29]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[2]),
        .Q(fifo_tx_rdata[2]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[30] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[30]),
        .Q(fifo_tx_rdata[30]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[31] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[31]),
        .Q(fifo_tx_rdata[31]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[3] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[3]),
        .Q(fifo_tx_rdata[3]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[4] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[4]),
        .Q(fifo_tx_rdata[4]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[5] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[5]),
        .Q(fifo_tx_rdata[5]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[6] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[6]),
        .Q(fifo_tx_rdata[6]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[7] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[7]),
        .Q(fifo_tx_rdata[7]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[8] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[8]),
        .Q(fifo_tx_rdata[8]),
        .R(1'b0));
  FDRE \fifo_tx_rdata_reg[9] 
       (.C(clk_i),
        .CE(1'b1),
        .D(fifo_tx_rdata0[9]),
        .Q(fifo_tx_rdata[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h40)) 
    \fifo_tx_wdata[31]_i_1 
       (.I0(p_0_in27_in),
        .I1(fifo_tx_push_data),
        .I2(rst_n),
        .O(\fifo_tx_wdata[31]_i_1_n_0 ));
  FDRE \fifo_tx_wdata_reg[0] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[0] ),
        .Q(fifo_tx_wdata[0]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[10] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[10] ),
        .Q(fifo_tx_wdata[10]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[11] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[11] ),
        .Q(fifo_tx_wdata[11]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[12] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[12] ),
        .Q(fifo_tx_wdata[12]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[13] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[13] ),
        .Q(fifo_tx_wdata[13]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[14] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[14] ),
        .Q(fifo_tx_wdata[14]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[15] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[15] ),
        .Q(fifo_tx_wdata[15]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[16] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[16] ),
        .Q(fifo_tx_wdata[16]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[17] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[17] ),
        .Q(fifo_tx_wdata[17]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[18] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[18] ),
        .Q(fifo_tx_wdata[18]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[19] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[19] ),
        .Q(fifo_tx_wdata[19]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[1] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[1] ),
        .Q(fifo_tx_wdata[1]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[20] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[20] ),
        .Q(fifo_tx_wdata[20]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[21] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[21] ),
        .Q(fifo_tx_wdata[21]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[22] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[22] ),
        .Q(fifo_tx_wdata[22]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[23] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[23] ),
        .Q(fifo_tx_wdata[23]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[24] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[24] ),
        .Q(fifo_tx_wdata[24]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[25] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[25] ),
        .Q(fifo_tx_wdata[25]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[26] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[26] ),
        .Q(fifo_tx_wdata[26]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[27] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[27] ),
        .Q(fifo_tx_wdata[27]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[28] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[28] ),
        .Q(fifo_tx_wdata[28]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[29] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[29] ),
        .Q(fifo_tx_wdata[29]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[2] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[2] ),
        .Q(fifo_tx_wdata[2]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[30] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[30] ),
        .Q(fifo_tx_wdata[30]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[31] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[31] ),
        .Q(fifo_tx_wdata[31]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[3] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[3] ),
        .Q(fifo_tx_wdata[3]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[4] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[4] ),
        .Q(fifo_tx_wdata[4]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[5] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[5] ),
        .Q(fifo_tx_wdata[5]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[6] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[6] ),
        .Q(fifo_tx_wdata[6]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[7] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[7] ),
        .Q(fifo_tx_wdata[7]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[8] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[8] ),
        .Q(fifo_tx_wdata[8]),
        .R(1'b0));
  FDRE \fifo_tx_wdata_reg[9] 
       (.C(clk_i),
        .CE(\fifo_tx_wdata[31]_i_1_n_0 ),
        .D(\QSPI_DR_reg_n_0_[9] ),
        .Q(fifo_tx_wdata[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h4)) 
    fifo_tx_wr_en_i_1
       (.I0(p_0_in27_in),
        .I1(fifo_tx_push_data),
        .O(fifo_tx_wr_en_i_1_n_0));
  FDCE fifo_tx_wr_en_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(fifo_tx_wr_en_i_1_n_0),
        .Q(fifo_tx_wr_en));
  LUT6 #(
    .INIT(64'h0000000054550000)) 
    \instr_shadow[7]_i_1 
       (.I0(\QSPI_STA_reg_n_0_[1] ),
        .I1(\instr_shadow[7]_i_2_n_0 ),
        .I2(\instr_shadow[7]_i_3_n_0 ),
        .I3(\instr_shadow[7]_i_4_n_0 ),
        .I4(\fifo_status_reg_n_0_[0] ),
        .I5(\fifo_status_reg_n_0_[1] ),
        .O(\instr_shadow[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6FF6FFFFFFFF6FF6)) 
    \instr_shadow[7]_i_2 
       (.I0(instr_shadow[0]),
        .I1(\QSPI_CCR_reg_n_0_[0] ),
        .I2(\QSPI_CCR_reg_n_0_[1] ),
        .I3(instr_shadow[1]),
        .I4(\QSPI_CCR_reg_n_0_[2] ),
        .I5(instr_shadow[2]),
        .O(\instr_shadow[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6FF6FFFFFFFF6FF6)) 
    \instr_shadow[7]_i_3 
       (.I0(instr_shadow[3]),
        .I1(\QSPI_CCR_reg_n_0_[3] ),
        .I2(\QSPI_CCR_reg_n_0_[5] ),
        .I3(instr_shadow[5]),
        .I4(\QSPI_CCR_reg_n_0_[4] ),
        .I5(instr_shadow[4]),
        .O(\instr_shadow[7]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \instr_shadow[7]_i_4 
       (.I0(instr_shadow[7]),
        .I1(\QSPI_CCR_reg_n_0_[7] ),
        .I2(instr_shadow[6]),
        .I3(\QSPI_CCR_reg_n_0_[6] ),
        .O(\instr_shadow[7]_i_4_n_0 ));
  FDCE \instr_shadow_reg[0] 
       (.C(clk_i),
        .CE(\instr_shadow[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\QSPI_CCR_reg_n_0_[0] ),
        .Q(instr_shadow[0]));
  FDCE \instr_shadow_reg[1] 
       (.C(clk_i),
        .CE(\instr_shadow[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\QSPI_CCR_reg_n_0_[1] ),
        .Q(instr_shadow[1]));
  FDCE \instr_shadow_reg[2] 
       (.C(clk_i),
        .CE(\instr_shadow[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\QSPI_CCR_reg_n_0_[2] ),
        .Q(instr_shadow[2]));
  FDCE \instr_shadow_reg[3] 
       (.C(clk_i),
        .CE(\instr_shadow[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\QSPI_CCR_reg_n_0_[3] ),
        .Q(instr_shadow[3]));
  FDCE \instr_shadow_reg[4] 
       (.C(clk_i),
        .CE(\instr_shadow[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\QSPI_CCR_reg_n_0_[4] ),
        .Q(instr_shadow[4]));
  FDCE \instr_shadow_reg[5] 
       (.C(clk_i),
        .CE(\instr_shadow[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\QSPI_CCR_reg_n_0_[5] ),
        .Q(instr_shadow[5]));
  FDCE \instr_shadow_reg[6] 
       (.C(clk_i),
        .CE(\instr_shadow[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\QSPI_CCR_reg_n_0_[6] ),
        .Q(instr_shadow[6]));
  FDCE \instr_shadow_reg[7] 
       (.C(clk_i),
        .CE(\instr_shadow[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\QSPI_CCR_reg_n_0_[7] ),
        .Q(instr_shadow[7]));
  LUT6 #(
    .INIT(64'hB8B8B8FFB8B8B800)) 
    io0_val_tristate_oe_i_1
       (.I0(io0_val_tristate_oe_i_2_n_0),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\QSPI_CCR_reg_n_0_[7] ),
        .I3(io0_val_tristate_oe_i_3_n_0),
        .I4(io0_val_tristate_oe_i_4_n_0),
        .I5(io0_val_tristate_oe_reg_n_0),
        .O(io0_val_tristate_oe_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    io0_val_tristate_oe_i_2
       (.I0(data_mode__0[2]),
        .I1(shift_byte[28]),
        .I2(shift_byte[31]),
        .I3(data_mode__0[0]),
        .I4(shift_byte[30]),
        .I5(data_mode__0[1]),
        .O(io0_val_tristate_oe_i_2_n_0));
  LUT4 #(
    .INIT(16'hBAAA)) 
    io0_val_tristate_oe_i_3
       (.I0(\instr_shadow[7]_i_1_n_0 ),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\fifo_status_reg_n_0_[0] ),
        .I3(qspi_falling_edge),
        .O(io0_val_tristate_oe_i_3_n_0));
  LUT6 #(
    .INIT(64'h4000000044440044)) 
    io0_val_tristate_oe_i_4
       (.I0(\fifo_status_reg_n_0_[0] ),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\shift_byte[7]_i_4_n_0 ),
        .I3(r_w_reg_n_0),
        .I4(qspi_falling_edge),
        .I5(\to_do_list[1]_i_3_n_0 ),
        .O(io0_val_tristate_oe_i_4_n_0));
  FDRE io0_val_tristate_oe_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(io0_val_tristate_oe_i_1_n_0),
        .Q(io0_val_tristate_oe_reg_n_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hB8B8B8FFB8B8B800)) 
    io1_val_tristate_oe_i_1
       (.I0(shift_byte[29]),
        .I1(data_mode__0[2]),
        .I2(shift_byte[31]),
        .I3(\data_mode[2]_i_2_n_0 ),
        .I4(io1_val_tristate_oe_i_2_n_0),
        .I5(io1_val_tristate_oe_reg_n_0),
        .O(io1_val_tristate_oe_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000400051515151)) 
    io1_val_tristate_oe_i_2
       (.I0(\shift_byte[7]_i_3_n_0 ),
        .I1(r_w_reg_n_0),
        .I2(qspi_falling_edge),
        .I3(io1_val_tristate_oe_i_3_n_0),
        .I4(data_mode__0[0]),
        .I5(\to_do_list[1]_i_3_n_0 ),
        .O(io1_val_tristate_oe_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    io1_val_tristate_oe_i_3
       (.I0(data_mode__0[2]),
        .I1(data_mode__0[1]),
        .O(io1_val_tristate_oe_i_3_n_0));
  FDRE io1_val_tristate_oe_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(io1_val_tristate_oe_i_1_n_0),
        .Q(io1_val_tristate_oe_reg_n_0),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hBABB8A88)) 
    io2_val_tristate_oe_i_1
       (.I0(shift_byte[30]),
        .I1(\data_mode[2]_i_2_n_0 ),
        .I2(io2_val_tristate_oe_i_2_n_0),
        .I3(io2_val_tristate_oe_i_3_n_0),
        .I4(io2_val_tristate_oe_reg_n_0),
        .O(io2_val_tristate_oe_i_1_n_0));
  LUT6 #(
    .INIT(64'hAA8AAAAAAAAAAAAA)) 
    io2_val_tristate_oe_i_2
       (.I0(\to_do_list[1]_i_3_n_0 ),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[2]),
        .I3(data_mode__0[0]),
        .I4(qspi_falling_edge),
        .I5(r_w_reg_n_0),
        .O(io2_val_tristate_oe_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'h0000F100)) 
    io2_val_tristate_oe_i_3
       (.I0(r_w_reg_n_0),
        .I1(\to_do_list[1]_i_3_n_0 ),
        .I2(qspi_falling_edge),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\fifo_status_reg_n_0_[0] ),
        .O(io2_val_tristate_oe_i_3_n_0));
  FDRE io2_val_tristate_oe_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(io2_val_tristate_oe_i_1_n_0),
        .Q(io2_val_tristate_oe_reg_n_0),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hBABB8A88)) 
    io3_val_tristate_oe_i_1
       (.I0(shift_byte[31]),
        .I1(\data_mode[2]_i_2_n_0 ),
        .I2(io2_val_tristate_oe_i_2_n_0),
        .I3(io2_val_tristate_oe_i_3_n_0),
        .I4(io3_val_tristate_oe_reg_n_0),
        .O(io3_val_tristate_oe_i_1_n_0));
  FDRE io3_val_tristate_oe_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(io3_val_tristate_oe_i_1_n_0),
        .Q(io3_val_tristate_oe_reg_n_0),
        .R(1'b0));
  CARRY4 prscl_cnt1_carry
       (.CI(1'b0),
        .CO({prscl_cnt1_carry_n_0,prscl_cnt1_carry_n_1,prscl_cnt1_carry_n_2,prscl_cnt1_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_prscl_cnt1_carry_O_UNCONNECTED[3:0]),
        .S({prscl_cnt1_carry_i_1_n_0,prscl_cnt1_carry_i_2_n_0,prscl_cnt1_carry_i_3_n_0,prscl_cnt1_carry_i_4_n_0}));
  CARRY4 prscl_cnt1_carry__0
       (.CI(prscl_cnt1_carry_n_0),
        .CO({prscl_cnt1_carry__0_n_0,prscl_cnt1_carry__0_n_1,prscl_cnt1_carry__0_n_2,prscl_cnt1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_prscl_cnt1_carry__0_O_UNCONNECTED[3:0]),
        .S({prscl_cnt1_carry__0_i_1_n_0,prscl_cnt1_carry__0_i_2_n_0,prscl_cnt1_carry__0_i_3_n_0,prscl_cnt1_carry__0_i_4_n_0}));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    prscl_cnt1_carry__0_i_1
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(prscl_cnt1_carry__0_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    prscl_cnt1_carry__0_i_2
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(prscl_cnt1_carry__0_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    prscl_cnt1_carry__0_i_3
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(prscl_cnt1_carry__0_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    prscl_cnt1_carry__0_i_4
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(prscl_cnt1_carry__0_i_4_n_0));
  CARRY4 prscl_cnt1_carry__1
       (.CI(prscl_cnt1_carry__0_n_0),
        .CO({NLW_prscl_cnt1_carry__1_CO_UNCONNECTED[3],prscl_cnt1,prscl_cnt1_carry__1_n_2,prscl_cnt1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_prscl_cnt1_carry__1_O_UNCONNECTED[3:0]),
        .S({1'b0,prscl_cnt1_carry__1_i_1_n_0,prscl_cnt1_carry__1_i_2_n_0,prscl_cnt1_carry__1_i_3_n_0}));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    prscl_cnt1_carry__1_i_1
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(prscl_cnt1_carry__1_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    prscl_cnt1_carry__1_i_2
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(prscl_cnt1_carry__1_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    prscl_cnt1_carry__1_i_3
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(prscl_cnt1_carry__1_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    prscl_cnt1_carry_i_1
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(prscl_cnt1_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    prscl_cnt1_carry_i_2
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(prscl_cnt1_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h0069)) 
    prscl_cnt1_carry_i_3
       (.I0(p_0_in_0[5]),
        .I1(prscl_cnt1_carry_i_5_n_0),
        .I2(prscl_cnt_reg[5]),
        .I3(prscl_cnt1_carry_i_6_n_0),
        .O(prscl_cnt1_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h4120000800084120)) 
    prscl_cnt1_carry_i_4
       (.I0(prscl_cnt_reg[0]),
        .I1(prscl_cnt_reg[1]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[0]),
        .I4(prscl_cnt_reg[2]),
        .I5(p_0_in_0[2]),
        .O(prscl_cnt1_carry_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    prscl_cnt1_carry_i_5
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[4]),
        .I2(p_0_in_0[2]),
        .I3(p_0_in_0[1]),
        .I4(p_0_in_0[0]),
        .O(prscl_cnt1_carry_i_5_n_0));
  LUT6 #(
    .INIT(64'h777BBBBDDDDEEEE7)) 
    prscl_cnt1_carry_i_6
       (.I0(prscl_cnt_reg[3]),
        .I1(p_0_in_0[4]),
        .I2(p_0_in_0[2]),
        .I3(prscl_cnt1_carry_i_7_n_0),
        .I4(p_0_in_0[3]),
        .I5(prscl_cnt_reg[4]),
        .O(prscl_cnt1_carry_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'hE)) 
    prscl_cnt1_carry_i_7
       (.I0(p_0_in_0[0]),
        .I1(p_0_in_0[1]),
        .O(prscl_cnt1_carry_i_7_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    \prscl_cnt[0]_i_1 
       (.I0(prscl_cnt1),
        .I1(prscl_cnt_reg[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \prscl_cnt[1]_i_1 
       (.I0(prscl_cnt_reg[1]),
        .I1(prscl_cnt_reg[0]),
        .I2(prscl_cnt1),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h1540)) 
    \prscl_cnt[2]_i_1 
       (.I0(prscl_cnt1),
        .I1(prscl_cnt_reg[0]),
        .I2(prscl_cnt_reg[1]),
        .I3(prscl_cnt_reg[2]),
        .O(\prscl_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h15554000)) 
    \prscl_cnt[3]_i_1 
       (.I0(prscl_cnt1),
        .I1(prscl_cnt_reg[1]),
        .I2(prscl_cnt_reg[0]),
        .I3(prscl_cnt_reg[2]),
        .I4(prscl_cnt_reg[3]),
        .O(\prscl_cnt[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1555555540000000)) 
    \prscl_cnt[4]_i_1 
       (.I0(prscl_cnt1),
        .I1(prscl_cnt_reg[0]),
        .I2(prscl_cnt_reg[3]),
        .I3(prscl_cnt_reg[1]),
        .I4(prscl_cnt_reg[2]),
        .I5(prscl_cnt_reg[4]),
        .O(\prscl_cnt[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'h5104)) 
    \prscl_cnt[5]_i_1 
       (.I0(prscl_cnt1),
        .I1(prscl_cnt_reg[0]),
        .I2(\prscl_cnt[5]_i_2_n_0 ),
        .I3(prscl_cnt_reg[5]),
        .O(\prscl_cnt[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \prscl_cnt[5]_i_2 
       (.I0(prscl_cnt_reg[3]),
        .I1(prscl_cnt_reg[1]),
        .I2(prscl_cnt_reg[2]),
        .I3(prscl_cnt_reg[4]),
        .O(\prscl_cnt[5]_i_2_n_0 ));
  FDCE \prscl_cnt_reg[0] 
       (.C(clk_i),
        .CE(p_11_in),
        .CLR(rst_n_0),
        .D(p_0_in[0]),
        .Q(prscl_cnt_reg[0]));
  FDCE \prscl_cnt_reg[1] 
       (.C(clk_i),
        .CE(p_11_in),
        .CLR(rst_n_0),
        .D(p_0_in[1]),
        .Q(prscl_cnt_reg[1]));
  FDCE \prscl_cnt_reg[2] 
       (.C(clk_i),
        .CE(p_11_in),
        .CLR(rst_n_0),
        .D(\prscl_cnt[2]_i_1_n_0 ),
        .Q(prscl_cnt_reg[2]));
  FDCE \prscl_cnt_reg[3] 
       (.C(clk_i),
        .CE(p_11_in),
        .CLR(rst_n_0),
        .D(\prscl_cnt[3]_i_1_n_0 ),
        .Q(prscl_cnt_reg[3]));
  FDCE \prscl_cnt_reg[4] 
       (.C(clk_i),
        .CE(p_11_in),
        .CLR(rst_n_0),
        .D(\prscl_cnt[4]_i_1_n_0 ),
        .Q(prscl_cnt_reg[4]));
  FDCE \prscl_cnt_reg[5] 
       (.C(clk_i),
        .CE(p_11_in),
        .CLR(rst_n_0),
        .D(\prscl_cnt[5]_i_1_n_0 ),
        .Q(prscl_cnt_reg[5]));
  LUT1 #(
    .INIT(2'h1)) 
    qspi_falling_edge_i_1
       (.I0(QSPI_CS_reg_0),
        .O(p_11_in));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    qspi_falling_edge_i_2
       (.I0(qspi_falling_edge_i_3_n_0),
        .I1(QSPI_SCLK_reg_0),
        .I2(qspi_falling_edge_i_4_n_0),
        .O(qspi_falling_edge_i_2_n_0));
  LUT6 #(
    .INIT(64'h4004100100400410)) 
    qspi_falling_edge_i_3
       (.I0(qspi_falling_edge_i_5_n_0),
        .I1(p_0_in_0[5]),
        .I2(qspi_falling_edge_i_6_n_0),
        .I3(prscl_cnt_reg[4]),
        .I4(prscl_cnt_reg[5]),
        .I5(p_0_in_0[4]),
        .O(qspi_falling_edge_i_3_n_0));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    qspi_falling_edge_i_4
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[4]),
        .I2(p_0_in_0[2]),
        .I3(p_0_in_0[1]),
        .I4(p_0_in_0[5]),
        .I5(p_0_in_0[0]),
        .O(qspi_falling_edge_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'hEBBBBEEE)) 
    qspi_falling_edge_i_5
       (.I0(qspi_falling_edge_i_7_n_0),
        .I1(prscl_cnt_reg[3]),
        .I2(prscl_cnt_reg[2]),
        .I3(prscl_cnt_reg[1]),
        .I4(p_0_in_0[3]),
        .O(qspi_falling_edge_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    qspi_falling_edge_i_6
       (.I0(prscl_cnt_reg[2]),
        .I1(prscl_cnt_reg[1]),
        .I2(prscl_cnt_reg[3]),
        .O(qspi_falling_edge_i_6_n_0));
  LUT6 #(
    .INIT(64'hF6FFFF6FFF6FF6FF)) 
    qspi_falling_edge_i_7
       (.I0(p_0_in_0[0]),
        .I1(prscl_cnt_reg[0]),
        .I2(prscl_cnt_reg[1]),
        .I3(p_0_in_0[1]),
        .I4(p_0_in_0[2]),
        .I5(prscl_cnt_reg[2]),
        .O(qspi_falling_edge_i_7_n_0));
  FDCE qspi_falling_edge_reg
       (.C(clk_i),
        .CE(p_11_in),
        .CLR(rst_n_0),
        .D(qspi_falling_edge_i_2_n_0),
        .Q(qspi_falling_edge));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    qspi_rising_edge_i_1
       (.I0(qspi_falling_edge_i_4_n_0),
        .I1(QSPI_SCLK_reg_0),
        .I2(qspi_falling_edge_i_3_n_0),
        .O(qspi_rising_edge_i_1_n_0));
  FDCE qspi_rising_edge_reg
       (.C(clk_i),
        .CE(p_11_in),
        .CLR(rst_n_0),
        .D(qspi_rising_edge_i_1_n_0),
        .Q(qspi_rising_edge));
  LUT6 #(
    .INIT(64'hBB88FFFFBB883000)) 
    r_w_i_1
       (.I0(\QSPI_CCR_reg_n_0_[10] ),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\fifo_status_reg_n_0_[0] ),
        .I3(busy0),
        .I4(\to_do_list[1]_i_2_n_0 ),
        .I5(r_w_reg_n_0),
        .O(r_w_i_1_n_0));
  FDCE r_w_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(r_w_i_1_n_0),
        .Q(r_w_reg_n_0));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[0]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[0]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(p_1_in),
        .O(\rdata[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[0]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[0] ),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[0] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[0] ),
        .I5(araddr[4]),
        .O(\rdata[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[10]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[10]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[10] ),
        .O(\rdata[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FAC000000AC)) 
    \rdata[10]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[10] ),
        .I1(\QSPI_CCR_reg_n_0_[10] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[10] ),
        .O(\rdata[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[11]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[11]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[11] ),
        .O(\rdata[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FCA000000CA)) 
    \rdata[11]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[11] ),
        .I1(\QSPI_ADR_reg_n_0_[11] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[11] ),
        .O(\rdata[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[12]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[12]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[12] ),
        .O(\rdata[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FAC000000AC)) 
    \rdata[12]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[12] ),
        .I1(\QSPI_CCR_reg_n_0_[12] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[12] ),
        .O(\rdata[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[13]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[13]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[13] ),
        .O(\rdata[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[13]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[13] ),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[13] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[13] ),
        .I5(araddr[4]),
        .O(\rdata[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[14]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[14]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[14] ),
        .O(\rdata[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FCA000000CA)) 
    \rdata[14]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[14] ),
        .I1(\QSPI_ADR_reg_n_0_[14] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[14] ),
        .O(\rdata[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[15]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[15]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[15] ),
        .O(\rdata[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FAC000000AC)) 
    \rdata[15]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[15] ),
        .I1(\QSPI_CCR_reg_n_0_[15] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[15] ),
        .O(\rdata[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[16]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[16]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[16] ),
        .O(\rdata[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[16]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[16] ),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[16] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[16] ),
        .I5(araddr[4]),
        .O(\rdata[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[17]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[17]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[17] ),
        .O(\rdata[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FCA000000CA)) 
    \rdata[17]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[17] ),
        .I1(\QSPI_ADR_reg_n_0_[17] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[17] ),
        .O(\rdata[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[18]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[18]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[18] ),
        .O(\rdata[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FAC000000AC)) 
    \rdata[18]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[18] ),
        .I1(\QSPI_CCR_reg_n_0_[18] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[18] ),
        .O(\rdata[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[19]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[19]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[19] ),
        .O(\rdata[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FAC000000AC)) 
    \rdata[19]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[19] ),
        .I1(\QSPI_CCR_reg_n_0_[19] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[19] ),
        .O(\rdata[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h080808A808080808)) 
    \rdata[1]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[1]_i_2_n_0 ),
        .I2(araddr[4]),
        .I3(araddr[3]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[1] ),
        .O(\rdata[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[1]_i_2 
       (.I0(\QSPI_STA_reg_n_0_[1] ),
        .I1(\QSPI_DR_read_reg_n_0_[1] ),
        .I2(araddr[3]),
        .I3(\QSPI_ADR_reg_n_0_[1] ),
        .I4(araddr[2]),
        .I5(\QSPI_CCR_reg_n_0_[1] ),
        .O(\rdata[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[20]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[20]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[20] ),
        .O(\rdata[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FAC000000AC)) 
    \rdata[20]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[20] ),
        .I1(\QSPI_CCR_reg_n_0_[20] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[20] ),
        .O(\rdata[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[21]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[21]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[21] ),
        .O(\rdata[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[21]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[21] ),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[21] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[21] ),
        .I5(araddr[4]),
        .O(\rdata[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[22]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[22]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[22] ),
        .O(\rdata[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FAC000000AC)) 
    \rdata[22]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[22] ),
        .I1(\QSPI_CCR_reg_n_0_[22] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[22] ),
        .O(\rdata[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[23]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[23]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[23] ),
        .O(\rdata[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FCA000000CA)) 
    \rdata[23]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[23] ),
        .I1(\QSPI_ADR_reg_n_0_[23] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[23] ),
        .O(\rdata[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[24]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[24]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[24] ),
        .O(\rdata[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[24]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[24] ),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[24] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[24] ),
        .I5(araddr[4]),
        .O(\rdata[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[25]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[25]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[25] ),
        .O(\rdata[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[25]_i_2 
       (.I0(p_0_in_0[0]),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[25] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[25] ),
        .I5(araddr[4]),
        .O(\rdata[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[26]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[26]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[26] ),
        .O(\rdata[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[26]_i_2 
       (.I0(p_0_in_0[1]),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[26] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[26] ),
        .I5(araddr[4]),
        .O(\rdata[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[27]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[27]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[27] ),
        .O(\rdata[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[27]_i_2 
       (.I0(p_0_in_0[2]),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[27] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[27] ),
        .I5(araddr[4]),
        .O(\rdata[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[28]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[28]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[28] ),
        .O(\rdata[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000FAC000000AC)) 
    \rdata[28]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[28] ),
        .I1(p_0_in_0[3]),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(araddr[4]),
        .I5(\QSPI_DR_read_reg_n_0_[28] ),
        .O(\rdata[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[29]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[29]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[29] ),
        .O(\rdata[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[29]_i_2 
       (.I0(p_0_in_0[4]),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[29] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[29] ),
        .I5(araddr[4]),
        .O(\rdata[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[2]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[2]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[2] ),
        .O(\rdata[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[2]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[2] ),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[2] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[2] ),
        .I5(araddr[4]),
        .O(\rdata[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[30]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[30]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[30] ),
        .O(\rdata[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[30]_i_2 
       (.I0(p_0_in_0[5]),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[30] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[30] ),
        .I5(araddr[4]),
        .O(\rdata[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[31]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[31] ),
        .O(\rdata[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \rdata[31]_i_2 
       (.I0(araddr[5]),
        .I1(araddr[6]),
        .I2(araddr[7]),
        .I3(araddr[0]),
        .I4(araddr[1]),
        .O(\rdata[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[31]_i_3 
       (.I0(p_0_in0),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[31] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[31] ),
        .I5(araddr[4]),
        .O(\rdata[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h88888A8888888888)) 
    \rdata[3]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[3]_i_2_n_0 ),
        .I2(araddr[3]),
        .I3(araddr[4]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[3] ),
        .O(\rdata[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000033E200E2)) 
    \rdata[3]_i_2 
       (.I0(\QSPI_CCR_reg_n_0_[3] ),
        .I1(araddr[2]),
        .I2(\QSPI_ADR_reg_n_0_[3] ),
        .I3(araddr[3]),
        .I4(\QSPI_DR_read_reg_n_0_[3] ),
        .I5(araddr[4]),
        .O(\rdata[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h080808A808080808)) 
    \rdata[4]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[4]_i_2_n_0 ),
        .I2(araddr[4]),
        .I3(araddr[3]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[4] ),
        .O(\rdata[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[4]_i_2 
       (.I0(\QSPI_STA_reg_n_0_[4] ),
        .I1(\QSPI_DR_read_reg_n_0_[4] ),
        .I2(araddr[3]),
        .I3(\QSPI_ADR_reg_n_0_[4] ),
        .I4(araddr[2]),
        .I5(\QSPI_CCR_reg_n_0_[4] ),
        .O(\rdata[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h080808A808080808)) 
    \rdata[5]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[5]_i_2_n_0 ),
        .I2(araddr[4]),
        .I3(araddr[3]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[5] ),
        .O(\rdata[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[5]_i_2 
       (.I0(\QSPI_STA_reg_n_0_[5] ),
        .I1(\QSPI_DR_read_reg_n_0_[5] ),
        .I2(araddr[3]),
        .I3(\QSPI_ADR_reg_n_0_[5] ),
        .I4(araddr[2]),
        .I5(\QSPI_CCR_reg_n_0_[5] ),
        .O(\rdata[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h080808A808080808)) 
    \rdata[6]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[6]_i_2_n_0 ),
        .I2(araddr[4]),
        .I3(araddr[3]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[6] ),
        .O(\rdata[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[6]_i_2 
       (.I0(p_0_in27_in),
        .I1(\QSPI_DR_read_reg_n_0_[6] ),
        .I2(araddr[3]),
        .I3(\QSPI_ADR_reg_n_0_[6] ),
        .I4(araddr[2]),
        .I5(\QSPI_CCR_reg_n_0_[6] ),
        .O(\rdata[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h080808A808080808)) 
    \rdata[7]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[7]_i_2_n_0 ),
        .I2(araddr[4]),
        .I3(araddr[3]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[7] ),
        .O(\rdata[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[7]_i_2 
       (.I0(\QSPI_STA_reg_n_0_[7] ),
        .I1(\QSPI_DR_read_reg_n_0_[7] ),
        .I2(araddr[3]),
        .I3(\QSPI_ADR_reg_n_0_[7] ),
        .I4(araddr[2]),
        .I5(\QSPI_CCR_reg_n_0_[7] ),
        .O(\rdata[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h080808A808080808)) 
    \rdata[8]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[8]_i_2_n_0 ),
        .I2(araddr[4]),
        .I3(araddr[3]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[8] ),
        .O(\rdata[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[8]_i_2 
       (.I0(\QSPI_STA_reg_n_0_[8] ),
        .I1(\QSPI_DR_read_reg_n_0_[8] ),
        .I2(araddr[3]),
        .I3(\QSPI_ADR_reg_n_0_[8] ),
        .I4(araddr[2]),
        .I5(data2[0]),
        .O(\rdata[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h080808A808080808)) 
    \rdata[9]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[9]_i_2_n_0 ),
        .I2(araddr[4]),
        .I3(araddr[3]),
        .I4(araddr[2]),
        .I5(\QSPI_FCR_reg_n_0_[9] ),
        .O(\rdata[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[9]_i_2 
       (.I0(\QSPI_STA_reg_n_0_[9] ),
        .I1(\QSPI_DR_read_reg_n_0_[9] ),
        .I2(araddr[3]),
        .I3(\QSPI_ADR_reg_n_0_[9] ),
        .I4(araddr[2]),
        .I5(data2[1]),
        .O(\rdata[9]_i_2_n_0 ));
  FDCE \rdata_reg[0] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[0]_i_1_n_0 ),
        .Q(rdata[0]));
  FDCE \rdata_reg[10] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[10]_i_1_n_0 ),
        .Q(rdata[10]));
  FDCE \rdata_reg[11] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[11]_i_1_n_0 ),
        .Q(rdata[11]));
  FDCE \rdata_reg[12] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[12]_i_1_n_0 ),
        .Q(rdata[12]));
  FDCE \rdata_reg[13] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[13]_i_1_n_0 ),
        .Q(rdata[13]));
  FDCE \rdata_reg[14] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[14]_i_1_n_0 ),
        .Q(rdata[14]));
  FDCE \rdata_reg[15] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[15]_i_1_n_0 ),
        .Q(rdata[15]));
  FDCE \rdata_reg[16] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[16]_i_1_n_0 ),
        .Q(rdata[16]));
  FDCE \rdata_reg[17] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[17]_i_1_n_0 ),
        .Q(rdata[17]));
  FDCE \rdata_reg[18] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[18]_i_1_n_0 ),
        .Q(rdata[18]));
  FDCE \rdata_reg[19] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[19]_i_1_n_0 ),
        .Q(rdata[19]));
  FDCE \rdata_reg[1] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[1]_i_1_n_0 ),
        .Q(rdata[1]));
  FDCE \rdata_reg[20] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[20]_i_1_n_0 ),
        .Q(rdata[20]));
  FDCE \rdata_reg[21] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[21]_i_1_n_0 ),
        .Q(rdata[21]));
  FDCE \rdata_reg[22] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[22]_i_1_n_0 ),
        .Q(rdata[22]));
  FDCE \rdata_reg[23] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[23]_i_1_n_0 ),
        .Q(rdata[23]));
  FDCE \rdata_reg[24] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[24]_i_1_n_0 ),
        .Q(rdata[24]));
  FDCE \rdata_reg[25] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[25]_i_1_n_0 ),
        .Q(rdata[25]));
  FDCE \rdata_reg[26] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[26]_i_1_n_0 ),
        .Q(rdata[26]));
  FDCE \rdata_reg[27] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[27]_i_1_n_0 ),
        .Q(rdata[27]));
  FDCE \rdata_reg[28] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[28]_i_1_n_0 ),
        .Q(rdata[28]));
  FDCE \rdata_reg[29] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[29]_i_1_n_0 ),
        .Q(rdata[29]));
  FDCE \rdata_reg[2] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[2]_i_1_n_0 ),
        .Q(rdata[2]));
  FDCE \rdata_reg[30] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[30]_i_1_n_0 ),
        .Q(rdata[30]));
  FDCE \rdata_reg[31] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[31]_i_1_n_0 ),
        .Q(rdata[31]));
  FDCE \rdata_reg[3] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[3]_i_1_n_0 ),
        .Q(rdata[3]));
  FDCE \rdata_reg[4] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[4]_i_1_n_0 ),
        .Q(rdata[4]));
  FDCE \rdata_reg[5] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[5]_i_1_n_0 ),
        .Q(rdata[5]));
  FDCE \rdata_reg[6] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[6]_i_1_n_0 ),
        .Q(rdata[6]));
  FDCE \rdata_reg[7] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[7]_i_1_n_0 ),
        .Q(rdata[7]));
  FDCE \rdata_reg[8] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[8]_i_1_n_0 ),
        .Q(rdata[8]));
  FDCE \rdata_reg[9] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(rst_n_0),
        .D(\rdata[9]_i_1_n_0 ),
        .Q(rdata[9]));
  LUT3 #(
    .INIT(8'hBA)) 
    rvalid_i_1
       (.I0(arvalid),
        .I1(rready),
        .I2(rvalid),
        .O(rvalid_i_1_n_0));
  FDCE rvalid_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(rvalid_i_1_n_0),
        .Q(rvalid));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    rx_pull_once_i_1
       (.I0(rx_pull_once_reg_n_0),
        .I1(\to_do_list_reg_n_0_[2] ),
        .I2(\to_do_list_reg_n_0_[1] ),
        .I3(\to_do_list_reg_n_0_[3] ),
        .I4(\to_do_list[2]_i_2_n_0 ),
        .I5(r_w_reg_n_0),
        .O(rx_pull_once_i_1_n_0));
  FDCE rx_pull_once_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(rx_pull_once_i_1_n_0),
        .Q(rx_pull_once_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h000E)) 
    \rx_rd_ptr[0]_i_1 
       (.I0(rx_pull_once_reg_n_0),
        .I1(fifo_rx_pull_data),
        .I2(\QSPI_STA_reg_n_0_[5] ),
        .I3(rx_rd_ptr[0]),
        .O(\rx_rd_ptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h000E0E00)) 
    \rx_rd_ptr[1]_i_1 
       (.I0(rx_pull_once_reg_n_0),
        .I1(fifo_rx_pull_data),
        .I2(\QSPI_STA_reg_n_0_[5] ),
        .I3(rx_rd_ptr[1]),
        .I4(rx_rd_ptr[0]),
        .O(\rx_rd_ptr[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000E0E0E0E000000)) 
    \rx_rd_ptr[2]_i_1 
       (.I0(rx_pull_once_reg_n_0),
        .I1(fifo_rx_pull_data),
        .I2(\QSPI_STA_reg_n_0_[5] ),
        .I3(rx_rd_ptr[0]),
        .I4(rx_rd_ptr[1]),
        .I5(rx_rd_ptr[2]),
        .O(\rx_rd_ptr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h2AAA8000)) 
    \rx_rd_ptr[3]_i_1 
       (.I0(\rx_rd_ptr[4]_i_2_n_0 ),
        .I1(rx_rd_ptr[1]),
        .I2(rx_rd_ptr[0]),
        .I3(rx_rd_ptr[2]),
        .I4(rx_rd_ptr[3]),
        .O(\rx_rd_ptr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2AAAAAAA80000000)) 
    \rx_rd_ptr[4]_i_1 
       (.I0(\rx_rd_ptr[4]_i_2_n_0 ),
        .I1(rx_rd_ptr[2]),
        .I2(rx_rd_ptr[0]),
        .I3(rx_rd_ptr[1]),
        .I4(rx_rd_ptr[3]),
        .I5(rx_rd_ptr[4]),
        .O(\rx_rd_ptr[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h54)) 
    \rx_rd_ptr[4]_i_2 
       (.I0(\QSPI_STA_reg_n_0_[5] ),
        .I1(fifo_rx_pull_data),
        .I2(rx_pull_once_reg_n_0),
        .O(\rx_rd_ptr[4]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hAAFE)) 
    \rx_rd_ptr[5]_i_1 
       (.I0(p_1_in),
        .I1(rx_pull_once_reg_n_0),
        .I2(fifo_rx_pull_data),
        .I3(\QSPI_STA_reg_n_0_[5] ),
        .O(\rx_rd_ptr[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0E000E0E000E0000)) 
    \rx_rd_ptr[5]_i_2 
       (.I0(rx_pull_once_reg_n_0),
        .I1(fifo_rx_pull_data),
        .I2(\QSPI_STA_reg_n_0_[5] ),
        .I3(\rx_rd_ptr[5]_i_3_n_0 ),
        .I4(rx_rd_ptr[4]),
        .I5(rx_rd_ptr[5]),
        .O(\rx_rd_ptr[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \rx_rd_ptr[5]_i_3 
       (.I0(rx_rd_ptr[2]),
        .I1(rx_rd_ptr[0]),
        .I2(rx_rd_ptr[1]),
        .I3(rx_rd_ptr[3]),
        .O(\rx_rd_ptr[5]_i_3_n_0 ));
  FDCE \rx_rd_ptr_reg[0] 
       (.C(clk_i),
        .CE(\rx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\rx_rd_ptr[0]_i_1_n_0 ),
        .Q(rx_rd_ptr[0]));
  FDCE \rx_rd_ptr_reg[1] 
       (.C(clk_i),
        .CE(\rx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\rx_rd_ptr[1]_i_1_n_0 ),
        .Q(rx_rd_ptr[1]));
  FDCE \rx_rd_ptr_reg[2] 
       (.C(clk_i),
        .CE(\rx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\rx_rd_ptr[2]_i_1_n_0 ),
        .Q(rx_rd_ptr[2]));
  FDCE \rx_rd_ptr_reg[3] 
       (.C(clk_i),
        .CE(\rx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\rx_rd_ptr[3]_i_1_n_0 ),
        .Q(rx_rd_ptr[3]));
  FDCE \rx_rd_ptr_reg[4] 
       (.C(clk_i),
        .CE(\rx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\rx_rd_ptr[4]_i_1_n_0 ),
        .Q(rx_rd_ptr[4]));
  FDCE \rx_rd_ptr_reg[5] 
       (.C(clk_i),
        .CE(\rx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\rx_rd_ptr[5]_i_2_n_0 ),
        .Q(rx_rd_ptr[5]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \rx_wr_ptr[0]_i_1 
       (.I0(rx_wr_ptr[0]),
        .I1(fifo_rx_wr_en_i_1_n_0),
        .O(\rx_wr_ptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h6F)) 
    \rx_wr_ptr[1]_i_1 
       (.I0(rx_wr_ptr[1]),
        .I1(rx_wr_ptr[0]),
        .I2(fifo_rx_wr_en_i_1_n_0),
        .O(\rx_wr_ptr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h7FD5)) 
    \rx_wr_ptr[2]_i_1 
       (.I0(fifo_rx_wr_en_i_1_n_0),
        .I1(rx_wr_ptr[0]),
        .I2(rx_wr_ptr[1]),
        .I3(rx_wr_ptr[2]),
        .O(\rx_wr_ptr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h7FFFD555)) 
    \rx_wr_ptr[3]_i_1 
       (.I0(fifo_rx_wr_en_i_1_n_0),
        .I1(rx_wr_ptr[1]),
        .I2(rx_wr_ptr[0]),
        .I3(rx_wr_ptr[2]),
        .I4(rx_wr_ptr[3]),
        .O(\rx_wr_ptr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFD5555555)) 
    \rx_wr_ptr[4]_i_1 
       (.I0(fifo_rx_wr_en_i_1_n_0),
        .I1(rx_wr_ptr[2]),
        .I2(rx_wr_ptr[0]),
        .I3(rx_wr_ptr[1]),
        .I4(rx_wr_ptr[3]),
        .I5(rx_wr_ptr[4]),
        .O(\rx_wr_ptr[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \rx_wr_ptr[5]_i_1 
       (.I0(p_1_in),
        .I1(fifo_rx_wr_en_i_1_n_0),
        .O(\rx_wr_ptr[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'hD2FF)) 
    \rx_wr_ptr[5]_i_2 
       (.I0(rx_wr_ptr[4]),
        .I1(\rx_wr_ptr[5]_i_3_n_0 ),
        .I2(rx_wr_ptr[5]),
        .I3(fifo_rx_wr_en_i_1_n_0),
        .O(\rx_wr_ptr[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \rx_wr_ptr[5]_i_3 
       (.I0(rx_wr_ptr[2]),
        .I1(rx_wr_ptr[0]),
        .I2(rx_wr_ptr[1]),
        .I3(rx_wr_ptr[3]),
        .O(\rx_wr_ptr[5]_i_3_n_0 ));
  FDPE \rx_wr_ptr_reg[0] 
       (.C(clk_i),
        .CE(\rx_wr_ptr[5]_i_1_n_0 ),
        .D(\rx_wr_ptr[0]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(rx_wr_ptr[0]));
  FDPE \rx_wr_ptr_reg[1] 
       (.C(clk_i),
        .CE(\rx_wr_ptr[5]_i_1_n_0 ),
        .D(\rx_wr_ptr[1]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(rx_wr_ptr[1]));
  FDPE \rx_wr_ptr_reg[2] 
       (.C(clk_i),
        .CE(\rx_wr_ptr[5]_i_1_n_0 ),
        .D(\rx_wr_ptr[2]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(rx_wr_ptr[2]));
  FDPE \rx_wr_ptr_reg[3] 
       (.C(clk_i),
        .CE(\rx_wr_ptr[5]_i_1_n_0 ),
        .D(\rx_wr_ptr[3]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(rx_wr_ptr[3]));
  FDPE \rx_wr_ptr_reg[4] 
       (.C(clk_i),
        .CE(\rx_wr_ptr[5]_i_1_n_0 ),
        .D(\rx_wr_ptr[4]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(rx_wr_ptr[4]));
  FDPE \rx_wr_ptr_reg[5] 
       (.C(clk_i),
        .CE(\rx_wr_ptr[5]_i_1_n_0 ),
        .D(\rx_wr_ptr[5]_i_2_n_0 ),
        .PRE(rst_n_0),
        .Q(rx_wr_ptr[5]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \shift_byte[0]_i_1 
       (.I0(fifo_tx_rdata[24]),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(QSPI_IO0),
        .I3(r_w_reg_n_0),
        .O(\shift_byte[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[10]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[2] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[18]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[10]_i_2_n_0 ),
        .O(\shift_byte[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[10]_i_2 
       (.I0(shift_byte[8]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[9]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[6]),
        .O(\shift_byte[10]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[11]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[3] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[19]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[11]_i_2_n_0 ),
        .O(\shift_byte[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[11]_i_2 
       (.I0(shift_byte[9]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[10]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[7]),
        .O(\shift_byte[11]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[12]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[4] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[20]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[12]_i_2_n_0 ),
        .O(\shift_byte[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[12]_i_2 
       (.I0(shift_byte[10]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[11]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[8]),
        .O(\shift_byte[12]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[13]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[5] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[21]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[13]_i_2_n_0 ),
        .O(\shift_byte[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[13]_i_2 
       (.I0(shift_byte[11]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[12]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[9]),
        .O(\shift_byte[13]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[14]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[6] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[22]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[14]_i_2_n_0 ),
        .O(\shift_byte[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[14]_i_2 
       (.I0(shift_byte[12]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[13]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[10]),
        .O(\shift_byte[14]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[15]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[7] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[23]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[15]_i_2_n_0 ),
        .O(\shift_byte[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[15]_i_2 
       (.I0(shift_byte[13]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[14]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[11]),
        .O(\shift_byte[15]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[16]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[8] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[8]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[16]_i_2_n_0 ),
        .O(\shift_byte[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[16]_i_2 
       (.I0(shift_byte[14]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[15]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[12]),
        .O(\shift_byte[16]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[17]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[9] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[9]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[17]_i_2_n_0 ),
        .O(\shift_byte[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[17]_i_2 
       (.I0(shift_byte[15]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[16]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[13]),
        .O(\shift_byte[17]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[18]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[10] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[10]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[18]_i_2_n_0 ),
        .O(\shift_byte[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[18]_i_2 
       (.I0(shift_byte[16]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[17]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[14]),
        .O(\shift_byte[18]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[19]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[11] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[11]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[19]_i_2_n_0 ),
        .O(\shift_byte[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[19]_i_2 
       (.I0(shift_byte[17]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[18]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[15]),
        .O(\shift_byte[19]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[1]_i_1 
       (.I0(fifo_tx_rdata[25]),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[1]_i_2_n_0 ),
        .O(\shift_byte[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1F001F0F1F001000)) 
    \shift_byte[1]_i_2 
       (.I0(data_mode__0[1]),
        .I1(data_mode__0[2]),
        .I2(r_w_reg_n_0),
        .I3(shift_byte[0]),
        .I4(data_mode__0[0]),
        .I5(QSPI_IO1),
        .O(\shift_byte[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[20]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[12] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[12]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[20]_i_2_n_0 ),
        .O(\shift_byte[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[20]_i_2 
       (.I0(shift_byte[18]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[19]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[16]),
        .O(\shift_byte[20]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[21]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[13] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[13]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[21]_i_2_n_0 ),
        .O(\shift_byte[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[21]_i_2 
       (.I0(shift_byte[19]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[20]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[17]),
        .O(\shift_byte[21]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[22]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[14] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[14]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[22]_i_2_n_0 ),
        .O(\shift_byte[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[22]_i_2 
       (.I0(shift_byte[20]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[21]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[18]),
        .O(\shift_byte[22]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[23]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[15] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[15]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[23]_i_2_n_0 ),
        .O(\shift_byte[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[23]_i_2 
       (.I0(shift_byte[21]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[22]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[19]),
        .O(\shift_byte[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEEEEAAAAFEEEAAAA)) 
    \shift_byte[24]_i_1 
       (.I0(\shift_byte[24]_i_3_n_0 ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(r_w_reg_n_0),
        .I3(\to_do_list_reg_n_0_[3] ),
        .I4(\to_do_list[2]_i_2_n_0 ),
        .I5(\to_do_list_reg_n_0_[2] ),
        .O(\shift_byte[24]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[24]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[16] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[0]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[24]_i_4_n_0 ),
        .O(\shift_byte[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00008A8000000000)) 
    \shift_byte[24]_i_3 
       (.I0(\shift_byte[7]_i_4_n_0 ),
        .I1(qspi_falling_edge),
        .I2(r_w_reg_n_0),
        .I3(qspi_rising_edge),
        .I4(\fifo_status_reg_n_0_[0] ),
        .I5(\fifo_status_reg_n_0_[1] ),
        .O(\shift_byte[24]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[24]_i_4 
       (.I0(shift_byte[22]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[23]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[20]),
        .O(\shift_byte[24]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[25]_i_1 
       (.I0(\shift_byte[25]_i_2_n_0 ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[25]_i_3_n_0 ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\QSPI_CCR_reg_n_0_[0] ),
        .O(\shift_byte[25]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[25]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[17] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[1]),
        .O(\shift_byte[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[25]_i_3 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[21]),
        .I2(data_mode__0[1]),
        .I3(shift_byte[23]),
        .I4(shift_byte[24]),
        .I5(data_mode__0[0]),
        .O(\shift_byte[25]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[26]_i_1 
       (.I0(\shift_byte[26]_i_2_n_0 ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[26]_i_3_n_0 ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\QSPI_CCR_reg_n_0_[1] ),
        .O(\shift_byte[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[26]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[18] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[2]),
        .O(\shift_byte[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[26]_i_3 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[22]),
        .I2(data_mode__0[1]),
        .I3(shift_byte[24]),
        .I4(shift_byte[25]),
        .I5(data_mode__0[0]),
        .O(\shift_byte[26]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[27]_i_1 
       (.I0(\shift_byte[27]_i_2_n_0 ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[27]_i_3_n_0 ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\QSPI_CCR_reg_n_0_[2] ),
        .O(\shift_byte[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[27]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[19] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[3]),
        .O(\shift_byte[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[27]_i_3 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[23]),
        .I2(data_mode__0[1]),
        .I3(shift_byte[25]),
        .I4(shift_byte[26]),
        .I5(data_mode__0[0]),
        .O(\shift_byte[27]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[28]_i_1 
       (.I0(\shift_byte[28]_i_2_n_0 ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[28]_i_3_n_0 ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\QSPI_CCR_reg_n_0_[3] ),
        .O(\shift_byte[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[28]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[20] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[4]),
        .O(\shift_byte[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[28]_i_3 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[24]),
        .I2(data_mode__0[1]),
        .I3(shift_byte[26]),
        .I4(shift_byte[27]),
        .I5(data_mode__0[0]),
        .O(\shift_byte[28]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[29]_i_1 
       (.I0(\shift_byte[29]_i_2_n_0 ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[29]_i_3_n_0 ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\QSPI_CCR_reg_n_0_[4] ),
        .O(\shift_byte[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[29]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[21] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[5]),
        .O(\shift_byte[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[29]_i_3 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[25]),
        .I2(data_mode__0[1]),
        .I3(shift_byte[27]),
        .I4(shift_byte[28]),
        .I5(data_mode__0[0]),
        .O(\shift_byte[29]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAEA0000AAEAAAEA)) 
    \shift_byte[2]_i_1 
       (.I0(\shift_byte[2]_i_2_n_0 ),
        .I1(QSPI_IO2),
        .I2(data_mode__0[2]),
        .I3(r_w_reg_n_0),
        .I4(fifo_tx_rdata[26]),
        .I5(\fifo_status_reg_n_0_[0] ),
        .O(\shift_byte[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \shift_byte[2]_i_2 
       (.I0(shift_byte[1]),
        .I1(data_mode__0[0]),
        .I2(data_mode__0[1]),
        .I3(shift_byte[0]),
        .I4(\fifo_status_reg_n_0_[0] ),
        .O(\shift_byte[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[30]_i_1 
       (.I0(\shift_byte[30]_i_2_n_0 ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[30]_i_3_n_0 ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\QSPI_CCR_reg_n_0_[5] ),
        .O(\shift_byte[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[30]_i_2 
       (.I0(\QSPI_ADR_reg_n_0_[22] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[6]),
        .O(\shift_byte[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[30]_i_3 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[26]),
        .I2(data_mode__0[1]),
        .I3(shift_byte[28]),
        .I4(data_mode__0[0]),
        .I5(shift_byte[29]),
        .O(\shift_byte[30]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \shift_byte[31]_i_1 
       (.I0(\instr_shadow[7]_i_1_n_0 ),
        .I1(\shift_byte[24]_i_1_n_0 ),
        .O(\shift_byte[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[31]_i_2 
       (.I0(\shift_byte[31]_i_3_n_0 ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[31]_i_4_n_0 ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\QSPI_CCR_reg_n_0_[6] ),
        .O(\shift_byte[31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[31]_i_3 
       (.I0(\QSPI_ADR_reg_n_0_[23] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[7]),
        .O(\shift_byte[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[31]_i_4 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[27]),
        .I2(shift_byte[29]),
        .I3(data_mode__0[1]),
        .I4(shift_byte[30]),
        .I5(data_mode__0[0]),
        .O(\shift_byte[31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAAEA0000AAEAAAEA)) 
    \shift_byte[3]_i_1 
       (.I0(\shift_byte[3]_i_2_n_0 ),
        .I1(QSPI_IO3),
        .I2(data_mode__0[2]),
        .I3(r_w_reg_n_0),
        .I4(fifo_tx_rdata[27]),
        .I5(\fifo_status_reg_n_0_[0] ),
        .O(\shift_byte[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \shift_byte[3]_i_2 
       (.I0(shift_byte[2]),
        .I1(data_mode__0[0]),
        .I2(data_mode__0[1]),
        .I3(shift_byte[1]),
        .I4(\fifo_status_reg_n_0_[0] ),
        .O(\shift_byte[3]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[4]_i_1 
       (.I0(fifo_tx_rdata[28]),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[4]_i_2_n_0 ),
        .O(\shift_byte[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[4]_i_2 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[0]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[3]),
        .I4(shift_byte[2]),
        .I5(data_mode__0[1]),
        .O(\shift_byte[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[5]_i_1 
       (.I0(fifo_tx_rdata[29]),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[5]_i_2_n_0 ),
        .O(\shift_byte[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[5]_i_2 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[4]),
        .I4(shift_byte[3]),
        .I5(data_mode__0[1]),
        .O(\shift_byte[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[6]_i_1 
       (.I0(fifo_tx_rdata[30]),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[6]_i_2_n_0 ),
        .O(\shift_byte[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[6]_i_2 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[2]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[5]),
        .I4(shift_byte[4]),
        .I5(data_mode__0[1]),
        .O(\shift_byte[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hBBBAAABAAAAAAAAA)) 
    \shift_byte[7]_i_1 
       (.I0(\tx_rd_ptr[5]_i_3_n_0 ),
        .I1(\shift_byte[7]_i_3_n_0 ),
        .I2(qspi_rising_edge),
        .I3(r_w_reg_n_0),
        .I4(qspi_falling_edge),
        .I5(\shift_byte[7]_i_4_n_0 ),
        .O(\shift_byte[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \shift_byte[7]_i_2 
       (.I0(fifo_tx_rdata[31]),
        .I1(\fifo_status_reg_n_0_[0] ),
        .I2(\shift_byte[7]_i_5_n_0 ),
        .O(\shift_byte[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \shift_byte[7]_i_3 
       (.I0(\fifo_status_reg_n_0_[0] ),
        .I1(\fifo_status_reg_n_0_[1] ),
        .O(\shift_byte[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h16)) 
    \shift_byte[7]_i_4 
       (.I0(data_mode__0[0]),
        .I1(data_mode__0[2]),
        .I2(data_mode__0[1]),
        .O(\shift_byte[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[7]_i_5 
       (.I0(data_mode__0[2]),
        .I1(shift_byte[3]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[6]),
        .I4(shift_byte[5]),
        .I5(data_mode__0[1]),
        .O(\shift_byte[7]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[8]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[0] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[16]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[8]_i_2_n_0 ),
        .O(\shift_byte[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[8]_i_2 
       (.I0(shift_byte[6]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[7]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[4]),
        .O(\shift_byte[8]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \shift_byte[9]_i_1 
       (.I0(\QSPI_ADR_reg_n_0_[1] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(fifo_tx_rdata[17]),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\shift_byte[9]_i_2_n_0 ),
        .O(\shift_byte[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \shift_byte[9]_i_2 
       (.I0(shift_byte[7]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_byte[8]),
        .I4(data_mode__0[2]),
        .I5(shift_byte[5]),
        .O(\shift_byte[9]_i_2_n_0 ));
  FDCE \shift_byte_reg[0] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[0]_i_1_n_0 ),
        .Q(shift_byte[0]));
  FDCE \shift_byte_reg[10] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[10]_i_1_n_0 ),
        .Q(shift_byte[10]));
  FDCE \shift_byte_reg[11] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[11]_i_1_n_0 ),
        .Q(shift_byte[11]));
  FDCE \shift_byte_reg[12] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[12]_i_1_n_0 ),
        .Q(shift_byte[12]));
  FDCE \shift_byte_reg[13] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[13]_i_1_n_0 ),
        .Q(shift_byte[13]));
  FDCE \shift_byte_reg[14] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[14]_i_1_n_0 ),
        .Q(shift_byte[14]));
  FDCE \shift_byte_reg[15] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[15]_i_1_n_0 ),
        .Q(shift_byte[15]));
  FDCE \shift_byte_reg[16] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[16]_i_1_n_0 ),
        .Q(shift_byte[16]));
  FDCE \shift_byte_reg[17] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[17]_i_1_n_0 ),
        .Q(shift_byte[17]));
  FDCE \shift_byte_reg[18] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[18]_i_1_n_0 ),
        .Q(shift_byte[18]));
  FDCE \shift_byte_reg[19] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[19]_i_1_n_0 ),
        .Q(shift_byte[19]));
  FDCE \shift_byte_reg[1] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[1]_i_1_n_0 ),
        .Q(shift_byte[1]));
  FDCE \shift_byte_reg[20] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[20]_i_1_n_0 ),
        .Q(shift_byte[20]));
  FDCE \shift_byte_reg[21] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[21]_i_1_n_0 ),
        .Q(shift_byte[21]));
  FDCE \shift_byte_reg[22] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[22]_i_1_n_0 ),
        .Q(shift_byte[22]));
  FDCE \shift_byte_reg[23] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[23]_i_1_n_0 ),
        .Q(shift_byte[23]));
  FDCE \shift_byte_reg[24] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[24]_i_2_n_0 ),
        .Q(shift_byte[24]));
  FDCE \shift_byte_reg[25] 
       (.C(clk_i),
        .CE(\shift_byte[31]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[25]_i_1_n_0 ),
        .Q(shift_byte[25]));
  FDCE \shift_byte_reg[26] 
       (.C(clk_i),
        .CE(\shift_byte[31]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[26]_i_1_n_0 ),
        .Q(shift_byte[26]));
  FDCE \shift_byte_reg[27] 
       (.C(clk_i),
        .CE(\shift_byte[31]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[27]_i_1_n_0 ),
        .Q(shift_byte[27]));
  FDCE \shift_byte_reg[28] 
       (.C(clk_i),
        .CE(\shift_byte[31]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[28]_i_1_n_0 ),
        .Q(shift_byte[28]));
  FDCE \shift_byte_reg[29] 
       (.C(clk_i),
        .CE(\shift_byte[31]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[29]_i_1_n_0 ),
        .Q(shift_byte[29]));
  FDCE \shift_byte_reg[2] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[2]_i_1_n_0 ),
        .Q(shift_byte[2]));
  FDCE \shift_byte_reg[30] 
       (.C(clk_i),
        .CE(\shift_byte[31]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[30]_i_1_n_0 ),
        .Q(shift_byte[30]));
  FDCE \shift_byte_reg[31] 
       (.C(clk_i),
        .CE(\shift_byte[31]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[31]_i_2_n_0 ),
        .Q(shift_byte[31]));
  FDCE \shift_byte_reg[3] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[3]_i_1_n_0 ),
        .Q(shift_byte[3]));
  FDCE \shift_byte_reg[4] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[4]_i_1_n_0 ),
        .Q(shift_byte[4]));
  FDCE \shift_byte_reg[5] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[5]_i_1_n_0 ),
        .Q(shift_byte[5]));
  FDCE \shift_byte_reg[6] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[6]_i_1_n_0 ),
        .Q(shift_byte[6]));
  FDCE \shift_byte_reg[7] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[7]_i_2_n_0 ),
        .Q(shift_byte[7]));
  FDCE \shift_byte_reg[8] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[8]_i_1_n_0 ),
        .Q(shift_byte[8]));
  FDCE \shift_byte_reg[9] 
       (.C(clk_i),
        .CE(\shift_byte[24]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_byte[9]_i_1_n_0 ),
        .Q(shift_byte[9]));
  LUT4 #(
    .INIT(16'h14FF)) 
    \shift_cnt[0]_i_1 
       (.I0(\fifo_status_reg_n_0_[0] ),
        .I1(shift_cnt__0[0]),
        .I2(data_mode__0[0]),
        .I3(\fifo_status_reg_n_0_[1] ),
        .O(\shift_cnt[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h14411414FFFFFFFF)) 
    \shift_cnt[1]_i_1 
       (.I0(\fifo_status_reg_n_0_[0] ),
        .I1(shift_cnt__0[1]),
        .I2(data_mode__0[1]),
        .I3(shift_cnt__0[0]),
        .I4(data_mode__0[0]),
        .I5(\fifo_status_reg_n_0_[1] ),
        .O(\shift_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h0096FFFF)) 
    \shift_cnt[2]_i_1 
       (.I0(shift_cnt__0[2]),
        .I1(data_mode__0[2]),
        .I2(\shift_cnt[2]_i_2_n_0 ),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\fifo_status_reg_n_0_[1] ),
        .O(\shift_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'h2F02)) 
    \shift_cnt[2]_i_2 
       (.I0(data_mode__0[0]),
        .I1(shift_cnt__0[0]),
        .I2(shift_cnt__0[1]),
        .I3(data_mode__0[1]),
        .O(\shift_cnt[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'hFFFF0900)) 
    \shift_cnt[3]_i_1 
       (.I0(shift_cnt__0[3]),
        .I1(\shift_cnt[3]_i_2_n_0 ),
        .I2(\fifo_status_reg_n_0_[0] ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\shift_cnt[3]_i_3_n_0 ),
        .O(\shift_cnt[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hD0FD0000FFFFD0FD)) 
    \shift_cnt[3]_i_2 
       (.I0(data_mode__0[0]),
        .I1(shift_cnt__0[0]),
        .I2(shift_cnt__0[1]),
        .I3(data_mode__0[1]),
        .I4(shift_cnt__0[2]),
        .I5(data_mode__0[2]),
        .O(\shift_cnt[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h88888000)) 
    \shift_cnt[3]_i_3 
       (.I0(\fifo_status_reg_n_0_[0] ),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(sel0[0]),
        .I3(\to_do_list[2]_i_3_n_0 ),
        .I4(\to_do_list_reg_n_0_[1] ),
        .O(\shift_cnt[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hA2A2A2A2A2020202)) 
    \shift_cnt[4]_i_1 
       (.I0(\fifo_status_reg_n_0_[1] ),
        .I1(\shift_cnt[4]_i_2_n_0 ),
        .I2(\fifo_status_reg_n_0_[0] ),
        .I3(sel0[1]),
        .I4(\to_do_list[2]_i_3_n_0 ),
        .I5(\to_do_list_reg_n_0_[1] ),
        .O(\shift_cnt[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h56)) 
    \shift_cnt[4]_i_2 
       (.I0(shift_cnt__0[4]),
        .I1(\shift_cnt[3]_i_2_n_0 ),
        .I2(shift_cnt__0[3]),
        .O(\shift_cnt[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF44F0)) 
    \shift_cnt[5]_i_1 
       (.I0(\shift_cnt[5]_i_3_n_0 ),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\shift_cnt[5]_i_4_n_0 ),
        .I3(\fifo_status_reg_n_0_[0] ),
        .I4(\instr_shadow[7]_i_1_n_0 ),
        .O(\shift_cnt[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h020202A2)) 
    \shift_cnt[5]_i_2 
       (.I0(\fifo_status_reg_n_0_[1] ),
        .I1(\shift_cnt[5]_i_5_n_0 ),
        .I2(\fifo_status_reg_n_0_[0] ),
        .I3(\to_do_list[2]_i_3_n_0 ),
        .I4(\to_do_list_reg_n_0_[1] ),
        .O(\shift_cnt[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h01005555)) 
    \shift_cnt[5]_i_3 
       (.I0(\to_do_list_reg_n_0_[1] ),
        .I1(sel0[1]),
        .I2(sel0[0]),
        .I3(\to_do_list[2]_i_3_n_0 ),
        .I4(\data_byte_size[7]_i_3_n_0 ),
        .O(\shift_cnt[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \shift_cnt[5]_i_4 
       (.I0(\to_do_list[1]_i_3_n_0 ),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(qspi_falling_edge),
        .O(\shift_cnt[5]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'h5556)) 
    \shift_cnt[5]_i_5 
       (.I0(shift_cnt__0[5]),
        .I1(\shift_cnt[3]_i_2_n_0 ),
        .I2(shift_cnt__0[4]),
        .I3(shift_cnt__0[3]),
        .O(\shift_cnt[5]_i_5_n_0 ));
  FDCE \shift_cnt_reg[0] 
       (.C(clk_i),
        .CE(\shift_cnt[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_cnt[0]_i_1_n_0 ),
        .Q(shift_cnt__0[0]));
  FDCE \shift_cnt_reg[1] 
       (.C(clk_i),
        .CE(\shift_cnt[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_cnt[1]_i_1_n_0 ),
        .Q(shift_cnt__0[1]));
  FDCE \shift_cnt_reg[2] 
       (.C(clk_i),
        .CE(\shift_cnt[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_cnt[2]_i_1_n_0 ),
        .Q(shift_cnt__0[2]));
  FDCE \shift_cnt_reg[3] 
       (.C(clk_i),
        .CE(\shift_cnt[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_cnt[3]_i_1_n_0 ),
        .Q(shift_cnt__0[3]));
  FDCE \shift_cnt_reg[4] 
       (.C(clk_i),
        .CE(\shift_cnt[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_cnt[4]_i_1_n_0 ),
        .Q(shift_cnt__0[4]));
  FDCE \shift_cnt_reg[5] 
       (.C(clk_i),
        .CE(\shift_cnt[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\shift_cnt[5]_i_2_n_0 ),
        .Q(shift_cnt__0[5]));
  LUT5 #(
    .INIT(32'h555554F0)) 
    \to_do_list[0]_i_1 
       (.I0(\fifo_status_reg_n_0_[1] ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(\to_do_list_reg_n_0_[0] ),
        .I3(\to_do_list[0]_i_2_n_0 ),
        .I4(\to_do_list[3]_i_2_n_0 ),
        .O(\to_do_list[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000D0000000000)) 
    \to_do_list[0]_i_2 
       (.I0(r_w_reg_n_0),
        .I1(qspi_falling_edge),
        .I2(\fifo_status_reg_n_0_[0] ),
        .I3(\fifo_status_reg_n_0_[1] ),
        .I4(\to_do_list[0]_i_3_n_0 ),
        .I5(\to_do_list[0]_i_4_n_0 ),
        .O(\to_do_list[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'h6FF6)) 
    \to_do_list[0]_i_3 
       (.I0(shift_cnt__0[1]),
        .I1(data_mode__0[1]),
        .I2(data_mode__0[0]),
        .I3(shift_cnt__0[0]),
        .O(\to_do_list[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000009)) 
    \to_do_list[0]_i_4 
       (.I0(shift_cnt__0[2]),
        .I1(data_mode__0[2]),
        .I2(shift_cnt__0[4]),
        .I3(shift_cnt__0[3]),
        .I4(shift_cnt__0[5]),
        .O(\to_do_list[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h222F2220)) 
    \to_do_list[1]_i_1 
       (.I0(address),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\to_do_list[1]_i_2_n_0 ),
        .I3(\to_do_list[3]_i_2_n_0 ),
        .I4(\to_do_list_reg_n_0_[1] ),
        .O(\to_do_list[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000D000D0000)) 
    \to_do_list[1]_i_2 
       (.I0(r_w_reg_n_0),
        .I1(qspi_falling_edge),
        .I2(\shift_byte[7]_i_3_n_0 ),
        .I3(\to_do_list[1]_i_3_n_0 ),
        .I4(\to_do_list_reg_n_0_[0] ),
        .I5(\to_do_list_reg_n_0_[1] ),
        .O(\to_do_list[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'h6FF6FFFF)) 
    \to_do_list[1]_i_3 
       (.I0(shift_cnt__0[0]),
        .I1(data_mode__0[0]),
        .I2(data_mode__0[1]),
        .I3(shift_cnt__0[1]),
        .I4(\to_do_list[0]_i_4_n_0 ),
        .O(\to_do_list[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h2F2F2FFF2F2F2F00)) 
    \to_do_list[2]_i_1 
       (.I0(\to_do_list[2]_i_2_n_0 ),
        .I1(\to_do_list[2]_i_3_n_0 ),
        .I2(\to_do_list[2]_i_4_n_0 ),
        .I3(\to_do_list[3]_i_2_n_0 ),
        .I4(\to_do_list[2]_i_5_n_0 ),
        .I5(\to_do_list_reg_n_0_[2] ),
        .O(\to_do_list[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \to_do_list[2]_i_2 
       (.I0(\fifo_status_reg_n_0_[1] ),
        .I1(\fifo_status_reg_n_0_[0] ),
        .O(\to_do_list[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \to_do_list[2]_i_3 
       (.I0(sel0[5]),
        .I1(sel0[4]),
        .I2(sel0[3]),
        .I3(sel0[2]),
        .I4(sel0[6]),
        .I5(sel0[7]),
        .O(\to_do_list[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAAB)) 
    \to_do_list[2]_i_4 
       (.I0(\fifo_status_reg_n_0_[1] ),
        .I1(\QSPI_CCR_reg_n_0_[14] ),
        .I2(\QSPI_CCR_reg_n_0_[15] ),
        .I3(\QSPI_CCR_reg_n_0_[11] ),
        .I4(\QSPI_CCR_reg_n_0_[13] ),
        .I5(\QSPI_CCR_reg_n_0_[12] ),
        .O(\to_do_list[2]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'hABAAAAAA)) 
    \to_do_list[2]_i_5 
       (.I0(\to_do_list[2]_i_6_n_0 ),
        .I1(\to_do_list_reg_n_0_[0] ),
        .I2(\to_do_list_reg_n_0_[1] ),
        .I3(\to_do_list_reg_n_0_[2] ),
        .I4(\to_do_list[0]_i_2_n_0 ),
        .O(\to_do_list[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000E20000)) 
    \to_do_list[2]_i_6 
       (.I0(\to_do_list_reg_n_0_[3] ),
        .I1(\to_do_list_reg_n_0_[2] ),
        .I2(\to_do_list[2]_i_7_n_0 ),
        .I3(\to_do_list[2]_i_3_n_0 ),
        .I4(\to_do_list[2]_i_2_n_0 ),
        .I5(\to_do_list_reg_n_0_[1] ),
        .O(\to_do_list[2]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    \to_do_list[2]_i_7 
       (.I0(qspi_falling_edge),
        .I1(dummy_cycle__0[4]),
        .I2(dummy_cycle__0[3]),
        .I3(dummy_cycle__0[2]),
        .I4(dummy_cycle__0[1]),
        .I5(dummy_cycle__0[0]),
        .O(\to_do_list[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h545454FF54545400)) 
    \to_do_list[3]_i_1 
       (.I0(\fifo_status_reg_n_0_[1] ),
        .I1(data2[0]),
        .I2(data2[1]),
        .I3(\to_do_list[3]_i_2_n_0 ),
        .I4(\to_do_list[3]_i_3_n_0 ),
        .I5(\to_do_list_reg_n_0_[3] ),
        .O(\to_do_list[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hABAAAAAA)) 
    \to_do_list[3]_i_2 
       (.I0(\instr_shadow[7]_i_1_n_0 ),
        .I1(sel0[1]),
        .I2(sel0[0]),
        .I3(\to_do_list[2]_i_3_n_0 ),
        .I4(\to_do_list[0]_i_2_n_0 ),
        .O(\to_do_list[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000200)) 
    \to_do_list[3]_i_3 
       (.I0(\to_do_list[0]_i_2_n_0 ),
        .I1(\to_do_list_reg_n_0_[1] ),
        .I2(\to_do_list_reg_n_0_[2] ),
        .I3(\to_do_list_reg_n_0_[3] ),
        .I4(\to_do_list_reg_n_0_[0] ),
        .O(\to_do_list[3]_i_3_n_0 ));
  FDCE \to_do_list_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\to_do_list[0]_i_1_n_0 ),
        .Q(\to_do_list_reg_n_0_[0] ));
  FDCE \to_do_list_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\to_do_list[1]_i_1_n_0 ),
        .Q(\to_do_list_reg_n_0_[1] ));
  FDCE \to_do_list_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\to_do_list[2]_i_1_n_0 ),
        .Q(\to_do_list_reg_n_0_[2] ));
  FDCE \to_do_list_reg[3] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(rst_n_0),
        .D(\to_do_list[3]_i_1_n_0 ),
        .Q(\to_do_list_reg_n_0_[3] ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0070)) 
    \tx_rd_ptr[0]_i_1 
       (.I0(\tx_rd_ptr[5]_i_4_n_0 ),
        .I1(tx_rd_ptr[5]),
        .I2(\tx_rd_ptr[5]_i_3_n_0 ),
        .I3(tx_rd_ptr[0]),
        .O(\tx_rd_ptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h00707000)) 
    \tx_rd_ptr[1]_i_1 
       (.I0(\tx_rd_ptr[5]_i_4_n_0 ),
        .I1(tx_rd_ptr[5]),
        .I2(\tx_rd_ptr[5]_i_3_n_0 ),
        .I3(tx_rd_ptr[1]),
        .I4(tx_rd_ptr[0]),
        .O(\tx_rd_ptr[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0070707070000000)) 
    \tx_rd_ptr[2]_i_1 
       (.I0(\tx_rd_ptr[5]_i_4_n_0 ),
        .I1(tx_rd_ptr[5]),
        .I2(\tx_rd_ptr[5]_i_3_n_0 ),
        .I3(tx_rd_ptr[0]),
        .I4(tx_rd_ptr[1]),
        .I5(tx_rd_ptr[2]),
        .O(\tx_rd_ptr[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \tx_rd_ptr[3]_i_1 
       (.I0(tx_rd_ptr[3]),
        .I1(tx_rd_ptr[2]),
        .I2(tx_rd_ptr[0]),
        .I3(tx_rd_ptr[1]),
        .I4(\tx_rd_ptr[5]_i_3_n_0 ),
        .O(\tx_rd_ptr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2888888888888888)) 
    \tx_rd_ptr[4]_i_1 
       (.I0(\tx_rd_ptr[5]_i_3_n_0 ),
        .I1(tx_rd_ptr[4]),
        .I2(tx_rd_ptr[2]),
        .I3(tx_rd_ptr[0]),
        .I4(tx_rd_ptr[1]),
        .I5(tx_rd_ptr[3]),
        .O(\tx_rd_ptr[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \tx_rd_ptr[5]_i_1 
       (.I0(\QSPI_FCR_reg_n_0_[1] ),
        .I1(\tx_rd_ptr[5]_i_3_n_0 ),
        .O(\tx_rd_ptr[5]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h28)) 
    \tx_rd_ptr[5]_i_2 
       (.I0(\tx_rd_ptr[5]_i_3_n_0 ),
        .I1(tx_rd_ptr[5]),
        .I2(\tx_rd_ptr[5]_i_4_n_0 ),
        .O(\tx_rd_ptr[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000008000)) 
    \tx_rd_ptr[5]_i_3 
       (.I0(\fifo_status_reg_n_0_[0] ),
        .I1(\fifo_status_reg_n_0_[1] ),
        .I2(\to_do_list_reg_n_0_[3] ),
        .I3(r_w_reg_n_0),
        .I4(\to_do_list_reg_n_0_[2] ),
        .I5(\to_do_list_reg_n_0_[1] ),
        .O(\tx_rd_ptr[5]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \tx_rd_ptr[5]_i_4 
       (.I0(tx_rd_ptr[4]),
        .I1(tx_rd_ptr[3]),
        .I2(tx_rd_ptr[1]),
        .I3(tx_rd_ptr[0]),
        .I4(tx_rd_ptr[2]),
        .O(\tx_rd_ptr[5]_i_4_n_0 ));
  FDCE \tx_rd_ptr_reg[0] 
       (.C(clk_i),
        .CE(\tx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\tx_rd_ptr[0]_i_1_n_0 ),
        .Q(tx_rd_ptr[0]));
  FDCE \tx_rd_ptr_reg[1] 
       (.C(clk_i),
        .CE(\tx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\tx_rd_ptr[1]_i_1_n_0 ),
        .Q(tx_rd_ptr[1]));
  FDCE \tx_rd_ptr_reg[2] 
       (.C(clk_i),
        .CE(\tx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\tx_rd_ptr[2]_i_1_n_0 ),
        .Q(tx_rd_ptr[2]));
  FDCE \tx_rd_ptr_reg[3] 
       (.C(clk_i),
        .CE(\tx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\tx_rd_ptr[3]_i_1_n_0 ),
        .Q(tx_rd_ptr[3]));
  FDCE \tx_rd_ptr_reg[4] 
       (.C(clk_i),
        .CE(\tx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\tx_rd_ptr[4]_i_1_n_0 ),
        .Q(tx_rd_ptr[4]));
  FDCE \tx_rd_ptr_reg[5] 
       (.C(clk_i),
        .CE(\tx_rd_ptr[5]_i_1_n_0 ),
        .CLR(rst_n_0),
        .D(\tx_rd_ptr[5]_i_2_n_0 ),
        .Q(tx_rd_ptr[5]));
  LUT3 #(
    .INIT(8'hDF)) 
    \tx_wr_ptr[0]_i_1 
       (.I0(tx_wr_ptr[0]),
        .I1(p_0_in27_in),
        .I2(fifo_tx_push_data),
        .O(\tx_wr_ptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hF6FF)) 
    \tx_wr_ptr[1]_i_1 
       (.I0(tx_wr_ptr[1]),
        .I1(tx_wr_ptr[0]),
        .I2(p_0_in27_in),
        .I3(fifo_tx_push_data),
        .O(\tx_wr_ptr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hBFFFFBBB)) 
    \tx_wr_ptr[2]_i_1 
       (.I0(p_0_in27_in),
        .I1(fifo_tx_push_data),
        .I2(tx_wr_ptr[0]),
        .I3(tx_wr_ptr[1]),
        .I4(tx_wr_ptr[2]),
        .O(\tx_wr_ptr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBFFFFFFFFBBBBBBB)) 
    \tx_wr_ptr[3]_i_1 
       (.I0(p_0_in27_in),
        .I1(fifo_tx_push_data),
        .I2(tx_wr_ptr[1]),
        .I3(tx_wr_ptr[0]),
        .I4(tx_wr_ptr[2]),
        .I5(tx_wr_ptr[3]),
        .O(\tx_wr_ptr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFD5555555)) 
    \tx_wr_ptr[4]_i_1 
       (.I0(fifo_tx_wr_en0),
        .I1(tx_wr_ptr[2]),
        .I2(tx_wr_ptr[0]),
        .I3(tx_wr_ptr[1]),
        .I4(tx_wr_ptr[3]),
        .I5(tx_wr_ptr[4]),
        .O(\tx_wr_ptr[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \tx_wr_ptr[4]_i_2 
       (.I0(fifo_tx_push_data),
        .I1(p_0_in27_in),
        .O(fifo_tx_wr_en0));
  LUT3 #(
    .INIT(8'hBA)) 
    \tx_wr_ptr[5]_i_1 
       (.I0(\QSPI_FCR_reg_n_0_[1] ),
        .I1(p_0_in27_in),
        .I2(fifo_tx_push_data),
        .O(\tx_wr_ptr[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hFFD2FFFF)) 
    \tx_wr_ptr[5]_i_2 
       (.I0(tx_wr_ptr[4]),
        .I1(\tx_wr_ptr[5]_i_3_n_0 ),
        .I2(tx_wr_ptr[5]),
        .I3(p_0_in27_in),
        .I4(fifo_tx_push_data),
        .O(\tx_wr_ptr[5]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \tx_wr_ptr[5]_i_3 
       (.I0(tx_wr_ptr[2]),
        .I1(tx_wr_ptr[0]),
        .I2(tx_wr_ptr[1]),
        .I3(tx_wr_ptr[3]),
        .O(\tx_wr_ptr[5]_i_3_n_0 ));
  FDPE \tx_wr_ptr_reg[0] 
       (.C(clk_i),
        .CE(\tx_wr_ptr[5]_i_1_n_0 ),
        .D(\tx_wr_ptr[0]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(tx_wr_ptr[0]));
  FDPE \tx_wr_ptr_reg[1] 
       (.C(clk_i),
        .CE(\tx_wr_ptr[5]_i_1_n_0 ),
        .D(\tx_wr_ptr[1]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(tx_wr_ptr[1]));
  FDPE \tx_wr_ptr_reg[2] 
       (.C(clk_i),
        .CE(\tx_wr_ptr[5]_i_1_n_0 ),
        .D(\tx_wr_ptr[2]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(tx_wr_ptr[2]));
  FDPE \tx_wr_ptr_reg[3] 
       (.C(clk_i),
        .CE(\tx_wr_ptr[5]_i_1_n_0 ),
        .D(\tx_wr_ptr[3]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(tx_wr_ptr[3]));
  FDPE \tx_wr_ptr_reg[4] 
       (.C(clk_i),
        .CE(\tx_wr_ptr[5]_i_1_n_0 ),
        .D(\tx_wr_ptr[4]_i_1_n_0 ),
        .PRE(rst_n_0),
        .Q(tx_wr_ptr[4]));
  FDPE \tx_wr_ptr_reg[5] 
       (.C(clk_i),
        .CE(\tx_wr_ptr[5]_i_1_n_0 ),
        .D(\tx_wr_ptr[5]_i_2_n_0 ),
        .PRE(rst_n_0),
        .Q(tx_wr_ptr[5]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
