// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat May  9 17:15:08 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_Timer_module_0_0/design_1_Timer_module_0_0_sim_netlist.v
// Design      : design_1_Timer_module_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_Timer_module_0_0,Timer_module,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "Timer_module,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_Timer_module_0_0
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
    rvalid);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF interface_aximm, FREQ_TOLERANCE_HZ 0, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk_i;
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

  wire \<const0> ;
  wire \<const1> ;
  wire [31:0]araddr;
  wire arready;
  wire arvalid;
  wire [31:0]awaddr;
  wire awvalid;
  wire bready;
  wire bvalid;
  wire clk_i;
  wire [31:0]rdata;
  wire rready;
  wire rst_n;
  wire rvalid;
  wire [31:0]wdata;
  wire wready;
  wire wvalid;

  assign awready = \<const1> ;
  assign bresp[1] = \<const0> ;
  assign bresp[0] = \<const0> ;
  assign rresp[1] = \<const0> ;
  assign rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  design_1_Timer_module_0_0_Timer_module inst
       (.araddr(araddr[7:0]),
        .arready(arready),
        .arvalid(arvalid),
        .awaddr(awaddr[7:0]),
        .awvalid(awvalid),
        .bready(bready),
        .bvalid(bvalid),
        .clk_i(clk_i),
        .rdata(rdata),
        .rready(rready),
        .rst_n(rst_n),
        .rvalid(rvalid),
        .wdata(wdata),
        .wready(wready),
        .wvalid(wvalid));
endmodule

(* ORIG_REF_NAME = "Timer_module" *) 
module design_1_Timer_module_0_0_Timer_module
   (rdata,
    bvalid,
    wready,
    rvalid,
    arready,
    awaddr,
    clk_i,
    wdata,
    arvalid,
    awvalid,
    wvalid,
    araddr,
    rst_n,
    bready,
    rready);
  output [31:0]rdata;
  output bvalid;
  output wready;
  output rvalid;
  output arready;
  input [7:0]awaddr;
  input clk_i;
  input [31:0]wdata;
  input arvalid;
  input awvalid;
  input wvalid;
  input [7:0]araddr;
  input rst_n;
  input bready;
  input rready;

  wire [31:0]TIM_ARE;
  wire [0:0]TIM_ARE_1;
  wire \TIM_CLR[31]_i_1_n_0 ;
  wire \TIM_CLR[31]_i_3_n_0 ;
  wire \TIM_CLR_reg_n_0_[0] ;
  wire \TIM_CLR_reg_n_0_[10] ;
  wire \TIM_CLR_reg_n_0_[11] ;
  wire \TIM_CLR_reg_n_0_[12] ;
  wire \TIM_CLR_reg_n_0_[13] ;
  wire \TIM_CLR_reg_n_0_[14] ;
  wire \TIM_CLR_reg_n_0_[15] ;
  wire \TIM_CLR_reg_n_0_[16] ;
  wire \TIM_CLR_reg_n_0_[17] ;
  wire \TIM_CLR_reg_n_0_[18] ;
  wire \TIM_CLR_reg_n_0_[19] ;
  wire \TIM_CLR_reg_n_0_[1] ;
  wire \TIM_CLR_reg_n_0_[20] ;
  wire \TIM_CLR_reg_n_0_[21] ;
  wire \TIM_CLR_reg_n_0_[22] ;
  wire \TIM_CLR_reg_n_0_[23] ;
  wire \TIM_CLR_reg_n_0_[24] ;
  wire \TIM_CLR_reg_n_0_[25] ;
  wire \TIM_CLR_reg_n_0_[26] ;
  wire \TIM_CLR_reg_n_0_[27] ;
  wire \TIM_CLR_reg_n_0_[28] ;
  wire \TIM_CLR_reg_n_0_[29] ;
  wire \TIM_CLR_reg_n_0_[2] ;
  wire \TIM_CLR_reg_n_0_[30] ;
  wire \TIM_CLR_reg_n_0_[31] ;
  wire \TIM_CLR_reg_n_0_[3] ;
  wire \TIM_CLR_reg_n_0_[4] ;
  wire \TIM_CLR_reg_n_0_[5] ;
  wire \TIM_CLR_reg_n_0_[6] ;
  wire \TIM_CLR_reg_n_0_[7] ;
  wire \TIM_CLR_reg_n_0_[8] ;
  wire \TIM_CLR_reg_n_0_[9] ;
  wire [31:0]TIM_CNT;
  wire [31:1]TIM_CNT0;
  wire \TIM_CNT0_inferred__0/i__carry__0_n_0 ;
  wire \TIM_CNT0_inferred__0/i__carry__0_n_1 ;
  wire \TIM_CNT0_inferred__0/i__carry__0_n_2 ;
  wire \TIM_CNT0_inferred__0/i__carry__0_n_3 ;
  wire \TIM_CNT0_inferred__0/i__carry__0_n_4 ;
  wire \TIM_CNT0_inferred__0/i__carry__0_n_5 ;
  wire \TIM_CNT0_inferred__0/i__carry__0_n_6 ;
  wire \TIM_CNT0_inferred__0/i__carry__0_n_7 ;
  wire \TIM_CNT0_inferred__0/i__carry__1_n_0 ;
  wire \TIM_CNT0_inferred__0/i__carry__1_n_1 ;
  wire \TIM_CNT0_inferred__0/i__carry__1_n_2 ;
  wire \TIM_CNT0_inferred__0/i__carry__1_n_3 ;
  wire \TIM_CNT0_inferred__0/i__carry__1_n_4 ;
  wire \TIM_CNT0_inferred__0/i__carry__1_n_5 ;
  wire \TIM_CNT0_inferred__0/i__carry__1_n_6 ;
  wire \TIM_CNT0_inferred__0/i__carry__1_n_7 ;
  wire \TIM_CNT0_inferred__0/i__carry__2_n_0 ;
  wire \TIM_CNT0_inferred__0/i__carry__2_n_1 ;
  wire \TIM_CNT0_inferred__0/i__carry__2_n_2 ;
  wire \TIM_CNT0_inferred__0/i__carry__2_n_3 ;
  wire \TIM_CNT0_inferred__0/i__carry__2_n_4 ;
  wire \TIM_CNT0_inferred__0/i__carry__2_n_5 ;
  wire \TIM_CNT0_inferred__0/i__carry__2_n_6 ;
  wire \TIM_CNT0_inferred__0/i__carry__2_n_7 ;
  wire \TIM_CNT0_inferred__0/i__carry__3_n_0 ;
  wire \TIM_CNT0_inferred__0/i__carry__3_n_1 ;
  wire \TIM_CNT0_inferred__0/i__carry__3_n_2 ;
  wire \TIM_CNT0_inferred__0/i__carry__3_n_3 ;
  wire \TIM_CNT0_inferred__0/i__carry__3_n_4 ;
  wire \TIM_CNT0_inferred__0/i__carry__3_n_5 ;
  wire \TIM_CNT0_inferred__0/i__carry__3_n_6 ;
  wire \TIM_CNT0_inferred__0/i__carry__3_n_7 ;
  wire \TIM_CNT0_inferred__0/i__carry__4_n_0 ;
  wire \TIM_CNT0_inferred__0/i__carry__4_n_1 ;
  wire \TIM_CNT0_inferred__0/i__carry__4_n_2 ;
  wire \TIM_CNT0_inferred__0/i__carry__4_n_3 ;
  wire \TIM_CNT0_inferred__0/i__carry__4_n_4 ;
  wire \TIM_CNT0_inferred__0/i__carry__4_n_5 ;
  wire \TIM_CNT0_inferred__0/i__carry__4_n_6 ;
  wire \TIM_CNT0_inferred__0/i__carry__4_n_7 ;
  wire \TIM_CNT0_inferred__0/i__carry__5_n_0 ;
  wire \TIM_CNT0_inferred__0/i__carry__5_n_1 ;
  wire \TIM_CNT0_inferred__0/i__carry__5_n_2 ;
  wire \TIM_CNT0_inferred__0/i__carry__5_n_3 ;
  wire \TIM_CNT0_inferred__0/i__carry__5_n_4 ;
  wire \TIM_CNT0_inferred__0/i__carry__5_n_5 ;
  wire \TIM_CNT0_inferred__0/i__carry__5_n_6 ;
  wire \TIM_CNT0_inferred__0/i__carry__5_n_7 ;
  wire \TIM_CNT0_inferred__0/i__carry__6_n_2 ;
  wire \TIM_CNT0_inferred__0/i__carry__6_n_3 ;
  wire \TIM_CNT0_inferred__0/i__carry__6_n_5 ;
  wire \TIM_CNT0_inferred__0/i__carry__6_n_6 ;
  wire \TIM_CNT0_inferred__0/i__carry__6_n_7 ;
  wire \TIM_CNT0_inferred__0/i__carry_n_0 ;
  wire \TIM_CNT0_inferred__0/i__carry_n_1 ;
  wire \TIM_CNT0_inferred__0/i__carry_n_2 ;
  wire \TIM_CNT0_inferred__0/i__carry_n_3 ;
  wire \TIM_CNT0_inferred__0/i__carry_n_4 ;
  wire \TIM_CNT0_inferred__0/i__carry_n_5 ;
  wire \TIM_CNT0_inferred__0/i__carry_n_6 ;
  wire \TIM_CNT0_inferred__0/i__carry_n_7 ;
  wire TIM_CNT1_carry__0_i_1_n_0;
  wire TIM_CNT1_carry__0_i_2_n_0;
  wire TIM_CNT1_carry__0_i_3_n_0;
  wire TIM_CNT1_carry__0_i_4_n_0;
  wire TIM_CNT1_carry__0_i_5_n_0;
  wire TIM_CNT1_carry__0_i_6_n_0;
  wire TIM_CNT1_carry__0_i_7_n_0;
  wire TIM_CNT1_carry__0_i_8_n_0;
  wire TIM_CNT1_carry__0_n_0;
  wire TIM_CNT1_carry__0_n_1;
  wire TIM_CNT1_carry__0_n_2;
  wire TIM_CNT1_carry__0_n_3;
  wire TIM_CNT1_carry__1_i_1_n_0;
  wire TIM_CNT1_carry__1_i_2_n_0;
  wire TIM_CNT1_carry__1_i_3_n_0;
  wire TIM_CNT1_carry__1_i_4_n_0;
  wire TIM_CNT1_carry__1_i_5_n_0;
  wire TIM_CNT1_carry__1_i_6_n_0;
  wire TIM_CNT1_carry__1_i_7_n_0;
  wire TIM_CNT1_carry__1_i_8_n_0;
  wire TIM_CNT1_carry__1_n_0;
  wire TIM_CNT1_carry__1_n_1;
  wire TIM_CNT1_carry__1_n_2;
  wire TIM_CNT1_carry__1_n_3;
  wire TIM_CNT1_carry__2_i_1_n_0;
  wire TIM_CNT1_carry__2_i_2_n_0;
  wire TIM_CNT1_carry__2_i_3_n_0;
  wire TIM_CNT1_carry__2_i_4_n_0;
  wire TIM_CNT1_carry__2_i_5_n_0;
  wire TIM_CNT1_carry__2_i_6_n_0;
  wire TIM_CNT1_carry__2_i_7_n_0;
  wire TIM_CNT1_carry__2_i_8_n_0;
  wire TIM_CNT1_carry__2_n_0;
  wire TIM_CNT1_carry__2_n_1;
  wire TIM_CNT1_carry__2_n_2;
  wire TIM_CNT1_carry__2_n_3;
  wire TIM_CNT1_carry_i_1_n_0;
  wire TIM_CNT1_carry_i_2_n_0;
  wire TIM_CNT1_carry_i_3_n_0;
  wire TIM_CNT1_carry_i_4_n_0;
  wire TIM_CNT1_carry_i_5_n_0;
  wire TIM_CNT1_carry_i_6_n_0;
  wire TIM_CNT1_carry_i_7_n_0;
  wire TIM_CNT1_carry_i_8_n_0;
  wire TIM_CNT1_carry_n_0;
  wire TIM_CNT1_carry_n_1;
  wire TIM_CNT1_carry_n_2;
  wire TIM_CNT1_carry_n_3;
  wire \TIM_CNT[0]_i_1_n_0 ;
  wire \TIM_CNT[10]_i_1_n_0 ;
  wire \TIM_CNT[11]_i_1_n_0 ;
  wire \TIM_CNT[12]_i_1_n_0 ;
  wire \TIM_CNT[13]_i_1_n_0 ;
  wire \TIM_CNT[14]_i_1_n_0 ;
  wire \TIM_CNT[15]_i_1_n_0 ;
  wire \TIM_CNT[16]_i_1_n_0 ;
  wire \TIM_CNT[17]_i_1_n_0 ;
  wire \TIM_CNT[18]_i_1_n_0 ;
  wire \TIM_CNT[19]_i_1_n_0 ;
  wire \TIM_CNT[1]_i_1_n_0 ;
  wire \TIM_CNT[20]_i_1_n_0 ;
  wire \TIM_CNT[21]_i_1_n_0 ;
  wire \TIM_CNT[22]_i_1_n_0 ;
  wire \TIM_CNT[23]_i_1_n_0 ;
  wire \TIM_CNT[24]_i_1_n_0 ;
  wire \TIM_CNT[25]_i_1_n_0 ;
  wire \TIM_CNT[26]_i_1_n_0 ;
  wire \TIM_CNT[27]_i_1_n_0 ;
  wire \TIM_CNT[28]_i_1_n_0 ;
  wire \TIM_CNT[29]_i_1_n_0 ;
  wire \TIM_CNT[2]_i_1_n_0 ;
  wire \TIM_CNT[30]_i_1_n_0 ;
  wire \TIM_CNT[31]_i_10_n_0 ;
  wire \TIM_CNT[31]_i_11_n_0 ;
  wire \TIM_CNT[31]_i_12_n_0 ;
  wire \TIM_CNT[31]_i_13_n_0 ;
  wire \TIM_CNT[31]_i_14_n_0 ;
  wire \TIM_CNT[31]_i_15_n_0 ;
  wire \TIM_CNT[31]_i_16_n_0 ;
  wire \TIM_CNT[31]_i_17_n_0 ;
  wire \TIM_CNT[31]_i_18_n_0 ;
  wire \TIM_CNT[31]_i_19_n_0 ;
  wire \TIM_CNT[31]_i_1_n_0 ;
  wire \TIM_CNT[31]_i_20_n_0 ;
  wire \TIM_CNT[31]_i_21_n_0 ;
  wire \TIM_CNT[31]_i_22_n_0 ;
  wire \TIM_CNT[31]_i_23_n_0 ;
  wire \TIM_CNT[31]_i_24_n_0 ;
  wire \TIM_CNT[31]_i_25_n_0 ;
  wire \TIM_CNT[31]_i_26_n_0 ;
  wire \TIM_CNT[31]_i_27_n_0 ;
  wire \TIM_CNT[31]_i_2_n_0 ;
  wire \TIM_CNT[31]_i_3_n_0 ;
  wire \TIM_CNT[31]_i_4_n_0 ;
  wire \TIM_CNT[31]_i_5_n_0 ;
  wire \TIM_CNT[31]_i_6_n_0 ;
  wire \TIM_CNT[31]_i_7_n_0 ;
  wire \TIM_CNT[31]_i_9_n_0 ;
  wire \TIM_CNT[3]_i_1_n_0 ;
  wire \TIM_CNT[4]_i_1_n_0 ;
  wire \TIM_CNT[5]_i_1_n_0 ;
  wire \TIM_CNT[6]_i_1_n_0 ;
  wire \TIM_CNT[7]_i_1_n_0 ;
  wire \TIM_CNT[8]_i_1_n_0 ;
  wire \TIM_CNT[9]_i_1_n_0 ;
  wire \TIM_CNT_reg[12]_i_2_n_0 ;
  wire \TIM_CNT_reg[12]_i_2_n_1 ;
  wire \TIM_CNT_reg[12]_i_2_n_2 ;
  wire \TIM_CNT_reg[12]_i_2_n_3 ;
  wire \TIM_CNT_reg[16]_i_2_n_0 ;
  wire \TIM_CNT_reg[16]_i_2_n_1 ;
  wire \TIM_CNT_reg[16]_i_2_n_2 ;
  wire \TIM_CNT_reg[16]_i_2_n_3 ;
  wire \TIM_CNT_reg[20]_i_2_n_0 ;
  wire \TIM_CNT_reg[20]_i_2_n_1 ;
  wire \TIM_CNT_reg[20]_i_2_n_2 ;
  wire \TIM_CNT_reg[20]_i_2_n_3 ;
  wire \TIM_CNT_reg[24]_i_2_n_0 ;
  wire \TIM_CNT_reg[24]_i_2_n_1 ;
  wire \TIM_CNT_reg[24]_i_2_n_2 ;
  wire \TIM_CNT_reg[24]_i_2_n_3 ;
  wire \TIM_CNT_reg[28]_i_2_n_0 ;
  wire \TIM_CNT_reg[28]_i_2_n_1 ;
  wire \TIM_CNT_reg[28]_i_2_n_2 ;
  wire \TIM_CNT_reg[28]_i_2_n_3 ;
  wire \TIM_CNT_reg[31]_i_8_n_2 ;
  wire \TIM_CNT_reg[31]_i_8_n_3 ;
  wire \TIM_CNT_reg[4]_i_2_n_0 ;
  wire \TIM_CNT_reg[4]_i_2_n_1 ;
  wire \TIM_CNT_reg[4]_i_2_n_2 ;
  wire \TIM_CNT_reg[4]_i_2_n_3 ;
  wire \TIM_CNT_reg[8]_i_2_n_0 ;
  wire \TIM_CNT_reg[8]_i_2_n_1 ;
  wire \TIM_CNT_reg[8]_i_2_n_2 ;
  wire \TIM_CNT_reg[8]_i_2_n_3 ;
  wire [0:0]TIM_ENA;
  wire \TIM_ENA_reg_n_0_[10] ;
  wire \TIM_ENA_reg_n_0_[11] ;
  wire \TIM_ENA_reg_n_0_[12] ;
  wire \TIM_ENA_reg_n_0_[13] ;
  wire \TIM_ENA_reg_n_0_[14] ;
  wire \TIM_ENA_reg_n_0_[15] ;
  wire \TIM_ENA_reg_n_0_[16] ;
  wire \TIM_ENA_reg_n_0_[17] ;
  wire \TIM_ENA_reg_n_0_[18] ;
  wire \TIM_ENA_reg_n_0_[19] ;
  wire \TIM_ENA_reg_n_0_[1] ;
  wire \TIM_ENA_reg_n_0_[20] ;
  wire \TIM_ENA_reg_n_0_[21] ;
  wire \TIM_ENA_reg_n_0_[22] ;
  wire \TIM_ENA_reg_n_0_[23] ;
  wire \TIM_ENA_reg_n_0_[24] ;
  wire \TIM_ENA_reg_n_0_[25] ;
  wire \TIM_ENA_reg_n_0_[26] ;
  wire \TIM_ENA_reg_n_0_[27] ;
  wire \TIM_ENA_reg_n_0_[28] ;
  wire \TIM_ENA_reg_n_0_[29] ;
  wire \TIM_ENA_reg_n_0_[2] ;
  wire \TIM_ENA_reg_n_0_[30] ;
  wire \TIM_ENA_reg_n_0_[31] ;
  wire \TIM_ENA_reg_n_0_[3] ;
  wire \TIM_ENA_reg_n_0_[4] ;
  wire \TIM_ENA_reg_n_0_[5] ;
  wire \TIM_ENA_reg_n_0_[6] ;
  wire \TIM_ENA_reg_n_0_[7] ;
  wire \TIM_ENA_reg_n_0_[8] ;
  wire \TIM_ENA_reg_n_0_[9] ;
  wire \TIM_EVC[0]_i_1_n_0 ;
  wire \TIM_EVC[10]_i_1_n_0 ;
  wire \TIM_EVC[11]_i_1_n_0 ;
  wire \TIM_EVC[12]_i_1_n_0 ;
  wire \TIM_EVC[13]_i_1_n_0 ;
  wire \TIM_EVC[14]_i_1_n_0 ;
  wire \TIM_EVC[15]_i_1_n_0 ;
  wire \TIM_EVC[16]_i_1_n_0 ;
  wire \TIM_EVC[17]_i_1_n_0 ;
  wire \TIM_EVC[18]_i_1_n_0 ;
  wire \TIM_EVC[19]_i_1_n_0 ;
  wire \TIM_EVC[1]_i_1_n_0 ;
  wire \TIM_EVC[20]_i_1_n_0 ;
  wire \TIM_EVC[21]_i_1_n_0 ;
  wire \TIM_EVC[22]_i_1_n_0 ;
  wire \TIM_EVC[23]_i_1_n_0 ;
  wire \TIM_EVC[24]_i_1_n_0 ;
  wire \TIM_EVC[25]_i_1_n_0 ;
  wire \TIM_EVC[26]_i_1_n_0 ;
  wire \TIM_EVC[27]_i_1_n_0 ;
  wire \TIM_EVC[28]_i_1_n_0 ;
  wire \TIM_EVC[29]_i_1_n_0 ;
  wire \TIM_EVC[2]_i_1_n_0 ;
  wire \TIM_EVC[30]_i_1_n_0 ;
  wire \TIM_EVC[31]_i_1_n_0 ;
  wire \TIM_EVC[31]_i_2_n_0 ;
  wire \TIM_EVC[31]_i_3_n_0 ;
  wire \TIM_EVC[3]_i_1_n_0 ;
  wire \TIM_EVC[4]_i_1_n_0 ;
  wire \TIM_EVC[5]_i_1_n_0 ;
  wire \TIM_EVC[6]_i_1_n_0 ;
  wire \TIM_EVC[7]_i_1_n_0 ;
  wire \TIM_EVC[8]_i_1_n_0 ;
  wire \TIM_EVC[9]_i_1_n_0 ;
  wire \TIM_EVC_reg_n_0_[10] ;
  wire \TIM_EVC_reg_n_0_[11] ;
  wire \TIM_EVC_reg_n_0_[12] ;
  wire \TIM_EVC_reg_n_0_[13] ;
  wire \TIM_EVC_reg_n_0_[14] ;
  wire \TIM_EVC_reg_n_0_[15] ;
  wire \TIM_EVC_reg_n_0_[16] ;
  wire \TIM_EVC_reg_n_0_[17] ;
  wire \TIM_EVC_reg_n_0_[18] ;
  wire \TIM_EVC_reg_n_0_[19] ;
  wire \TIM_EVC_reg_n_0_[1] ;
  wire \TIM_EVC_reg_n_0_[20] ;
  wire \TIM_EVC_reg_n_0_[21] ;
  wire \TIM_EVC_reg_n_0_[22] ;
  wire \TIM_EVC_reg_n_0_[23] ;
  wire \TIM_EVC_reg_n_0_[24] ;
  wire \TIM_EVC_reg_n_0_[25] ;
  wire \TIM_EVC_reg_n_0_[26] ;
  wire \TIM_EVC_reg_n_0_[27] ;
  wire \TIM_EVC_reg_n_0_[28] ;
  wire \TIM_EVC_reg_n_0_[29] ;
  wire \TIM_EVC_reg_n_0_[2] ;
  wire \TIM_EVC_reg_n_0_[30] ;
  wire \TIM_EVC_reg_n_0_[31] ;
  wire \TIM_EVC_reg_n_0_[3] ;
  wire \TIM_EVC_reg_n_0_[4] ;
  wire \TIM_EVC_reg_n_0_[5] ;
  wire \TIM_EVC_reg_n_0_[6] ;
  wire \TIM_EVC_reg_n_0_[7] ;
  wire \TIM_EVC_reg_n_0_[8] ;
  wire \TIM_EVC_reg_n_0_[9] ;
  wire [31:0]TIM_EVN;
  wire TIM_EVN0_carry__0_n_0;
  wire TIM_EVN0_carry__0_n_1;
  wire TIM_EVN0_carry__0_n_2;
  wire TIM_EVN0_carry__0_n_3;
  wire TIM_EVN0_carry__0_n_4;
  wire TIM_EVN0_carry__0_n_5;
  wire TIM_EVN0_carry__0_n_6;
  wire TIM_EVN0_carry__0_n_7;
  wire TIM_EVN0_carry__1_n_0;
  wire TIM_EVN0_carry__1_n_1;
  wire TIM_EVN0_carry__1_n_2;
  wire TIM_EVN0_carry__1_n_3;
  wire TIM_EVN0_carry__1_n_4;
  wire TIM_EVN0_carry__1_n_5;
  wire TIM_EVN0_carry__1_n_6;
  wire TIM_EVN0_carry__1_n_7;
  wire TIM_EVN0_carry__2_n_0;
  wire TIM_EVN0_carry__2_n_1;
  wire TIM_EVN0_carry__2_n_2;
  wire TIM_EVN0_carry__2_n_3;
  wire TIM_EVN0_carry__2_n_4;
  wire TIM_EVN0_carry__2_n_5;
  wire TIM_EVN0_carry__2_n_6;
  wire TIM_EVN0_carry__2_n_7;
  wire TIM_EVN0_carry__3_n_0;
  wire TIM_EVN0_carry__3_n_1;
  wire TIM_EVN0_carry__3_n_2;
  wire TIM_EVN0_carry__3_n_3;
  wire TIM_EVN0_carry__3_n_4;
  wire TIM_EVN0_carry__3_n_5;
  wire TIM_EVN0_carry__3_n_6;
  wire TIM_EVN0_carry__3_n_7;
  wire TIM_EVN0_carry__4_n_0;
  wire TIM_EVN0_carry__4_n_1;
  wire TIM_EVN0_carry__4_n_2;
  wire TIM_EVN0_carry__4_n_3;
  wire TIM_EVN0_carry__4_n_4;
  wire TIM_EVN0_carry__4_n_5;
  wire TIM_EVN0_carry__4_n_6;
  wire TIM_EVN0_carry__4_n_7;
  wire TIM_EVN0_carry__5_n_0;
  wire TIM_EVN0_carry__5_n_1;
  wire TIM_EVN0_carry__5_n_2;
  wire TIM_EVN0_carry__5_n_3;
  wire TIM_EVN0_carry__5_n_4;
  wire TIM_EVN0_carry__5_n_5;
  wire TIM_EVN0_carry__5_n_6;
  wire TIM_EVN0_carry__5_n_7;
  wire TIM_EVN0_carry__6_n_2;
  wire TIM_EVN0_carry__6_n_3;
  wire TIM_EVN0_carry__6_n_5;
  wire TIM_EVN0_carry__6_n_6;
  wire TIM_EVN0_carry__6_n_7;
  wire TIM_EVN0_carry_n_0;
  wire TIM_EVN0_carry_n_1;
  wire TIM_EVN0_carry_n_2;
  wire TIM_EVN0_carry_n_3;
  wire TIM_EVN0_carry_n_4;
  wire TIM_EVN0_carry_n_5;
  wire TIM_EVN0_carry_n_6;
  wire TIM_EVN0_carry_n_7;
  wire \TIM_EVN[0]_i_1_n_0 ;
  wire \TIM_EVN[10]_i_1_n_0 ;
  wire \TIM_EVN[11]_i_1_n_0 ;
  wire \TIM_EVN[12]_i_1_n_0 ;
  wire \TIM_EVN[13]_i_1_n_0 ;
  wire \TIM_EVN[14]_i_1_n_0 ;
  wire \TIM_EVN[15]_i_1_n_0 ;
  wire \TIM_EVN[16]_i_1_n_0 ;
  wire \TIM_EVN[17]_i_1_n_0 ;
  wire \TIM_EVN[18]_i_1_n_0 ;
  wire \TIM_EVN[19]_i_1_n_0 ;
  wire \TIM_EVN[1]_i_1_n_0 ;
  wire \TIM_EVN[20]_i_1_n_0 ;
  wire \TIM_EVN[21]_i_1_n_0 ;
  wire \TIM_EVN[22]_i_1_n_0 ;
  wire \TIM_EVN[23]_i_1_n_0 ;
  wire \TIM_EVN[24]_i_1_n_0 ;
  wire \TIM_EVN[25]_i_1_n_0 ;
  wire \TIM_EVN[26]_i_1_n_0 ;
  wire \TIM_EVN[27]_i_1_n_0 ;
  wire \TIM_EVN[28]_i_1_n_0 ;
  wire \TIM_EVN[29]_i_1_n_0 ;
  wire \TIM_EVN[2]_i_1_n_0 ;
  wire \TIM_EVN[30]_i_1_n_0 ;
  wire \TIM_EVN[31]_i_10_n_0 ;
  wire \TIM_EVN[31]_i_11_n_0 ;
  wire \TIM_EVN[31]_i_12_n_0 ;
  wire \TIM_EVN[31]_i_13_n_0 ;
  wire \TIM_EVN[31]_i_14_n_0 ;
  wire \TIM_EVN[31]_i_15_n_0 ;
  wire \TIM_EVN[31]_i_16_n_0 ;
  wire \TIM_EVN[31]_i_17_n_0 ;
  wire \TIM_EVN[31]_i_18_n_0 ;
  wire \TIM_EVN[31]_i_19_n_0 ;
  wire \TIM_EVN[31]_i_1_n_0 ;
  wire \TIM_EVN[31]_i_20_n_0 ;
  wire \TIM_EVN[31]_i_21_n_0 ;
  wire \TIM_EVN[31]_i_22_n_0 ;
  wire \TIM_EVN[31]_i_23_n_0 ;
  wire \TIM_EVN[31]_i_2_n_0 ;
  wire \TIM_EVN[31]_i_3_n_0 ;
  wire \TIM_EVN[31]_i_4_n_0 ;
  wire \TIM_EVN[31]_i_5_n_0 ;
  wire \TIM_EVN[31]_i_6_n_0 ;
  wire \TIM_EVN[31]_i_7_n_0 ;
  wire \TIM_EVN[31]_i_8_n_0 ;
  wire \TIM_EVN[31]_i_9_n_0 ;
  wire \TIM_EVN[3]_i_1_n_0 ;
  wire \TIM_EVN[4]_i_1_n_0 ;
  wire \TIM_EVN[5]_i_1_n_0 ;
  wire \TIM_EVN[6]_i_1_n_0 ;
  wire \TIM_EVN[7]_i_1_n_0 ;
  wire \TIM_EVN[8]_i_1_n_0 ;
  wire \TIM_EVN[9]_i_1_n_0 ;
  wire [0:0]TIM_MOD;
  wire \TIM_MOD_reg_n_0_[0] ;
  wire \TIM_MOD_reg_n_0_[10] ;
  wire \TIM_MOD_reg_n_0_[11] ;
  wire \TIM_MOD_reg_n_0_[12] ;
  wire \TIM_MOD_reg_n_0_[13] ;
  wire \TIM_MOD_reg_n_0_[14] ;
  wire \TIM_MOD_reg_n_0_[15] ;
  wire \TIM_MOD_reg_n_0_[16] ;
  wire \TIM_MOD_reg_n_0_[17] ;
  wire \TIM_MOD_reg_n_0_[18] ;
  wire \TIM_MOD_reg_n_0_[19] ;
  wire \TIM_MOD_reg_n_0_[1] ;
  wire \TIM_MOD_reg_n_0_[20] ;
  wire \TIM_MOD_reg_n_0_[21] ;
  wire \TIM_MOD_reg_n_0_[22] ;
  wire \TIM_MOD_reg_n_0_[23] ;
  wire \TIM_MOD_reg_n_0_[24] ;
  wire \TIM_MOD_reg_n_0_[25] ;
  wire \TIM_MOD_reg_n_0_[26] ;
  wire \TIM_MOD_reg_n_0_[27] ;
  wire \TIM_MOD_reg_n_0_[28] ;
  wire \TIM_MOD_reg_n_0_[29] ;
  wire \TIM_MOD_reg_n_0_[2] ;
  wire \TIM_MOD_reg_n_0_[30] ;
  wire \TIM_MOD_reg_n_0_[31] ;
  wire \TIM_MOD_reg_n_0_[3] ;
  wire \TIM_MOD_reg_n_0_[4] ;
  wire \TIM_MOD_reg_n_0_[5] ;
  wire \TIM_MOD_reg_n_0_[6] ;
  wire \TIM_MOD_reg_n_0_[7] ;
  wire \TIM_MOD_reg_n_0_[8] ;
  wire \TIM_MOD_reg_n_0_[9] ;
  wire [31:0]TIM_PRE;
  wire TIM_PRE0_carry__0_i_1_n_0;
  wire TIM_PRE0_carry__0_i_2_n_0;
  wire TIM_PRE0_carry__0_i_3_n_0;
  wire TIM_PRE0_carry__0_i_4_n_0;
  wire TIM_PRE0_carry__0_n_0;
  wire TIM_PRE0_carry__0_n_1;
  wire TIM_PRE0_carry__0_n_2;
  wire TIM_PRE0_carry__0_n_3;
  wire TIM_PRE0_carry__1_i_1_n_0;
  wire TIM_PRE0_carry__1_i_2_n_0;
  wire TIM_PRE0_carry__1_i_3_n_0;
  wire TIM_PRE0_carry__1_i_4_n_0;
  wire TIM_PRE0_carry__1_n_0;
  wire TIM_PRE0_carry__1_n_1;
  wire TIM_PRE0_carry__1_n_2;
  wire TIM_PRE0_carry__1_n_3;
  wire TIM_PRE0_carry__2_i_1_n_0;
  wire TIM_PRE0_carry__2_i_2_n_0;
  wire TIM_PRE0_carry__2_i_3_n_0;
  wire TIM_PRE0_carry__2_i_4_n_0;
  wire TIM_PRE0_carry__2_n_0;
  wire TIM_PRE0_carry__2_n_1;
  wire TIM_PRE0_carry__2_n_2;
  wire TIM_PRE0_carry__2_n_3;
  wire TIM_PRE0_carry__3_i_1_n_0;
  wire TIM_PRE0_carry__3_i_2_n_0;
  wire TIM_PRE0_carry__3_i_3_n_0;
  wire TIM_PRE0_carry__3_i_4_n_0;
  wire TIM_PRE0_carry__3_n_0;
  wire TIM_PRE0_carry__3_n_1;
  wire TIM_PRE0_carry__3_n_2;
  wire TIM_PRE0_carry__3_n_3;
  wire TIM_PRE0_carry__4_i_1_n_0;
  wire TIM_PRE0_carry__4_i_2_n_0;
  wire TIM_PRE0_carry__4_i_3_n_0;
  wire TIM_PRE0_carry__4_i_4_n_0;
  wire TIM_PRE0_carry__4_n_0;
  wire TIM_PRE0_carry__4_n_1;
  wire TIM_PRE0_carry__4_n_2;
  wire TIM_PRE0_carry__4_n_3;
  wire TIM_PRE0_carry__5_i_1_n_0;
  wire TIM_PRE0_carry__5_i_2_n_0;
  wire TIM_PRE0_carry__5_i_3_n_0;
  wire TIM_PRE0_carry__5_i_4_n_0;
  wire TIM_PRE0_carry__5_n_0;
  wire TIM_PRE0_carry__5_n_1;
  wire TIM_PRE0_carry__5_n_2;
  wire TIM_PRE0_carry__5_n_3;
  wire TIM_PRE0_carry__6_i_1_n_0;
  wire TIM_PRE0_carry__6_i_2_n_0;
  wire TIM_PRE0_carry__6_i_3_n_0;
  wire TIM_PRE0_carry__6_n_2;
  wire TIM_PRE0_carry__6_n_3;
  wire TIM_PRE0_carry_i_1_n_0;
  wire TIM_PRE0_carry_i_2_n_0;
  wire TIM_PRE0_carry_i_3_n_0;
  wire TIM_PRE0_carry_i_4_n_0;
  wire TIM_PRE0_carry_n_0;
  wire TIM_PRE0_carry_n_1;
  wire TIM_PRE0_carry_n_2;
  wire TIM_PRE0_carry_n_3;
  wire \TIM_PRE[0]_i_1_n_0 ;
  wire \TIM_PRE[10]_i_1_n_0 ;
  wire \TIM_PRE[11]_i_1_n_0 ;
  wire \TIM_PRE[12]_i_1_n_0 ;
  wire \TIM_PRE[13]_i_1_n_0 ;
  wire \TIM_PRE[14]_i_1_n_0 ;
  wire \TIM_PRE[15]_i_1_n_0 ;
  wire \TIM_PRE[16]_i_1_n_0 ;
  wire \TIM_PRE[17]_i_1_n_0 ;
  wire \TIM_PRE[18]_i_1_n_0 ;
  wire \TIM_PRE[19]_i_1_n_0 ;
  wire \TIM_PRE[1]_i_1_n_0 ;
  wire \TIM_PRE[20]_i_1_n_0 ;
  wire \TIM_PRE[21]_i_1_n_0 ;
  wire \TIM_PRE[22]_i_1_n_0 ;
  wire \TIM_PRE[23]_i_1_n_0 ;
  wire \TIM_PRE[24]_i_1_n_0 ;
  wire \TIM_PRE[25]_i_1_n_0 ;
  wire \TIM_PRE[26]_i_1_n_0 ;
  wire \TIM_PRE[27]_i_1_n_0 ;
  wire \TIM_PRE[28]_i_1_n_0 ;
  wire \TIM_PRE[29]_i_1_n_0 ;
  wire \TIM_PRE[2]_i_1_n_0 ;
  wire \TIM_PRE[30]_i_1_n_0 ;
  wire \TIM_PRE[31]_i_10_n_0 ;
  wire \TIM_PRE[31]_i_1_n_0 ;
  wire \TIM_PRE[31]_i_2_n_0 ;
  wire \TIM_PRE[31]_i_3_n_0 ;
  wire \TIM_PRE[31]_i_4_n_0 ;
  wire \TIM_PRE[31]_i_5_n_0 ;
  wire \TIM_PRE[31]_i_6_n_0 ;
  wire \TIM_PRE[31]_i_7_n_0 ;
  wire \TIM_PRE[31]_i_8_n_0 ;
  wire \TIM_PRE[31]_i_9_n_0 ;
  wire \TIM_PRE[3]_i_1_n_0 ;
  wire \TIM_PRE[4]_i_1_n_0 ;
  wire \TIM_PRE[5]_i_1_n_0 ;
  wire \TIM_PRE[6]_i_1_n_0 ;
  wire \TIM_PRE[7]_i_1_n_0 ;
  wire \TIM_PRE[8]_i_1_n_0 ;
  wire \TIM_PRE[9]_i_1_n_0 ;
  wire [31:0]TIM_PRE_m;
  wire TIM_PRE_m1;
  wire [0:0]TIM_PRE_m_0;
  wire [7:0]araddr;
  wire arready;
  wire arready_i_1_n_0;
  wire arvalid;
  wire [7:0]awaddr;
  wire awvalid;
  wire bready;
  wire bvalid;
  wire bvalid_i_1_n_0;
  wire clk_i;
  wire [31:1]data1;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__1_i_1_n_0;
  wire i__carry__1_i_2_n_0;
  wire i__carry__1_i_3_n_0;
  wire i__carry__1_i_4_n_0;
  wire i__carry__2_i_1_n_0;
  wire i__carry__2_i_2_n_0;
  wire i__carry__2_i_3_n_0;
  wire i__carry__2_i_4_n_0;
  wire i__carry__3_i_1_n_0;
  wire i__carry__3_i_2_n_0;
  wire i__carry__3_i_3_n_0;
  wire i__carry__3_i_4_n_0;
  wire i__carry__4_i_1_n_0;
  wire i__carry__4_i_2_n_0;
  wire i__carry__4_i_3_n_0;
  wire i__carry__4_i_4_n_0;
  wire i__carry__5_i_1_n_0;
  wire i__carry__5_i_2_n_0;
  wire i__carry__5_i_3_n_0;
  wire i__carry__5_i_4_n_0;
  wire i__carry__6_i_1_n_0;
  wire i__carry__6_i_2_n_0;
  wire i__carry__6_i_3_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4_n_0;
  wire [31:0]p_0_in;
  wire [31:0]p_1_in;
  wire p_2_in;
  wire p_3_in;
  wire [31:0]rdata;
  wire \rdata[0]_i_2_n_0 ;
  wire \rdata[0]_i_3_n_0 ;
  wire \rdata[10]_i_2_n_0 ;
  wire \rdata[10]_i_3_n_0 ;
  wire \rdata[11]_i_2_n_0 ;
  wire \rdata[11]_i_3_n_0 ;
  wire \rdata[12]_i_2_n_0 ;
  wire \rdata[12]_i_3_n_0 ;
  wire \rdata[13]_i_2_n_0 ;
  wire \rdata[13]_i_3_n_0 ;
  wire \rdata[14]_i_2_n_0 ;
  wire \rdata[14]_i_3_n_0 ;
  wire \rdata[15]_i_2_n_0 ;
  wire \rdata[15]_i_3_n_0 ;
  wire \rdata[16]_i_2_n_0 ;
  wire \rdata[16]_i_3_n_0 ;
  wire \rdata[17]_i_2_n_0 ;
  wire \rdata[17]_i_3_n_0 ;
  wire \rdata[18]_i_2_n_0 ;
  wire \rdata[18]_i_3_n_0 ;
  wire \rdata[19]_i_2_n_0 ;
  wire \rdata[19]_i_3_n_0 ;
  wire \rdata[1]_i_2_n_0 ;
  wire \rdata[1]_i_3_n_0 ;
  wire \rdata[20]_i_2_n_0 ;
  wire \rdata[20]_i_3_n_0 ;
  wire \rdata[21]_i_2_n_0 ;
  wire \rdata[21]_i_3_n_0 ;
  wire \rdata[22]_i_2_n_0 ;
  wire \rdata[22]_i_3_n_0 ;
  wire \rdata[23]_i_2_n_0 ;
  wire \rdata[23]_i_3_n_0 ;
  wire \rdata[24]_i_2_n_0 ;
  wire \rdata[24]_i_3_n_0 ;
  wire \rdata[25]_i_2_n_0 ;
  wire \rdata[25]_i_3_n_0 ;
  wire \rdata[26]_i_2_n_0 ;
  wire \rdata[26]_i_3_n_0 ;
  wire \rdata[27]_i_2_n_0 ;
  wire \rdata[27]_i_3_n_0 ;
  wire \rdata[28]_i_2_n_0 ;
  wire \rdata[28]_i_3_n_0 ;
  wire \rdata[29]_i_2_n_0 ;
  wire \rdata[29]_i_3_n_0 ;
  wire \rdata[2]_i_2_n_0 ;
  wire \rdata[2]_i_3_n_0 ;
  wire \rdata[30]_i_2_n_0 ;
  wire \rdata[30]_i_3_n_0 ;
  wire \rdata[31]_i_2_n_0 ;
  wire \rdata[31]_i_3_n_0 ;
  wire \rdata[31]_i_4_n_0 ;
  wire \rdata[31]_i_5_n_0 ;
  wire \rdata[3]_i_2_n_0 ;
  wire \rdata[3]_i_3_n_0 ;
  wire \rdata[4]_i_2_n_0 ;
  wire \rdata[4]_i_3_n_0 ;
  wire \rdata[5]_i_2_n_0 ;
  wire \rdata[5]_i_3_n_0 ;
  wire \rdata[6]_i_2_n_0 ;
  wire \rdata[6]_i_3_n_0 ;
  wire \rdata[7]_i_2_n_0 ;
  wire \rdata[7]_i_3_n_0 ;
  wire \rdata[8]_i_2_n_0 ;
  wire \rdata[8]_i_3_n_0 ;
  wire \rdata[9]_i_2_n_0 ;
  wire \rdata[9]_i_3_n_0 ;
  wire rready;
  wire rst_n;
  wire rvalid;
  wire rvalid_i_1_n_0;
  wire [31:0]wdata;
  wire wready;
  wire wready_i_1_n_0;
  wire wready_i_2_n_0;
  wire wvalid;
  wire [3:2]\NLW_TIM_CNT0_inferred__0/i__carry__6_CO_UNCONNECTED ;
  wire [3:3]\NLW_TIM_CNT0_inferred__0/i__carry__6_O_UNCONNECTED ;
  wire [3:0]NLW_TIM_CNT1_carry_O_UNCONNECTED;
  wire [3:0]NLW_TIM_CNT1_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_TIM_CNT1_carry__1_O_UNCONNECTED;
  wire [3:0]NLW_TIM_CNT1_carry__2_O_UNCONNECTED;
  wire [3:2]\NLW_TIM_CNT_reg[31]_i_8_CO_UNCONNECTED ;
  wire [3:3]\NLW_TIM_CNT_reg[31]_i_8_O_UNCONNECTED ;
  wire [3:2]NLW_TIM_EVN0_carry__6_CO_UNCONNECTED;
  wire [3:3]NLW_TIM_EVN0_carry__6_O_UNCONNECTED;
  wire [3:2]NLW_TIM_PRE0_carry__6_CO_UNCONNECTED;
  wire [3:3]NLW_TIM_PRE0_carry__6_O_UNCONNECTED;

  LUT4 #(
    .INIT(16'h0200)) 
    \TIM_ARE[31]_i_1 
       (.I0(\TIM_CLR[31]_i_3_n_0 ),
        .I1(awaddr[4]),
        .I2(awaddr[3]),
        .I3(awaddr[2]),
        .O(TIM_ARE_1));
  FDCE \TIM_ARE_reg[0] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[0]),
        .Q(TIM_ARE[0]));
  FDCE \TIM_ARE_reg[10] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[10]),
        .Q(TIM_ARE[10]));
  FDCE \TIM_ARE_reg[11] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[11]),
        .Q(TIM_ARE[11]));
  FDCE \TIM_ARE_reg[12] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[12]),
        .Q(TIM_ARE[12]));
  FDCE \TIM_ARE_reg[13] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[13]),
        .Q(TIM_ARE[13]));
  FDCE \TIM_ARE_reg[14] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[14]),
        .Q(TIM_ARE[14]));
  FDCE \TIM_ARE_reg[15] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[15]),
        .Q(TIM_ARE[15]));
  FDCE \TIM_ARE_reg[16] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[16]),
        .Q(TIM_ARE[16]));
  FDCE \TIM_ARE_reg[17] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[17]),
        .Q(TIM_ARE[17]));
  FDCE \TIM_ARE_reg[18] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[18]),
        .Q(TIM_ARE[18]));
  FDCE \TIM_ARE_reg[19] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[19]),
        .Q(TIM_ARE[19]));
  FDCE \TIM_ARE_reg[1] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[1]),
        .Q(TIM_ARE[1]));
  FDCE \TIM_ARE_reg[20] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[20]),
        .Q(TIM_ARE[20]));
  FDCE \TIM_ARE_reg[21] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[21]),
        .Q(TIM_ARE[21]));
  FDCE \TIM_ARE_reg[22] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[22]),
        .Q(TIM_ARE[22]));
  FDCE \TIM_ARE_reg[23] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[23]),
        .Q(TIM_ARE[23]));
  FDCE \TIM_ARE_reg[24] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[24]),
        .Q(TIM_ARE[24]));
  FDCE \TIM_ARE_reg[25] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[25]),
        .Q(TIM_ARE[25]));
  FDCE \TIM_ARE_reg[26] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[26]),
        .Q(TIM_ARE[26]));
  FDCE \TIM_ARE_reg[27] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[27]),
        .Q(TIM_ARE[27]));
  FDCE \TIM_ARE_reg[28] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[28]),
        .Q(TIM_ARE[28]));
  FDCE \TIM_ARE_reg[29] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[29]),
        .Q(TIM_ARE[29]));
  FDCE \TIM_ARE_reg[2] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[2]),
        .Q(TIM_ARE[2]));
  FDCE \TIM_ARE_reg[30] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[30]),
        .Q(TIM_ARE[30]));
  FDCE \TIM_ARE_reg[31] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[31]),
        .Q(TIM_ARE[31]));
  FDCE \TIM_ARE_reg[3] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[3]),
        .Q(TIM_ARE[3]));
  FDCE \TIM_ARE_reg[4] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[4]),
        .Q(TIM_ARE[4]));
  FDCE \TIM_ARE_reg[5] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[5]),
        .Q(TIM_ARE[5]));
  FDCE \TIM_ARE_reg[6] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[6]),
        .Q(TIM_ARE[6]));
  FDCE \TIM_ARE_reg[7] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[7]),
        .Q(TIM_ARE[7]));
  FDCE \TIM_ARE_reg[8] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[8]),
        .Q(TIM_ARE[8]));
  FDCE \TIM_ARE_reg[9] 
       (.C(clk_i),
        .CE(TIM_ARE_1),
        .CLR(wready_i_2_n_0),
        .D(wdata[9]),
        .Q(TIM_ARE[9]));
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[0]_i_1 
       (.I0(wdata[0]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[10]_i_1 
       (.I0(wdata[10]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[11]_i_1 
       (.I0(wdata[11]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[11]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[12]_i_1 
       (.I0(wdata[12]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[12]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[13]_i_1 
       (.I0(wdata[13]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[13]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[14]_i_1 
       (.I0(wdata[14]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[14]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[15]_i_1 
       (.I0(wdata[15]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[15]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[16]_i_1 
       (.I0(wdata[16]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[16]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[17]_i_1 
       (.I0(wdata[17]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[17]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[18]_i_1 
       (.I0(wdata[18]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[18]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[19]_i_1 
       (.I0(wdata[19]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[19]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[1]_i_1 
       (.I0(wdata[1]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[20]_i_1 
       (.I0(wdata[20]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[20]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[21]_i_1 
       (.I0(wdata[21]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[21]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[22]_i_1 
       (.I0(wdata[22]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[22]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[23]_i_1 
       (.I0(wdata[23]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[23]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[24]_i_1 
       (.I0(wdata[24]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[24]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[25]_i_1 
       (.I0(wdata[25]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[25]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[26]_i_1 
       (.I0(wdata[26]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[26]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[27]_i_1 
       (.I0(wdata[27]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[27]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[28]_i_1 
       (.I0(wdata[28]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[28]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[29]_i_1 
       (.I0(wdata[29]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[29]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[2]_i_1 
       (.I0(wdata[2]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[30]_i_1 
       (.I0(wdata[30]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[30]));
  LUT5 #(
    .INIT(32'hFFFF0020)) 
    \TIM_CLR[31]_i_1 
       (.I0(\TIM_CLR[31]_i_3_n_0 ),
        .I1(awaddr[4]),
        .I2(awaddr[3]),
        .I3(awaddr[2]),
        .I4(\TIM_CLR_reg_n_0_[0] ),
        .O(\TIM_CLR[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[31]_i_2 
       (.I0(wdata[31]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[31]));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \TIM_CLR[31]_i_3 
       (.I0(awaddr[0]),
        .I1(TIM_PRE_m1),
        .I2(awaddr[1]),
        .I3(awaddr[5]),
        .I4(awaddr[6]),
        .I5(awaddr[7]),
        .O(\TIM_CLR[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \TIM_CLR[31]_i_4 
       (.I0(awvalid),
        .I1(wvalid),
        .O(TIM_PRE_m1));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[3]_i_1 
       (.I0(wdata[3]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[4]_i_1 
       (.I0(wdata[4]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[5]_i_1 
       (.I0(wdata[5]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[6]_i_1 
       (.I0(wdata[6]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[7]_i_1 
       (.I0(wdata[7]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[8]_i_1 
       (.I0(wdata[8]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[8]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \TIM_CLR[9]_i_1 
       (.I0(wdata[9]),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .O(p_1_in[9]));
  FDCE \TIM_CLR_reg[0] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[0]),
        .Q(\TIM_CLR_reg_n_0_[0] ));
  FDCE \TIM_CLR_reg[10] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[10]),
        .Q(\TIM_CLR_reg_n_0_[10] ));
  FDCE \TIM_CLR_reg[11] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[11]),
        .Q(\TIM_CLR_reg_n_0_[11] ));
  FDCE \TIM_CLR_reg[12] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[12]),
        .Q(\TIM_CLR_reg_n_0_[12] ));
  FDCE \TIM_CLR_reg[13] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[13]),
        .Q(\TIM_CLR_reg_n_0_[13] ));
  FDCE \TIM_CLR_reg[14] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[14]),
        .Q(\TIM_CLR_reg_n_0_[14] ));
  FDCE \TIM_CLR_reg[15] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[15]),
        .Q(\TIM_CLR_reg_n_0_[15] ));
  FDCE \TIM_CLR_reg[16] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[16]),
        .Q(\TIM_CLR_reg_n_0_[16] ));
  FDCE \TIM_CLR_reg[17] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[17]),
        .Q(\TIM_CLR_reg_n_0_[17] ));
  FDCE \TIM_CLR_reg[18] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[18]),
        .Q(\TIM_CLR_reg_n_0_[18] ));
  FDCE \TIM_CLR_reg[19] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[19]),
        .Q(\TIM_CLR_reg_n_0_[19] ));
  FDCE \TIM_CLR_reg[1] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[1]),
        .Q(\TIM_CLR_reg_n_0_[1] ));
  FDCE \TIM_CLR_reg[20] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[20]),
        .Q(\TIM_CLR_reg_n_0_[20] ));
  FDCE \TIM_CLR_reg[21] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[21]),
        .Q(\TIM_CLR_reg_n_0_[21] ));
  FDCE \TIM_CLR_reg[22] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[22]),
        .Q(\TIM_CLR_reg_n_0_[22] ));
  FDCE \TIM_CLR_reg[23] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[23]),
        .Q(\TIM_CLR_reg_n_0_[23] ));
  FDCE \TIM_CLR_reg[24] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[24]),
        .Q(\TIM_CLR_reg_n_0_[24] ));
  FDCE \TIM_CLR_reg[25] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[25]),
        .Q(\TIM_CLR_reg_n_0_[25] ));
  FDCE \TIM_CLR_reg[26] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[26]),
        .Q(\TIM_CLR_reg_n_0_[26] ));
  FDCE \TIM_CLR_reg[27] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[27]),
        .Q(\TIM_CLR_reg_n_0_[27] ));
  FDCE \TIM_CLR_reg[28] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[28]),
        .Q(\TIM_CLR_reg_n_0_[28] ));
  FDCE \TIM_CLR_reg[29] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[29]),
        .Q(\TIM_CLR_reg_n_0_[29] ));
  FDCE \TIM_CLR_reg[2] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[2]),
        .Q(\TIM_CLR_reg_n_0_[2] ));
  FDCE \TIM_CLR_reg[30] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[30]),
        .Q(\TIM_CLR_reg_n_0_[30] ));
  FDCE \TIM_CLR_reg[31] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[31]),
        .Q(\TIM_CLR_reg_n_0_[31] ));
  FDCE \TIM_CLR_reg[3] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[3]),
        .Q(\TIM_CLR_reg_n_0_[3] ));
  FDCE \TIM_CLR_reg[4] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[4]),
        .Q(\TIM_CLR_reg_n_0_[4] ));
  FDCE \TIM_CLR_reg[5] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[5]),
        .Q(\TIM_CLR_reg_n_0_[5] ));
  FDCE \TIM_CLR_reg[6] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[6]),
        .Q(\TIM_CLR_reg_n_0_[6] ));
  FDCE \TIM_CLR_reg[7] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[7]),
        .Q(\TIM_CLR_reg_n_0_[7] ));
  FDCE \TIM_CLR_reg[8] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[8]),
        .Q(\TIM_CLR_reg_n_0_[8] ));
  FDCE \TIM_CLR_reg[9] 
       (.C(clk_i),
        .CE(\TIM_CLR[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(p_1_in[9]),
        .Q(\TIM_CLR_reg_n_0_[9] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT0_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\TIM_CNT0_inferred__0/i__carry_n_0 ,\TIM_CNT0_inferred__0/i__carry_n_1 ,\TIM_CNT0_inferred__0/i__carry_n_2 ,\TIM_CNT0_inferred__0/i__carry_n_3 }),
        .CYINIT(TIM_CNT[0]),
        .DI(TIM_CNT[4:1]),
        .O({\TIM_CNT0_inferred__0/i__carry_n_4 ,\TIM_CNT0_inferred__0/i__carry_n_5 ,\TIM_CNT0_inferred__0/i__carry_n_6 ,\TIM_CNT0_inferred__0/i__carry_n_7 }),
        .S({i__carry_i_1_n_0,i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT0_inferred__0/i__carry__0 
       (.CI(\TIM_CNT0_inferred__0/i__carry_n_0 ),
        .CO({\TIM_CNT0_inferred__0/i__carry__0_n_0 ,\TIM_CNT0_inferred__0/i__carry__0_n_1 ,\TIM_CNT0_inferred__0/i__carry__0_n_2 ,\TIM_CNT0_inferred__0/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI(TIM_CNT[8:5]),
        .O({\TIM_CNT0_inferred__0/i__carry__0_n_4 ,\TIM_CNT0_inferred__0/i__carry__0_n_5 ,\TIM_CNT0_inferred__0/i__carry__0_n_6 ,\TIM_CNT0_inferred__0/i__carry__0_n_7 }),
        .S({i__carry__0_i_1_n_0,i__carry__0_i_2_n_0,i__carry__0_i_3_n_0,i__carry__0_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT0_inferred__0/i__carry__1 
       (.CI(\TIM_CNT0_inferred__0/i__carry__0_n_0 ),
        .CO({\TIM_CNT0_inferred__0/i__carry__1_n_0 ,\TIM_CNT0_inferred__0/i__carry__1_n_1 ,\TIM_CNT0_inferred__0/i__carry__1_n_2 ,\TIM_CNT0_inferred__0/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI(TIM_CNT[12:9]),
        .O({\TIM_CNT0_inferred__0/i__carry__1_n_4 ,\TIM_CNT0_inferred__0/i__carry__1_n_5 ,\TIM_CNT0_inferred__0/i__carry__1_n_6 ,\TIM_CNT0_inferred__0/i__carry__1_n_7 }),
        .S({i__carry__1_i_1_n_0,i__carry__1_i_2_n_0,i__carry__1_i_3_n_0,i__carry__1_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT0_inferred__0/i__carry__2 
       (.CI(\TIM_CNT0_inferred__0/i__carry__1_n_0 ),
        .CO({\TIM_CNT0_inferred__0/i__carry__2_n_0 ,\TIM_CNT0_inferred__0/i__carry__2_n_1 ,\TIM_CNT0_inferred__0/i__carry__2_n_2 ,\TIM_CNT0_inferred__0/i__carry__2_n_3 }),
        .CYINIT(1'b0),
        .DI(TIM_CNT[16:13]),
        .O({\TIM_CNT0_inferred__0/i__carry__2_n_4 ,\TIM_CNT0_inferred__0/i__carry__2_n_5 ,\TIM_CNT0_inferred__0/i__carry__2_n_6 ,\TIM_CNT0_inferred__0/i__carry__2_n_7 }),
        .S({i__carry__2_i_1_n_0,i__carry__2_i_2_n_0,i__carry__2_i_3_n_0,i__carry__2_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT0_inferred__0/i__carry__3 
       (.CI(\TIM_CNT0_inferred__0/i__carry__2_n_0 ),
        .CO({\TIM_CNT0_inferred__0/i__carry__3_n_0 ,\TIM_CNT0_inferred__0/i__carry__3_n_1 ,\TIM_CNT0_inferred__0/i__carry__3_n_2 ,\TIM_CNT0_inferred__0/i__carry__3_n_3 }),
        .CYINIT(1'b0),
        .DI(TIM_CNT[20:17]),
        .O({\TIM_CNT0_inferred__0/i__carry__3_n_4 ,\TIM_CNT0_inferred__0/i__carry__3_n_5 ,\TIM_CNT0_inferred__0/i__carry__3_n_6 ,\TIM_CNT0_inferred__0/i__carry__3_n_7 }),
        .S({i__carry__3_i_1_n_0,i__carry__3_i_2_n_0,i__carry__3_i_3_n_0,i__carry__3_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT0_inferred__0/i__carry__4 
       (.CI(\TIM_CNT0_inferred__0/i__carry__3_n_0 ),
        .CO({\TIM_CNT0_inferred__0/i__carry__4_n_0 ,\TIM_CNT0_inferred__0/i__carry__4_n_1 ,\TIM_CNT0_inferred__0/i__carry__4_n_2 ,\TIM_CNT0_inferred__0/i__carry__4_n_3 }),
        .CYINIT(1'b0),
        .DI(TIM_CNT[24:21]),
        .O({\TIM_CNT0_inferred__0/i__carry__4_n_4 ,\TIM_CNT0_inferred__0/i__carry__4_n_5 ,\TIM_CNT0_inferred__0/i__carry__4_n_6 ,\TIM_CNT0_inferred__0/i__carry__4_n_7 }),
        .S({i__carry__4_i_1_n_0,i__carry__4_i_2_n_0,i__carry__4_i_3_n_0,i__carry__4_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT0_inferred__0/i__carry__5 
       (.CI(\TIM_CNT0_inferred__0/i__carry__4_n_0 ),
        .CO({\TIM_CNT0_inferred__0/i__carry__5_n_0 ,\TIM_CNT0_inferred__0/i__carry__5_n_1 ,\TIM_CNT0_inferred__0/i__carry__5_n_2 ,\TIM_CNT0_inferred__0/i__carry__5_n_3 }),
        .CYINIT(1'b0),
        .DI(TIM_CNT[28:25]),
        .O({\TIM_CNT0_inferred__0/i__carry__5_n_4 ,\TIM_CNT0_inferred__0/i__carry__5_n_5 ,\TIM_CNT0_inferred__0/i__carry__5_n_6 ,\TIM_CNT0_inferred__0/i__carry__5_n_7 }),
        .S({i__carry__5_i_1_n_0,i__carry__5_i_2_n_0,i__carry__5_i_3_n_0,i__carry__5_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT0_inferred__0/i__carry__6 
       (.CI(\TIM_CNT0_inferred__0/i__carry__5_n_0 ),
        .CO({\NLW_TIM_CNT0_inferred__0/i__carry__6_CO_UNCONNECTED [3:2],\TIM_CNT0_inferred__0/i__carry__6_n_2 ,\TIM_CNT0_inferred__0/i__carry__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,TIM_CNT[30:29]}),
        .O({\NLW_TIM_CNT0_inferred__0/i__carry__6_O_UNCONNECTED [3],\TIM_CNT0_inferred__0/i__carry__6_n_5 ,\TIM_CNT0_inferred__0/i__carry__6_n_6 ,\TIM_CNT0_inferred__0/i__carry__6_n_7 }),
        .S({1'b0,i__carry__6_i_1_n_0,i__carry__6_i_2_n_0,i__carry__6_i_3_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 TIM_CNT1_carry
       (.CI(1'b0),
        .CO({TIM_CNT1_carry_n_0,TIM_CNT1_carry_n_1,TIM_CNT1_carry_n_2,TIM_CNT1_carry_n_3}),
        .CYINIT(1'b1),
        .DI({TIM_CNT1_carry_i_1_n_0,TIM_CNT1_carry_i_2_n_0,TIM_CNT1_carry_i_3_n_0,TIM_CNT1_carry_i_4_n_0}),
        .O(NLW_TIM_CNT1_carry_O_UNCONNECTED[3:0]),
        .S({TIM_CNT1_carry_i_5_n_0,TIM_CNT1_carry_i_6_n_0,TIM_CNT1_carry_i_7_n_0,TIM_CNT1_carry_i_8_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 TIM_CNT1_carry__0
       (.CI(TIM_CNT1_carry_n_0),
        .CO({TIM_CNT1_carry__0_n_0,TIM_CNT1_carry__0_n_1,TIM_CNT1_carry__0_n_2,TIM_CNT1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({TIM_CNT1_carry__0_i_1_n_0,TIM_CNT1_carry__0_i_2_n_0,TIM_CNT1_carry__0_i_3_n_0,TIM_CNT1_carry__0_i_4_n_0}),
        .O(NLW_TIM_CNT1_carry__0_O_UNCONNECTED[3:0]),
        .S({TIM_CNT1_carry__0_i_5_n_0,TIM_CNT1_carry__0_i_6_n_0,TIM_CNT1_carry__0_i_7_n_0,TIM_CNT1_carry__0_i_8_n_0}));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__0_i_1
       (.I0(TIM_CNT[14]),
        .I1(TIM_ARE[14]),
        .I2(TIM_ARE[15]),
        .I3(TIM_CNT[15]),
        .O(TIM_CNT1_carry__0_i_1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__0_i_2
       (.I0(TIM_CNT[12]),
        .I1(TIM_ARE[12]),
        .I2(TIM_ARE[13]),
        .I3(TIM_CNT[13]),
        .O(TIM_CNT1_carry__0_i_2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__0_i_3
       (.I0(TIM_CNT[10]),
        .I1(TIM_ARE[10]),
        .I2(TIM_ARE[11]),
        .I3(TIM_CNT[11]),
        .O(TIM_CNT1_carry__0_i_3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__0_i_4
       (.I0(TIM_CNT[8]),
        .I1(TIM_ARE[8]),
        .I2(TIM_ARE[9]),
        .I3(TIM_CNT[9]),
        .O(TIM_CNT1_carry__0_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__0_i_5
       (.I0(TIM_ARE[15]),
        .I1(TIM_CNT[15]),
        .I2(TIM_ARE[14]),
        .I3(TIM_CNT[14]),
        .O(TIM_CNT1_carry__0_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__0_i_6
       (.I0(TIM_ARE[13]),
        .I1(TIM_CNT[13]),
        .I2(TIM_ARE[12]),
        .I3(TIM_CNT[12]),
        .O(TIM_CNT1_carry__0_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__0_i_7
       (.I0(TIM_ARE[11]),
        .I1(TIM_CNT[11]),
        .I2(TIM_ARE[10]),
        .I3(TIM_CNT[10]),
        .O(TIM_CNT1_carry__0_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__0_i_8
       (.I0(TIM_ARE[9]),
        .I1(TIM_CNT[9]),
        .I2(TIM_ARE[8]),
        .I3(TIM_CNT[8]),
        .O(TIM_CNT1_carry__0_i_8_n_0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 TIM_CNT1_carry__1
       (.CI(TIM_CNT1_carry__0_n_0),
        .CO({TIM_CNT1_carry__1_n_0,TIM_CNT1_carry__1_n_1,TIM_CNT1_carry__1_n_2,TIM_CNT1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({TIM_CNT1_carry__1_i_1_n_0,TIM_CNT1_carry__1_i_2_n_0,TIM_CNT1_carry__1_i_3_n_0,TIM_CNT1_carry__1_i_4_n_0}),
        .O(NLW_TIM_CNT1_carry__1_O_UNCONNECTED[3:0]),
        .S({TIM_CNT1_carry__1_i_5_n_0,TIM_CNT1_carry__1_i_6_n_0,TIM_CNT1_carry__1_i_7_n_0,TIM_CNT1_carry__1_i_8_n_0}));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__1_i_1
       (.I0(TIM_CNT[22]),
        .I1(TIM_ARE[22]),
        .I2(TIM_ARE[23]),
        .I3(TIM_CNT[23]),
        .O(TIM_CNT1_carry__1_i_1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__1_i_2
       (.I0(TIM_CNT[20]),
        .I1(TIM_ARE[20]),
        .I2(TIM_ARE[21]),
        .I3(TIM_CNT[21]),
        .O(TIM_CNT1_carry__1_i_2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__1_i_3
       (.I0(TIM_CNT[18]),
        .I1(TIM_ARE[18]),
        .I2(TIM_ARE[19]),
        .I3(TIM_CNT[19]),
        .O(TIM_CNT1_carry__1_i_3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__1_i_4
       (.I0(TIM_CNT[16]),
        .I1(TIM_ARE[16]),
        .I2(TIM_ARE[17]),
        .I3(TIM_CNT[17]),
        .O(TIM_CNT1_carry__1_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__1_i_5
       (.I0(TIM_ARE[23]),
        .I1(TIM_CNT[23]),
        .I2(TIM_ARE[22]),
        .I3(TIM_CNT[22]),
        .O(TIM_CNT1_carry__1_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__1_i_6
       (.I0(TIM_ARE[21]),
        .I1(TIM_CNT[21]),
        .I2(TIM_ARE[20]),
        .I3(TIM_CNT[20]),
        .O(TIM_CNT1_carry__1_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__1_i_7
       (.I0(TIM_ARE[19]),
        .I1(TIM_CNT[19]),
        .I2(TIM_ARE[18]),
        .I3(TIM_CNT[18]),
        .O(TIM_CNT1_carry__1_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__1_i_8
       (.I0(TIM_ARE[17]),
        .I1(TIM_CNT[17]),
        .I2(TIM_ARE[16]),
        .I3(TIM_CNT[16]),
        .O(TIM_CNT1_carry__1_i_8_n_0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 TIM_CNT1_carry__2
       (.CI(TIM_CNT1_carry__1_n_0),
        .CO({TIM_CNT1_carry__2_n_0,TIM_CNT1_carry__2_n_1,TIM_CNT1_carry__2_n_2,TIM_CNT1_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({TIM_CNT1_carry__2_i_1_n_0,TIM_CNT1_carry__2_i_2_n_0,TIM_CNT1_carry__2_i_3_n_0,TIM_CNT1_carry__2_i_4_n_0}),
        .O(NLW_TIM_CNT1_carry__2_O_UNCONNECTED[3:0]),
        .S({TIM_CNT1_carry__2_i_5_n_0,TIM_CNT1_carry__2_i_6_n_0,TIM_CNT1_carry__2_i_7_n_0,TIM_CNT1_carry__2_i_8_n_0}));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__2_i_1
       (.I0(TIM_CNT[30]),
        .I1(TIM_ARE[30]),
        .I2(TIM_ARE[31]),
        .I3(TIM_CNT[31]),
        .O(TIM_CNT1_carry__2_i_1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__2_i_2
       (.I0(TIM_CNT[28]),
        .I1(TIM_ARE[28]),
        .I2(TIM_ARE[29]),
        .I3(TIM_CNT[29]),
        .O(TIM_CNT1_carry__2_i_2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__2_i_3
       (.I0(TIM_CNT[26]),
        .I1(TIM_ARE[26]),
        .I2(TIM_ARE[27]),
        .I3(TIM_CNT[27]),
        .O(TIM_CNT1_carry__2_i_3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry__2_i_4
       (.I0(TIM_CNT[24]),
        .I1(TIM_ARE[24]),
        .I2(TIM_ARE[25]),
        .I3(TIM_CNT[25]),
        .O(TIM_CNT1_carry__2_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__2_i_5
       (.I0(TIM_ARE[31]),
        .I1(TIM_CNT[31]),
        .I2(TIM_ARE[30]),
        .I3(TIM_CNT[30]),
        .O(TIM_CNT1_carry__2_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__2_i_6
       (.I0(TIM_ARE[29]),
        .I1(TIM_CNT[29]),
        .I2(TIM_ARE[28]),
        .I3(TIM_CNT[28]),
        .O(TIM_CNT1_carry__2_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__2_i_7
       (.I0(TIM_ARE[27]),
        .I1(TIM_CNT[27]),
        .I2(TIM_ARE[26]),
        .I3(TIM_CNT[26]),
        .O(TIM_CNT1_carry__2_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry__2_i_8
       (.I0(TIM_ARE[25]),
        .I1(TIM_CNT[25]),
        .I2(TIM_ARE[24]),
        .I3(TIM_CNT[24]),
        .O(TIM_CNT1_carry__2_i_8_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry_i_1
       (.I0(TIM_CNT[6]),
        .I1(TIM_ARE[6]),
        .I2(TIM_ARE[7]),
        .I3(TIM_CNT[7]),
        .O(TIM_CNT1_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry_i_2
       (.I0(TIM_CNT[4]),
        .I1(TIM_ARE[4]),
        .I2(TIM_ARE[5]),
        .I3(TIM_CNT[5]),
        .O(TIM_CNT1_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry_i_3
       (.I0(TIM_CNT[2]),
        .I1(TIM_ARE[2]),
        .I2(TIM_ARE[3]),
        .I3(TIM_CNT[3]),
        .O(TIM_CNT1_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    TIM_CNT1_carry_i_4
       (.I0(TIM_CNT[0]),
        .I1(TIM_ARE[0]),
        .I2(TIM_ARE[1]),
        .I3(TIM_CNT[1]),
        .O(TIM_CNT1_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry_i_5
       (.I0(TIM_ARE[7]),
        .I1(TIM_CNT[7]),
        .I2(TIM_ARE[6]),
        .I3(TIM_CNT[6]),
        .O(TIM_CNT1_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry_i_6
       (.I0(TIM_ARE[5]),
        .I1(TIM_CNT[5]),
        .I2(TIM_ARE[4]),
        .I3(TIM_CNT[4]),
        .O(TIM_CNT1_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry_i_7
       (.I0(TIM_ARE[3]),
        .I1(TIM_CNT[3]),
        .I2(TIM_ARE[2]),
        .I3(TIM_CNT[2]),
        .O(TIM_CNT1_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    TIM_CNT1_carry_i_8
       (.I0(TIM_ARE[1]),
        .I1(TIM_CNT[1]),
        .I2(TIM_ARE[0]),
        .I3(TIM_CNT[0]),
        .O(TIM_CNT1_carry_i_8_n_0));
  LUT5 #(
    .INIT(32'hC0FFC0EA)) 
    \TIM_CNT[0]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT[31]_i_7_n_0 ),
        .I2(TIM_ARE[0]),
        .I3(TIM_CNT[0]),
        .I4(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[10]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__1_n_6 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[10]),
        .I4(TIM_CNT0[10]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[11]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__1_n_5 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[11]),
        .I4(TIM_CNT0[11]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[12]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__1_n_4 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[12]),
        .I4(TIM_CNT0[12]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[13]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__2_n_7 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[13]),
        .I4(TIM_CNT0[13]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[14]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__2_n_6 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[14]),
        .I4(TIM_CNT0[14]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[15]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__2_n_5 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[15]),
        .I4(TIM_CNT0[15]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[16]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__2_n_4 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[16]),
        .I4(TIM_CNT0[16]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[17]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__3_n_7 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[17]),
        .I4(TIM_CNT0[17]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[18]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__3_n_6 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[18]),
        .I4(TIM_CNT0[18]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[19]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__3_n_5 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[19]),
        .I4(TIM_CNT0[19]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[1]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry_n_7 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[1]),
        .I4(TIM_CNT0[1]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[20]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__3_n_4 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[20]),
        .I4(TIM_CNT0[20]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[21]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__4_n_7 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[21]),
        .I4(TIM_CNT0[21]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[22]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__4_n_6 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[22]),
        .I4(TIM_CNT0[22]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[23]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__4_n_5 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[23]),
        .I4(TIM_CNT0[23]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[24]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__4_n_4 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[24]),
        .I4(TIM_CNT0[24]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[25]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__5_n_7 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[25]),
        .I4(TIM_CNT0[25]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[26]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__5_n_6 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[26]),
        .I4(TIM_CNT0[26]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[27]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__5_n_5 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[27]),
        .I4(TIM_CNT0[27]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[28]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__5_n_4 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[28]),
        .I4(TIM_CNT0[28]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[29]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__6_n_7 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[29]),
        .I4(TIM_CNT0[29]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[2]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry_n_6 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[2]),
        .I4(TIM_CNT0[2]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[30]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__6_n_6 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[30]),
        .I4(TIM_CNT0[30]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF8000)) 
    \TIM_CNT[31]_i_1 
       (.I0(\TIM_CNT[31]_i_3_n_0 ),
        .I1(\TIM_CNT[31]_i_4_n_0 ),
        .I2(\TIM_CNT[31]_i_5_n_0 ),
        .I3(p_3_in),
        .I4(\TIM_CLR_reg_n_0_[0] ),
        .O(\TIM_CNT[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000023)) 
    \TIM_CNT[31]_i_10 
       (.I0(TIM_PRE[28]),
        .I1(TIM_PRE[29]),
        .I2(TIM_PRE[27]),
        .I3(TIM_PRE[26]),
        .I4(TIM_PRE[25]),
        .O(\TIM_CNT[31]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \TIM_CNT[31]_i_11 
       (.I0(TIM_PRE[22]),
        .I1(TIM_PRE[23]),
        .O(\TIM_CNT[31]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h0011000100000000)) 
    \TIM_CNT[31]_i_12 
       (.I0(TIM_PRE[16]),
        .I1(TIM_PRE[17]),
        .I2(TIM_PRE[18]),
        .I3(TIM_PRE[20]),
        .I4(TIM_PRE[19]),
        .I5(\TIM_CNT[31]_i_22_n_0 ),
        .O(\TIM_CNT[31]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00000023)) 
    \TIM_CNT[31]_i_13 
       (.I0(TIM_PRE[10]),
        .I1(TIM_PRE[11]),
        .I2(TIM_PRE[9]),
        .I3(TIM_PRE[8]),
        .I4(TIM_PRE[7]),
        .O(\TIM_CNT[31]_i_13_n_0 ));
  LUT5 #(
    .INIT(32'h00000023)) 
    \TIM_CNT[31]_i_14 
       (.I0(TIM_PRE[13]),
        .I1(TIM_PRE[14]),
        .I2(TIM_PRE[12]),
        .I3(TIM_PRE[11]),
        .I4(TIM_PRE[10]),
        .O(\TIM_CNT[31]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'h00000023)) 
    \TIM_CNT[31]_i_15 
       (.I0(TIM_PRE[16]),
        .I1(TIM_PRE[17]),
        .I2(TIM_PRE[15]),
        .I3(TIM_PRE[14]),
        .I4(TIM_PRE[13]),
        .O(\TIM_CNT[31]_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h31)) 
    \TIM_CNT[31]_i_16 
       (.I0(TIM_PRE[0]),
        .I1(TIM_PRE[2]),
        .I2(TIM_PRE[1]),
        .O(\TIM_CNT[31]_i_16_n_0 ));
  LUT5 #(
    .INIT(32'h00000023)) 
    \TIM_CNT[31]_i_17 
       (.I0(TIM_PRE[7]),
        .I1(TIM_PRE[8]),
        .I2(TIM_PRE[6]),
        .I3(TIM_PRE[5]),
        .I4(TIM_PRE[4]),
        .O(\TIM_CNT[31]_i_17_n_0 ));
  LUT5 #(
    .INIT(32'h00000023)) 
    \TIM_CNT[31]_i_18 
       (.I0(TIM_PRE[4]),
        .I1(TIM_PRE[5]),
        .I2(TIM_PRE[3]),
        .I3(TIM_PRE[2]),
        .I4(TIM_PRE[1]),
        .O(\TIM_CNT[31]_i_18_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \TIM_CNT[31]_i_19 
       (.I0(TIM_CNT[14]),
        .I1(TIM_CNT[12]),
        .I2(TIM_CNT[10]),
        .I3(TIM_CNT[7]),
        .I4(\TIM_CNT[31]_i_23_n_0 ),
        .I5(\TIM_CNT[31]_i_24_n_0 ),
        .O(\TIM_CNT[31]_i_19_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[31]_i_2 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__6_n_5 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[31]),
        .I4(TIM_CNT0[31]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \TIM_CNT[31]_i_20 
       (.I0(TIM_CNT[25]),
        .I1(TIM_CNT[28]),
        .I2(TIM_CNT[19]),
        .I3(TIM_CNT[22]),
        .I4(\TIM_EVN[31]_i_12_n_0 ),
        .I5(\TIM_CNT[31]_i_25_n_0 ),
        .O(\TIM_CNT[31]_i_20_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \TIM_CNT[31]_i_21 
       (.I0(TIM_CNT[18]),
        .I1(TIM_CNT[20]),
        .I2(TIM_CNT[16]),
        .I3(TIM_CNT[17]),
        .I4(\TIM_CNT[31]_i_26_n_0 ),
        .I5(\TIM_CNT[31]_i_27_n_0 ),
        .O(\TIM_CNT[31]_i_21_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00000023)) 
    \TIM_CNT[31]_i_22 
       (.I0(TIM_PRE[22]),
        .I1(TIM_PRE[23]),
        .I2(TIM_PRE[21]),
        .I3(TIM_PRE[20]),
        .I4(TIM_PRE[19]),
        .O(\TIM_CNT[31]_i_22_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \TIM_CNT[31]_i_23 
       (.I0(TIM_CNT[3]),
        .I1(TIM_CNT[5]),
        .I2(TIM_CNT[4]),
        .I3(TIM_CNT[1]),
        .I4(TIM_CNT[2]),
        .I5(TIM_CNT[0]),
        .O(\TIM_CNT[31]_i_23_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \TIM_CNT[31]_i_24 
       (.I0(TIM_CNT[15]),
        .I1(TIM_CNT[13]),
        .I2(TIM_CNT[9]),
        .I3(TIM_CNT[11]),
        .I4(TIM_CNT[6]),
        .I5(TIM_CNT[8]),
        .O(\TIM_CNT[31]_i_24_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \TIM_CNT[31]_i_25 
       (.I0(TIM_CNT[27]),
        .I1(TIM_CNT[29]),
        .O(\TIM_CNT[31]_i_25_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \TIM_CNT[31]_i_26 
       (.I0(TIM_CNT[24]),
        .I1(TIM_CNT[26]),
        .O(\TIM_CNT[31]_i_26_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \TIM_CNT[31]_i_27 
       (.I0(TIM_CNT[21]),
        .I1(TIM_CNT[23]),
        .O(\TIM_CNT[31]_i_27_n_0 ));
  LUT6 #(
    .INIT(64'h080A000000000000)) 
    \TIM_CNT[31]_i_3 
       (.I0(\TIM_CNT[31]_i_10_n_0 ),
        .I1(TIM_PRE[25]),
        .I2(TIM_PRE[26]),
        .I3(TIM_PRE[24]),
        .I4(\TIM_CNT[31]_i_11_n_0 ),
        .I5(\TIM_CNT[31]_i_12_n_0 ),
        .O(\TIM_CNT[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \TIM_CNT[31]_i_4 
       (.I0(\TIM_CNT[31]_i_13_n_0 ),
        .I1(\TIM_CNT[31]_i_14_n_0 ),
        .I2(\TIM_CNT[31]_i_15_n_0 ),
        .I3(\TIM_CNT[31]_i_16_n_0 ),
        .I4(\TIM_CNT[31]_i_17_n_0 ),
        .I5(\TIM_CNT[31]_i_18_n_0 ),
        .O(\TIM_CNT[31]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \TIM_CNT[31]_i_5 
       (.I0(TIM_PRE[31]),
        .I1(TIM_PRE[30]),
        .I2(TIM_PRE[29]),
        .I3(TIM_PRE[28]),
        .O(\TIM_CNT[31]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h10111111)) 
    \TIM_CNT[31]_i_6 
       (.I0(\TIM_CLR_reg_n_0_[0] ),
        .I1(\TIM_MOD_reg_n_0_[0] ),
        .I2(\TIM_CNT[31]_i_19_n_0 ),
        .I3(\TIM_CNT[31]_i_20_n_0 ),
        .I4(\TIM_CNT[31]_i_21_n_0 ),
        .O(\TIM_CNT[31]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h01000000)) 
    \TIM_CNT[31]_i_7 
       (.I0(\TIM_CLR_reg_n_0_[0] ),
        .I1(\TIM_MOD_reg_n_0_[0] ),
        .I2(\TIM_CNT[31]_i_19_n_0 ),
        .I3(\TIM_CNT[31]_i_20_n_0 ),
        .I4(\TIM_CNT[31]_i_21_n_0 ),
        .O(\TIM_CNT[31]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \TIM_CNT[31]_i_9 
       (.I0(TIM_CNT1_carry__2_n_0),
        .I1(\TIM_MOD_reg_n_0_[0] ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .O(\TIM_CNT[31]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[3]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry_n_5 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[3]),
        .I4(TIM_CNT0[3]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[4]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry_n_4 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[4]),
        .I4(TIM_CNT0[4]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[5]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__0_n_7 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[5]),
        .I4(TIM_CNT0[5]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[6]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__0_n_6 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[6]),
        .I4(TIM_CNT0[6]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[7]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__0_n_5 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[7]),
        .I4(TIM_CNT0[7]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[8]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__0_n_4 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[8]),
        .I4(TIM_CNT0[8]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \TIM_CNT[9]_i_1 
       (.I0(\TIM_CNT[31]_i_6_n_0 ),
        .I1(\TIM_CNT0_inferred__0/i__carry__1_n_7 ),
        .I2(\TIM_CNT[31]_i_7_n_0 ),
        .I3(TIM_ARE[9]),
        .I4(TIM_CNT0[9]),
        .I5(\TIM_CNT[31]_i_9_n_0 ),
        .O(\TIM_CNT[9]_i_1_n_0 ));
  FDCE \TIM_CNT_reg[0] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[0]_i_1_n_0 ),
        .Q(TIM_CNT[0]));
  FDCE \TIM_CNT_reg[10] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[10]_i_1_n_0 ),
        .Q(TIM_CNT[10]));
  FDCE \TIM_CNT_reg[11] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[11]_i_1_n_0 ),
        .Q(TIM_CNT[11]));
  FDCE \TIM_CNT_reg[12] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[12]_i_1_n_0 ),
        .Q(TIM_CNT[12]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT_reg[12]_i_2 
       (.CI(\TIM_CNT_reg[8]_i_2_n_0 ),
        .CO({\TIM_CNT_reg[12]_i_2_n_0 ,\TIM_CNT_reg[12]_i_2_n_1 ,\TIM_CNT_reg[12]_i_2_n_2 ,\TIM_CNT_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(TIM_CNT0[12:9]),
        .S(TIM_CNT[12:9]));
  FDCE \TIM_CNT_reg[13] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[13]_i_1_n_0 ),
        .Q(TIM_CNT[13]));
  FDCE \TIM_CNT_reg[14] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[14]_i_1_n_0 ),
        .Q(TIM_CNT[14]));
  FDCE \TIM_CNT_reg[15] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[15]_i_1_n_0 ),
        .Q(TIM_CNT[15]));
  FDCE \TIM_CNT_reg[16] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[16]_i_1_n_0 ),
        .Q(TIM_CNT[16]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT_reg[16]_i_2 
       (.CI(\TIM_CNT_reg[12]_i_2_n_0 ),
        .CO({\TIM_CNT_reg[16]_i_2_n_0 ,\TIM_CNT_reg[16]_i_2_n_1 ,\TIM_CNT_reg[16]_i_2_n_2 ,\TIM_CNT_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(TIM_CNT0[16:13]),
        .S(TIM_CNT[16:13]));
  FDCE \TIM_CNT_reg[17] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[17]_i_1_n_0 ),
        .Q(TIM_CNT[17]));
  FDCE \TIM_CNT_reg[18] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[18]_i_1_n_0 ),
        .Q(TIM_CNT[18]));
  FDCE \TIM_CNT_reg[19] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[19]_i_1_n_0 ),
        .Q(TIM_CNT[19]));
  FDCE \TIM_CNT_reg[1] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[1]_i_1_n_0 ),
        .Q(TIM_CNT[1]));
  FDCE \TIM_CNT_reg[20] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[20]_i_1_n_0 ),
        .Q(TIM_CNT[20]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT_reg[20]_i_2 
       (.CI(\TIM_CNT_reg[16]_i_2_n_0 ),
        .CO({\TIM_CNT_reg[20]_i_2_n_0 ,\TIM_CNT_reg[20]_i_2_n_1 ,\TIM_CNT_reg[20]_i_2_n_2 ,\TIM_CNT_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(TIM_CNT0[20:17]),
        .S(TIM_CNT[20:17]));
  FDCE \TIM_CNT_reg[21] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[21]_i_1_n_0 ),
        .Q(TIM_CNT[21]));
  FDCE \TIM_CNT_reg[22] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[22]_i_1_n_0 ),
        .Q(TIM_CNT[22]));
  FDCE \TIM_CNT_reg[23] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[23]_i_1_n_0 ),
        .Q(TIM_CNT[23]));
  FDCE \TIM_CNT_reg[24] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[24]_i_1_n_0 ),
        .Q(TIM_CNT[24]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT_reg[24]_i_2 
       (.CI(\TIM_CNT_reg[20]_i_2_n_0 ),
        .CO({\TIM_CNT_reg[24]_i_2_n_0 ,\TIM_CNT_reg[24]_i_2_n_1 ,\TIM_CNT_reg[24]_i_2_n_2 ,\TIM_CNT_reg[24]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(TIM_CNT0[24:21]),
        .S(TIM_CNT[24:21]));
  FDCE \TIM_CNT_reg[25] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[25]_i_1_n_0 ),
        .Q(TIM_CNT[25]));
  FDCE \TIM_CNT_reg[26] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[26]_i_1_n_0 ),
        .Q(TIM_CNT[26]));
  FDCE \TIM_CNT_reg[27] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[27]_i_1_n_0 ),
        .Q(TIM_CNT[27]));
  FDCE \TIM_CNT_reg[28] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[28]_i_1_n_0 ),
        .Q(TIM_CNT[28]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT_reg[28]_i_2 
       (.CI(\TIM_CNT_reg[24]_i_2_n_0 ),
        .CO({\TIM_CNT_reg[28]_i_2_n_0 ,\TIM_CNT_reg[28]_i_2_n_1 ,\TIM_CNT_reg[28]_i_2_n_2 ,\TIM_CNT_reg[28]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(TIM_CNT0[28:25]),
        .S(TIM_CNT[28:25]));
  FDCE \TIM_CNT_reg[29] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[29]_i_1_n_0 ),
        .Q(TIM_CNT[29]));
  FDCE \TIM_CNT_reg[2] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[2]_i_1_n_0 ),
        .Q(TIM_CNT[2]));
  FDCE \TIM_CNT_reg[30] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[30]_i_1_n_0 ),
        .Q(TIM_CNT[30]));
  FDCE \TIM_CNT_reg[31] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[31]_i_2_n_0 ),
        .Q(TIM_CNT[31]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT_reg[31]_i_8 
       (.CI(\TIM_CNT_reg[28]_i_2_n_0 ),
        .CO({\NLW_TIM_CNT_reg[31]_i_8_CO_UNCONNECTED [3:2],\TIM_CNT_reg[31]_i_8_n_2 ,\TIM_CNT_reg[31]_i_8_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_TIM_CNT_reg[31]_i_8_O_UNCONNECTED [3],TIM_CNT0[31:29]}),
        .S({1'b0,TIM_CNT[31:29]}));
  FDCE \TIM_CNT_reg[3] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[3]_i_1_n_0 ),
        .Q(TIM_CNT[3]));
  FDCE \TIM_CNT_reg[4] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[4]_i_1_n_0 ),
        .Q(TIM_CNT[4]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\TIM_CNT_reg[4]_i_2_n_0 ,\TIM_CNT_reg[4]_i_2_n_1 ,\TIM_CNT_reg[4]_i_2_n_2 ,\TIM_CNT_reg[4]_i_2_n_3 }),
        .CYINIT(TIM_CNT[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(TIM_CNT0[4:1]),
        .S(TIM_CNT[4:1]));
  FDCE \TIM_CNT_reg[5] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[5]_i_1_n_0 ),
        .Q(TIM_CNT[5]));
  FDCE \TIM_CNT_reg[6] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[6]_i_1_n_0 ),
        .Q(TIM_CNT[6]));
  FDCE \TIM_CNT_reg[7] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[7]_i_1_n_0 ),
        .Q(TIM_CNT[7]));
  FDCE \TIM_CNT_reg[8] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[8]_i_1_n_0 ),
        .Q(TIM_CNT[8]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \TIM_CNT_reg[8]_i_2 
       (.CI(\TIM_CNT_reg[4]_i_2_n_0 ),
        .CO({\TIM_CNT_reg[8]_i_2_n_0 ,\TIM_CNT_reg[8]_i_2_n_1 ,\TIM_CNT_reg[8]_i_2_n_2 ,\TIM_CNT_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(TIM_CNT0[8:5]),
        .S(TIM_CNT[8:5]));
  FDCE \TIM_CNT_reg[9] 
       (.C(clk_i),
        .CE(\TIM_CNT[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_CNT[9]_i_1_n_0 ),
        .Q(TIM_CNT[9]));
  LUT4 #(
    .INIT(16'h2000)) 
    \TIM_ENA[31]_i_1 
       (.I0(\TIM_CLR[31]_i_3_n_0 ),
        .I1(awaddr[4]),
        .I2(awaddr[3]),
        .I3(awaddr[2]),
        .O(TIM_ENA));
  FDCE \TIM_ENA_reg[0] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[0]),
        .Q(p_3_in));
  FDCE \TIM_ENA_reg[10] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[10]),
        .Q(\TIM_ENA_reg_n_0_[10] ));
  FDCE \TIM_ENA_reg[11] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[11]),
        .Q(\TIM_ENA_reg_n_0_[11] ));
  FDCE \TIM_ENA_reg[12] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[12]),
        .Q(\TIM_ENA_reg_n_0_[12] ));
  FDCE \TIM_ENA_reg[13] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[13]),
        .Q(\TIM_ENA_reg_n_0_[13] ));
  FDCE \TIM_ENA_reg[14] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[14]),
        .Q(\TIM_ENA_reg_n_0_[14] ));
  FDCE \TIM_ENA_reg[15] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[15]),
        .Q(\TIM_ENA_reg_n_0_[15] ));
  FDCE \TIM_ENA_reg[16] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[16]),
        .Q(\TIM_ENA_reg_n_0_[16] ));
  FDCE \TIM_ENA_reg[17] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[17]),
        .Q(\TIM_ENA_reg_n_0_[17] ));
  FDCE \TIM_ENA_reg[18] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[18]),
        .Q(\TIM_ENA_reg_n_0_[18] ));
  FDCE \TIM_ENA_reg[19] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[19]),
        .Q(\TIM_ENA_reg_n_0_[19] ));
  FDCE \TIM_ENA_reg[1] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[1]),
        .Q(\TIM_ENA_reg_n_0_[1] ));
  FDCE \TIM_ENA_reg[20] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[20]),
        .Q(\TIM_ENA_reg_n_0_[20] ));
  FDCE \TIM_ENA_reg[21] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[21]),
        .Q(\TIM_ENA_reg_n_0_[21] ));
  FDCE \TIM_ENA_reg[22] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[22]),
        .Q(\TIM_ENA_reg_n_0_[22] ));
  FDCE \TIM_ENA_reg[23] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[23]),
        .Q(\TIM_ENA_reg_n_0_[23] ));
  FDCE \TIM_ENA_reg[24] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[24]),
        .Q(\TIM_ENA_reg_n_0_[24] ));
  FDCE \TIM_ENA_reg[25] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[25]),
        .Q(\TIM_ENA_reg_n_0_[25] ));
  FDCE \TIM_ENA_reg[26] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[26]),
        .Q(\TIM_ENA_reg_n_0_[26] ));
  FDCE \TIM_ENA_reg[27] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[27]),
        .Q(\TIM_ENA_reg_n_0_[27] ));
  FDCE \TIM_ENA_reg[28] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[28]),
        .Q(\TIM_ENA_reg_n_0_[28] ));
  FDCE \TIM_ENA_reg[29] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[29]),
        .Q(\TIM_ENA_reg_n_0_[29] ));
  FDCE \TIM_ENA_reg[2] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[2]),
        .Q(\TIM_ENA_reg_n_0_[2] ));
  FDCE \TIM_ENA_reg[30] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[30]),
        .Q(\TIM_ENA_reg_n_0_[30] ));
  FDCE \TIM_ENA_reg[31] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[31]),
        .Q(\TIM_ENA_reg_n_0_[31] ));
  FDCE \TIM_ENA_reg[3] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[3]),
        .Q(\TIM_ENA_reg_n_0_[3] ));
  FDCE \TIM_ENA_reg[4] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[4]),
        .Q(\TIM_ENA_reg_n_0_[4] ));
  FDCE \TIM_ENA_reg[5] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[5]),
        .Q(\TIM_ENA_reg_n_0_[5] ));
  FDCE \TIM_ENA_reg[6] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[6]),
        .Q(\TIM_ENA_reg_n_0_[6] ));
  FDCE \TIM_ENA_reg[7] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[7]),
        .Q(\TIM_ENA_reg_n_0_[7] ));
  FDCE \TIM_ENA_reg[8] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[8]),
        .Q(\TIM_ENA_reg_n_0_[8] ));
  FDCE \TIM_ENA_reg[9] 
       (.C(clk_i),
        .CE(TIM_ENA),
        .CLR(wready_i_2_n_0),
        .D(wdata[9]),
        .Q(\TIM_ENA_reg_n_0_[9] ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[0]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[0]),
        .O(\TIM_EVC[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[10]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[10]),
        .O(\TIM_EVC[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[11]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[11]),
        .O(\TIM_EVC[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[12]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[12]),
        .O(\TIM_EVC[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[13]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[13]),
        .O(\TIM_EVC[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[14]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[14]),
        .O(\TIM_EVC[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[15]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[15]),
        .O(\TIM_EVC[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[16]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[16]),
        .O(\TIM_EVC[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[17]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[17]),
        .O(\TIM_EVC[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[18]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[18]),
        .O(\TIM_EVC[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[19]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[19]),
        .O(\TIM_EVC[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[1]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[1]),
        .O(\TIM_EVC[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[20]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[20]),
        .O(\TIM_EVC[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[21]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[21]),
        .O(\TIM_EVC[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[22]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[22]),
        .O(\TIM_EVC[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[23]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[23]),
        .O(\TIM_EVC[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[24]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[24]),
        .O(\TIM_EVC[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[25]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[25]),
        .O(\TIM_EVC[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[26]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[26]),
        .O(\TIM_EVC[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[27]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[27]),
        .O(\TIM_EVC[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[28]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[28]),
        .O(\TIM_EVC[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[29]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[29]),
        .O(\TIM_EVC[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[2]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[2]),
        .O(\TIM_EVC[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[30]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[30]),
        .O(\TIM_EVC[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8000FFFF)) 
    \TIM_EVC[31]_i_1 
       (.I0(\TIM_CLR[31]_i_3_n_0 ),
        .I1(awaddr[4]),
        .I2(awaddr[3]),
        .I3(awaddr[2]),
        .I4(\TIM_EVC[31]_i_3_n_0 ),
        .O(\TIM_EVC[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[31]_i_2 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[31]),
        .O(\TIM_EVC[31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \TIM_EVC[31]_i_3 
       (.I0(p_3_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_2_in),
        .O(\TIM_EVC[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[3]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[3]),
        .O(\TIM_EVC[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[4]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[4]),
        .O(\TIM_EVC[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[5]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[5]),
        .O(\TIM_EVC[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[6]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[6]),
        .O(\TIM_EVC[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[7]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[7]),
        .O(\TIM_EVC[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[8]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[8]),
        .O(\TIM_EVC[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    \TIM_EVC[9]_i_1 
       (.I0(p_2_in),
        .I1(\TIM_CLR_reg_n_0_[0] ),
        .I2(p_3_in),
        .I3(wdata[9]),
        .O(\TIM_EVC[9]_i_1_n_0 ));
  FDCE \TIM_EVC_reg[0] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[0]_i_1_n_0 ),
        .Q(p_2_in));
  FDCE \TIM_EVC_reg[10] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[10]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[10] ));
  FDCE \TIM_EVC_reg[11] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[11]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[11] ));
  FDCE \TIM_EVC_reg[12] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[12]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[12] ));
  FDCE \TIM_EVC_reg[13] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[13]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[13] ));
  FDCE \TIM_EVC_reg[14] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[14]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[14] ));
  FDCE \TIM_EVC_reg[15] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[15]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[15] ));
  FDCE \TIM_EVC_reg[16] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[16]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[16] ));
  FDCE \TIM_EVC_reg[17] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[17]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[17] ));
  FDCE \TIM_EVC_reg[18] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[18]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[18] ));
  FDCE \TIM_EVC_reg[19] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[19]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[19] ));
  FDCE \TIM_EVC_reg[1] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[1]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[1] ));
  FDCE \TIM_EVC_reg[20] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[20]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[20] ));
  FDCE \TIM_EVC_reg[21] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[21]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[21] ));
  FDCE \TIM_EVC_reg[22] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[22]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[22] ));
  FDCE \TIM_EVC_reg[23] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[23]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[23] ));
  FDCE \TIM_EVC_reg[24] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[24]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[24] ));
  FDCE \TIM_EVC_reg[25] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[25]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[25] ));
  FDCE \TIM_EVC_reg[26] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[26]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[26] ));
  FDCE \TIM_EVC_reg[27] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[27]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[27] ));
  FDCE \TIM_EVC_reg[28] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[28]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[28] ));
  FDCE \TIM_EVC_reg[29] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[29]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[29] ));
  FDCE \TIM_EVC_reg[2] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[2]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[2] ));
  FDCE \TIM_EVC_reg[30] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[30]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[30] ));
  FDCE \TIM_EVC_reg[31] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[31]_i_2_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[31] ));
  FDCE \TIM_EVC_reg[3] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[3]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[3] ));
  FDCE \TIM_EVC_reg[4] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[4]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[4] ));
  FDCE \TIM_EVC_reg[5] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[5]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[5] ));
  FDCE \TIM_EVC_reg[6] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[6]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[6] ));
  FDCE \TIM_EVC_reg[7] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[7]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[7] ));
  FDCE \TIM_EVC_reg[8] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[8]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[8] ));
  FDCE \TIM_EVC_reg[9] 
       (.C(clk_i),
        .CE(\TIM_EVC[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVC[9]_i_1_n_0 ),
        .Q(\TIM_EVC_reg_n_0_[9] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_EVN0_carry
       (.CI(1'b0),
        .CO({TIM_EVN0_carry_n_0,TIM_EVN0_carry_n_1,TIM_EVN0_carry_n_2,TIM_EVN0_carry_n_3}),
        .CYINIT(TIM_EVN[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({TIM_EVN0_carry_n_4,TIM_EVN0_carry_n_5,TIM_EVN0_carry_n_6,TIM_EVN0_carry_n_7}),
        .S(TIM_EVN[4:1]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_EVN0_carry__0
       (.CI(TIM_EVN0_carry_n_0),
        .CO({TIM_EVN0_carry__0_n_0,TIM_EVN0_carry__0_n_1,TIM_EVN0_carry__0_n_2,TIM_EVN0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({TIM_EVN0_carry__0_n_4,TIM_EVN0_carry__0_n_5,TIM_EVN0_carry__0_n_6,TIM_EVN0_carry__0_n_7}),
        .S(TIM_EVN[8:5]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_EVN0_carry__1
       (.CI(TIM_EVN0_carry__0_n_0),
        .CO({TIM_EVN0_carry__1_n_0,TIM_EVN0_carry__1_n_1,TIM_EVN0_carry__1_n_2,TIM_EVN0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({TIM_EVN0_carry__1_n_4,TIM_EVN0_carry__1_n_5,TIM_EVN0_carry__1_n_6,TIM_EVN0_carry__1_n_7}),
        .S(TIM_EVN[12:9]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_EVN0_carry__2
       (.CI(TIM_EVN0_carry__1_n_0),
        .CO({TIM_EVN0_carry__2_n_0,TIM_EVN0_carry__2_n_1,TIM_EVN0_carry__2_n_2,TIM_EVN0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({TIM_EVN0_carry__2_n_4,TIM_EVN0_carry__2_n_5,TIM_EVN0_carry__2_n_6,TIM_EVN0_carry__2_n_7}),
        .S(TIM_EVN[16:13]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_EVN0_carry__3
       (.CI(TIM_EVN0_carry__2_n_0),
        .CO({TIM_EVN0_carry__3_n_0,TIM_EVN0_carry__3_n_1,TIM_EVN0_carry__3_n_2,TIM_EVN0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({TIM_EVN0_carry__3_n_4,TIM_EVN0_carry__3_n_5,TIM_EVN0_carry__3_n_6,TIM_EVN0_carry__3_n_7}),
        .S(TIM_EVN[20:17]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_EVN0_carry__4
       (.CI(TIM_EVN0_carry__3_n_0),
        .CO({TIM_EVN0_carry__4_n_0,TIM_EVN0_carry__4_n_1,TIM_EVN0_carry__4_n_2,TIM_EVN0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({TIM_EVN0_carry__4_n_4,TIM_EVN0_carry__4_n_5,TIM_EVN0_carry__4_n_6,TIM_EVN0_carry__4_n_7}),
        .S(TIM_EVN[24:21]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_EVN0_carry__5
       (.CI(TIM_EVN0_carry__4_n_0),
        .CO({TIM_EVN0_carry__5_n_0,TIM_EVN0_carry__5_n_1,TIM_EVN0_carry__5_n_2,TIM_EVN0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({TIM_EVN0_carry__5_n_4,TIM_EVN0_carry__5_n_5,TIM_EVN0_carry__5_n_6,TIM_EVN0_carry__5_n_7}),
        .S(TIM_EVN[28:25]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_EVN0_carry__6
       (.CI(TIM_EVN0_carry__5_n_0),
        .CO({NLW_TIM_EVN0_carry__6_CO_UNCONNECTED[3:2],TIM_EVN0_carry__6_n_2,TIM_EVN0_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_TIM_EVN0_carry__6_O_UNCONNECTED[3],TIM_EVN0_carry__6_n_5,TIM_EVN0_carry__6_n_6,TIM_EVN0_carry__6_n_7}),
        .S({1'b0,TIM_EVN[31:29]}));
  LUT5 #(
    .INIT(32'h0A0A0800)) 
    \TIM_EVN[0]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN[0]),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[10]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__1_n_6),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[11]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__1_n_5),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[12]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__1_n_4),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[13]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__2_n_7),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[14]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__2_n_6),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[15]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__2_n_5),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[16]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__2_n_4),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[17]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__3_n_7),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[18]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__3_n_6),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[19]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__3_n_5),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[1]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry_n_7),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[20]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__3_n_4),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[21]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__4_n_7),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[22]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__4_n_6),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[23]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__4_n_5),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[24]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__4_n_4),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[24]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[25]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__5_n_7),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[26]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__5_n_6),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[27]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__5_n_5),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[28]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__5_n_4),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[28]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[29]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__6_n_7),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[2]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry_n_6),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[30]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__6_n_6),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0B080000)) 
    \TIM_EVN[31]_i_1 
       (.I0(\TIM_EVN[31]_i_3_n_0 ),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(p_2_in),
        .I4(p_3_in),
        .O(\TIM_EVN[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \TIM_EVN[31]_i_10 
       (.I0(TIM_CNT[3]),
        .I1(TIM_CNT[5]),
        .I2(TIM_CNT[1]),
        .I3(TIM_CNT[2]),
        .I4(\TIM_EVN[31]_i_23_n_0 ),
        .O(\TIM_EVN[31]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0011000100000000)) 
    \TIM_EVN[31]_i_11 
       (.I0(TIM_PRE[22]),
        .I1(TIM_PRE[23]),
        .I2(TIM_PRE[24]),
        .I3(TIM_PRE[26]),
        .I4(TIM_PRE[25]),
        .I5(\TIM_CNT[31]_i_10_n_0 ),
        .O(\TIM_EVN[31]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \TIM_EVN[31]_i_12 
       (.I0(TIM_CNT[30]),
        .I1(TIM_CNT[31]),
        .O(\TIM_EVN[31]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \TIM_EVN[31]_i_13 
       (.I0(TIM_CNT[19]),
        .I1(TIM_CNT[20]),
        .I2(TIM_CNT[18]),
        .I3(TIM_CNT[22]),
        .I4(TIM_CNT[23]),
        .I5(TIM_CNT[21]),
        .O(\TIM_EVN[31]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \TIM_EVN[31]_i_14 
       (.I0(TIM_CNT[13]),
        .I1(TIM_CNT[14]),
        .I2(TIM_CNT[12]),
        .I3(TIM_CNT[16]),
        .I4(TIM_CNT[17]),
        .I5(TIM_CNT[15]),
        .O(\TIM_EVN[31]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \TIM_EVN[31]_i_15 
       (.I0(TIM_CNT[7]),
        .I1(TIM_CNT[8]),
        .I2(TIM_CNT[6]),
        .I3(TIM_CNT[10]),
        .I4(TIM_CNT[11]),
        .I5(TIM_CNT[9]),
        .O(\TIM_EVN[31]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \TIM_EVN[31]_i_16 
       (.I0(TIM_CNT[1]),
        .I1(TIM_CNT[2]),
        .I2(TIM_CNT[0]),
        .I3(TIM_CNT[4]),
        .I4(TIM_CNT[5]),
        .I5(TIM_CNT[3]),
        .O(\TIM_EVN[31]_i_16_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \TIM_EVN[31]_i_17 
       (.I0(TIM_CNT[24]),
        .I1(TIM_CNT[26]),
        .I2(TIM_CNT[25]),
        .O(\TIM_EVN[31]_i_17_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \TIM_EVN[31]_i_18 
       (.I0(TIM_CNT[16]),
        .I1(TIM_CNT[17]),
        .O(\TIM_EVN[31]_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \TIM_EVN[31]_i_19 
       (.I0(TIM_CNT[26]),
        .I1(TIM_CNT[24]),
        .I2(TIM_CNT[29]),
        .I3(TIM_CNT[27]),
        .O(\TIM_EVN[31]_i_19_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[31]_i_2 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__6_n_5),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \TIM_EVN[31]_i_20 
       (.I0(TIM_CNT[21]),
        .I1(TIM_CNT[23]),
        .I2(TIM_CNT[18]),
        .I3(TIM_CNT[20]),
        .I4(TIM_CNT[25]),
        .I5(TIM_CNT[22]),
        .O(\TIM_EVN[31]_i_20_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \TIM_EVN[31]_i_21 
       (.I0(TIM_CNT[12]),
        .I1(TIM_CNT[14]),
        .O(\TIM_EVN[31]_i_21_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \TIM_EVN[31]_i_22 
       (.I0(TIM_CNT[13]),
        .I1(TIM_CNT[15]),
        .O(\TIM_EVN[31]_i_22_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \TIM_EVN[31]_i_23 
       (.I0(TIM_CNT[8]),
        .I1(TIM_CNT[6]),
        .I2(TIM_CNT[11]),
        .I3(TIM_CNT[9]),
        .O(\TIM_EVN[31]_i_23_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF8B888888)) 
    \TIM_EVN[31]_i_3 
       (.I0(TIM_CNT1_carry__2_n_0),
        .I1(\TIM_MOD_reg_n_0_[0] ),
        .I2(\TIM_EVN[31]_i_8_n_0 ),
        .I3(\TIM_EVN[31]_i_9_n_0 ),
        .I4(\TIM_EVN[31]_i_10_n_0 ),
        .I5(p_2_in),
        .O(\TIM_EVN[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \TIM_EVN[31]_i_4 
       (.I0(\TIM_CNT[31]_i_12_n_0 ),
        .I1(\TIM_EVN[31]_i_11_n_0 ),
        .I2(TIM_PRE[28]),
        .I3(TIM_PRE[29]),
        .I4(TIM_PRE[30]),
        .I5(TIM_PRE[31]),
        .O(\TIM_EVN[31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \TIM_EVN[31]_i_5 
       (.I0(TIM_CNT[27]),
        .I1(TIM_CNT[29]),
        .I2(TIM_CNT[28]),
        .I3(\TIM_EVN[31]_i_12_n_0 ),
        .I4(\TIM_MOD_reg_n_0_[0] ),
        .I5(\TIM_CNT[31]_i_4_n_0 ),
        .O(\TIM_EVN[31]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \TIM_EVN[31]_i_6 
       (.I0(\TIM_EVN[31]_i_13_n_0 ),
        .I1(\TIM_EVN[31]_i_14_n_0 ),
        .I2(\TIM_EVN[31]_i_15_n_0 ),
        .I3(\TIM_EVN[31]_i_16_n_0 ),
        .I4(\TIM_EVN[31]_i_17_n_0 ),
        .O(\TIM_EVN[31]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \TIM_EVN[31]_i_7 
       (.I0(TIM_CNT1_carry__2_n_0),
        .I1(\TIM_MOD_reg_n_0_[0] ),
        .I2(\TIM_CNT[31]_i_4_n_0 ),
        .O(\TIM_EVN[31]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \TIM_EVN[31]_i_8 
       (.I0(\TIM_EVN[31]_i_18_n_0 ),
        .I1(TIM_CNT[19]),
        .I2(\TIM_EVN[31]_i_19_n_0 ),
        .I3(\TIM_EVN[31]_i_12_n_0 ),
        .I4(TIM_CNT[28]),
        .I5(\TIM_EVN[31]_i_20_n_0 ),
        .O(\TIM_EVN[31]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \TIM_EVN[31]_i_9 
       (.I0(TIM_CNT[7]),
        .I1(TIM_CNT[10]),
        .I2(TIM_CNT[0]),
        .I3(TIM_CNT[4]),
        .I4(\TIM_EVN[31]_i_21_n_0 ),
        .I5(\TIM_EVN[31]_i_22_n_0 ),
        .O(\TIM_EVN[31]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[3]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry_n_5),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[4]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry_n_4),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[5]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__0_n_7),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[6]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__0_n_6),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[7]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__0_n_5),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[8]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__0_n_4),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A08000)) 
    \TIM_EVN[9]_i_1 
       (.I0(\TIM_EVN[31]_i_4_n_0 ),
        .I1(\TIM_EVN[31]_i_5_n_0 ),
        .I2(TIM_EVN0_carry__1_n_7),
        .I3(\TIM_EVN[31]_i_6_n_0 ),
        .I4(\TIM_EVN[31]_i_7_n_0 ),
        .O(\TIM_EVN[9]_i_1_n_0 ));
  FDCE \TIM_EVN_reg[0] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[0]_i_1_n_0 ),
        .Q(TIM_EVN[0]));
  FDCE \TIM_EVN_reg[10] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[10]_i_1_n_0 ),
        .Q(TIM_EVN[10]));
  FDCE \TIM_EVN_reg[11] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[11]_i_1_n_0 ),
        .Q(TIM_EVN[11]));
  FDCE \TIM_EVN_reg[12] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[12]_i_1_n_0 ),
        .Q(TIM_EVN[12]));
  FDCE \TIM_EVN_reg[13] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[13]_i_1_n_0 ),
        .Q(TIM_EVN[13]));
  FDCE \TIM_EVN_reg[14] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[14]_i_1_n_0 ),
        .Q(TIM_EVN[14]));
  FDCE \TIM_EVN_reg[15] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[15]_i_1_n_0 ),
        .Q(TIM_EVN[15]));
  FDCE \TIM_EVN_reg[16] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[16]_i_1_n_0 ),
        .Q(TIM_EVN[16]));
  FDCE \TIM_EVN_reg[17] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[17]_i_1_n_0 ),
        .Q(TIM_EVN[17]));
  FDCE \TIM_EVN_reg[18] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[18]_i_1_n_0 ),
        .Q(TIM_EVN[18]));
  FDCE \TIM_EVN_reg[19] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[19]_i_1_n_0 ),
        .Q(TIM_EVN[19]));
  FDCE \TIM_EVN_reg[1] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[1]_i_1_n_0 ),
        .Q(TIM_EVN[1]));
  FDCE \TIM_EVN_reg[20] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[20]_i_1_n_0 ),
        .Q(TIM_EVN[20]));
  FDCE \TIM_EVN_reg[21] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[21]_i_1_n_0 ),
        .Q(TIM_EVN[21]));
  FDCE \TIM_EVN_reg[22] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[22]_i_1_n_0 ),
        .Q(TIM_EVN[22]));
  FDCE \TIM_EVN_reg[23] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[23]_i_1_n_0 ),
        .Q(TIM_EVN[23]));
  FDCE \TIM_EVN_reg[24] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[24]_i_1_n_0 ),
        .Q(TIM_EVN[24]));
  FDCE \TIM_EVN_reg[25] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[25]_i_1_n_0 ),
        .Q(TIM_EVN[25]));
  FDCE \TIM_EVN_reg[26] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[26]_i_1_n_0 ),
        .Q(TIM_EVN[26]));
  FDCE \TIM_EVN_reg[27] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[27]_i_1_n_0 ),
        .Q(TIM_EVN[27]));
  FDCE \TIM_EVN_reg[28] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[28]_i_1_n_0 ),
        .Q(TIM_EVN[28]));
  FDCE \TIM_EVN_reg[29] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[29]_i_1_n_0 ),
        .Q(TIM_EVN[29]));
  FDCE \TIM_EVN_reg[2] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[2]_i_1_n_0 ),
        .Q(TIM_EVN[2]));
  FDCE \TIM_EVN_reg[30] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[30]_i_1_n_0 ),
        .Q(TIM_EVN[30]));
  FDCE \TIM_EVN_reg[31] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[31]_i_2_n_0 ),
        .Q(TIM_EVN[31]));
  FDCE \TIM_EVN_reg[3] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[3]_i_1_n_0 ),
        .Q(TIM_EVN[3]));
  FDCE \TIM_EVN_reg[4] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[4]_i_1_n_0 ),
        .Q(TIM_EVN[4]));
  FDCE \TIM_EVN_reg[5] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[5]_i_1_n_0 ),
        .Q(TIM_EVN[5]));
  FDCE \TIM_EVN_reg[6] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[6]_i_1_n_0 ),
        .Q(TIM_EVN[6]));
  FDCE \TIM_EVN_reg[7] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[7]_i_1_n_0 ),
        .Q(TIM_EVN[7]));
  FDCE \TIM_EVN_reg[8] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[8]_i_1_n_0 ),
        .Q(TIM_EVN[8]));
  FDCE \TIM_EVN_reg[9] 
       (.C(clk_i),
        .CE(\TIM_EVN[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_EVN[9]_i_1_n_0 ),
        .Q(TIM_EVN[9]));
  LUT4 #(
    .INIT(16'h0400)) 
    \TIM_MOD[31]_i_1 
       (.I0(awaddr[2]),
        .I1(awaddr[4]),
        .I2(awaddr[3]),
        .I3(\TIM_CLR[31]_i_3_n_0 ),
        .O(TIM_MOD));
  FDCE \TIM_MOD_reg[0] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[0]),
        .Q(\TIM_MOD_reg_n_0_[0] ));
  FDCE \TIM_MOD_reg[10] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[10]),
        .Q(\TIM_MOD_reg_n_0_[10] ));
  FDCE \TIM_MOD_reg[11] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[11]),
        .Q(\TIM_MOD_reg_n_0_[11] ));
  FDCE \TIM_MOD_reg[12] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[12]),
        .Q(\TIM_MOD_reg_n_0_[12] ));
  FDCE \TIM_MOD_reg[13] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[13]),
        .Q(\TIM_MOD_reg_n_0_[13] ));
  FDCE \TIM_MOD_reg[14] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[14]),
        .Q(\TIM_MOD_reg_n_0_[14] ));
  FDCE \TIM_MOD_reg[15] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[15]),
        .Q(\TIM_MOD_reg_n_0_[15] ));
  FDCE \TIM_MOD_reg[16] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[16]),
        .Q(\TIM_MOD_reg_n_0_[16] ));
  FDCE \TIM_MOD_reg[17] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[17]),
        .Q(\TIM_MOD_reg_n_0_[17] ));
  FDCE \TIM_MOD_reg[18] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[18]),
        .Q(\TIM_MOD_reg_n_0_[18] ));
  FDCE \TIM_MOD_reg[19] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[19]),
        .Q(\TIM_MOD_reg_n_0_[19] ));
  FDCE \TIM_MOD_reg[1] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[1]),
        .Q(\TIM_MOD_reg_n_0_[1] ));
  FDCE \TIM_MOD_reg[20] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[20]),
        .Q(\TIM_MOD_reg_n_0_[20] ));
  FDCE \TIM_MOD_reg[21] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[21]),
        .Q(\TIM_MOD_reg_n_0_[21] ));
  FDCE \TIM_MOD_reg[22] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[22]),
        .Q(\TIM_MOD_reg_n_0_[22] ));
  FDCE \TIM_MOD_reg[23] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[23]),
        .Q(\TIM_MOD_reg_n_0_[23] ));
  FDCE \TIM_MOD_reg[24] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[24]),
        .Q(\TIM_MOD_reg_n_0_[24] ));
  FDCE \TIM_MOD_reg[25] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[25]),
        .Q(\TIM_MOD_reg_n_0_[25] ));
  FDCE \TIM_MOD_reg[26] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[26]),
        .Q(\TIM_MOD_reg_n_0_[26] ));
  FDCE \TIM_MOD_reg[27] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[27]),
        .Q(\TIM_MOD_reg_n_0_[27] ));
  FDCE \TIM_MOD_reg[28] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[28]),
        .Q(\TIM_MOD_reg_n_0_[28] ));
  FDCE \TIM_MOD_reg[29] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[29]),
        .Q(\TIM_MOD_reg_n_0_[29] ));
  FDCE \TIM_MOD_reg[2] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[2]),
        .Q(\TIM_MOD_reg_n_0_[2] ));
  FDCE \TIM_MOD_reg[30] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[30]),
        .Q(\TIM_MOD_reg_n_0_[30] ));
  FDCE \TIM_MOD_reg[31] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[31]),
        .Q(\TIM_MOD_reg_n_0_[31] ));
  FDCE \TIM_MOD_reg[3] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[3]),
        .Q(\TIM_MOD_reg_n_0_[3] ));
  FDCE \TIM_MOD_reg[4] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[4]),
        .Q(\TIM_MOD_reg_n_0_[4] ));
  FDCE \TIM_MOD_reg[5] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[5]),
        .Q(\TIM_MOD_reg_n_0_[5] ));
  FDCE \TIM_MOD_reg[6] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[6]),
        .Q(\TIM_MOD_reg_n_0_[6] ));
  FDCE \TIM_MOD_reg[7] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[7]),
        .Q(\TIM_MOD_reg_n_0_[7] ));
  FDCE \TIM_MOD_reg[8] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[8]),
        .Q(\TIM_MOD_reg_n_0_[8] ));
  FDCE \TIM_MOD_reg[9] 
       (.C(clk_i),
        .CE(TIM_MOD),
        .CLR(wready_i_2_n_0),
        .D(wdata[9]),
        .Q(\TIM_MOD_reg_n_0_[9] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_PRE0_carry
       (.CI(1'b0),
        .CO({TIM_PRE0_carry_n_0,TIM_PRE0_carry_n_1,TIM_PRE0_carry_n_2,TIM_PRE0_carry_n_3}),
        .CYINIT(TIM_PRE[0]),
        .DI(TIM_PRE[4:1]),
        .O(data1[4:1]),
        .S({TIM_PRE0_carry_i_1_n_0,TIM_PRE0_carry_i_2_n_0,TIM_PRE0_carry_i_3_n_0,TIM_PRE0_carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_PRE0_carry__0
       (.CI(TIM_PRE0_carry_n_0),
        .CO({TIM_PRE0_carry__0_n_0,TIM_PRE0_carry__0_n_1,TIM_PRE0_carry__0_n_2,TIM_PRE0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(TIM_PRE[8:5]),
        .O(data1[8:5]),
        .S({TIM_PRE0_carry__0_i_1_n_0,TIM_PRE0_carry__0_i_2_n_0,TIM_PRE0_carry__0_i_3_n_0,TIM_PRE0_carry__0_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__0_i_1
       (.I0(TIM_PRE[8]),
        .O(TIM_PRE0_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__0_i_2
       (.I0(TIM_PRE[7]),
        .O(TIM_PRE0_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__0_i_3
       (.I0(TIM_PRE[6]),
        .O(TIM_PRE0_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__0_i_4
       (.I0(TIM_PRE[5]),
        .O(TIM_PRE0_carry__0_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_PRE0_carry__1
       (.CI(TIM_PRE0_carry__0_n_0),
        .CO({TIM_PRE0_carry__1_n_0,TIM_PRE0_carry__1_n_1,TIM_PRE0_carry__1_n_2,TIM_PRE0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(TIM_PRE[12:9]),
        .O(data1[12:9]),
        .S({TIM_PRE0_carry__1_i_1_n_0,TIM_PRE0_carry__1_i_2_n_0,TIM_PRE0_carry__1_i_3_n_0,TIM_PRE0_carry__1_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__1_i_1
       (.I0(TIM_PRE[12]),
        .O(TIM_PRE0_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__1_i_2
       (.I0(TIM_PRE[11]),
        .O(TIM_PRE0_carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__1_i_3
       (.I0(TIM_PRE[10]),
        .O(TIM_PRE0_carry__1_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__1_i_4
       (.I0(TIM_PRE[9]),
        .O(TIM_PRE0_carry__1_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_PRE0_carry__2
       (.CI(TIM_PRE0_carry__1_n_0),
        .CO({TIM_PRE0_carry__2_n_0,TIM_PRE0_carry__2_n_1,TIM_PRE0_carry__2_n_2,TIM_PRE0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI(TIM_PRE[16:13]),
        .O(data1[16:13]),
        .S({TIM_PRE0_carry__2_i_1_n_0,TIM_PRE0_carry__2_i_2_n_0,TIM_PRE0_carry__2_i_3_n_0,TIM_PRE0_carry__2_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__2_i_1
       (.I0(TIM_PRE[16]),
        .O(TIM_PRE0_carry__2_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__2_i_2
       (.I0(TIM_PRE[15]),
        .O(TIM_PRE0_carry__2_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__2_i_3
       (.I0(TIM_PRE[14]),
        .O(TIM_PRE0_carry__2_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__2_i_4
       (.I0(TIM_PRE[13]),
        .O(TIM_PRE0_carry__2_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_PRE0_carry__3
       (.CI(TIM_PRE0_carry__2_n_0),
        .CO({TIM_PRE0_carry__3_n_0,TIM_PRE0_carry__3_n_1,TIM_PRE0_carry__3_n_2,TIM_PRE0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI(TIM_PRE[20:17]),
        .O(data1[20:17]),
        .S({TIM_PRE0_carry__3_i_1_n_0,TIM_PRE0_carry__3_i_2_n_0,TIM_PRE0_carry__3_i_3_n_0,TIM_PRE0_carry__3_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__3_i_1
       (.I0(TIM_PRE[20]),
        .O(TIM_PRE0_carry__3_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__3_i_2
       (.I0(TIM_PRE[19]),
        .O(TIM_PRE0_carry__3_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__3_i_3
       (.I0(TIM_PRE[18]),
        .O(TIM_PRE0_carry__3_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__3_i_4
       (.I0(TIM_PRE[17]),
        .O(TIM_PRE0_carry__3_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_PRE0_carry__4
       (.CI(TIM_PRE0_carry__3_n_0),
        .CO({TIM_PRE0_carry__4_n_0,TIM_PRE0_carry__4_n_1,TIM_PRE0_carry__4_n_2,TIM_PRE0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI(TIM_PRE[24:21]),
        .O(data1[24:21]),
        .S({TIM_PRE0_carry__4_i_1_n_0,TIM_PRE0_carry__4_i_2_n_0,TIM_PRE0_carry__4_i_3_n_0,TIM_PRE0_carry__4_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__4_i_1
       (.I0(TIM_PRE[24]),
        .O(TIM_PRE0_carry__4_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__4_i_2
       (.I0(TIM_PRE[23]),
        .O(TIM_PRE0_carry__4_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__4_i_3
       (.I0(TIM_PRE[22]),
        .O(TIM_PRE0_carry__4_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__4_i_4
       (.I0(TIM_PRE[21]),
        .O(TIM_PRE0_carry__4_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_PRE0_carry__5
       (.CI(TIM_PRE0_carry__4_n_0),
        .CO({TIM_PRE0_carry__5_n_0,TIM_PRE0_carry__5_n_1,TIM_PRE0_carry__5_n_2,TIM_PRE0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI(TIM_PRE[28:25]),
        .O(data1[28:25]),
        .S({TIM_PRE0_carry__5_i_1_n_0,TIM_PRE0_carry__5_i_2_n_0,TIM_PRE0_carry__5_i_3_n_0,TIM_PRE0_carry__5_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__5_i_1
       (.I0(TIM_PRE[28]),
        .O(TIM_PRE0_carry__5_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__5_i_2
       (.I0(TIM_PRE[27]),
        .O(TIM_PRE0_carry__5_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__5_i_3
       (.I0(TIM_PRE[26]),
        .O(TIM_PRE0_carry__5_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__5_i_4
       (.I0(TIM_PRE[25]),
        .O(TIM_PRE0_carry__5_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 TIM_PRE0_carry__6
       (.CI(TIM_PRE0_carry__5_n_0),
        .CO({NLW_TIM_PRE0_carry__6_CO_UNCONNECTED[3:2],TIM_PRE0_carry__6_n_2,TIM_PRE0_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,TIM_PRE[30:29]}),
        .O({NLW_TIM_PRE0_carry__6_O_UNCONNECTED[3],data1[31:29]}),
        .S({1'b0,TIM_PRE0_carry__6_i_1_n_0,TIM_PRE0_carry__6_i_2_n_0,TIM_PRE0_carry__6_i_3_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__6_i_1
       (.I0(TIM_PRE[31]),
        .O(TIM_PRE0_carry__6_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__6_i_2
       (.I0(TIM_PRE[30]),
        .O(TIM_PRE0_carry__6_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry__6_i_3
       (.I0(TIM_PRE[29]),
        .O(TIM_PRE0_carry__6_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry_i_1
       (.I0(TIM_PRE[4]),
        .O(TIM_PRE0_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry_i_2
       (.I0(TIM_PRE[3]),
        .O(TIM_PRE0_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry_i_3
       (.I0(TIM_PRE[2]),
        .O(TIM_PRE0_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    TIM_PRE0_carry_i_4
       (.I0(TIM_PRE[1]),
        .O(TIM_PRE0_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'hA8AB)) 
    \TIM_PRE[0]_i_1 
       (.I0(TIM_PRE_m[0]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(TIM_PRE[0]),
        .O(\TIM_PRE[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[10]_i_1 
       (.I0(TIM_PRE_m[10]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[10]),
        .O(\TIM_PRE[10]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[11]_i_1 
       (.I0(TIM_PRE_m[11]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[11]),
        .O(\TIM_PRE[11]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[12]_i_1 
       (.I0(TIM_PRE_m[12]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[12]),
        .O(\TIM_PRE[12]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[13]_i_1 
       (.I0(TIM_PRE_m[13]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[13]),
        .O(\TIM_PRE[13]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[14]_i_1 
       (.I0(TIM_PRE_m[14]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[14]),
        .O(\TIM_PRE[14]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[15]_i_1 
       (.I0(TIM_PRE_m[15]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[15]),
        .O(\TIM_PRE[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[16]_i_1 
       (.I0(TIM_PRE_m[16]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[16]),
        .O(\TIM_PRE[16]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[17]_i_1 
       (.I0(TIM_PRE_m[17]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[17]),
        .O(\TIM_PRE[17]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[18]_i_1 
       (.I0(TIM_PRE_m[18]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[18]),
        .O(\TIM_PRE[18]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[19]_i_1 
       (.I0(TIM_PRE_m[19]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[19]),
        .O(\TIM_PRE[19]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[1]_i_1 
       (.I0(TIM_PRE_m[1]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[1]),
        .O(\TIM_PRE[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[20]_i_1 
       (.I0(TIM_PRE_m[20]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[20]),
        .O(\TIM_PRE[20]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[21]_i_1 
       (.I0(TIM_PRE_m[21]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[21]),
        .O(\TIM_PRE[21]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[22]_i_1 
       (.I0(TIM_PRE_m[22]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[22]),
        .O(\TIM_PRE[22]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[23]_i_1 
       (.I0(TIM_PRE_m[23]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[23]),
        .O(\TIM_PRE[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[24]_i_1 
       (.I0(TIM_PRE_m[24]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[24]),
        .O(\TIM_PRE[24]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[25]_i_1 
       (.I0(TIM_PRE_m[25]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[25]),
        .O(\TIM_PRE[25]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[26]_i_1 
       (.I0(TIM_PRE_m[26]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[26]),
        .O(\TIM_PRE[26]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[27]_i_1 
       (.I0(TIM_PRE_m[27]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[27]),
        .O(\TIM_PRE[27]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[28]_i_1 
       (.I0(TIM_PRE_m[28]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[28]),
        .O(\TIM_PRE[28]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[29]_i_1 
       (.I0(TIM_PRE_m[29]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[29]),
        .O(\TIM_PRE[29]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[2]_i_1 
       (.I0(TIM_PRE_m[2]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[2]),
        .O(\TIM_PRE[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[30]_i_1 
       (.I0(TIM_PRE_m[30]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[30]),
        .O(\TIM_PRE[30]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \TIM_PRE[31]_i_1 
       (.I0(\TIM_CLR_reg_n_0_[0] ),
        .I1(p_3_in),
        .O(\TIM_PRE[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \TIM_PRE[31]_i_10 
       (.I0(TIM_PRE[11]),
        .I1(TIM_PRE[10]),
        .I2(TIM_PRE[9]),
        .I3(TIM_PRE[8]),
        .O(\TIM_PRE[31]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[31]_i_2 
       (.I0(TIM_PRE_m[31]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[31]),
        .O(\TIM_PRE[31]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0008)) 
    \TIM_PRE[31]_i_3 
       (.I0(\TIM_PRE[31]_i_4_n_0 ),
        .I1(\TIM_PRE[31]_i_5_n_0 ),
        .I2(\TIM_PRE[31]_i_6_n_0 ),
        .I3(\TIM_PRE[31]_i_7_n_0 ),
        .O(\TIM_PRE[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \TIM_PRE[31]_i_4 
       (.I0(\TIM_CNT[31]_i_5_n_0 ),
        .I1(TIM_PRE[24]),
        .I2(TIM_PRE[25]),
        .I3(TIM_PRE[26]),
        .I4(TIM_PRE[27]),
        .O(\TIM_PRE[31]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \TIM_PRE[31]_i_5 
       (.I0(TIM_PRE[18]),
        .I1(TIM_PRE[19]),
        .I2(TIM_PRE[16]),
        .I3(TIM_PRE[17]),
        .I4(\TIM_PRE[31]_i_8_n_0 ),
        .O(\TIM_PRE[31]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \TIM_PRE[31]_i_6 
       (.I0(TIM_PRE[6]),
        .I1(TIM_PRE[7]),
        .I2(TIM_PRE[4]),
        .I3(TIM_PRE[5]),
        .I4(\TIM_PRE[31]_i_9_n_0 ),
        .O(\TIM_PRE[31]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \TIM_PRE[31]_i_7 
       (.I0(TIM_PRE[12]),
        .I1(TIM_PRE[13]),
        .I2(TIM_PRE[14]),
        .I3(TIM_PRE[15]),
        .I4(\TIM_PRE[31]_i_10_n_0 ),
        .O(\TIM_PRE[31]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \TIM_PRE[31]_i_8 
       (.I0(TIM_PRE[23]),
        .I1(TIM_PRE[22]),
        .I2(TIM_PRE[21]),
        .I3(TIM_PRE[20]),
        .O(\TIM_PRE[31]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \TIM_PRE[31]_i_9 
       (.I0(TIM_PRE[3]),
        .I1(TIM_PRE[2]),
        .I2(TIM_PRE[1]),
        .I3(TIM_PRE[0]),
        .O(\TIM_PRE[31]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[3]_i_1 
       (.I0(TIM_PRE_m[3]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[3]),
        .O(\TIM_PRE[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[4]_i_1 
       (.I0(TIM_PRE_m[4]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[4]),
        .O(\TIM_PRE[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[5]_i_1 
       (.I0(TIM_PRE_m[5]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[5]),
        .O(\TIM_PRE[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[6]_i_1 
       (.I0(TIM_PRE_m[6]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[6]),
        .O(\TIM_PRE[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[7]_i_1 
       (.I0(TIM_PRE_m[7]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[7]),
        .O(\TIM_PRE[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[8]_i_1 
       (.I0(TIM_PRE_m[8]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[8]),
        .O(\TIM_PRE[8]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hABA8)) 
    \TIM_PRE[9]_i_1 
       (.I0(TIM_PRE_m[9]),
        .I1(\TIM_PRE[31]_i_3_n_0 ),
        .I2(\TIM_CLR_reg_n_0_[0] ),
        .I3(data1[9]),
        .O(\TIM_PRE[9]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0002)) 
    \TIM_PRE_m[31]_i_1 
       (.I0(\TIM_CLR[31]_i_3_n_0 ),
        .I1(awaddr[4]),
        .I2(awaddr[3]),
        .I3(awaddr[2]),
        .O(TIM_PRE_m_0));
  FDCE \TIM_PRE_m_reg[0] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[0]),
        .Q(TIM_PRE_m[0]));
  FDCE \TIM_PRE_m_reg[10] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[10]),
        .Q(TIM_PRE_m[10]));
  FDCE \TIM_PRE_m_reg[11] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[11]),
        .Q(TIM_PRE_m[11]));
  FDCE \TIM_PRE_m_reg[12] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[12]),
        .Q(TIM_PRE_m[12]));
  FDCE \TIM_PRE_m_reg[13] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[13]),
        .Q(TIM_PRE_m[13]));
  FDCE \TIM_PRE_m_reg[14] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[14]),
        .Q(TIM_PRE_m[14]));
  FDCE \TIM_PRE_m_reg[15] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[15]),
        .Q(TIM_PRE_m[15]));
  FDCE \TIM_PRE_m_reg[16] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[16]),
        .Q(TIM_PRE_m[16]));
  FDCE \TIM_PRE_m_reg[17] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[17]),
        .Q(TIM_PRE_m[17]));
  FDCE \TIM_PRE_m_reg[18] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[18]),
        .Q(TIM_PRE_m[18]));
  FDCE \TIM_PRE_m_reg[19] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[19]),
        .Q(TIM_PRE_m[19]));
  FDCE \TIM_PRE_m_reg[1] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[1]),
        .Q(TIM_PRE_m[1]));
  FDCE \TIM_PRE_m_reg[20] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[20]),
        .Q(TIM_PRE_m[20]));
  FDCE \TIM_PRE_m_reg[21] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[21]),
        .Q(TIM_PRE_m[21]));
  FDCE \TIM_PRE_m_reg[22] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[22]),
        .Q(TIM_PRE_m[22]));
  FDCE \TIM_PRE_m_reg[23] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[23]),
        .Q(TIM_PRE_m[23]));
  FDCE \TIM_PRE_m_reg[24] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[24]),
        .Q(TIM_PRE_m[24]));
  FDCE \TIM_PRE_m_reg[25] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[25]),
        .Q(TIM_PRE_m[25]));
  FDCE \TIM_PRE_m_reg[26] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[26]),
        .Q(TIM_PRE_m[26]));
  FDCE \TIM_PRE_m_reg[27] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[27]),
        .Q(TIM_PRE_m[27]));
  FDCE \TIM_PRE_m_reg[28] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[28]),
        .Q(TIM_PRE_m[28]));
  FDCE \TIM_PRE_m_reg[29] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[29]),
        .Q(TIM_PRE_m[29]));
  FDCE \TIM_PRE_m_reg[2] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[2]),
        .Q(TIM_PRE_m[2]));
  FDCE \TIM_PRE_m_reg[30] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[30]),
        .Q(TIM_PRE_m[30]));
  FDCE \TIM_PRE_m_reg[31] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[31]),
        .Q(TIM_PRE_m[31]));
  FDCE \TIM_PRE_m_reg[3] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[3]),
        .Q(TIM_PRE_m[3]));
  FDCE \TIM_PRE_m_reg[4] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[4]),
        .Q(TIM_PRE_m[4]));
  FDCE \TIM_PRE_m_reg[5] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[5]),
        .Q(TIM_PRE_m[5]));
  FDCE \TIM_PRE_m_reg[6] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[6]),
        .Q(TIM_PRE_m[6]));
  FDCE \TIM_PRE_m_reg[7] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[7]),
        .Q(TIM_PRE_m[7]));
  FDCE \TIM_PRE_m_reg[8] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[8]),
        .Q(TIM_PRE_m[8]));
  FDCE \TIM_PRE_m_reg[9] 
       (.C(clk_i),
        .CE(TIM_PRE_m_0),
        .CLR(wready_i_2_n_0),
        .D(wdata[9]),
        .Q(TIM_PRE_m[9]));
  FDCE \TIM_PRE_reg[0] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[0]_i_1_n_0 ),
        .Q(TIM_PRE[0]));
  FDCE \TIM_PRE_reg[10] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[10]_i_1_n_0 ),
        .Q(TIM_PRE[10]));
  FDCE \TIM_PRE_reg[11] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[11]_i_1_n_0 ),
        .Q(TIM_PRE[11]));
  FDCE \TIM_PRE_reg[12] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[12]_i_1_n_0 ),
        .Q(TIM_PRE[12]));
  FDCE \TIM_PRE_reg[13] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[13]_i_1_n_0 ),
        .Q(TIM_PRE[13]));
  FDCE \TIM_PRE_reg[14] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[14]_i_1_n_0 ),
        .Q(TIM_PRE[14]));
  FDCE \TIM_PRE_reg[15] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[15]_i_1_n_0 ),
        .Q(TIM_PRE[15]));
  FDCE \TIM_PRE_reg[16] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[16]_i_1_n_0 ),
        .Q(TIM_PRE[16]));
  FDCE \TIM_PRE_reg[17] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[17]_i_1_n_0 ),
        .Q(TIM_PRE[17]));
  FDCE \TIM_PRE_reg[18] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[18]_i_1_n_0 ),
        .Q(TIM_PRE[18]));
  FDCE \TIM_PRE_reg[19] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[19]_i_1_n_0 ),
        .Q(TIM_PRE[19]));
  FDCE \TIM_PRE_reg[1] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[1]_i_1_n_0 ),
        .Q(TIM_PRE[1]));
  FDCE \TIM_PRE_reg[20] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[20]_i_1_n_0 ),
        .Q(TIM_PRE[20]));
  FDCE \TIM_PRE_reg[21] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[21]_i_1_n_0 ),
        .Q(TIM_PRE[21]));
  FDCE \TIM_PRE_reg[22] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[22]_i_1_n_0 ),
        .Q(TIM_PRE[22]));
  FDCE \TIM_PRE_reg[23] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[23]_i_1_n_0 ),
        .Q(TIM_PRE[23]));
  FDCE \TIM_PRE_reg[24] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[24]_i_1_n_0 ),
        .Q(TIM_PRE[24]));
  FDCE \TIM_PRE_reg[25] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[25]_i_1_n_0 ),
        .Q(TIM_PRE[25]));
  FDCE \TIM_PRE_reg[26] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[26]_i_1_n_0 ),
        .Q(TIM_PRE[26]));
  FDCE \TIM_PRE_reg[27] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[27]_i_1_n_0 ),
        .Q(TIM_PRE[27]));
  FDCE \TIM_PRE_reg[28] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[28]_i_1_n_0 ),
        .Q(TIM_PRE[28]));
  FDCE \TIM_PRE_reg[29] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[29]_i_1_n_0 ),
        .Q(TIM_PRE[29]));
  FDCE \TIM_PRE_reg[2] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[2]_i_1_n_0 ),
        .Q(TIM_PRE[2]));
  FDCE \TIM_PRE_reg[30] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[30]_i_1_n_0 ),
        .Q(TIM_PRE[30]));
  FDCE \TIM_PRE_reg[31] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[31]_i_2_n_0 ),
        .Q(TIM_PRE[31]));
  FDCE \TIM_PRE_reg[3] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[3]_i_1_n_0 ),
        .Q(TIM_PRE[3]));
  FDCE \TIM_PRE_reg[4] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[4]_i_1_n_0 ),
        .Q(TIM_PRE[4]));
  FDCE \TIM_PRE_reg[5] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[5]_i_1_n_0 ),
        .Q(TIM_PRE[5]));
  FDCE \TIM_PRE_reg[6] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[6]_i_1_n_0 ),
        .Q(TIM_PRE[6]));
  FDCE \TIM_PRE_reg[7] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[7]_i_1_n_0 ),
        .Q(TIM_PRE[7]));
  FDCE \TIM_PRE_reg[8] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[8]_i_1_n_0 ),
        .Q(TIM_PRE[8]));
  FDCE \TIM_PRE_reg[9] 
       (.C(clk_i),
        .CE(\TIM_PRE[31]_i_1_n_0 ),
        .CLR(wready_i_2_n_0),
        .D(\TIM_PRE[9]_i_1_n_0 ),
        .Q(TIM_PRE[9]));
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
        .PRE(wready_i_2_n_0),
        .Q(arready));
  LUT4 #(
    .INIT(16'hF444)) 
    bvalid_i_1
       (.I0(bready),
        .I1(bvalid),
        .I2(wvalid),
        .I3(awvalid),
        .O(bvalid_i_1_n_0));
  FDCE bvalid_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(wready_i_2_n_0),
        .D(bvalid_i_1_n_0),
        .Q(bvalid));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_1
       (.I0(TIM_CNT[8]),
        .O(i__carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_2
       (.I0(TIM_CNT[7]),
        .O(i__carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_3
       (.I0(TIM_CNT[6]),
        .O(i__carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_4
       (.I0(TIM_CNT[5]),
        .O(i__carry__0_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__1_i_1
       (.I0(TIM_CNT[12]),
        .O(i__carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__1_i_2
       (.I0(TIM_CNT[11]),
        .O(i__carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__1_i_3
       (.I0(TIM_CNT[10]),
        .O(i__carry__1_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__1_i_4
       (.I0(TIM_CNT[9]),
        .O(i__carry__1_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__2_i_1
       (.I0(TIM_CNT[16]),
        .O(i__carry__2_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__2_i_2
       (.I0(TIM_CNT[15]),
        .O(i__carry__2_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__2_i_3
       (.I0(TIM_CNT[14]),
        .O(i__carry__2_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__2_i_4
       (.I0(TIM_CNT[13]),
        .O(i__carry__2_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__3_i_1
       (.I0(TIM_CNT[20]),
        .O(i__carry__3_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__3_i_2
       (.I0(TIM_CNT[19]),
        .O(i__carry__3_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__3_i_3
       (.I0(TIM_CNT[18]),
        .O(i__carry__3_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__3_i_4
       (.I0(TIM_CNT[17]),
        .O(i__carry__3_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__4_i_1
       (.I0(TIM_CNT[24]),
        .O(i__carry__4_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__4_i_2
       (.I0(TIM_CNT[23]),
        .O(i__carry__4_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__4_i_3
       (.I0(TIM_CNT[22]),
        .O(i__carry__4_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__4_i_4
       (.I0(TIM_CNT[21]),
        .O(i__carry__4_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__5_i_1
       (.I0(TIM_CNT[28]),
        .O(i__carry__5_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__5_i_2
       (.I0(TIM_CNT[27]),
        .O(i__carry__5_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__5_i_3
       (.I0(TIM_CNT[26]),
        .O(i__carry__5_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__5_i_4
       (.I0(TIM_CNT[25]),
        .O(i__carry__5_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__6_i_1
       (.I0(TIM_CNT[31]),
        .O(i__carry__6_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__6_i_2
       (.I0(TIM_CNT[30]),
        .O(i__carry__6_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__6_i_3
       (.I0(TIM_CNT[29]),
        .O(i__carry__6_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_1
       (.I0(TIM_CNT[4]),
        .O(i__carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_2
       (.I0(TIM_CNT[3]),
        .O(i__carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_3
       (.I0(TIM_CNT[2]),
        .O(i__carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_4
       (.I0(TIM_CNT[1]),
        .O(i__carry_i_4_n_0));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[0]_i_1 
       (.I0(\rdata[0]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[0]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[0]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[0]_i_2 
       (.I0(TIM_CNT[0]),
        .I1(p_2_in),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[0] ),
        .I5(TIM_EVN[0]),
        .O(\rdata[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[0]_i_3 
       (.I0(TIM_ARE[0]),
        .I1(p_3_in),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[0]),
        .I5(\TIM_CLR_reg_n_0_[0] ),
        .O(\rdata[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[10]_i_1 
       (.I0(\rdata[10]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[10]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[10]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[10]_i_2 
       (.I0(TIM_CNT[10]),
        .I1(\TIM_EVC_reg_n_0_[10] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[10] ),
        .I5(TIM_EVN[10]),
        .O(\rdata[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[10]_i_3 
       (.I0(TIM_ARE[10]),
        .I1(\TIM_ENA_reg_n_0_[10] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[10]),
        .I5(\TIM_CLR_reg_n_0_[10] ),
        .O(\rdata[10]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[11]_i_1 
       (.I0(\rdata[11]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[11]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[11]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[11]_i_2 
       (.I0(TIM_CNT[11]),
        .I1(\TIM_EVC_reg_n_0_[11] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[11] ),
        .I5(TIM_EVN[11]),
        .O(\rdata[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[11]_i_3 
       (.I0(TIM_ARE[11]),
        .I1(\TIM_ENA_reg_n_0_[11] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[11]),
        .I5(\TIM_CLR_reg_n_0_[11] ),
        .O(\rdata[11]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[12]_i_1 
       (.I0(\rdata[12]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[12]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[12]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[12]_i_2 
       (.I0(TIM_CNT[12]),
        .I1(\TIM_EVC_reg_n_0_[12] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[12] ),
        .I5(TIM_EVN[12]),
        .O(\rdata[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[12]_i_3 
       (.I0(TIM_ARE[12]),
        .I1(\TIM_ENA_reg_n_0_[12] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[12]),
        .I5(\TIM_CLR_reg_n_0_[12] ),
        .O(\rdata[12]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[13]_i_1 
       (.I0(\rdata[13]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[13]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[13]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[13]_i_2 
       (.I0(TIM_CNT[13]),
        .I1(\TIM_EVC_reg_n_0_[13] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[13] ),
        .I5(TIM_EVN[13]),
        .O(\rdata[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[13]_i_3 
       (.I0(TIM_ARE[13]),
        .I1(\TIM_ENA_reg_n_0_[13] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[13]),
        .I5(\TIM_CLR_reg_n_0_[13] ),
        .O(\rdata[13]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[14]_i_1 
       (.I0(\rdata[14]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[14]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[14]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[14]_i_2 
       (.I0(TIM_CNT[14]),
        .I1(\TIM_EVC_reg_n_0_[14] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[14] ),
        .I5(TIM_EVN[14]),
        .O(\rdata[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[14]_i_3 
       (.I0(TIM_ARE[14]),
        .I1(\TIM_ENA_reg_n_0_[14] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[14]),
        .I5(\TIM_CLR_reg_n_0_[14] ),
        .O(\rdata[14]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[15]_i_1 
       (.I0(\rdata[15]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[15]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[15]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[15]_i_2 
       (.I0(TIM_CNT[15]),
        .I1(\TIM_EVC_reg_n_0_[15] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[15] ),
        .I5(TIM_EVN[15]),
        .O(\rdata[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[15]_i_3 
       (.I0(TIM_ARE[15]),
        .I1(\TIM_ENA_reg_n_0_[15] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[15]),
        .I5(\TIM_CLR_reg_n_0_[15] ),
        .O(\rdata[15]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[16]_i_1 
       (.I0(\rdata[16]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[16]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[16]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[16]_i_2 
       (.I0(TIM_CNT[16]),
        .I1(\TIM_EVC_reg_n_0_[16] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[16] ),
        .I5(TIM_EVN[16]),
        .O(\rdata[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[16]_i_3 
       (.I0(TIM_ARE[16]),
        .I1(\TIM_ENA_reg_n_0_[16] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[16]),
        .I5(\TIM_CLR_reg_n_0_[16] ),
        .O(\rdata[16]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[17]_i_1 
       (.I0(\rdata[17]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[17]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[17]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[17]_i_2 
       (.I0(TIM_CNT[17]),
        .I1(\TIM_EVC_reg_n_0_[17] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[17] ),
        .I5(TIM_EVN[17]),
        .O(\rdata[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[17]_i_3 
       (.I0(TIM_ARE[17]),
        .I1(\TIM_ENA_reg_n_0_[17] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[17]),
        .I5(\TIM_CLR_reg_n_0_[17] ),
        .O(\rdata[17]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[18]_i_1 
       (.I0(\rdata[18]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[18]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[18]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[18]_i_2 
       (.I0(TIM_CNT[18]),
        .I1(\TIM_EVC_reg_n_0_[18] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[18] ),
        .I5(TIM_EVN[18]),
        .O(\rdata[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[18]_i_3 
       (.I0(TIM_ARE[18]),
        .I1(\TIM_ENA_reg_n_0_[18] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[18]),
        .I5(\TIM_CLR_reg_n_0_[18] ),
        .O(\rdata[18]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[19]_i_1 
       (.I0(\rdata[19]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[19]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[19]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[19]_i_2 
       (.I0(TIM_CNT[19]),
        .I1(\TIM_EVC_reg_n_0_[19] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[19] ),
        .I5(TIM_EVN[19]),
        .O(\rdata[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[19]_i_3 
       (.I0(TIM_ARE[19]),
        .I1(\TIM_ENA_reg_n_0_[19] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[19]),
        .I5(\TIM_CLR_reg_n_0_[19] ),
        .O(\rdata[19]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[1]_i_1 
       (.I0(\rdata[1]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[1]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[1]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[1]_i_2 
       (.I0(TIM_CNT[1]),
        .I1(\TIM_EVC_reg_n_0_[1] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[1] ),
        .I5(TIM_EVN[1]),
        .O(\rdata[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[1]_i_3 
       (.I0(TIM_ARE[1]),
        .I1(\TIM_ENA_reg_n_0_[1] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[1]),
        .I5(\TIM_CLR_reg_n_0_[1] ),
        .O(\rdata[1]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[20]_i_1 
       (.I0(\rdata[20]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[20]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[20]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[20]_i_2 
       (.I0(TIM_CNT[20]),
        .I1(\TIM_EVC_reg_n_0_[20] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[20] ),
        .I5(TIM_EVN[20]),
        .O(\rdata[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[20]_i_3 
       (.I0(TIM_ARE[20]),
        .I1(\TIM_ENA_reg_n_0_[20] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[20]),
        .I5(\TIM_CLR_reg_n_0_[20] ),
        .O(\rdata[20]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[21]_i_1 
       (.I0(\rdata[21]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[21]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[21]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[21]_i_2 
       (.I0(TIM_CNT[21]),
        .I1(\TIM_EVC_reg_n_0_[21] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[21] ),
        .I5(TIM_EVN[21]),
        .O(\rdata[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[21]_i_3 
       (.I0(TIM_ARE[21]),
        .I1(\TIM_ENA_reg_n_0_[21] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[21]),
        .I5(\TIM_CLR_reg_n_0_[21] ),
        .O(\rdata[21]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[22]_i_1 
       (.I0(\rdata[22]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[22]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[22]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[22]_i_2 
       (.I0(TIM_CNT[22]),
        .I1(\TIM_EVC_reg_n_0_[22] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[22] ),
        .I5(TIM_EVN[22]),
        .O(\rdata[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[22]_i_3 
       (.I0(TIM_ARE[22]),
        .I1(\TIM_ENA_reg_n_0_[22] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[22]),
        .I5(\TIM_CLR_reg_n_0_[22] ),
        .O(\rdata[22]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[23]_i_1 
       (.I0(\rdata[23]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[23]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[23]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[23]_i_2 
       (.I0(TIM_CNT[23]),
        .I1(\TIM_EVC_reg_n_0_[23] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[23] ),
        .I5(TIM_EVN[23]),
        .O(\rdata[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[23]_i_3 
       (.I0(TIM_ARE[23]),
        .I1(\TIM_ENA_reg_n_0_[23] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[23]),
        .I5(\TIM_CLR_reg_n_0_[23] ),
        .O(\rdata[23]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[24]_i_1 
       (.I0(\rdata[24]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[24]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[24]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[24]_i_2 
       (.I0(TIM_CNT[24]),
        .I1(\TIM_EVC_reg_n_0_[24] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[24] ),
        .I5(TIM_EVN[24]),
        .O(\rdata[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[24]_i_3 
       (.I0(TIM_ARE[24]),
        .I1(\TIM_ENA_reg_n_0_[24] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[24]),
        .I5(\TIM_CLR_reg_n_0_[24] ),
        .O(\rdata[24]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[25]_i_1 
       (.I0(\rdata[25]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[25]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[25]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[25]_i_2 
       (.I0(TIM_CNT[25]),
        .I1(\TIM_EVC_reg_n_0_[25] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[25] ),
        .I5(TIM_EVN[25]),
        .O(\rdata[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[25]_i_3 
       (.I0(TIM_ARE[25]),
        .I1(\TIM_ENA_reg_n_0_[25] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[25]),
        .I5(\TIM_CLR_reg_n_0_[25] ),
        .O(\rdata[25]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[26]_i_1 
       (.I0(\rdata[26]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[26]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[26]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[26]_i_2 
       (.I0(TIM_CNT[26]),
        .I1(\TIM_EVC_reg_n_0_[26] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[26] ),
        .I5(TIM_EVN[26]),
        .O(\rdata[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[26]_i_3 
       (.I0(TIM_ARE[26]),
        .I1(\TIM_ENA_reg_n_0_[26] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[26]),
        .I5(\TIM_CLR_reg_n_0_[26] ),
        .O(\rdata[26]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[27]_i_1 
       (.I0(\rdata[27]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[27]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[27]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[27]_i_2 
       (.I0(TIM_CNT[27]),
        .I1(\TIM_EVC_reg_n_0_[27] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[27] ),
        .I5(TIM_EVN[27]),
        .O(\rdata[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[27]_i_3 
       (.I0(TIM_ARE[27]),
        .I1(\TIM_ENA_reg_n_0_[27] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[27]),
        .I5(\TIM_CLR_reg_n_0_[27] ),
        .O(\rdata[27]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[28]_i_1 
       (.I0(\rdata[28]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[28]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[28]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[28]_i_2 
       (.I0(TIM_CNT[28]),
        .I1(\TIM_EVC_reg_n_0_[28] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[28] ),
        .I5(TIM_EVN[28]),
        .O(\rdata[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[28]_i_3 
       (.I0(TIM_ARE[28]),
        .I1(\TIM_ENA_reg_n_0_[28] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[28]),
        .I5(\TIM_CLR_reg_n_0_[28] ),
        .O(\rdata[28]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[29]_i_1 
       (.I0(\rdata[29]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[29]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[29]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[29]_i_2 
       (.I0(TIM_CNT[29]),
        .I1(\TIM_EVC_reg_n_0_[29] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[29] ),
        .I5(TIM_EVN[29]),
        .O(\rdata[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[29]_i_3 
       (.I0(TIM_ARE[29]),
        .I1(\TIM_ENA_reg_n_0_[29] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[29]),
        .I5(\TIM_CLR_reg_n_0_[29] ),
        .O(\rdata[29]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[2]_i_1 
       (.I0(\rdata[2]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[2]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[2]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[2]_i_2 
       (.I0(TIM_CNT[2]),
        .I1(\TIM_EVC_reg_n_0_[2] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[2] ),
        .I5(TIM_EVN[2]),
        .O(\rdata[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[2]_i_3 
       (.I0(TIM_ARE[2]),
        .I1(\TIM_ENA_reg_n_0_[2] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[2]),
        .I5(\TIM_CLR_reg_n_0_[2] ),
        .O(\rdata[2]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[30]_i_1 
       (.I0(\rdata[30]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[30]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[30]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[30]_i_2 
       (.I0(TIM_CNT[30]),
        .I1(\TIM_EVC_reg_n_0_[30] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[30] ),
        .I5(TIM_EVN[30]),
        .O(\rdata[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[30]_i_3 
       (.I0(TIM_ARE[30]),
        .I1(\TIM_ENA_reg_n_0_[30] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[30]),
        .I5(\TIM_CLR_reg_n_0_[30] ),
        .O(\rdata[30]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[31]_i_1 
       (.I0(\rdata[31]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[31]_i_4_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[31]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[31]_i_2 
       (.I0(TIM_CNT[31]),
        .I1(\TIM_EVC_reg_n_0_[31] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[31] ),
        .I5(TIM_EVN[31]),
        .O(\rdata[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \rdata[31]_i_3 
       (.I0(araddr[5]),
        .I1(araddr[6]),
        .I2(araddr[7]),
        .I3(araddr[1]),
        .I4(araddr[4]),
        .I5(araddr[0]),
        .O(\rdata[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[31]_i_4 
       (.I0(TIM_ARE[31]),
        .I1(\TIM_ENA_reg_n_0_[31] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[31]),
        .I5(\TIM_CLR_reg_n_0_[31] ),
        .O(\rdata[31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \rdata[31]_i_5 
       (.I0(araddr[5]),
        .I1(araddr[6]),
        .I2(araddr[7]),
        .I3(araddr[1]),
        .I4(araddr[4]),
        .I5(araddr[0]),
        .O(\rdata[31]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[3]_i_1 
       (.I0(\rdata[3]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[3]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[3]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[3]_i_2 
       (.I0(TIM_CNT[3]),
        .I1(\TIM_EVC_reg_n_0_[3] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[3] ),
        .I5(TIM_EVN[3]),
        .O(\rdata[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[3]_i_3 
       (.I0(TIM_ARE[3]),
        .I1(\TIM_ENA_reg_n_0_[3] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[3]),
        .I5(\TIM_CLR_reg_n_0_[3] ),
        .O(\rdata[3]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[4]_i_1 
       (.I0(\rdata[4]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[4]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[4]_i_2 
       (.I0(TIM_CNT[4]),
        .I1(\TIM_EVC_reg_n_0_[4] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[4] ),
        .I5(TIM_EVN[4]),
        .O(\rdata[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[4]_i_3 
       (.I0(TIM_ARE[4]),
        .I1(\TIM_ENA_reg_n_0_[4] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[4]),
        .I5(\TIM_CLR_reg_n_0_[4] ),
        .O(\rdata[4]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[5]_i_1 
       (.I0(\rdata[5]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[5]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[5]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[5]_i_2 
       (.I0(TIM_CNT[5]),
        .I1(\TIM_EVC_reg_n_0_[5] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[5] ),
        .I5(TIM_EVN[5]),
        .O(\rdata[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[5]_i_3 
       (.I0(TIM_ARE[5]),
        .I1(\TIM_ENA_reg_n_0_[5] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[5]),
        .I5(\TIM_CLR_reg_n_0_[5] ),
        .O(\rdata[5]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[6]_i_1 
       (.I0(\rdata[6]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[6]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[6]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[6]_i_2 
       (.I0(TIM_CNT[6]),
        .I1(\TIM_EVC_reg_n_0_[6] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[6] ),
        .I5(TIM_EVN[6]),
        .O(\rdata[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[6]_i_3 
       (.I0(TIM_ARE[6]),
        .I1(\TIM_ENA_reg_n_0_[6] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[6]),
        .I5(\TIM_CLR_reg_n_0_[6] ),
        .O(\rdata[6]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[7]_i_1 
       (.I0(\rdata[7]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[7]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[7]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[7]_i_2 
       (.I0(TIM_CNT[7]),
        .I1(\TIM_EVC_reg_n_0_[7] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[7] ),
        .I5(TIM_EVN[7]),
        .O(\rdata[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[7]_i_3 
       (.I0(TIM_ARE[7]),
        .I1(\TIM_ENA_reg_n_0_[7] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[7]),
        .I5(\TIM_CLR_reg_n_0_[7] ),
        .O(\rdata[7]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[8]_i_1 
       (.I0(\rdata[8]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[8]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[8]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[8]_i_2 
       (.I0(TIM_CNT[8]),
        .I1(\TIM_EVC_reg_n_0_[8] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[8] ),
        .I5(TIM_EVN[8]),
        .O(\rdata[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[8]_i_3 
       (.I0(TIM_ARE[8]),
        .I1(\TIM_ENA_reg_n_0_[8] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[8]),
        .I5(\TIM_CLR_reg_n_0_[8] ),
        .O(\rdata[8]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[9]_i_1 
       (.I0(\rdata[9]_i_2_n_0 ),
        .I1(\rdata[31]_i_3_n_0 ),
        .I2(\rdata[9]_i_3_n_0 ),
        .I3(\rdata[31]_i_5_n_0 ),
        .O(p_0_in[9]));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[9]_i_2 
       (.I0(TIM_CNT[9]),
        .I1(\TIM_EVC_reg_n_0_[9] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(\TIM_MOD_reg_n_0_[9] ),
        .I5(TIM_EVN[9]),
        .O(\rdata[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rdata[9]_i_3 
       (.I0(TIM_ARE[9]),
        .I1(\TIM_ENA_reg_n_0_[9] ),
        .I2(araddr[2]),
        .I3(araddr[3]),
        .I4(TIM_PRE_m[9]),
        .I5(\TIM_CLR_reg_n_0_[9] ),
        .O(\rdata[9]_i_3_n_0 ));
  FDCE \rdata_reg[0] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[0]),
        .Q(rdata[0]));
  FDCE \rdata_reg[10] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[10]),
        .Q(rdata[10]));
  FDCE \rdata_reg[11] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[11]),
        .Q(rdata[11]));
  FDCE \rdata_reg[12] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[12]),
        .Q(rdata[12]));
  FDCE \rdata_reg[13] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[13]),
        .Q(rdata[13]));
  FDCE \rdata_reg[14] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[14]),
        .Q(rdata[14]));
  FDCE \rdata_reg[15] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[15]),
        .Q(rdata[15]));
  FDCE \rdata_reg[16] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[16]),
        .Q(rdata[16]));
  FDCE \rdata_reg[17] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[17]),
        .Q(rdata[17]));
  FDCE \rdata_reg[18] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[18]),
        .Q(rdata[18]));
  FDCE \rdata_reg[19] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[19]),
        .Q(rdata[19]));
  FDCE \rdata_reg[1] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[1]),
        .Q(rdata[1]));
  FDCE \rdata_reg[20] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[20]),
        .Q(rdata[20]));
  FDCE \rdata_reg[21] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[21]),
        .Q(rdata[21]));
  FDCE \rdata_reg[22] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[22]),
        .Q(rdata[22]));
  FDCE \rdata_reg[23] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[23]),
        .Q(rdata[23]));
  FDCE \rdata_reg[24] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[24]),
        .Q(rdata[24]));
  FDCE \rdata_reg[25] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[25]),
        .Q(rdata[25]));
  FDCE \rdata_reg[26] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[26]),
        .Q(rdata[26]));
  FDCE \rdata_reg[27] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[27]),
        .Q(rdata[27]));
  FDCE \rdata_reg[28] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[28]),
        .Q(rdata[28]));
  FDCE \rdata_reg[29] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[29]),
        .Q(rdata[29]));
  FDCE \rdata_reg[2] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[2]),
        .Q(rdata[2]));
  FDCE \rdata_reg[30] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[30]),
        .Q(rdata[30]));
  FDCE \rdata_reg[31] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[31]),
        .Q(rdata[31]));
  FDCE \rdata_reg[3] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[3]),
        .Q(rdata[3]));
  FDCE \rdata_reg[4] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[4]),
        .Q(rdata[4]));
  FDCE \rdata_reg[5] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[5]),
        .Q(rdata[5]));
  FDCE \rdata_reg[6] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[6]),
        .Q(rdata[6]));
  FDCE \rdata_reg[7] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[7]),
        .Q(rdata[7]));
  FDCE \rdata_reg[8] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[8]),
        .Q(rdata[8]));
  FDCE \rdata_reg[9] 
       (.C(clk_i),
        .CE(arvalid),
        .CLR(wready_i_2_n_0),
        .D(p_0_in[9]),
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
        .CLR(wready_i_2_n_0),
        .D(rvalid_i_1_n_0),
        .Q(rvalid));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h0FFF0888)) 
    wready_i_1
       (.I0(bready),
        .I1(bvalid),
        .I2(wvalid),
        .I3(awvalid),
        .I4(wready),
        .O(wready_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    wready_i_2
       (.I0(rst_n),
        .O(wready_i_2_n_0));
  FDPE wready_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(wready_i_1_n_0),
        .PRE(wready_i_2_n_0),
        .Q(wready));
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
