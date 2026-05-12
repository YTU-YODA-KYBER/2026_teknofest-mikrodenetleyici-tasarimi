// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat May  9 17:15:06 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_I2C_Master_AXI4_Lite_0_0_sim_netlist.v
// Design      : design_1_I2C_Master_AXI4_Lite_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_I2C_Master_AXI4_Lite
   (I2C_SCL_reg_0,
    rdata,
    bvalid,
    awready,
    rvalid,
    arready,
    I2C_SDA,
    clk_i,
    wdata,
    rst_n,
    awaddr,
    wvalid,
    awvalid,
    araddr,
    arvalid,
    bready,
    rready);
  output I2C_SCL_reg_0;
  output [31:0]rdata;
  output bvalid;
  output awready;
  output rvalid;
  output arready;
  inout I2C_SDA;
  input clk_i;
  input [31:0]wdata;
  input rst_n;
  input [7:0]awaddr;
  input wvalid;
  input awvalid;
  input [7:0]araddr;
  input arvalid;
  input bready;
  input rready;

  wire [0:0]I2C_ADR;
  wire \I2C_ADR[31]_i_2_n_0 ;
  wire [31:0]I2C_ADR__0;
  wire \I2C_CFG[0]_i_1_n_0 ;
  wire \I2C_CFG[1]_i_1_n_0 ;
  wire \I2C_CFG[1]_i_2_n_0 ;
  wire \I2C_CFG[1]_i_3_n_0 ;
  wire \I2C_CFG[1]_i_4_n_0 ;
  wire \I2C_CFG[1]_i_5_n_0 ;
  wire \I2C_CFG[1]_i_6_n_0 ;
  wire \I2C_CFG[2]_i_1_n_0 ;
  wire \I2C_CFG[2]_i_2_n_0 ;
  wire \I2C_CFG[31]_i_1_n_0 ;
  wire \I2C_CFG[31]_i_2_n_0 ;
  wire \I2C_CFG[3]_i_1_n_0 ;
  wire \I2C_CFG[3]_i_2_n_0 ;
  wire \I2C_CFG[3]_i_3_n_0 ;
  wire \I2C_CFG[3]_i_4_n_0 ;
  wire \I2C_CFG[3]_i_5_n_0 ;
  wire \I2C_CFG[3]_i_6_n_0 ;
  wire \I2C_CFG[3]_i_7_n_0 ;
  wire [0:0]I2C_CFG_clr;
  wire \I2C_CFG_clr[0]_i_1_n_0 ;
  wire \I2C_CFG_clr[1]_i_1_n_0 ;
  wire \I2C_CFG_clr_reg_n_0_[0] ;
  wire \I2C_CFG_clr_reg_n_0_[1] ;
  wire \I2C_CFG_reg_n_0_[0] ;
  wire \I2C_CFG_reg_n_0_[10] ;
  wire \I2C_CFG_reg_n_0_[11] ;
  wire \I2C_CFG_reg_n_0_[12] ;
  wire \I2C_CFG_reg_n_0_[13] ;
  wire \I2C_CFG_reg_n_0_[14] ;
  wire \I2C_CFG_reg_n_0_[15] ;
  wire \I2C_CFG_reg_n_0_[16] ;
  wire \I2C_CFG_reg_n_0_[17] ;
  wire \I2C_CFG_reg_n_0_[18] ;
  wire \I2C_CFG_reg_n_0_[19] ;
  wire \I2C_CFG_reg_n_0_[1] ;
  wire \I2C_CFG_reg_n_0_[20] ;
  wire \I2C_CFG_reg_n_0_[21] ;
  wire \I2C_CFG_reg_n_0_[22] ;
  wire \I2C_CFG_reg_n_0_[23] ;
  wire \I2C_CFG_reg_n_0_[24] ;
  wire \I2C_CFG_reg_n_0_[25] ;
  wire \I2C_CFG_reg_n_0_[26] ;
  wire \I2C_CFG_reg_n_0_[27] ;
  wire \I2C_CFG_reg_n_0_[28] ;
  wire \I2C_CFG_reg_n_0_[29] ;
  wire \I2C_CFG_reg_n_0_[2] ;
  wire \I2C_CFG_reg_n_0_[30] ;
  wire \I2C_CFG_reg_n_0_[31] ;
  wire \I2C_CFG_reg_n_0_[3] ;
  wire \I2C_CFG_reg_n_0_[4] ;
  wire \I2C_CFG_reg_n_0_[5] ;
  wire \I2C_CFG_reg_n_0_[6] ;
  wire \I2C_CFG_reg_n_0_[7] ;
  wire \I2C_CFG_reg_n_0_[8] ;
  wire \I2C_CFG_reg_n_0_[9] ;
  wire [0:0]I2C_NBY;
  wire I2C_NBY1;
  wire \I2C_NBY[0]_i_1_n_0 ;
  wire \I2C_NBY[0]_i_2_n_0 ;
  wire \I2C_NBY[0]_i_3_n_0 ;
  wire \I2C_NBY[0]_i_4_n_0 ;
  wire \I2C_NBY[0]_i_5_n_0 ;
  wire \I2C_NBY[1]_i_1_n_0 ;
  wire \I2C_NBY[2]_i_10_n_0 ;
  wire \I2C_NBY[2]_i_1_n_0 ;
  wire \I2C_NBY[2]_i_2_n_0 ;
  wire \I2C_NBY[2]_i_3_n_0 ;
  wire \I2C_NBY[2]_i_4_n_0 ;
  wire \I2C_NBY[2]_i_6_n_0 ;
  wire \I2C_NBY[2]_i_7_n_0 ;
  wire \I2C_NBY[2]_i_8_n_0 ;
  wire \I2C_NBY[2]_i_9_n_0 ;
  wire \I2C_NBY_reg_n_0_[0] ;
  wire \I2C_NBY_reg_n_0_[1] ;
  wire \I2C_NBY_reg_n_0_[2] ;
  wire \I2C_RDR[15]_i_1_n_0 ;
  wire \I2C_RDR[15]_i_2_n_0 ;
  wire \I2C_RDR[23]_i_1_n_0 ;
  wire \I2C_RDR[23]_i_2_n_0 ;
  wire \I2C_RDR[23]_i_3_n_0 ;
  wire \I2C_RDR[31]_i_1_n_0 ;
  wire \I2C_RDR[31]_i_2_n_0 ;
  wire \I2C_RDR[31]_i_3_n_0 ;
  wire \I2C_RDR[31]_i_4_n_0 ;
  wire \I2C_RDR[7]_i_1_n_0 ;
  wire \I2C_RDR[7]_i_2_n_0 ;
  wire \I2C_RDR_reg_n_0_[0] ;
  wire \I2C_RDR_reg_n_0_[10] ;
  wire \I2C_RDR_reg_n_0_[11] ;
  wire \I2C_RDR_reg_n_0_[12] ;
  wire \I2C_RDR_reg_n_0_[13] ;
  wire \I2C_RDR_reg_n_0_[14] ;
  wire \I2C_RDR_reg_n_0_[15] ;
  wire \I2C_RDR_reg_n_0_[16] ;
  wire \I2C_RDR_reg_n_0_[17] ;
  wire \I2C_RDR_reg_n_0_[18] ;
  wire \I2C_RDR_reg_n_0_[19] ;
  wire \I2C_RDR_reg_n_0_[1] ;
  wire \I2C_RDR_reg_n_0_[20] ;
  wire \I2C_RDR_reg_n_0_[21] ;
  wire \I2C_RDR_reg_n_0_[22] ;
  wire \I2C_RDR_reg_n_0_[23] ;
  wire \I2C_RDR_reg_n_0_[24] ;
  wire \I2C_RDR_reg_n_0_[25] ;
  wire \I2C_RDR_reg_n_0_[26] ;
  wire \I2C_RDR_reg_n_0_[27] ;
  wire \I2C_RDR_reg_n_0_[28] ;
  wire \I2C_RDR_reg_n_0_[29] ;
  wire \I2C_RDR_reg_n_0_[2] ;
  wire \I2C_RDR_reg_n_0_[30] ;
  wire \I2C_RDR_reg_n_0_[31] ;
  wire \I2C_RDR_reg_n_0_[3] ;
  wire \I2C_RDR_reg_n_0_[4] ;
  wire \I2C_RDR_reg_n_0_[5] ;
  wire \I2C_RDR_reg_n_0_[6] ;
  wire \I2C_RDR_reg_n_0_[7] ;
  wire \I2C_RDR_reg_n_0_[8] ;
  wire \I2C_RDR_reg_n_0_[9] ;
  wire I2C_SCL_i_1_n_0;
  wire I2C_SCL_i_2_n_0;
  wire I2C_SCL_i_3_n_0;
  wire I2C_SCL_reg_0;
  wire I2C_SDA;
  wire I2C_SDA_INST_0_i_1_n_0;
  wire [0:0]I2C_TDR;
  wire \I2C_TDR_reg_n_0_[0] ;
  wire \I2C_TDR_reg_n_0_[1] ;
  wire \I2C_TDR_reg_n_0_[2] ;
  wire \I2C_TDR_reg_n_0_[3] ;
  wire \I2C_TDR_reg_n_0_[4] ;
  wire \I2C_TDR_reg_n_0_[5] ;
  wire \I2C_TDR_reg_n_0_[6] ;
  wire \I2C_TDR_reg_n_0_[7] ;
  wire [7:0]araddr;
  wire arready;
  wire arready_i_1_n_0;
  wire arvalid;
  wire [7:0]awaddr;
  wire awready;
  wire awready_i_1_n_0;
  wire awready_i_2_n_0;
  wire awready_i_3_n_0;
  wire awvalid;
  wire bready;
  wire bvalid;
  wire bvalid_i_1_n_0;
  wire byte_cnt1;
  wire \byte_cnt[0]_i_1_n_0 ;
  wire \byte_cnt[0]_i_2_n_0 ;
  wire \byte_cnt[0]_i_3_n_0 ;
  wire \byte_cnt[0]_i_4_n_0 ;
  wire \byte_cnt[0]_i_5_n_0 ;
  wire \byte_cnt[0]_i_6_n_0 ;
  wire \byte_cnt[0]_i_7_n_0 ;
  wire \byte_cnt[1]_i_1_n_0 ;
  wire \byte_cnt[1]_i_2_n_0 ;
  wire \byte_cnt[2]_i_1_n_0 ;
  wire \byte_cnt[2]_i_2_n_0 ;
  wire \byte_cnt[2]_i_3_n_0 ;
  wire \byte_cnt[2]_i_4_n_0 ;
  wire \byte_cnt[2]_i_5_n_0 ;
  wire \byte_cnt[2]_i_6_n_0 ;
  wire \byte_cnt[2]_i_7_n_0 ;
  wire \byte_cnt[2]_i_8_n_0 ;
  wire \byte_cnt_reg_n_0_[0] ;
  wire \byte_cnt_reg_n_0_[1] ;
  wire \byte_cnt_reg_n_0_[2] ;
  wire clk_i;
  wire \current_state[0]_i_1_n_0 ;
  wire \current_state[0]_i_2_n_0 ;
  wire \current_state[0]_i_3_n_0 ;
  wire \current_state[0]_i_4_n_0 ;
  wire \current_state[0]_i_5_n_0 ;
  wire \current_state[0]_i_6_n_0 ;
  wire \current_state[1]_i_1_n_0 ;
  wire \current_state[1]_i_2_n_0 ;
  wire \current_state[1]_i_3_n_0 ;
  wire \current_state[1]_i_4_n_0 ;
  wire \current_state[1]_i_5_n_0 ;
  wire \current_state[1]_i_6_n_0 ;
  wire \current_state[2]_i_10_n_0 ;
  wire \current_state[2]_i_11_n_0 ;
  wire \current_state[2]_i_1_n_0 ;
  wire \current_state[2]_i_2_n_0 ;
  wire \current_state[2]_i_3_n_0 ;
  wire \current_state[2]_i_4_n_0 ;
  wire \current_state[2]_i_5_n_0 ;
  wire \current_state[2]_i_6_n_0 ;
  wire \current_state[2]_i_7_n_0 ;
  wire \current_state[2]_i_8_n_0 ;
  wire \current_state[2]_i_9_n_0 ;
  wire \current_state_reg_n_0_[0] ;
  wire \current_state_reg_n_0_[1] ;
  wire \current_state_reg_n_0_[2] ;
  wire [7:0]data1;
  wire [7:0]data2;
  wire [7:0]data3;
  wire delay_i_1_n_0;
  wire delay_reg_n_0;
  wire \freq_div_cnt[0]_i_1_n_0 ;
  wire \freq_div_cnt[1]_i_1_n_0 ;
  wire \freq_div_cnt[2]_i_1_n_0 ;
  wire \freq_div_cnt[2]_i_2_n_0 ;
  wire \freq_div_cnt[3]_i_1_n_0 ;
  wire \freq_div_cnt[4]_i_1_n_0 ;
  wire \freq_div_cnt[5]_i_1_n_0 ;
  wire \freq_div_cnt[6]_i_1_n_0 ;
  wire \freq_div_cnt[6]_i_2_n_0 ;
  wire \freq_div_cnt_reg_n_0_[0] ;
  wire \freq_div_cnt_reg_n_0_[1] ;
  wire \freq_div_cnt_reg_n_0_[2] ;
  wire \freq_div_cnt_reg_n_0_[3] ;
  wire \freq_div_cnt_reg_n_0_[4] ;
  wire \freq_div_cnt_reg_n_0_[5] ;
  wire \freq_div_cnt_reg_n_0_[6] ;
  wire freq_div_en;
  wire freq_div_en_i_1_n_0;
  wire is_read_op19_out;
  wire is_read_op_i_1_n_0;
  wire is_read_op_reg_n_0;
  wire \nby_cnt[0]_i_1_n_0 ;
  wire \nby_cnt[0]_i_2_n_0 ;
  wire \nby_cnt[0]_i_3_n_0 ;
  wire \nby_cnt[0]_i_4_n_0 ;
  wire \nby_cnt[0]_i_5_n_0 ;
  wire \nby_cnt[0]_i_6_n_0 ;
  wire \nby_cnt[0]_i_7_n_0 ;
  wire \nby_cnt[1]_i_1_n_0 ;
  wire \nby_cnt[1]_i_2_n_0 ;
  wire \nby_cnt[1]_i_3_n_0 ;
  wire \nby_cnt[1]_i_4_n_0 ;
  wire \nby_cnt[1]_i_5_n_0 ;
  wire \nby_cnt[1]_i_6_n_0 ;
  wire \nby_cnt[2]_i_10_n_0 ;
  wire \nby_cnt[2]_i_11_n_0 ;
  wire \nby_cnt[2]_i_1_n_0 ;
  wire \nby_cnt[2]_i_2_n_0 ;
  wire \nby_cnt[2]_i_3_n_0 ;
  wire \nby_cnt[2]_i_4_n_0 ;
  wire \nby_cnt[2]_i_5_n_0 ;
  wire \nby_cnt[2]_i_6_n_0 ;
  wire \nby_cnt[2]_i_7_n_0 ;
  wire \nby_cnt[2]_i_8_n_0 ;
  wire \nby_cnt[2]_i_9_n_0 ;
  wire \nby_cnt_reg_n_0_[0] ;
  wire \nby_cnt_reg_n_0_[1] ;
  wire \nby_cnt_reg_n_0_[2] ;
  wire [7:7]p_3_in;
  wire r_w_i_1_n_0;
  wire r_w_i_2_n_0;
  wire r_w_i_3_n_0;
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
  wire \rdata[31]_i_4_n_0 ;
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
  wire restart_i_1_n_0;
  wire restart_i_2_n_0;
  wire restart_i_3_n_0;
  wire restart_reg_n_0;
  wire rready;
  wire rst_n;
  wire rvalid;
  wire rvalid_i_1_n_0;
  wire sda_out_val_i_1_n_0;
  wire sda_out_val_i_2_n_0;
  wire sda_out_val_i_3_n_0;
  wire sda_out_val_i_4_n_0;
  wire sda_out_val_i_5_n_0;
  wire sda_out_val_i_6_n_0;
  wire sda_out_val_i_7_n_0;
  wire sda_out_val_i_8_n_0;
  wire sda_out_val_reg_n_0;
  wire \shift_byte[0]_i_1_n_0 ;
  wire \shift_byte[0]_i_2_n_0 ;
  wire \shift_byte[0]_i_3_n_0 ;
  wire \shift_byte[0]_i_4_n_0 ;
  wire \shift_byte[0]_i_5_n_0 ;
  wire \shift_byte[1]_i_1_n_0 ;
  wire \shift_byte[1]_i_2_n_0 ;
  wire \shift_byte[1]_i_3_n_0 ;
  wire \shift_byte[1]_i_4_n_0 ;
  wire \shift_byte[2]_i_1_n_0 ;
  wire \shift_byte[2]_i_2_n_0 ;
  wire \shift_byte[2]_i_3_n_0 ;
  wire \shift_byte[2]_i_4_n_0 ;
  wire \shift_byte[3]_i_1_n_0 ;
  wire \shift_byte[3]_i_2_n_0 ;
  wire \shift_byte[3]_i_3_n_0 ;
  wire \shift_byte[3]_i_4_n_0 ;
  wire \shift_byte[4]_i_1_n_0 ;
  wire \shift_byte[4]_i_2_n_0 ;
  wire \shift_byte[4]_i_3_n_0 ;
  wire \shift_byte[4]_i_4_n_0 ;
  wire \shift_byte[5]_i_1_n_0 ;
  wire \shift_byte[5]_i_2_n_0 ;
  wire \shift_byte[5]_i_3_n_0 ;
  wire \shift_byte[5]_i_4_n_0 ;
  wire \shift_byte[6]_i_1_n_0 ;
  wire \shift_byte[6]_i_2_n_0 ;
  wire \shift_byte[6]_i_3_n_0 ;
  wire \shift_byte[6]_i_4_n_0 ;
  wire \shift_byte[6]_i_5_n_0 ;
  wire \shift_byte[6]_i_6_n_0 ;
  wire \shift_byte[7]_i_10_n_0 ;
  wire \shift_byte[7]_i_11_n_0 ;
  wire \shift_byte[7]_i_12_n_0 ;
  wire \shift_byte[7]_i_1_n_0 ;
  wire \shift_byte[7]_i_2_n_0 ;
  wire \shift_byte[7]_i_3_n_0 ;
  wire \shift_byte[7]_i_4_n_0 ;
  wire \shift_byte[7]_i_5_n_0 ;
  wire \shift_byte[7]_i_6_n_0 ;
  wire \shift_byte[7]_i_7_n_0 ;
  wire \shift_byte[7]_i_8_n_0 ;
  wire \shift_byte[7]_i_9_n_0 ;
  wire \shift_byte_reg_n_0_[0] ;
  wire \shift_byte_reg_n_0_[1] ;
  wire \shift_byte_reg_n_0_[2] ;
  wire \shift_byte_reg_n_0_[3] ;
  wire \shift_byte_reg_n_0_[4] ;
  wire \shift_byte_reg_n_0_[5] ;
  wire \shift_byte_reg_n_0_[6] ;
  wire \shift_cnt[0]_i_1_n_0 ;
  wire \shift_cnt[0]_i_2_n_0 ;
  wire \shift_cnt[1]_i_1_n_0 ;
  wire \shift_cnt[2]_i_1_n_0 ;
  wire \shift_cnt[2]_i_2_n_0 ;
  wire \shift_cnt[2]_i_3_n_0 ;
  wire \shift_cnt[2]_i_4_n_0 ;
  wire \shift_cnt[2]_i_5_n_0 ;
  wire \shift_cnt_reg_n_0_[0] ;
  wire \shift_cnt_reg_n_0_[1] ;
  wire \shift_cnt_reg_n_0_[2] ;
  wire [31:0]wdata;
  wire wvalid;

  LUT5 #(
    .INIT(32'h00010000)) 
    \I2C_ADR[31]_i_1 
       (.I0(awaddr[4]),
        .I1(awaddr[0]),
        .I2(awaddr[1]),
        .I3(awaddr[3]),
        .I4(\I2C_ADR[31]_i_2_n_0 ),
        .O(I2C_ADR));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    \I2C_ADR[31]_i_2 
       (.I0(awaddr[2]),
        .I1(awaddr[6]),
        .I2(awaddr[7]),
        .I3(awaddr[5]),
        .I4(wvalid),
        .I5(awvalid),
        .O(\I2C_ADR[31]_i_2_n_0 ));
  FDCE \I2C_ADR_reg[0] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[0]),
        .Q(I2C_ADR__0[0]));
  FDCE \I2C_ADR_reg[10] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[10]),
        .Q(I2C_ADR__0[10]));
  FDCE \I2C_ADR_reg[11] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[11]),
        .Q(I2C_ADR__0[11]));
  FDCE \I2C_ADR_reg[12] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[12]),
        .Q(I2C_ADR__0[12]));
  FDCE \I2C_ADR_reg[13] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[13]),
        .Q(I2C_ADR__0[13]));
  FDCE \I2C_ADR_reg[14] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[14]),
        .Q(I2C_ADR__0[14]));
  FDCE \I2C_ADR_reg[15] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[15]),
        .Q(I2C_ADR__0[15]));
  FDCE \I2C_ADR_reg[16] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[16]),
        .Q(I2C_ADR__0[16]));
  FDCE \I2C_ADR_reg[17] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[17]),
        .Q(I2C_ADR__0[17]));
  FDCE \I2C_ADR_reg[18] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[18]),
        .Q(I2C_ADR__0[18]));
  FDCE \I2C_ADR_reg[19] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[19]),
        .Q(I2C_ADR__0[19]));
  FDCE \I2C_ADR_reg[1] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[1]),
        .Q(I2C_ADR__0[1]));
  FDCE \I2C_ADR_reg[20] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[20]),
        .Q(I2C_ADR__0[20]));
  FDCE \I2C_ADR_reg[21] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[21]),
        .Q(I2C_ADR__0[21]));
  FDCE \I2C_ADR_reg[22] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[22]),
        .Q(I2C_ADR__0[22]));
  FDCE \I2C_ADR_reg[23] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[23]),
        .Q(I2C_ADR__0[23]));
  FDCE \I2C_ADR_reg[24] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[24]),
        .Q(I2C_ADR__0[24]));
  FDCE \I2C_ADR_reg[25] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[25]),
        .Q(I2C_ADR__0[25]));
  FDCE \I2C_ADR_reg[26] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[26]),
        .Q(I2C_ADR__0[26]));
  FDCE \I2C_ADR_reg[27] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[27]),
        .Q(I2C_ADR__0[27]));
  FDCE \I2C_ADR_reg[28] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[28]),
        .Q(I2C_ADR__0[28]));
  FDCE \I2C_ADR_reg[29] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[29]),
        .Q(I2C_ADR__0[29]));
  FDCE \I2C_ADR_reg[2] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[2]),
        .Q(I2C_ADR__0[2]));
  FDCE \I2C_ADR_reg[30] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[30]),
        .Q(I2C_ADR__0[30]));
  FDCE \I2C_ADR_reg[31] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[31]),
        .Q(I2C_ADR__0[31]));
  FDCE \I2C_ADR_reg[3] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[3]),
        .Q(I2C_ADR__0[3]));
  FDCE \I2C_ADR_reg[4] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[4]),
        .Q(I2C_ADR__0[4]));
  FDCE \I2C_ADR_reg[5] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[5]),
        .Q(I2C_ADR__0[5]));
  FDCE \I2C_ADR_reg[6] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[6]),
        .Q(I2C_ADR__0[6]));
  FDCE \I2C_ADR_reg[7] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[7]),
        .Q(I2C_ADR__0[7]));
  FDCE \I2C_ADR_reg[8] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[8]),
        .Q(I2C_ADR__0[8]));
  FDCE \I2C_ADR_reg[9] 
       (.C(clk_i),
        .CE(I2C_ADR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[9]),
        .Q(I2C_ADR__0[9]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h0B08)) 
    \I2C_CFG[0]_i_1 
       (.I0(wdata[0]),
        .I1(\I2C_CFG[31]_i_1_n_0 ),
        .I2(\I2C_CFG[1]_i_2_n_0 ),
        .I3(\I2C_CFG_reg_n_0_[0] ),
        .O(\I2C_CFG[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBABABAFFBABABA00)) 
    \I2C_CFG[1]_i_1 
       (.I0(\I2C_CFG[1]_i_2_n_0 ),
        .I1(\I2C_CFG[1]_i_3_n_0 ),
        .I2(wdata[1]),
        .I3(\I2C_CFG[31]_i_1_n_0 ),
        .I4(\I2C_CFG[1]_i_4_n_0 ),
        .I5(\I2C_CFG_reg_n_0_[1] ),
        .O(\I2C_CFG[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    \I2C_CFG[1]_i_2 
       (.I0(\current_state_reg_n_0_[0] ),
        .I1(r_w_reg_n_0),
        .I2(I2C_SCL_reg_0),
        .I3(\I2C_CFG[3]_i_5_n_0 ),
        .I4(\current_state_reg_n_0_[1] ),
        .I5(\current_state_reg_n_0_[2] ),
        .O(\I2C_CFG[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    \I2C_CFG[1]_i_3 
       (.I0(restart_reg_n_0),
        .I1(\I2C_CFG_clr_reg_n_0_[0] ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\current_state_reg_n_0_[2] ),
        .I4(\current_state_reg_n_0_[1] ),
        .I5(\I2C_CFG[1]_i_5_n_0 ),
        .O(\I2C_CFG[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000800000A080A0)) 
    \I2C_CFG[1]_i_4 
       (.I0(\I2C_CFG[3]_i_5_n_0 ),
        .I1(\I2C_CFG_clr_reg_n_0_[0] ),
        .I2(\current_state_reg_n_0_[2] ),
        .I3(\current_state_reg_n_0_[1] ),
        .I4(\current_state_reg_n_0_[0] ),
        .I5(\I2C_CFG[1]_i_6_n_0 ),
        .O(\I2C_CFG[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBFFFFF)) 
    \I2C_CFG[1]_i_5 
       (.I0(\shift_byte[7]_i_4_n_0 ),
        .I1(freq_div_en),
        .I2(\freq_div_cnt_reg_n_0_[3] ),
        .I3(\freq_div_cnt_reg_n_0_[1] ),
        .I4(\freq_div_cnt_reg_n_0_[2] ),
        .I5(\I2C_CFG[3]_i_6_n_0 ),
        .O(\I2C_CFG[1]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \I2C_CFG[1]_i_6 
       (.I0(I2C_SCL_reg_0),
        .I1(r_w_reg_n_0),
        .I2(\current_state_reg_n_0_[0] ),
        .O(\I2C_CFG[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0BBBBBBB08888888)) 
    \I2C_CFG[2]_i_1 
       (.I0(wdata[2]),
        .I1(\I2C_CFG[31]_i_1_n_0 ),
        .I2(r_w_reg_n_0),
        .I3(\I2C_CFG[3]_i_5_n_0 ),
        .I4(\I2C_CFG[2]_i_2_n_0 ),
        .I5(\I2C_CFG_reg_n_0_[2] ),
        .O(\I2C_CFG[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \I2C_CFG[2]_i_2 
       (.I0(\current_state_reg_n_0_[0] ),
        .I1(\current_state_reg_n_0_[2] ),
        .I2(\current_state_reg_n_0_[1] ),
        .I3(I2C_SCL_reg_0),
        .O(\I2C_CFG[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000020)) 
    \I2C_CFG[31]_i_1 
       (.I0(\I2C_CFG[31]_i_2_n_0 ),
        .I1(awaddr[3]),
        .I2(awaddr[4]),
        .I3(awaddr[1]),
        .I4(awaddr[0]),
        .O(\I2C_CFG[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \I2C_CFG[31]_i_2 
       (.I0(awaddr[2]),
        .I1(awaddr[6]),
        .I2(awaddr[7]),
        .I3(awaddr[5]),
        .I4(wvalid),
        .I5(awvalid),
        .O(\I2C_CFG[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8F88AFAF8088A0A0)) 
    \I2C_CFG[3]_i_1 
       (.I0(\I2C_CFG[3]_i_2_n_0 ),
        .I1(\I2C_CFG[3]_i_3_n_0 ),
        .I2(\I2C_CFG[31]_i_1_n_0 ),
        .I3(\I2C_CFG[3]_i_4_n_0 ),
        .I4(\I2C_CFG[3]_i_5_n_0 ),
        .I5(\I2C_CFG_reg_n_0_[3] ),
        .O(\I2C_CFG[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAAAAAAAAAA)) 
    \I2C_CFG[3]_i_2 
       (.I0(wdata[3]),
        .I1(\current_state_reg_n_0_[2] ),
        .I2(\current_state_reg_n_0_[1] ),
        .I3(\I2C_CFG[3]_i_5_n_0 ),
        .I4(\I2C_CFG[2]_i_2_n_0 ),
        .I5(r_w_reg_n_0),
        .O(\I2C_CFG[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'hFF3F5F3F)) 
    \I2C_CFG[3]_i_3 
       (.I0(\I2C_CFG_clr_reg_n_0_[1] ),
        .I1(restart_reg_n_0),
        .I2(\current_state_reg_n_0_[2] ),
        .I3(\current_state_reg_n_0_[1] ),
        .I4(\current_state_reg_n_0_[0] ),
        .O(\I2C_CFG[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hF5FF3FFFF5FFFFFF)) 
    \I2C_CFG[3]_i_4 
       (.I0(\I2C_CFG_clr_reg_n_0_[1] ),
        .I1(r_w_reg_n_0),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\current_state_reg_n_0_[2] ),
        .I4(\current_state_reg_n_0_[1] ),
        .I5(I2C_SCL_reg_0),
        .O(\I2C_CFG[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0100010001000000)) 
    \I2C_CFG[3]_i_5 
       (.I0(restart_reg_n_0),
        .I1(\I2C_CFG[3]_i_6_n_0 ),
        .I2(\I2C_CFG[3]_i_7_n_0 ),
        .I3(freq_div_en),
        .I4(\I2C_CFG_reg_n_0_[2] ),
        .I5(\I2C_CFG_reg_n_0_[0] ),
        .O(\I2C_CFG[3]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'hFFDF)) 
    \I2C_CFG[3]_i_6 
       (.I0(\freq_div_cnt_reg_n_0_[0] ),
        .I1(\freq_div_cnt_reg_n_0_[5] ),
        .I2(\freq_div_cnt_reg_n_0_[4] ),
        .I3(\freq_div_cnt_reg_n_0_[6] ),
        .O(\I2C_CFG[3]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \I2C_CFG[3]_i_7 
       (.I0(\freq_div_cnt_reg_n_0_[2] ),
        .I1(\freq_div_cnt_reg_n_0_[1] ),
        .I2(\freq_div_cnt_reg_n_0_[3] ),
        .O(\I2C_CFG[3]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \I2C_CFG_clr[0]_i_1 
       (.I0(wdata[0]),
        .I1(I2C_CFG_clr),
        .I2(\I2C_CFG_clr_reg_n_0_[0] ),
        .O(\I2C_CFG_clr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \I2C_CFG_clr[1]_i_1 
       (.I0(wdata[1]),
        .I1(I2C_CFG_clr),
        .I2(\I2C_CFG_clr_reg_n_0_[1] ),
        .O(\I2C_CFG_clr[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000080000)) 
    \I2C_CFG_clr[1]_i_2 
       (.I0(\I2C_ADR[31]_i_2_n_0 ),
        .I1(rst_n),
        .I2(awaddr[0]),
        .I3(awaddr[1]),
        .I4(awaddr[4]),
        .I5(awaddr[3]),
        .O(I2C_CFG_clr));
  FDRE \I2C_CFG_clr_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .D(\I2C_CFG_clr[0]_i_1_n_0 ),
        .Q(\I2C_CFG_clr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \I2C_CFG_clr_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .D(\I2C_CFG_clr[1]_i_1_n_0 ),
        .Q(\I2C_CFG_clr_reg_n_0_[1] ),
        .R(1'b0));
  FDCE \I2C_CFG_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\I2C_CFG[0]_i_1_n_0 ),
        .Q(\I2C_CFG_reg_n_0_[0] ));
  FDCE \I2C_CFG_reg[10] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[10]),
        .Q(\I2C_CFG_reg_n_0_[10] ));
  FDCE \I2C_CFG_reg[11] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[11]),
        .Q(\I2C_CFG_reg_n_0_[11] ));
  FDCE \I2C_CFG_reg[12] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[12]),
        .Q(\I2C_CFG_reg_n_0_[12] ));
  FDCE \I2C_CFG_reg[13] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[13]),
        .Q(\I2C_CFG_reg_n_0_[13] ));
  FDCE \I2C_CFG_reg[14] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[14]),
        .Q(\I2C_CFG_reg_n_0_[14] ));
  FDCE \I2C_CFG_reg[15] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[15]),
        .Q(\I2C_CFG_reg_n_0_[15] ));
  FDCE \I2C_CFG_reg[16] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[16]),
        .Q(\I2C_CFG_reg_n_0_[16] ));
  FDCE \I2C_CFG_reg[17] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[17]),
        .Q(\I2C_CFG_reg_n_0_[17] ));
  FDCE \I2C_CFG_reg[18] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[18]),
        .Q(\I2C_CFG_reg_n_0_[18] ));
  FDCE \I2C_CFG_reg[19] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[19]),
        .Q(\I2C_CFG_reg_n_0_[19] ));
  FDCE \I2C_CFG_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\I2C_CFG[1]_i_1_n_0 ),
        .Q(\I2C_CFG_reg_n_0_[1] ));
  FDCE \I2C_CFG_reg[20] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[20]),
        .Q(\I2C_CFG_reg_n_0_[20] ));
  FDCE \I2C_CFG_reg[21] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[21]),
        .Q(\I2C_CFG_reg_n_0_[21] ));
  FDCE \I2C_CFG_reg[22] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[22]),
        .Q(\I2C_CFG_reg_n_0_[22] ));
  FDCE \I2C_CFG_reg[23] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[23]),
        .Q(\I2C_CFG_reg_n_0_[23] ));
  FDCE \I2C_CFG_reg[24] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[24]),
        .Q(\I2C_CFG_reg_n_0_[24] ));
  FDCE \I2C_CFG_reg[25] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[25]),
        .Q(\I2C_CFG_reg_n_0_[25] ));
  FDCE \I2C_CFG_reg[26] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[26]),
        .Q(\I2C_CFG_reg_n_0_[26] ));
  FDCE \I2C_CFG_reg[27] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[27]),
        .Q(\I2C_CFG_reg_n_0_[27] ));
  FDCE \I2C_CFG_reg[28] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[28]),
        .Q(\I2C_CFG_reg_n_0_[28] ));
  FDCE \I2C_CFG_reg[29] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[29]),
        .Q(\I2C_CFG_reg_n_0_[29] ));
  FDCE \I2C_CFG_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\I2C_CFG[2]_i_1_n_0 ),
        .Q(\I2C_CFG_reg_n_0_[2] ));
  FDCE \I2C_CFG_reg[30] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[30]),
        .Q(\I2C_CFG_reg_n_0_[30] ));
  FDCE \I2C_CFG_reg[31] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[31]),
        .Q(\I2C_CFG_reg_n_0_[31] ));
  FDCE \I2C_CFG_reg[3] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\I2C_CFG[3]_i_1_n_0 ),
        .Q(\I2C_CFG_reg_n_0_[3] ));
  FDCE \I2C_CFG_reg[4] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[4]),
        .Q(\I2C_CFG_reg_n_0_[4] ));
  FDCE \I2C_CFG_reg[5] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[5]),
        .Q(\I2C_CFG_reg_n_0_[5] ));
  FDCE \I2C_CFG_reg[6] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[6]),
        .Q(\I2C_CFG_reg_n_0_[6] ));
  FDCE \I2C_CFG_reg[7] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[7]),
        .Q(\I2C_CFG_reg_n_0_[7] ));
  FDCE \I2C_CFG_reg[8] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[8]),
        .Q(\I2C_CFG_reg_n_0_[8] ));
  FDCE \I2C_CFG_reg[9] 
       (.C(clk_i),
        .CE(\I2C_CFG[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[9]),
        .Q(\I2C_CFG_reg_n_0_[9] ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \I2C_NBY[0]_i_1 
       (.I0(\I2C_NBY[0]_i_2_n_0 ),
        .I1(I2C_NBY),
        .I2(\I2C_NBY_reg_n_0_[0] ),
        .O(\I2C_NBY[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000040500000000)) 
    \I2C_NBY[0]_i_2 
       (.I0(\I2C_NBY[0]_i_3_n_0 ),
        .I1(wdata[0]),
        .I2(wdata[2]),
        .I3(wdata[1]),
        .I4(\I2C_NBY[2]_i_8_n_0 ),
        .I5(\I2C_NBY[2]_i_9_n_0 ),
        .O(\I2C_NBY[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \I2C_NBY[0]_i_3 
       (.I0(\I2C_NBY[2]_i_2_n_0 ),
        .I1(\I2C_NBY[0]_i_4_n_0 ),
        .I2(\I2C_NBY[2]_i_10_n_0 ),
        .I3(\I2C_NBY[0]_i_5_n_0 ),
        .I4(\I2C_NBY[2]_i_6_n_0 ),
        .O(\I2C_NBY[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \I2C_NBY[0]_i_4 
       (.I0(wdata[23]),
        .I1(wdata[9]),
        .I2(wdata[22]),
        .I3(wdata[6]),
        .O(\I2C_NBY[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \I2C_NBY[0]_i_5 
       (.I0(wdata[24]),
        .I1(wdata[18]),
        .I2(wdata[16]),
        .I3(wdata[8]),
        .O(\I2C_NBY[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0002FFFF00020000)) 
    \I2C_NBY[1]_i_1 
       (.I0(wdata[1]),
        .I1(\I2C_NBY[2]_i_2_n_0 ),
        .I2(\I2C_NBY[2]_i_3_n_0 ),
        .I3(\I2C_NBY[2]_i_4_n_0 ),
        .I4(I2C_NBY),
        .I5(\I2C_NBY_reg_n_0_[1] ),
        .O(\I2C_NBY[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFE0000)) 
    \I2C_NBY[2]_i_1 
       (.I0(wdata[2]),
        .I1(\I2C_NBY[2]_i_2_n_0 ),
        .I2(\I2C_NBY[2]_i_3_n_0 ),
        .I3(\I2C_NBY[2]_i_4_n_0 ),
        .I4(I2C_NBY),
        .I5(\I2C_NBY_reg_n_0_[2] ),
        .O(\I2C_NBY[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \I2C_NBY[2]_i_10 
       (.I0(wdata[12]),
        .I1(wdata[5]),
        .I2(wdata[28]),
        .I3(wdata[17]),
        .O(\I2C_NBY[2]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \I2C_NBY[2]_i_2 
       (.I0(wdata[25]),
        .I1(wdata[7]),
        .I2(wdata[15]),
        .I3(wdata[27]),
        .I4(wdata[14]),
        .I5(wdata[20]),
        .O(\I2C_NBY[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \I2C_NBY[2]_i_3 
       (.I0(\I2C_NBY[2]_i_6_n_0 ),
        .I1(wdata[24]),
        .I2(wdata[18]),
        .I3(wdata[16]),
        .I4(wdata[8]),
        .I5(\I2C_NBY[2]_i_7_n_0 ),
        .O(\I2C_NBY[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFEAAFFFF)) 
    \I2C_NBY[2]_i_4 
       (.I0(\I2C_NBY[2]_i_8_n_0 ),
        .I1(wdata[0]),
        .I2(wdata[1]),
        .I3(wdata[2]),
        .I4(\I2C_NBY[2]_i_9_n_0 ),
        .O(\I2C_NBY[2]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \I2C_NBY[2]_i_5 
       (.I0(awaddr[4]),
        .I1(awaddr[0]),
        .I2(awaddr[1]),
        .I3(awaddr[3]),
        .I4(\I2C_CFG[31]_i_2_n_0 ),
        .O(I2C_NBY));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \I2C_NBY[2]_i_6 
       (.I0(wdata[26]),
        .I1(wdata[19]),
        .I2(wdata[21]),
        .I3(wdata[13]),
        .O(\I2C_NBY[2]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \I2C_NBY[2]_i_7 
       (.I0(wdata[6]),
        .I1(wdata[22]),
        .I2(wdata[9]),
        .I3(wdata[23]),
        .I4(\I2C_NBY[2]_i_10_n_0 ),
        .O(\I2C_NBY[2]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \I2C_NBY[2]_i_8 
       (.I0(wdata[31]),
        .I1(wdata[30]),
        .I2(wdata[29]),
        .O(\I2C_NBY[2]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \I2C_NBY[2]_i_9 
       (.I0(wdata[4]),
        .I1(wdata[3]),
        .I2(wdata[11]),
        .I3(wdata[10]),
        .O(\I2C_NBY[2]_i_9_n_0 ));
  FDCE \I2C_NBY_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\I2C_NBY[0]_i_1_n_0 ),
        .Q(\I2C_NBY_reg_n_0_[0] ));
  FDCE \I2C_NBY_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\I2C_NBY[1]_i_1_n_0 ),
        .Q(\I2C_NBY_reg_n_0_[1] ));
  FDCE \I2C_NBY_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\I2C_NBY[2]_i_1_n_0 ),
        .Q(\I2C_NBY_reg_n_0_[2] ));
  LUT5 #(
    .INIT(32'h888888A8)) 
    \I2C_RDR[15]_i_1 
       (.I0(\I2C_RDR[31]_i_2_n_0 ),
        .I1(\I2C_RDR[15]_i_2_n_0 ),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\byte_cnt_reg_n_0_[0] ),
        .I4(\I2C_RDR[23]_i_3_n_0 ),
        .O(\I2C_RDR[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0100000000000000)) 
    \I2C_RDR[15]_i_2 
       (.I0(\I2C_NBY_reg_n_0_[2] ),
        .I1(\I2C_CFG_reg_n_0_[0] ),
        .I2(\I2C_NBY_reg_n_0_[0] ),
        .I3(\shift_byte[0]_i_4_n_0 ),
        .I4(\I2C_NBY_reg_n_0_[1] ),
        .I5(\current_state_reg_n_0_[1] ),
        .O(\I2C_RDR[15]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h8888A888)) 
    \I2C_RDR[23]_i_1 
       (.I0(\I2C_RDR[31]_i_2_n_0 ),
        .I1(\I2C_RDR[23]_i_2_n_0 ),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\byte_cnt_reg_n_0_[0] ),
        .I4(\I2C_RDR[23]_i_3_n_0 ),
        .O(\I2C_RDR[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000008000)) 
    \I2C_RDR[23]_i_2 
       (.I0(\shift_byte[0]_i_4_n_0 ),
        .I1(\I2C_NBY_reg_n_0_[0] ),
        .I2(\I2C_NBY_reg_n_0_[1] ),
        .I3(\current_state_reg_n_0_[1] ),
        .I4(\I2C_CFG_reg_n_0_[0] ),
        .I5(\I2C_NBY_reg_n_0_[2] ),
        .O(\I2C_RDR[23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'hFFFB)) 
    \I2C_RDR[23]_i_3 
       (.I0(\byte_cnt_reg_n_0_[2] ),
        .I1(r_w_reg_n_0),
        .I2(I2C_SCL_reg_0),
        .I3(\current_state_reg_n_0_[1] ),
        .O(\I2C_RDR[23]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h2222222222222A22)) 
    \I2C_RDR[31]_i_1 
       (.I0(\I2C_RDR[31]_i_2_n_0 ),
        .I1(\I2C_RDR[31]_i_3_n_0 ),
        .I2(\I2C_RDR[31]_i_4_n_0 ),
        .I3(r_w_reg_n_0),
        .I4(I2C_SCL_reg_0),
        .I5(\current_state_reg_n_0_[1] ),
        .O(\I2C_RDR[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \I2C_RDR[31]_i_2 
       (.I0(\I2C_CFG[3]_i_5_n_0 ),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(\current_state_reg_n_0_[2] ),
        .O(\I2C_RDR[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF7FFFF)) 
    \I2C_RDR[31]_i_3 
       (.I0(\I2C_NBY_reg_n_0_[2] ),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\I2C_NBY_reg_n_0_[1] ),
        .I3(\I2C_NBY_reg_n_0_[0] ),
        .I4(\shift_byte[0]_i_4_n_0 ),
        .I5(\I2C_CFG_reg_n_0_[0] ),
        .O(\I2C_RDR[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hEF)) 
    \I2C_RDR[31]_i_4 
       (.I0(\byte_cnt_reg_n_0_[0] ),
        .I1(\byte_cnt_reg_n_0_[1] ),
        .I2(\byte_cnt_reg_n_0_[2] ),
        .O(\I2C_RDR[31]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h888A8888)) 
    \I2C_RDR[7]_i_1 
       (.I0(\I2C_RDR[31]_i_2_n_0 ),
        .I1(\I2C_RDR[7]_i_2_n_0 ),
        .I2(\I2C_RDR[23]_i_3_n_0 ),
        .I3(\byte_cnt_reg_n_0_[1] ),
        .I4(\byte_cnt_reg_n_0_[0] ),
        .O(\I2C_RDR[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000800)) 
    \I2C_RDR[7]_i_2 
       (.I0(\shift_byte[0]_i_4_n_0 ),
        .I1(\I2C_NBY_reg_n_0_[0] ),
        .I2(\I2C_NBY_reg_n_0_[1] ),
        .I3(\current_state_reg_n_0_[1] ),
        .I4(\I2C_CFG_reg_n_0_[0] ),
        .I5(\I2C_NBY_reg_n_0_[2] ),
        .O(\I2C_RDR[7]_i_2_n_0 ));
  FDCE \I2C_RDR_reg[0] 
       (.C(clk_i),
        .CE(\I2C_RDR[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[0] ),
        .Q(\I2C_RDR_reg_n_0_[0] ));
  FDCE \I2C_RDR_reg[10] 
       (.C(clk_i),
        .CE(\I2C_RDR[15]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[2] ),
        .Q(\I2C_RDR_reg_n_0_[10] ));
  FDCE \I2C_RDR_reg[11] 
       (.C(clk_i),
        .CE(\I2C_RDR[15]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[3] ),
        .Q(\I2C_RDR_reg_n_0_[11] ));
  FDCE \I2C_RDR_reg[12] 
       (.C(clk_i),
        .CE(\I2C_RDR[15]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[4] ),
        .Q(\I2C_RDR_reg_n_0_[12] ));
  FDCE \I2C_RDR_reg[13] 
       (.C(clk_i),
        .CE(\I2C_RDR[15]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[5] ),
        .Q(\I2C_RDR_reg_n_0_[13] ));
  FDCE \I2C_RDR_reg[14] 
       (.C(clk_i),
        .CE(\I2C_RDR[15]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[6] ),
        .Q(\I2C_RDR_reg_n_0_[14] ));
  FDCE \I2C_RDR_reg[15] 
       (.C(clk_i),
        .CE(\I2C_RDR[15]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(p_3_in),
        .Q(\I2C_RDR_reg_n_0_[15] ));
  FDCE \I2C_RDR_reg[16] 
       (.C(clk_i),
        .CE(\I2C_RDR[23]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[0] ),
        .Q(\I2C_RDR_reg_n_0_[16] ));
  FDCE \I2C_RDR_reg[17] 
       (.C(clk_i),
        .CE(\I2C_RDR[23]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[1] ),
        .Q(\I2C_RDR_reg_n_0_[17] ));
  FDCE \I2C_RDR_reg[18] 
       (.C(clk_i),
        .CE(\I2C_RDR[23]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[2] ),
        .Q(\I2C_RDR_reg_n_0_[18] ));
  FDCE \I2C_RDR_reg[19] 
       (.C(clk_i),
        .CE(\I2C_RDR[23]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[3] ),
        .Q(\I2C_RDR_reg_n_0_[19] ));
  FDCE \I2C_RDR_reg[1] 
       (.C(clk_i),
        .CE(\I2C_RDR[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[1] ),
        .Q(\I2C_RDR_reg_n_0_[1] ));
  FDCE \I2C_RDR_reg[20] 
       (.C(clk_i),
        .CE(\I2C_RDR[23]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[4] ),
        .Q(\I2C_RDR_reg_n_0_[20] ));
  FDCE \I2C_RDR_reg[21] 
       (.C(clk_i),
        .CE(\I2C_RDR[23]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[5] ),
        .Q(\I2C_RDR_reg_n_0_[21] ));
  FDCE \I2C_RDR_reg[22] 
       (.C(clk_i),
        .CE(\I2C_RDR[23]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[6] ),
        .Q(\I2C_RDR_reg_n_0_[22] ));
  FDCE \I2C_RDR_reg[23] 
       (.C(clk_i),
        .CE(\I2C_RDR[23]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(p_3_in),
        .Q(\I2C_RDR_reg_n_0_[23] ));
  FDCE \I2C_RDR_reg[24] 
       (.C(clk_i),
        .CE(\I2C_RDR[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[0] ),
        .Q(\I2C_RDR_reg_n_0_[24] ));
  FDCE \I2C_RDR_reg[25] 
       (.C(clk_i),
        .CE(\I2C_RDR[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[1] ),
        .Q(\I2C_RDR_reg_n_0_[25] ));
  FDCE \I2C_RDR_reg[26] 
       (.C(clk_i),
        .CE(\I2C_RDR[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[2] ),
        .Q(\I2C_RDR_reg_n_0_[26] ));
  FDCE \I2C_RDR_reg[27] 
       (.C(clk_i),
        .CE(\I2C_RDR[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[3] ),
        .Q(\I2C_RDR_reg_n_0_[27] ));
  FDCE \I2C_RDR_reg[28] 
       (.C(clk_i),
        .CE(\I2C_RDR[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[4] ),
        .Q(\I2C_RDR_reg_n_0_[28] ));
  FDCE \I2C_RDR_reg[29] 
       (.C(clk_i),
        .CE(\I2C_RDR[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[5] ),
        .Q(\I2C_RDR_reg_n_0_[29] ));
  FDCE \I2C_RDR_reg[2] 
       (.C(clk_i),
        .CE(\I2C_RDR[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[2] ),
        .Q(\I2C_RDR_reg_n_0_[2] ));
  FDCE \I2C_RDR_reg[30] 
       (.C(clk_i),
        .CE(\I2C_RDR[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[6] ),
        .Q(\I2C_RDR_reg_n_0_[30] ));
  FDCE \I2C_RDR_reg[31] 
       (.C(clk_i),
        .CE(\I2C_RDR[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(p_3_in),
        .Q(\I2C_RDR_reg_n_0_[31] ));
  FDCE \I2C_RDR_reg[3] 
       (.C(clk_i),
        .CE(\I2C_RDR[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[3] ),
        .Q(\I2C_RDR_reg_n_0_[3] ));
  FDCE \I2C_RDR_reg[4] 
       (.C(clk_i),
        .CE(\I2C_RDR[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[4] ),
        .Q(\I2C_RDR_reg_n_0_[4] ));
  FDCE \I2C_RDR_reg[5] 
       (.C(clk_i),
        .CE(\I2C_RDR[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[5] ),
        .Q(\I2C_RDR_reg_n_0_[5] ));
  FDCE \I2C_RDR_reg[6] 
       (.C(clk_i),
        .CE(\I2C_RDR[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[6] ),
        .Q(\I2C_RDR_reg_n_0_[6] ));
  FDCE \I2C_RDR_reg[7] 
       (.C(clk_i),
        .CE(\I2C_RDR[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(p_3_in),
        .Q(\I2C_RDR_reg_n_0_[7] ));
  FDCE \I2C_RDR_reg[8] 
       (.C(clk_i),
        .CE(\I2C_RDR[15]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[0] ),
        .Q(\I2C_RDR_reg_n_0_[8] ));
  FDCE \I2C_RDR_reg[9] 
       (.C(clk_i),
        .CE(\I2C_RDR[15]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte_reg_n_0_[1] ),
        .Q(\I2C_RDR_reg_n_0_[9] ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB5)) 
    I2C_SCL_i_1
       (.I0(I2C_SCL_i_3_n_0),
        .I1(freq_div_en),
        .I2(I2C_SCL_reg_0),
        .O(I2C_SCL_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    I2C_SCL_i_2
       (.I0(rst_n),
        .O(I2C_SCL_i_2_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAA8AAA)) 
    I2C_SCL_i_3
       (.I0(freq_div_en),
        .I1(\freq_div_cnt[2]_i_2_n_0 ),
        .I2(\freq_div_cnt_reg_n_0_[0] ),
        .I3(\freq_div_cnt_reg_n_0_[1] ),
        .I4(\freq_div_cnt_reg_n_0_[2] ),
        .I5(\freq_div_cnt_reg_n_0_[6] ),
        .O(I2C_SCL_i_3_n_0));
  FDPE I2C_SCL_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(I2C_SCL_i_1_n_0),
        .PRE(I2C_SCL_i_2_n_0),
        .Q(I2C_SCL_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h8)) 
    I2C_SDA_INST_0
       (.I0(sda_out_val_reg_n_0),
        .I1(I2C_SDA_INST_0_i_1_n_0),
        .O(I2C_SDA));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT1 #(
    .INIT(2'h1)) 
    I2C_SDA_INST_0_i_1
       (.I0(sda_out_val_reg_n_0),
        .O(I2C_SDA_INST_0_i_1_n_0));
  LUT5 #(
    .INIT(32'h00000008)) 
    \I2C_TDR[31]_i_1 
       (.I0(\I2C_ADR[31]_i_2_n_0 ),
        .I1(awaddr[3]),
        .I2(awaddr[4]),
        .I3(awaddr[0]),
        .I4(awaddr[1]),
        .O(I2C_TDR));
  FDCE \I2C_TDR_reg[0] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[0]),
        .Q(\I2C_TDR_reg_n_0_[0] ));
  FDCE \I2C_TDR_reg[10] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[10]),
        .Q(data1[2]));
  FDCE \I2C_TDR_reg[11] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[11]),
        .Q(data1[3]));
  FDCE \I2C_TDR_reg[12] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[12]),
        .Q(data1[4]));
  FDCE \I2C_TDR_reg[13] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[13]),
        .Q(data1[5]));
  FDCE \I2C_TDR_reg[14] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[14]),
        .Q(data1[6]));
  FDCE \I2C_TDR_reg[15] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[15]),
        .Q(data1[7]));
  FDCE \I2C_TDR_reg[16] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[16]),
        .Q(data2[0]));
  FDCE \I2C_TDR_reg[17] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[17]),
        .Q(data2[1]));
  FDCE \I2C_TDR_reg[18] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[18]),
        .Q(data2[2]));
  FDCE \I2C_TDR_reg[19] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[19]),
        .Q(data2[3]));
  FDCE \I2C_TDR_reg[1] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[1]),
        .Q(\I2C_TDR_reg_n_0_[1] ));
  FDCE \I2C_TDR_reg[20] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[20]),
        .Q(data2[4]));
  FDCE \I2C_TDR_reg[21] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[21]),
        .Q(data2[5]));
  FDCE \I2C_TDR_reg[22] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[22]),
        .Q(data2[6]));
  FDCE \I2C_TDR_reg[23] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[23]),
        .Q(data2[7]));
  FDCE \I2C_TDR_reg[24] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[24]),
        .Q(data3[0]));
  FDCE \I2C_TDR_reg[25] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[25]),
        .Q(data3[1]));
  FDCE \I2C_TDR_reg[26] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[26]),
        .Q(data3[2]));
  FDCE \I2C_TDR_reg[27] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[27]),
        .Q(data3[3]));
  FDCE \I2C_TDR_reg[28] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[28]),
        .Q(data3[4]));
  FDCE \I2C_TDR_reg[29] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[29]),
        .Q(data3[5]));
  FDCE \I2C_TDR_reg[2] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[2]),
        .Q(\I2C_TDR_reg_n_0_[2] ));
  FDCE \I2C_TDR_reg[30] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[30]),
        .Q(data3[6]));
  FDCE \I2C_TDR_reg[31] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[31]),
        .Q(data3[7]));
  FDCE \I2C_TDR_reg[3] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[3]),
        .Q(\I2C_TDR_reg_n_0_[3] ));
  FDCE \I2C_TDR_reg[4] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[4]),
        .Q(\I2C_TDR_reg_n_0_[4] ));
  FDCE \I2C_TDR_reg[5] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[5]),
        .Q(\I2C_TDR_reg_n_0_[5] ));
  FDCE \I2C_TDR_reg[6] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[6]),
        .Q(\I2C_TDR_reg_n_0_[6] ));
  FDCE \I2C_TDR_reg[7] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[7]),
        .Q(\I2C_TDR_reg_n_0_[7] ));
  FDCE \I2C_TDR_reg[8] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[8]),
        .Q(data1[0]));
  FDCE \I2C_TDR_reg[9] 
       (.C(clk_i),
        .CE(I2C_TDR),
        .CLR(I2C_SCL_i_2_n_0),
        .D(wdata[9]),
        .Q(data1[1]));
  LUT4 #(
    .INIT(16'h5540)) 
    arready_i_1
       (.I0(arvalid),
        .I1(rvalid),
        .I2(rready),
        .I3(arready),
        .O(arready_i_1_n_0));
  FDPE arready_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(arready_i_1_n_0),
        .PRE(I2C_SCL_i_2_n_0),
        .Q(arready));
  LUT6 #(
    .INIT(64'hAAAABBBBAAAABAAA)) 
    awready_i_1
       (.I0(awready_i_2_n_0),
        .I1(awready_i_3_n_0),
        .I2(bready),
        .I3(bvalid),
        .I4(I2C_NBY1),
        .I5(awready),
        .O(awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h08000000)) 
    awready_i_2
       (.I0(\I2C_CFG[3]_i_5_n_0 ),
        .I1(I2C_SCL_reg_0),
        .I2(\current_state_reg_n_0_[1] ),
        .I3(\current_state_reg_n_0_[2] ),
        .I4(\current_state_reg_n_0_[0] ),
        .O(awready_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h54)) 
    awready_i_3
       (.I0(freq_div_en),
        .I1(\I2C_CFG_reg_n_0_[0] ),
        .I2(\I2C_CFG_reg_n_0_[2] ),
        .O(awready_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    awready_i_4
       (.I0(wvalid),
        .I1(awvalid),
        .O(I2C_NBY1));
  FDPE awready_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(awready_i_1_n_0),
        .PRE(I2C_SCL_i_2_n_0),
        .Q(awready));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'h88F8)) 
    bvalid_i_1
       (.I0(awvalid),
        .I1(wvalid),
        .I2(bvalid),
        .I3(bready),
        .O(bvalid_i_1_n_0));
  FDCE bvalid_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(bvalid_i_1_n_0),
        .Q(bvalid));
  LUT6 #(
    .INIT(64'h08AAFFFF08AA0000)) 
    \byte_cnt[0]_i_1 
       (.I0(freq_div_en),
        .I1(\byte_cnt[0]_i_2_n_0 ),
        .I2(\byte_cnt[0]_i_3_n_0 ),
        .I3(\byte_cnt[0]_i_4_n_0 ),
        .I4(\byte_cnt[2]_i_4_n_0 ),
        .I5(\byte_cnt_reg_n_0_[0] ),
        .O(\byte_cnt[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hDDDFDDDFDDDFDDDD)) 
    \byte_cnt[0]_i_2 
       (.I0(\byte_cnt[0]_i_5_n_0 ),
        .I1(\current_state_reg_n_0_[2] ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\byte_cnt[0]_i_6_n_0 ),
        .I4(r_w_reg_n_0),
        .I5(\byte_cnt[0]_i_7_n_0 ),
        .O(\byte_cnt[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h51055505)) 
    \byte_cnt[0]_i_3 
       (.I0(freq_div_en),
        .I1(I2C_SCL_reg_0),
        .I2(\current_state_reg_n_0_[1] ),
        .I3(\current_state_reg_n_0_[2] ),
        .I4(\current_state_reg_n_0_[0] ),
        .O(\byte_cnt[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \byte_cnt[0]_i_4 
       (.I0(restart_reg_n_0),
        .I1(\shift_byte[7]_i_5_n_0 ),
        .O(\byte_cnt[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h2A2A2A2AAA2A2A2A)) 
    \byte_cnt[0]_i_5 
       (.I0(\current_state_reg_n_0_[1] ),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(freq_div_en),
        .I3(delay_reg_n_0),
        .I4(byte_cnt1),
        .I5(\I2C_CFG_reg_n_0_[0] ),
        .O(\byte_cnt[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h44C044CC44444444)) 
    \byte_cnt[0]_i_6 
       (.I0(freq_div_en),
        .I1(r_w_reg_n_0),
        .I2(\byte_cnt_reg_n_0_[0] ),
        .I3(\current_state[1]_i_6_n_0 ),
        .I4(\current_state[0]_i_6_n_0 ),
        .I5(I2C_SCL_reg_0),
        .O(\byte_cnt[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hA8ABA8ABA8ABABAB)) 
    \byte_cnt[0]_i_7 
       (.I0(freq_div_en),
        .I1(I2C_SCL_reg_0),
        .I2(\current_state[1]_i_6_n_0 ),
        .I3(\byte_cnt_reg_n_0_[0] ),
        .I4(\current_state[0]_i_6_n_0 ),
        .I5(\nby_cnt_reg_n_0_[0] ),
        .O(\byte_cnt[0]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \byte_cnt[1]_i_1 
       (.I0(freq_div_en),
        .I1(\byte_cnt[1]_i_2_n_0 ),
        .I2(\byte_cnt[2]_i_3_n_0 ),
        .I3(\byte_cnt[2]_i_4_n_0 ),
        .I4(\byte_cnt_reg_n_0_[1] ),
        .O(\byte_cnt[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000028)) 
    \byte_cnt[1]_i_2 
       (.I0(\current_state[1]_i_4_n_0 ),
        .I1(\byte_cnt_reg_n_0_[0] ),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\current_state_reg_n_0_[0] ),
        .I4(\byte_cnt[2]_i_5_n_0 ),
        .O(\byte_cnt[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \byte_cnt[2]_i_1 
       (.I0(freq_div_en),
        .I1(\byte_cnt[2]_i_2_n_0 ),
        .I2(\byte_cnt[2]_i_3_n_0 ),
        .I3(\byte_cnt[2]_i_4_n_0 ),
        .I4(\byte_cnt_reg_n_0_[2] ),
        .O(\byte_cnt[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000002888)) 
    \byte_cnt[2]_i_2 
       (.I0(\current_state[1]_i_4_n_0 ),
        .I1(\byte_cnt_reg_n_0_[2] ),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\byte_cnt_reg_n_0_[0] ),
        .I4(\current_state_reg_n_0_[0] ),
        .I5(\byte_cnt[2]_i_5_n_0 ),
        .O(\byte_cnt[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \byte_cnt[2]_i_3 
       (.I0(\shift_byte[7]_i_5_n_0 ),
        .I1(restart_reg_n_0),
        .I2(\byte_cnt[2]_i_6_n_0 ),
        .O(\byte_cnt[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h0EFF0E0E)) 
    \byte_cnt[2]_i_4 
       (.I0(\I2C_CFG_reg_n_0_[2] ),
        .I1(\I2C_CFG_reg_n_0_[0] ),
        .I2(freq_div_en),
        .I3(\byte_cnt[2]_i_6_n_0 ),
        .I4(\I2C_CFG[3]_i_5_n_0 ),
        .O(\byte_cnt[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0800FF0F)) 
    \byte_cnt[2]_i_5 
       (.I0(I2C_SCL_reg_0),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(\current_state_reg_n_0_[1] ),
        .I3(\current_state_reg_n_0_[2] ),
        .I4(freq_div_en),
        .I5(restart_reg_n_0),
        .O(\byte_cnt[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFB8FFFF)) 
    \byte_cnt[2]_i_6 
       (.I0(\byte_cnt[2]_i_7_n_0 ),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(\byte_cnt[2]_i_8_n_0 ),
        .I3(\current_state_reg_n_0_[2] ),
        .I4(\current_state_reg_n_0_[1] ),
        .I5(\byte_cnt[2]_i_5_n_0 ),
        .O(\byte_cnt[2]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA2)) 
    \byte_cnt[2]_i_7 
       (.I0(freq_div_en),
        .I1(delay_reg_n_0),
        .I2(r_w_reg_n_0),
        .I3(I2C_SCL_reg_0),
        .I4(\I2C_CFG_reg_n_0_[0] ),
        .O(\byte_cnt[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAA28)) 
    \byte_cnt[2]_i_8 
       (.I0(freq_div_en),
        .I1(I2C_SCL_reg_0),
        .I2(r_w_reg_n_0),
        .I3(\shift_cnt_reg_n_0_[2] ),
        .I4(\shift_cnt_reg_n_0_[1] ),
        .I5(\shift_cnt_reg_n_0_[0] ),
        .O(\byte_cnt[2]_i_8_n_0 ));
  FDCE \byte_cnt_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\byte_cnt[0]_i_1_n_0 ),
        .Q(\byte_cnt_reg_n_0_[0] ));
  FDCE \byte_cnt_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\byte_cnt[1]_i_1_n_0 ),
        .Q(\byte_cnt_reg_n_0_[1] ));
  FDCE \byte_cnt_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\byte_cnt[2]_i_1_n_0 ),
        .Q(\byte_cnt_reg_n_0_[2] ));
  LUT6 #(
    .INIT(64'h08AAFFFF08AA0000)) 
    \current_state[0]_i_1 
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(\current_state[0]_i_2_n_0 ),
        .I2(\current_state[0]_i_3_n_0 ),
        .I3(\current_state[1]_i_3_n_0 ),
        .I4(\current_state[2]_i_6_n_0 ),
        .I5(\current_state_reg_n_0_[0] ),
        .O(\current_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BAAAAFAF)) 
    \current_state[0]_i_2 
       (.I0(\current_state_reg_n_0_[1] ),
        .I1(r_w_reg_n_0),
        .I2(I2C_SCL_reg_0),
        .I3(I2C_SDA),
        .I4(\current_state_reg_n_0_[0] ),
        .I5(\current_state_reg_n_0_[2] ),
        .O(\current_state[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8888888800808888)) 
    \current_state[0]_i_3 
       (.I0(\current_state[0]_i_4_n_0 ),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state[0]_i_5_n_0 ),
        .I3(\shift_byte[0]_i_4_n_0 ),
        .I4(\current_state_reg_n_0_[0] ),
        .I5(\I2C_CFG_reg_n_0_[0] ),
        .O(\current_state[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEFFFFFFFEFFE)) 
    \current_state[0]_i_4 
       (.I0(\current_state[1]_i_6_n_0 ),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(r_w_reg_n_0),
        .I3(I2C_SCL_reg_0),
        .I4(\current_state[0]_i_6_n_0 ),
        .I5(\nby_cnt_reg_n_0_[0] ),
        .O(\current_state[0]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hFD)) 
    \current_state[0]_i_5 
       (.I0(delay_reg_n_0),
        .I1(r_w_reg_n_0),
        .I2(I2C_SCL_reg_0),
        .O(\current_state[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \current_state[0]_i_6 
       (.I0(\nby_cnt_reg_n_0_[2] ),
        .I1(\nby_cnt_reg_n_0_[1] ),
        .O(\current_state[0]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h4FFF4F00)) 
    \current_state[1]_i_1 
       (.I0(\current_state[1]_i_2_n_0 ),
        .I1(\current_state[1]_i_3_n_0 ),
        .I2(\current_state[2]_i_2_n_0 ),
        .I3(\current_state[2]_i_6_n_0 ),
        .I4(\current_state_reg_n_0_[1] ),
        .O(\current_state[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000032003203)) 
    \current_state[1]_i_2 
       (.I0(\current_state[1]_i_4_n_0 ),
        .I1(\current_state_reg_n_0_[2] ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\current_state_reg_n_0_[1] ),
        .I4(I2C_SCL_reg_0),
        .I5(\current_state[1]_i_5_n_0 ),
        .O(\current_state[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFDF)) 
    \current_state[1]_i_3 
       (.I0(\current_state_reg_n_0_[2] ),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(I2C_SCL_reg_0),
        .I3(\current_state_reg_n_0_[1] ),
        .I4(I2C_SDA),
        .O(\current_state[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000A8A800005554)) 
    \current_state[1]_i_4 
       (.I0(r_w_reg_n_0),
        .I1(\nby_cnt_reg_n_0_[2] ),
        .I2(\nby_cnt_reg_n_0_[1] ),
        .I3(\nby_cnt_reg_n_0_[0] ),
        .I4(\current_state[1]_i_6_n_0 ),
        .I5(I2C_SCL_reg_0),
        .O(\current_state[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAF51000000000000)) 
    \current_state[1]_i_5 
       (.I0(\I2C_CFG_reg_n_0_[0] ),
        .I1(delay_reg_n_0),
        .I2(r_w_reg_n_0),
        .I3(I2C_SCL_reg_0),
        .I4(\current_state_reg_n_0_[1] ),
        .I5(\current_state_reg_n_0_[0] ),
        .O(\current_state[1]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \current_state[1]_i_6 
       (.I0(\shift_cnt_reg_n_0_[2] ),
        .I1(\shift_cnt_reg_n_0_[1] ),
        .I2(\shift_cnt_reg_n_0_[0] ),
        .O(\current_state[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h888AFFFF888A0000)) 
    \current_state[2]_i_1 
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(\current_state[2]_i_3_n_0 ),
        .I2(\current_state[2]_i_4_n_0 ),
        .I3(\current_state[2]_i_5_n_0 ),
        .I4(\current_state[2]_i_6_n_0 ),
        .I5(\current_state_reg_n_0_[2] ),
        .O(\current_state[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \current_state[2]_i_10 
       (.I0(\current_state_reg_n_0_[0] ),
        .I1(\current_state_reg_n_0_[1] ),
        .O(\current_state[2]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'hBFBFEFBF)) 
    \current_state[2]_i_11 
       (.I0(\current_state_reg_n_0_[1] ),
        .I1(I2C_SCL_reg_0),
        .I2(freq_div_en),
        .I3(\current_state_reg_n_0_[0] ),
        .I4(r_w_reg_n_0),
        .O(\current_state[2]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \current_state[2]_i_2 
       (.I0(restart_reg_n_0),
        .I1(\current_state[2]_i_7_n_0 ),
        .O(\current_state[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h30100000)) 
    \current_state[2]_i_3 
       (.I0(I2C_SDA),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(I2C_SCL_reg_0),
        .I3(\current_state_reg_n_0_[0] ),
        .I4(\current_state_reg_n_0_[2] ),
        .O(\current_state[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \current_state[2]_i_4 
       (.I0(\current_state_reg_n_0_[1] ),
        .I1(\current_state_reg_n_0_[2] ),
        .I2(\current_state_reg_n_0_[0] ),
        .O(\current_state[2]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hC7)) 
    \current_state[2]_i_5 
       (.I0(r_w_reg_n_0),
        .I1(I2C_SCL_reg_0),
        .I2(\I2C_CFG_reg_n_0_[0] ),
        .O(\current_state[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h050D050F050D0505)) 
    \current_state[2]_i_6 
       (.I0(freq_div_en),
        .I1(I2C_SCL_reg_0),
        .I2(\shift_byte[7]_i_4_n_0 ),
        .I3(\shift_byte[7]_i_5_n_0 ),
        .I4(restart_reg_n_0),
        .I5(\current_state[2]_i_8_n_0 ),
        .O(\current_state[2]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFBFFFFFF)) 
    \current_state[2]_i_7 
       (.I0(\I2C_CFG[3]_i_6_n_0 ),
        .I1(\freq_div_cnt_reg_n_0_[2] ),
        .I2(\freq_div_cnt_reg_n_0_[1] ),
        .I3(\freq_div_cnt_reg_n_0_[3] ),
        .I4(freq_div_en),
        .O(\current_state[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAFEAAAAAAAA)) 
    \current_state[2]_i_8 
       (.I0(\current_state[2]_i_3_n_0 ),
        .I1(\current_state[2]_i_9_n_0 ),
        .I2(\current_state[2]_i_10_n_0 ),
        .I3(\current_state[1]_i_5_n_0 ),
        .I4(\current_state_reg_n_0_[2] ),
        .I5(\current_state[2]_i_11_n_0 ),
        .O(\current_state[2]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000009F)) 
    \current_state[2]_i_9 
       (.I0(r_w_reg_n_0),
        .I1(I2C_SCL_reg_0),
        .I2(freq_div_en),
        .I3(\shift_cnt_reg_n_0_[0] ),
        .I4(\shift_cnt_reg_n_0_[1] ),
        .I5(\shift_cnt_reg_n_0_[2] ),
        .O(\current_state[2]_i_9_n_0 ));
  FDCE \current_state_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\current_state[0]_i_1_n_0 ),
        .Q(\current_state_reg_n_0_[0] ));
  FDPE \current_state_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .D(\current_state[1]_i_1_n_0 ),
        .PRE(I2C_SCL_i_2_n_0),
        .Q(\current_state_reg_n_0_[1] ));
  FDCE \current_state_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\current_state[2]_i_1_n_0 ),
        .Q(\current_state_reg_n_0_[2] ));
  LUT6 #(
    .INIT(64'hFFFF0000FFFF0002)) 
    delay_i_1
       (.I0(\I2C_CFG[3]_i_5_n_0 ),
        .I1(r_w_reg_n_0),
        .I2(I2C_SCL_reg_0),
        .I3(\I2C_CFG_reg_n_0_[0] ),
        .I4(delay_reg_n_0),
        .I5(\current_state[2]_i_4_n_0 ),
        .O(delay_i_1_n_0));
  FDCE delay_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(delay_i_1_n_0),
        .Q(delay_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \freq_div_cnt[0]_i_1 
       (.I0(freq_div_en),
        .I1(\freq_div_cnt_reg_n_0_[0] ),
        .O(\freq_div_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h60)) 
    \freq_div_cnt[1]_i_1 
       (.I0(\freq_div_cnt_reg_n_0_[1] ),
        .I1(\freq_div_cnt_reg_n_0_[0] ),
        .I2(freq_div_en),
        .O(\freq_div_cnt[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00E0F000F000F000)) 
    \freq_div_cnt[2]_i_1 
       (.I0(\freq_div_cnt[2]_i_2_n_0 ),
        .I1(\freq_div_cnt_reg_n_0_[6] ),
        .I2(freq_div_en),
        .I3(\freq_div_cnt_reg_n_0_[2] ),
        .I4(\freq_div_cnt_reg_n_0_[1] ),
        .I5(\freq_div_cnt_reg_n_0_[0] ),
        .O(\freq_div_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \freq_div_cnt[2]_i_2 
       (.I0(\freq_div_cnt_reg_n_0_[3] ),
        .I1(\freq_div_cnt_reg_n_0_[4] ),
        .I2(\freq_div_cnt_reg_n_0_[5] ),
        .O(\freq_div_cnt[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h2AAA8000)) 
    \freq_div_cnt[3]_i_1 
       (.I0(I2C_SCL_i_3_n_0),
        .I1(\freq_div_cnt_reg_n_0_[2] ),
        .I2(\freq_div_cnt_reg_n_0_[1] ),
        .I3(\freq_div_cnt_reg_n_0_[0] ),
        .I4(\freq_div_cnt_reg_n_0_[3] ),
        .O(\freq_div_cnt[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2AAAAAAA80000000)) 
    \freq_div_cnt[4]_i_1 
       (.I0(I2C_SCL_i_3_n_0),
        .I1(\freq_div_cnt_reg_n_0_[0] ),
        .I2(\freq_div_cnt_reg_n_0_[1] ),
        .I3(\freq_div_cnt_reg_n_0_[2] ),
        .I4(\freq_div_cnt_reg_n_0_[3] ),
        .I5(\freq_div_cnt_reg_n_0_[4] ),
        .O(\freq_div_cnt[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'h2AAA8000)) 
    \freq_div_cnt[5]_i_1 
       (.I0(I2C_SCL_i_3_n_0),
        .I1(\freq_div_cnt[6]_i_2_n_0 ),
        .I2(\freq_div_cnt_reg_n_0_[3] ),
        .I3(\freq_div_cnt_reg_n_0_[4] ),
        .I4(\freq_div_cnt_reg_n_0_[5] ),
        .O(\freq_div_cnt[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2AAAAAAA80000000)) 
    \freq_div_cnt[6]_i_1 
       (.I0(freq_div_en),
        .I1(\freq_div_cnt[6]_i_2_n_0 ),
        .I2(\freq_div_cnt_reg_n_0_[5] ),
        .I3(\freq_div_cnt_reg_n_0_[4] ),
        .I4(\freq_div_cnt_reg_n_0_[3] ),
        .I5(\freq_div_cnt_reg_n_0_[6] ),
        .O(\freq_div_cnt[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \freq_div_cnt[6]_i_2 
       (.I0(\freq_div_cnt_reg_n_0_[2] ),
        .I1(\freq_div_cnt_reg_n_0_[1] ),
        .I2(\freq_div_cnt_reg_n_0_[0] ),
        .O(\freq_div_cnt[6]_i_2_n_0 ));
  FDCE \freq_div_cnt_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\freq_div_cnt[0]_i_1_n_0 ),
        .Q(\freq_div_cnt_reg_n_0_[0] ));
  FDCE \freq_div_cnt_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\freq_div_cnt[1]_i_1_n_0 ),
        .Q(\freq_div_cnt_reg_n_0_[1] ));
  FDCE \freq_div_cnt_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\freq_div_cnt[2]_i_1_n_0 ),
        .Q(\freq_div_cnt_reg_n_0_[2] ));
  FDCE \freq_div_cnt_reg[3] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\freq_div_cnt[3]_i_1_n_0 ),
        .Q(\freq_div_cnt_reg_n_0_[3] ));
  FDCE \freq_div_cnt_reg[4] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\freq_div_cnt[4]_i_1_n_0 ),
        .Q(\freq_div_cnt_reg_n_0_[4] ));
  FDCE \freq_div_cnt_reg[5] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\freq_div_cnt[5]_i_1_n_0 ),
        .Q(\freq_div_cnt_reg_n_0_[5] ));
  FDCE \freq_div_cnt_reg[6] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\freq_div_cnt[6]_i_1_n_0 ),
        .Q(\freq_div_cnt_reg_n_0_[6] ));
  LUT6 #(
    .INIT(64'h5555FFFCFF54FFFC)) 
    freq_div_en_i_1
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(\I2C_CFG_reg_n_0_[2] ),
        .I2(\I2C_CFG_reg_n_0_[0] ),
        .I3(freq_div_en),
        .I4(\I2C_CFG[2]_i_2_n_0 ),
        .I5(\I2C_CFG[3]_i_5_n_0 ),
        .O(freq_div_en_i_1_n_0));
  FDCE freq_div_en_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(freq_div_en_i_1_n_0),
        .Q(freq_div_en));
  LUT3 #(
    .INIT(8'hB8)) 
    is_read_op_i_1
       (.I0(freq_div_en),
        .I1(is_read_op19_out),
        .I2(is_read_op_reg_n_0),
        .O(is_read_op_i_1_n_0));
  LUT6 #(
    .INIT(64'h0E00EEEE0000EEEE)) 
    is_read_op_i_2
       (.I0(\I2C_CFG_reg_n_0_[2] ),
        .I1(\I2C_CFG_reg_n_0_[0] ),
        .I2(\shift_byte[7]_i_5_n_0 ),
        .I3(I2C_SCL_reg_0),
        .I4(freq_div_en),
        .I5(restart_reg_n_0),
        .O(is_read_op19_out));
  FDCE is_read_op_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(is_read_op_i_1_n_0),
        .Q(is_read_op_reg_n_0));
  LUT6 #(
    .INIT(64'h4F44FFFF4F440000)) 
    \nby_cnt[0]_i_1 
       (.I0(\nby_cnt[0]_i_2_n_0 ),
        .I1(\nby_cnt[0]_i_3_n_0 ),
        .I2(\nby_cnt[0]_i_4_n_0 ),
        .I3(\nby_cnt[0]_i_5_n_0 ),
        .I4(\nby_cnt[2]_i_5_n_0 ),
        .I5(\nby_cnt_reg_n_0_[0] ),
        .O(\nby_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \nby_cnt[0]_i_2 
       (.I0(\I2C_CFG_reg_n_0_[0] ),
        .I1(\I2C_NBY_reg_n_0_[0] ),
        .O(\nby_cnt[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \nby_cnt[0]_i_3 
       (.I0(\current_state[2]_i_7_n_0 ),
        .I1(I2C_SCL_reg_0),
        .I2(restart_reg_n_0),
        .O(\nby_cnt[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAFFFEAAAA)) 
    \nby_cnt[0]_i_4 
       (.I0(restart_reg_n_0),
        .I1(\shift_byte[6]_i_2_n_0 ),
        .I2(\nby_cnt[0]_i_6_n_0 ),
        .I3(\current_state[2]_i_7_n_0 ),
        .I4(\I2C_CFG_reg_n_0_[0] ),
        .I5(\I2C_NBY_reg_n_0_[0] ),
        .O(\nby_cnt[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFDFCFDFFFDFFFDF)) 
    \nby_cnt[0]_i_5 
       (.I0(\current_state[1]_i_4_n_0 ),
        .I1(\shift_cnt[2]_i_4_n_0 ),
        .I2(\nby_cnt[0]_i_6_n_0 ),
        .I3(\current_state_reg_n_0_[0] ),
        .I4(\I2C_NBY_reg_n_0_[0] ),
        .I5(\nby_cnt[0]_i_7_n_0 ),
        .O(\nby_cnt[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hFEFEFEFF)) 
    \nby_cnt[0]_i_6 
       (.I0(\current_state[1]_i_6_n_0 ),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(\nby_cnt_reg_n_0_[0] ),
        .I3(\nby_cnt_reg_n_0_[2] ),
        .I4(\nby_cnt_reg_n_0_[1] ),
        .O(\nby_cnt[0]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h0200)) 
    \nby_cnt[0]_i_7 
       (.I0(is_read_op_reg_n_0),
        .I1(I2C_SCL_reg_0),
        .I2(r_w_reg_n_0),
        .I3(delay_reg_n_0),
        .O(\nby_cnt[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hEFE0)) 
    \nby_cnt[1]_i_1 
       (.I0(\nby_cnt[1]_i_2_n_0 ),
        .I1(\nby_cnt[1]_i_3_n_0 ),
        .I2(\nby_cnt[2]_i_5_n_0 ),
        .I3(\nby_cnt_reg_n_0_[1] ),
        .O(\nby_cnt[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F1000000)) 
    \nby_cnt[1]_i_2 
       (.I0(\current_state_reg_n_0_[0] ),
        .I1(\current_state[1]_i_4_n_0 ),
        .I2(\shift_cnt[2]_i_4_n_0 ),
        .I3(\I2C_CFG_reg_n_0_[0] ),
        .I4(\I2C_NBY_reg_n_0_[1] ),
        .I5(restart_reg_n_0),
        .O(\nby_cnt[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h88888888080800FF)) 
    \nby_cnt[1]_i_3 
       (.I0(\I2C_CFG_reg_n_0_[0] ),
        .I1(\I2C_NBY_reg_n_0_[1] ),
        .I2(I2C_SCL_reg_0),
        .I3(\nby_cnt[1]_i_4_n_0 ),
        .I4(restart_reg_n_0),
        .I5(\current_state[2]_i_7_n_0 ),
        .O(\nby_cnt[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFDDFFFFFFDDFFF0)) 
    \nby_cnt[1]_i_4 
       (.I0(\I2C_NBY_reg_n_0_[1] ),
        .I1(\nby_cnt[2]_i_7_n_0 ),
        .I2(\nby_cnt[1]_i_5_n_0 ),
        .I3(\shift_cnt[2]_i_4_n_0 ),
        .I4(\current_state_reg_n_0_[0] ),
        .I5(\nby_cnt[1]_i_6_n_0 ),
        .O(\nby_cnt[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFEFEFFFFFFFFFEFF)) 
    \nby_cnt[1]_i_5 
       (.I0(\shift_cnt_reg_n_0_[0] ),
        .I1(\shift_cnt_reg_n_0_[1] ),
        .I2(\shift_cnt_reg_n_0_[2] ),
        .I3(\nby_cnt_reg_n_0_[2] ),
        .I4(\nby_cnt_reg_n_0_[1] ),
        .I5(\nby_cnt_reg_n_0_[0] ),
        .O(\nby_cnt[1]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \nby_cnt[1]_i_6 
       (.I0(I2C_SCL_reg_0),
        .I1(r_w_reg_n_0),
        .O(\nby_cnt[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFD0FFFFFFD00000)) 
    \nby_cnt[2]_i_1 
       (.I0(\nby_cnt[2]_i_2_n_0 ),
        .I1(\nby_cnt[2]_i_3_n_0 ),
        .I2(\current_state[2]_i_2_n_0 ),
        .I3(\nby_cnt[2]_i_4_n_0 ),
        .I4(\nby_cnt[2]_i_5_n_0 ),
        .I5(\nby_cnt_reg_n_0_[2] ),
        .O(\nby_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0100)) 
    \nby_cnt[2]_i_10 
       (.I0(\I2C_CFG_reg_n_0_[0] ),
        .I1(I2C_SCL_reg_0),
        .I2(r_w_reg_n_0),
        .I3(delay_reg_n_0),
        .O(\nby_cnt[2]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \nby_cnt[2]_i_11 
       (.I0(I2C_SCL_reg_0),
        .I1(freq_div_en),
        .I2(restart_reg_n_0),
        .O(\nby_cnt[2]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h373737F7F7F7F737)) 
    \nby_cnt[2]_i_2 
       (.I0(\nby_cnt[2]_i_6_n_0 ),
        .I1(\shift_cnt[0]_i_2_n_0 ),
        .I2(\current_state[1]_i_4_n_0 ),
        .I3(\nby_cnt_reg_n_0_[1] ),
        .I4(\nby_cnt_reg_n_0_[0] ),
        .I5(\nby_cnt_reg_n_0_[2] ),
        .O(\nby_cnt[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hF0004400F000F000)) 
    \nby_cnt[2]_i_3 
       (.I0(\nby_cnt[2]_i_7_n_0 ),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(\I2C_CFG_reg_n_0_[0] ),
        .I3(\I2C_NBY_reg_n_0_[2] ),
        .I4(\current_state_reg_n_0_[2] ),
        .I5(\current_state_reg_n_0_[1] ),
        .O(\nby_cnt[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hF2000000)) 
    \nby_cnt[2]_i_4 
       (.I0(restart_reg_n_0),
        .I1(I2C_SCL_reg_0),
        .I2(\current_state[2]_i_7_n_0 ),
        .I3(\I2C_NBY_reg_n_0_[2] ),
        .I4(\I2C_CFG_reg_n_0_[0] ),
        .O(\nby_cnt[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAAA8A8A888888888)) 
    \nby_cnt[2]_i_5 
       (.I0(rst_n),
        .I1(awready_i_3_n_0),
        .I2(\nby_cnt[2]_i_8_n_0 ),
        .I3(\shift_cnt[0]_i_2_n_0 ),
        .I4(\current_state[1]_i_4_n_0 ),
        .I5(\nby_cnt[2]_i_9_n_0 ),
        .O(\nby_cnt[2]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \nby_cnt[2]_i_6 
       (.I0(\I2C_CFG_reg_n_0_[0] ),
        .I1(\I2C_NBY_reg_n_0_[2] ),
        .O(\nby_cnt[2]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h55515555)) 
    \nby_cnt[2]_i_7 
       (.I0(\I2C_CFG_reg_n_0_[0] ),
        .I1(delay_reg_n_0),
        .I2(r_w_reg_n_0),
        .I3(I2C_SCL_reg_0),
        .I4(is_read_op_reg_n_0),
        .O(\nby_cnt[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0080FFAA)) 
    \nby_cnt[2]_i_8 
       (.I0(\current_state_reg_n_0_[0] ),
        .I1(is_read_op_reg_n_0),
        .I2(\nby_cnt[2]_i_10_n_0 ),
        .I3(\shift_cnt[2]_i_4_n_0 ),
        .I4(freq_div_en),
        .I5(restart_reg_n_0),
        .O(\nby_cnt[2]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000100000)) 
    \nby_cnt[2]_i_9 
       (.I0(\shift_byte[7]_i_4_n_0 ),
        .I1(\nby_cnt[2]_i_11_n_0 ),
        .I2(\freq_div_cnt_reg_n_0_[3] ),
        .I3(\freq_div_cnt_reg_n_0_[1] ),
        .I4(\freq_div_cnt_reg_n_0_[2] ),
        .I5(\I2C_CFG[3]_i_6_n_0 ),
        .O(\nby_cnt[2]_i_9_n_0 ));
  FDRE \nby_cnt_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .D(\nby_cnt[0]_i_1_n_0 ),
        .Q(\nby_cnt_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \nby_cnt_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .D(\nby_cnt[1]_i_1_n_0 ),
        .Q(\nby_cnt_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \nby_cnt_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .D(\nby_cnt[2]_i_1_n_0 ),
        .Q(\nby_cnt_reg_n_0_[2] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFF11FF51EE00AA00)) 
    r_w_i_1
       (.I0(awready_i_3_n_0),
        .I1(\I2C_CFG[3]_i_5_n_0 ),
        .I2(r_w_i_2_n_0),
        .I3(freq_div_en),
        .I4(r_w_i_3_n_0),
        .I5(r_w_reg_n_0),
        .O(r_w_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    r_w_i_2
       (.I0(\current_state_reg_n_0_[2] ),
        .I1(\current_state_reg_n_0_[1] ),
        .O(r_w_i_2_n_0));
  LUT6 #(
    .INIT(64'h000008000000FFFF)) 
    r_w_i_3
       (.I0(delay_reg_n_0),
        .I1(byte_cnt1),
        .I2(\I2C_CFG_reg_n_0_[0] ),
        .I3(is_read_op_reg_n_0),
        .I4(\current_state[2]_i_4_n_0 ),
        .I5(freq_div_en),
        .O(r_w_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h1)) 
    r_w_i_4
       (.I0(I2C_SCL_reg_0),
        .I1(r_w_reg_n_0),
        .O(byte_cnt1));
  FDCE r_w_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(r_w_i_1_n_0),
        .Q(r_w_reg_n_0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[0]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[0] ),
        .I1(araddr[4]),
        .I2(\rdata[0]_i_2_n_0 ),
        .O(\rdata[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[0]_i_2 
       (.I0(\I2C_TDR_reg_n_0_[0] ),
        .I1(\I2C_RDR_reg_n_0_[0] ),
        .I2(araddr[3]),
        .I3(I2C_ADR__0[0]),
        .I4(araddr[2]),
        .I5(\I2C_NBY_reg_n_0_[0] ),
        .O(\rdata[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[10]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[10] ),
        .I1(araddr[4]),
        .I2(\rdata[10]_i_2_n_0 ),
        .O(\rdata[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[10]_i_2 
       (.I0(data1[2]),
        .I1(\I2C_RDR_reg_n_0_[10] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[10]),
        .O(\rdata[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[11]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[11] ),
        .I1(araddr[4]),
        .I2(\rdata[11]_i_2_n_0 ),
        .O(\rdata[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[11]_i_2 
       (.I0(data1[3]),
        .I1(\I2C_RDR_reg_n_0_[11] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[11]),
        .O(\rdata[11]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[12]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[12] ),
        .I1(araddr[4]),
        .I2(\rdata[12]_i_2_n_0 ),
        .O(\rdata[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[12]_i_2 
       (.I0(data1[4]),
        .I1(\I2C_RDR_reg_n_0_[12] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[12]),
        .O(\rdata[12]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[13]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[13] ),
        .I1(araddr[4]),
        .I2(\rdata[13]_i_2_n_0 ),
        .O(\rdata[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[13]_i_2 
       (.I0(data1[5]),
        .I1(\I2C_RDR_reg_n_0_[13] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[13]),
        .O(\rdata[13]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[14]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[14] ),
        .I1(araddr[4]),
        .I2(\rdata[14]_i_2_n_0 ),
        .O(\rdata[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[14]_i_2 
       (.I0(data1[6]),
        .I1(\I2C_RDR_reg_n_0_[14] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[14]),
        .O(\rdata[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[15]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[15] ),
        .I1(araddr[4]),
        .I2(\rdata[15]_i_2_n_0 ),
        .O(\rdata[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[15]_i_2 
       (.I0(data1[7]),
        .I1(\I2C_RDR_reg_n_0_[15] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[15]),
        .O(\rdata[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[16]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[16] ),
        .I1(araddr[4]),
        .I2(\rdata[16]_i_2_n_0 ),
        .O(\rdata[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[16]_i_2 
       (.I0(data2[0]),
        .I1(\I2C_RDR_reg_n_0_[16] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[16]),
        .O(\rdata[16]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[17]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[17] ),
        .I1(araddr[4]),
        .I2(\rdata[17]_i_2_n_0 ),
        .O(\rdata[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[17]_i_2 
       (.I0(data2[1]),
        .I1(\I2C_RDR_reg_n_0_[17] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[17]),
        .O(\rdata[17]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[18]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[18] ),
        .I1(araddr[4]),
        .I2(\rdata[18]_i_2_n_0 ),
        .O(\rdata[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[18]_i_2 
       (.I0(data2[2]),
        .I1(\I2C_RDR_reg_n_0_[18] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[18]),
        .O(\rdata[18]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[19]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[19] ),
        .I1(araddr[4]),
        .I2(\rdata[19]_i_2_n_0 ),
        .O(\rdata[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[19]_i_2 
       (.I0(data2[3]),
        .I1(\I2C_RDR_reg_n_0_[19] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[19]),
        .O(\rdata[19]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[1]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[1] ),
        .I1(araddr[4]),
        .I2(\rdata[1]_i_2_n_0 ),
        .O(\rdata[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[1]_i_2 
       (.I0(\I2C_TDR_reg_n_0_[1] ),
        .I1(\I2C_RDR_reg_n_0_[1] ),
        .I2(araddr[3]),
        .I3(I2C_ADR__0[1]),
        .I4(araddr[2]),
        .I5(\I2C_NBY_reg_n_0_[1] ),
        .O(\rdata[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[20]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[20] ),
        .I1(araddr[4]),
        .I2(\rdata[20]_i_2_n_0 ),
        .O(\rdata[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[20]_i_2 
       (.I0(data2[4]),
        .I1(\I2C_RDR_reg_n_0_[20] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[20]),
        .O(\rdata[20]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[21]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[21] ),
        .I1(araddr[4]),
        .I2(\rdata[21]_i_2_n_0 ),
        .O(\rdata[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[21]_i_2 
       (.I0(data2[5]),
        .I1(\I2C_RDR_reg_n_0_[21] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[21]),
        .O(\rdata[21]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[22]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[22] ),
        .I1(araddr[4]),
        .I2(\rdata[22]_i_2_n_0 ),
        .O(\rdata[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[22]_i_2 
       (.I0(data2[6]),
        .I1(\I2C_RDR_reg_n_0_[22] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[22]),
        .O(\rdata[22]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[23]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[23] ),
        .I1(araddr[4]),
        .I2(\rdata[23]_i_2_n_0 ),
        .O(\rdata[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[23]_i_2 
       (.I0(data2[7]),
        .I1(\I2C_RDR_reg_n_0_[23] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[23]),
        .O(\rdata[23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[24]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[24] ),
        .I1(araddr[4]),
        .I2(\rdata[24]_i_2_n_0 ),
        .O(\rdata[24]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[24]_i_2 
       (.I0(data3[0]),
        .I1(\I2C_RDR_reg_n_0_[24] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[24]),
        .O(\rdata[24]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[25]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[25] ),
        .I1(araddr[4]),
        .I2(\rdata[25]_i_2_n_0 ),
        .O(\rdata[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[25]_i_2 
       (.I0(data3[1]),
        .I1(\I2C_RDR_reg_n_0_[25] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[25]),
        .O(\rdata[25]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[26]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[26] ),
        .I1(araddr[4]),
        .I2(\rdata[26]_i_2_n_0 ),
        .O(\rdata[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[26]_i_2 
       (.I0(data3[2]),
        .I1(\I2C_RDR_reg_n_0_[26] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[26]),
        .O(\rdata[26]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[27]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[27] ),
        .I1(araddr[4]),
        .I2(\rdata[27]_i_2_n_0 ),
        .O(\rdata[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[27]_i_2 
       (.I0(data3[3]),
        .I1(\I2C_RDR_reg_n_0_[27] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[27]),
        .O(\rdata[27]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[28]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[28] ),
        .I1(araddr[4]),
        .I2(\rdata[28]_i_2_n_0 ),
        .O(\rdata[28]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[28]_i_2 
       (.I0(data3[4]),
        .I1(\I2C_RDR_reg_n_0_[28] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[28]),
        .O(\rdata[28]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[29]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[29] ),
        .I1(araddr[4]),
        .I2(\rdata[29]_i_2_n_0 ),
        .O(\rdata[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[29]_i_2 
       (.I0(data3[5]),
        .I1(\I2C_RDR_reg_n_0_[29] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[29]),
        .O(\rdata[29]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[2]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[2] ),
        .I1(araddr[4]),
        .I2(\rdata[2]_i_2_n_0 ),
        .O(\rdata[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[2]_i_2 
       (.I0(\I2C_TDR_reg_n_0_[2] ),
        .I1(\I2C_RDR_reg_n_0_[2] ),
        .I2(araddr[3]),
        .I3(I2C_ADR__0[2]),
        .I4(araddr[2]),
        .I5(\I2C_NBY_reg_n_0_[2] ),
        .O(\rdata[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[30]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[30] ),
        .I1(araddr[4]),
        .I2(\rdata[30]_i_2_n_0 ),
        .O(\rdata[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[30]_i_2 
       (.I0(data3[6]),
        .I1(\I2C_RDR_reg_n_0_[30] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[30]),
        .O(\rdata[30]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h001F)) 
    \rdata[31]_i_1 
       (.I0(araddr[3]),
        .I1(araddr[2]),
        .I2(araddr[4]),
        .I3(\rdata[31]_i_3_n_0 ),
        .O(\rdata[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[31]_i_2 
       (.I0(\I2C_CFG_reg_n_0_[31] ),
        .I1(araddr[4]),
        .I2(\rdata[31]_i_4_n_0 ),
        .O(\rdata[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFEFFFFFFFF)) 
    \rdata[31]_i_3 
       (.I0(araddr[7]),
        .I1(araddr[0]),
        .I2(araddr[1]),
        .I3(araddr[5]),
        .I4(araddr[6]),
        .I5(arvalid),
        .O(\rdata[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[31]_i_4 
       (.I0(data3[7]),
        .I1(\I2C_RDR_reg_n_0_[31] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[31]),
        .O(\rdata[31]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[3]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[3] ),
        .I1(araddr[4]),
        .I2(\rdata[3]_i_2_n_0 ),
        .O(\rdata[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[3]_i_2 
       (.I0(\I2C_TDR_reg_n_0_[3] ),
        .I1(\I2C_RDR_reg_n_0_[3] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[3]),
        .O(\rdata[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[4]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[4] ),
        .I1(araddr[4]),
        .I2(\rdata[4]_i_2_n_0 ),
        .O(\rdata[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[4]_i_2 
       (.I0(\I2C_TDR_reg_n_0_[4] ),
        .I1(\I2C_RDR_reg_n_0_[4] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[4]),
        .O(\rdata[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[5]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[5] ),
        .I1(araddr[4]),
        .I2(\rdata[5]_i_2_n_0 ),
        .O(\rdata[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[5]_i_2 
       (.I0(\I2C_TDR_reg_n_0_[5] ),
        .I1(\I2C_RDR_reg_n_0_[5] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[5]),
        .O(\rdata[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[6]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[6] ),
        .I1(araddr[4]),
        .I2(\rdata[6]_i_2_n_0 ),
        .O(\rdata[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[6]_i_2 
       (.I0(\I2C_TDR_reg_n_0_[6] ),
        .I1(\I2C_RDR_reg_n_0_[6] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[6]),
        .O(\rdata[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[7]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[7] ),
        .I1(araddr[4]),
        .I2(\rdata[7]_i_2_n_0 ),
        .O(\rdata[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[7]_i_2 
       (.I0(\I2C_TDR_reg_n_0_[7] ),
        .I1(\I2C_RDR_reg_n_0_[7] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[7]),
        .O(\rdata[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[8]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[8] ),
        .I1(araddr[4]),
        .I2(\rdata[8]_i_2_n_0 ),
        .O(\rdata[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[8]_i_2 
       (.I0(data1[0]),
        .I1(\I2C_RDR_reg_n_0_[8] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[8]),
        .O(\rdata[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[9]_i_1 
       (.I0(\I2C_CFG_reg_n_0_[9] ),
        .I1(araddr[4]),
        .I2(\rdata[9]_i_2_n_0 ),
        .O(\rdata[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rdata[9]_i_2 
       (.I0(data1[1]),
        .I1(\I2C_RDR_reg_n_0_[9] ),
        .I2(araddr[3]),
        .I3(araddr[2]),
        .I4(I2C_ADR__0[9]),
        .O(\rdata[9]_i_2_n_0 ));
  FDCE \rdata_reg[0] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[0]_i_1_n_0 ),
        .Q(rdata[0]));
  FDCE \rdata_reg[10] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[10]_i_1_n_0 ),
        .Q(rdata[10]));
  FDCE \rdata_reg[11] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[11]_i_1_n_0 ),
        .Q(rdata[11]));
  FDCE \rdata_reg[12] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[12]_i_1_n_0 ),
        .Q(rdata[12]));
  FDCE \rdata_reg[13] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[13]_i_1_n_0 ),
        .Q(rdata[13]));
  FDCE \rdata_reg[14] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[14]_i_1_n_0 ),
        .Q(rdata[14]));
  FDCE \rdata_reg[15] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[15]_i_1_n_0 ),
        .Q(rdata[15]));
  FDCE \rdata_reg[16] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[16]_i_1_n_0 ),
        .Q(rdata[16]));
  FDCE \rdata_reg[17] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[17]_i_1_n_0 ),
        .Q(rdata[17]));
  FDCE \rdata_reg[18] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[18]_i_1_n_0 ),
        .Q(rdata[18]));
  FDCE \rdata_reg[19] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[19]_i_1_n_0 ),
        .Q(rdata[19]));
  FDCE \rdata_reg[1] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[1]_i_1_n_0 ),
        .Q(rdata[1]));
  FDCE \rdata_reg[20] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[20]_i_1_n_0 ),
        .Q(rdata[20]));
  FDCE \rdata_reg[21] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[21]_i_1_n_0 ),
        .Q(rdata[21]));
  FDCE \rdata_reg[22] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[22]_i_1_n_0 ),
        .Q(rdata[22]));
  FDCE \rdata_reg[23] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[23]_i_1_n_0 ),
        .Q(rdata[23]));
  FDCE \rdata_reg[24] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[24]_i_1_n_0 ),
        .Q(rdata[24]));
  FDCE \rdata_reg[25] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[25]_i_1_n_0 ),
        .Q(rdata[25]));
  FDCE \rdata_reg[26] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[26]_i_1_n_0 ),
        .Q(rdata[26]));
  FDCE \rdata_reg[27] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[27]_i_1_n_0 ),
        .Q(rdata[27]));
  FDCE \rdata_reg[28] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[28]_i_1_n_0 ),
        .Q(rdata[28]));
  FDCE \rdata_reg[29] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[29]_i_1_n_0 ),
        .Q(rdata[29]));
  FDCE \rdata_reg[2] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[2]_i_1_n_0 ),
        .Q(rdata[2]));
  FDCE \rdata_reg[30] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[30]_i_1_n_0 ),
        .Q(rdata[30]));
  FDCE \rdata_reg[31] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[31]_i_2_n_0 ),
        .Q(rdata[31]));
  FDCE \rdata_reg[3] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[3]_i_1_n_0 ),
        .Q(rdata[3]));
  FDCE \rdata_reg[4] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[4]_i_1_n_0 ),
        .Q(rdata[4]));
  FDCE \rdata_reg[5] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[5]_i_1_n_0 ),
        .Q(rdata[5]));
  FDCE \rdata_reg[6] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[6]_i_1_n_0 ),
        .Q(rdata[6]));
  FDCE \rdata_reg[7] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[7]_i_1_n_0 ),
        .Q(rdata[7]));
  FDCE \rdata_reg[8] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[8]_i_1_n_0 ),
        .Q(rdata[8]));
  FDCE \rdata_reg[9] 
       (.C(clk_i),
        .CE(\rdata[31]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\rdata[9]_i_1_n_0 ),
        .Q(rdata[9]));
  LUT5 #(
    .INIT(32'h30338A88)) 
    restart_i_1
       (.I0(delay_reg_n_0),
        .I1(restart_i_2_n_0),
        .I2(restart_i_3_n_0),
        .I3(\current_state[2]_i_2_n_0 ),
        .I4(restart_reg_n_0),
        .O(restart_i_1_n_0));
  LUT6 #(
    .INIT(64'h0080008000800000)) 
    restart_i_2
       (.I0(restart_reg_n_0),
        .I1(freq_div_en),
        .I2(I2C_SCL_reg_0),
        .I3(\shift_byte[7]_i_5_n_0 ),
        .I4(\I2C_CFG_reg_n_0_[0] ),
        .I5(\I2C_CFG_reg_n_0_[2] ),
        .O(restart_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF7FF)) 
    restart_i_3
       (.I0(byte_cnt1),
        .I1(delay_reg_n_0),
        .I2(\current_state[2]_i_4_n_0 ),
        .I3(\I2C_CFG_reg_n_0_[2] ),
        .I4(\I2C_CFG_reg_n_0_[0] ),
        .I5(is_read_op_reg_n_0),
        .O(restart_i_3_n_0));
  FDCE restart_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(restart_i_1_n_0),
        .Q(restart_reg_n_0));
  LUT3 #(
    .INIT(8'hAE)) 
    rvalid_i_1
       (.I0(arvalid),
        .I1(rvalid),
        .I2(rready),
        .O(rvalid_i_1_n_0));
  FDCE rvalid_reg
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(rvalid_i_1_n_0),
        .Q(rvalid));
  LUT6 #(
    .INIT(64'hABBBBBBBA8888888)) 
    sda_out_val_i_1
       (.I0(sda_out_val_i_2_n_0),
        .I1(is_read_op19_out),
        .I2(\I2C_CFG[3]_i_5_n_0 ),
        .I3(sda_out_val_i_3_n_0),
        .I4(sda_out_val_i_4_n_0),
        .I5(sda_out_val_reg_n_0),
        .O(sda_out_val_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hF100FB00)) 
    sda_out_val_i_2
       (.I0(restart_reg_n_0),
        .I1(sda_out_val_i_5_n_0),
        .I2(\shift_byte[7]_i_5_n_0 ),
        .I3(freq_div_en),
        .I4(I2C_SCL_reg_0),
        .O(sda_out_val_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    sda_out_val_i_3
       (.I0(\current_state_reg_n_0_[1] ),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(\current_state_reg_n_0_[2] ),
        .O(sda_out_val_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFBBBF0000)) 
    sda_out_val_i_4
       (.I0(\current_state_reg_n_0_[0] ),
        .I1(freq_div_en),
        .I2(I2C_SCL_reg_0),
        .I3(r_w_reg_n_0),
        .I4(\byte_cnt[0]_i_5_n_0 ),
        .I5(sda_out_val_i_6_n_0),
        .O(sda_out_val_i_4_n_0));
  LUT6 #(
    .INIT(64'h0000EEEE0E00EEEE)) 
    sda_out_val_i_5
       (.I0(sda_out_val_i_7_n_0),
        .I1(sda_out_val_i_8_n_0),
        .I2(\current_state_reg_n_0_[1] ),
        .I3(\current_state_reg_n_0_[0] ),
        .I4(\current_state_reg_n_0_[2] ),
        .I5(I2C_SCL_reg_0),
        .O(sda_out_val_i_5_n_0));
  LUT6 #(
    .INIT(64'hCDDDCDDDCCDDCDDD)) 
    sda_out_val_i_6
       (.I0(\current_state_reg_n_0_[1] ),
        .I1(\current_state_reg_n_0_[2] ),
        .I2(I2C_SCL_reg_0),
        .I3(freq_div_en),
        .I4(\current_state_reg_n_0_[0] ),
        .I5(r_w_reg_n_0),
        .O(sda_out_val_i_6_n_0));
  LUT6 #(
    .INIT(64'hAAAAAABAAAAABBBA)) 
    sda_out_val_i_7
       (.I0(\current_state_reg_n_0_[2] ),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(r_w_reg_n_0),
        .I3(I2C_SCL_reg_0),
        .I4(\current_state_reg_n_0_[0] ),
        .I5(freq_div_en),
        .O(sda_out_val_i_7_n_0));
  LUT6 #(
    .INIT(64'h0000555300000000)) 
    sda_out_val_i_8
       (.I0(freq_div_en),
        .I1(p_3_in),
        .I2(r_w_reg_n_0),
        .I3(I2C_SCL_reg_0),
        .I4(\current_state_reg_n_0_[0] ),
        .I5(\current_state_reg_n_0_[1] ),
        .O(sda_out_val_i_8_n_0));
  FDPE sda_out_val_reg
       (.C(clk_i),
        .CE(1'b1),
        .D(sda_out_val_i_1_n_0),
        .PRE(I2C_SCL_i_2_n_0),
        .Q(sda_out_val_reg_n_0));
  LUT6 #(
    .INIT(64'hFBBBBBBBAAAAAAAA)) 
    \shift_byte[0]_i_1 
       (.I0(\shift_byte[0]_i_2_n_0 ),
        .I1(\shift_byte[0]_i_3_n_0 ),
        .I2(I2C_SDA),
        .I3(\shift_byte[0]_i_4_n_0 ),
        .I4(\shift_cnt[0]_i_2_n_0 ),
        .I5(\current_state[2]_i_2_n_0 ),
        .O(\shift_byte[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \shift_byte[0]_i_2 
       (.I0(\shift_byte[7]_i_5_n_0 ),
        .I1(I2C_SCL_reg_0),
        .I2(freq_div_en),
        .I3(restart_reg_n_0),
        .O(\shift_byte[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7F7F777F7F7F7F7F)) 
    \shift_byte[0]_i_3 
       (.I0(\shift_byte[7]_i_8_n_0 ),
        .I1(\current_state_reg_n_0_[0] ),
        .I2(\shift_byte[0]_i_5_n_0 ),
        .I3(\shift_byte[7]_i_11_n_0 ),
        .I4(\byte_cnt_reg_n_0_[0] ),
        .I5(data3[0]),
        .O(\shift_byte[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \shift_byte[0]_i_4 
       (.I0(I2C_SCL_reg_0),
        .I1(r_w_reg_n_0),
        .O(\shift_byte[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F8C83808)) 
    \shift_byte[0]_i_5 
       (.I0(\I2C_TDR_reg_n_0_[0] ),
        .I1(\byte_cnt_reg_n_0_[0] ),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(data1[0]),
        .I4(data2[0]),
        .I5(\byte_cnt_reg_n_0_[2] ),
        .O(\shift_byte[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFD5DA808FDFDA808)) 
    \shift_byte[1]_i_1 
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(\shift_byte[1]_i_2_n_0 ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\shift_byte[1]_i_3_n_0 ),
        .I4(I2C_ADR__0[0]),
        .I5(\shift_byte[7]_i_8_n_0 ),
        .O(\shift_byte[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAEA2AAAAA2)) 
    \shift_byte[1]_i_2 
       (.I0(I2C_ADR__0[0]),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state_reg_n_0_[2] ),
        .I3(r_w_reg_n_0),
        .I4(I2C_SCL_reg_0),
        .I5(\shift_byte_reg_n_0_[0] ),
        .O(\shift_byte[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCCC0C8080C00C808)) 
    \shift_byte[1]_i_3 
       (.I0(\shift_byte[1]_i_4_n_0 ),
        .I1(\shift_byte[7]_i_8_n_0 ),
        .I2(\shift_byte[7]_i_11_n_0 ),
        .I3(I2C_ADR__0[0]),
        .I4(\shift_byte[7]_i_12_n_0 ),
        .I5(data3[1]),
        .O(\shift_byte[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \shift_byte[1]_i_4 
       (.I0(data2[1]),
        .I1(data1[1]),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\I2C_TDR_reg_n_0_[1] ),
        .I4(\byte_cnt_reg_n_0_[0] ),
        .I5(I2C_ADR__0[0]),
        .O(\shift_byte[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h5DFD08A85DFD0808)) 
    \shift_byte[2]_i_1 
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(\shift_byte[2]_i_2_n_0 ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\shift_byte[2]_i_3_n_0 ),
        .I4(I2C_ADR__0[1]),
        .I5(\shift_byte[7]_i_8_n_0 ),
        .O(\shift_byte[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAEA2AAAAA2)) 
    \shift_byte[2]_i_2 
       (.I0(I2C_ADR__0[1]),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state_reg_n_0_[2] ),
        .I3(r_w_reg_n_0),
        .I4(I2C_SCL_reg_0),
        .I5(\shift_byte_reg_n_0_[1] ),
        .O(\shift_byte[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000CCC0C0C440C44)) 
    \shift_byte[2]_i_3 
       (.I0(\shift_byte[2]_i_4_n_0 ),
        .I1(\shift_byte[7]_i_8_n_0 ),
        .I2(I2C_ADR__0[1]),
        .I3(\shift_byte[7]_i_12_n_0 ),
        .I4(data3[2]),
        .I5(\shift_byte[7]_i_11_n_0 ),
        .O(\shift_byte[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \shift_byte[2]_i_4 
       (.I0(data2[2]),
        .I1(data1[2]),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\I2C_TDR_reg_n_0_[2] ),
        .I4(\byte_cnt_reg_n_0_[0] ),
        .I5(I2C_ADR__0[1]),
        .O(\shift_byte[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h5DFD08A85DFD0808)) 
    \shift_byte[3]_i_1 
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(\shift_byte[3]_i_2_n_0 ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\shift_byte[3]_i_3_n_0 ),
        .I4(I2C_ADR__0[2]),
        .I5(\shift_byte[7]_i_8_n_0 ),
        .O(\shift_byte[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAEA2AAAAA2)) 
    \shift_byte[3]_i_2 
       (.I0(I2C_ADR__0[2]),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state_reg_n_0_[2] ),
        .I3(r_w_reg_n_0),
        .I4(I2C_SCL_reg_0),
        .I5(\shift_byte_reg_n_0_[2] ),
        .O(\shift_byte[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000CCC0C0C440C44)) 
    \shift_byte[3]_i_3 
       (.I0(\shift_byte[3]_i_4_n_0 ),
        .I1(\shift_byte[7]_i_8_n_0 ),
        .I2(I2C_ADR__0[2]),
        .I3(\shift_byte[7]_i_12_n_0 ),
        .I4(data3[3]),
        .I5(\shift_byte[7]_i_11_n_0 ),
        .O(\shift_byte[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \shift_byte[3]_i_4 
       (.I0(data2[3]),
        .I1(data1[3]),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\I2C_TDR_reg_n_0_[3] ),
        .I4(\byte_cnt_reg_n_0_[0] ),
        .I5(I2C_ADR__0[2]),
        .O(\shift_byte[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h5DFD08A85DFD0808)) 
    \shift_byte[4]_i_1 
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(\shift_byte[4]_i_2_n_0 ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\shift_byte[4]_i_3_n_0 ),
        .I4(I2C_ADR__0[3]),
        .I5(\shift_byte[7]_i_8_n_0 ),
        .O(\shift_byte[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAEA2AAAAA2)) 
    \shift_byte[4]_i_2 
       (.I0(I2C_ADR__0[3]),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state_reg_n_0_[2] ),
        .I3(r_w_reg_n_0),
        .I4(I2C_SCL_reg_0),
        .I5(\shift_byte_reg_n_0_[3] ),
        .O(\shift_byte[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000CCC0C0C440C44)) 
    \shift_byte[4]_i_3 
       (.I0(\shift_byte[4]_i_4_n_0 ),
        .I1(\shift_byte[7]_i_8_n_0 ),
        .I2(I2C_ADR__0[3]),
        .I3(\shift_byte[7]_i_12_n_0 ),
        .I4(data3[4]),
        .I5(\shift_byte[7]_i_11_n_0 ),
        .O(\shift_byte[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \shift_byte[4]_i_4 
       (.I0(data2[4]),
        .I1(data1[4]),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\I2C_TDR_reg_n_0_[4] ),
        .I4(\byte_cnt_reg_n_0_[0] ),
        .I5(I2C_ADR__0[3]),
        .O(\shift_byte[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h5DFD08A85DFD0808)) 
    \shift_byte[5]_i_1 
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(\shift_byte[5]_i_2_n_0 ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\shift_byte[5]_i_3_n_0 ),
        .I4(I2C_ADR__0[4]),
        .I5(\shift_byte[7]_i_8_n_0 ),
        .O(\shift_byte[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAEA2AAAAA2)) 
    \shift_byte[5]_i_2 
       (.I0(I2C_ADR__0[4]),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state_reg_n_0_[2] ),
        .I3(r_w_reg_n_0),
        .I4(I2C_SCL_reg_0),
        .I5(\shift_byte_reg_n_0_[4] ),
        .O(\shift_byte[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000CCC0C0C440C44)) 
    \shift_byte[5]_i_3 
       (.I0(\shift_byte[5]_i_4_n_0 ),
        .I1(\shift_byte[7]_i_8_n_0 ),
        .I2(I2C_ADR__0[4]),
        .I3(\shift_byte[7]_i_12_n_0 ),
        .I4(data3[5]),
        .I5(\shift_byte[7]_i_11_n_0 ),
        .O(\shift_byte[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \shift_byte[5]_i_4 
       (.I0(data2[5]),
        .I1(data1[5]),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\I2C_TDR_reg_n_0_[5] ),
        .I4(\byte_cnt_reg_n_0_[0] ),
        .I5(I2C_ADR__0[4]),
        .O(\shift_byte[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hEEEECEC444444444)) 
    \shift_byte[6]_i_1 
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(I2C_ADR__0[5]),
        .I2(\shift_byte[6]_i_2_n_0 ),
        .I3(\shift_byte_reg_n_0_[5] ),
        .I4(\current_state_reg_n_0_[0] ),
        .I5(\shift_byte[6]_i_3_n_0 ),
        .O(\shift_byte[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hDFFD)) 
    \shift_byte[6]_i_2 
       (.I0(\current_state_reg_n_0_[1] ),
        .I1(\current_state_reg_n_0_[2] ),
        .I2(r_w_reg_n_0),
        .I3(I2C_SCL_reg_0),
        .O(\shift_byte[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h54FF54FFFFFF00FF)) 
    \shift_byte[6]_i_3 
       (.I0(\shift_byte[6]_i_4_n_0 ),
        .I1(\shift_byte[6]_i_5_n_0 ),
        .I2(\shift_byte[6]_i_6_n_0 ),
        .I3(\current_state_reg_n_0_[0] ),
        .I4(I2C_ADR__0[5]),
        .I5(\shift_byte[7]_i_8_n_0 ),
        .O(\shift_byte[6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h04000700)) 
    \shift_byte[6]_i_4 
       (.I0(I2C_ADR__0[5]),
        .I1(\byte_cnt_reg_n_0_[0] ),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\byte_cnt_reg_n_0_[2] ),
        .I4(data3[6]),
        .O(\shift_byte[6]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h0000AC00)) 
    \shift_byte[6]_i_5 
       (.I0(data2[6]),
        .I1(data1[6]),
        .I2(\byte_cnt_reg_n_0_[0] ),
        .I3(\byte_cnt_reg_n_0_[1] ),
        .I4(\byte_cnt_reg_n_0_[2] ),
        .O(\shift_byte[6]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hAFAF0C0A)) 
    \shift_byte[6]_i_6 
       (.I0(I2C_ADR__0[5]),
        .I1(\I2C_TDR_reg_n_0_[6] ),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\byte_cnt_reg_n_0_[0] ),
        .I4(\byte_cnt_reg_n_0_[2] ),
        .O(\shift_byte[6]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0033003310331133)) 
    \shift_byte[7]_i_1 
       (.I0(\shift_byte[7]_i_3_n_0 ),
        .I1(\shift_byte[7]_i_4_n_0 ),
        .I2(I2C_SCL_reg_0),
        .I3(freq_div_en),
        .I4(restart_reg_n_0),
        .I5(\shift_byte[7]_i_5_n_0 ),
        .O(\shift_byte[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \shift_byte[7]_i_10 
       (.I0(data2[7]),
        .I1(data1[7]),
        .I2(\byte_cnt_reg_n_0_[1] ),
        .I3(\I2C_TDR_reg_n_0_[7] ),
        .I4(\byte_cnt_reg_n_0_[0] ),
        .I5(I2C_ADR__0[6]),
        .O(\shift_byte[7]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \shift_byte[7]_i_11 
       (.I0(\byte_cnt_reg_n_0_[2] ),
        .I1(\byte_cnt_reg_n_0_[1] ),
        .O(\shift_byte[7]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \shift_byte[7]_i_12 
       (.I0(\byte_cnt_reg_n_0_[2] ),
        .I1(\byte_cnt_reg_n_0_[1] ),
        .I2(\byte_cnt_reg_n_0_[0] ),
        .O(\shift_byte[7]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hFD5DA808FDFDA808)) 
    \shift_byte[7]_i_2 
       (.I0(\current_state[2]_i_2_n_0 ),
        .I1(\shift_byte[7]_i_6_n_0 ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(\shift_byte[7]_i_7_n_0 ),
        .I4(I2C_ADR__0[6]),
        .I5(\shift_byte[7]_i_8_n_0 ),
        .O(\shift_byte[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h01000101)) 
    \shift_byte[7]_i_3 
       (.I0(\shift_cnt[2]_i_5_n_0 ),
        .I1(\shift_byte[7]_i_9_n_0 ),
        .I2(restart_reg_n_0),
        .I3(freq_div_en),
        .I4(\current_state_reg_n_0_[2] ),
        .O(\shift_byte[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \shift_byte[7]_i_4 
       (.I0(\I2C_CFG_reg_n_0_[2] ),
        .I1(\I2C_CFG_reg_n_0_[0] ),
        .O(\shift_byte[7]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hFFDF)) 
    \shift_byte[7]_i_5 
       (.I0(\freq_div_cnt_reg_n_0_[3] ),
        .I1(\freq_div_cnt_reg_n_0_[1] ),
        .I2(\freq_div_cnt_reg_n_0_[2] ),
        .I3(\I2C_CFG[3]_i_6_n_0 ),
        .O(\shift_byte[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAEAAAAAEA2AAAAA2)) 
    \shift_byte[7]_i_6 
       (.I0(I2C_ADR__0[6]),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state_reg_n_0_[2] ),
        .I3(r_w_reg_n_0),
        .I4(I2C_SCL_reg_0),
        .I5(\shift_byte_reg_n_0_[6] ),
        .O(\shift_byte[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCCC0C8080C00C808)) 
    \shift_byte[7]_i_7 
       (.I0(\shift_byte[7]_i_10_n_0 ),
        .I1(\shift_byte[7]_i_8_n_0 ),
        .I2(\shift_byte[7]_i_11_n_0 ),
        .I3(I2C_ADR__0[6]),
        .I4(\shift_byte[7]_i_12_n_0 ),
        .I5(data3[7]),
        .O(\shift_byte[7]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h00000100)) 
    \shift_byte[7]_i_8 
       (.I0(\current_state_reg_n_0_[1] ),
        .I1(\current_state_reg_n_0_[2] ),
        .I2(r_w_reg_n_0),
        .I3(I2C_SCL_reg_0),
        .I4(I2C_SDA),
        .O(\shift_byte[7]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h1E000000)) 
    \shift_byte[7]_i_9 
       (.I0(\byte_cnt_reg_n_0_[0] ),
        .I1(\byte_cnt_reg_n_0_[1] ),
        .I2(\byte_cnt_reg_n_0_[2] ),
        .I3(\shift_byte[7]_i_8_n_0 ),
        .I4(\current_state_reg_n_0_[0] ),
        .O(\shift_byte[7]_i_9_n_0 ));
  FDCE \shift_byte_reg[0] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte[0]_i_1_n_0 ),
        .Q(\shift_byte_reg_n_0_[0] ));
  FDCE \shift_byte_reg[1] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte[1]_i_1_n_0 ),
        .Q(\shift_byte_reg_n_0_[1] ));
  FDCE \shift_byte_reg[2] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte[2]_i_1_n_0 ),
        .Q(\shift_byte_reg_n_0_[2] ));
  FDCE \shift_byte_reg[3] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte[3]_i_1_n_0 ),
        .Q(\shift_byte_reg_n_0_[3] ));
  FDCE \shift_byte_reg[4] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte[4]_i_1_n_0 ),
        .Q(\shift_byte_reg_n_0_[4] ));
  FDCE \shift_byte_reg[5] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte[5]_i_1_n_0 ),
        .Q(\shift_byte_reg_n_0_[5] ));
  FDCE \shift_byte_reg[6] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte[6]_i_1_n_0 ),
        .Q(\shift_byte_reg_n_0_[6] ));
  FDCE \shift_byte_reg[7] 
       (.C(clk_i),
        .CE(\shift_byte[7]_i_1_n_0 ),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_byte[7]_i_2_n_0 ),
        .Q(p_3_in));
  LUT6 #(
    .INIT(64'h7DFFFFFFFFFF0000)) 
    \shift_cnt[0]_i_1 
       (.I0(\shift_cnt[0]_i_2_n_0 ),
        .I1(r_w_reg_n_0),
        .I2(I2C_SCL_reg_0),
        .I3(\current_state[2]_i_2_n_0 ),
        .I4(\shift_cnt[2]_i_3_n_0 ),
        .I5(\shift_cnt_reg_n_0_[0] ),
        .O(\shift_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \shift_cnt[0]_i_2 
       (.I0(\current_state_reg_n_0_[0] ),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state_reg_n_0_[2] ),
        .O(\shift_cnt[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF7FF7F00)) 
    \shift_cnt[1]_i_1 
       (.I0(\shift_cnt[2]_i_2_n_0 ),
        .I1(\current_state[2]_i_2_n_0 ),
        .I2(\shift_cnt_reg_n_0_[0] ),
        .I3(\shift_cnt[2]_i_3_n_0 ),
        .I4(\shift_cnt_reg_n_0_[1] ),
        .O(\shift_cnt[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF7FFFF777F0000)) 
    \shift_cnt[2]_i_1 
       (.I0(\shift_cnt[2]_i_2_n_0 ),
        .I1(\current_state[2]_i_2_n_0 ),
        .I2(\shift_cnt_reg_n_0_[0] ),
        .I3(\shift_cnt_reg_n_0_[1] ),
        .I4(\shift_cnt[2]_i_3_n_0 ),
        .I5(\shift_cnt_reg_n_0_[2] ),
        .O(\shift_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h04000004)) 
    \shift_cnt[2]_i_2 
       (.I0(\current_state_reg_n_0_[2] ),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state_reg_n_0_[0] ),
        .I3(r_w_reg_n_0),
        .I4(I2C_SCL_reg_0),
        .O(\shift_cnt[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFAEAAAAAAAA)) 
    \shift_cnt[2]_i_3 
       (.I0(awready_i_3_n_0),
        .I1(\shift_cnt[2]_i_4_n_0 ),
        .I2(freq_div_en),
        .I3(\I2C_CFG[2]_i_2_n_0 ),
        .I4(\shift_cnt[2]_i_5_n_0 ),
        .I5(\I2C_CFG[3]_i_5_n_0 ),
        .O(\shift_cnt[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \shift_cnt[2]_i_4 
       (.I0(\current_state_reg_n_0_[2] ),
        .I1(\current_state_reg_n_0_[1] ),
        .O(\shift_cnt[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h040C000C000C040C)) 
    \shift_cnt[2]_i_5 
       (.I0(\current_state_reg_n_0_[0] ),
        .I1(\current_state_reg_n_0_[1] ),
        .I2(\current_state_reg_n_0_[2] ),
        .I3(freq_div_en),
        .I4(I2C_SCL_reg_0),
        .I5(r_w_reg_n_0),
        .O(\shift_cnt[2]_i_5_n_0 ));
  FDCE \shift_cnt_reg[0] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_cnt[0]_i_1_n_0 ),
        .Q(\shift_cnt_reg_n_0_[0] ));
  FDCE \shift_cnt_reg[1] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_cnt[1]_i_1_n_0 ),
        .Q(\shift_cnt_reg_n_0_[1] ));
  FDCE \shift_cnt_reg[2] 
       (.C(clk_i),
        .CE(1'b1),
        .CLR(I2C_SCL_i_2_n_0),
        .D(\shift_cnt[2]_i_1_n_0 ),
        .Q(\shift_cnt_reg_n_0_[2] ));
endmodule

(* CHECK_LICENSE_TYPE = "design_1_I2C_Master_AXI4_Lite_0_0,I2C_Master_AXI4_Lite,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "I2C_Master_AXI4_Lite,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clk_i,
    rst_n,
    I2C_SCL,
    I2C_SDA,
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk_i CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk_i, FREQ_TOLERANCE_HZ 0, ASSOCIATED_BUSIF interface_aximm, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, ASSOCIATED_RESET rst_n, INSERT_VIP 0" *) input rst_n;
  output I2C_SCL;
  inout I2C_SDA;
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
  wire I2C_SCL;
  wire I2C_SDA;
  wire [31:0]araddr;
  wire arready;
  wire arvalid;
  wire [31:0]awaddr;
  wire awready;
  wire awvalid;
  wire bready;
  wire bvalid;
  wire clk_i;
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_I2C_Master_AXI4_Lite inst
       (.I2C_SCL_reg_0(I2C_SCL),
        .I2C_SDA(I2C_SDA),
        .araddr(araddr[7:0]),
        .arready(arready),
        .arvalid(arvalid),
        .awaddr(awaddr[7:0]),
        .awready(awready),
        .awvalid(awvalid),
        .bready(bready),
        .bvalid(bvalid),
        .clk_i(clk_i),
        .rdata(rdata),
        .rready(rready),
        .rst_n(rst_n),
        .rvalid(rvalid),
        .wdata(wdata),
        .wvalid(wvalid));
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
