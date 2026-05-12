// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sun May 10 17:03:17 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_AXI4_Interconnect_0_0/design_1_AXI4_Interconnect_0_0_sim_netlist.v
// Design      : design_1_AXI4_Interconnect_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_AXI4_Interconnect_0_0,AXI4_Interconnect,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "AXI4_Interconnect,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_AXI4_Interconnect_0_0
   (clk_i,
    rst_ni,
    axi_s0_awid,
    axi_s0_awaddr,
    axi_s0_awlen,
    axi_s0_awsize,
    axi_s0_awburst,
    axi_s0_awprot,
    axi_s0_awvalid,
    axi_s0_awready,
    axi_s0_wdata,
    axi_s0_wstrb,
    axi_s0_wlast,
    axi_s0_wvalid,
    axi_s0_wready,
    axi_s0_bready,
    axi_s0_bid,
    axi_s0_bresp,
    axi_s0_bvalid,
    axi_s0_arid,
    axi_s0_araddr,
    axi_s0_arlen,
    axi_s0_arsize,
    axi_s0_arburst,
    axi_s0_arprot,
    axi_s0_arvalid,
    axi_s0_arready,
    axi_s0_rready,
    axi_s0_rid,
    axi_s0_rdata,
    axi_s0_rresp,
    axi_s0_rlast,
    axi_s0_rvalid,
    axi_m0_awaddr,
    axi_m0_awvalid,
    axi_m0_awready,
    axi_m0_wdata,
    axi_m0_wvalid,
    axi_m0_wready,
    axi_m0_bresp,
    axi_m0_bvalid,
    axi_m0_bready,
    axi_m0_araddr,
    axi_m0_arvalid,
    axi_m0_arready,
    axi_m0_rdata,
    axi_m0_rresp,
    axi_m0_rvalid,
    axi_m0_rready,
    axi_m1_awaddr,
    axi_m1_awvalid,
    axi_m1_awready,
    axi_m1_wdata,
    axi_m1_wvalid,
    axi_m1_wready,
    axi_m1_bresp,
    axi_m1_bvalid,
    axi_m1_bready,
    axi_m1_araddr,
    axi_m1_arvalid,
    axi_m1_arready,
    axi_m1_rdata,
    axi_m1_rresp,
    axi_m1_rvalid,
    axi_m1_rready,
    axi_m2_awaddr,
    axi_m2_awvalid,
    axi_m2_awready,
    axi_m2_wdata,
    axi_m2_wvalid,
    axi_m2_wready,
    axi_m2_bresp,
    axi_m2_bvalid,
    axi_m2_bready,
    axi_m2_araddr,
    axi_m2_arvalid,
    axi_m2_arready,
    axi_m2_rdata,
    axi_m2_rresp,
    axi_m2_rvalid,
    axi_m2_rready,
    axi_m3_awaddr,
    axi_m3_awvalid,
    axi_m3_awready,
    axi_m3_wdata,
    axi_m3_wvalid,
    axi_m3_wready,
    axi_m3_bresp,
    axi_m3_bvalid,
    axi_m3_bready,
    axi_m3_araddr,
    axi_m3_arvalid,
    axi_m3_arready,
    axi_m3_rdata,
    axi_m3_rresp,
    axi_m3_rvalid,
    axi_m3_rready,
    axi_m4_awaddr,
    axi_m4_awvalid,
    axi_m4_awready,
    axi_m4_wdata,
    axi_m4_wvalid,
    axi_m4_wready,
    axi_m4_bresp,
    axi_m4_bvalid,
    axi_m4_bready,
    axi_m4_araddr,
    axi_m4_arvalid,
    axi_m4_arready,
    axi_m4_rdata,
    axi_m4_rresp,
    axi_m4_rvalid,
    axi_m4_rready,
    axi_m4_awid,
    axi_m4_awlen,
    axi_m4_awsize,
    axi_m4_awburst,
    axi_m4_awprot,
    axi_m4_wstrb,
    axi_m4_wlast,
    axi_m4_arid,
    axi_m4_arlen,
    axi_m4_arsize,
    axi_m4_arburst,
    axi_m4_arprot,
    axi_m4_bid,
    axi_m4_rlast,
    axi_m4_rid,
    axi_m5_awaddr,
    axi_m5_awvalid,
    axi_m5_awready,
    axi_m5_wdata,
    axi_m5_wvalid,
    axi_m5_wready,
    axi_m5_bresp,
    axi_m5_bvalid,
    axi_m5_bready,
    axi_m5_araddr,
    axi_m5_arvalid,
    axi_m5_arready,
    axi_m5_rdata,
    axi_m5_rresp,
    axi_m5_rvalid,
    axi_m5_rready,
    axi_m5_awid,
    axi_m5_awlen,
    axi_m5_awsize,
    axi_m5_awburst,
    axi_m5_awprot,
    axi_m5_wstrb,
    axi_m5_wlast,
    axi_m5_arid,
    axi_m5_arlen,
    axi_m5_arsize,
    axi_m5_arburst,
    axi_m5_arprot,
    axi_m5_bid,
    axi_m5_rlast,
    axi_m5_rid);
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

  wire \<const0> ;
  wire axi_m0_arready;
  wire axi_m0_arvalid;
  wire axi_m0_arvalid_INST_0_i_1_n_0;
  wire axi_m0_awready;
  wire axi_m0_awvalid;
  wire [1:0]axi_m0_bresp;
  wire axi_m0_bvalid;
  wire [31:0]axi_m0_rdata;
  wire [1:0]axi_m0_rresp;
  wire axi_m0_rvalid;
  wire axi_m0_wready;
  wire axi_m0_wvalid;
  wire axi_m1_arready;
  wire axi_m1_arvalid;
  wire axi_m1_awready;
  wire axi_m1_awvalid;
  wire [1:0]axi_m1_bresp;
  wire axi_m1_bvalid;
  wire [31:0]axi_m1_rdata;
  wire [1:0]axi_m1_rresp;
  wire axi_m1_rvalid;
  wire axi_m1_wready;
  wire axi_m1_wvalid;
  wire axi_m2_arready;
  wire axi_m2_arvalid;
  wire axi_m2_awready;
  wire axi_m2_awvalid;
  wire [1:0]axi_m2_bresp;
  wire axi_m2_bvalid;
  wire [31:0]axi_m2_rdata;
  wire [1:0]axi_m2_rresp;
  wire axi_m2_rvalid;
  wire axi_m2_wready;
  wire axi_m2_wvalid;
  wire axi_m3_arready;
  wire axi_m3_arvalid;
  wire axi_m3_awready;
  wire axi_m3_awvalid;
  wire [1:0]axi_m3_bresp;
  wire axi_m3_bvalid;
  wire [31:0]axi_m3_rdata;
  wire [1:0]axi_m3_rresp;
  wire axi_m3_rvalid;
  wire axi_m3_wready;
  wire axi_m3_wvalid;
  wire axi_m4_arready;
  wire axi_m4_arvalid;
  wire axi_m4_arvalid_INST_0_i_1_n_0;
  wire axi_m4_awready;
  wire axi_m4_awvalid;
  wire axi_m4_awvalid_INST_0_i_1_n_0;
  wire [1:0]axi_m4_bresp;
  wire axi_m4_bvalid;
  wire [31:0]axi_m4_rdata;
  wire [1:0]axi_m4_rresp;
  wire axi_m4_rvalid;
  wire axi_m4_wready;
  wire axi_m4_wvalid;
  wire axi_m5_arready;
  wire axi_m5_arvalid;
  wire axi_m5_arvalid_INST_0_i_1_n_0;
  wire axi_m5_awready;
  wire axi_m5_awvalid;
  wire axi_m5_awvalid_INST_0_i_1_n_0;
  wire [1:0]axi_m5_bresp;
  wire axi_m5_bvalid;
  wire [31:0]axi_m5_rdata;
  wire [1:0]axi_m5_rresp;
  wire axi_m5_rvalid;
  wire axi_m5_wready;
  wire axi_m5_wvalid;
  wire [31:0]axi_s0_araddr;
  wire axi_s0_arready;
  wire axi_s0_arready_INST_0_i_1_n_0;
  wire axi_s0_arready_INST_0_i_2_n_0;
  wire axi_s0_arready_INST_0_i_3_n_0;
  wire axi_s0_arready_INST_0_i_4_n_0;
  wire axi_s0_arready_INST_0_i_5_n_0;
  wire axi_s0_arvalid;
  wire [31:0]axi_s0_awaddr;
  wire axi_s0_awready;
  wire axi_s0_awready_INST_0_i_1_n_0;
  wire axi_s0_awready_INST_0_i_2_n_0;
  wire axi_s0_awready_INST_0_i_3_n_0;
  wire axi_s0_awready_INST_0_i_4_n_0;
  wire axi_s0_awready_INST_0_i_5_n_0;
  wire axi_s0_awready_INST_0_i_6_n_0;
  wire axi_s0_awready_INST_0_i_7_n_0;
  wire axi_s0_awready_INST_0_i_8_n_0;
  wire axi_s0_awvalid;
  wire axi_s0_bready;
  wire [1:0]axi_s0_bresp;
  wire \axi_s0_bresp[0]_INST_0_i_1_n_0 ;
  wire \axi_s0_bresp[0]_INST_0_i_2_n_0 ;
  wire \axi_s0_bresp[1]_INST_0_i_1_n_0 ;
  wire \axi_s0_bresp[1]_INST_0_i_2_n_0 ;
  wire axi_s0_bvalid;
  wire [31:0]axi_s0_rdata;
  wire \axi_s0_rdata[0]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[0]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[10]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[10]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[11]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[11]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[12]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[12]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[13]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[13]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[14]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[14]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[15]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[15]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[16]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[16]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[17]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[17]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[18]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[18]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[19]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[19]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[1]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[1]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[20]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[20]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[21]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[21]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[22]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[22]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[23]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[23]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[24]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[24]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[25]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[25]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[26]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[26]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[27]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[27]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[28]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[28]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[29]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[29]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[2]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[2]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[30]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[30]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[31]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[31]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[3]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[3]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[4]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[4]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[5]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[5]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[6]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[6]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[7]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[7]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[8]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[8]_INST_0_i_2_n_0 ;
  wire \axi_s0_rdata[9]_INST_0_i_1_n_0 ;
  wire \axi_s0_rdata[9]_INST_0_i_2_n_0 ;
  wire axi_s0_rready;
  wire [1:0]axi_s0_rresp;
  wire \axi_s0_rresp[0]_INST_0_i_1_n_0 ;
  wire \axi_s0_rresp[0]_INST_0_i_2_n_0 ;
  wire \axi_s0_rresp[1]_INST_0_i_1_n_0 ;
  wire \axi_s0_rresp[1]_INST_0_i_2_n_0 ;
  wire axi_s0_rvalid;
  wire [31:0]axi_s0_wdata;
  wire axi_s0_wready;
  wire axi_s0_wready_INST_0_i_1_n_0;
  wire axi_s0_wready_INST_0_i_2_n_0;
  wire axi_s0_wvalid;

  assign axi_m0_araddr[31:0] = axi_s0_araddr;
  assign axi_m0_awaddr[31:0] = axi_s0_awaddr;
  assign axi_m0_bready = axi_s0_bready;
  assign axi_m0_rready = axi_s0_rready;
  assign axi_m0_wdata[31:0] = axi_s0_wdata;
  assign axi_m1_araddr[31:0] = axi_s0_araddr;
  assign axi_m1_awaddr[31:0] = axi_s0_awaddr;
  assign axi_m1_bready = axi_s0_bready;
  assign axi_m1_rready = axi_s0_rready;
  assign axi_m1_wdata[31:0] = axi_s0_wdata;
  assign axi_m2_araddr[31:0] = axi_s0_araddr;
  assign axi_m2_awaddr[31:0] = axi_s0_awaddr;
  assign axi_m2_bready = axi_s0_bready;
  assign axi_m2_rready = axi_s0_rready;
  assign axi_m2_wdata[31:0] = axi_s0_wdata;
  assign axi_m3_araddr[31:0] = axi_s0_araddr;
  assign axi_m3_awaddr[31:0] = axi_s0_awaddr;
  assign axi_m3_bready = axi_s0_bready;
  assign axi_m3_rready = axi_s0_rready;
  assign axi_m3_wdata[31:0] = axi_s0_wdata;
  assign axi_m4_araddr[31:0] = axi_s0_araddr;
  assign axi_m4_arburst[1] = \<const0> ;
  assign axi_m4_arburst[0] = \<const0> ;
  assign axi_m4_arid[3] = \<const0> ;
  assign axi_m4_arid[2] = \<const0> ;
  assign axi_m4_arid[1] = \<const0> ;
  assign axi_m4_arid[0] = \<const0> ;
  assign axi_m4_arlen[7] = \<const0> ;
  assign axi_m4_arlen[6] = \<const0> ;
  assign axi_m4_arlen[5] = \<const0> ;
  assign axi_m4_arlen[4] = \<const0> ;
  assign axi_m4_arlen[3] = \<const0> ;
  assign axi_m4_arlen[2] = \<const0> ;
  assign axi_m4_arlen[1] = \<const0> ;
  assign axi_m4_arlen[0] = \<const0> ;
  assign axi_m4_arprot[2] = \<const0> ;
  assign axi_m4_arprot[1] = \<const0> ;
  assign axi_m4_arprot[0] = \<const0> ;
  assign axi_m4_arsize[2] = \<const0> ;
  assign axi_m4_arsize[1] = \<const0> ;
  assign axi_m4_arsize[0] = \<const0> ;
  assign axi_m4_awaddr[31:0] = axi_s0_awaddr;
  assign axi_m4_awburst[1] = \<const0> ;
  assign axi_m4_awburst[0] = \<const0> ;
  assign axi_m4_awid[3] = \<const0> ;
  assign axi_m4_awid[2] = \<const0> ;
  assign axi_m4_awid[1] = \<const0> ;
  assign axi_m4_awid[0] = \<const0> ;
  assign axi_m4_awlen[7] = \<const0> ;
  assign axi_m4_awlen[6] = \<const0> ;
  assign axi_m4_awlen[5] = \<const0> ;
  assign axi_m4_awlen[4] = \<const0> ;
  assign axi_m4_awlen[3] = \<const0> ;
  assign axi_m4_awlen[2] = \<const0> ;
  assign axi_m4_awlen[1] = \<const0> ;
  assign axi_m4_awlen[0] = \<const0> ;
  assign axi_m4_awprot[2] = \<const0> ;
  assign axi_m4_awprot[1] = \<const0> ;
  assign axi_m4_awprot[0] = \<const0> ;
  assign axi_m4_awsize[2] = \<const0> ;
  assign axi_m4_awsize[1] = \<const0> ;
  assign axi_m4_awsize[0] = \<const0> ;
  assign axi_m4_bready = axi_s0_bready;
  assign axi_m4_rready = axi_s0_rready;
  assign axi_m4_wdata[31:0] = axi_s0_wdata;
  assign axi_m4_wlast = \<const0> ;
  assign axi_m4_wstrb[3] = \<const0> ;
  assign axi_m4_wstrb[2] = \<const0> ;
  assign axi_m4_wstrb[1] = \<const0> ;
  assign axi_m4_wstrb[0] = \<const0> ;
  assign axi_m5_araddr[31:0] = axi_s0_araddr;
  assign axi_m5_arburst[1] = \<const0> ;
  assign axi_m5_arburst[0] = \<const0> ;
  assign axi_m5_arid[3] = \<const0> ;
  assign axi_m5_arid[2] = \<const0> ;
  assign axi_m5_arid[1] = \<const0> ;
  assign axi_m5_arid[0] = \<const0> ;
  assign axi_m5_arlen[7] = \<const0> ;
  assign axi_m5_arlen[6] = \<const0> ;
  assign axi_m5_arlen[5] = \<const0> ;
  assign axi_m5_arlen[4] = \<const0> ;
  assign axi_m5_arlen[3] = \<const0> ;
  assign axi_m5_arlen[2] = \<const0> ;
  assign axi_m5_arlen[1] = \<const0> ;
  assign axi_m5_arlen[0] = \<const0> ;
  assign axi_m5_arprot[2] = \<const0> ;
  assign axi_m5_arprot[1] = \<const0> ;
  assign axi_m5_arprot[0] = \<const0> ;
  assign axi_m5_arsize[2] = \<const0> ;
  assign axi_m5_arsize[1] = \<const0> ;
  assign axi_m5_arsize[0] = \<const0> ;
  assign axi_m5_awaddr[31:0] = axi_s0_awaddr;
  assign axi_m5_awburst[1] = \<const0> ;
  assign axi_m5_awburst[0] = \<const0> ;
  assign axi_m5_awid[3] = \<const0> ;
  assign axi_m5_awid[2] = \<const0> ;
  assign axi_m5_awid[1] = \<const0> ;
  assign axi_m5_awid[0] = \<const0> ;
  assign axi_m5_awlen[7] = \<const0> ;
  assign axi_m5_awlen[6] = \<const0> ;
  assign axi_m5_awlen[5] = \<const0> ;
  assign axi_m5_awlen[4] = \<const0> ;
  assign axi_m5_awlen[3] = \<const0> ;
  assign axi_m5_awlen[2] = \<const0> ;
  assign axi_m5_awlen[1] = \<const0> ;
  assign axi_m5_awlen[0] = \<const0> ;
  assign axi_m5_awprot[2] = \<const0> ;
  assign axi_m5_awprot[1] = \<const0> ;
  assign axi_m5_awprot[0] = \<const0> ;
  assign axi_m5_awsize[2] = \<const0> ;
  assign axi_m5_awsize[1] = \<const0> ;
  assign axi_m5_awsize[0] = \<const0> ;
  assign axi_m5_bready = axi_s0_bready;
  assign axi_m5_rready = axi_s0_rready;
  assign axi_m5_wdata[31:0] = axi_s0_wdata;
  assign axi_m5_wlast = \<const0> ;
  assign axi_m5_wstrb[3] = \<const0> ;
  assign axi_m5_wstrb[2] = \<const0> ;
  assign axi_m5_wstrb[1] = \<const0> ;
  assign axi_m5_wstrb[0] = \<const0> ;
  assign axi_s0_bid[3] = \<const0> ;
  assign axi_s0_bid[2] = \<const0> ;
  assign axi_s0_bid[1] = \<const0> ;
  assign axi_s0_bid[0] = \<const0> ;
  assign axi_s0_rid[3] = \<const0> ;
  assign axi_s0_rid[2] = \<const0> ;
  assign axi_s0_rid[1] = \<const0> ;
  assign axi_s0_rid[0] = \<const0> ;
  assign axi_s0_rlast = \<const0> ;
  GND GND
       (.G(\<const0> ));
  LUT3 #(
    .INIT(8'h02)) 
    axi_m0_arvalid_INST_0
       (.I0(axi_m0_arvalid_INST_0_i_1_n_0),
        .I1(axi_s0_araddr[17]),
        .I2(axi_s0_araddr[16]),
        .O(axi_m0_arvalid));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00080000)) 
    axi_m0_arvalid_INST_0_i_1
       (.I0(axi_s0_arvalid),
        .I1(axi_s0_arready_INST_0_i_2_n_0),
        .I2(axi_s0_araddr[28]),
        .I3(axi_s0_araddr[29]),
        .I4(axi_s0_araddr[30]),
        .O(axi_m0_arvalid_INST_0_i_1_n_0));
  LUT4 #(
    .INIT(16'h1000)) 
    axi_m0_awvalid_INST_0
       (.I0(axi_s0_awaddr[17]),
        .I1(axi_s0_awaddr[16]),
        .I2(axi_s0_awready_INST_0_i_1_n_0),
        .I3(axi_s0_awvalid),
        .O(axi_m0_awvalid));
  LUT4 #(
    .INIT(16'h1000)) 
    axi_m0_wvalid_INST_0
       (.I0(axi_s0_awaddr[17]),
        .I1(axi_s0_awaddr[16]),
        .I2(axi_s0_awready_INST_0_i_1_n_0),
        .I3(axi_s0_wvalid),
        .O(axi_m0_wvalid));
  LUT3 #(
    .INIT(8'h40)) 
    axi_m1_arvalid_INST_0
       (.I0(axi_s0_araddr[17]),
        .I1(axi_s0_araddr[16]),
        .I2(axi_m0_arvalid_INST_0_i_1_n_0),
        .O(axi_m1_arvalid));
  LUT4 #(
    .INIT(16'h0800)) 
    axi_m1_awvalid_INST_0
       (.I0(axi_s0_awaddr[16]),
        .I1(axi_s0_awready_INST_0_i_1_n_0),
        .I2(axi_s0_awaddr[17]),
        .I3(axi_s0_awvalid),
        .O(axi_m1_awvalid));
  LUT4 #(
    .INIT(16'h0800)) 
    axi_m1_wvalid_INST_0
       (.I0(axi_s0_awaddr[16]),
        .I1(axi_s0_awready_INST_0_i_1_n_0),
        .I2(axi_s0_awaddr[17]),
        .I3(axi_s0_wvalid),
        .O(axi_m1_wvalid));
  LUT3 #(
    .INIT(8'h40)) 
    axi_m2_arvalid_INST_0
       (.I0(axi_s0_araddr[16]),
        .I1(axi_s0_araddr[17]),
        .I2(axi_m0_arvalid_INST_0_i_1_n_0),
        .O(axi_m2_arvalid));
  LUT4 #(
    .INIT(16'h4000)) 
    axi_m2_awvalid_INST_0
       (.I0(axi_s0_awaddr[16]),
        .I1(axi_s0_awaddr[17]),
        .I2(axi_s0_awready_INST_0_i_1_n_0),
        .I3(axi_s0_awvalid),
        .O(axi_m2_awvalid));
  LUT4 #(
    .INIT(16'h4000)) 
    axi_m2_wvalid_INST_0
       (.I0(axi_s0_awaddr[16]),
        .I1(axi_s0_awaddr[17]),
        .I2(axi_s0_awready_INST_0_i_1_n_0),
        .I3(axi_s0_wvalid),
        .O(axi_m2_wvalid));
  LUT3 #(
    .INIT(8'h80)) 
    axi_m3_arvalid_INST_0
       (.I0(axi_s0_araddr[17]),
        .I1(axi_s0_araddr[16]),
        .I2(axi_m0_arvalid_INST_0_i_1_n_0),
        .O(axi_m3_arvalid));
  LUT4 #(
    .INIT(16'h8000)) 
    axi_m3_awvalid_INST_0
       (.I0(axi_s0_awaddr[16]),
        .I1(axi_s0_awready_INST_0_i_1_n_0),
        .I2(axi_s0_awaddr[17]),
        .I3(axi_s0_awvalid),
        .O(axi_m3_awvalid));
  LUT4 #(
    .INIT(16'h8000)) 
    axi_m3_wvalid_INST_0
       (.I0(axi_s0_awaddr[16]),
        .I1(axi_s0_awready_INST_0_i_1_n_0),
        .I2(axi_s0_awaddr[17]),
        .I3(axi_s0_wvalid),
        .O(axi_m3_wvalid));
  LUT5 #(
    .INIT(32'h00100000)) 
    axi_m4_arvalid_INST_0
       (.I0(axi_s0_araddr[16]),
        .I1(axi_s0_araddr[17]),
        .I2(axi_s0_araddr[29]),
        .I3(axi_s0_araddr[30]),
        .I4(axi_m4_arvalid_INST_0_i_1_n_0),
        .O(axi_m4_arvalid));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h40)) 
    axi_m4_arvalid_INST_0_i_1
       (.I0(axi_s0_araddr[28]),
        .I1(axi_s0_arready_INST_0_i_2_n_0),
        .I2(axi_s0_arvalid),
        .O(axi_m4_arvalid_INST_0_i_1_n_0));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    axi_m4_awvalid_INST_0
       (.I0(axi_s0_awaddr[29]),
        .I1(axi_s0_awaddr[17]),
        .I2(axi_s0_awaddr[16]),
        .I3(axi_s0_awaddr[30]),
        .I4(axi_m4_awvalid_INST_0_i_1_n_0),
        .I5(axi_s0_awvalid),
        .O(axi_m4_awvalid));
  LUT6 #(
    .INIT(64'h0000000000020000)) 
    axi_m4_awvalid_INST_0_i_1
       (.I0(axi_s0_awready_INST_0_i_6_n_0),
        .I1(axi_s0_awaddr[31]),
        .I2(axi_s0_awaddr[18]),
        .I3(axi_s0_awaddr[19]),
        .I4(axi_s0_awready_INST_0_i_4_n_0),
        .I5(axi_s0_awaddr[28]),
        .O(axi_m4_awvalid_INST_0_i_1_n_0));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    axi_m4_wvalid_INST_0
       (.I0(axi_s0_awaddr[29]),
        .I1(axi_s0_awaddr[17]),
        .I2(axi_s0_awaddr[16]),
        .I3(axi_s0_awaddr[30]),
        .I4(axi_m4_awvalid_INST_0_i_1_n_0),
        .I5(axi_s0_wvalid),
        .O(axi_m4_wvalid));
  LUT6 #(
    .INIT(64'h0020000000000000)) 
    axi_m5_arvalid_INST_0
       (.I0(axi_m5_arvalid_INST_0_i_1_n_0),
        .I1(axi_s0_araddr[29]),
        .I2(axi_s0_araddr[28]),
        .I3(axi_s0_araddr[30]),
        .I4(axi_s0_arvalid),
        .I5(axi_s0_arready_INST_0_i_2_n_0),
        .O(axi_m5_arvalid));
  LUT2 #(
    .INIT(4'h1)) 
    axi_m5_arvalid_INST_0_i_1
       (.I0(axi_s0_araddr[16]),
        .I1(axi_s0_araddr[17]),
        .O(axi_m5_arvalid_INST_0_i_1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    axi_m5_awvalid_INST_0
       (.I0(axi_m5_awvalid_INST_0_i_1_n_0),
        .I1(axi_s0_awvalid),
        .O(axi_m5_awvalid));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    axi_m5_awvalid_INST_0_i_1
       (.I0(axi_s0_awready_INST_0_i_7_n_0),
        .I1(axi_s0_awaddr[17]),
        .I2(axi_s0_awaddr[16]),
        .I3(axi_s0_awaddr[30]),
        .I4(axi_s0_awaddr[29]),
        .I5(axi_s0_awaddr[28]),
        .O(axi_m5_awvalid_INST_0_i_1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    axi_m5_wvalid_INST_0
       (.I0(axi_m5_awvalid_INST_0_i_1_n_0),
        .I1(axi_s0_wvalid),
        .O(axi_m5_wvalid));
  LUT6 #(
    .INIT(64'hFFFF000004000000)) 
    axi_s0_arready_INST_0
       (.I0(axi_s0_araddr[28]),
        .I1(axi_s0_arready_INST_0_i_1_n_0),
        .I2(axi_s0_araddr[29]),
        .I3(axi_s0_araddr[30]),
        .I4(axi_s0_arready_INST_0_i_2_n_0),
        .I5(axi_s0_arready_INST_0_i_3_n_0),
        .O(axi_s0_arready));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    axi_s0_arready_INST_0_i_1
       (.I0(axi_m3_arready),
        .I1(axi_m1_arready),
        .I2(axi_s0_araddr[16]),
        .I3(axi_m2_arready),
        .I4(axi_s0_araddr[17]),
        .I5(axi_m0_arready),
        .O(axi_s0_arready_INST_0_i_1_n_0));
  LUT5 #(
    .INIT(32'h00020000)) 
    axi_s0_arready_INST_0_i_2
       (.I0(axi_s0_arready_INST_0_i_4_n_0),
        .I1(axi_s0_araddr[19]),
        .I2(axi_s0_araddr[18]),
        .I3(axi_s0_araddr[31]),
        .I4(axi_s0_arready_INST_0_i_5_n_0),
        .O(axi_s0_arready_INST_0_i_2_n_0));
  LUT6 #(
    .INIT(64'h0400404004000000)) 
    axi_s0_arready_INST_0_i_3
       (.I0(axi_s0_araddr[30]),
        .I1(axi_m5_arvalid_INST_0_i_1_n_0),
        .I2(axi_s0_araddr[29]),
        .I3(axi_m5_arready),
        .I4(axi_s0_araddr[28]),
        .I5(axi_m4_arready),
        .O(axi_s0_arready_INST_0_i_3_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    axi_s0_arready_INST_0_i_4
       (.I0(axi_s0_araddr[23]),
        .I1(axi_s0_araddr[22]),
        .I2(axi_s0_araddr[21]),
        .I3(axi_s0_araddr[20]),
        .O(axi_s0_arready_INST_0_i_4_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    axi_s0_arready_INST_0_i_5
       (.I0(axi_s0_araddr[27]),
        .I1(axi_s0_araddr[26]),
        .I2(axi_s0_araddr[25]),
        .I3(axi_s0_araddr[24]),
        .O(axi_s0_arready_INST_0_i_5_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFF10FF00)) 
    axi_s0_awready_INST_0
       (.I0(axi_s0_awaddr[17]),
        .I1(axi_s0_awaddr[16]),
        .I2(axi_s0_awready_INST_0_i_1_n_0),
        .I3(axi_s0_awready_INST_0_i_2_n_0),
        .I4(axi_m0_awready),
        .I5(axi_s0_awready_INST_0_i_3_n_0),
        .O(axi_s0_awready));
  LUT6 #(
    .INIT(64'h0400000000000000)) 
    axi_s0_awready_INST_0_i_1
       (.I0(axi_s0_awaddr[29]),
        .I1(axi_s0_awaddr[30]),
        .I2(axi_s0_awaddr[28]),
        .I3(axi_s0_awready_INST_0_i_4_n_0),
        .I4(axi_s0_awready_INST_0_i_5_n_0),
        .I5(axi_s0_awready_INST_0_i_6_n_0),
        .O(axi_s0_awready_INST_0_i_1_n_0));
  LUT6 #(
    .INIT(64'hF0CC0000AA000000)) 
    axi_s0_awready_INST_0_i_2
       (.I0(axi_m1_awready),
        .I1(axi_m2_awready),
        .I2(axi_m3_awready),
        .I3(axi_s0_awaddr[16]),
        .I4(axi_s0_awready_INST_0_i_1_n_0),
        .I5(axi_s0_awaddr[17]),
        .O(axi_s0_awready_INST_0_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000C000A0000000)) 
    axi_s0_awready_INST_0_i_3
       (.I0(axi_m4_awready),
        .I1(axi_m5_awready),
        .I2(axi_s0_awready_INST_0_i_7_n_0),
        .I3(axi_s0_awready_INST_0_i_8_n_0),
        .I4(axi_s0_awaddr[29]),
        .I5(axi_s0_awaddr[28]),
        .O(axi_s0_awready_INST_0_i_3_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    axi_s0_awready_INST_0_i_4
       (.I0(axi_s0_awaddr[23]),
        .I1(axi_s0_awaddr[22]),
        .I2(axi_s0_awaddr[21]),
        .I3(axi_s0_awaddr[20]),
        .O(axi_s0_awready_INST_0_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h01)) 
    axi_s0_awready_INST_0_i_5
       (.I0(axi_s0_awaddr[19]),
        .I1(axi_s0_awaddr[18]),
        .I2(axi_s0_awaddr[31]),
        .O(axi_s0_awready_INST_0_i_5_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    axi_s0_awready_INST_0_i_6
       (.I0(axi_s0_awaddr[27]),
        .I1(axi_s0_awaddr[26]),
        .I2(axi_s0_awaddr[25]),
        .I3(axi_s0_awaddr[24]),
        .O(axi_s0_awready_INST_0_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00020000)) 
    axi_s0_awready_INST_0_i_7
       (.I0(axi_s0_awready_INST_0_i_4_n_0),
        .I1(axi_s0_awaddr[19]),
        .I2(axi_s0_awaddr[18]),
        .I3(axi_s0_awaddr[31]),
        .I4(axi_s0_awready_INST_0_i_6_n_0),
        .O(axi_s0_awready_INST_0_i_7_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    axi_s0_awready_INST_0_i_8
       (.I0(axi_s0_awaddr[17]),
        .I1(axi_s0_awaddr[16]),
        .I2(axi_s0_awaddr[30]),
        .O(axi_s0_awready_INST_0_i_8_n_0));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_bresp[0]_INST_0 
       (.I0(axi_m1_bvalid),
        .I1(axi_m2_bvalid),
        .I2(axi_m0_bvalid),
        .I3(\axi_s0_bresp[0]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_bresp[0]_INST_0_i_2_n_0 ),
        .O(axi_s0_bresp[0]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_bresp[0]_INST_0_i_1 
       (.I0(axi_m3_bresp[0]),
        .I1(axi_m5_bresp[0]),
        .I2(axi_m4_bresp[0]),
        .I3(axi_m3_bvalid),
        .I4(axi_m5_bvalid),
        .I5(axi_m4_bvalid),
        .O(\axi_s0_bresp[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_bresp[0]_INST_0_i_2 
       (.I0(axi_m0_bresp[0]),
        .I1(axi_m2_bresp[0]),
        .I2(axi_m1_bresp[0]),
        .I3(axi_m0_bvalid),
        .I4(axi_m2_bvalid),
        .I5(axi_m1_bvalid),
        .O(\axi_s0_bresp[0]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_bresp[1]_INST_0 
       (.I0(axi_m1_bvalid),
        .I1(axi_m2_bvalid),
        .I2(axi_m0_bvalid),
        .I3(\axi_s0_bresp[1]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_bresp[1]_INST_0_i_2_n_0 ),
        .O(axi_s0_bresp[1]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_bresp[1]_INST_0_i_1 
       (.I0(axi_m3_bresp[1]),
        .I1(axi_m5_bresp[1]),
        .I2(axi_m4_bresp[1]),
        .I3(axi_m3_bvalid),
        .I4(axi_m5_bvalid),
        .I5(axi_m4_bvalid),
        .O(\axi_s0_bresp[1]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_bresp[1]_INST_0_i_2 
       (.I0(axi_m0_bresp[1]),
        .I1(axi_m2_bresp[1]),
        .I2(axi_m1_bresp[1]),
        .I3(axi_m0_bvalid),
        .I4(axi_m2_bvalid),
        .I5(axi_m1_bvalid),
        .O(\axi_s0_bresp[1]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    axi_s0_bvalid_INST_0
       (.I0(axi_m0_bvalid),
        .I1(axi_m2_bvalid),
        .I2(axi_m1_bvalid),
        .I3(axi_m4_bvalid),
        .I4(axi_m3_bvalid),
        .O(axi_s0_bvalid));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[0]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[0]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[0]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[0]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[0]_INST_0_i_1 
       (.I0(axi_m3_rdata[0]),
        .I1(axi_m5_rdata[0]),
        .I2(axi_m4_rdata[0]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[0]_INST_0_i_2 
       (.I0(axi_m0_rdata[0]),
        .I1(axi_m2_rdata[0]),
        .I2(axi_m1_rdata[0]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[0]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[10]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[10]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[10]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[10]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[10]_INST_0_i_1 
       (.I0(axi_m3_rdata[10]),
        .I1(axi_m5_rdata[10]),
        .I2(axi_m4_rdata[10]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[10]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[10]_INST_0_i_2 
       (.I0(axi_m0_rdata[10]),
        .I1(axi_m2_rdata[10]),
        .I2(axi_m1_rdata[10]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[10]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[11]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[11]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[11]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[11]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[11]_INST_0_i_1 
       (.I0(axi_m3_rdata[11]),
        .I1(axi_m5_rdata[11]),
        .I2(axi_m4_rdata[11]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[11]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[11]_INST_0_i_2 
       (.I0(axi_m0_rdata[11]),
        .I1(axi_m2_rdata[11]),
        .I2(axi_m1_rdata[11]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[11]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[12]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[12]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[12]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[12]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[12]_INST_0_i_1 
       (.I0(axi_m3_rdata[12]),
        .I1(axi_m5_rdata[12]),
        .I2(axi_m4_rdata[12]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[12]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[12]_INST_0_i_2 
       (.I0(axi_m0_rdata[12]),
        .I1(axi_m2_rdata[12]),
        .I2(axi_m1_rdata[12]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[12]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[13]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[13]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[13]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[13]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[13]_INST_0_i_1 
       (.I0(axi_m3_rdata[13]),
        .I1(axi_m5_rdata[13]),
        .I2(axi_m4_rdata[13]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[13]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[13]_INST_0_i_2 
       (.I0(axi_m0_rdata[13]),
        .I1(axi_m2_rdata[13]),
        .I2(axi_m1_rdata[13]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[13]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[14]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[14]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[14]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[14]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[14]_INST_0_i_1 
       (.I0(axi_m3_rdata[14]),
        .I1(axi_m5_rdata[14]),
        .I2(axi_m4_rdata[14]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[14]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[14]_INST_0_i_2 
       (.I0(axi_m0_rdata[14]),
        .I1(axi_m2_rdata[14]),
        .I2(axi_m1_rdata[14]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[14]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[15]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[15]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[15]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[15]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[15]_INST_0_i_1 
       (.I0(axi_m3_rdata[15]),
        .I1(axi_m5_rdata[15]),
        .I2(axi_m4_rdata[15]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[15]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[15]_INST_0_i_2 
       (.I0(axi_m0_rdata[15]),
        .I1(axi_m2_rdata[15]),
        .I2(axi_m1_rdata[15]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[15]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[16]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[16]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[16]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[16]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[16]_INST_0_i_1 
       (.I0(axi_m3_rdata[16]),
        .I1(axi_m5_rdata[16]),
        .I2(axi_m4_rdata[16]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[16]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[16]_INST_0_i_2 
       (.I0(axi_m0_rdata[16]),
        .I1(axi_m2_rdata[16]),
        .I2(axi_m1_rdata[16]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[16]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[17]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[17]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[17]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[17]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[17]_INST_0_i_1 
       (.I0(axi_m3_rdata[17]),
        .I1(axi_m5_rdata[17]),
        .I2(axi_m4_rdata[17]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[17]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[17]_INST_0_i_2 
       (.I0(axi_m0_rdata[17]),
        .I1(axi_m2_rdata[17]),
        .I2(axi_m1_rdata[17]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[17]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[18]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[18]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[18]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[18]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[18]_INST_0_i_1 
       (.I0(axi_m3_rdata[18]),
        .I1(axi_m5_rdata[18]),
        .I2(axi_m4_rdata[18]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[18]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[18]_INST_0_i_2 
       (.I0(axi_m0_rdata[18]),
        .I1(axi_m2_rdata[18]),
        .I2(axi_m1_rdata[18]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[18]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[19]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[19]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[19]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[19]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[19]_INST_0_i_1 
       (.I0(axi_m3_rdata[19]),
        .I1(axi_m5_rdata[19]),
        .I2(axi_m4_rdata[19]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[19]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[19]_INST_0_i_2 
       (.I0(axi_m0_rdata[19]),
        .I1(axi_m2_rdata[19]),
        .I2(axi_m1_rdata[19]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[19]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[1]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[1]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[1]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[1]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[1]_INST_0_i_1 
       (.I0(axi_m3_rdata[1]),
        .I1(axi_m5_rdata[1]),
        .I2(axi_m4_rdata[1]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[1]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[1]_INST_0_i_2 
       (.I0(axi_m0_rdata[1]),
        .I1(axi_m2_rdata[1]),
        .I2(axi_m1_rdata[1]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[1]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[20]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[20]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[20]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[20]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[20]_INST_0_i_1 
       (.I0(axi_m3_rdata[20]),
        .I1(axi_m5_rdata[20]),
        .I2(axi_m4_rdata[20]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[20]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[20]_INST_0_i_2 
       (.I0(axi_m0_rdata[20]),
        .I1(axi_m2_rdata[20]),
        .I2(axi_m1_rdata[20]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[20]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[21]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[21]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[21]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[21]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[21]_INST_0_i_1 
       (.I0(axi_m3_rdata[21]),
        .I1(axi_m5_rdata[21]),
        .I2(axi_m4_rdata[21]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[21]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[21]_INST_0_i_2 
       (.I0(axi_m0_rdata[21]),
        .I1(axi_m2_rdata[21]),
        .I2(axi_m1_rdata[21]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[21]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[22]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[22]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[22]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[22]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[22]_INST_0_i_1 
       (.I0(axi_m3_rdata[22]),
        .I1(axi_m5_rdata[22]),
        .I2(axi_m4_rdata[22]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[22]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[22]_INST_0_i_2 
       (.I0(axi_m0_rdata[22]),
        .I1(axi_m2_rdata[22]),
        .I2(axi_m1_rdata[22]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[22]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[23]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[23]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[23]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[23]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[23]_INST_0_i_1 
       (.I0(axi_m3_rdata[23]),
        .I1(axi_m5_rdata[23]),
        .I2(axi_m4_rdata[23]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[23]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[23]_INST_0_i_2 
       (.I0(axi_m0_rdata[23]),
        .I1(axi_m2_rdata[23]),
        .I2(axi_m1_rdata[23]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[23]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[24]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[24]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[24]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[24]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[24]_INST_0_i_1 
       (.I0(axi_m3_rdata[24]),
        .I1(axi_m5_rdata[24]),
        .I2(axi_m4_rdata[24]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[24]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[24]_INST_0_i_2 
       (.I0(axi_m0_rdata[24]),
        .I1(axi_m2_rdata[24]),
        .I2(axi_m1_rdata[24]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[24]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[25]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[25]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[25]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[25]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[25]_INST_0_i_1 
       (.I0(axi_m3_rdata[25]),
        .I1(axi_m5_rdata[25]),
        .I2(axi_m4_rdata[25]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[25]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[25]_INST_0_i_2 
       (.I0(axi_m0_rdata[25]),
        .I1(axi_m2_rdata[25]),
        .I2(axi_m1_rdata[25]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[25]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[26]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[26]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[26]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[26]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[26]_INST_0_i_1 
       (.I0(axi_m3_rdata[26]),
        .I1(axi_m5_rdata[26]),
        .I2(axi_m4_rdata[26]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[26]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[26]_INST_0_i_2 
       (.I0(axi_m0_rdata[26]),
        .I1(axi_m2_rdata[26]),
        .I2(axi_m1_rdata[26]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[26]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[27]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[27]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[27]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[27]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[27]_INST_0_i_1 
       (.I0(axi_m3_rdata[27]),
        .I1(axi_m5_rdata[27]),
        .I2(axi_m4_rdata[27]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[27]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[27]_INST_0_i_2 
       (.I0(axi_m0_rdata[27]),
        .I1(axi_m2_rdata[27]),
        .I2(axi_m1_rdata[27]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[27]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[28]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[28]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[28]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[28]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[28]_INST_0_i_1 
       (.I0(axi_m3_rdata[28]),
        .I1(axi_m5_rdata[28]),
        .I2(axi_m4_rdata[28]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[28]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[28]_INST_0_i_2 
       (.I0(axi_m0_rdata[28]),
        .I1(axi_m2_rdata[28]),
        .I2(axi_m1_rdata[28]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[28]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[29]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[29]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[29]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[29]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[29]_INST_0_i_1 
       (.I0(axi_m3_rdata[29]),
        .I1(axi_m5_rdata[29]),
        .I2(axi_m4_rdata[29]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[29]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[29]_INST_0_i_2 
       (.I0(axi_m0_rdata[29]),
        .I1(axi_m2_rdata[29]),
        .I2(axi_m1_rdata[29]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[29]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[2]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[2]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[2]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[2]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[2]_INST_0_i_1 
       (.I0(axi_m3_rdata[2]),
        .I1(axi_m5_rdata[2]),
        .I2(axi_m4_rdata[2]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[2]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[2]_INST_0_i_2 
       (.I0(axi_m0_rdata[2]),
        .I1(axi_m2_rdata[2]),
        .I2(axi_m1_rdata[2]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[2]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[30]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[30]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[30]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[30]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[30]_INST_0_i_1 
       (.I0(axi_m3_rdata[30]),
        .I1(axi_m5_rdata[30]),
        .I2(axi_m4_rdata[30]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[30]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[30]_INST_0_i_2 
       (.I0(axi_m0_rdata[30]),
        .I1(axi_m2_rdata[30]),
        .I2(axi_m1_rdata[30]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[30]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[31]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[31]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[31]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[31]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[31]_INST_0_i_1 
       (.I0(axi_m3_rdata[31]),
        .I1(axi_m5_rdata[31]),
        .I2(axi_m4_rdata[31]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[31]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[31]_INST_0_i_2 
       (.I0(axi_m0_rdata[31]),
        .I1(axi_m2_rdata[31]),
        .I2(axi_m1_rdata[31]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[31]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[3]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[3]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[3]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[3]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[3]_INST_0_i_1 
       (.I0(axi_m3_rdata[3]),
        .I1(axi_m5_rdata[3]),
        .I2(axi_m4_rdata[3]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[3]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[3]_INST_0_i_2 
       (.I0(axi_m0_rdata[3]),
        .I1(axi_m2_rdata[3]),
        .I2(axi_m1_rdata[3]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[3]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[4]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[4]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[4]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[4]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[4]_INST_0_i_1 
       (.I0(axi_m3_rdata[4]),
        .I1(axi_m5_rdata[4]),
        .I2(axi_m4_rdata[4]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[4]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[4]_INST_0_i_2 
       (.I0(axi_m0_rdata[4]),
        .I1(axi_m2_rdata[4]),
        .I2(axi_m1_rdata[4]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[4]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[5]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[5]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[5]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[5]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[5]_INST_0_i_1 
       (.I0(axi_m3_rdata[5]),
        .I1(axi_m5_rdata[5]),
        .I2(axi_m4_rdata[5]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[5]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[5]_INST_0_i_2 
       (.I0(axi_m0_rdata[5]),
        .I1(axi_m2_rdata[5]),
        .I2(axi_m1_rdata[5]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[5]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[6]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[6]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[6]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[6]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[6]_INST_0_i_1 
       (.I0(axi_m3_rdata[6]),
        .I1(axi_m5_rdata[6]),
        .I2(axi_m4_rdata[6]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[6]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[6]_INST_0_i_2 
       (.I0(axi_m0_rdata[6]),
        .I1(axi_m2_rdata[6]),
        .I2(axi_m1_rdata[6]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[6]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[7]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[7]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[7]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[7]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[7]_INST_0_i_1 
       (.I0(axi_m3_rdata[7]),
        .I1(axi_m5_rdata[7]),
        .I2(axi_m4_rdata[7]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[7]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[7]_INST_0_i_2 
       (.I0(axi_m0_rdata[7]),
        .I1(axi_m2_rdata[7]),
        .I2(axi_m1_rdata[7]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[7]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[8]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[8]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[8]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[8]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[8]_INST_0_i_1 
       (.I0(axi_m3_rdata[8]),
        .I1(axi_m5_rdata[8]),
        .I2(axi_m4_rdata[8]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[8]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[8]_INST_0_i_2 
       (.I0(axi_m0_rdata[8]),
        .I1(axi_m2_rdata[8]),
        .I2(axi_m1_rdata[8]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[8]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rdata[9]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rdata[9]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rdata[9]_INST_0_i_2_n_0 ),
        .O(axi_s0_rdata[9]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[9]_INST_0_i_1 
       (.I0(axi_m3_rdata[9]),
        .I1(axi_m5_rdata[9]),
        .I2(axi_m4_rdata[9]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rdata[9]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rdata[9]_INST_0_i_2 
       (.I0(axi_m0_rdata[9]),
        .I1(axi_m2_rdata[9]),
        .I2(axi_m1_rdata[9]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rdata[9]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rresp[0]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rresp[0]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rresp[0]_INST_0_i_2_n_0 ),
        .O(axi_s0_rresp[0]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rresp[0]_INST_0_i_1 
       (.I0(axi_m3_rresp[0]),
        .I1(axi_m5_rresp[0]),
        .I2(axi_m4_rresp[0]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rresp[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rresp[0]_INST_0_i_2 
       (.I0(axi_m0_rresp[0]),
        .I1(axi_m2_rresp[0]),
        .I2(axi_m1_rresp[0]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rresp[0]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    \axi_s0_rresp[1]_INST_0 
       (.I0(axi_m1_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m0_rvalid),
        .I3(\axi_s0_rresp[1]_INST_0_i_1_n_0 ),
        .I4(\axi_s0_rresp[1]_INST_0_i_2_n_0 ),
        .O(axi_s0_rresp[1]));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rresp[1]_INST_0_i_1 
       (.I0(axi_m3_rresp[1]),
        .I1(axi_m5_rresp[1]),
        .I2(axi_m4_rresp[1]),
        .I3(axi_m3_rvalid),
        .I4(axi_m5_rvalid),
        .I5(axi_m4_rvalid),
        .O(\axi_s0_rresp[1]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAF0AACCAA00)) 
    \axi_s0_rresp[1]_INST_0_i_2 
       (.I0(axi_m0_rresp[1]),
        .I1(axi_m2_rresp[1]),
        .I2(axi_m1_rresp[1]),
        .I3(axi_m0_rvalid),
        .I4(axi_m2_rvalid),
        .I5(axi_m1_rvalid),
        .O(\axi_s0_rresp[1]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    axi_s0_rvalid_INST_0
       (.I0(axi_m0_rvalid),
        .I1(axi_m2_rvalid),
        .I2(axi_m1_rvalid),
        .I3(axi_m4_rvalid),
        .I4(axi_m3_rvalid),
        .O(axi_s0_rvalid));
  LUT6 #(
    .INIT(64'hFFFFFFFFFF10FF00)) 
    axi_s0_wready_INST_0
       (.I0(axi_s0_awaddr[17]),
        .I1(axi_s0_awaddr[16]),
        .I2(axi_s0_awready_INST_0_i_1_n_0),
        .I3(axi_s0_wready_INST_0_i_1_n_0),
        .I4(axi_m0_wready),
        .I5(axi_s0_wready_INST_0_i_2_n_0),
        .O(axi_s0_wready));
  LUT6 #(
    .INIT(64'hF0CC0000AA000000)) 
    axi_s0_wready_INST_0_i_1
       (.I0(axi_m1_wready),
        .I1(axi_m2_wready),
        .I2(axi_m3_wready),
        .I3(axi_s0_awaddr[16]),
        .I4(axi_s0_awready_INST_0_i_1_n_0),
        .I5(axi_s0_awaddr[17]),
        .O(axi_s0_wready_INST_0_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000C000A0000000)) 
    axi_s0_wready_INST_0_i_2
       (.I0(axi_m4_wready),
        .I1(axi_m5_wready),
        .I2(axi_s0_awready_INST_0_i_7_n_0),
        .I3(axi_s0_awready_INST_0_i_8_n_0),
        .I4(axi_s0_awaddr[29]),
        .I5(axi_s0_awaddr[28]),
        .O(axi_s0_wready_INST_0_i_2_n_0));
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
