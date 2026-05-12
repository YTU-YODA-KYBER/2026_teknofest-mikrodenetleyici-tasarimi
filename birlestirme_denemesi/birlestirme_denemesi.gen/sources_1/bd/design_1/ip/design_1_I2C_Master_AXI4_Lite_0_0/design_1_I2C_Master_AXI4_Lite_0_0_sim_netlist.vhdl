-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
-- Date        : Sat May  9 17:15:06 2026
-- Host        : Stradale running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_I2C_Master_AXI4_Lite_0_0/design_1_I2C_Master_AXI4_Lite_0_0_sim_netlist.vhdl
-- Design      : design_1_I2C_Master_AXI4_Lite_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_I2C_Master_AXI4_Lite_0_0_I2C_Master_AXI4_Lite is
  port (
    I2C_SCL_reg_0 : out STD_LOGIC;
    rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bvalid : out STD_LOGIC;
    awready : out STD_LOGIC;
    rvalid : out STD_LOGIC;
    arready : out STD_LOGIC;
    I2C_SDA : inout STD_LOGIC;
    clk_i : in STD_LOGIC;
    wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rst_n : in STD_LOGIC;
    awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wvalid : in STD_LOGIC;
    awvalid : in STD_LOGIC;
    araddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    arvalid : in STD_LOGIC;
    bready : in STD_LOGIC;
    rready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_I2C_Master_AXI4_Lite_0_0_I2C_Master_AXI4_Lite : entity is "I2C_Master_AXI4_Lite";
end design_1_I2C_Master_AXI4_Lite_0_0_I2C_Master_AXI4_Lite;

architecture STRUCTURE of design_1_I2C_Master_AXI4_Lite_0_0_I2C_Master_AXI4_Lite is
  signal I2C_ADR : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \I2C_ADR[31]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_ADR__0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \I2C_CFG[0]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_CFG[1]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_CFG[1]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_CFG[1]_i_3_n_0\ : STD_LOGIC;
  signal \I2C_CFG[1]_i_4_n_0\ : STD_LOGIC;
  signal \I2C_CFG[1]_i_5_n_0\ : STD_LOGIC;
  signal \I2C_CFG[1]_i_6_n_0\ : STD_LOGIC;
  signal \I2C_CFG[2]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_CFG[2]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_CFG[31]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_CFG[31]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_CFG[3]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_CFG[3]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_CFG[3]_i_3_n_0\ : STD_LOGIC;
  signal \I2C_CFG[3]_i_4_n_0\ : STD_LOGIC;
  signal \I2C_CFG[3]_i_5_n_0\ : STD_LOGIC;
  signal \I2C_CFG[3]_i_6_n_0\ : STD_LOGIC;
  signal \I2C_CFG[3]_i_7_n_0\ : STD_LOGIC;
  signal I2C_CFG_clr : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \I2C_CFG_clr[0]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_CFG_clr[1]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_CFG_clr_reg_n_0_[0]\ : STD_LOGIC;
  signal \I2C_CFG_clr_reg_n_0_[1]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[0]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[10]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[11]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[12]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[13]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[14]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[15]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[16]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[17]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[18]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[19]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[1]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[20]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[21]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[22]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[23]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[24]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[25]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[26]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[27]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[28]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[29]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[2]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[30]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[31]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[3]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[4]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[5]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[6]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[7]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[8]\ : STD_LOGIC;
  signal \I2C_CFG_reg_n_0_[9]\ : STD_LOGIC;
  signal I2C_NBY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal I2C_NBY1 : STD_LOGIC;
  signal \I2C_NBY[0]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_NBY[0]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_NBY[0]_i_3_n_0\ : STD_LOGIC;
  signal \I2C_NBY[0]_i_4_n_0\ : STD_LOGIC;
  signal \I2C_NBY[0]_i_5_n_0\ : STD_LOGIC;
  signal \I2C_NBY[1]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_NBY[2]_i_10_n_0\ : STD_LOGIC;
  signal \I2C_NBY[2]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_NBY[2]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_NBY[2]_i_3_n_0\ : STD_LOGIC;
  signal \I2C_NBY[2]_i_4_n_0\ : STD_LOGIC;
  signal \I2C_NBY[2]_i_6_n_0\ : STD_LOGIC;
  signal \I2C_NBY[2]_i_7_n_0\ : STD_LOGIC;
  signal \I2C_NBY[2]_i_8_n_0\ : STD_LOGIC;
  signal \I2C_NBY[2]_i_9_n_0\ : STD_LOGIC;
  signal \I2C_NBY_reg_n_0_[0]\ : STD_LOGIC;
  signal \I2C_NBY_reg_n_0_[1]\ : STD_LOGIC;
  signal \I2C_NBY_reg_n_0_[2]\ : STD_LOGIC;
  signal \I2C_RDR[15]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_RDR[15]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_RDR[23]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_RDR[23]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_RDR[23]_i_3_n_0\ : STD_LOGIC;
  signal \I2C_RDR[31]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_RDR[31]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_RDR[31]_i_3_n_0\ : STD_LOGIC;
  signal \I2C_RDR[31]_i_4_n_0\ : STD_LOGIC;
  signal \I2C_RDR[7]_i_1_n_0\ : STD_LOGIC;
  signal \I2C_RDR[7]_i_2_n_0\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[0]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[10]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[11]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[12]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[13]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[14]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[15]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[16]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[17]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[18]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[19]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[1]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[20]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[21]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[22]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[23]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[24]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[25]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[26]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[27]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[28]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[29]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[2]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[30]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[31]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[3]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[4]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[5]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[6]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[7]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[8]\ : STD_LOGIC;
  signal \I2C_RDR_reg_n_0_[9]\ : STD_LOGIC;
  signal I2C_SCL_i_1_n_0 : STD_LOGIC;
  signal I2C_SCL_i_2_n_0 : STD_LOGIC;
  signal I2C_SCL_i_3_n_0 : STD_LOGIC;
  signal \^i2c_scl_reg_0\ : STD_LOGIC;
  signal I2C_SDA_INST_0_i_1_n_0 : STD_LOGIC;
  signal I2C_TDR : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \I2C_TDR_reg_n_0_[0]\ : STD_LOGIC;
  signal \I2C_TDR_reg_n_0_[1]\ : STD_LOGIC;
  signal \I2C_TDR_reg_n_0_[2]\ : STD_LOGIC;
  signal \I2C_TDR_reg_n_0_[3]\ : STD_LOGIC;
  signal \I2C_TDR_reg_n_0_[4]\ : STD_LOGIC;
  signal \I2C_TDR_reg_n_0_[5]\ : STD_LOGIC;
  signal \I2C_TDR_reg_n_0_[6]\ : STD_LOGIC;
  signal \I2C_TDR_reg_n_0_[7]\ : STD_LOGIC;
  signal \^arready\ : STD_LOGIC;
  signal arready_i_1_n_0 : STD_LOGIC;
  signal \^awready\ : STD_LOGIC;
  signal awready_i_1_n_0 : STD_LOGIC;
  signal awready_i_2_n_0 : STD_LOGIC;
  signal awready_i_3_n_0 : STD_LOGIC;
  signal \^bvalid\ : STD_LOGIC;
  signal bvalid_i_1_n_0 : STD_LOGIC;
  signal byte_cnt1 : STD_LOGIC;
  signal \byte_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \byte_cnt[0]_i_2_n_0\ : STD_LOGIC;
  signal \byte_cnt[0]_i_3_n_0\ : STD_LOGIC;
  signal \byte_cnt[0]_i_4_n_0\ : STD_LOGIC;
  signal \byte_cnt[0]_i_5_n_0\ : STD_LOGIC;
  signal \byte_cnt[0]_i_6_n_0\ : STD_LOGIC;
  signal \byte_cnt[0]_i_7_n_0\ : STD_LOGIC;
  signal \byte_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \byte_cnt[1]_i_2_n_0\ : STD_LOGIC;
  signal \byte_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \byte_cnt[2]_i_2_n_0\ : STD_LOGIC;
  signal \byte_cnt[2]_i_3_n_0\ : STD_LOGIC;
  signal \byte_cnt[2]_i_4_n_0\ : STD_LOGIC;
  signal \byte_cnt[2]_i_5_n_0\ : STD_LOGIC;
  signal \byte_cnt[2]_i_6_n_0\ : STD_LOGIC;
  signal \byte_cnt[2]_i_7_n_0\ : STD_LOGIC;
  signal \byte_cnt[2]_i_8_n_0\ : STD_LOGIC;
  signal \byte_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \byte_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \byte_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal \current_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \current_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \current_state[0]_i_3_n_0\ : STD_LOGIC;
  signal \current_state[0]_i_4_n_0\ : STD_LOGIC;
  signal \current_state[0]_i_5_n_0\ : STD_LOGIC;
  signal \current_state[0]_i_6_n_0\ : STD_LOGIC;
  signal \current_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \current_state[1]_i_2_n_0\ : STD_LOGIC;
  signal \current_state[1]_i_3_n_0\ : STD_LOGIC;
  signal \current_state[1]_i_4_n_0\ : STD_LOGIC;
  signal \current_state[1]_i_5_n_0\ : STD_LOGIC;
  signal \current_state[1]_i_6_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_10_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_11_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_2_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_3_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_4_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_5_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_6_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_7_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_8_n_0\ : STD_LOGIC;
  signal \current_state[2]_i_9_n_0\ : STD_LOGIC;
  signal \current_state_reg_n_0_[0]\ : STD_LOGIC;
  signal \current_state_reg_n_0_[1]\ : STD_LOGIC;
  signal \current_state_reg_n_0_[2]\ : STD_LOGIC;
  signal data1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal data2 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal data3 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal delay_i_1_n_0 : STD_LOGIC;
  signal delay_reg_n_0 : STD_LOGIC;
  signal \freq_div_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \freq_div_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \freq_div_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \freq_div_cnt[2]_i_2_n_0\ : STD_LOGIC;
  signal \freq_div_cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal \freq_div_cnt[4]_i_1_n_0\ : STD_LOGIC;
  signal \freq_div_cnt[5]_i_1_n_0\ : STD_LOGIC;
  signal \freq_div_cnt[6]_i_1_n_0\ : STD_LOGIC;
  signal \freq_div_cnt[6]_i_2_n_0\ : STD_LOGIC;
  signal \freq_div_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \freq_div_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \freq_div_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal \freq_div_cnt_reg_n_0_[3]\ : STD_LOGIC;
  signal \freq_div_cnt_reg_n_0_[4]\ : STD_LOGIC;
  signal \freq_div_cnt_reg_n_0_[5]\ : STD_LOGIC;
  signal \freq_div_cnt_reg_n_0_[6]\ : STD_LOGIC;
  signal freq_div_en : STD_LOGIC;
  signal freq_div_en_i_1_n_0 : STD_LOGIC;
  signal is_read_op19_out : STD_LOGIC;
  signal is_read_op_i_1_n_0 : STD_LOGIC;
  signal is_read_op_reg_n_0 : STD_LOGIC;
  signal \nby_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \nby_cnt[0]_i_2_n_0\ : STD_LOGIC;
  signal \nby_cnt[0]_i_3_n_0\ : STD_LOGIC;
  signal \nby_cnt[0]_i_4_n_0\ : STD_LOGIC;
  signal \nby_cnt[0]_i_5_n_0\ : STD_LOGIC;
  signal \nby_cnt[0]_i_6_n_0\ : STD_LOGIC;
  signal \nby_cnt[0]_i_7_n_0\ : STD_LOGIC;
  signal \nby_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \nby_cnt[1]_i_2_n_0\ : STD_LOGIC;
  signal \nby_cnt[1]_i_3_n_0\ : STD_LOGIC;
  signal \nby_cnt[1]_i_4_n_0\ : STD_LOGIC;
  signal \nby_cnt[1]_i_5_n_0\ : STD_LOGIC;
  signal \nby_cnt[1]_i_6_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_10_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_11_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_2_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_3_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_4_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_5_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_6_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_7_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_8_n_0\ : STD_LOGIC;
  signal \nby_cnt[2]_i_9_n_0\ : STD_LOGIC;
  signal \nby_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \nby_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \nby_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal p_3_in : STD_LOGIC_VECTOR ( 7 to 7 );
  signal r_w_i_1_n_0 : STD_LOGIC;
  signal r_w_i_2_n_0 : STD_LOGIC;
  signal r_w_i_3_n_0 : STD_LOGIC;
  signal r_w_reg_n_0 : STD_LOGIC;
  signal \rdata[0]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[0]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[10]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[10]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[11]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[11]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[12]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[12]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[13]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[13]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[14]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[14]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[15]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[15]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[16]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[16]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[17]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[17]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[18]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[18]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[19]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[19]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[1]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[1]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[20]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[20]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[21]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[21]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[22]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[22]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[23]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[23]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[24]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[24]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[25]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[25]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[26]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[26]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[27]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[27]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[28]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[28]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[29]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[29]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[2]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[2]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[30]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[30]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[3]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[3]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[4]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[4]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[5]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[5]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[6]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[6]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[7]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[7]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[8]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[8]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[9]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[9]_i_2_n_0\ : STD_LOGIC;
  signal restart_i_1_n_0 : STD_LOGIC;
  signal restart_i_2_n_0 : STD_LOGIC;
  signal restart_i_3_n_0 : STD_LOGIC;
  signal restart_reg_n_0 : STD_LOGIC;
  signal \^rvalid\ : STD_LOGIC;
  signal rvalid_i_1_n_0 : STD_LOGIC;
  signal sda_out_val_i_1_n_0 : STD_LOGIC;
  signal sda_out_val_i_2_n_0 : STD_LOGIC;
  signal sda_out_val_i_3_n_0 : STD_LOGIC;
  signal sda_out_val_i_4_n_0 : STD_LOGIC;
  signal sda_out_val_i_5_n_0 : STD_LOGIC;
  signal sda_out_val_i_6_n_0 : STD_LOGIC;
  signal sda_out_val_i_7_n_0 : STD_LOGIC;
  signal sda_out_val_i_8_n_0 : STD_LOGIC;
  signal sda_out_val_reg_n_0 : STD_LOGIC;
  signal \shift_byte[0]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[0]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[0]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[0]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[0]_i_5_n_0\ : STD_LOGIC;
  signal \shift_byte[1]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[1]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[1]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[1]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[2]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[2]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[2]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[2]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[3]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[3]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[3]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[3]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[4]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[4]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[4]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[4]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[5]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[5]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[5]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[5]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[6]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[6]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[6]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[6]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[6]_i_5_n_0\ : STD_LOGIC;
  signal \shift_byte[6]_i_6_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_10_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_11_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_12_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_5_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_6_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_7_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_8_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_9_n_0\ : STD_LOGIC;
  signal \shift_byte_reg_n_0_[0]\ : STD_LOGIC;
  signal \shift_byte_reg_n_0_[1]\ : STD_LOGIC;
  signal \shift_byte_reg_n_0_[2]\ : STD_LOGIC;
  signal \shift_byte_reg_n_0_[3]\ : STD_LOGIC;
  signal \shift_byte_reg_n_0_[4]\ : STD_LOGIC;
  signal \shift_byte_reg_n_0_[5]\ : STD_LOGIC;
  signal \shift_byte_reg_n_0_[6]\ : STD_LOGIC;
  signal \shift_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \shift_cnt[0]_i_2_n_0\ : STD_LOGIC;
  signal \shift_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \shift_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \shift_cnt[2]_i_2_n_0\ : STD_LOGIC;
  signal \shift_cnt[2]_i_3_n_0\ : STD_LOGIC;
  signal \shift_cnt[2]_i_4_n_0\ : STD_LOGIC;
  signal \shift_cnt[2]_i_5_n_0\ : STD_LOGIC;
  signal \shift_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \shift_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \shift_cnt_reg_n_0_[2]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \I2C_CFG[0]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \I2C_CFG[1]_i_6\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \I2C_CFG[2]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \I2C_CFG[3]_i_3\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \I2C_CFG[3]_i_6\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \I2C_CFG[3]_i_7\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \I2C_CFG_clr[0]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \I2C_CFG_clr[1]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \I2C_NBY[0]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \I2C_NBY[0]_i_4\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \I2C_NBY[2]_i_7\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \I2C_RDR[23]_i_3\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \I2C_RDR[31]_i_2\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \I2C_RDR[31]_i_4\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of I2C_SCL_i_1 : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of I2C_SDA_INST_0 : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of I2C_SDA_INST_0_i_1 : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of awready_i_2 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of awready_i_3 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of awready_i_4 : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of bvalid_i_1 : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \byte_cnt[0]_i_3\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \byte_cnt[0]_i_4\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \byte_cnt[2]_i_3\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \byte_cnt[2]_i_4\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \byte_cnt[2]_i_7\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \current_state[0]_i_5\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \current_state[0]_i_6\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \current_state[2]_i_10\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \current_state[2]_i_11\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \current_state[2]_i_4\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \current_state[2]_i_5\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \current_state[2]_i_7\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \freq_div_cnt[0]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \freq_div_cnt[1]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \freq_div_cnt[2]_i_2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \freq_div_cnt[3]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \freq_div_cnt[5]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \freq_div_cnt[6]_i_2\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \nby_cnt[0]_i_2\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \nby_cnt[0]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \nby_cnt[0]_i_6\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \nby_cnt[0]_i_7\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \nby_cnt[1]_i_6\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \nby_cnt[2]_i_10\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \nby_cnt[2]_i_11\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \nby_cnt[2]_i_4\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \nby_cnt[2]_i_7\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of r_w_i_4 : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \rdata[0]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \rdata[10]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \rdata[11]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \rdata[12]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \rdata[13]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \rdata[14]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \rdata[15]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \rdata[16]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \rdata[17]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \rdata[18]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \rdata[19]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \rdata[1]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \rdata[20]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \rdata[21]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \rdata[22]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \rdata[23]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \rdata[24]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \rdata[25]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \rdata[26]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \rdata[27]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \rdata[28]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \rdata[29]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \rdata[2]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \rdata[30]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \rdata[31]_i_2\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \rdata[3]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \rdata[4]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \rdata[5]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \rdata[6]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \rdata[7]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \rdata[8]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \rdata[9]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of sda_out_val_i_2 : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of sda_out_val_i_3 : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \shift_byte[0]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \shift_byte[0]_i_4\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \shift_byte[6]_i_2\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \shift_byte[6]_i_4\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \shift_byte[6]_i_6\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \shift_byte[7]_i_11\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \shift_byte[7]_i_12\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \shift_byte[7]_i_4\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \shift_byte[7]_i_5\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \shift_byte[7]_i_9\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \shift_cnt[0]_i_2\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \shift_cnt[2]_i_2\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \shift_cnt[2]_i_4\ : label is "soft_lutpair29";
begin
  I2C_SCL_reg_0 <= \^i2c_scl_reg_0\;
  arready <= \^arready\;
  awready <= \^awready\;
  bvalid <= \^bvalid\;
  rvalid <= \^rvalid\;
\I2C_ADR[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => awaddr(4),
      I1 => awaddr(0),
      I2 => awaddr(1),
      I3 => awaddr(3),
      I4 => \I2C_ADR[31]_i_2_n_0\,
      O => I2C_ADR(0)
    );
\I2C_ADR[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002000000000000"
    )
        port map (
      I0 => awaddr(2),
      I1 => awaddr(6),
      I2 => awaddr(7),
      I3 => awaddr(5),
      I4 => wvalid,
      I5 => awvalid,
      O => \I2C_ADR[31]_i_2_n_0\
    );
\I2C_ADR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(0),
      Q => \I2C_ADR__0\(0)
    );
\I2C_ADR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(10),
      Q => \I2C_ADR__0\(10)
    );
\I2C_ADR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(11),
      Q => \I2C_ADR__0\(11)
    );
\I2C_ADR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(12),
      Q => \I2C_ADR__0\(12)
    );
\I2C_ADR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(13),
      Q => \I2C_ADR__0\(13)
    );
\I2C_ADR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(14),
      Q => \I2C_ADR__0\(14)
    );
\I2C_ADR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(15),
      Q => \I2C_ADR__0\(15)
    );
\I2C_ADR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(16),
      Q => \I2C_ADR__0\(16)
    );
\I2C_ADR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(17),
      Q => \I2C_ADR__0\(17)
    );
\I2C_ADR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(18),
      Q => \I2C_ADR__0\(18)
    );
\I2C_ADR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(19),
      Q => \I2C_ADR__0\(19)
    );
\I2C_ADR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(1),
      Q => \I2C_ADR__0\(1)
    );
\I2C_ADR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(20),
      Q => \I2C_ADR__0\(20)
    );
\I2C_ADR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(21),
      Q => \I2C_ADR__0\(21)
    );
\I2C_ADR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(22),
      Q => \I2C_ADR__0\(22)
    );
\I2C_ADR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(23),
      Q => \I2C_ADR__0\(23)
    );
\I2C_ADR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(24),
      Q => \I2C_ADR__0\(24)
    );
\I2C_ADR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(25),
      Q => \I2C_ADR__0\(25)
    );
\I2C_ADR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(26),
      Q => \I2C_ADR__0\(26)
    );
\I2C_ADR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(27),
      Q => \I2C_ADR__0\(27)
    );
\I2C_ADR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(28),
      Q => \I2C_ADR__0\(28)
    );
\I2C_ADR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(29),
      Q => \I2C_ADR__0\(29)
    );
\I2C_ADR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(2),
      Q => \I2C_ADR__0\(2)
    );
\I2C_ADR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(30),
      Q => \I2C_ADR__0\(30)
    );
\I2C_ADR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(31),
      Q => \I2C_ADR__0\(31)
    );
\I2C_ADR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(3),
      Q => \I2C_ADR__0\(3)
    );
\I2C_ADR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(4),
      Q => \I2C_ADR__0\(4)
    );
\I2C_ADR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(5),
      Q => \I2C_ADR__0\(5)
    );
\I2C_ADR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(6),
      Q => \I2C_ADR__0\(6)
    );
\I2C_ADR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(7),
      Q => \I2C_ADR__0\(7)
    );
\I2C_ADR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(8),
      Q => \I2C_ADR__0\(8)
    );
\I2C_ADR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_ADR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(9),
      Q => \I2C_ADR__0\(9)
    );
\I2C_CFG[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0B08"
    )
        port map (
      I0 => wdata(0),
      I1 => \I2C_CFG[31]_i_1_n_0\,
      I2 => \I2C_CFG[1]_i_2_n_0\,
      I3 => \I2C_CFG_reg_n_0_[0]\,
      O => \I2C_CFG[0]_i_1_n_0\
    );
\I2C_CFG[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BABABAFFBABABA00"
    )
        port map (
      I0 => \I2C_CFG[1]_i_2_n_0\,
      I1 => \I2C_CFG[1]_i_3_n_0\,
      I2 => wdata(1),
      I3 => \I2C_CFG[31]_i_1_n_0\,
      I4 => \I2C_CFG[1]_i_4_n_0\,
      I5 => \I2C_CFG_reg_n_0_[1]\,
      O => \I2C_CFG[1]_i_1_n_0\
    );
\I2C_CFG[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000200000000000"
    )
        port map (
      I0 => \current_state_reg_n_0_[0]\,
      I1 => r_w_reg_n_0,
      I2 => \^i2c_scl_reg_0\,
      I3 => \I2C_CFG[3]_i_5_n_0\,
      I4 => \current_state_reg_n_0_[1]\,
      I5 => \current_state_reg_n_0_[2]\,
      O => \I2C_CFG[1]_i_2_n_0\
    );
\I2C_CFG[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000004000000"
    )
        port map (
      I0 => restart_reg_n_0,
      I1 => \I2C_CFG_clr_reg_n_0_[0]\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \current_state_reg_n_0_[2]\,
      I4 => \current_state_reg_n_0_[1]\,
      I5 => \I2C_CFG[1]_i_5_n_0\,
      O => \I2C_CFG[1]_i_3_n_0\
    );
\I2C_CFG[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000800000A080A0"
    )
        port map (
      I0 => \I2C_CFG[3]_i_5_n_0\,
      I1 => \I2C_CFG_clr_reg_n_0_[0]\,
      I2 => \current_state_reg_n_0_[2]\,
      I3 => \current_state_reg_n_0_[1]\,
      I4 => \current_state_reg_n_0_[0]\,
      I5 => \I2C_CFG[1]_i_6_n_0\,
      O => \I2C_CFG[1]_i_4_n_0\
    );
\I2C_CFG[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFBFFFFF"
    )
        port map (
      I0 => \shift_byte[7]_i_4_n_0\,
      I1 => freq_div_en,
      I2 => \freq_div_cnt_reg_n_0_[3]\,
      I3 => \freq_div_cnt_reg_n_0_[1]\,
      I4 => \freq_div_cnt_reg_n_0_[2]\,
      I5 => \I2C_CFG[3]_i_6_n_0\,
      O => \I2C_CFG[1]_i_5_n_0\
    );
\I2C_CFG[1]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
        port map (
      I0 => \^i2c_scl_reg_0\,
      I1 => r_w_reg_n_0,
      I2 => \current_state_reg_n_0_[0]\,
      O => \I2C_CFG[1]_i_6_n_0\
    );
\I2C_CFG[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0BBBBBBB08888888"
    )
        port map (
      I0 => wdata(2),
      I1 => \I2C_CFG[31]_i_1_n_0\,
      I2 => r_w_reg_n_0,
      I3 => \I2C_CFG[3]_i_5_n_0\,
      I4 => \I2C_CFG[2]_i_2_n_0\,
      I5 => \I2C_CFG_reg_n_0_[2]\,
      O => \I2C_CFG[2]_i_1_n_0\
    );
\I2C_CFG[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => \current_state_reg_n_0_[0]\,
      I1 => \current_state_reg_n_0_[2]\,
      I2 => \current_state_reg_n_0_[1]\,
      I3 => \^i2c_scl_reg_0\,
      O => \I2C_CFG[2]_i_2_n_0\
    );
\I2C_CFG[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000020"
    )
        port map (
      I0 => \I2C_CFG[31]_i_2_n_0\,
      I1 => awaddr(3),
      I2 => awaddr(4),
      I3 => awaddr(1),
      I4 => awaddr(0),
      O => \I2C_CFG[31]_i_1_n_0\
    );
\I2C_CFG[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001000000000000"
    )
        port map (
      I0 => awaddr(2),
      I1 => awaddr(6),
      I2 => awaddr(7),
      I3 => awaddr(5),
      I4 => wvalid,
      I5 => awvalid,
      O => \I2C_CFG[31]_i_2_n_0\
    );
\I2C_CFG[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8F88AFAF8088A0A0"
    )
        port map (
      I0 => \I2C_CFG[3]_i_2_n_0\,
      I1 => \I2C_CFG[3]_i_3_n_0\,
      I2 => \I2C_CFG[31]_i_1_n_0\,
      I3 => \I2C_CFG[3]_i_4_n_0\,
      I4 => \I2C_CFG[3]_i_5_n_0\,
      I5 => \I2C_CFG_reg_n_0_[3]\,
      O => \I2C_CFG[3]_i_1_n_0\
    );
\I2C_CFG[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAAAAAAAAAAAAAA"
    )
        port map (
      I0 => wdata(3),
      I1 => \current_state_reg_n_0_[2]\,
      I2 => \current_state_reg_n_0_[1]\,
      I3 => \I2C_CFG[3]_i_5_n_0\,
      I4 => \I2C_CFG[2]_i_2_n_0\,
      I5 => r_w_reg_n_0,
      O => \I2C_CFG[3]_i_2_n_0\
    );
\I2C_CFG[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF3F5F3F"
    )
        port map (
      I0 => \I2C_CFG_clr_reg_n_0_[1]\,
      I1 => restart_reg_n_0,
      I2 => \current_state_reg_n_0_[2]\,
      I3 => \current_state_reg_n_0_[1]\,
      I4 => \current_state_reg_n_0_[0]\,
      O => \I2C_CFG[3]_i_3_n_0\
    );
\I2C_CFG[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F5FF3FFFF5FFFFFF"
    )
        port map (
      I0 => \I2C_CFG_clr_reg_n_0_[1]\,
      I1 => r_w_reg_n_0,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \current_state_reg_n_0_[2]\,
      I4 => \current_state_reg_n_0_[1]\,
      I5 => \^i2c_scl_reg_0\,
      O => \I2C_CFG[3]_i_4_n_0\
    );
\I2C_CFG[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0100010001000000"
    )
        port map (
      I0 => restart_reg_n_0,
      I1 => \I2C_CFG[3]_i_6_n_0\,
      I2 => \I2C_CFG[3]_i_7_n_0\,
      I3 => freq_div_en,
      I4 => \I2C_CFG_reg_n_0_[2]\,
      I5 => \I2C_CFG_reg_n_0_[0]\,
      O => \I2C_CFG[3]_i_5_n_0\
    );
\I2C_CFG[3]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFDF"
    )
        port map (
      I0 => \freq_div_cnt_reg_n_0_[0]\,
      I1 => \freq_div_cnt_reg_n_0_[5]\,
      I2 => \freq_div_cnt_reg_n_0_[4]\,
      I3 => \freq_div_cnt_reg_n_0_[6]\,
      O => \I2C_CFG[3]_i_6_n_0\
    );
\I2C_CFG[3]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
        port map (
      I0 => \freq_div_cnt_reg_n_0_[2]\,
      I1 => \freq_div_cnt_reg_n_0_[1]\,
      I2 => \freq_div_cnt_reg_n_0_[3]\,
      O => \I2C_CFG[3]_i_7_n_0\
    );
\I2C_CFG_clr[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata(0),
      I1 => I2C_CFG_clr(0),
      I2 => \I2C_CFG_clr_reg_n_0_[0]\,
      O => \I2C_CFG_clr[0]_i_1_n_0\
    );
\I2C_CFG_clr[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata(1),
      I1 => I2C_CFG_clr(0),
      I2 => \I2C_CFG_clr_reg_n_0_[1]\,
      O => \I2C_CFG_clr[1]_i_1_n_0\
    );
\I2C_CFG_clr[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000080000"
    )
        port map (
      I0 => \I2C_ADR[31]_i_2_n_0\,
      I1 => rst_n,
      I2 => awaddr(0),
      I3 => awaddr(1),
      I4 => awaddr(4),
      I5 => awaddr(3),
      O => I2C_CFG_clr(0)
    );
\I2C_CFG_clr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => \I2C_CFG_clr[0]_i_1_n_0\,
      Q => \I2C_CFG_clr_reg_n_0_[0]\,
      R => '0'
    );
\I2C_CFG_clr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => \I2C_CFG_clr[1]_i_1_n_0\,
      Q => \I2C_CFG_clr_reg_n_0_[1]\,
      R => '0'
    );
\I2C_CFG_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \I2C_CFG[0]_i_1_n_0\,
      Q => \I2C_CFG_reg_n_0_[0]\
    );
\I2C_CFG_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(10),
      Q => \I2C_CFG_reg_n_0_[10]\
    );
\I2C_CFG_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(11),
      Q => \I2C_CFG_reg_n_0_[11]\
    );
\I2C_CFG_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(12),
      Q => \I2C_CFG_reg_n_0_[12]\
    );
\I2C_CFG_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(13),
      Q => \I2C_CFG_reg_n_0_[13]\
    );
\I2C_CFG_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(14),
      Q => \I2C_CFG_reg_n_0_[14]\
    );
\I2C_CFG_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(15),
      Q => \I2C_CFG_reg_n_0_[15]\
    );
\I2C_CFG_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(16),
      Q => \I2C_CFG_reg_n_0_[16]\
    );
\I2C_CFG_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(17),
      Q => \I2C_CFG_reg_n_0_[17]\
    );
\I2C_CFG_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(18),
      Q => \I2C_CFG_reg_n_0_[18]\
    );
\I2C_CFG_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(19),
      Q => \I2C_CFG_reg_n_0_[19]\
    );
\I2C_CFG_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \I2C_CFG[1]_i_1_n_0\,
      Q => \I2C_CFG_reg_n_0_[1]\
    );
\I2C_CFG_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(20),
      Q => \I2C_CFG_reg_n_0_[20]\
    );
\I2C_CFG_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(21),
      Q => \I2C_CFG_reg_n_0_[21]\
    );
\I2C_CFG_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(22),
      Q => \I2C_CFG_reg_n_0_[22]\
    );
\I2C_CFG_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(23),
      Q => \I2C_CFG_reg_n_0_[23]\
    );
\I2C_CFG_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(24),
      Q => \I2C_CFG_reg_n_0_[24]\
    );
\I2C_CFG_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(25),
      Q => \I2C_CFG_reg_n_0_[25]\
    );
\I2C_CFG_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(26),
      Q => \I2C_CFG_reg_n_0_[26]\
    );
\I2C_CFG_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(27),
      Q => \I2C_CFG_reg_n_0_[27]\
    );
\I2C_CFG_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(28),
      Q => \I2C_CFG_reg_n_0_[28]\
    );
\I2C_CFG_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(29),
      Q => \I2C_CFG_reg_n_0_[29]\
    );
\I2C_CFG_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \I2C_CFG[2]_i_1_n_0\,
      Q => \I2C_CFG_reg_n_0_[2]\
    );
\I2C_CFG_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(30),
      Q => \I2C_CFG_reg_n_0_[30]\
    );
\I2C_CFG_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(31),
      Q => \I2C_CFG_reg_n_0_[31]\
    );
\I2C_CFG_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \I2C_CFG[3]_i_1_n_0\,
      Q => \I2C_CFG_reg_n_0_[3]\
    );
\I2C_CFG_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(4),
      Q => \I2C_CFG_reg_n_0_[4]\
    );
\I2C_CFG_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(5),
      Q => \I2C_CFG_reg_n_0_[5]\
    );
\I2C_CFG_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(6),
      Q => \I2C_CFG_reg_n_0_[6]\
    );
\I2C_CFG_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(7),
      Q => \I2C_CFG_reg_n_0_[7]\
    );
\I2C_CFG_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(8),
      Q => \I2C_CFG_reg_n_0_[8]\
    );
\I2C_CFG_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_CFG[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(9),
      Q => \I2C_CFG_reg_n_0_[9]\
    );
\I2C_NBY[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_NBY[0]_i_2_n_0\,
      I1 => I2C_NBY(0),
      I2 => \I2C_NBY_reg_n_0_[0]\,
      O => \I2C_NBY[0]_i_1_n_0\
    );
\I2C_NBY[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000040500000000"
    )
        port map (
      I0 => \I2C_NBY[0]_i_3_n_0\,
      I1 => wdata(0),
      I2 => wdata(2),
      I3 => wdata(1),
      I4 => \I2C_NBY[2]_i_8_n_0\,
      I5 => \I2C_NBY[2]_i_9_n_0\,
      O => \I2C_NBY[0]_i_2_n_0\
    );
\I2C_NBY[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \I2C_NBY[2]_i_2_n_0\,
      I1 => \I2C_NBY[0]_i_4_n_0\,
      I2 => \I2C_NBY[2]_i_10_n_0\,
      I3 => \I2C_NBY[0]_i_5_n_0\,
      I4 => \I2C_NBY[2]_i_6_n_0\,
      O => \I2C_NBY[0]_i_3_n_0\
    );
\I2C_NBY[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wdata(23),
      I1 => wdata(9),
      I2 => wdata(22),
      I3 => wdata(6),
      O => \I2C_NBY[0]_i_4_n_0\
    );
\I2C_NBY[0]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wdata(24),
      I1 => wdata(18),
      I2 => wdata(16),
      I3 => wdata(8),
      O => \I2C_NBY[0]_i_5_n_0\
    );
\I2C_NBY[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002FFFF00020000"
    )
        port map (
      I0 => wdata(1),
      I1 => \I2C_NBY[2]_i_2_n_0\,
      I2 => \I2C_NBY[2]_i_3_n_0\,
      I3 => \I2C_NBY[2]_i_4_n_0\,
      I4 => I2C_NBY(0),
      I5 => \I2C_NBY_reg_n_0_[1]\,
      O => \I2C_NBY[1]_i_1_n_0\
    );
\I2C_NBY[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFFFFFFFE0000"
    )
        port map (
      I0 => wdata(2),
      I1 => \I2C_NBY[2]_i_2_n_0\,
      I2 => \I2C_NBY[2]_i_3_n_0\,
      I3 => \I2C_NBY[2]_i_4_n_0\,
      I4 => I2C_NBY(0),
      I5 => \I2C_NBY_reg_n_0_[2]\,
      O => \I2C_NBY[2]_i_1_n_0\
    );
\I2C_NBY[2]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wdata(12),
      I1 => wdata(5),
      I2 => wdata(28),
      I3 => wdata(17),
      O => \I2C_NBY[2]_i_10_n_0\
    );
\I2C_NBY[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => wdata(25),
      I1 => wdata(7),
      I2 => wdata(15),
      I3 => wdata(27),
      I4 => wdata(14),
      I5 => wdata(20),
      O => \I2C_NBY[2]_i_2_n_0\
    );
\I2C_NBY[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \I2C_NBY[2]_i_6_n_0\,
      I1 => wdata(24),
      I2 => wdata(18),
      I3 => wdata(16),
      I4 => wdata(8),
      I5 => \I2C_NBY[2]_i_7_n_0\,
      O => \I2C_NBY[2]_i_3_n_0\
    );
\I2C_NBY[2]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEAAFFFF"
    )
        port map (
      I0 => \I2C_NBY[2]_i_8_n_0\,
      I1 => wdata(0),
      I2 => wdata(1),
      I3 => wdata(2),
      I4 => \I2C_NBY[2]_i_9_n_0\,
      O => \I2C_NBY[2]_i_4_n_0\
    );
\I2C_NBY[2]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => awaddr(4),
      I1 => awaddr(0),
      I2 => awaddr(1),
      I3 => awaddr(3),
      I4 => \I2C_CFG[31]_i_2_n_0\,
      O => I2C_NBY(0)
    );
\I2C_NBY[2]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wdata(26),
      I1 => wdata(19),
      I2 => wdata(21),
      I3 => wdata(13),
      O => \I2C_NBY[2]_i_6_n_0\
    );
\I2C_NBY[2]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => wdata(6),
      I1 => wdata(22),
      I2 => wdata(9),
      I3 => wdata(23),
      I4 => \I2C_NBY[2]_i_10_n_0\,
      O => \I2C_NBY[2]_i_7_n_0\
    );
\I2C_NBY[2]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => wdata(31),
      I1 => wdata(30),
      I2 => wdata(29),
      O => \I2C_NBY[2]_i_8_n_0\
    );
\I2C_NBY[2]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => wdata(4),
      I1 => wdata(3),
      I2 => wdata(11),
      I3 => wdata(10),
      O => \I2C_NBY[2]_i_9_n_0\
    );
\I2C_NBY_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \I2C_NBY[0]_i_1_n_0\,
      Q => \I2C_NBY_reg_n_0_[0]\
    );
\I2C_NBY_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \I2C_NBY[1]_i_1_n_0\,
      Q => \I2C_NBY_reg_n_0_[1]\
    );
\I2C_NBY_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \I2C_NBY[2]_i_1_n_0\,
      Q => \I2C_NBY_reg_n_0_[2]\
    );
\I2C_RDR[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"888888A8"
    )
        port map (
      I0 => \I2C_RDR[31]_i_2_n_0\,
      I1 => \I2C_RDR[15]_i_2_n_0\,
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \byte_cnt_reg_n_0_[0]\,
      I4 => \I2C_RDR[23]_i_3_n_0\,
      O => \I2C_RDR[15]_i_1_n_0\
    );
\I2C_RDR[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0100000000000000"
    )
        port map (
      I0 => \I2C_NBY_reg_n_0_[2]\,
      I1 => \I2C_CFG_reg_n_0_[0]\,
      I2 => \I2C_NBY_reg_n_0_[0]\,
      I3 => \shift_byte[0]_i_4_n_0\,
      I4 => \I2C_NBY_reg_n_0_[1]\,
      I5 => \current_state_reg_n_0_[1]\,
      O => \I2C_RDR[15]_i_2_n_0\
    );
\I2C_RDR[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8888A888"
    )
        port map (
      I0 => \I2C_RDR[31]_i_2_n_0\,
      I1 => \I2C_RDR[23]_i_2_n_0\,
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \byte_cnt_reg_n_0_[0]\,
      I4 => \I2C_RDR[23]_i_3_n_0\,
      O => \I2C_RDR[23]_i_1_n_0\
    );
\I2C_RDR[23]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000008000"
    )
        port map (
      I0 => \shift_byte[0]_i_4_n_0\,
      I1 => \I2C_NBY_reg_n_0_[0]\,
      I2 => \I2C_NBY_reg_n_0_[1]\,
      I3 => \current_state_reg_n_0_[1]\,
      I4 => \I2C_CFG_reg_n_0_[0]\,
      I5 => \I2C_NBY_reg_n_0_[2]\,
      O => \I2C_RDR[23]_i_2_n_0\
    );
\I2C_RDR[23]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFB"
    )
        port map (
      I0 => \byte_cnt_reg_n_0_[2]\,
      I1 => r_w_reg_n_0,
      I2 => \^i2c_scl_reg_0\,
      I3 => \current_state_reg_n_0_[1]\,
      O => \I2C_RDR[23]_i_3_n_0\
    );
\I2C_RDR[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2222222222222A22"
    )
        port map (
      I0 => \I2C_RDR[31]_i_2_n_0\,
      I1 => \I2C_RDR[31]_i_3_n_0\,
      I2 => \I2C_RDR[31]_i_4_n_0\,
      I3 => r_w_reg_n_0,
      I4 => \^i2c_scl_reg_0\,
      I5 => \current_state_reg_n_0_[1]\,
      O => \I2C_RDR[31]_i_1_n_0\
    );
\I2C_RDR[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \I2C_CFG[3]_i_5_n_0\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => \current_state_reg_n_0_[2]\,
      O => \I2C_RDR[31]_i_2_n_0\
    );
\I2C_RDR[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFF7FFFF"
    )
        port map (
      I0 => \I2C_NBY_reg_n_0_[2]\,
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \I2C_NBY_reg_n_0_[1]\,
      I3 => \I2C_NBY_reg_n_0_[0]\,
      I4 => \shift_byte[0]_i_4_n_0\,
      I5 => \I2C_CFG_reg_n_0_[0]\,
      O => \I2C_RDR[31]_i_3_n_0\
    );
\I2C_RDR[31]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
        port map (
      I0 => \byte_cnt_reg_n_0_[0]\,
      I1 => \byte_cnt_reg_n_0_[1]\,
      I2 => \byte_cnt_reg_n_0_[2]\,
      O => \I2C_RDR[31]_i_4_n_0\
    );
\I2C_RDR[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"888A8888"
    )
        port map (
      I0 => \I2C_RDR[31]_i_2_n_0\,
      I1 => \I2C_RDR[7]_i_2_n_0\,
      I2 => \I2C_RDR[23]_i_3_n_0\,
      I3 => \byte_cnt_reg_n_0_[1]\,
      I4 => \byte_cnt_reg_n_0_[0]\,
      O => \I2C_RDR[7]_i_1_n_0\
    );
\I2C_RDR[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000800"
    )
        port map (
      I0 => \shift_byte[0]_i_4_n_0\,
      I1 => \I2C_NBY_reg_n_0_[0]\,
      I2 => \I2C_NBY_reg_n_0_[1]\,
      I3 => \current_state_reg_n_0_[1]\,
      I4 => \I2C_CFG_reg_n_0_[0]\,
      I5 => \I2C_NBY_reg_n_0_[2]\,
      O => \I2C_RDR[7]_i_2_n_0\
    );
\I2C_RDR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[0]\,
      Q => \I2C_RDR_reg_n_0_[0]\
    );
\I2C_RDR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[15]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[2]\,
      Q => \I2C_RDR_reg_n_0_[10]\
    );
\I2C_RDR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[15]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[3]\,
      Q => \I2C_RDR_reg_n_0_[11]\
    );
\I2C_RDR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[15]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[4]\,
      Q => \I2C_RDR_reg_n_0_[12]\
    );
\I2C_RDR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[15]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[5]\,
      Q => \I2C_RDR_reg_n_0_[13]\
    );
\I2C_RDR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[15]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[6]\,
      Q => \I2C_RDR_reg_n_0_[14]\
    );
\I2C_RDR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[15]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => p_3_in(7),
      Q => \I2C_RDR_reg_n_0_[15]\
    );
\I2C_RDR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[23]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[0]\,
      Q => \I2C_RDR_reg_n_0_[16]\
    );
\I2C_RDR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[23]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[1]\,
      Q => \I2C_RDR_reg_n_0_[17]\
    );
\I2C_RDR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[23]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[2]\,
      Q => \I2C_RDR_reg_n_0_[18]\
    );
\I2C_RDR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[23]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[3]\,
      Q => \I2C_RDR_reg_n_0_[19]\
    );
\I2C_RDR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[1]\,
      Q => \I2C_RDR_reg_n_0_[1]\
    );
\I2C_RDR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[23]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[4]\,
      Q => \I2C_RDR_reg_n_0_[20]\
    );
\I2C_RDR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[23]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[5]\,
      Q => \I2C_RDR_reg_n_0_[21]\
    );
\I2C_RDR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[23]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[6]\,
      Q => \I2C_RDR_reg_n_0_[22]\
    );
\I2C_RDR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[23]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => p_3_in(7),
      Q => \I2C_RDR_reg_n_0_[23]\
    );
\I2C_RDR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[0]\,
      Q => \I2C_RDR_reg_n_0_[24]\
    );
\I2C_RDR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[1]\,
      Q => \I2C_RDR_reg_n_0_[25]\
    );
\I2C_RDR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[2]\,
      Q => \I2C_RDR_reg_n_0_[26]\
    );
\I2C_RDR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[3]\,
      Q => \I2C_RDR_reg_n_0_[27]\
    );
\I2C_RDR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[4]\,
      Q => \I2C_RDR_reg_n_0_[28]\
    );
\I2C_RDR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[5]\,
      Q => \I2C_RDR_reg_n_0_[29]\
    );
\I2C_RDR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[2]\,
      Q => \I2C_RDR_reg_n_0_[2]\
    );
\I2C_RDR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[6]\,
      Q => \I2C_RDR_reg_n_0_[30]\
    );
\I2C_RDR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => p_3_in(7),
      Q => \I2C_RDR_reg_n_0_[31]\
    );
\I2C_RDR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[3]\,
      Q => \I2C_RDR_reg_n_0_[3]\
    );
\I2C_RDR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[4]\,
      Q => \I2C_RDR_reg_n_0_[4]\
    );
\I2C_RDR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[5]\,
      Q => \I2C_RDR_reg_n_0_[5]\
    );
\I2C_RDR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[6]\,
      Q => \I2C_RDR_reg_n_0_[6]\
    );
\I2C_RDR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => p_3_in(7),
      Q => \I2C_RDR_reg_n_0_[7]\
    );
\I2C_RDR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[15]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[0]\,
      Q => \I2C_RDR_reg_n_0_[8]\
    );
\I2C_RDR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \I2C_RDR[15]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte_reg_n_0_[1]\,
      Q => \I2C_RDR_reg_n_0_[9]\
    );
I2C_SCL_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B5"
    )
        port map (
      I0 => I2C_SCL_i_3_n_0,
      I1 => freq_div_en,
      I2 => \^i2c_scl_reg_0\,
      O => I2C_SCL_i_1_n_0
    );
I2C_SCL_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst_n,
      O => I2C_SCL_i_2_n_0
    );
I2C_SCL_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAA8AAA"
    )
        port map (
      I0 => freq_div_en,
      I1 => \freq_div_cnt[2]_i_2_n_0\,
      I2 => \freq_div_cnt_reg_n_0_[0]\,
      I3 => \freq_div_cnt_reg_n_0_[1]\,
      I4 => \freq_div_cnt_reg_n_0_[2]\,
      I5 => \freq_div_cnt_reg_n_0_[6]\,
      O => I2C_SCL_i_3_n_0
    );
I2C_SCL_reg: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => I2C_SCL_i_1_n_0,
      PRE => I2C_SCL_i_2_n_0,
      Q => \^i2c_scl_reg_0\
    );
I2C_SDA_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => sda_out_val_reg_n_0,
      I1 => I2C_SDA_INST_0_i_1_n_0,
      O => I2C_SDA
    );
I2C_SDA_INST_0_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => sda_out_val_reg_n_0,
      O => I2C_SDA_INST_0_i_1_n_0
    );
\I2C_TDR[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000008"
    )
        port map (
      I0 => \I2C_ADR[31]_i_2_n_0\,
      I1 => awaddr(3),
      I2 => awaddr(4),
      I3 => awaddr(0),
      I4 => awaddr(1),
      O => I2C_TDR(0)
    );
\I2C_TDR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(0),
      Q => \I2C_TDR_reg_n_0_[0]\
    );
\I2C_TDR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(10),
      Q => data1(2)
    );
\I2C_TDR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(11),
      Q => data1(3)
    );
\I2C_TDR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(12),
      Q => data1(4)
    );
\I2C_TDR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(13),
      Q => data1(5)
    );
\I2C_TDR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(14),
      Q => data1(6)
    );
\I2C_TDR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(15),
      Q => data1(7)
    );
\I2C_TDR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(16),
      Q => data2(0)
    );
\I2C_TDR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(17),
      Q => data2(1)
    );
\I2C_TDR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(18),
      Q => data2(2)
    );
\I2C_TDR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(19),
      Q => data2(3)
    );
\I2C_TDR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(1),
      Q => \I2C_TDR_reg_n_0_[1]\
    );
\I2C_TDR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(20),
      Q => data2(4)
    );
\I2C_TDR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(21),
      Q => data2(5)
    );
\I2C_TDR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(22),
      Q => data2(6)
    );
\I2C_TDR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(23),
      Q => data2(7)
    );
\I2C_TDR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(24),
      Q => data3(0)
    );
\I2C_TDR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(25),
      Q => data3(1)
    );
\I2C_TDR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(26),
      Q => data3(2)
    );
\I2C_TDR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(27),
      Q => data3(3)
    );
\I2C_TDR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(28),
      Q => data3(4)
    );
\I2C_TDR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(29),
      Q => data3(5)
    );
\I2C_TDR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(2),
      Q => \I2C_TDR_reg_n_0_[2]\
    );
\I2C_TDR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(30),
      Q => data3(6)
    );
\I2C_TDR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(31),
      Q => data3(7)
    );
\I2C_TDR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(3),
      Q => \I2C_TDR_reg_n_0_[3]\
    );
\I2C_TDR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(4),
      Q => \I2C_TDR_reg_n_0_[4]\
    );
\I2C_TDR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(5),
      Q => \I2C_TDR_reg_n_0_[5]\
    );
\I2C_TDR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(6),
      Q => \I2C_TDR_reg_n_0_[6]\
    );
\I2C_TDR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(7),
      Q => \I2C_TDR_reg_n_0_[7]\
    );
\I2C_TDR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(8),
      Q => data1(0)
    );
\I2C_TDR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => I2C_TDR(0),
      CLR => I2C_SCL_i_2_n_0,
      D => wdata(9),
      Q => data1(1)
    );
arready_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5540"
    )
        port map (
      I0 => arvalid,
      I1 => \^rvalid\,
      I2 => rready,
      I3 => \^arready\,
      O => arready_i_1_n_0
    );
arready_reg: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => arready_i_1_n_0,
      PRE => I2C_SCL_i_2_n_0,
      Q => \^arready\
    );
awready_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAABBBBAAAABAAA"
    )
        port map (
      I0 => awready_i_2_n_0,
      I1 => awready_i_3_n_0,
      I2 => bready,
      I3 => \^bvalid\,
      I4 => I2C_NBY1,
      I5 => \^awready\,
      O => awready_i_1_n_0
    );
awready_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08000000"
    )
        port map (
      I0 => \I2C_CFG[3]_i_5_n_0\,
      I1 => \^i2c_scl_reg_0\,
      I2 => \current_state_reg_n_0_[1]\,
      I3 => \current_state_reg_n_0_[2]\,
      I4 => \current_state_reg_n_0_[0]\,
      O => awready_i_2_n_0
    );
awready_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
        port map (
      I0 => freq_div_en,
      I1 => \I2C_CFG_reg_n_0_[0]\,
      I2 => \I2C_CFG_reg_n_0_[2]\,
      O => awready_i_3_n_0
    );
awready_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => wvalid,
      I1 => awvalid,
      O => I2C_NBY1
    );
awready_reg: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => awready_i_1_n_0,
      PRE => I2C_SCL_i_2_n_0,
      Q => \^awready\
    );
bvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88F8"
    )
        port map (
      I0 => awvalid,
      I1 => wvalid,
      I2 => \^bvalid\,
      I3 => bready,
      O => bvalid_i_1_n_0
    );
bvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => bvalid_i_1_n_0,
      Q => \^bvalid\
    );
\byte_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"08AAFFFF08AA0000"
    )
        port map (
      I0 => freq_div_en,
      I1 => \byte_cnt[0]_i_2_n_0\,
      I2 => \byte_cnt[0]_i_3_n_0\,
      I3 => \byte_cnt[0]_i_4_n_0\,
      I4 => \byte_cnt[2]_i_4_n_0\,
      I5 => \byte_cnt_reg_n_0_[0]\,
      O => \byte_cnt[0]_i_1_n_0\
    );
\byte_cnt[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DDDFDDDFDDDFDDDD"
    )
        port map (
      I0 => \byte_cnt[0]_i_5_n_0\,
      I1 => \current_state_reg_n_0_[2]\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \byte_cnt[0]_i_6_n_0\,
      I4 => r_w_reg_n_0,
      I5 => \byte_cnt[0]_i_7_n_0\,
      O => \byte_cnt[0]_i_2_n_0\
    );
\byte_cnt[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"51055505"
    )
        port map (
      I0 => freq_div_en,
      I1 => \^i2c_scl_reg_0\,
      I2 => \current_state_reg_n_0_[1]\,
      I3 => \current_state_reg_n_0_[2]\,
      I4 => \current_state_reg_n_0_[0]\,
      O => \byte_cnt[0]_i_3_n_0\
    );
\byte_cnt[0]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => restart_reg_n_0,
      I1 => \shift_byte[7]_i_5_n_0\,
      O => \byte_cnt[0]_i_4_n_0\
    );
\byte_cnt[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2A2A2A2AAA2A2A2A"
    )
        port map (
      I0 => \current_state_reg_n_0_[1]\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => freq_div_en,
      I3 => delay_reg_n_0,
      I4 => byte_cnt1,
      I5 => \I2C_CFG_reg_n_0_[0]\,
      O => \byte_cnt[0]_i_5_n_0\
    );
\byte_cnt[0]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44C044CC44444444"
    )
        port map (
      I0 => freq_div_en,
      I1 => r_w_reg_n_0,
      I2 => \byte_cnt_reg_n_0_[0]\,
      I3 => \current_state[1]_i_6_n_0\,
      I4 => \current_state[0]_i_6_n_0\,
      I5 => \^i2c_scl_reg_0\,
      O => \byte_cnt[0]_i_6_n_0\
    );
\byte_cnt[0]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8ABA8ABA8ABABAB"
    )
        port map (
      I0 => freq_div_en,
      I1 => \^i2c_scl_reg_0\,
      I2 => \current_state[1]_i_6_n_0\,
      I3 => \byte_cnt_reg_n_0_[0]\,
      I4 => \current_state[0]_i_6_n_0\,
      I5 => \nby_cnt_reg_n_0_[0]\,
      O => \byte_cnt[0]_i_7_n_0\
    );
\byte_cnt[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8AFF8A00"
    )
        port map (
      I0 => freq_div_en,
      I1 => \byte_cnt[1]_i_2_n_0\,
      I2 => \byte_cnt[2]_i_3_n_0\,
      I3 => \byte_cnt[2]_i_4_n_0\,
      I4 => \byte_cnt_reg_n_0_[1]\,
      O => \byte_cnt[1]_i_1_n_0\
    );
\byte_cnt[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000028"
    )
        port map (
      I0 => \current_state[1]_i_4_n_0\,
      I1 => \byte_cnt_reg_n_0_[0]\,
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \current_state_reg_n_0_[0]\,
      I4 => \byte_cnt[2]_i_5_n_0\,
      O => \byte_cnt[1]_i_2_n_0\
    );
\byte_cnt[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8AFF8A00"
    )
        port map (
      I0 => freq_div_en,
      I1 => \byte_cnt[2]_i_2_n_0\,
      I2 => \byte_cnt[2]_i_3_n_0\,
      I3 => \byte_cnt[2]_i_4_n_0\,
      I4 => \byte_cnt_reg_n_0_[2]\,
      O => \byte_cnt[2]_i_1_n_0\
    );
\byte_cnt[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000002888"
    )
        port map (
      I0 => \current_state[1]_i_4_n_0\,
      I1 => \byte_cnt_reg_n_0_[2]\,
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \byte_cnt_reg_n_0_[0]\,
      I4 => \current_state_reg_n_0_[0]\,
      I5 => \byte_cnt[2]_i_5_n_0\,
      O => \byte_cnt[2]_i_2_n_0\
    );
\byte_cnt[2]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \shift_byte[7]_i_5_n_0\,
      I1 => restart_reg_n_0,
      I2 => \byte_cnt[2]_i_6_n_0\,
      O => \byte_cnt[2]_i_3_n_0\
    );
\byte_cnt[2]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0EFF0E0E"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[2]\,
      I1 => \I2C_CFG_reg_n_0_[0]\,
      I2 => freq_div_en,
      I3 => \byte_cnt[2]_i_6_n_0\,
      I4 => \I2C_CFG[3]_i_5_n_0\,
      O => \byte_cnt[2]_i_4_n_0\
    );
\byte_cnt[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF0800FF0F"
    )
        port map (
      I0 => \^i2c_scl_reg_0\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => \current_state_reg_n_0_[1]\,
      I3 => \current_state_reg_n_0_[2]\,
      I4 => freq_div_en,
      I5 => restart_reg_n_0,
      O => \byte_cnt[2]_i_5_n_0\
    );
\byte_cnt[2]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFB8FFFF"
    )
        port map (
      I0 => \byte_cnt[2]_i_7_n_0\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => \byte_cnt[2]_i_8_n_0\,
      I3 => \current_state_reg_n_0_[2]\,
      I4 => \current_state_reg_n_0_[1]\,
      I5 => \byte_cnt[2]_i_5_n_0\,
      O => \byte_cnt[2]_i_6_n_0\
    );
\byte_cnt[2]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAA2"
    )
        port map (
      I0 => freq_div_en,
      I1 => delay_reg_n_0,
      I2 => r_w_reg_n_0,
      I3 => \^i2c_scl_reg_0\,
      I4 => \I2C_CFG_reg_n_0_[0]\,
      O => \byte_cnt[2]_i_7_n_0\
    );
\byte_cnt[2]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAAA28"
    )
        port map (
      I0 => freq_div_en,
      I1 => \^i2c_scl_reg_0\,
      I2 => r_w_reg_n_0,
      I3 => \shift_cnt_reg_n_0_[2]\,
      I4 => \shift_cnt_reg_n_0_[1]\,
      I5 => \shift_cnt_reg_n_0_[0]\,
      O => \byte_cnt[2]_i_8_n_0\
    );
\byte_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \byte_cnt[0]_i_1_n_0\,
      Q => \byte_cnt_reg_n_0_[0]\
    );
\byte_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \byte_cnt[1]_i_1_n_0\,
      Q => \byte_cnt_reg_n_0_[1]\
    );
\byte_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \byte_cnt[2]_i_1_n_0\,
      Q => \byte_cnt_reg_n_0_[2]\
    );
\current_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"08AAFFFF08AA0000"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \current_state[0]_i_2_n_0\,
      I2 => \current_state[0]_i_3_n_0\,
      I3 => \current_state[1]_i_3_n_0\,
      I4 => \current_state[2]_i_6_n_0\,
      I5 => \current_state_reg_n_0_[0]\,
      O => \current_state[0]_i_1_n_0\
    );
\current_state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BAAAAFAF"
    )
        port map (
      I0 => \current_state_reg_n_0_[1]\,
      I1 => r_w_reg_n_0,
      I2 => \^i2c_scl_reg_0\,
      I3 => I2C_SDA,
      I4 => \current_state_reg_n_0_[0]\,
      I5 => \current_state_reg_n_0_[2]\,
      O => \current_state[0]_i_2_n_0\
    );
\current_state[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888800808888"
    )
        port map (
      I0 => \current_state[0]_i_4_n_0\,
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state[0]_i_5_n_0\,
      I3 => \shift_byte[0]_i_4_n_0\,
      I4 => \current_state_reg_n_0_[0]\,
      I5 => \I2C_CFG_reg_n_0_[0]\,
      O => \current_state[0]_i_3_n_0\
    );
\current_state[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFFFFFFFEFFE"
    )
        port map (
      I0 => \current_state[1]_i_6_n_0\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => r_w_reg_n_0,
      I3 => \^i2c_scl_reg_0\,
      I4 => \current_state[0]_i_6_n_0\,
      I5 => \nby_cnt_reg_n_0_[0]\,
      O => \current_state[0]_i_4_n_0\
    );
\current_state[0]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
        port map (
      I0 => delay_reg_n_0,
      I1 => r_w_reg_n_0,
      I2 => \^i2c_scl_reg_0\,
      O => \current_state[0]_i_5_n_0\
    );
\current_state[0]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \nby_cnt_reg_n_0_[2]\,
      I1 => \nby_cnt_reg_n_0_[1]\,
      O => \current_state[0]_i_6_n_0\
    );
\current_state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"4FFF4F00"
    )
        port map (
      I0 => \current_state[1]_i_2_n_0\,
      I1 => \current_state[1]_i_3_n_0\,
      I2 => \current_state[2]_i_2_n_0\,
      I3 => \current_state[2]_i_6_n_0\,
      I4 => \current_state_reg_n_0_[1]\,
      O => \current_state[1]_i_1_n_0\
    );
\current_state[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000032003203"
    )
        port map (
      I0 => \current_state[1]_i_4_n_0\,
      I1 => \current_state_reg_n_0_[2]\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \current_state_reg_n_0_[1]\,
      I4 => \^i2c_scl_reg_0\,
      I5 => \current_state[1]_i_5_n_0\,
      O => \current_state[1]_i_2_n_0\
    );
\current_state[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFDF"
    )
        port map (
      I0 => \current_state_reg_n_0_[2]\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => \^i2c_scl_reg_0\,
      I3 => \current_state_reg_n_0_[1]\,
      I4 => I2C_SDA,
      O => \current_state[1]_i_3_n_0\
    );
\current_state[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000A8A800005554"
    )
        port map (
      I0 => r_w_reg_n_0,
      I1 => \nby_cnt_reg_n_0_[2]\,
      I2 => \nby_cnt_reg_n_0_[1]\,
      I3 => \nby_cnt_reg_n_0_[0]\,
      I4 => \current_state[1]_i_6_n_0\,
      I5 => \^i2c_scl_reg_0\,
      O => \current_state[1]_i_4_n_0\
    );
\current_state[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF51000000000000"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[0]\,
      I1 => delay_reg_n_0,
      I2 => r_w_reg_n_0,
      I3 => \^i2c_scl_reg_0\,
      I4 => \current_state_reg_n_0_[1]\,
      I5 => \current_state_reg_n_0_[0]\,
      O => \current_state[1]_i_5_n_0\
    );
\current_state[1]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \shift_cnt_reg_n_0_[2]\,
      I1 => \shift_cnt_reg_n_0_[1]\,
      I2 => \shift_cnt_reg_n_0_[0]\,
      O => \current_state[1]_i_6_n_0\
    );
\current_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888AFFFF888A0000"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \current_state[2]_i_3_n_0\,
      I2 => \current_state[2]_i_4_n_0\,
      I3 => \current_state[2]_i_5_n_0\,
      I4 => \current_state[2]_i_6_n_0\,
      I5 => \current_state_reg_n_0_[2]\,
      O => \current_state[2]_i_1_n_0\
    );
\current_state[2]_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \current_state_reg_n_0_[0]\,
      I1 => \current_state_reg_n_0_[1]\,
      O => \current_state[2]_i_10_n_0\
    );
\current_state[2]_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFBFEFBF"
    )
        port map (
      I0 => \current_state_reg_n_0_[1]\,
      I1 => \^i2c_scl_reg_0\,
      I2 => freq_div_en,
      I3 => \current_state_reg_n_0_[0]\,
      I4 => r_w_reg_n_0,
      O => \current_state[2]_i_11_n_0\
    );
\current_state[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => restart_reg_n_0,
      I1 => \current_state[2]_i_7_n_0\,
      O => \current_state[2]_i_2_n_0\
    );
\current_state[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30100000"
    )
        port map (
      I0 => I2C_SDA,
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \^i2c_scl_reg_0\,
      I3 => \current_state_reg_n_0_[0]\,
      I4 => \current_state_reg_n_0_[2]\,
      O => \current_state[2]_i_3_n_0\
    );
\current_state[2]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
        port map (
      I0 => \current_state_reg_n_0_[1]\,
      I1 => \current_state_reg_n_0_[2]\,
      I2 => \current_state_reg_n_0_[0]\,
      O => \current_state[2]_i_4_n_0\
    );
\current_state[2]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C7"
    )
        port map (
      I0 => r_w_reg_n_0,
      I1 => \^i2c_scl_reg_0\,
      I2 => \I2C_CFG_reg_n_0_[0]\,
      O => \current_state[2]_i_5_n_0\
    );
\current_state[2]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"050D050F050D0505"
    )
        port map (
      I0 => freq_div_en,
      I1 => \^i2c_scl_reg_0\,
      I2 => \shift_byte[7]_i_4_n_0\,
      I3 => \shift_byte[7]_i_5_n_0\,
      I4 => restart_reg_n_0,
      I5 => \current_state[2]_i_8_n_0\,
      O => \current_state[2]_i_6_n_0\
    );
\current_state[2]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FBFFFFFF"
    )
        port map (
      I0 => \I2C_CFG[3]_i_6_n_0\,
      I1 => \freq_div_cnt_reg_n_0_[2]\,
      I2 => \freq_div_cnt_reg_n_0_[1]\,
      I3 => \freq_div_cnt_reg_n_0_[3]\,
      I4 => freq_div_en,
      O => \current_state[2]_i_7_n_0\
    );
\current_state[2]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAFEAAAAAAAA"
    )
        port map (
      I0 => \current_state[2]_i_3_n_0\,
      I1 => \current_state[2]_i_9_n_0\,
      I2 => \current_state[2]_i_10_n_0\,
      I3 => \current_state[1]_i_5_n_0\,
      I4 => \current_state_reg_n_0_[2]\,
      I5 => \current_state[2]_i_11_n_0\,
      O => \current_state[2]_i_8_n_0\
    );
\current_state[2]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000000009F"
    )
        port map (
      I0 => r_w_reg_n_0,
      I1 => \^i2c_scl_reg_0\,
      I2 => freq_div_en,
      I3 => \shift_cnt_reg_n_0_[0]\,
      I4 => \shift_cnt_reg_n_0_[1]\,
      I5 => \shift_cnt_reg_n_0_[2]\,
      O => \current_state[2]_i_9_n_0\
    );
\current_state_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \current_state[0]_i_1_n_0\,
      Q => \current_state_reg_n_0_[0]\
    );
\current_state_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => \current_state[1]_i_1_n_0\,
      PRE => I2C_SCL_i_2_n_0,
      Q => \current_state_reg_n_0_[1]\
    );
\current_state_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \current_state[2]_i_1_n_0\,
      Q => \current_state_reg_n_0_[2]\
    );
delay_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000FFFF0002"
    )
        port map (
      I0 => \I2C_CFG[3]_i_5_n_0\,
      I1 => r_w_reg_n_0,
      I2 => \^i2c_scl_reg_0\,
      I3 => \I2C_CFG_reg_n_0_[0]\,
      I4 => delay_reg_n_0,
      I5 => \current_state[2]_i_4_n_0\,
      O => delay_i_1_n_0
    );
delay_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => delay_i_1_n_0,
      Q => delay_reg_n_0
    );
\freq_div_cnt[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => freq_div_en,
      I1 => \freq_div_cnt_reg_n_0_[0]\,
      O => \freq_div_cnt[0]_i_1_n_0\
    );
\freq_div_cnt[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"60"
    )
        port map (
      I0 => \freq_div_cnt_reg_n_0_[1]\,
      I1 => \freq_div_cnt_reg_n_0_[0]\,
      I2 => freq_div_en,
      O => \freq_div_cnt[1]_i_1_n_0\
    );
\freq_div_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E0F000F000F000"
    )
        port map (
      I0 => \freq_div_cnt[2]_i_2_n_0\,
      I1 => \freq_div_cnt_reg_n_0_[6]\,
      I2 => freq_div_en,
      I3 => \freq_div_cnt_reg_n_0_[2]\,
      I4 => \freq_div_cnt_reg_n_0_[1]\,
      I5 => \freq_div_cnt_reg_n_0_[0]\,
      O => \freq_div_cnt[2]_i_1_n_0\
    );
\freq_div_cnt[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \freq_div_cnt_reg_n_0_[3]\,
      I1 => \freq_div_cnt_reg_n_0_[4]\,
      I2 => \freq_div_cnt_reg_n_0_[5]\,
      O => \freq_div_cnt[2]_i_2_n_0\
    );
\freq_div_cnt[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2AAA8000"
    )
        port map (
      I0 => I2C_SCL_i_3_n_0,
      I1 => \freq_div_cnt_reg_n_0_[2]\,
      I2 => \freq_div_cnt_reg_n_0_[1]\,
      I3 => \freq_div_cnt_reg_n_0_[0]\,
      I4 => \freq_div_cnt_reg_n_0_[3]\,
      O => \freq_div_cnt[3]_i_1_n_0\
    );
\freq_div_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2AAAAAAA80000000"
    )
        port map (
      I0 => I2C_SCL_i_3_n_0,
      I1 => \freq_div_cnt_reg_n_0_[0]\,
      I2 => \freq_div_cnt_reg_n_0_[1]\,
      I3 => \freq_div_cnt_reg_n_0_[2]\,
      I4 => \freq_div_cnt_reg_n_0_[3]\,
      I5 => \freq_div_cnt_reg_n_0_[4]\,
      O => \freq_div_cnt[4]_i_1_n_0\
    );
\freq_div_cnt[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2AAA8000"
    )
        port map (
      I0 => I2C_SCL_i_3_n_0,
      I1 => \freq_div_cnt[6]_i_2_n_0\,
      I2 => \freq_div_cnt_reg_n_0_[3]\,
      I3 => \freq_div_cnt_reg_n_0_[4]\,
      I4 => \freq_div_cnt_reg_n_0_[5]\,
      O => \freq_div_cnt[5]_i_1_n_0\
    );
\freq_div_cnt[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2AAAAAAA80000000"
    )
        port map (
      I0 => freq_div_en,
      I1 => \freq_div_cnt[6]_i_2_n_0\,
      I2 => \freq_div_cnt_reg_n_0_[5]\,
      I3 => \freq_div_cnt_reg_n_0_[4]\,
      I4 => \freq_div_cnt_reg_n_0_[3]\,
      I5 => \freq_div_cnt_reg_n_0_[6]\,
      O => \freq_div_cnt[6]_i_1_n_0\
    );
\freq_div_cnt[6]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \freq_div_cnt_reg_n_0_[2]\,
      I1 => \freq_div_cnt_reg_n_0_[1]\,
      I2 => \freq_div_cnt_reg_n_0_[0]\,
      O => \freq_div_cnt[6]_i_2_n_0\
    );
\freq_div_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \freq_div_cnt[0]_i_1_n_0\,
      Q => \freq_div_cnt_reg_n_0_[0]\
    );
\freq_div_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \freq_div_cnt[1]_i_1_n_0\,
      Q => \freq_div_cnt_reg_n_0_[1]\
    );
\freq_div_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \freq_div_cnt[2]_i_1_n_0\,
      Q => \freq_div_cnt_reg_n_0_[2]\
    );
\freq_div_cnt_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \freq_div_cnt[3]_i_1_n_0\,
      Q => \freq_div_cnt_reg_n_0_[3]\
    );
\freq_div_cnt_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \freq_div_cnt[4]_i_1_n_0\,
      Q => \freq_div_cnt_reg_n_0_[4]\
    );
\freq_div_cnt_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \freq_div_cnt[5]_i_1_n_0\,
      Q => \freq_div_cnt_reg_n_0_[5]\
    );
\freq_div_cnt_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \freq_div_cnt[6]_i_1_n_0\,
      Q => \freq_div_cnt_reg_n_0_[6]\
    );
freq_div_en_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555FFFCFF54FFFC"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \I2C_CFG_reg_n_0_[2]\,
      I2 => \I2C_CFG_reg_n_0_[0]\,
      I3 => freq_div_en,
      I4 => \I2C_CFG[2]_i_2_n_0\,
      I5 => \I2C_CFG[3]_i_5_n_0\,
      O => freq_div_en_i_1_n_0
    );
freq_div_en_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => freq_div_en_i_1_n_0,
      Q => freq_div_en
    );
is_read_op_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => freq_div_en,
      I1 => is_read_op19_out,
      I2 => is_read_op_reg_n_0,
      O => is_read_op_i_1_n_0
    );
is_read_op_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0E00EEEE0000EEEE"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[2]\,
      I1 => \I2C_CFG_reg_n_0_[0]\,
      I2 => \shift_byte[7]_i_5_n_0\,
      I3 => \^i2c_scl_reg_0\,
      I4 => freq_div_en,
      I5 => restart_reg_n_0,
      O => is_read_op19_out
    );
is_read_op_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => is_read_op_i_1_n_0,
      Q => is_read_op_reg_n_0
    );
\nby_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F44FFFF4F440000"
    )
        port map (
      I0 => \nby_cnt[0]_i_2_n_0\,
      I1 => \nby_cnt[0]_i_3_n_0\,
      I2 => \nby_cnt[0]_i_4_n_0\,
      I3 => \nby_cnt[0]_i_5_n_0\,
      I4 => \nby_cnt[2]_i_5_n_0\,
      I5 => \nby_cnt_reg_n_0_[0]\,
      O => \nby_cnt[0]_i_1_n_0\
    );
\nby_cnt[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[0]\,
      I1 => \I2C_NBY_reg_n_0_[0]\,
      O => \nby_cnt[0]_i_2_n_0\
    );
\nby_cnt[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => \current_state[2]_i_7_n_0\,
      I1 => \^i2c_scl_reg_0\,
      I2 => restart_reg_n_0,
      O => \nby_cnt[0]_i_3_n_0\
    );
\nby_cnt[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAFFFEAAAA"
    )
        port map (
      I0 => restart_reg_n_0,
      I1 => \shift_byte[6]_i_2_n_0\,
      I2 => \nby_cnt[0]_i_6_n_0\,
      I3 => \current_state[2]_i_7_n_0\,
      I4 => \I2C_CFG_reg_n_0_[0]\,
      I5 => \I2C_NBY_reg_n_0_[0]\,
      O => \nby_cnt[0]_i_4_n_0\
    );
\nby_cnt[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFDFCFDFFFDFFFDF"
    )
        port map (
      I0 => \current_state[1]_i_4_n_0\,
      I1 => \shift_cnt[2]_i_4_n_0\,
      I2 => \nby_cnt[0]_i_6_n_0\,
      I3 => \current_state_reg_n_0_[0]\,
      I4 => \I2C_NBY_reg_n_0_[0]\,
      I5 => \nby_cnt[0]_i_7_n_0\,
      O => \nby_cnt[0]_i_5_n_0\
    );
\nby_cnt[0]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFEFEFF"
    )
        port map (
      I0 => \current_state[1]_i_6_n_0\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => \nby_cnt_reg_n_0_[0]\,
      I3 => \nby_cnt_reg_n_0_[2]\,
      I4 => \nby_cnt_reg_n_0_[1]\,
      O => \nby_cnt[0]_i_6_n_0\
    );
\nby_cnt[0]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0200"
    )
        port map (
      I0 => is_read_op_reg_n_0,
      I1 => \^i2c_scl_reg_0\,
      I2 => r_w_reg_n_0,
      I3 => delay_reg_n_0,
      O => \nby_cnt[0]_i_7_n_0\
    );
\nby_cnt[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFE0"
    )
        port map (
      I0 => \nby_cnt[1]_i_2_n_0\,
      I1 => \nby_cnt[1]_i_3_n_0\,
      I2 => \nby_cnt[2]_i_5_n_0\,
      I3 => \nby_cnt_reg_n_0_[1]\,
      O => \nby_cnt[1]_i_1_n_0\
    );
\nby_cnt[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F1000000"
    )
        port map (
      I0 => \current_state_reg_n_0_[0]\,
      I1 => \current_state[1]_i_4_n_0\,
      I2 => \shift_cnt[2]_i_4_n_0\,
      I3 => \I2C_CFG_reg_n_0_[0]\,
      I4 => \I2C_NBY_reg_n_0_[1]\,
      I5 => restart_reg_n_0,
      O => \nby_cnt[1]_i_2_n_0\
    );
\nby_cnt[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888080800FF"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[0]\,
      I1 => \I2C_NBY_reg_n_0_[1]\,
      I2 => \^i2c_scl_reg_0\,
      I3 => \nby_cnt[1]_i_4_n_0\,
      I4 => restart_reg_n_0,
      I5 => \current_state[2]_i_7_n_0\,
      O => \nby_cnt[1]_i_3_n_0\
    );
\nby_cnt[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFDDFFFFFFDDFFF0"
    )
        port map (
      I0 => \I2C_NBY_reg_n_0_[1]\,
      I1 => \nby_cnt[2]_i_7_n_0\,
      I2 => \nby_cnt[1]_i_5_n_0\,
      I3 => \shift_cnt[2]_i_4_n_0\,
      I4 => \current_state_reg_n_0_[0]\,
      I5 => \nby_cnt[1]_i_6_n_0\,
      O => \nby_cnt[1]_i_4_n_0\
    );
\nby_cnt[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFEFFFFFFFFFEFF"
    )
        port map (
      I0 => \shift_cnt_reg_n_0_[0]\,
      I1 => \shift_cnt_reg_n_0_[1]\,
      I2 => \shift_cnt_reg_n_0_[2]\,
      I3 => \nby_cnt_reg_n_0_[2]\,
      I4 => \nby_cnt_reg_n_0_[1]\,
      I5 => \nby_cnt_reg_n_0_[0]\,
      O => \nby_cnt[1]_i_5_n_0\
    );
\nby_cnt[1]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^i2c_scl_reg_0\,
      I1 => r_w_reg_n_0,
      O => \nby_cnt[1]_i_6_n_0\
    );
\nby_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFD0FFFFFFD00000"
    )
        port map (
      I0 => \nby_cnt[2]_i_2_n_0\,
      I1 => \nby_cnt[2]_i_3_n_0\,
      I2 => \current_state[2]_i_2_n_0\,
      I3 => \nby_cnt[2]_i_4_n_0\,
      I4 => \nby_cnt[2]_i_5_n_0\,
      I5 => \nby_cnt_reg_n_0_[2]\,
      O => \nby_cnt[2]_i_1_n_0\
    );
\nby_cnt[2]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[0]\,
      I1 => \^i2c_scl_reg_0\,
      I2 => r_w_reg_n_0,
      I3 => delay_reg_n_0,
      O => \nby_cnt[2]_i_10_n_0\
    );
\nby_cnt[2]_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \^i2c_scl_reg_0\,
      I1 => freq_div_en,
      I2 => restart_reg_n_0,
      O => \nby_cnt[2]_i_11_n_0\
    );
\nby_cnt[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"373737F7F7F7F737"
    )
        port map (
      I0 => \nby_cnt[2]_i_6_n_0\,
      I1 => \shift_cnt[0]_i_2_n_0\,
      I2 => \current_state[1]_i_4_n_0\,
      I3 => \nby_cnt_reg_n_0_[1]\,
      I4 => \nby_cnt_reg_n_0_[0]\,
      I5 => \nby_cnt_reg_n_0_[2]\,
      O => \nby_cnt[2]_i_2_n_0\
    );
\nby_cnt[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0004400F000F000"
    )
        port map (
      I0 => \nby_cnt[2]_i_7_n_0\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => \I2C_CFG_reg_n_0_[0]\,
      I3 => \I2C_NBY_reg_n_0_[2]\,
      I4 => \current_state_reg_n_0_[2]\,
      I5 => \current_state_reg_n_0_[1]\,
      O => \nby_cnt[2]_i_3_n_0\
    );
\nby_cnt[2]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F2000000"
    )
        port map (
      I0 => restart_reg_n_0,
      I1 => \^i2c_scl_reg_0\,
      I2 => \current_state[2]_i_7_n_0\,
      I3 => \I2C_NBY_reg_n_0_[2]\,
      I4 => \I2C_CFG_reg_n_0_[0]\,
      O => \nby_cnt[2]_i_4_n_0\
    );
\nby_cnt[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA8A8A888888888"
    )
        port map (
      I0 => rst_n,
      I1 => awready_i_3_n_0,
      I2 => \nby_cnt[2]_i_8_n_0\,
      I3 => \shift_cnt[0]_i_2_n_0\,
      I4 => \current_state[1]_i_4_n_0\,
      I5 => \nby_cnt[2]_i_9_n_0\,
      O => \nby_cnt[2]_i_5_n_0\
    );
\nby_cnt[2]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[0]\,
      I1 => \I2C_NBY_reg_n_0_[2]\,
      O => \nby_cnt[2]_i_6_n_0\
    );
\nby_cnt[2]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55515555"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[0]\,
      I1 => delay_reg_n_0,
      I2 => r_w_reg_n_0,
      I3 => \^i2c_scl_reg_0\,
      I4 => is_read_op_reg_n_0,
      O => \nby_cnt[2]_i_7_n_0\
    );
\nby_cnt[2]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF0080FFAA"
    )
        port map (
      I0 => \current_state_reg_n_0_[0]\,
      I1 => is_read_op_reg_n_0,
      I2 => \nby_cnt[2]_i_10_n_0\,
      I3 => \shift_cnt[2]_i_4_n_0\,
      I4 => freq_div_en,
      I5 => restart_reg_n_0,
      O => \nby_cnt[2]_i_8_n_0\
    );
\nby_cnt[2]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000100000"
    )
        port map (
      I0 => \shift_byte[7]_i_4_n_0\,
      I1 => \nby_cnt[2]_i_11_n_0\,
      I2 => \freq_div_cnt_reg_n_0_[3]\,
      I3 => \freq_div_cnt_reg_n_0_[1]\,
      I4 => \freq_div_cnt_reg_n_0_[2]\,
      I5 => \I2C_CFG[3]_i_6_n_0\,
      O => \nby_cnt[2]_i_9_n_0\
    );
\nby_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => \nby_cnt[0]_i_1_n_0\,
      Q => \nby_cnt_reg_n_0_[0]\,
      R => '0'
    );
\nby_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => \nby_cnt[1]_i_1_n_0\,
      Q => \nby_cnt_reg_n_0_[1]\,
      R => '0'
    );
\nby_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => \nby_cnt[2]_i_1_n_0\,
      Q => \nby_cnt_reg_n_0_[2]\,
      R => '0'
    );
r_w_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF11FF51EE00AA00"
    )
        port map (
      I0 => awready_i_3_n_0,
      I1 => \I2C_CFG[3]_i_5_n_0\,
      I2 => r_w_i_2_n_0,
      I3 => freq_div_en,
      I4 => r_w_i_3_n_0,
      I5 => r_w_reg_n_0,
      O => r_w_i_1_n_0
    );
r_w_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \current_state_reg_n_0_[2]\,
      I1 => \current_state_reg_n_0_[1]\,
      O => r_w_i_2_n_0
    );
r_w_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000008000000FFFF"
    )
        port map (
      I0 => delay_reg_n_0,
      I1 => byte_cnt1,
      I2 => \I2C_CFG_reg_n_0_[0]\,
      I3 => is_read_op_reg_n_0,
      I4 => \current_state[2]_i_4_n_0\,
      I5 => freq_div_en,
      O => r_w_i_3_n_0
    );
r_w_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^i2c_scl_reg_0\,
      I1 => r_w_reg_n_0,
      O => byte_cnt1
    );
r_w_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => r_w_i_1_n_0,
      Q => r_w_reg_n_0
    );
\rdata[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[0]\,
      I1 => araddr(4),
      I2 => \rdata[0]_i_2_n_0\,
      O => \rdata[0]_i_1_n_0\
    );
\rdata[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \I2C_TDR_reg_n_0_[0]\,
      I1 => \I2C_RDR_reg_n_0_[0]\,
      I2 => araddr(3),
      I3 => \I2C_ADR__0\(0),
      I4 => araddr(2),
      I5 => \I2C_NBY_reg_n_0_[0]\,
      O => \rdata[0]_i_2_n_0\
    );
\rdata[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[10]\,
      I1 => araddr(4),
      I2 => \rdata[10]_i_2_n_0\,
      O => \rdata[10]_i_1_n_0\
    );
\rdata[10]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data1(2),
      I1 => \I2C_RDR_reg_n_0_[10]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(10),
      O => \rdata[10]_i_2_n_0\
    );
\rdata[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[11]\,
      I1 => araddr(4),
      I2 => \rdata[11]_i_2_n_0\,
      O => \rdata[11]_i_1_n_0\
    );
\rdata[11]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data1(3),
      I1 => \I2C_RDR_reg_n_0_[11]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(11),
      O => \rdata[11]_i_2_n_0\
    );
\rdata[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[12]\,
      I1 => araddr(4),
      I2 => \rdata[12]_i_2_n_0\,
      O => \rdata[12]_i_1_n_0\
    );
\rdata[12]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data1(4),
      I1 => \I2C_RDR_reg_n_0_[12]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(12),
      O => \rdata[12]_i_2_n_0\
    );
\rdata[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[13]\,
      I1 => araddr(4),
      I2 => \rdata[13]_i_2_n_0\,
      O => \rdata[13]_i_1_n_0\
    );
\rdata[13]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data1(5),
      I1 => \I2C_RDR_reg_n_0_[13]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(13),
      O => \rdata[13]_i_2_n_0\
    );
\rdata[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[14]\,
      I1 => araddr(4),
      I2 => \rdata[14]_i_2_n_0\,
      O => \rdata[14]_i_1_n_0\
    );
\rdata[14]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data1(6),
      I1 => \I2C_RDR_reg_n_0_[14]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(14),
      O => \rdata[14]_i_2_n_0\
    );
\rdata[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[15]\,
      I1 => araddr(4),
      I2 => \rdata[15]_i_2_n_0\,
      O => \rdata[15]_i_1_n_0\
    );
\rdata[15]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data1(7),
      I1 => \I2C_RDR_reg_n_0_[15]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(15),
      O => \rdata[15]_i_2_n_0\
    );
\rdata[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[16]\,
      I1 => araddr(4),
      I2 => \rdata[16]_i_2_n_0\,
      O => \rdata[16]_i_1_n_0\
    );
\rdata[16]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data2(0),
      I1 => \I2C_RDR_reg_n_0_[16]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(16),
      O => \rdata[16]_i_2_n_0\
    );
\rdata[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[17]\,
      I1 => araddr(4),
      I2 => \rdata[17]_i_2_n_0\,
      O => \rdata[17]_i_1_n_0\
    );
\rdata[17]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data2(1),
      I1 => \I2C_RDR_reg_n_0_[17]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(17),
      O => \rdata[17]_i_2_n_0\
    );
\rdata[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[18]\,
      I1 => araddr(4),
      I2 => \rdata[18]_i_2_n_0\,
      O => \rdata[18]_i_1_n_0\
    );
\rdata[18]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data2(2),
      I1 => \I2C_RDR_reg_n_0_[18]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(18),
      O => \rdata[18]_i_2_n_0\
    );
\rdata[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[19]\,
      I1 => araddr(4),
      I2 => \rdata[19]_i_2_n_0\,
      O => \rdata[19]_i_1_n_0\
    );
\rdata[19]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data2(3),
      I1 => \I2C_RDR_reg_n_0_[19]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(19),
      O => \rdata[19]_i_2_n_0\
    );
\rdata[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[1]\,
      I1 => araddr(4),
      I2 => \rdata[1]_i_2_n_0\,
      O => \rdata[1]_i_1_n_0\
    );
\rdata[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \I2C_TDR_reg_n_0_[1]\,
      I1 => \I2C_RDR_reg_n_0_[1]\,
      I2 => araddr(3),
      I3 => \I2C_ADR__0\(1),
      I4 => araddr(2),
      I5 => \I2C_NBY_reg_n_0_[1]\,
      O => \rdata[1]_i_2_n_0\
    );
\rdata[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[20]\,
      I1 => araddr(4),
      I2 => \rdata[20]_i_2_n_0\,
      O => \rdata[20]_i_1_n_0\
    );
\rdata[20]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data2(4),
      I1 => \I2C_RDR_reg_n_0_[20]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(20),
      O => \rdata[20]_i_2_n_0\
    );
\rdata[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[21]\,
      I1 => araddr(4),
      I2 => \rdata[21]_i_2_n_0\,
      O => \rdata[21]_i_1_n_0\
    );
\rdata[21]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data2(5),
      I1 => \I2C_RDR_reg_n_0_[21]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(21),
      O => \rdata[21]_i_2_n_0\
    );
\rdata[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[22]\,
      I1 => araddr(4),
      I2 => \rdata[22]_i_2_n_0\,
      O => \rdata[22]_i_1_n_0\
    );
\rdata[22]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data2(6),
      I1 => \I2C_RDR_reg_n_0_[22]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(22),
      O => \rdata[22]_i_2_n_0\
    );
\rdata[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[23]\,
      I1 => araddr(4),
      I2 => \rdata[23]_i_2_n_0\,
      O => \rdata[23]_i_1_n_0\
    );
\rdata[23]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data2(7),
      I1 => \I2C_RDR_reg_n_0_[23]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(23),
      O => \rdata[23]_i_2_n_0\
    );
\rdata[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[24]\,
      I1 => araddr(4),
      I2 => \rdata[24]_i_2_n_0\,
      O => \rdata[24]_i_1_n_0\
    );
\rdata[24]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data3(0),
      I1 => \I2C_RDR_reg_n_0_[24]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(24),
      O => \rdata[24]_i_2_n_0\
    );
\rdata[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[25]\,
      I1 => araddr(4),
      I2 => \rdata[25]_i_2_n_0\,
      O => \rdata[25]_i_1_n_0\
    );
\rdata[25]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data3(1),
      I1 => \I2C_RDR_reg_n_0_[25]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(25),
      O => \rdata[25]_i_2_n_0\
    );
\rdata[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[26]\,
      I1 => araddr(4),
      I2 => \rdata[26]_i_2_n_0\,
      O => \rdata[26]_i_1_n_0\
    );
\rdata[26]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data3(2),
      I1 => \I2C_RDR_reg_n_0_[26]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(26),
      O => \rdata[26]_i_2_n_0\
    );
\rdata[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[27]\,
      I1 => araddr(4),
      I2 => \rdata[27]_i_2_n_0\,
      O => \rdata[27]_i_1_n_0\
    );
\rdata[27]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data3(3),
      I1 => \I2C_RDR_reg_n_0_[27]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(27),
      O => \rdata[27]_i_2_n_0\
    );
\rdata[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[28]\,
      I1 => araddr(4),
      I2 => \rdata[28]_i_2_n_0\,
      O => \rdata[28]_i_1_n_0\
    );
\rdata[28]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data3(4),
      I1 => \I2C_RDR_reg_n_0_[28]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(28),
      O => \rdata[28]_i_2_n_0\
    );
\rdata[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[29]\,
      I1 => araddr(4),
      I2 => \rdata[29]_i_2_n_0\,
      O => \rdata[29]_i_1_n_0\
    );
\rdata[29]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data3(5),
      I1 => \I2C_RDR_reg_n_0_[29]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(29),
      O => \rdata[29]_i_2_n_0\
    );
\rdata[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[2]\,
      I1 => araddr(4),
      I2 => \rdata[2]_i_2_n_0\,
      O => \rdata[2]_i_1_n_0\
    );
\rdata[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \I2C_TDR_reg_n_0_[2]\,
      I1 => \I2C_RDR_reg_n_0_[2]\,
      I2 => araddr(3),
      I3 => \I2C_ADR__0\(2),
      I4 => araddr(2),
      I5 => \I2C_NBY_reg_n_0_[2]\,
      O => \rdata[2]_i_2_n_0\
    );
\rdata[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[30]\,
      I1 => araddr(4),
      I2 => \rdata[30]_i_2_n_0\,
      O => \rdata[30]_i_1_n_0\
    );
\rdata[30]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data3(6),
      I1 => \I2C_RDR_reg_n_0_[30]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(30),
      O => \rdata[30]_i_2_n_0\
    );
\rdata[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"001F"
    )
        port map (
      I0 => araddr(3),
      I1 => araddr(2),
      I2 => araddr(4),
      I3 => \rdata[31]_i_3_n_0\,
      O => \rdata[31]_i_1_n_0\
    );
\rdata[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[31]\,
      I1 => araddr(4),
      I2 => \rdata[31]_i_4_n_0\,
      O => \rdata[31]_i_2_n_0\
    );
\rdata[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFEFFFFFFFF"
    )
        port map (
      I0 => araddr(7),
      I1 => araddr(0),
      I2 => araddr(1),
      I3 => araddr(5),
      I4 => araddr(6),
      I5 => arvalid,
      O => \rdata[31]_i_3_n_0\
    );
\rdata[31]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data3(7),
      I1 => \I2C_RDR_reg_n_0_[31]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(31),
      O => \rdata[31]_i_4_n_0\
    );
\rdata[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[3]\,
      I1 => araddr(4),
      I2 => \rdata[3]_i_2_n_0\,
      O => \rdata[3]_i_1_n_0\
    );
\rdata[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \I2C_TDR_reg_n_0_[3]\,
      I1 => \I2C_RDR_reg_n_0_[3]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(3),
      O => \rdata[3]_i_2_n_0\
    );
\rdata[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[4]\,
      I1 => araddr(4),
      I2 => \rdata[4]_i_2_n_0\,
      O => \rdata[4]_i_1_n_0\
    );
\rdata[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \I2C_TDR_reg_n_0_[4]\,
      I1 => \I2C_RDR_reg_n_0_[4]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(4),
      O => \rdata[4]_i_2_n_0\
    );
\rdata[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[5]\,
      I1 => araddr(4),
      I2 => \rdata[5]_i_2_n_0\,
      O => \rdata[5]_i_1_n_0\
    );
\rdata[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \I2C_TDR_reg_n_0_[5]\,
      I1 => \I2C_RDR_reg_n_0_[5]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(5),
      O => \rdata[5]_i_2_n_0\
    );
\rdata[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[6]\,
      I1 => araddr(4),
      I2 => \rdata[6]_i_2_n_0\,
      O => \rdata[6]_i_1_n_0\
    );
\rdata[6]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \I2C_TDR_reg_n_0_[6]\,
      I1 => \I2C_RDR_reg_n_0_[6]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(6),
      O => \rdata[6]_i_2_n_0\
    );
\rdata[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[7]\,
      I1 => araddr(4),
      I2 => \rdata[7]_i_2_n_0\,
      O => \rdata[7]_i_1_n_0\
    );
\rdata[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \I2C_TDR_reg_n_0_[7]\,
      I1 => \I2C_RDR_reg_n_0_[7]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(7),
      O => \rdata[7]_i_2_n_0\
    );
\rdata[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[8]\,
      I1 => araddr(4),
      I2 => \rdata[8]_i_2_n_0\,
      O => \rdata[8]_i_1_n_0\
    );
\rdata[8]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data1(0),
      I1 => \I2C_RDR_reg_n_0_[8]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(8),
      O => \rdata[8]_i_2_n_0\
    );
\rdata[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[9]\,
      I1 => araddr(4),
      I2 => \rdata[9]_i_2_n_0\,
      O => \rdata[9]_i_1_n_0\
    );
\rdata[9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => data1(1),
      I1 => \I2C_RDR_reg_n_0_[9]\,
      I2 => araddr(3),
      I3 => araddr(2),
      I4 => \I2C_ADR__0\(9),
      O => \rdata[9]_i_2_n_0\
    );
\rdata_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[0]_i_1_n_0\,
      Q => rdata(0)
    );
\rdata_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[10]_i_1_n_0\,
      Q => rdata(10)
    );
\rdata_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[11]_i_1_n_0\,
      Q => rdata(11)
    );
\rdata_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[12]_i_1_n_0\,
      Q => rdata(12)
    );
\rdata_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[13]_i_1_n_0\,
      Q => rdata(13)
    );
\rdata_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[14]_i_1_n_0\,
      Q => rdata(14)
    );
\rdata_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[15]_i_1_n_0\,
      Q => rdata(15)
    );
\rdata_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[16]_i_1_n_0\,
      Q => rdata(16)
    );
\rdata_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[17]_i_1_n_0\,
      Q => rdata(17)
    );
\rdata_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[18]_i_1_n_0\,
      Q => rdata(18)
    );
\rdata_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[19]_i_1_n_0\,
      Q => rdata(19)
    );
\rdata_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[1]_i_1_n_0\,
      Q => rdata(1)
    );
\rdata_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[20]_i_1_n_0\,
      Q => rdata(20)
    );
\rdata_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[21]_i_1_n_0\,
      Q => rdata(21)
    );
\rdata_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[22]_i_1_n_0\,
      Q => rdata(22)
    );
\rdata_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[23]_i_1_n_0\,
      Q => rdata(23)
    );
\rdata_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[24]_i_1_n_0\,
      Q => rdata(24)
    );
\rdata_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[25]_i_1_n_0\,
      Q => rdata(25)
    );
\rdata_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[26]_i_1_n_0\,
      Q => rdata(26)
    );
\rdata_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[27]_i_1_n_0\,
      Q => rdata(27)
    );
\rdata_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[28]_i_1_n_0\,
      Q => rdata(28)
    );
\rdata_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[29]_i_1_n_0\,
      Q => rdata(29)
    );
\rdata_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[2]_i_1_n_0\,
      Q => rdata(2)
    );
\rdata_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[30]_i_1_n_0\,
      Q => rdata(30)
    );
\rdata_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[31]_i_2_n_0\,
      Q => rdata(31)
    );
\rdata_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[3]_i_1_n_0\,
      Q => rdata(3)
    );
\rdata_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[4]_i_1_n_0\,
      Q => rdata(4)
    );
\rdata_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[5]_i_1_n_0\,
      Q => rdata(5)
    );
\rdata_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[6]_i_1_n_0\,
      Q => rdata(6)
    );
\rdata_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[7]_i_1_n_0\,
      Q => rdata(7)
    );
\rdata_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[8]_i_1_n_0\,
      Q => rdata(8)
    );
\rdata_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rdata[31]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \rdata[9]_i_1_n_0\,
      Q => rdata(9)
    );
restart_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30338A88"
    )
        port map (
      I0 => delay_reg_n_0,
      I1 => restart_i_2_n_0,
      I2 => restart_i_3_n_0,
      I3 => \current_state[2]_i_2_n_0\,
      I4 => restart_reg_n_0,
      O => restart_i_1_n_0
    );
restart_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080008000800000"
    )
        port map (
      I0 => restart_reg_n_0,
      I1 => freq_div_en,
      I2 => \^i2c_scl_reg_0\,
      I3 => \shift_byte[7]_i_5_n_0\,
      I4 => \I2C_CFG_reg_n_0_[0]\,
      I5 => \I2C_CFG_reg_n_0_[2]\,
      O => restart_i_2_n_0
    );
restart_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFF7FF"
    )
        port map (
      I0 => byte_cnt1,
      I1 => delay_reg_n_0,
      I2 => \current_state[2]_i_4_n_0\,
      I3 => \I2C_CFG_reg_n_0_[2]\,
      I4 => \I2C_CFG_reg_n_0_[0]\,
      I5 => is_read_op_reg_n_0,
      O => restart_i_3_n_0
    );
restart_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => restart_i_1_n_0,
      Q => restart_reg_n_0
    );
rvalid_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AE"
    )
        port map (
      I0 => arvalid,
      I1 => \^rvalid\,
      I2 => rready,
      O => rvalid_i_1_n_0
    );
rvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => rvalid_i_1_n_0,
      Q => \^rvalid\
    );
sda_out_val_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABBBBBBBA8888888"
    )
        port map (
      I0 => sda_out_val_i_2_n_0,
      I1 => is_read_op19_out,
      I2 => \I2C_CFG[3]_i_5_n_0\,
      I3 => sda_out_val_i_3_n_0,
      I4 => sda_out_val_i_4_n_0,
      I5 => sda_out_val_reg_n_0,
      O => sda_out_val_i_1_n_0
    );
sda_out_val_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F100FB00"
    )
        port map (
      I0 => restart_reg_n_0,
      I1 => sda_out_val_i_5_n_0,
      I2 => \shift_byte[7]_i_5_n_0\,
      I3 => freq_div_en,
      I4 => \^i2c_scl_reg_0\,
      O => sda_out_val_i_2_n_0
    );
sda_out_val_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"4F"
    )
        port map (
      I0 => \current_state_reg_n_0_[1]\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => \current_state_reg_n_0_[2]\,
      O => sda_out_val_i_3_n_0
    );
sda_out_val_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBBBF0000"
    )
        port map (
      I0 => \current_state_reg_n_0_[0]\,
      I1 => freq_div_en,
      I2 => \^i2c_scl_reg_0\,
      I3 => r_w_reg_n_0,
      I4 => \byte_cnt[0]_i_5_n_0\,
      I5 => sda_out_val_i_6_n_0,
      O => sda_out_val_i_4_n_0
    );
sda_out_val_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000EEEE0E00EEEE"
    )
        port map (
      I0 => sda_out_val_i_7_n_0,
      I1 => sda_out_val_i_8_n_0,
      I2 => \current_state_reg_n_0_[1]\,
      I3 => \current_state_reg_n_0_[0]\,
      I4 => \current_state_reg_n_0_[2]\,
      I5 => \^i2c_scl_reg_0\,
      O => sda_out_val_i_5_n_0
    );
sda_out_val_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CDDDCDDDCCDDCDDD"
    )
        port map (
      I0 => \current_state_reg_n_0_[1]\,
      I1 => \current_state_reg_n_0_[2]\,
      I2 => \^i2c_scl_reg_0\,
      I3 => freq_div_en,
      I4 => \current_state_reg_n_0_[0]\,
      I5 => r_w_reg_n_0,
      O => sda_out_val_i_6_n_0
    );
sda_out_val_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAABAAAAABBBA"
    )
        port map (
      I0 => \current_state_reg_n_0_[2]\,
      I1 => \current_state_reg_n_0_[1]\,
      I2 => r_w_reg_n_0,
      I3 => \^i2c_scl_reg_0\,
      I4 => \current_state_reg_n_0_[0]\,
      I5 => freq_div_en,
      O => sda_out_val_i_7_n_0
    );
sda_out_val_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000555300000000"
    )
        port map (
      I0 => freq_div_en,
      I1 => p_3_in(7),
      I2 => r_w_reg_n_0,
      I3 => \^i2c_scl_reg_0\,
      I4 => \current_state_reg_n_0_[0]\,
      I5 => \current_state_reg_n_0_[1]\,
      O => sda_out_val_i_8_n_0
    );
sda_out_val_reg: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => sda_out_val_i_1_n_0,
      PRE => I2C_SCL_i_2_n_0,
      Q => sda_out_val_reg_n_0
    );
\shift_byte[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBBBBBBBAAAAAAAA"
    )
        port map (
      I0 => \shift_byte[0]_i_2_n_0\,
      I1 => \shift_byte[0]_i_3_n_0\,
      I2 => I2C_SDA,
      I3 => \shift_byte[0]_i_4_n_0\,
      I4 => \shift_cnt[0]_i_2_n_0\,
      I5 => \current_state[2]_i_2_n_0\,
      O => \shift_byte[0]_i_1_n_0\
    );
\shift_byte[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => \shift_byte[7]_i_5_n_0\,
      I1 => \^i2c_scl_reg_0\,
      I2 => freq_div_en,
      I3 => restart_reg_n_0,
      O => \shift_byte[0]_i_2_n_0\
    );
\shift_byte[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F7F777F7F7F7F7F"
    )
        port map (
      I0 => \shift_byte[7]_i_8_n_0\,
      I1 => \current_state_reg_n_0_[0]\,
      I2 => \shift_byte[0]_i_5_n_0\,
      I3 => \shift_byte[7]_i_11_n_0\,
      I4 => \byte_cnt_reg_n_0_[0]\,
      I5 => data3(0),
      O => \shift_byte[0]_i_3_n_0\
    );
\shift_byte[0]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^i2c_scl_reg_0\,
      I1 => r_w_reg_n_0,
      O => \shift_byte[0]_i_4_n_0\
    );
\shift_byte[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F8C83808"
    )
        port map (
      I0 => \I2C_TDR_reg_n_0_[0]\,
      I1 => \byte_cnt_reg_n_0_[0]\,
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => data1(0),
      I4 => data2(0),
      I5 => \byte_cnt_reg_n_0_[2]\,
      O => \shift_byte[0]_i_5_n_0\
    );
\shift_byte[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FD5DA808FDFDA808"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \shift_byte[1]_i_2_n_0\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \shift_byte[1]_i_3_n_0\,
      I4 => \I2C_ADR__0\(0),
      I5 => \shift_byte[7]_i_8_n_0\,
      O => \shift_byte[1]_i_1_n_0\
    );
\shift_byte[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAAAAAEA2AAAAA2"
    )
        port map (
      I0 => \I2C_ADR__0\(0),
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state_reg_n_0_[2]\,
      I3 => r_w_reg_n_0,
      I4 => \^i2c_scl_reg_0\,
      I5 => \shift_byte_reg_n_0_[0]\,
      O => \shift_byte[1]_i_2_n_0\
    );
\shift_byte[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCC0C8080C00C808"
    )
        port map (
      I0 => \shift_byte[1]_i_4_n_0\,
      I1 => \shift_byte[7]_i_8_n_0\,
      I2 => \shift_byte[7]_i_11_n_0\,
      I3 => \I2C_ADR__0\(0),
      I4 => \shift_byte[7]_i_12_n_0\,
      I5 => data3(1),
      O => \shift_byte[1]_i_3_n_0\
    );
\shift_byte[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data2(1),
      I1 => data1(1),
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \I2C_TDR_reg_n_0_[1]\,
      I4 => \byte_cnt_reg_n_0_[0]\,
      I5 => \I2C_ADR__0\(0),
      O => \shift_byte[1]_i_4_n_0\
    );
\shift_byte[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5DFD08A85DFD0808"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \shift_byte[2]_i_2_n_0\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \shift_byte[2]_i_3_n_0\,
      I4 => \I2C_ADR__0\(1),
      I5 => \shift_byte[7]_i_8_n_0\,
      O => \shift_byte[2]_i_1_n_0\
    );
\shift_byte[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAAAAAEA2AAAAA2"
    )
        port map (
      I0 => \I2C_ADR__0\(1),
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state_reg_n_0_[2]\,
      I3 => r_w_reg_n_0,
      I4 => \^i2c_scl_reg_0\,
      I5 => \shift_byte_reg_n_0_[1]\,
      O => \shift_byte[2]_i_2_n_0\
    );
\shift_byte[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000CCC0C0C440C44"
    )
        port map (
      I0 => \shift_byte[2]_i_4_n_0\,
      I1 => \shift_byte[7]_i_8_n_0\,
      I2 => \I2C_ADR__0\(1),
      I3 => \shift_byte[7]_i_12_n_0\,
      I4 => data3(2),
      I5 => \shift_byte[7]_i_11_n_0\,
      O => \shift_byte[2]_i_3_n_0\
    );
\shift_byte[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data2(2),
      I1 => data1(2),
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \I2C_TDR_reg_n_0_[2]\,
      I4 => \byte_cnt_reg_n_0_[0]\,
      I5 => \I2C_ADR__0\(1),
      O => \shift_byte[2]_i_4_n_0\
    );
\shift_byte[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5DFD08A85DFD0808"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \shift_byte[3]_i_2_n_0\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \shift_byte[3]_i_3_n_0\,
      I4 => \I2C_ADR__0\(2),
      I5 => \shift_byte[7]_i_8_n_0\,
      O => \shift_byte[3]_i_1_n_0\
    );
\shift_byte[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAAAAAEA2AAAAA2"
    )
        port map (
      I0 => \I2C_ADR__0\(2),
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state_reg_n_0_[2]\,
      I3 => r_w_reg_n_0,
      I4 => \^i2c_scl_reg_0\,
      I5 => \shift_byte_reg_n_0_[2]\,
      O => \shift_byte[3]_i_2_n_0\
    );
\shift_byte[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000CCC0C0C440C44"
    )
        port map (
      I0 => \shift_byte[3]_i_4_n_0\,
      I1 => \shift_byte[7]_i_8_n_0\,
      I2 => \I2C_ADR__0\(2),
      I3 => \shift_byte[7]_i_12_n_0\,
      I4 => data3(3),
      I5 => \shift_byte[7]_i_11_n_0\,
      O => \shift_byte[3]_i_3_n_0\
    );
\shift_byte[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data2(3),
      I1 => data1(3),
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \I2C_TDR_reg_n_0_[3]\,
      I4 => \byte_cnt_reg_n_0_[0]\,
      I5 => \I2C_ADR__0\(2),
      O => \shift_byte[3]_i_4_n_0\
    );
\shift_byte[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5DFD08A85DFD0808"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \shift_byte[4]_i_2_n_0\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \shift_byte[4]_i_3_n_0\,
      I4 => \I2C_ADR__0\(3),
      I5 => \shift_byte[7]_i_8_n_0\,
      O => \shift_byte[4]_i_1_n_0\
    );
\shift_byte[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAAAAAEA2AAAAA2"
    )
        port map (
      I0 => \I2C_ADR__0\(3),
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state_reg_n_0_[2]\,
      I3 => r_w_reg_n_0,
      I4 => \^i2c_scl_reg_0\,
      I5 => \shift_byte_reg_n_0_[3]\,
      O => \shift_byte[4]_i_2_n_0\
    );
\shift_byte[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000CCC0C0C440C44"
    )
        port map (
      I0 => \shift_byte[4]_i_4_n_0\,
      I1 => \shift_byte[7]_i_8_n_0\,
      I2 => \I2C_ADR__0\(3),
      I3 => \shift_byte[7]_i_12_n_0\,
      I4 => data3(4),
      I5 => \shift_byte[7]_i_11_n_0\,
      O => \shift_byte[4]_i_3_n_0\
    );
\shift_byte[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data2(4),
      I1 => data1(4),
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \I2C_TDR_reg_n_0_[4]\,
      I4 => \byte_cnt_reg_n_0_[0]\,
      I5 => \I2C_ADR__0\(3),
      O => \shift_byte[4]_i_4_n_0\
    );
\shift_byte[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5DFD08A85DFD0808"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \shift_byte[5]_i_2_n_0\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \shift_byte[5]_i_3_n_0\,
      I4 => \I2C_ADR__0\(4),
      I5 => \shift_byte[7]_i_8_n_0\,
      O => \shift_byte[5]_i_1_n_0\
    );
\shift_byte[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAAAAAEA2AAAAA2"
    )
        port map (
      I0 => \I2C_ADR__0\(4),
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state_reg_n_0_[2]\,
      I3 => r_w_reg_n_0,
      I4 => \^i2c_scl_reg_0\,
      I5 => \shift_byte_reg_n_0_[4]\,
      O => \shift_byte[5]_i_2_n_0\
    );
\shift_byte[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000CCC0C0C440C44"
    )
        port map (
      I0 => \shift_byte[5]_i_4_n_0\,
      I1 => \shift_byte[7]_i_8_n_0\,
      I2 => \I2C_ADR__0\(4),
      I3 => \shift_byte[7]_i_12_n_0\,
      I4 => data3(5),
      I5 => \shift_byte[7]_i_11_n_0\,
      O => \shift_byte[5]_i_3_n_0\
    );
\shift_byte[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data2(5),
      I1 => data1(5),
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \I2C_TDR_reg_n_0_[5]\,
      I4 => \byte_cnt_reg_n_0_[0]\,
      I5 => \I2C_ADR__0\(4),
      O => \shift_byte[5]_i_4_n_0\
    );
\shift_byte[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEECEC444444444"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \I2C_ADR__0\(5),
      I2 => \shift_byte[6]_i_2_n_0\,
      I3 => \shift_byte_reg_n_0_[5]\,
      I4 => \current_state_reg_n_0_[0]\,
      I5 => \shift_byte[6]_i_3_n_0\,
      O => \shift_byte[6]_i_1_n_0\
    );
\shift_byte[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFFD"
    )
        port map (
      I0 => \current_state_reg_n_0_[1]\,
      I1 => \current_state_reg_n_0_[2]\,
      I2 => r_w_reg_n_0,
      I3 => \^i2c_scl_reg_0\,
      O => \shift_byte[6]_i_2_n_0\
    );
\shift_byte[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"54FF54FFFFFF00FF"
    )
        port map (
      I0 => \shift_byte[6]_i_4_n_0\,
      I1 => \shift_byte[6]_i_5_n_0\,
      I2 => \shift_byte[6]_i_6_n_0\,
      I3 => \current_state_reg_n_0_[0]\,
      I4 => \I2C_ADR__0\(5),
      I5 => \shift_byte[7]_i_8_n_0\,
      O => \shift_byte[6]_i_3_n_0\
    );
\shift_byte[6]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04000700"
    )
        port map (
      I0 => \I2C_ADR__0\(5),
      I1 => \byte_cnt_reg_n_0_[0]\,
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \byte_cnt_reg_n_0_[2]\,
      I4 => data3(6),
      O => \shift_byte[6]_i_4_n_0\
    );
\shift_byte[6]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AC00"
    )
        port map (
      I0 => data2(6),
      I1 => data1(6),
      I2 => \byte_cnt_reg_n_0_[0]\,
      I3 => \byte_cnt_reg_n_0_[1]\,
      I4 => \byte_cnt_reg_n_0_[2]\,
      O => \shift_byte[6]_i_5_n_0\
    );
\shift_byte[6]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFAF0C0A"
    )
        port map (
      I0 => \I2C_ADR__0\(5),
      I1 => \I2C_TDR_reg_n_0_[6]\,
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \byte_cnt_reg_n_0_[0]\,
      I4 => \byte_cnt_reg_n_0_[2]\,
      O => \shift_byte[6]_i_6_n_0\
    );
\shift_byte[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0033003310331133"
    )
        port map (
      I0 => \shift_byte[7]_i_3_n_0\,
      I1 => \shift_byte[7]_i_4_n_0\,
      I2 => \^i2c_scl_reg_0\,
      I3 => freq_div_en,
      I4 => restart_reg_n_0,
      I5 => \shift_byte[7]_i_5_n_0\,
      O => \shift_byte[7]_i_1_n_0\
    );
\shift_byte[7]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data2(7),
      I1 => data1(7),
      I2 => \byte_cnt_reg_n_0_[1]\,
      I3 => \I2C_TDR_reg_n_0_[7]\,
      I4 => \byte_cnt_reg_n_0_[0]\,
      I5 => \I2C_ADR__0\(6),
      O => \shift_byte[7]_i_10_n_0\
    );
\shift_byte[7]_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \byte_cnt_reg_n_0_[2]\,
      I1 => \byte_cnt_reg_n_0_[1]\,
      O => \shift_byte[7]_i_11_n_0\
    );
\shift_byte[7]_i_12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => \byte_cnt_reg_n_0_[2]\,
      I1 => \byte_cnt_reg_n_0_[1]\,
      I2 => \byte_cnt_reg_n_0_[0]\,
      O => \shift_byte[7]_i_12_n_0\
    );
\shift_byte[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FD5DA808FDFDA808"
    )
        port map (
      I0 => \current_state[2]_i_2_n_0\,
      I1 => \shift_byte[7]_i_6_n_0\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => \shift_byte[7]_i_7_n_0\,
      I4 => \I2C_ADR__0\(6),
      I5 => \shift_byte[7]_i_8_n_0\,
      O => \shift_byte[7]_i_2_n_0\
    );
\shift_byte[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01000101"
    )
        port map (
      I0 => \shift_cnt[2]_i_5_n_0\,
      I1 => \shift_byte[7]_i_9_n_0\,
      I2 => restart_reg_n_0,
      I3 => freq_div_en,
      I4 => \current_state_reg_n_0_[2]\,
      O => \shift_byte[7]_i_3_n_0\
    );
\shift_byte[7]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \I2C_CFG_reg_n_0_[2]\,
      I1 => \I2C_CFG_reg_n_0_[0]\,
      O => \shift_byte[7]_i_4_n_0\
    );
\shift_byte[7]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFDF"
    )
        port map (
      I0 => \freq_div_cnt_reg_n_0_[3]\,
      I1 => \freq_div_cnt_reg_n_0_[1]\,
      I2 => \freq_div_cnt_reg_n_0_[2]\,
      I3 => \I2C_CFG[3]_i_6_n_0\,
      O => \shift_byte[7]_i_5_n_0\
    );
\shift_byte[7]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAAAAAEA2AAAAA2"
    )
        port map (
      I0 => \I2C_ADR__0\(6),
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state_reg_n_0_[2]\,
      I3 => r_w_reg_n_0,
      I4 => \^i2c_scl_reg_0\,
      I5 => \shift_byte_reg_n_0_[6]\,
      O => \shift_byte[7]_i_6_n_0\
    );
\shift_byte[7]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCC0C8080C00C808"
    )
        port map (
      I0 => \shift_byte[7]_i_10_n_0\,
      I1 => \shift_byte[7]_i_8_n_0\,
      I2 => \shift_byte[7]_i_11_n_0\,
      I3 => \I2C_ADR__0\(6),
      I4 => \shift_byte[7]_i_12_n_0\,
      I5 => data3(7),
      O => \shift_byte[7]_i_7_n_0\
    );
\shift_byte[7]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000100"
    )
        port map (
      I0 => \current_state_reg_n_0_[1]\,
      I1 => \current_state_reg_n_0_[2]\,
      I2 => r_w_reg_n_0,
      I3 => \^i2c_scl_reg_0\,
      I4 => I2C_SDA,
      O => \shift_byte[7]_i_8_n_0\
    );
\shift_byte[7]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1E000000"
    )
        port map (
      I0 => \byte_cnt_reg_n_0_[0]\,
      I1 => \byte_cnt_reg_n_0_[1]\,
      I2 => \byte_cnt_reg_n_0_[2]\,
      I3 => \shift_byte[7]_i_8_n_0\,
      I4 => \current_state_reg_n_0_[0]\,
      O => \shift_byte[7]_i_9_n_0\
    );
\shift_byte_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte[0]_i_1_n_0\,
      Q => \shift_byte_reg_n_0_[0]\
    );
\shift_byte_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte[1]_i_1_n_0\,
      Q => \shift_byte_reg_n_0_[1]\
    );
\shift_byte_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte[2]_i_1_n_0\,
      Q => \shift_byte_reg_n_0_[2]\
    );
\shift_byte_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte[3]_i_1_n_0\,
      Q => \shift_byte_reg_n_0_[3]\
    );
\shift_byte_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte[4]_i_1_n_0\,
      Q => \shift_byte_reg_n_0_[4]\
    );
\shift_byte_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte[5]_i_1_n_0\,
      Q => \shift_byte_reg_n_0_[5]\
    );
\shift_byte_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte[6]_i_1_n_0\,
      Q => \shift_byte_reg_n_0_[6]\
    );
\shift_byte_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_byte[7]_i_2_n_0\,
      Q => p_3_in(7)
    );
\shift_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7DFFFFFFFFFF0000"
    )
        port map (
      I0 => \shift_cnt[0]_i_2_n_0\,
      I1 => r_w_reg_n_0,
      I2 => \^i2c_scl_reg_0\,
      I3 => \current_state[2]_i_2_n_0\,
      I4 => \shift_cnt[2]_i_3_n_0\,
      I5 => \shift_cnt_reg_n_0_[0]\,
      O => \shift_cnt[0]_i_1_n_0\
    );
\shift_cnt[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \current_state_reg_n_0_[0]\,
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state_reg_n_0_[2]\,
      O => \shift_cnt[0]_i_2_n_0\
    );
\shift_cnt[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FF7F00"
    )
        port map (
      I0 => \shift_cnt[2]_i_2_n_0\,
      I1 => \current_state[2]_i_2_n_0\,
      I2 => \shift_cnt_reg_n_0_[0]\,
      I3 => \shift_cnt[2]_i_3_n_0\,
      I4 => \shift_cnt_reg_n_0_[1]\,
      O => \shift_cnt[1]_i_1_n_0\
    );
\shift_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF7FFFF777F0000"
    )
        port map (
      I0 => \shift_cnt[2]_i_2_n_0\,
      I1 => \current_state[2]_i_2_n_0\,
      I2 => \shift_cnt_reg_n_0_[0]\,
      I3 => \shift_cnt_reg_n_0_[1]\,
      I4 => \shift_cnt[2]_i_3_n_0\,
      I5 => \shift_cnt_reg_n_0_[2]\,
      O => \shift_cnt[2]_i_1_n_0\
    );
\shift_cnt[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04000004"
    )
        port map (
      I0 => \current_state_reg_n_0_[2]\,
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state_reg_n_0_[0]\,
      I3 => r_w_reg_n_0,
      I4 => \^i2c_scl_reg_0\,
      O => \shift_cnt[2]_i_2_n_0\
    );
\shift_cnt[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFAEAAAAAAAA"
    )
        port map (
      I0 => awready_i_3_n_0,
      I1 => \shift_cnt[2]_i_4_n_0\,
      I2 => freq_div_en,
      I3 => \I2C_CFG[2]_i_2_n_0\,
      I4 => \shift_cnt[2]_i_5_n_0\,
      I5 => \I2C_CFG[3]_i_5_n_0\,
      O => \shift_cnt[2]_i_3_n_0\
    );
\shift_cnt[2]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \current_state_reg_n_0_[2]\,
      I1 => \current_state_reg_n_0_[1]\,
      O => \shift_cnt[2]_i_4_n_0\
    );
\shift_cnt[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"040C000C000C040C"
    )
        port map (
      I0 => \current_state_reg_n_0_[0]\,
      I1 => \current_state_reg_n_0_[1]\,
      I2 => \current_state_reg_n_0_[2]\,
      I3 => freq_div_en,
      I4 => \^i2c_scl_reg_0\,
      I5 => r_w_reg_n_0,
      O => \shift_cnt[2]_i_5_n_0\
    );
\shift_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_cnt[0]_i_1_n_0\,
      Q => \shift_cnt_reg_n_0_[0]\
    );
\shift_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_cnt[1]_i_1_n_0\,
      Q => \shift_cnt_reg_n_0_[1]\
    );
\shift_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => I2C_SCL_i_2_n_0,
      D => \shift_cnt[2]_i_1_n_0\,
      Q => \shift_cnt_reg_n_0_[2]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_I2C_Master_AXI4_Lite_0_0 is
  port (
    clk_i : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    I2C_SCL : out STD_LOGIC;
    I2C_SDA : inout STD_LOGIC;
    awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    awvalid : in STD_LOGIC;
    awready : out STD_LOGIC;
    wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wvalid : in STD_LOGIC;
    wready : out STD_LOGIC;
    bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    bvalid : out STD_LOGIC;
    bready : in STD_LOGIC;
    araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    arvalid : in STD_LOGIC;
    arready : out STD_LOGIC;
    rready : in STD_LOGIC;
    rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    rvalid : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_I2C_Master_AXI4_Lite_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_I2C_Master_AXI4_Lite_0_0 : entity is "design_1_I2C_Master_AXI4_Lite_0_0,I2C_Master_AXI4_Lite,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_I2C_Master_AXI4_Lite_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_I2C_Master_AXI4_Lite_0_0 : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_I2C_Master_AXI4_Lite_0_0 : entity is "I2C_Master_AXI4_Lite,Vivado 2025.2";
end design_1_I2C_Master_AXI4_Lite_0_0;

architecture STRUCTURE of design_1_I2C_Master_AXI4_Lite_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^awready\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of arready : signal is "xilinx.com:interface:aximm:1.0 interface_aximm ARREADY";
  attribute X_INTERFACE_INFO of arvalid : signal is "xilinx.com:interface:aximm:1.0 interface_aximm ARVALID";
  attribute X_INTERFACE_INFO of awready : signal is "xilinx.com:interface:aximm:1.0 interface_aximm AWREADY";
  attribute X_INTERFACE_INFO of awvalid : signal is "xilinx.com:interface:aximm:1.0 interface_aximm AWVALID";
  attribute X_INTERFACE_INFO of bready : signal is "xilinx.com:interface:aximm:1.0 interface_aximm BREADY";
  attribute X_INTERFACE_INFO of bvalid : signal is "xilinx.com:interface:aximm:1.0 interface_aximm BVALID";
  attribute X_INTERFACE_INFO of clk_i : signal is "xilinx.com:signal:clock:1.0 clk_i CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk_i : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk_i : signal is "XIL_INTERFACENAME clk_i, FREQ_TOLERANCE_HZ 0, ASSOCIATED_BUSIF interface_aximm, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rready : signal is "xilinx.com:interface:aximm:1.0 interface_aximm RREADY";
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_MODE of rst_n : signal is "slave";
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, ASSOCIATED_RESET rst_n, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rvalid : signal is "xilinx.com:interface:aximm:1.0 interface_aximm RVALID";
  attribute X_INTERFACE_INFO of wready : signal is "xilinx.com:interface:aximm:1.0 interface_aximm WREADY";
  attribute X_INTERFACE_INFO of wvalid : signal is "xilinx.com:interface:aximm:1.0 interface_aximm WVALID";
  attribute X_INTERFACE_INFO of araddr : signal is "xilinx.com:interface:aximm:1.0 interface_aximm ARADDR";
  attribute X_INTERFACE_INFO of awaddr : signal is "xilinx.com:interface:aximm:1.0 interface_aximm AWADDR";
  attribute X_INTERFACE_MODE of awaddr : signal is "slave";
  attribute X_INTERFACE_PARAMETER of awaddr : signal is "XIL_INTERFACENAME interface_aximm, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of bresp : signal is "xilinx.com:interface:aximm:1.0 interface_aximm BRESP";
  attribute X_INTERFACE_INFO of rdata : signal is "xilinx.com:interface:aximm:1.0 interface_aximm RDATA";
  attribute X_INTERFACE_INFO of rresp : signal is "xilinx.com:interface:aximm:1.0 interface_aximm RRESP";
  attribute X_INTERFACE_INFO of wdata : signal is "xilinx.com:interface:aximm:1.0 interface_aximm WDATA";
begin
  awready <= \^awready\;
  bresp(1) <= \<const0>\;
  bresp(0) <= \<const0>\;
  rresp(1) <= \<const0>\;
  rresp(0) <= \<const0>\;
  wready <= \^awready\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.design_1_I2C_Master_AXI4_Lite_0_0_I2C_Master_AXI4_Lite
     port map (
      I2C_SCL_reg_0 => I2C_SCL,
      I2C_SDA => I2C_SDA,
      araddr(7 downto 0) => araddr(7 downto 0),
      arready => arready,
      arvalid => arvalid,
      awaddr(7 downto 0) => awaddr(7 downto 0),
      awready => \^awready\,
      awvalid => awvalid,
      bready => bready,
      bvalid => bvalid,
      clk_i => clk_i,
      rdata(31 downto 0) => rdata(31 downto 0),
      rready => rready,
      rst_n => rst_n,
      rvalid => rvalid,
      wdata(31 downto 0) => wdata(31 downto 0),
      wvalid => wvalid
    );
end STRUCTURE;
