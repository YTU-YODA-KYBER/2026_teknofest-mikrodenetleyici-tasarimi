// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat May  9 17:16:57 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_Instr_Splitter_0_0/design_1_Instr_Splitter_0_0_stub.v
// Design      : design_1_Instr_Splitter_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_Instr_Splitter_0_0,Instr_Splitter,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "Instr_Splitter,Vivado 2025.2" *) 
module design_1_Instr_Splitter_0_0(clk_i, rst_n, axi_awid, axi_awaddr, axi_awlen, 
  axi_awsize, axi_awburst, axi_awprot, axi_awvalid, axi_awready, axi_wdata, axi_wstrb, axi_wlast, 
  axi_wvalid, axi_wready, axi_bready, axi_bid, axi_bresp, axi_bvalid, axi_arid, axi_araddr, 
  axi_arlen, axi_arsize, axi_arburst, axi_arprot, axi_arvalid, axi_arready, axi_rready, axi_rid, 
  axi_rdata, axi_rresp, axi_rlast, axi_rvalid, i_awid, i_awaddr, i_awlen, i_awsize, i_awburst, 
  i_awprot, i_awvalid, i_awready, i_wdata, i_wstrb, i_wlast, i_wvalid, i_wready, i_bready, i_bid, 
  i_bresp, i_bvalid, i_arid, i_araddr, i_arlen, i_arsize, i_arburst, i_arprot, i_arvalid, i_arready, 
  i_rready, i_rid, i_rdata, i_rresp, i_rlast, i_rvalid, b_awid, b_awaddr, b_awlen, b_awsize, b_awburst, 
  b_awprot, b_awvalid, b_awready, b_wdata, b_wstrb, b_wlast, b_wvalid, b_wready, b_bready, b_bid, 
  b_bresp, b_bvalid, b_arid, b_araddr, b_arlen, b_arsize, b_arburst, b_arprot, b_arvalid, b_arready, 
  b_rready, b_rid, b_rdata, b_rresp, b_rlast, b_rvalid)
/* synthesis syn_black_box black_box_pad_pin="clk_i,rst_n,axi_awid[3:0],axi_awaddr[31:0],axi_awlen[7:0],axi_awsize[2:0],axi_awburst[1:0],axi_awprot[2:0],axi_awvalid,axi_awready,axi_wdata[31:0],axi_wstrb[3:0],axi_wlast,axi_wvalid,axi_wready,axi_bready,axi_bid[3:0],axi_bresp[1:0],axi_bvalid,axi_arid[3:0],axi_araddr[31:0],axi_arlen[7:0],axi_arsize[2:0],axi_arburst[1:0],axi_arprot[2:0],axi_arvalid,axi_arready,axi_rready,axi_rid[3:0],axi_rdata[31:0],axi_rresp[1:0],axi_rlast,axi_rvalid,i_awid[3:0],i_awaddr[31:0],i_awlen[7:0],i_awsize[2:0],i_awburst[1:0],i_awprot[2:0],i_awvalid,i_awready,i_wdata[31:0],i_wstrb[3:0],i_wlast,i_wvalid,i_wready,i_bready,i_bid[3:0],i_bresp[1:0],i_bvalid,i_arid[3:0],i_araddr[31:0],i_arlen[7:0],i_arsize[2:0],i_arburst[1:0],i_arprot[2:0],i_arvalid,i_arready,i_rready,i_rid[3:0],i_rdata[31:0],i_rresp[1:0],i_rlast,i_rvalid,b_awid[3:0],b_awaddr[31:0],b_awlen[7:0],b_awsize[2:0],b_awburst[1:0],b_awprot[2:0],b_awvalid,b_awready,b_wdata[31:0],b_wstrb[3:0],b_wlast,b_wvalid,b_wready,b_bready,b_bid[3:0],b_bresp[1:0],b_bvalid,b_arid[3:0],b_araddr[31:0],b_arlen[7:0],b_arsize[2:0],b_arburst[1:0],b_arprot[2:0],b_arvalid,b_arready,b_rready,b_rid[3:0],b_rdata[31:0],b_rresp[1:0],b_rlast,b_rvalid" */;
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
endmodule
