// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sun May 10 17:03:17 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_AXI4_Interconnect_0_0/design_1_AXI4_Interconnect_0_0_stub.v
// Design      : design_1_AXI4_Interconnect_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_AXI4_Interconnect_0_0,AXI4_Interconnect,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "AXI4_Interconnect,Vivado 2025.2" *) 
module design_1_AXI4_Interconnect_0_0(clk_i, rst_ni, axi_s0_awid, axi_s0_awaddr, 
  axi_s0_awlen, axi_s0_awsize, axi_s0_awburst, axi_s0_awprot, axi_s0_awvalid, axi_s0_awready, 
  axi_s0_wdata, axi_s0_wstrb, axi_s0_wlast, axi_s0_wvalid, axi_s0_wready, axi_s0_bready, 
  axi_s0_bid, axi_s0_bresp, axi_s0_bvalid, axi_s0_arid, axi_s0_araddr, axi_s0_arlen, 
  axi_s0_arsize, axi_s0_arburst, axi_s0_arprot, axi_s0_arvalid, axi_s0_arready, 
  axi_s0_rready, axi_s0_rid, axi_s0_rdata, axi_s0_rresp, axi_s0_rlast, axi_s0_rvalid, 
  axi_m0_awaddr, axi_m0_awvalid, axi_m0_awready, axi_m0_wdata, axi_m0_wvalid, axi_m0_wready, 
  axi_m0_bresp, axi_m0_bvalid, axi_m0_bready, axi_m0_araddr, axi_m0_arvalid, axi_m0_arready, 
  axi_m0_rdata, axi_m0_rresp, axi_m0_rvalid, axi_m0_rready, axi_m1_awaddr, axi_m1_awvalid, 
  axi_m1_awready, axi_m1_wdata, axi_m1_wvalid, axi_m1_wready, axi_m1_bresp, axi_m1_bvalid, 
  axi_m1_bready, axi_m1_araddr, axi_m1_arvalid, axi_m1_arready, axi_m1_rdata, axi_m1_rresp, 
  axi_m1_rvalid, axi_m1_rready, axi_m2_awaddr, axi_m2_awvalid, axi_m2_awready, axi_m2_wdata, 
  axi_m2_wvalid, axi_m2_wready, axi_m2_bresp, axi_m2_bvalid, axi_m2_bready, axi_m2_araddr, 
  axi_m2_arvalid, axi_m2_arready, axi_m2_rdata, axi_m2_rresp, axi_m2_rvalid, axi_m2_rready, 
  axi_m3_awaddr, axi_m3_awvalid, axi_m3_awready, axi_m3_wdata, axi_m3_wvalid, axi_m3_wready, 
  axi_m3_bresp, axi_m3_bvalid, axi_m3_bready, axi_m3_araddr, axi_m3_arvalid, axi_m3_arready, 
  axi_m3_rdata, axi_m3_rresp, axi_m3_rvalid, axi_m3_rready, axi_m4_awaddr, axi_m4_awvalid, 
  axi_m4_awready, axi_m4_wdata, axi_m4_wvalid, axi_m4_wready, axi_m4_bresp, axi_m4_bvalid, 
  axi_m4_bready, axi_m4_araddr, axi_m4_arvalid, axi_m4_arready, axi_m4_rdata, axi_m4_rresp, 
  axi_m4_rvalid, axi_m4_rready, axi_m4_awid, axi_m4_awlen, axi_m4_awsize, axi_m4_awburst, 
  axi_m4_awprot, axi_m4_wstrb, axi_m4_wlast, axi_m4_arid, axi_m4_arlen, axi_m4_arsize, 
  axi_m4_arburst, axi_m4_arprot, axi_m4_bid, axi_m4_rlast, axi_m4_rid, axi_m5_awaddr, 
  axi_m5_awvalid, axi_m5_awready, axi_m5_wdata, axi_m5_wvalid, axi_m5_wready, axi_m5_bresp, 
  axi_m5_bvalid, axi_m5_bready, axi_m5_araddr, axi_m5_arvalid, axi_m5_arready, axi_m5_rdata, 
  axi_m5_rresp, axi_m5_rvalid, axi_m5_rready, axi_m5_awid, axi_m5_awlen, axi_m5_awsize, 
  axi_m5_awburst, axi_m5_awprot, axi_m5_wstrb, axi_m5_wlast, axi_m5_arid, axi_m5_arlen, 
  axi_m5_arsize, axi_m5_arburst, axi_m5_arprot, axi_m5_bid, axi_m5_rlast, axi_m5_rid)
/* synthesis syn_black_box black_box_pad_pin="clk_i,rst_ni,axi_s0_awid[3:0],axi_s0_awaddr[31:0],axi_s0_awlen[7:0],axi_s0_awsize[2:0],axi_s0_awburst[1:0],axi_s0_awprot[2:0],axi_s0_awvalid,axi_s0_awready,axi_s0_wdata[31:0],axi_s0_wstrb[3:0],axi_s0_wlast,axi_s0_wvalid,axi_s0_wready,axi_s0_bready,axi_s0_bid[3:0],axi_s0_bresp[1:0],axi_s0_bvalid,axi_s0_arid[3:0],axi_s0_araddr[31:0],axi_s0_arlen[7:0],axi_s0_arsize[2:0],axi_s0_arburst[1:0],axi_s0_arprot[2:0],axi_s0_arvalid,axi_s0_arready,axi_s0_rready,axi_s0_rid[3:0],axi_s0_rdata[31:0],axi_s0_rresp[1:0],axi_s0_rlast,axi_s0_rvalid,axi_m0_awaddr[31:0],axi_m0_awvalid,axi_m0_awready,axi_m0_wdata[31:0],axi_m0_wvalid,axi_m0_wready,axi_m0_bresp[1:0],axi_m0_bvalid,axi_m0_bready,axi_m0_araddr[31:0],axi_m0_arvalid,axi_m0_arready,axi_m0_rdata[31:0],axi_m0_rresp[1:0],axi_m0_rvalid,axi_m0_rready,axi_m1_awaddr[31:0],axi_m1_awvalid,axi_m1_awready,axi_m1_wdata[31:0],axi_m1_wvalid,axi_m1_wready,axi_m1_bresp[1:0],axi_m1_bvalid,axi_m1_bready,axi_m1_araddr[31:0],axi_m1_arvalid,axi_m1_arready,axi_m1_rdata[31:0],axi_m1_rresp[1:0],axi_m1_rvalid,axi_m1_rready,axi_m2_awaddr[31:0],axi_m2_awvalid,axi_m2_awready,axi_m2_wdata[31:0],axi_m2_wvalid,axi_m2_wready,axi_m2_bresp[1:0],axi_m2_bvalid,axi_m2_bready,axi_m2_araddr[31:0],axi_m2_arvalid,axi_m2_arready,axi_m2_rdata[31:0],axi_m2_rresp[1:0],axi_m2_rvalid,axi_m2_rready,axi_m3_awaddr[31:0],axi_m3_awvalid,axi_m3_awready,axi_m3_wdata[31:0],axi_m3_wvalid,axi_m3_wready,axi_m3_bresp[1:0],axi_m3_bvalid,axi_m3_bready,axi_m3_araddr[31:0],axi_m3_arvalid,axi_m3_arready,axi_m3_rdata[31:0],axi_m3_rresp[1:0],axi_m3_rvalid,axi_m3_rready,axi_m4_awaddr[31:0],axi_m4_awvalid,axi_m4_awready,axi_m4_wdata[31:0],axi_m4_wvalid,axi_m4_wready,axi_m4_bresp[1:0],axi_m4_bvalid,axi_m4_bready,axi_m4_araddr[31:0],axi_m4_arvalid,axi_m4_arready,axi_m4_rdata[31:0],axi_m4_rresp[1:0],axi_m4_rvalid,axi_m4_rready,axi_m4_awid[3:0],axi_m4_awlen[7:0],axi_m4_awsize[2:0],axi_m4_awburst[1:0],axi_m4_awprot[2:0],axi_m4_wstrb[3:0],axi_m4_wlast,axi_m4_arid[3:0],axi_m4_arlen[7:0],axi_m4_arsize[2:0],axi_m4_arburst[1:0],axi_m4_arprot[2:0],axi_m4_bid[3:0],axi_m4_rlast,axi_m4_rid[3:0],axi_m5_awaddr[31:0],axi_m5_awvalid,axi_m5_awready,axi_m5_wdata[31:0],axi_m5_wvalid,axi_m5_wready,axi_m5_bresp[1:0],axi_m5_bvalid,axi_m5_bready,axi_m5_araddr[31:0],axi_m5_arvalid,axi_m5_arready,axi_m5_rdata[31:0],axi_m5_rresp[1:0],axi_m5_rvalid,axi_m5_rready,axi_m5_awid[3:0],axi_m5_awlen[7:0],axi_m5_awsize[2:0],axi_m5_awburst[1:0],axi_m5_awprot[2:0],axi_m5_wstrb[3:0],axi_m5_wlast,axi_m5_arid[3:0],axi_m5_arlen[7:0],axi_m5_arsize[2:0],axi_m5_arburst[1:0],axi_m5_arprot[2:0],axi_m5_bid[3:0],axi_m5_rlast,axi_m5_rid[3:0]" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk_i CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk_i, FREQ_TOLERANCE_HZ 0, ASSOCIATED_BUSIF axi_m0:axi_m1:axi_m2:axi_m3:axi_m4:axi_m5:axi_s0, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_ni RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_ni, POLARITY ACTIVE_LOW, ASSOCIATED_RESET rst_ni, INSERT_VIP 0" *) input rst_ni;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 AWID" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_s0, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [3:0]axi_s0_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 AWADDR" *) input [31:0]axi_s0_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 AWLEN" *) input [7:0]axi_s0_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 AWSIZE" *) input [2:0]axi_s0_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 AWBURST" *) input [1:0]axi_s0_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 AWPROT" *) input [2:0]axi_s0_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 AWVALID" *) input axi_s0_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 AWREADY" *) output axi_s0_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 WDATA" *) input [31:0]axi_s0_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 WSTRB" *) input [3:0]axi_s0_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 WLAST" *) input axi_s0_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 WVALID" *) input axi_s0_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 WREADY" *) output axi_s0_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 BREADY" *) input axi_s0_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 BID" *) output [3:0]axi_s0_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 BRESP" *) output [1:0]axi_s0_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 BVALID" *) output axi_s0_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 ARID" *) input [3:0]axi_s0_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 ARADDR" *) input [31:0]axi_s0_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 ARLEN" *) input [7:0]axi_s0_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 ARSIZE" *) input [2:0]axi_s0_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 ARBURST" *) input [1:0]axi_s0_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 ARPROT" *) input [2:0]axi_s0_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 ARVALID" *) input axi_s0_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 ARREADY" *) output axi_s0_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 RREADY" *) input axi_s0_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 RID" *) output [3:0]axi_s0_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 RDATA" *) output [31:0]axi_s0_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 RRESP" *) output [1:0]axi_s0_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 RLAST" *) output axi_s0_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_s0 RVALID" *) output axi_s0_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 AWADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_m0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [31:0]axi_m0_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 AWVALID" *) output axi_m0_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 AWREADY" *) input axi_m0_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 WDATA" *) output [31:0]axi_m0_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 WVALID" *) output axi_m0_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 WREADY" *) input axi_m0_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 BRESP" *) input [1:0]axi_m0_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 BVALID" *) input axi_m0_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 BREADY" *) output axi_m0_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 ARADDR" *) output [31:0]axi_m0_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 ARVALID" *) output axi_m0_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 ARREADY" *) input axi_m0_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 RDATA" *) input [31:0]axi_m0_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 RRESP" *) input [1:0]axi_m0_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 RVALID" *) input axi_m0_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m0 RREADY" *) output axi_m0_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 AWADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_m1, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [31:0]axi_m1_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 AWVALID" *) output axi_m1_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 AWREADY" *) input axi_m1_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 WDATA" *) output [31:0]axi_m1_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 WVALID" *) output axi_m1_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 WREADY" *) input axi_m1_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 BRESP" *) input [1:0]axi_m1_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 BVALID" *) input axi_m1_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 BREADY" *) output axi_m1_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 ARADDR" *) output [31:0]axi_m1_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 ARVALID" *) output axi_m1_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 ARREADY" *) input axi_m1_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 RDATA" *) input [31:0]axi_m1_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 RRESP" *) input [1:0]axi_m1_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 RVALID" *) input axi_m1_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m1 RREADY" *) output axi_m1_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 AWADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_m2, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [31:0]axi_m2_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 AWVALID" *) output axi_m2_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 AWREADY" *) input axi_m2_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 WDATA" *) output [31:0]axi_m2_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 WVALID" *) output axi_m2_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 WREADY" *) input axi_m2_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 BRESP" *) input [1:0]axi_m2_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 BVALID" *) input axi_m2_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 BREADY" *) output axi_m2_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 ARADDR" *) output [31:0]axi_m2_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 ARVALID" *) output axi_m2_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 ARREADY" *) input axi_m2_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 RDATA" *) input [31:0]axi_m2_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 RRESP" *) input [1:0]axi_m2_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 RVALID" *) input axi_m2_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m2 RREADY" *) output axi_m2_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 AWADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_m3, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [31:0]axi_m3_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 AWVALID" *) output axi_m3_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 AWREADY" *) input axi_m3_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 WDATA" *) output [31:0]axi_m3_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 WVALID" *) output axi_m3_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 WREADY" *) input axi_m3_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 BRESP" *) input [1:0]axi_m3_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 BVALID" *) input axi_m3_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 BREADY" *) output axi_m3_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 ARADDR" *) output [31:0]axi_m3_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 ARVALID" *) output axi_m3_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 ARREADY" *) input axi_m3_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 RDATA" *) input [31:0]axi_m3_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 RRESP" *) input [1:0]axi_m3_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 RVALID" *) input axi_m3_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m3 RREADY" *) output axi_m3_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 AWADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_m4, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [31:0]axi_m4_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 AWVALID" *) output axi_m4_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 AWREADY" *) input axi_m4_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 WDATA" *) output [31:0]axi_m4_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 WVALID" *) output axi_m4_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 WREADY" *) input axi_m4_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 BRESP" *) input [1:0]axi_m4_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 BVALID" *) input axi_m4_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 BREADY" *) output axi_m4_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 ARADDR" *) output [31:0]axi_m4_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 ARVALID" *) output axi_m4_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 ARREADY" *) input axi_m4_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 RDATA" *) input [31:0]axi_m4_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 RRESP" *) input [1:0]axi_m4_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 RVALID" *) input axi_m4_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 RREADY" *) output axi_m4_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 AWID" *) output [3:0]axi_m4_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 AWLEN" *) output [7:0]axi_m4_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 AWSIZE" *) output [2:0]axi_m4_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 AWBURST" *) output [1:0]axi_m4_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 AWPROT" *) output [2:0]axi_m4_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 WSTRB" *) output [3:0]axi_m4_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 WLAST" *) output axi_m4_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 ARID" *) output [3:0]axi_m4_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 ARLEN" *) output [7:0]axi_m4_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 ARSIZE" *) output [2:0]axi_m4_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 ARBURST" *) output [1:0]axi_m4_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 ARPROT" *) output [2:0]axi_m4_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 BID" *) input [3:0]axi_m4_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 RLAST" *) input axi_m4_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m4 RID" *) input [3:0]axi_m4_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 AWADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_m5, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [31:0]axi_m5_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 AWVALID" *) output axi_m5_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 AWREADY" *) input axi_m5_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 WDATA" *) output [31:0]axi_m5_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 WVALID" *) output axi_m5_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 WREADY" *) input axi_m5_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 BRESP" *) input [1:0]axi_m5_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 BVALID" *) input axi_m5_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 BREADY" *) output axi_m5_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 ARADDR" *) output [31:0]axi_m5_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 ARVALID" *) output axi_m5_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 ARREADY" *) input axi_m5_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 RDATA" *) input [31:0]axi_m5_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 RRESP" *) input [1:0]axi_m5_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 RVALID" *) input axi_m5_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 RREADY" *) output axi_m5_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 AWID" *) output [3:0]axi_m5_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 AWLEN" *) output [7:0]axi_m5_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 AWSIZE" *) output [2:0]axi_m5_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 AWBURST" *) output [1:0]axi_m5_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 AWPROT" *) output [2:0]axi_m5_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 WSTRB" *) output [3:0]axi_m5_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 WLAST" *) output axi_m5_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 ARID" *) output [3:0]axi_m5_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 ARLEN" *) output [7:0]axi_m5_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 ARSIZE" *) output [2:0]axi_m5_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 ARBURST" *) output [1:0]axi_m5_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 ARPROT" *) output [2:0]axi_m5_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 BID" *) input [3:0]axi_m5_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 RLAST" *) input axi_m5_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m5 RID" *) input [3:0]axi_m5_rid;
endmodule
