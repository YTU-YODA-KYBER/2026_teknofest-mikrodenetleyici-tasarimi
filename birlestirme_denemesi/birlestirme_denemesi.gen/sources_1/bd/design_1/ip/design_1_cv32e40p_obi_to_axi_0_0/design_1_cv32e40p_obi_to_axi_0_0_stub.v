// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat May  9 17:18:41 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_cv32e40p_obi_to_axi_0_0/design_1_cv32e40p_obi_to_axi_0_0_stub.v
// Design      : design_1_cv32e40p_obi_to_axi_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_cv32e40p_obi_to_axi_0_0,cv32e40p_obi_to_axi_wrapper,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "cv32e40p_obi_to_axi_wrapper,Vivado 2025.2" *) 
module design_1_cv32e40p_obi_to_axi_0_0(clk_i, rst_ni, interrupt_i, interrupt_ack, 
  interrupt_id, axi_instr_arid, axi_instr_araddr, axi_instr_arlen, axi_instr_arsize, 
  axi_instr_arburst, axi_instr_arprot, axi_instr_arvalid, axi_instr_arready, 
  axi_instr_rready, axi_instr_rid, axi_instr_rdata, axi_instr_rresp, axi_instr_rlast, 
  axi_instr_rvalid, axi_instr_awid, axi_instr_awaddr, axi_instr_awlen, axi_instr_awsize, 
  axi_instr_awburst, axi_instr_awprot, axi_instr_awvalid, axi_instr_awready, 
  axi_instr_wdata, axi_instr_wstrb, axi_instr_wlast, axi_instr_wvalid, axi_instr_wready, 
  axi_instr_bready, axi_instr_bid, axi_instr_bresp, axi_instr_bvalid, axi_data_awid, 
  axi_data_awaddr, axi_data_awlen, axi_data_awsize, axi_data_awburst, axi_data_awprot, 
  axi_data_awvalid, axi_data_awready, axi_data_wdata, axi_data_wstrb, axi_data_wlast, 
  axi_data_wvalid, axi_data_wready, axi_data_bready, axi_data_bid, axi_data_bresp, 
  axi_data_bvalid, axi_data_arid, axi_data_araddr, axi_data_arlen, axi_data_arsize, 
  axi_data_arburst, axi_data_arprot, axi_data_arvalid, axi_data_arready, axi_data_rready, 
  axi_data_rid, axi_data_rdata, axi_data_rresp, axi_data_rlast, axi_data_rvalid)
/* synthesis syn_black_box black_box_pad_pin="rst_ni,interrupt_i[31:0],interrupt_ack,interrupt_id[4:0],axi_instr_arid[3:0],axi_instr_araddr[31:0],axi_instr_arlen[7:0],axi_instr_arsize[2:0],axi_instr_arburst[1:0],axi_instr_arprot[2:0],axi_instr_arvalid,axi_instr_arready,axi_instr_rready,axi_instr_rid[3:0],axi_instr_rdata[31:0],axi_instr_rresp[1:0],axi_instr_rlast,axi_instr_rvalid,axi_instr_awid[3:0],axi_instr_awaddr[31:0],axi_instr_awlen[7:0],axi_instr_awsize[2:0],axi_instr_awburst[1:0],axi_instr_awprot[2:0],axi_instr_awvalid,axi_instr_awready,axi_instr_wdata[31:0],axi_instr_wstrb[3:0],axi_instr_wlast,axi_instr_wvalid,axi_instr_wready,axi_instr_bready,axi_instr_bid[3:0],axi_instr_bresp[1:0],axi_instr_bvalid,axi_data_awid[3:0],axi_data_awaddr[31:0],axi_data_awlen[7:0],axi_data_awsize[2:0],axi_data_awburst[1:0],axi_data_awprot[2:0],axi_data_awvalid,axi_data_awready,axi_data_wdata[31:0],axi_data_wstrb[3:0],axi_data_wlast,axi_data_wvalid,axi_data_wready,axi_data_bready,axi_data_bid[3:0],axi_data_bresp[1:0],axi_data_bvalid,axi_data_arid[3:0],axi_data_araddr[31:0],axi_data_arlen[7:0],axi_data_arsize[2:0],axi_data_arburst[1:0],axi_data_arprot[2:0],axi_data_arvalid,axi_data_arready,axi_data_rready,axi_data_rid[3:0],axi_data_rdata[31:0],axi_data_rresp[1:0],axi_data_rlast,axi_data_rvalid" */
/* synthesis syn_force_seq_prim="clk_i" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk_i CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk_i, FREQ_TOLERANCE_HZ 0, ASSOCIATED_BUSIF axi_data:axi_instr, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk_i /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_ni RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_ni, POLARITY ACTIVE_LOW, ASSOCIATED_RESET rst_ni, INSERT_VIP 0" *) input rst_ni;
  input [31:0]interrupt_i;
  output interrupt_ack;
  output [4:0]interrupt_id;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr ARID" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_instr, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [3:0]axi_instr_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr ARADDR" *) output [31:0]axi_instr_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr ARLEN" *) output [7:0]axi_instr_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr ARSIZE" *) output [2:0]axi_instr_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr ARBURST" *) output [1:0]axi_instr_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr ARPROT" *) output [2:0]axi_instr_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr ARVALID" *) output axi_instr_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr ARREADY" *) input axi_instr_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr RREADY" *) output axi_instr_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr RID" *) input [3:0]axi_instr_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr RDATA" *) input [31:0]axi_instr_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr RRESP" *) input [1:0]axi_instr_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr RLAST" *) input axi_instr_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr RVALID" *) input axi_instr_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr AWID" *) output [3:0]axi_instr_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr AWADDR" *) output [31:0]axi_instr_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr AWLEN" *) output [7:0]axi_instr_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr AWSIZE" *) output [2:0]axi_instr_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr AWBURST" *) output [1:0]axi_instr_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr AWPROT" *) output [2:0]axi_instr_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr AWVALID" *) output axi_instr_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr AWREADY" *) input axi_instr_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr WDATA" *) output [31:0]axi_instr_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr WSTRB" *) output [3:0]axi_instr_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr WLAST" *) output axi_instr_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr WVALID" *) output axi_instr_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr WREADY" *) input axi_instr_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr BREADY" *) output axi_instr_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr BID" *) input [3:0]axi_instr_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr BRESP" *) input [1:0]axi_instr_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_instr BVALID" *) input axi_instr_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data AWID" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_data, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [3:0]axi_data_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data AWADDR" *) output [31:0]axi_data_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data AWLEN" *) output [7:0]axi_data_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data AWSIZE" *) output [2:0]axi_data_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data AWBURST" *) output [1:0]axi_data_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data AWPROT" *) output [2:0]axi_data_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data AWVALID" *) output axi_data_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data AWREADY" *) input axi_data_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data WDATA" *) output [31:0]axi_data_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data WSTRB" *) output [3:0]axi_data_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data WLAST" *) output axi_data_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data WVALID" *) output axi_data_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data WREADY" *) input axi_data_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data BREADY" *) output axi_data_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data BID" *) input [3:0]axi_data_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data BRESP" *) input [1:0]axi_data_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data BVALID" *) input axi_data_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data ARID" *) output [3:0]axi_data_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data ARADDR" *) output [31:0]axi_data_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data ARLEN" *) output [7:0]axi_data_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data ARSIZE" *) output [2:0]axi_data_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data ARBURST" *) output [1:0]axi_data_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data ARPROT" *) output [2:0]axi_data_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data ARVALID" *) output axi_data_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data ARREADY" *) input axi_data_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data RREADY" *) output axi_data_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data RID" *) input [3:0]axi_data_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data RDATA" *) input [31:0]axi_data_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data RRESP" *) input [1:0]axi_data_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data RLAST" *) input axi_data_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_data RVALID" *) input axi_data_rvalid;
endmodule
