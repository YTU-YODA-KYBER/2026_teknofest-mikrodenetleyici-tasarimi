// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat May  9 17:16:57 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_Instr_Splitter_0_0/design_1_Instr_Splitter_0_0_sim_netlist.v
// Design      : design_1_Instr_Splitter_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_Instr_Splitter_0_0,Instr_Splitter,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "Instr_Splitter,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_Instr_Splitter_0_0
   (clk_i,
    rst_n,
    axi_awid,
    axi_awaddr,
    axi_awlen,
    axi_awsize,
    axi_awburst,
    axi_awprot,
    axi_awvalid,
    axi_awready,
    axi_wdata,
    axi_wstrb,
    axi_wlast,
    axi_wvalid,
    axi_wready,
    axi_bready,
    axi_bid,
    axi_bresp,
    axi_bvalid,
    axi_arid,
    axi_araddr,
    axi_arlen,
    axi_arsize,
    axi_arburst,
    axi_arprot,
    axi_arvalid,
    axi_arready,
    axi_rready,
    axi_rid,
    axi_rdata,
    axi_rresp,
    axi_rlast,
    axi_rvalid,
    i_awid,
    i_awaddr,
    i_awlen,
    i_awsize,
    i_awburst,
    i_awprot,
    i_awvalid,
    i_awready,
    i_wdata,
    i_wstrb,
    i_wlast,
    i_wvalid,
    i_wready,
    i_bready,
    i_bid,
    i_bresp,
    i_bvalid,
    i_arid,
    i_araddr,
    i_arlen,
    i_arsize,
    i_arburst,
    i_arprot,
    i_arvalid,
    i_arready,
    i_rready,
    i_rid,
    i_rdata,
    i_rresp,
    i_rlast,
    i_rvalid,
    b_awid,
    b_awaddr,
    b_awlen,
    b_awsize,
    b_awburst,
    b_awprot,
    b_awvalid,
    b_awready,
    b_wdata,
    b_wstrb,
    b_wlast,
    b_wvalid,
    b_wready,
    b_bready,
    b_bid,
    b_bresp,
    b_bvalid,
    b_arid,
    b_araddr,
    b_arlen,
    b_arsize,
    b_arburst,
    b_arprot,
    b_arvalid,
    b_arready,
    b_rready,
    b_rid,
    b_rdata,
    b_rresp,
    b_rlast,
    b_rvalid);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk_i CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk_i, FREQ_TOLERANCE_HZ 0, ASSOCIATED_BUSIF b:i:axi, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, ASSOCIATED_RESET rst_n, INSERT_VIP 0" *) input rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWID" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [3:0]axi_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWADDR" *) input [31:0]axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWLEN" *) input [7:0]axi_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWSIZE" *) input [2:0]axi_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWBURST" *) input [1:0]axi_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWPROT" *) input [2:0]axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWVALID" *) input axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWREADY" *) output axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WDATA" *) input [31:0]axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WSTRB" *) input [3:0]axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WLAST" *) input axi_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WVALID" *) input axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WREADY" *) output axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi BREADY" *) input axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi BID" *) output [3:0]axi_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi BRESP" *) output [1:0]axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi BVALID" *) output axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARID" *) input [3:0]axi_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARADDR" *) input [31:0]axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARLEN" *) input [7:0]axi_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARSIZE" *) input [2:0]axi_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARBURST" *) input [1:0]axi_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARPROT" *) input [2:0]axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARVALID" *) input axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARREADY" *) output axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RREADY" *) input axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RID" *) output [3:0]axi_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RDATA" *) output [31:0]axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RRESP" *) output [1:0]axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RLAST" *) output axi_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RVALID" *) output axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i AWID" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME i, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [3:0]i_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i AWADDR" *) output [31:0]i_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i AWLEN" *) output [7:0]i_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i AWSIZE" *) output [2:0]i_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i AWBURST" *) output [1:0]i_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i AWPROT" *) output [2:0]i_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i AWVALID" *) output i_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i AWREADY" *) input i_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i WDATA" *) output [31:0]i_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i WSTRB" *) output [3:0]i_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i WLAST" *) output i_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i WVALID" *) output i_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i WREADY" *) input i_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i BREADY" *) output i_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i BID" *) input [3:0]i_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i BRESP" *) input [1:0]i_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i BVALID" *) input i_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i ARID" *) output [3:0]i_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i ARADDR" *) output [31:0]i_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i ARLEN" *) output [7:0]i_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i ARSIZE" *) output [2:0]i_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i ARBURST" *) output [1:0]i_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i ARPROT" *) output [2:0]i_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i ARVALID" *) output i_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i ARREADY" *) input i_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i RREADY" *) output i_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i RID" *) input [3:0]i_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i RDATA" *) input [31:0]i_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i RRESP" *) input [1:0]i_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i RLAST" *) input i_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 i RVALID" *) input i_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b AWID" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME b, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [3:0]b_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b AWADDR" *) output [31:0]b_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b AWLEN" *) output [7:0]b_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b AWSIZE" *) output [2:0]b_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b AWBURST" *) output [1:0]b_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b AWPROT" *) output [2:0]b_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b AWVALID" *) output b_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b AWREADY" *) input b_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b WDATA" *) output [31:0]b_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b WSTRB" *) output [3:0]b_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b WLAST" *) output b_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b WVALID" *) output b_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b WREADY" *) input b_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b BREADY" *) output b_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b BID" *) input [3:0]b_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b BRESP" *) input [1:0]b_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b BVALID" *) input b_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b ARID" *) output [3:0]b_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b ARADDR" *) output [31:0]b_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b ARLEN" *) output [7:0]b_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b ARSIZE" *) output [2:0]b_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b ARBURST" *) output [1:0]b_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b ARPROT" *) output [2:0]b_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b ARVALID" *) output b_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b ARREADY" *) input b_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b RREADY" *) output b_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b RID" *) input [3:0]b_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b RDATA" *) input [31:0]b_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b RRESP" *) input [1:0]b_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b RLAST" *) input b_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 b RVALID" *) input b_rvalid;

  wire \<const0> ;
  wire [31:0]axi_araddr;
  wire axi_arready;
  wire axi_arready_INST_0_i_1_n_0;
  wire axi_arready_INST_0_i_2_n_0;
  wire axi_arready_INST_0_i_3_n_0;
  wire axi_arready_INST_0_i_4_n_0;
  wire axi_arvalid;
  wire [31:0]axi_rdata;
  wire axi_rready;
  wire [1:0]axi_rresp;
  wire axi_rvalid;
  wire b_arready;
  wire b_arvalid;
  wire [31:0]b_rdata;
  wire [1:0]b_rresp;
  wire b_rvalid;
  wire i_arready;
  wire i_arvalid;
  wire [31:0]i_rdata;
  wire [1:0]i_rresp;
  wire i_rvalid;

  assign axi_awready = \<const0> ;
  assign axi_bid[3] = \<const0> ;
  assign axi_bid[2] = \<const0> ;
  assign axi_bid[1] = \<const0> ;
  assign axi_bid[0] = \<const0> ;
  assign axi_bresp[1] = \<const0> ;
  assign axi_bresp[0] = \<const0> ;
  assign axi_bvalid = \<const0> ;
  assign axi_rid[3] = \<const0> ;
  assign axi_rid[2] = \<const0> ;
  assign axi_rid[1] = \<const0> ;
  assign axi_rid[0] = \<const0> ;
  assign axi_rlast = \<const0> ;
  assign axi_wready = \<const0> ;
  assign b_araddr[31:0] = axi_araddr;
  assign b_arburst[1] = \<const0> ;
  assign b_arburst[0] = \<const0> ;
  assign b_arid[3] = \<const0> ;
  assign b_arid[2] = \<const0> ;
  assign b_arid[1] = \<const0> ;
  assign b_arid[0] = \<const0> ;
  assign b_arlen[7] = \<const0> ;
  assign b_arlen[6] = \<const0> ;
  assign b_arlen[5] = \<const0> ;
  assign b_arlen[4] = \<const0> ;
  assign b_arlen[3] = \<const0> ;
  assign b_arlen[2] = \<const0> ;
  assign b_arlen[1] = \<const0> ;
  assign b_arlen[0] = \<const0> ;
  assign b_arprot[2] = \<const0> ;
  assign b_arprot[1] = \<const0> ;
  assign b_arprot[0] = \<const0> ;
  assign b_arsize[2] = \<const0> ;
  assign b_arsize[1] = \<const0> ;
  assign b_arsize[0] = \<const0> ;
  assign b_awaddr[31] = \<const0> ;
  assign b_awaddr[30] = \<const0> ;
  assign b_awaddr[29] = \<const0> ;
  assign b_awaddr[28] = \<const0> ;
  assign b_awaddr[27] = \<const0> ;
  assign b_awaddr[26] = \<const0> ;
  assign b_awaddr[25] = \<const0> ;
  assign b_awaddr[24] = \<const0> ;
  assign b_awaddr[23] = \<const0> ;
  assign b_awaddr[22] = \<const0> ;
  assign b_awaddr[21] = \<const0> ;
  assign b_awaddr[20] = \<const0> ;
  assign b_awaddr[19] = \<const0> ;
  assign b_awaddr[18] = \<const0> ;
  assign b_awaddr[17] = \<const0> ;
  assign b_awaddr[16] = \<const0> ;
  assign b_awaddr[15] = \<const0> ;
  assign b_awaddr[14] = \<const0> ;
  assign b_awaddr[13] = \<const0> ;
  assign b_awaddr[12] = \<const0> ;
  assign b_awaddr[11] = \<const0> ;
  assign b_awaddr[10] = \<const0> ;
  assign b_awaddr[9] = \<const0> ;
  assign b_awaddr[8] = \<const0> ;
  assign b_awaddr[7] = \<const0> ;
  assign b_awaddr[6] = \<const0> ;
  assign b_awaddr[5] = \<const0> ;
  assign b_awaddr[4] = \<const0> ;
  assign b_awaddr[3] = \<const0> ;
  assign b_awaddr[2] = \<const0> ;
  assign b_awaddr[1] = \<const0> ;
  assign b_awaddr[0] = \<const0> ;
  assign b_awburst[1] = \<const0> ;
  assign b_awburst[0] = \<const0> ;
  assign b_awid[3] = \<const0> ;
  assign b_awid[2] = \<const0> ;
  assign b_awid[1] = \<const0> ;
  assign b_awid[0] = \<const0> ;
  assign b_awlen[7] = \<const0> ;
  assign b_awlen[6] = \<const0> ;
  assign b_awlen[5] = \<const0> ;
  assign b_awlen[4] = \<const0> ;
  assign b_awlen[3] = \<const0> ;
  assign b_awlen[2] = \<const0> ;
  assign b_awlen[1] = \<const0> ;
  assign b_awlen[0] = \<const0> ;
  assign b_awprot[2] = \<const0> ;
  assign b_awprot[1] = \<const0> ;
  assign b_awprot[0] = \<const0> ;
  assign b_awsize[2] = \<const0> ;
  assign b_awsize[1] = \<const0> ;
  assign b_awsize[0] = \<const0> ;
  assign b_awvalid = \<const0> ;
  assign b_bready = \<const0> ;
  assign b_rready = axi_rready;
  assign b_wdata[31] = \<const0> ;
  assign b_wdata[30] = \<const0> ;
  assign b_wdata[29] = \<const0> ;
  assign b_wdata[28] = \<const0> ;
  assign b_wdata[27] = \<const0> ;
  assign b_wdata[26] = \<const0> ;
  assign b_wdata[25] = \<const0> ;
  assign b_wdata[24] = \<const0> ;
  assign b_wdata[23] = \<const0> ;
  assign b_wdata[22] = \<const0> ;
  assign b_wdata[21] = \<const0> ;
  assign b_wdata[20] = \<const0> ;
  assign b_wdata[19] = \<const0> ;
  assign b_wdata[18] = \<const0> ;
  assign b_wdata[17] = \<const0> ;
  assign b_wdata[16] = \<const0> ;
  assign b_wdata[15] = \<const0> ;
  assign b_wdata[14] = \<const0> ;
  assign b_wdata[13] = \<const0> ;
  assign b_wdata[12] = \<const0> ;
  assign b_wdata[11] = \<const0> ;
  assign b_wdata[10] = \<const0> ;
  assign b_wdata[9] = \<const0> ;
  assign b_wdata[8] = \<const0> ;
  assign b_wdata[7] = \<const0> ;
  assign b_wdata[6] = \<const0> ;
  assign b_wdata[5] = \<const0> ;
  assign b_wdata[4] = \<const0> ;
  assign b_wdata[3] = \<const0> ;
  assign b_wdata[2] = \<const0> ;
  assign b_wdata[1] = \<const0> ;
  assign b_wdata[0] = \<const0> ;
  assign b_wlast = \<const0> ;
  assign b_wstrb[3] = \<const0> ;
  assign b_wstrb[2] = \<const0> ;
  assign b_wstrb[1] = \<const0> ;
  assign b_wstrb[0] = \<const0> ;
  assign b_wvalid = \<const0> ;
  assign i_araddr[31:0] = axi_araddr;
  assign i_arburst[1] = \<const0> ;
  assign i_arburst[0] = \<const0> ;
  assign i_arid[3] = \<const0> ;
  assign i_arid[2] = \<const0> ;
  assign i_arid[1] = \<const0> ;
  assign i_arid[0] = \<const0> ;
  assign i_arlen[7] = \<const0> ;
  assign i_arlen[6] = \<const0> ;
  assign i_arlen[5] = \<const0> ;
  assign i_arlen[4] = \<const0> ;
  assign i_arlen[3] = \<const0> ;
  assign i_arlen[2] = \<const0> ;
  assign i_arlen[1] = \<const0> ;
  assign i_arlen[0] = \<const0> ;
  assign i_arprot[2] = \<const0> ;
  assign i_arprot[1] = \<const0> ;
  assign i_arprot[0] = \<const0> ;
  assign i_arsize[2] = \<const0> ;
  assign i_arsize[1] = \<const0> ;
  assign i_arsize[0] = \<const0> ;
  assign i_awaddr[31] = \<const0> ;
  assign i_awaddr[30] = \<const0> ;
  assign i_awaddr[29] = \<const0> ;
  assign i_awaddr[28] = \<const0> ;
  assign i_awaddr[27] = \<const0> ;
  assign i_awaddr[26] = \<const0> ;
  assign i_awaddr[25] = \<const0> ;
  assign i_awaddr[24] = \<const0> ;
  assign i_awaddr[23] = \<const0> ;
  assign i_awaddr[22] = \<const0> ;
  assign i_awaddr[21] = \<const0> ;
  assign i_awaddr[20] = \<const0> ;
  assign i_awaddr[19] = \<const0> ;
  assign i_awaddr[18] = \<const0> ;
  assign i_awaddr[17] = \<const0> ;
  assign i_awaddr[16] = \<const0> ;
  assign i_awaddr[15] = \<const0> ;
  assign i_awaddr[14] = \<const0> ;
  assign i_awaddr[13] = \<const0> ;
  assign i_awaddr[12] = \<const0> ;
  assign i_awaddr[11] = \<const0> ;
  assign i_awaddr[10] = \<const0> ;
  assign i_awaddr[9] = \<const0> ;
  assign i_awaddr[8] = \<const0> ;
  assign i_awaddr[7] = \<const0> ;
  assign i_awaddr[6] = \<const0> ;
  assign i_awaddr[5] = \<const0> ;
  assign i_awaddr[4] = \<const0> ;
  assign i_awaddr[3] = \<const0> ;
  assign i_awaddr[2] = \<const0> ;
  assign i_awaddr[1] = \<const0> ;
  assign i_awaddr[0] = \<const0> ;
  assign i_awburst[1] = \<const0> ;
  assign i_awburst[0] = \<const0> ;
  assign i_awid[3] = \<const0> ;
  assign i_awid[2] = \<const0> ;
  assign i_awid[1] = \<const0> ;
  assign i_awid[0] = \<const0> ;
  assign i_awlen[7] = \<const0> ;
  assign i_awlen[6] = \<const0> ;
  assign i_awlen[5] = \<const0> ;
  assign i_awlen[4] = \<const0> ;
  assign i_awlen[3] = \<const0> ;
  assign i_awlen[2] = \<const0> ;
  assign i_awlen[1] = \<const0> ;
  assign i_awlen[0] = \<const0> ;
  assign i_awprot[2] = \<const0> ;
  assign i_awprot[1] = \<const0> ;
  assign i_awprot[0] = \<const0> ;
  assign i_awsize[2] = \<const0> ;
  assign i_awsize[1] = \<const0> ;
  assign i_awsize[0] = \<const0> ;
  assign i_awvalid = \<const0> ;
  assign i_bready = \<const0> ;
  assign i_rready = axi_rready;
  assign i_wdata[31] = \<const0> ;
  assign i_wdata[30] = \<const0> ;
  assign i_wdata[29] = \<const0> ;
  assign i_wdata[28] = \<const0> ;
  assign i_wdata[27] = \<const0> ;
  assign i_wdata[26] = \<const0> ;
  assign i_wdata[25] = \<const0> ;
  assign i_wdata[24] = \<const0> ;
  assign i_wdata[23] = \<const0> ;
  assign i_wdata[22] = \<const0> ;
  assign i_wdata[21] = \<const0> ;
  assign i_wdata[20] = \<const0> ;
  assign i_wdata[19] = \<const0> ;
  assign i_wdata[18] = \<const0> ;
  assign i_wdata[17] = \<const0> ;
  assign i_wdata[16] = \<const0> ;
  assign i_wdata[15] = \<const0> ;
  assign i_wdata[14] = \<const0> ;
  assign i_wdata[13] = \<const0> ;
  assign i_wdata[12] = \<const0> ;
  assign i_wdata[11] = \<const0> ;
  assign i_wdata[10] = \<const0> ;
  assign i_wdata[9] = \<const0> ;
  assign i_wdata[8] = \<const0> ;
  assign i_wdata[7] = \<const0> ;
  assign i_wdata[6] = \<const0> ;
  assign i_wdata[5] = \<const0> ;
  assign i_wdata[4] = \<const0> ;
  assign i_wdata[3] = \<const0> ;
  assign i_wdata[2] = \<const0> ;
  assign i_wdata[1] = \<const0> ;
  assign i_wdata[0] = \<const0> ;
  assign i_wlast = \<const0> ;
  assign i_wstrb[3] = \<const0> ;
  assign i_wstrb[2] = \<const0> ;
  assign i_wstrb[1] = \<const0> ;
  assign i_wstrb[0] = \<const0> ;
  assign i_wvalid = \<const0> ;
  GND GND
       (.G(\<const0> ));
  LUT5 #(
    .INIT(32'h02030200)) 
    axi_arready_INST_0
       (.I0(b_arready),
        .I1(axi_arready_INST_0_i_1_n_0),
        .I2(axi_arready_INST_0_i_2_n_0),
        .I3(axi_araddr[28]),
        .I4(i_arready),
        .O(axi_arready));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    axi_arready_INST_0_i_1
       (.I0(axi_araddr[24]),
        .I1(axi_araddr[17]),
        .I2(axi_araddr[26]),
        .I3(axi_araddr[16]),
        .I4(axi_arready_INST_0_i_3_n_0),
        .I5(axi_arready_INST_0_i_4_n_0),
        .O(axi_arready_INST_0_i_1_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    axi_arready_INST_0_i_2
       (.I0(axi_araddr[29]),
        .I1(axi_araddr[30]),
        .I2(axi_araddr[31]),
        .O(axi_arready_INST_0_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    axi_arready_INST_0_i_3
       (.I0(axi_araddr[21]),
        .I1(axi_araddr[23]),
        .I2(axi_araddr[18]),
        .I3(axi_araddr[22]),
        .O(axi_arready_INST_0_i_3_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    axi_arready_INST_0_i_4
       (.I0(axi_araddr[20]),
        .I1(axi_araddr[27]),
        .I2(axi_araddr[19]),
        .I3(axi_araddr[25]),
        .O(axi_arready_INST_0_i_4_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    axi_rvalid_INST_0
       (.I0(b_rvalid),
        .I1(i_rvalid),
        .O(axi_rvalid));
  LUT6 #(
    .INIT(64'h0000000000020000)) 
    b_arvalid_INST_0
       (.I0(axi_arvalid),
        .I1(axi_araddr[31]),
        .I2(axi_araddr[30]),
        .I3(axi_araddr[29]),
        .I4(axi_araddr[28]),
        .I5(axi_arready_INST_0_i_1_n_0),
        .O(b_arvalid));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    i_arvalid_INST_0
       (.I0(axi_arvalid),
        .I1(axi_araddr[28]),
        .I2(axi_araddr[31]),
        .I3(axi_araddr[30]),
        .I4(axi_araddr[29]),
        .I5(axi_arready_INST_0_i_1_n_0),
        .O(i_arvalid));
  design_1_Instr_Splitter_0_0_Instr_Splitter inst
       (.axi_rdata(axi_rdata),
        .axi_rresp(axi_rresp),
        .b_rdata(b_rdata),
        .b_rresp(b_rresp),
        .b_rvalid(b_rvalid),
        .i_rdata(i_rdata),
        .i_rresp(i_rresp),
        .i_rvalid(i_rvalid));
endmodule

(* ORIG_REF_NAME = "Instr_Splitter" *) 
module design_1_Instr_Splitter_0_0_Instr_Splitter
   (axi_rresp,
    axi_rdata,
    b_rresp,
    b_rvalid,
    i_rvalid,
    i_rresp,
    b_rdata,
    i_rdata);
  output [1:0]axi_rresp;
  output [31:0]axi_rdata;
  input [1:0]b_rresp;
  input b_rvalid;
  input i_rvalid;
  input [1:0]i_rresp;
  input [31:0]b_rdata;
  input [31:0]i_rdata;

  wire [31:0]axi_rdata;
  wire [1:0]axi_rresp;
  wire [31:0]b_rdata;
  wire [1:0]b_rresp;
  wire b_rvalid;
  wire [31:0]i_rdata;
  wire [1:0]i_rresp;
  wire i_rvalid;

  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[0]_INST_0 
       (.I0(b_rdata[0]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[0]),
        .O(axi_rdata[0]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[10]_INST_0 
       (.I0(b_rdata[10]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[10]),
        .O(axi_rdata[10]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[11]_INST_0 
       (.I0(b_rdata[11]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[11]),
        .O(axi_rdata[11]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[12]_INST_0 
       (.I0(b_rdata[12]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[12]),
        .O(axi_rdata[12]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[13]_INST_0 
       (.I0(b_rdata[13]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[13]),
        .O(axi_rdata[13]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[14]_INST_0 
       (.I0(b_rdata[14]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[14]),
        .O(axi_rdata[14]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[15]_INST_0 
       (.I0(b_rdata[15]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[15]),
        .O(axi_rdata[15]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[16]_INST_0 
       (.I0(b_rdata[16]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[16]),
        .O(axi_rdata[16]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[17]_INST_0 
       (.I0(b_rdata[17]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[17]),
        .O(axi_rdata[17]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[18]_INST_0 
       (.I0(b_rdata[18]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[18]),
        .O(axi_rdata[18]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[19]_INST_0 
       (.I0(b_rdata[19]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[19]),
        .O(axi_rdata[19]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[1]_INST_0 
       (.I0(b_rdata[1]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[1]),
        .O(axi_rdata[1]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[20]_INST_0 
       (.I0(b_rdata[20]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[20]),
        .O(axi_rdata[20]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[21]_INST_0 
       (.I0(b_rdata[21]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[21]),
        .O(axi_rdata[21]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[22]_INST_0 
       (.I0(b_rdata[22]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[22]),
        .O(axi_rdata[22]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[23]_INST_0 
       (.I0(b_rdata[23]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[23]),
        .O(axi_rdata[23]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[24]_INST_0 
       (.I0(b_rdata[24]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[24]),
        .O(axi_rdata[24]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[25]_INST_0 
       (.I0(b_rdata[25]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[25]),
        .O(axi_rdata[25]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[26]_INST_0 
       (.I0(b_rdata[26]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[26]),
        .O(axi_rdata[26]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[27]_INST_0 
       (.I0(b_rdata[27]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[27]),
        .O(axi_rdata[27]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[28]_INST_0 
       (.I0(b_rdata[28]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[28]),
        .O(axi_rdata[28]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[29]_INST_0 
       (.I0(b_rdata[29]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[29]),
        .O(axi_rdata[29]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[2]_INST_0 
       (.I0(b_rdata[2]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[2]),
        .O(axi_rdata[2]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[30]_INST_0 
       (.I0(b_rdata[30]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[30]),
        .O(axi_rdata[30]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[31]_INST_0 
       (.I0(b_rdata[31]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[31]),
        .O(axi_rdata[31]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[3]_INST_0 
       (.I0(b_rdata[3]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[3]),
        .O(axi_rdata[3]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[4]_INST_0 
       (.I0(b_rdata[4]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[4]),
        .O(axi_rdata[4]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[5]_INST_0 
       (.I0(b_rdata[5]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[5]),
        .O(axi_rdata[5]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[6]_INST_0 
       (.I0(b_rdata[6]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[6]),
        .O(axi_rdata[6]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[7]_INST_0 
       (.I0(b_rdata[7]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[7]),
        .O(axi_rdata[7]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[8]_INST_0 
       (.I0(b_rdata[8]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[8]),
        .O(axi_rdata[8]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rdata[9]_INST_0 
       (.I0(b_rdata[9]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rdata[9]),
        .O(axi_rdata[9]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rresp[0]_INST_0 
       (.I0(b_rresp[0]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rresp[0]),
        .O(axi_rresp[0]));
  LUT4 #(
    .INIT(16'hB888)) 
    \axi_rresp[1]_INST_0 
       (.I0(b_rresp[1]),
        .I1(b_rvalid),
        .I2(i_rvalid),
        .I3(i_rresp[1]),
        .O(axi_rresp[1]));
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
