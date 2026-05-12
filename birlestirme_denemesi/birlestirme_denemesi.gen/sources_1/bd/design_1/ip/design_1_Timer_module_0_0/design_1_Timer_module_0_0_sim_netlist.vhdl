-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
-- Date        : Sat May  9 17:15:08 2026
-- Host        : Stradale running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_Timer_module_0_0/design_1_Timer_module_0_0_sim_netlist.vhdl
-- Design      : design_1_Timer_module_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Timer_module_0_0_Timer_module is
  port (
    rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bvalid : out STD_LOGIC;
    wready : out STD_LOGIC;
    rvalid : out STD_LOGIC;
    arready : out STD_LOGIC;
    awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk_i : in STD_LOGIC;
    wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    arvalid : in STD_LOGIC;
    awvalid : in STD_LOGIC;
    wvalid : in STD_LOGIC;
    araddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rst_n : in STD_LOGIC;
    bready : in STD_LOGIC;
    rready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_Timer_module_0_0_Timer_module : entity is "Timer_module";
end design_1_Timer_module_0_0_Timer_module;

architecture STRUCTURE of design_1_Timer_module_0_0_Timer_module is
  signal TIM_ARE : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal TIM_ARE_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \TIM_CLR[31]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CLR[31]_i_3_n_0\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[0]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[10]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[11]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[12]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[13]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[14]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[15]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[16]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[17]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[18]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[19]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[1]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[20]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[21]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[22]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[23]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[24]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[25]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[26]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[27]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[28]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[29]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[2]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[30]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[31]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[3]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[4]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[5]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[6]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[7]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[8]\ : STD_LOGIC;
  signal \TIM_CLR_reg_n_0_[9]\ : STD_LOGIC;
  signal TIM_CNT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal TIM_CNT0 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal \TIM_CNT0_inferred__0/i__carry__0_n_0\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__0_n_1\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__0_n_2\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__0_n_3\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__0_n_4\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__0_n_5\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__0_n_6\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__0_n_7\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__1_n_0\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__1_n_1\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__1_n_2\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__1_n_3\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__1_n_4\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__1_n_5\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__1_n_6\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__1_n_7\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__2_n_0\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__2_n_1\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__2_n_2\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__2_n_3\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__2_n_4\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__2_n_5\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__2_n_6\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__2_n_7\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__3_n_0\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__3_n_1\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__3_n_2\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__3_n_3\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__3_n_4\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__3_n_5\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__3_n_6\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__3_n_7\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__4_n_0\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__4_n_1\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__4_n_2\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__4_n_3\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__4_n_4\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__4_n_5\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__4_n_6\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__4_n_7\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__5_n_0\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__5_n_1\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__5_n_2\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__5_n_3\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__5_n_4\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__5_n_5\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__5_n_6\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__5_n_7\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__6_n_2\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__6_n_3\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__6_n_5\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__6_n_6\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry__6_n_7\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry_n_0\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry_n_1\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry_n_2\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry_n_3\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry_n_4\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry_n_5\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry_n_6\ : STD_LOGIC;
  signal \TIM_CNT0_inferred__0/i__carry_n_7\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_i_7_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_i_8_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_n_1\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_n_2\ : STD_LOGIC;
  signal \TIM_CNT1_carry__0_n_3\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_i_5_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_i_6_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_i_7_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_i_8_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_n_1\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_n_2\ : STD_LOGIC;
  signal \TIM_CNT1_carry__1_n_3\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_i_5_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_i_6_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_i_7_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_i_8_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_n_0\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_n_1\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_n_2\ : STD_LOGIC;
  signal \TIM_CNT1_carry__2_n_3\ : STD_LOGIC;
  signal TIM_CNT1_carry_i_1_n_0 : STD_LOGIC;
  signal TIM_CNT1_carry_i_2_n_0 : STD_LOGIC;
  signal TIM_CNT1_carry_i_3_n_0 : STD_LOGIC;
  signal TIM_CNT1_carry_i_4_n_0 : STD_LOGIC;
  signal TIM_CNT1_carry_i_5_n_0 : STD_LOGIC;
  signal TIM_CNT1_carry_i_6_n_0 : STD_LOGIC;
  signal TIM_CNT1_carry_i_7_n_0 : STD_LOGIC;
  signal TIM_CNT1_carry_i_8_n_0 : STD_LOGIC;
  signal TIM_CNT1_carry_n_0 : STD_LOGIC;
  signal TIM_CNT1_carry_n_1 : STD_LOGIC;
  signal TIM_CNT1_carry_n_2 : STD_LOGIC;
  signal TIM_CNT1_carry_n_3 : STD_LOGIC;
  signal \TIM_CNT[0]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[10]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[11]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[12]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[13]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[14]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[15]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[16]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[17]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[18]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[19]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[1]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[20]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[21]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[22]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[23]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[24]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[25]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[26]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[27]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[28]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[29]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[2]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[30]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_10_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_11_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_12_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_13_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_14_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_15_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_16_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_17_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_18_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_19_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_20_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_21_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_22_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_23_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_24_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_25_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_26_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_27_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_3_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_4_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_5_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_6_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_7_n_0\ : STD_LOGIC;
  signal \TIM_CNT[31]_i_9_n_0\ : STD_LOGIC;
  signal \TIM_CNT[3]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[4]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[5]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[6]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[7]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[8]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT[9]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_CNT_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT_reg[12]_i_2_n_1\ : STD_LOGIC;
  signal \TIM_CNT_reg[12]_i_2_n_2\ : STD_LOGIC;
  signal \TIM_CNT_reg[12]_i_2_n_3\ : STD_LOGIC;
  signal \TIM_CNT_reg[16]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT_reg[16]_i_2_n_1\ : STD_LOGIC;
  signal \TIM_CNT_reg[16]_i_2_n_2\ : STD_LOGIC;
  signal \TIM_CNT_reg[16]_i_2_n_3\ : STD_LOGIC;
  signal \TIM_CNT_reg[20]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT_reg[20]_i_2_n_1\ : STD_LOGIC;
  signal \TIM_CNT_reg[20]_i_2_n_2\ : STD_LOGIC;
  signal \TIM_CNT_reg[20]_i_2_n_3\ : STD_LOGIC;
  signal \TIM_CNT_reg[24]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT_reg[24]_i_2_n_1\ : STD_LOGIC;
  signal \TIM_CNT_reg[24]_i_2_n_2\ : STD_LOGIC;
  signal \TIM_CNT_reg[24]_i_2_n_3\ : STD_LOGIC;
  signal \TIM_CNT_reg[28]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT_reg[28]_i_2_n_1\ : STD_LOGIC;
  signal \TIM_CNT_reg[28]_i_2_n_2\ : STD_LOGIC;
  signal \TIM_CNT_reg[28]_i_2_n_3\ : STD_LOGIC;
  signal \TIM_CNT_reg[31]_i_8_n_2\ : STD_LOGIC;
  signal \TIM_CNT_reg[31]_i_8_n_3\ : STD_LOGIC;
  signal \TIM_CNT_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT_reg[4]_i_2_n_1\ : STD_LOGIC;
  signal \TIM_CNT_reg[4]_i_2_n_2\ : STD_LOGIC;
  signal \TIM_CNT_reg[4]_i_2_n_3\ : STD_LOGIC;
  signal \TIM_CNT_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_CNT_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \TIM_CNT_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \TIM_CNT_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal TIM_ENA : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \TIM_ENA_reg_n_0_[10]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[11]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[12]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[13]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[14]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[15]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[16]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[17]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[18]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[19]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[1]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[20]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[21]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[22]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[23]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[24]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[25]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[26]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[27]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[28]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[29]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[2]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[30]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[31]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[3]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[4]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[5]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[6]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[7]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[8]\ : STD_LOGIC;
  signal \TIM_ENA_reg_n_0_[9]\ : STD_LOGIC;
  signal \TIM_EVC[0]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[10]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[11]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[12]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[13]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[14]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[15]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[16]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[17]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[18]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[19]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[1]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[20]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[21]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[22]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[23]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[24]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[25]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[26]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[27]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[28]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[29]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[2]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[30]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[31]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[31]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_EVC[31]_i_3_n_0\ : STD_LOGIC;
  signal \TIM_EVC[3]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[4]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[5]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[6]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[7]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[8]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC[9]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[10]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[11]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[12]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[13]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[14]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[15]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[16]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[17]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[18]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[19]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[1]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[20]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[21]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[22]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[23]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[24]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[25]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[26]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[27]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[28]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[29]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[2]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[30]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[31]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[3]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[4]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[5]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[6]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[7]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[8]\ : STD_LOGIC;
  signal \TIM_EVC_reg_n_0_[9]\ : STD_LOGIC;
  signal TIM_EVN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \TIM_EVN0_carry__0_n_0\ : STD_LOGIC;
  signal \TIM_EVN0_carry__0_n_1\ : STD_LOGIC;
  signal \TIM_EVN0_carry__0_n_2\ : STD_LOGIC;
  signal \TIM_EVN0_carry__0_n_3\ : STD_LOGIC;
  signal \TIM_EVN0_carry__0_n_4\ : STD_LOGIC;
  signal \TIM_EVN0_carry__0_n_5\ : STD_LOGIC;
  signal \TIM_EVN0_carry__0_n_6\ : STD_LOGIC;
  signal \TIM_EVN0_carry__0_n_7\ : STD_LOGIC;
  signal \TIM_EVN0_carry__1_n_0\ : STD_LOGIC;
  signal \TIM_EVN0_carry__1_n_1\ : STD_LOGIC;
  signal \TIM_EVN0_carry__1_n_2\ : STD_LOGIC;
  signal \TIM_EVN0_carry__1_n_3\ : STD_LOGIC;
  signal \TIM_EVN0_carry__1_n_4\ : STD_LOGIC;
  signal \TIM_EVN0_carry__1_n_5\ : STD_LOGIC;
  signal \TIM_EVN0_carry__1_n_6\ : STD_LOGIC;
  signal \TIM_EVN0_carry__1_n_7\ : STD_LOGIC;
  signal \TIM_EVN0_carry__2_n_0\ : STD_LOGIC;
  signal \TIM_EVN0_carry__2_n_1\ : STD_LOGIC;
  signal \TIM_EVN0_carry__2_n_2\ : STD_LOGIC;
  signal \TIM_EVN0_carry__2_n_3\ : STD_LOGIC;
  signal \TIM_EVN0_carry__2_n_4\ : STD_LOGIC;
  signal \TIM_EVN0_carry__2_n_5\ : STD_LOGIC;
  signal \TIM_EVN0_carry__2_n_6\ : STD_LOGIC;
  signal \TIM_EVN0_carry__2_n_7\ : STD_LOGIC;
  signal \TIM_EVN0_carry__3_n_0\ : STD_LOGIC;
  signal \TIM_EVN0_carry__3_n_1\ : STD_LOGIC;
  signal \TIM_EVN0_carry__3_n_2\ : STD_LOGIC;
  signal \TIM_EVN0_carry__3_n_3\ : STD_LOGIC;
  signal \TIM_EVN0_carry__3_n_4\ : STD_LOGIC;
  signal \TIM_EVN0_carry__3_n_5\ : STD_LOGIC;
  signal \TIM_EVN0_carry__3_n_6\ : STD_LOGIC;
  signal \TIM_EVN0_carry__3_n_7\ : STD_LOGIC;
  signal \TIM_EVN0_carry__4_n_0\ : STD_LOGIC;
  signal \TIM_EVN0_carry__4_n_1\ : STD_LOGIC;
  signal \TIM_EVN0_carry__4_n_2\ : STD_LOGIC;
  signal \TIM_EVN0_carry__4_n_3\ : STD_LOGIC;
  signal \TIM_EVN0_carry__4_n_4\ : STD_LOGIC;
  signal \TIM_EVN0_carry__4_n_5\ : STD_LOGIC;
  signal \TIM_EVN0_carry__4_n_6\ : STD_LOGIC;
  signal \TIM_EVN0_carry__4_n_7\ : STD_LOGIC;
  signal \TIM_EVN0_carry__5_n_0\ : STD_LOGIC;
  signal \TIM_EVN0_carry__5_n_1\ : STD_LOGIC;
  signal \TIM_EVN0_carry__5_n_2\ : STD_LOGIC;
  signal \TIM_EVN0_carry__5_n_3\ : STD_LOGIC;
  signal \TIM_EVN0_carry__5_n_4\ : STD_LOGIC;
  signal \TIM_EVN0_carry__5_n_5\ : STD_LOGIC;
  signal \TIM_EVN0_carry__5_n_6\ : STD_LOGIC;
  signal \TIM_EVN0_carry__5_n_7\ : STD_LOGIC;
  signal \TIM_EVN0_carry__6_n_2\ : STD_LOGIC;
  signal \TIM_EVN0_carry__6_n_3\ : STD_LOGIC;
  signal \TIM_EVN0_carry__6_n_5\ : STD_LOGIC;
  signal \TIM_EVN0_carry__6_n_6\ : STD_LOGIC;
  signal \TIM_EVN0_carry__6_n_7\ : STD_LOGIC;
  signal TIM_EVN0_carry_n_0 : STD_LOGIC;
  signal TIM_EVN0_carry_n_1 : STD_LOGIC;
  signal TIM_EVN0_carry_n_2 : STD_LOGIC;
  signal TIM_EVN0_carry_n_3 : STD_LOGIC;
  signal TIM_EVN0_carry_n_4 : STD_LOGIC;
  signal TIM_EVN0_carry_n_5 : STD_LOGIC;
  signal TIM_EVN0_carry_n_6 : STD_LOGIC;
  signal TIM_EVN0_carry_n_7 : STD_LOGIC;
  signal \TIM_EVN[0]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[10]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[11]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[12]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[13]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[14]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[15]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[16]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[17]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[18]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[19]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[1]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[20]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[21]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[22]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[23]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[24]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[25]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[26]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[27]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[28]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[29]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[2]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[30]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_10_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_11_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_12_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_13_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_14_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_15_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_16_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_17_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_18_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_19_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_20_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_21_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_22_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_23_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_3_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_4_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_5_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_6_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_7_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_8_n_0\ : STD_LOGIC;
  signal \TIM_EVN[31]_i_9_n_0\ : STD_LOGIC;
  signal \TIM_EVN[3]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[4]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[5]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[6]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[7]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[8]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_EVN[9]_i_1_n_0\ : STD_LOGIC;
  signal TIM_MOD : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \TIM_MOD_reg_n_0_[0]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[10]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[11]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[12]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[13]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[14]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[15]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[16]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[17]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[18]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[19]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[1]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[20]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[21]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[22]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[23]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[24]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[25]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[26]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[27]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[28]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[29]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[2]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[30]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[31]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[3]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[4]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[5]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[6]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[7]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[8]\ : STD_LOGIC;
  signal \TIM_MOD_reg_n_0_[9]\ : STD_LOGIC;
  signal TIM_PRE : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \TIM_PRE0_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__0_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__0_n_1\ : STD_LOGIC;
  signal \TIM_PRE0_carry__0_n_2\ : STD_LOGIC;
  signal \TIM_PRE0_carry__0_n_3\ : STD_LOGIC;
  signal \TIM_PRE0_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__1_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__1_n_1\ : STD_LOGIC;
  signal \TIM_PRE0_carry__1_n_2\ : STD_LOGIC;
  signal \TIM_PRE0_carry__1_n_3\ : STD_LOGIC;
  signal \TIM_PRE0_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__2_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__2_n_1\ : STD_LOGIC;
  signal \TIM_PRE0_carry__2_n_2\ : STD_LOGIC;
  signal \TIM_PRE0_carry__2_n_3\ : STD_LOGIC;
  signal \TIM_PRE0_carry__3_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__3_i_2_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__3_i_3_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__3_i_4_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__3_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__3_n_1\ : STD_LOGIC;
  signal \TIM_PRE0_carry__3_n_2\ : STD_LOGIC;
  signal \TIM_PRE0_carry__3_n_3\ : STD_LOGIC;
  signal \TIM_PRE0_carry__4_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__4_i_2_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__4_i_3_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__4_i_4_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__4_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__4_n_1\ : STD_LOGIC;
  signal \TIM_PRE0_carry__4_n_2\ : STD_LOGIC;
  signal \TIM_PRE0_carry__4_n_3\ : STD_LOGIC;
  signal \TIM_PRE0_carry__5_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__5_i_2_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__5_i_3_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__5_i_4_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__5_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__5_n_1\ : STD_LOGIC;
  signal \TIM_PRE0_carry__5_n_2\ : STD_LOGIC;
  signal \TIM_PRE0_carry__5_n_3\ : STD_LOGIC;
  signal \TIM_PRE0_carry__6_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__6_i_2_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__6_i_3_n_0\ : STD_LOGIC;
  signal \TIM_PRE0_carry__6_n_2\ : STD_LOGIC;
  signal \TIM_PRE0_carry__6_n_3\ : STD_LOGIC;
  signal TIM_PRE0_carry_i_1_n_0 : STD_LOGIC;
  signal TIM_PRE0_carry_i_2_n_0 : STD_LOGIC;
  signal TIM_PRE0_carry_i_3_n_0 : STD_LOGIC;
  signal TIM_PRE0_carry_i_4_n_0 : STD_LOGIC;
  signal TIM_PRE0_carry_n_0 : STD_LOGIC;
  signal TIM_PRE0_carry_n_1 : STD_LOGIC;
  signal TIM_PRE0_carry_n_2 : STD_LOGIC;
  signal TIM_PRE0_carry_n_3 : STD_LOGIC;
  signal \TIM_PRE[0]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[10]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[11]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[12]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[13]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[14]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[15]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[16]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[17]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[18]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[19]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[1]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[20]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[21]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[22]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[23]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[24]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[25]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[26]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[27]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[28]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[29]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[2]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[30]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_10_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_2_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_3_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_4_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_5_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_6_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_7_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_8_n_0\ : STD_LOGIC;
  signal \TIM_PRE[31]_i_9_n_0\ : STD_LOGIC;
  signal \TIM_PRE[3]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[4]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[5]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[6]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[7]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[8]_i_1_n_0\ : STD_LOGIC;
  signal \TIM_PRE[9]_i_1_n_0\ : STD_LOGIC;
  signal TIM_PRE_m : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal TIM_PRE_m1 : STD_LOGIC;
  signal TIM_PRE_m_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^arready\ : STD_LOGIC;
  signal arready_i_1_n_0 : STD_LOGIC;
  signal \^bvalid\ : STD_LOGIC;
  signal bvalid_i_1_n_0 : STD_LOGIC;
  signal data1 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal \i__carry__0_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_3_n_0\ : STD_LOGIC;
  signal \i__carry_i_1_n_0\ : STD_LOGIC;
  signal \i__carry_i_2_n_0\ : STD_LOGIC;
  signal \i__carry_i_3_n_0\ : STD_LOGIC;
  signal \i__carry_i_4_n_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal p_1_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal p_2_in : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal \rdata[0]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[0]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[10]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[10]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[11]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[11]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[12]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[12]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[13]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[13]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[14]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[14]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[15]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[15]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[16]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[16]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[17]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[17]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[18]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[18]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[19]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[19]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[1]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[1]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[20]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[20]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[21]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[21]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[22]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[22]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[23]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[23]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[24]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[24]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[25]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[25]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[26]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[26]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[27]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[27]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[28]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[28]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[29]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[29]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[2]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[2]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[30]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[30]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_5_n_0\ : STD_LOGIC;
  signal \rdata[3]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[3]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[4]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[4]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[5]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[5]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[6]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[6]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[7]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[7]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[8]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[8]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[9]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[9]_i_3_n_0\ : STD_LOGIC;
  signal \^rvalid\ : STD_LOGIC;
  signal rvalid_i_1_n_0 : STD_LOGIC;
  signal \^wready\ : STD_LOGIC;
  signal wready_i_1_n_0 : STD_LOGIC;
  signal wready_i_2_n_0 : STD_LOGIC;
  signal \NLW_TIM_CNT0_inferred__0/i__carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_TIM_CNT0_inferred__0/i__carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_TIM_CNT1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_TIM_CNT1_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_TIM_CNT1_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_TIM_CNT1_carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_TIM_CNT_reg[31]_i_8_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_TIM_CNT_reg[31]_i_8_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_TIM_EVN0_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_TIM_EVN0_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_TIM_PRE0_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_TIM_PRE0_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \TIM_CLR[10]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \TIM_CLR[11]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \TIM_CLR[12]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \TIM_CLR[13]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \TIM_CLR[14]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \TIM_CLR[15]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \TIM_CLR[16]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \TIM_CLR[17]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \TIM_CLR[18]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \TIM_CLR[19]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \TIM_CLR[1]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \TIM_CLR[20]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \TIM_CLR[21]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \TIM_CLR[22]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \TIM_CLR[23]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \TIM_CLR[24]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \TIM_CLR[25]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \TIM_CLR[26]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \TIM_CLR[27]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \TIM_CLR[28]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \TIM_CLR[29]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \TIM_CLR[2]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \TIM_CLR[30]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \TIM_CLR[31]_i_2\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \TIM_CLR[31]_i_4\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \TIM_CLR[3]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \TIM_CLR[4]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \TIM_CLR[5]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \TIM_CLR[6]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \TIM_CLR[7]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \TIM_CLR[8]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \TIM_CLR[9]_i_1\ : label is "soft_lutpair32";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \TIM_CNT0_inferred__0/i__carry\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT0_inferred__0/i__carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT0_inferred__0/i__carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT0_inferred__0/i__carry__2\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT0_inferred__0/i__carry__3\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT0_inferred__0/i__carry__4\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT0_inferred__0/i__carry__5\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT0_inferred__0/i__carry__6\ : label is 35;
  attribute COMPARATOR_THRESHOLD : integer;
  attribute COMPARATOR_THRESHOLD of TIM_CNT1_carry : label is 11;
  attribute COMPARATOR_THRESHOLD of \TIM_CNT1_carry__0\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \TIM_CNT1_carry__1\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \TIM_CNT1_carry__2\ : label is 11;
  attribute SOFT_HLUTNM of \TIM_CNT[31]_i_13\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \TIM_CNT[31]_i_16\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \TIM_CNT[31]_i_22\ : label is "soft_lutpair1";
  attribute ADDER_THRESHOLD of \TIM_CNT_reg[12]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT_reg[16]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT_reg[20]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT_reg[24]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT_reg[28]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT_reg[31]_i_8\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT_reg[4]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_CNT_reg[8]_i_2\ : label is 35;
  attribute SOFT_HLUTNM of \TIM_EVC[0]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \TIM_EVC[10]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \TIM_EVC[11]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \TIM_EVC[12]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \TIM_EVC[13]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \TIM_EVC[14]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \TIM_EVC[15]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \TIM_EVC[16]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \TIM_EVC[17]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \TIM_EVC[18]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \TIM_EVC[19]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \TIM_EVC[1]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \TIM_EVC[20]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \TIM_EVC[21]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \TIM_EVC[22]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \TIM_EVC[23]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \TIM_EVC[24]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \TIM_EVC[25]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \TIM_EVC[26]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \TIM_EVC[27]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \TIM_EVC[28]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \TIM_EVC[29]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \TIM_EVC[2]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \TIM_EVC[30]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \TIM_EVC[31]_i_2\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \TIM_EVC[31]_i_3\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \TIM_EVC[3]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \TIM_EVC[4]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \TIM_EVC[5]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \TIM_EVC[6]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \TIM_EVC[7]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \TIM_EVC[8]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \TIM_EVC[9]_i_1\ : label is "soft_lutpair7";
  attribute ADDER_THRESHOLD of TIM_EVN0_carry : label is 35;
  attribute ADDER_THRESHOLD of \TIM_EVN0_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_EVN0_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_EVN0_carry__2\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_EVN0_carry__3\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_EVN0_carry__4\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_EVN0_carry__5\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_EVN0_carry__6\ : label is 35;
  attribute SOFT_HLUTNM of \TIM_EVN[31]_i_17\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \TIM_EVN[31]_i_19\ : label is "soft_lutpair20";
  attribute ADDER_THRESHOLD of TIM_PRE0_carry : label is 35;
  attribute ADDER_THRESHOLD of \TIM_PRE0_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_PRE0_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_PRE0_carry__2\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_PRE0_carry__3\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_PRE0_carry__4\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_PRE0_carry__5\ : label is 35;
  attribute ADDER_THRESHOLD of \TIM_PRE0_carry__6\ : label is 35;
  attribute SOFT_HLUTNM of \TIM_PRE[31]_i_10\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \TIM_PRE[31]_i_8\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \TIM_PRE[31]_i_9\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of wready_i_1 : label is "soft_lutpair2";
begin
  arready <= \^arready\;
  bvalid <= \^bvalid\;
  rvalid <= \^rvalid\;
  wready <= \^wready\;
\TIM_ARE[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0200"
    )
        port map (
      I0 => \TIM_CLR[31]_i_3_n_0\,
      I1 => awaddr(4),
      I2 => awaddr(3),
      I3 => awaddr(2),
      O => TIM_ARE_1(0)
    );
\TIM_ARE_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(0),
      Q => TIM_ARE(0)
    );
\TIM_ARE_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(10),
      Q => TIM_ARE(10)
    );
\TIM_ARE_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(11),
      Q => TIM_ARE(11)
    );
\TIM_ARE_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(12),
      Q => TIM_ARE(12)
    );
\TIM_ARE_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(13),
      Q => TIM_ARE(13)
    );
\TIM_ARE_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(14),
      Q => TIM_ARE(14)
    );
\TIM_ARE_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(15),
      Q => TIM_ARE(15)
    );
\TIM_ARE_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(16),
      Q => TIM_ARE(16)
    );
\TIM_ARE_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(17),
      Q => TIM_ARE(17)
    );
\TIM_ARE_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(18),
      Q => TIM_ARE(18)
    );
\TIM_ARE_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(19),
      Q => TIM_ARE(19)
    );
\TIM_ARE_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(1),
      Q => TIM_ARE(1)
    );
\TIM_ARE_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(20),
      Q => TIM_ARE(20)
    );
\TIM_ARE_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(21),
      Q => TIM_ARE(21)
    );
\TIM_ARE_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(22),
      Q => TIM_ARE(22)
    );
\TIM_ARE_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(23),
      Q => TIM_ARE(23)
    );
\TIM_ARE_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(24),
      Q => TIM_ARE(24)
    );
\TIM_ARE_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(25),
      Q => TIM_ARE(25)
    );
\TIM_ARE_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(26),
      Q => TIM_ARE(26)
    );
\TIM_ARE_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(27),
      Q => TIM_ARE(27)
    );
\TIM_ARE_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(28),
      Q => TIM_ARE(28)
    );
\TIM_ARE_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(29),
      Q => TIM_ARE(29)
    );
\TIM_ARE_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(2),
      Q => TIM_ARE(2)
    );
\TIM_ARE_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(30),
      Q => TIM_ARE(30)
    );
\TIM_ARE_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(31),
      Q => TIM_ARE(31)
    );
\TIM_ARE_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(3),
      Q => TIM_ARE(3)
    );
\TIM_ARE_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(4),
      Q => TIM_ARE(4)
    );
\TIM_ARE_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(5),
      Q => TIM_ARE(5)
    );
\TIM_ARE_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(6),
      Q => TIM_ARE(6)
    );
\TIM_ARE_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(7),
      Q => TIM_ARE(7)
    );
\TIM_ARE_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(8),
      Q => TIM_ARE(8)
    );
\TIM_ARE_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ARE_1(0),
      CLR => wready_i_2_n_0,
      D => wdata(9),
      Q => TIM_ARE(9)
    );
\TIM_CLR[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(0),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(0)
    );
\TIM_CLR[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(10),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(10)
    );
\TIM_CLR[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(11),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(11)
    );
\TIM_CLR[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(12),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(12)
    );
\TIM_CLR[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(13),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(13)
    );
\TIM_CLR[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(14),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(14)
    );
\TIM_CLR[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(15),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(15)
    );
\TIM_CLR[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(16),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(16)
    );
\TIM_CLR[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(17),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(17)
    );
\TIM_CLR[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(18),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(18)
    );
\TIM_CLR[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(19),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(19)
    );
\TIM_CLR[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(1),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(1)
    );
\TIM_CLR[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(20),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(20)
    );
\TIM_CLR[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(21),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(21)
    );
\TIM_CLR[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(22),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(22)
    );
\TIM_CLR[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(23),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(23)
    );
\TIM_CLR[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(24),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(24)
    );
\TIM_CLR[25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(25),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(25)
    );
\TIM_CLR[26]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(26),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(26)
    );
\TIM_CLR[27]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(27),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(27)
    );
\TIM_CLR[28]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(28),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(28)
    );
\TIM_CLR[29]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(29),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(29)
    );
\TIM_CLR[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(2),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(2)
    );
\TIM_CLR[30]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(30),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(30)
    );
\TIM_CLR[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0020"
    )
        port map (
      I0 => \TIM_CLR[31]_i_3_n_0\,
      I1 => awaddr(4),
      I2 => awaddr(3),
      I3 => awaddr(2),
      I4 => \TIM_CLR_reg_n_0_[0]\,
      O => \TIM_CLR[31]_i_1_n_0\
    );
\TIM_CLR[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(31),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(31)
    );
\TIM_CLR[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => awaddr(0),
      I1 => TIM_PRE_m1,
      I2 => awaddr(1),
      I3 => awaddr(5),
      I4 => awaddr(6),
      I5 => awaddr(7),
      O => \TIM_CLR[31]_i_3_n_0\
    );
\TIM_CLR[31]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => awvalid,
      I1 => wvalid,
      O => TIM_PRE_m1
    );
\TIM_CLR[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(3),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(3)
    );
\TIM_CLR[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(4),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(4)
    );
\TIM_CLR[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(5),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(5)
    );
\TIM_CLR[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(6),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(6)
    );
\TIM_CLR[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(7),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(7)
    );
\TIM_CLR[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(8),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(8)
    );
\TIM_CLR[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => wdata(9),
      I1 => \TIM_CLR_reg_n_0_[0]\,
      O => p_1_in(9)
    );
\TIM_CLR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(0),
      Q => \TIM_CLR_reg_n_0_[0]\
    );
\TIM_CLR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(10),
      Q => \TIM_CLR_reg_n_0_[10]\
    );
\TIM_CLR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(11),
      Q => \TIM_CLR_reg_n_0_[11]\
    );
\TIM_CLR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(12),
      Q => \TIM_CLR_reg_n_0_[12]\
    );
\TIM_CLR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(13),
      Q => \TIM_CLR_reg_n_0_[13]\
    );
\TIM_CLR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(14),
      Q => \TIM_CLR_reg_n_0_[14]\
    );
\TIM_CLR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(15),
      Q => \TIM_CLR_reg_n_0_[15]\
    );
\TIM_CLR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(16),
      Q => \TIM_CLR_reg_n_0_[16]\
    );
\TIM_CLR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(17),
      Q => \TIM_CLR_reg_n_0_[17]\
    );
\TIM_CLR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(18),
      Q => \TIM_CLR_reg_n_0_[18]\
    );
\TIM_CLR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(19),
      Q => \TIM_CLR_reg_n_0_[19]\
    );
\TIM_CLR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(1),
      Q => \TIM_CLR_reg_n_0_[1]\
    );
\TIM_CLR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(20),
      Q => \TIM_CLR_reg_n_0_[20]\
    );
\TIM_CLR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(21),
      Q => \TIM_CLR_reg_n_0_[21]\
    );
\TIM_CLR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(22),
      Q => \TIM_CLR_reg_n_0_[22]\
    );
\TIM_CLR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(23),
      Q => \TIM_CLR_reg_n_0_[23]\
    );
\TIM_CLR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(24),
      Q => \TIM_CLR_reg_n_0_[24]\
    );
\TIM_CLR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(25),
      Q => \TIM_CLR_reg_n_0_[25]\
    );
\TIM_CLR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(26),
      Q => \TIM_CLR_reg_n_0_[26]\
    );
\TIM_CLR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(27),
      Q => \TIM_CLR_reg_n_0_[27]\
    );
\TIM_CLR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(28),
      Q => \TIM_CLR_reg_n_0_[28]\
    );
\TIM_CLR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(29),
      Q => \TIM_CLR_reg_n_0_[29]\
    );
\TIM_CLR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(2),
      Q => \TIM_CLR_reg_n_0_[2]\
    );
\TIM_CLR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(30),
      Q => \TIM_CLR_reg_n_0_[30]\
    );
\TIM_CLR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(31),
      Q => \TIM_CLR_reg_n_0_[31]\
    );
\TIM_CLR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(3),
      Q => \TIM_CLR_reg_n_0_[3]\
    );
\TIM_CLR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(4),
      Q => \TIM_CLR_reg_n_0_[4]\
    );
\TIM_CLR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(5),
      Q => \TIM_CLR_reg_n_0_[5]\
    );
\TIM_CLR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(6),
      Q => \TIM_CLR_reg_n_0_[6]\
    );
\TIM_CLR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(7),
      Q => \TIM_CLR_reg_n_0_[7]\
    );
\TIM_CLR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(8),
      Q => \TIM_CLR_reg_n_0_[8]\
    );
\TIM_CLR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CLR[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => p_1_in(9),
      Q => \TIM_CLR_reg_n_0_[9]\
    );
\TIM_CNT0_inferred__0/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \TIM_CNT0_inferred__0/i__carry_n_0\,
      CO(2) => \TIM_CNT0_inferred__0/i__carry_n_1\,
      CO(1) => \TIM_CNT0_inferred__0/i__carry_n_2\,
      CO(0) => \TIM_CNT0_inferred__0/i__carry_n_3\,
      CYINIT => TIM_CNT(0),
      DI(3 downto 0) => TIM_CNT(4 downto 1),
      O(3) => \TIM_CNT0_inferred__0/i__carry_n_4\,
      O(2) => \TIM_CNT0_inferred__0/i__carry_n_5\,
      O(1) => \TIM_CNT0_inferred__0/i__carry_n_6\,
      O(0) => \TIM_CNT0_inferred__0/i__carry_n_7\,
      S(3) => \i__carry_i_1_n_0\,
      S(2) => \i__carry_i_2_n_0\,
      S(1) => \i__carry_i_3_n_0\,
      S(0) => \i__carry_i_4_n_0\
    );
\TIM_CNT0_inferred__0/i__carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT0_inferred__0/i__carry_n_0\,
      CO(3) => \TIM_CNT0_inferred__0/i__carry__0_n_0\,
      CO(2) => \TIM_CNT0_inferred__0/i__carry__0_n_1\,
      CO(1) => \TIM_CNT0_inferred__0/i__carry__0_n_2\,
      CO(0) => \TIM_CNT0_inferred__0/i__carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_CNT(8 downto 5),
      O(3) => \TIM_CNT0_inferred__0/i__carry__0_n_4\,
      O(2) => \TIM_CNT0_inferred__0/i__carry__0_n_5\,
      O(1) => \TIM_CNT0_inferred__0/i__carry__0_n_6\,
      O(0) => \TIM_CNT0_inferred__0/i__carry__0_n_7\,
      S(3) => \i__carry__0_i_1_n_0\,
      S(2) => \i__carry__0_i_2_n_0\,
      S(1) => \i__carry__0_i_3_n_0\,
      S(0) => \i__carry__0_i_4_n_0\
    );
\TIM_CNT0_inferred__0/i__carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT0_inferred__0/i__carry__0_n_0\,
      CO(3) => \TIM_CNT0_inferred__0/i__carry__1_n_0\,
      CO(2) => \TIM_CNT0_inferred__0/i__carry__1_n_1\,
      CO(1) => \TIM_CNT0_inferred__0/i__carry__1_n_2\,
      CO(0) => \TIM_CNT0_inferred__0/i__carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_CNT(12 downto 9),
      O(3) => \TIM_CNT0_inferred__0/i__carry__1_n_4\,
      O(2) => \TIM_CNT0_inferred__0/i__carry__1_n_5\,
      O(1) => \TIM_CNT0_inferred__0/i__carry__1_n_6\,
      O(0) => \TIM_CNT0_inferred__0/i__carry__1_n_7\,
      S(3) => \i__carry__1_i_1_n_0\,
      S(2) => \i__carry__1_i_2_n_0\,
      S(1) => \i__carry__1_i_3_n_0\,
      S(0) => \i__carry__1_i_4_n_0\
    );
\TIM_CNT0_inferred__0/i__carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT0_inferred__0/i__carry__1_n_0\,
      CO(3) => \TIM_CNT0_inferred__0/i__carry__2_n_0\,
      CO(2) => \TIM_CNT0_inferred__0/i__carry__2_n_1\,
      CO(1) => \TIM_CNT0_inferred__0/i__carry__2_n_2\,
      CO(0) => \TIM_CNT0_inferred__0/i__carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_CNT(16 downto 13),
      O(3) => \TIM_CNT0_inferred__0/i__carry__2_n_4\,
      O(2) => \TIM_CNT0_inferred__0/i__carry__2_n_5\,
      O(1) => \TIM_CNT0_inferred__0/i__carry__2_n_6\,
      O(0) => \TIM_CNT0_inferred__0/i__carry__2_n_7\,
      S(3) => \i__carry__2_i_1_n_0\,
      S(2) => \i__carry__2_i_2_n_0\,
      S(1) => \i__carry__2_i_3_n_0\,
      S(0) => \i__carry__2_i_4_n_0\
    );
\TIM_CNT0_inferred__0/i__carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT0_inferred__0/i__carry__2_n_0\,
      CO(3) => \TIM_CNT0_inferred__0/i__carry__3_n_0\,
      CO(2) => \TIM_CNT0_inferred__0/i__carry__3_n_1\,
      CO(1) => \TIM_CNT0_inferred__0/i__carry__3_n_2\,
      CO(0) => \TIM_CNT0_inferred__0/i__carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_CNT(20 downto 17),
      O(3) => \TIM_CNT0_inferred__0/i__carry__3_n_4\,
      O(2) => \TIM_CNT0_inferred__0/i__carry__3_n_5\,
      O(1) => \TIM_CNT0_inferred__0/i__carry__3_n_6\,
      O(0) => \TIM_CNT0_inferred__0/i__carry__3_n_7\,
      S(3) => \i__carry__3_i_1_n_0\,
      S(2) => \i__carry__3_i_2_n_0\,
      S(1) => \i__carry__3_i_3_n_0\,
      S(0) => \i__carry__3_i_4_n_0\
    );
\TIM_CNT0_inferred__0/i__carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT0_inferred__0/i__carry__3_n_0\,
      CO(3) => \TIM_CNT0_inferred__0/i__carry__4_n_0\,
      CO(2) => \TIM_CNT0_inferred__0/i__carry__4_n_1\,
      CO(1) => \TIM_CNT0_inferred__0/i__carry__4_n_2\,
      CO(0) => \TIM_CNT0_inferred__0/i__carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_CNT(24 downto 21),
      O(3) => \TIM_CNT0_inferred__0/i__carry__4_n_4\,
      O(2) => \TIM_CNT0_inferred__0/i__carry__4_n_5\,
      O(1) => \TIM_CNT0_inferred__0/i__carry__4_n_6\,
      O(0) => \TIM_CNT0_inferred__0/i__carry__4_n_7\,
      S(3) => \i__carry__4_i_1_n_0\,
      S(2) => \i__carry__4_i_2_n_0\,
      S(1) => \i__carry__4_i_3_n_0\,
      S(0) => \i__carry__4_i_4_n_0\
    );
\TIM_CNT0_inferred__0/i__carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT0_inferred__0/i__carry__4_n_0\,
      CO(3) => \TIM_CNT0_inferred__0/i__carry__5_n_0\,
      CO(2) => \TIM_CNT0_inferred__0/i__carry__5_n_1\,
      CO(1) => \TIM_CNT0_inferred__0/i__carry__5_n_2\,
      CO(0) => \TIM_CNT0_inferred__0/i__carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_CNT(28 downto 25),
      O(3) => \TIM_CNT0_inferred__0/i__carry__5_n_4\,
      O(2) => \TIM_CNT0_inferred__0/i__carry__5_n_5\,
      O(1) => \TIM_CNT0_inferred__0/i__carry__5_n_6\,
      O(0) => \TIM_CNT0_inferred__0/i__carry__5_n_7\,
      S(3) => \i__carry__5_i_1_n_0\,
      S(2) => \i__carry__5_i_2_n_0\,
      S(1) => \i__carry__5_i_3_n_0\,
      S(0) => \i__carry__5_i_4_n_0\
    );
\TIM_CNT0_inferred__0/i__carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT0_inferred__0/i__carry__5_n_0\,
      CO(3 downto 2) => \NLW_TIM_CNT0_inferred__0/i__carry__6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \TIM_CNT0_inferred__0/i__carry__6_n_2\,
      CO(0) => \TIM_CNT0_inferred__0/i__carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1 downto 0) => TIM_CNT(30 downto 29),
      O(3) => \NLW_TIM_CNT0_inferred__0/i__carry__6_O_UNCONNECTED\(3),
      O(2) => \TIM_CNT0_inferred__0/i__carry__6_n_5\,
      O(1) => \TIM_CNT0_inferred__0/i__carry__6_n_6\,
      O(0) => \TIM_CNT0_inferred__0/i__carry__6_n_7\,
      S(3) => '0',
      S(2) => \i__carry__6_i_1_n_0\,
      S(1) => \i__carry__6_i_2_n_0\,
      S(0) => \i__carry__6_i_3_n_0\
    );
TIM_CNT1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => TIM_CNT1_carry_n_0,
      CO(2) => TIM_CNT1_carry_n_1,
      CO(1) => TIM_CNT1_carry_n_2,
      CO(0) => TIM_CNT1_carry_n_3,
      CYINIT => '1',
      DI(3) => TIM_CNT1_carry_i_1_n_0,
      DI(2) => TIM_CNT1_carry_i_2_n_0,
      DI(1) => TIM_CNT1_carry_i_3_n_0,
      DI(0) => TIM_CNT1_carry_i_4_n_0,
      O(3 downto 0) => NLW_TIM_CNT1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => TIM_CNT1_carry_i_5_n_0,
      S(2) => TIM_CNT1_carry_i_6_n_0,
      S(1) => TIM_CNT1_carry_i_7_n_0,
      S(0) => TIM_CNT1_carry_i_8_n_0
    );
\TIM_CNT1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => TIM_CNT1_carry_n_0,
      CO(3) => \TIM_CNT1_carry__0_n_0\,
      CO(2) => \TIM_CNT1_carry__0_n_1\,
      CO(1) => \TIM_CNT1_carry__0_n_2\,
      CO(0) => \TIM_CNT1_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => \TIM_CNT1_carry__0_i_1_n_0\,
      DI(2) => \TIM_CNT1_carry__0_i_2_n_0\,
      DI(1) => \TIM_CNT1_carry__0_i_3_n_0\,
      DI(0) => \TIM_CNT1_carry__0_i_4_n_0\,
      O(3 downto 0) => \NLW_TIM_CNT1_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \TIM_CNT1_carry__0_i_5_n_0\,
      S(2) => \TIM_CNT1_carry__0_i_6_n_0\,
      S(1) => \TIM_CNT1_carry__0_i_7_n_0\,
      S(0) => \TIM_CNT1_carry__0_i_8_n_0\
    );
\TIM_CNT1_carry__0_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(14),
      I1 => TIM_ARE(14),
      I2 => TIM_ARE(15),
      I3 => TIM_CNT(15),
      O => \TIM_CNT1_carry__0_i_1_n_0\
    );
\TIM_CNT1_carry__0_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(12),
      I1 => TIM_ARE(12),
      I2 => TIM_ARE(13),
      I3 => TIM_CNT(13),
      O => \TIM_CNT1_carry__0_i_2_n_0\
    );
\TIM_CNT1_carry__0_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(10),
      I1 => TIM_ARE(10),
      I2 => TIM_ARE(11),
      I3 => TIM_CNT(11),
      O => \TIM_CNT1_carry__0_i_3_n_0\
    );
\TIM_CNT1_carry__0_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(8),
      I1 => TIM_ARE(8),
      I2 => TIM_ARE(9),
      I3 => TIM_CNT(9),
      O => \TIM_CNT1_carry__0_i_4_n_0\
    );
\TIM_CNT1_carry__0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(15),
      I1 => TIM_CNT(15),
      I2 => TIM_ARE(14),
      I3 => TIM_CNT(14),
      O => \TIM_CNT1_carry__0_i_5_n_0\
    );
\TIM_CNT1_carry__0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(13),
      I1 => TIM_CNT(13),
      I2 => TIM_ARE(12),
      I3 => TIM_CNT(12),
      O => \TIM_CNT1_carry__0_i_6_n_0\
    );
\TIM_CNT1_carry__0_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(11),
      I1 => TIM_CNT(11),
      I2 => TIM_ARE(10),
      I3 => TIM_CNT(10),
      O => \TIM_CNT1_carry__0_i_7_n_0\
    );
\TIM_CNT1_carry__0_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(9),
      I1 => TIM_CNT(9),
      I2 => TIM_ARE(8),
      I3 => TIM_CNT(8),
      O => \TIM_CNT1_carry__0_i_8_n_0\
    );
\TIM_CNT1_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT1_carry__0_n_0\,
      CO(3) => \TIM_CNT1_carry__1_n_0\,
      CO(2) => \TIM_CNT1_carry__1_n_1\,
      CO(1) => \TIM_CNT1_carry__1_n_2\,
      CO(0) => \TIM_CNT1_carry__1_n_3\,
      CYINIT => '0',
      DI(3) => \TIM_CNT1_carry__1_i_1_n_0\,
      DI(2) => \TIM_CNT1_carry__1_i_2_n_0\,
      DI(1) => \TIM_CNT1_carry__1_i_3_n_0\,
      DI(0) => \TIM_CNT1_carry__1_i_4_n_0\,
      O(3 downto 0) => \NLW_TIM_CNT1_carry__1_O_UNCONNECTED\(3 downto 0),
      S(3) => \TIM_CNT1_carry__1_i_5_n_0\,
      S(2) => \TIM_CNT1_carry__1_i_6_n_0\,
      S(1) => \TIM_CNT1_carry__1_i_7_n_0\,
      S(0) => \TIM_CNT1_carry__1_i_8_n_0\
    );
\TIM_CNT1_carry__1_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(22),
      I1 => TIM_ARE(22),
      I2 => TIM_ARE(23),
      I3 => TIM_CNT(23),
      O => \TIM_CNT1_carry__1_i_1_n_0\
    );
\TIM_CNT1_carry__1_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(20),
      I1 => TIM_ARE(20),
      I2 => TIM_ARE(21),
      I3 => TIM_CNT(21),
      O => \TIM_CNT1_carry__1_i_2_n_0\
    );
\TIM_CNT1_carry__1_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(18),
      I1 => TIM_ARE(18),
      I2 => TIM_ARE(19),
      I3 => TIM_CNT(19),
      O => \TIM_CNT1_carry__1_i_3_n_0\
    );
\TIM_CNT1_carry__1_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(16),
      I1 => TIM_ARE(16),
      I2 => TIM_ARE(17),
      I3 => TIM_CNT(17),
      O => \TIM_CNT1_carry__1_i_4_n_0\
    );
\TIM_CNT1_carry__1_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(23),
      I1 => TIM_CNT(23),
      I2 => TIM_ARE(22),
      I3 => TIM_CNT(22),
      O => \TIM_CNT1_carry__1_i_5_n_0\
    );
\TIM_CNT1_carry__1_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(21),
      I1 => TIM_CNT(21),
      I2 => TIM_ARE(20),
      I3 => TIM_CNT(20),
      O => \TIM_CNT1_carry__1_i_6_n_0\
    );
\TIM_CNT1_carry__1_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(19),
      I1 => TIM_CNT(19),
      I2 => TIM_ARE(18),
      I3 => TIM_CNT(18),
      O => \TIM_CNT1_carry__1_i_7_n_0\
    );
\TIM_CNT1_carry__1_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(17),
      I1 => TIM_CNT(17),
      I2 => TIM_ARE(16),
      I3 => TIM_CNT(16),
      O => \TIM_CNT1_carry__1_i_8_n_0\
    );
\TIM_CNT1_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT1_carry__1_n_0\,
      CO(3) => \TIM_CNT1_carry__2_n_0\,
      CO(2) => \TIM_CNT1_carry__2_n_1\,
      CO(1) => \TIM_CNT1_carry__2_n_2\,
      CO(0) => \TIM_CNT1_carry__2_n_3\,
      CYINIT => '0',
      DI(3) => \TIM_CNT1_carry__2_i_1_n_0\,
      DI(2) => \TIM_CNT1_carry__2_i_2_n_0\,
      DI(1) => \TIM_CNT1_carry__2_i_3_n_0\,
      DI(0) => \TIM_CNT1_carry__2_i_4_n_0\,
      O(3 downto 0) => \NLW_TIM_CNT1_carry__2_O_UNCONNECTED\(3 downto 0),
      S(3) => \TIM_CNT1_carry__2_i_5_n_0\,
      S(2) => \TIM_CNT1_carry__2_i_6_n_0\,
      S(1) => \TIM_CNT1_carry__2_i_7_n_0\,
      S(0) => \TIM_CNT1_carry__2_i_8_n_0\
    );
\TIM_CNT1_carry__2_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(30),
      I1 => TIM_ARE(30),
      I2 => TIM_ARE(31),
      I3 => TIM_CNT(31),
      O => \TIM_CNT1_carry__2_i_1_n_0\
    );
\TIM_CNT1_carry__2_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(28),
      I1 => TIM_ARE(28),
      I2 => TIM_ARE(29),
      I3 => TIM_CNT(29),
      O => \TIM_CNT1_carry__2_i_2_n_0\
    );
\TIM_CNT1_carry__2_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(26),
      I1 => TIM_ARE(26),
      I2 => TIM_ARE(27),
      I3 => TIM_CNT(27),
      O => \TIM_CNT1_carry__2_i_3_n_0\
    );
\TIM_CNT1_carry__2_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(24),
      I1 => TIM_ARE(24),
      I2 => TIM_ARE(25),
      I3 => TIM_CNT(25),
      O => \TIM_CNT1_carry__2_i_4_n_0\
    );
\TIM_CNT1_carry__2_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(31),
      I1 => TIM_CNT(31),
      I2 => TIM_ARE(30),
      I3 => TIM_CNT(30),
      O => \TIM_CNT1_carry__2_i_5_n_0\
    );
\TIM_CNT1_carry__2_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(29),
      I1 => TIM_CNT(29),
      I2 => TIM_ARE(28),
      I3 => TIM_CNT(28),
      O => \TIM_CNT1_carry__2_i_6_n_0\
    );
\TIM_CNT1_carry__2_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(27),
      I1 => TIM_CNT(27),
      I2 => TIM_ARE(26),
      I3 => TIM_CNT(26),
      O => \TIM_CNT1_carry__2_i_7_n_0\
    );
\TIM_CNT1_carry__2_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(25),
      I1 => TIM_CNT(25),
      I2 => TIM_ARE(24),
      I3 => TIM_CNT(24),
      O => \TIM_CNT1_carry__2_i_8_n_0\
    );
TIM_CNT1_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(6),
      I1 => TIM_ARE(6),
      I2 => TIM_ARE(7),
      I3 => TIM_CNT(7),
      O => TIM_CNT1_carry_i_1_n_0
    );
TIM_CNT1_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(4),
      I1 => TIM_ARE(4),
      I2 => TIM_ARE(5),
      I3 => TIM_CNT(5),
      O => TIM_CNT1_carry_i_2_n_0
    );
TIM_CNT1_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(2),
      I1 => TIM_ARE(2),
      I2 => TIM_ARE(3),
      I3 => TIM_CNT(3),
      O => TIM_CNT1_carry_i_3_n_0
    );
TIM_CNT1_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => TIM_CNT(0),
      I1 => TIM_ARE(0),
      I2 => TIM_ARE(1),
      I3 => TIM_CNT(1),
      O => TIM_CNT1_carry_i_4_n_0
    );
TIM_CNT1_carry_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(7),
      I1 => TIM_CNT(7),
      I2 => TIM_ARE(6),
      I3 => TIM_CNT(6),
      O => TIM_CNT1_carry_i_5_n_0
    );
TIM_CNT1_carry_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(5),
      I1 => TIM_CNT(5),
      I2 => TIM_ARE(4),
      I3 => TIM_CNT(4),
      O => TIM_CNT1_carry_i_6_n_0
    );
TIM_CNT1_carry_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(3),
      I1 => TIM_CNT(3),
      I2 => TIM_ARE(2),
      I3 => TIM_CNT(2),
      O => TIM_CNT1_carry_i_7_n_0
    );
TIM_CNT1_carry_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => TIM_ARE(1),
      I1 => TIM_CNT(1),
      I2 => TIM_ARE(0),
      I3 => TIM_CNT(0),
      O => TIM_CNT1_carry_i_8_n_0
    );
\TIM_CNT[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C0FFC0EA"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT[31]_i_7_n_0\,
      I2 => TIM_ARE(0),
      I3 => TIM_CNT(0),
      I4 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[0]_i_1_n_0\
    );
\TIM_CNT[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__1_n_6\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(10),
      I4 => TIM_CNT0(10),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[10]_i_1_n_0\
    );
\TIM_CNT[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__1_n_5\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(11),
      I4 => TIM_CNT0(11),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[11]_i_1_n_0\
    );
\TIM_CNT[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__1_n_4\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(12),
      I4 => TIM_CNT0(12),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[12]_i_1_n_0\
    );
\TIM_CNT[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__2_n_7\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(13),
      I4 => TIM_CNT0(13),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[13]_i_1_n_0\
    );
\TIM_CNT[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__2_n_6\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(14),
      I4 => TIM_CNT0(14),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[14]_i_1_n_0\
    );
\TIM_CNT[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__2_n_5\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(15),
      I4 => TIM_CNT0(15),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[15]_i_1_n_0\
    );
\TIM_CNT[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__2_n_4\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(16),
      I4 => TIM_CNT0(16),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[16]_i_1_n_0\
    );
\TIM_CNT[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__3_n_7\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(17),
      I4 => TIM_CNT0(17),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[17]_i_1_n_0\
    );
\TIM_CNT[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__3_n_6\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(18),
      I4 => TIM_CNT0(18),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[18]_i_1_n_0\
    );
\TIM_CNT[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__3_n_5\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(19),
      I4 => TIM_CNT0(19),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[19]_i_1_n_0\
    );
\TIM_CNT[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry_n_7\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(1),
      I4 => TIM_CNT0(1),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[1]_i_1_n_0\
    );
\TIM_CNT[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__3_n_4\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(20),
      I4 => TIM_CNT0(20),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[20]_i_1_n_0\
    );
\TIM_CNT[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__4_n_7\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(21),
      I4 => TIM_CNT0(21),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[21]_i_1_n_0\
    );
\TIM_CNT[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__4_n_6\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(22),
      I4 => TIM_CNT0(22),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[22]_i_1_n_0\
    );
\TIM_CNT[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__4_n_5\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(23),
      I4 => TIM_CNT0(23),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[23]_i_1_n_0\
    );
\TIM_CNT[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__4_n_4\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(24),
      I4 => TIM_CNT0(24),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[24]_i_1_n_0\
    );
\TIM_CNT[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__5_n_7\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(25),
      I4 => TIM_CNT0(25),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[25]_i_1_n_0\
    );
\TIM_CNT[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__5_n_6\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(26),
      I4 => TIM_CNT0(26),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[26]_i_1_n_0\
    );
\TIM_CNT[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__5_n_5\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(27),
      I4 => TIM_CNT0(27),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[27]_i_1_n_0\
    );
\TIM_CNT[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__5_n_4\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(28),
      I4 => TIM_CNT0(28),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[28]_i_1_n_0\
    );
\TIM_CNT[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__6_n_7\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(29),
      I4 => TIM_CNT0(29),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[29]_i_1_n_0\
    );
\TIM_CNT[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry_n_6\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(2),
      I4 => TIM_CNT0(2),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[2]_i_1_n_0\
    );
\TIM_CNT[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__6_n_6\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(30),
      I4 => TIM_CNT0(30),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[30]_i_1_n_0\
    );
\TIM_CNT[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF8000"
    )
        port map (
      I0 => \TIM_CNT[31]_i_3_n_0\,
      I1 => \TIM_CNT[31]_i_4_n_0\,
      I2 => \TIM_CNT[31]_i_5_n_0\,
      I3 => p_3_in,
      I4 => \TIM_CLR_reg_n_0_[0]\,
      O => \TIM_CNT[31]_i_1_n_0\
    );
\TIM_CNT[31]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000023"
    )
        port map (
      I0 => TIM_PRE(28),
      I1 => TIM_PRE(29),
      I2 => TIM_PRE(27),
      I3 => TIM_PRE(26),
      I4 => TIM_PRE(25),
      O => \TIM_CNT[31]_i_10_n_0\
    );
\TIM_CNT[31]_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(22),
      I1 => TIM_PRE(23),
      O => \TIM_CNT[31]_i_11_n_0\
    );
\TIM_CNT[31]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0011000100000000"
    )
        port map (
      I0 => TIM_PRE(16),
      I1 => TIM_PRE(17),
      I2 => TIM_PRE(18),
      I3 => TIM_PRE(20),
      I4 => TIM_PRE(19),
      I5 => \TIM_CNT[31]_i_22_n_0\,
      O => \TIM_CNT[31]_i_12_n_0\
    );
\TIM_CNT[31]_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000023"
    )
        port map (
      I0 => TIM_PRE(10),
      I1 => TIM_PRE(11),
      I2 => TIM_PRE(9),
      I3 => TIM_PRE(8),
      I4 => TIM_PRE(7),
      O => \TIM_CNT[31]_i_13_n_0\
    );
\TIM_CNT[31]_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000023"
    )
        port map (
      I0 => TIM_PRE(13),
      I1 => TIM_PRE(14),
      I2 => TIM_PRE(12),
      I3 => TIM_PRE(11),
      I4 => TIM_PRE(10),
      O => \TIM_CNT[31]_i_14_n_0\
    );
\TIM_CNT[31]_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000023"
    )
        port map (
      I0 => TIM_PRE(16),
      I1 => TIM_PRE(17),
      I2 => TIM_PRE(15),
      I3 => TIM_PRE(14),
      I4 => TIM_PRE(13),
      O => \TIM_CNT[31]_i_15_n_0\
    );
\TIM_CNT[31]_i_16\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"31"
    )
        port map (
      I0 => TIM_PRE(0),
      I1 => TIM_PRE(2),
      I2 => TIM_PRE(1),
      O => \TIM_CNT[31]_i_16_n_0\
    );
\TIM_CNT[31]_i_17\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000023"
    )
        port map (
      I0 => TIM_PRE(7),
      I1 => TIM_PRE(8),
      I2 => TIM_PRE(6),
      I3 => TIM_PRE(5),
      I4 => TIM_PRE(4),
      O => \TIM_CNT[31]_i_17_n_0\
    );
\TIM_CNT[31]_i_18\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000023"
    )
        port map (
      I0 => TIM_PRE(4),
      I1 => TIM_PRE(5),
      I2 => TIM_PRE(3),
      I3 => TIM_PRE(2),
      I4 => TIM_PRE(1),
      O => \TIM_CNT[31]_i_18_n_0\
    );
\TIM_CNT[31]_i_19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => TIM_CNT(14),
      I1 => TIM_CNT(12),
      I2 => TIM_CNT(10),
      I3 => TIM_CNT(7),
      I4 => \TIM_CNT[31]_i_23_n_0\,
      I5 => \TIM_CNT[31]_i_24_n_0\,
      O => \TIM_CNT[31]_i_19_n_0\
    );
\TIM_CNT[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__6_n_5\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(31),
      I4 => TIM_CNT0(31),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[31]_i_2_n_0\
    );
\TIM_CNT[31]_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => TIM_CNT(25),
      I1 => TIM_CNT(28),
      I2 => TIM_CNT(19),
      I3 => TIM_CNT(22),
      I4 => \TIM_EVN[31]_i_12_n_0\,
      I5 => \TIM_CNT[31]_i_25_n_0\,
      O => \TIM_CNT[31]_i_20_n_0\
    );
\TIM_CNT[31]_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => TIM_CNT(18),
      I1 => TIM_CNT(20),
      I2 => TIM_CNT(16),
      I3 => TIM_CNT(17),
      I4 => \TIM_CNT[31]_i_26_n_0\,
      I5 => \TIM_CNT[31]_i_27_n_0\,
      O => \TIM_CNT[31]_i_21_n_0\
    );
\TIM_CNT[31]_i_22\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000023"
    )
        port map (
      I0 => TIM_PRE(22),
      I1 => TIM_PRE(23),
      I2 => TIM_PRE(21),
      I3 => TIM_PRE(20),
      I4 => TIM_PRE(19),
      O => \TIM_CNT[31]_i_22_n_0\
    );
\TIM_CNT[31]_i_23\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => TIM_CNT(3),
      I1 => TIM_CNT(5),
      I2 => TIM_CNT(4),
      I3 => TIM_CNT(1),
      I4 => TIM_CNT(2),
      I5 => TIM_CNT(0),
      O => \TIM_CNT[31]_i_23_n_0\
    );
\TIM_CNT[31]_i_24\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => TIM_CNT(15),
      I1 => TIM_CNT(13),
      I2 => TIM_CNT(9),
      I3 => TIM_CNT(11),
      I4 => TIM_CNT(6),
      I5 => TIM_CNT(8),
      O => \TIM_CNT[31]_i_24_n_0\
    );
\TIM_CNT[31]_i_25\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => TIM_CNT(27),
      I1 => TIM_CNT(29),
      O => \TIM_CNT[31]_i_25_n_0\
    );
\TIM_CNT[31]_i_26\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => TIM_CNT(24),
      I1 => TIM_CNT(26),
      O => \TIM_CNT[31]_i_26_n_0\
    );
\TIM_CNT[31]_i_27\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => TIM_CNT(21),
      I1 => TIM_CNT(23),
      O => \TIM_CNT[31]_i_27_n_0\
    );
\TIM_CNT[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"080A000000000000"
    )
        port map (
      I0 => \TIM_CNT[31]_i_10_n_0\,
      I1 => TIM_PRE(25),
      I2 => TIM_PRE(26),
      I3 => TIM_PRE(24),
      I4 => \TIM_CNT[31]_i_11_n_0\,
      I5 => \TIM_CNT[31]_i_12_n_0\,
      O => \TIM_CNT[31]_i_3_n_0\
    );
\TIM_CNT[31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \TIM_CNT[31]_i_13_n_0\,
      I1 => \TIM_CNT[31]_i_14_n_0\,
      I2 => \TIM_CNT[31]_i_15_n_0\,
      I3 => \TIM_CNT[31]_i_16_n_0\,
      I4 => \TIM_CNT[31]_i_17_n_0\,
      I5 => \TIM_CNT[31]_i_18_n_0\,
      O => \TIM_CNT[31]_i_4_n_0\
    );
\TIM_CNT[31]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => TIM_PRE(31),
      I1 => TIM_PRE(30),
      I2 => TIM_PRE(29),
      I3 => TIM_PRE(28),
      O => \TIM_CNT[31]_i_5_n_0\
    );
\TIM_CNT[31]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10111111"
    )
        port map (
      I0 => \TIM_CLR_reg_n_0_[0]\,
      I1 => \TIM_MOD_reg_n_0_[0]\,
      I2 => \TIM_CNT[31]_i_19_n_0\,
      I3 => \TIM_CNT[31]_i_20_n_0\,
      I4 => \TIM_CNT[31]_i_21_n_0\,
      O => \TIM_CNT[31]_i_6_n_0\
    );
\TIM_CNT[31]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01000000"
    )
        port map (
      I0 => \TIM_CLR_reg_n_0_[0]\,
      I1 => \TIM_MOD_reg_n_0_[0]\,
      I2 => \TIM_CNT[31]_i_19_n_0\,
      I3 => \TIM_CNT[31]_i_20_n_0\,
      I4 => \TIM_CNT[31]_i_21_n_0\,
      O => \TIM_CNT[31]_i_7_n_0\
    );
\TIM_CNT[31]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \TIM_CNT1_carry__2_n_0\,
      I1 => \TIM_MOD_reg_n_0_[0]\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      O => \TIM_CNT[31]_i_9_n_0\
    );
\TIM_CNT[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry_n_5\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(3),
      I4 => TIM_CNT0(3),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[3]_i_1_n_0\
    );
\TIM_CNT[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry_n_4\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(4),
      I4 => TIM_CNT0(4),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[4]_i_1_n_0\
    );
\TIM_CNT[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__0_n_7\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(5),
      I4 => TIM_CNT0(5),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[5]_i_1_n_0\
    );
\TIM_CNT[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__0_n_6\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(6),
      I4 => TIM_CNT0(6),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[6]_i_1_n_0\
    );
\TIM_CNT[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__0_n_5\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(7),
      I4 => TIM_CNT0(7),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[7]_i_1_n_0\
    );
\TIM_CNT[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__0_n_4\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(8),
      I4 => TIM_CNT0(8),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[8]_i_1_n_0\
    );
\TIM_CNT[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \TIM_CNT[31]_i_6_n_0\,
      I1 => \TIM_CNT0_inferred__0/i__carry__1_n_7\,
      I2 => \TIM_CNT[31]_i_7_n_0\,
      I3 => TIM_ARE(9),
      I4 => TIM_CNT0(9),
      I5 => \TIM_CNT[31]_i_9_n_0\,
      O => \TIM_CNT[9]_i_1_n_0\
    );
\TIM_CNT_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[0]_i_1_n_0\,
      Q => TIM_CNT(0)
    );
\TIM_CNT_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[10]_i_1_n_0\,
      Q => TIM_CNT(10)
    );
\TIM_CNT_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[11]_i_1_n_0\,
      Q => TIM_CNT(11)
    );
\TIM_CNT_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[12]_i_1_n_0\,
      Q => TIM_CNT(12)
    );
\TIM_CNT_reg[12]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT_reg[8]_i_2_n_0\,
      CO(3) => \TIM_CNT_reg[12]_i_2_n_0\,
      CO(2) => \TIM_CNT_reg[12]_i_2_n_1\,
      CO(1) => \TIM_CNT_reg[12]_i_2_n_2\,
      CO(0) => \TIM_CNT_reg[12]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => TIM_CNT0(12 downto 9),
      S(3 downto 0) => TIM_CNT(12 downto 9)
    );
\TIM_CNT_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[13]_i_1_n_0\,
      Q => TIM_CNT(13)
    );
\TIM_CNT_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[14]_i_1_n_0\,
      Q => TIM_CNT(14)
    );
\TIM_CNT_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[15]_i_1_n_0\,
      Q => TIM_CNT(15)
    );
\TIM_CNT_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[16]_i_1_n_0\,
      Q => TIM_CNT(16)
    );
\TIM_CNT_reg[16]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT_reg[12]_i_2_n_0\,
      CO(3) => \TIM_CNT_reg[16]_i_2_n_0\,
      CO(2) => \TIM_CNT_reg[16]_i_2_n_1\,
      CO(1) => \TIM_CNT_reg[16]_i_2_n_2\,
      CO(0) => \TIM_CNT_reg[16]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => TIM_CNT0(16 downto 13),
      S(3 downto 0) => TIM_CNT(16 downto 13)
    );
\TIM_CNT_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[17]_i_1_n_0\,
      Q => TIM_CNT(17)
    );
\TIM_CNT_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[18]_i_1_n_0\,
      Q => TIM_CNT(18)
    );
\TIM_CNT_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[19]_i_1_n_0\,
      Q => TIM_CNT(19)
    );
\TIM_CNT_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[1]_i_1_n_0\,
      Q => TIM_CNT(1)
    );
\TIM_CNT_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[20]_i_1_n_0\,
      Q => TIM_CNT(20)
    );
\TIM_CNT_reg[20]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT_reg[16]_i_2_n_0\,
      CO(3) => \TIM_CNT_reg[20]_i_2_n_0\,
      CO(2) => \TIM_CNT_reg[20]_i_2_n_1\,
      CO(1) => \TIM_CNT_reg[20]_i_2_n_2\,
      CO(0) => \TIM_CNT_reg[20]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => TIM_CNT0(20 downto 17),
      S(3 downto 0) => TIM_CNT(20 downto 17)
    );
\TIM_CNT_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[21]_i_1_n_0\,
      Q => TIM_CNT(21)
    );
\TIM_CNT_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[22]_i_1_n_0\,
      Q => TIM_CNT(22)
    );
\TIM_CNT_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[23]_i_1_n_0\,
      Q => TIM_CNT(23)
    );
\TIM_CNT_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[24]_i_1_n_0\,
      Q => TIM_CNT(24)
    );
\TIM_CNT_reg[24]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT_reg[20]_i_2_n_0\,
      CO(3) => \TIM_CNT_reg[24]_i_2_n_0\,
      CO(2) => \TIM_CNT_reg[24]_i_2_n_1\,
      CO(1) => \TIM_CNT_reg[24]_i_2_n_2\,
      CO(0) => \TIM_CNT_reg[24]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => TIM_CNT0(24 downto 21),
      S(3 downto 0) => TIM_CNT(24 downto 21)
    );
\TIM_CNT_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[25]_i_1_n_0\,
      Q => TIM_CNT(25)
    );
\TIM_CNT_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[26]_i_1_n_0\,
      Q => TIM_CNT(26)
    );
\TIM_CNT_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[27]_i_1_n_0\,
      Q => TIM_CNT(27)
    );
\TIM_CNT_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[28]_i_1_n_0\,
      Q => TIM_CNT(28)
    );
\TIM_CNT_reg[28]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT_reg[24]_i_2_n_0\,
      CO(3) => \TIM_CNT_reg[28]_i_2_n_0\,
      CO(2) => \TIM_CNT_reg[28]_i_2_n_1\,
      CO(1) => \TIM_CNT_reg[28]_i_2_n_2\,
      CO(0) => \TIM_CNT_reg[28]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => TIM_CNT0(28 downto 25),
      S(3 downto 0) => TIM_CNT(28 downto 25)
    );
\TIM_CNT_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[29]_i_1_n_0\,
      Q => TIM_CNT(29)
    );
\TIM_CNT_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[2]_i_1_n_0\,
      Q => TIM_CNT(2)
    );
\TIM_CNT_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[30]_i_1_n_0\,
      Q => TIM_CNT(30)
    );
\TIM_CNT_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[31]_i_2_n_0\,
      Q => TIM_CNT(31)
    );
\TIM_CNT_reg[31]_i_8\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT_reg[28]_i_2_n_0\,
      CO(3 downto 2) => \NLW_TIM_CNT_reg[31]_i_8_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \TIM_CNT_reg[31]_i_8_n_2\,
      CO(0) => \TIM_CNT_reg[31]_i_8_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_TIM_CNT_reg[31]_i_8_O_UNCONNECTED\(3),
      O(2 downto 0) => TIM_CNT0(31 downto 29),
      S(3) => '0',
      S(2 downto 0) => TIM_CNT(31 downto 29)
    );
\TIM_CNT_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[3]_i_1_n_0\,
      Q => TIM_CNT(3)
    );
\TIM_CNT_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[4]_i_1_n_0\,
      Q => TIM_CNT(4)
    );
\TIM_CNT_reg[4]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \TIM_CNT_reg[4]_i_2_n_0\,
      CO(2) => \TIM_CNT_reg[4]_i_2_n_1\,
      CO(1) => \TIM_CNT_reg[4]_i_2_n_2\,
      CO(0) => \TIM_CNT_reg[4]_i_2_n_3\,
      CYINIT => TIM_CNT(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => TIM_CNT0(4 downto 1),
      S(3 downto 0) => TIM_CNT(4 downto 1)
    );
\TIM_CNT_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[5]_i_1_n_0\,
      Q => TIM_CNT(5)
    );
\TIM_CNT_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[6]_i_1_n_0\,
      Q => TIM_CNT(6)
    );
\TIM_CNT_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[7]_i_1_n_0\,
      Q => TIM_CNT(7)
    );
\TIM_CNT_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[8]_i_1_n_0\,
      Q => TIM_CNT(8)
    );
\TIM_CNT_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_CNT_reg[4]_i_2_n_0\,
      CO(3) => \TIM_CNT_reg[8]_i_2_n_0\,
      CO(2) => \TIM_CNT_reg[8]_i_2_n_1\,
      CO(1) => \TIM_CNT_reg[8]_i_2_n_2\,
      CO(0) => \TIM_CNT_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => TIM_CNT0(8 downto 5),
      S(3 downto 0) => TIM_CNT(8 downto 5)
    );
\TIM_CNT_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_CNT[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_CNT[9]_i_1_n_0\,
      Q => TIM_CNT(9)
    );
\TIM_ENA[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2000"
    )
        port map (
      I0 => \TIM_CLR[31]_i_3_n_0\,
      I1 => awaddr(4),
      I2 => awaddr(3),
      I3 => awaddr(2),
      O => TIM_ENA(0)
    );
\TIM_ENA_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(0),
      Q => p_3_in
    );
\TIM_ENA_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(10),
      Q => \TIM_ENA_reg_n_0_[10]\
    );
\TIM_ENA_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(11),
      Q => \TIM_ENA_reg_n_0_[11]\
    );
\TIM_ENA_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(12),
      Q => \TIM_ENA_reg_n_0_[12]\
    );
\TIM_ENA_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(13),
      Q => \TIM_ENA_reg_n_0_[13]\
    );
\TIM_ENA_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(14),
      Q => \TIM_ENA_reg_n_0_[14]\
    );
\TIM_ENA_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(15),
      Q => \TIM_ENA_reg_n_0_[15]\
    );
\TIM_ENA_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(16),
      Q => \TIM_ENA_reg_n_0_[16]\
    );
\TIM_ENA_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(17),
      Q => \TIM_ENA_reg_n_0_[17]\
    );
\TIM_ENA_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(18),
      Q => \TIM_ENA_reg_n_0_[18]\
    );
\TIM_ENA_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(19),
      Q => \TIM_ENA_reg_n_0_[19]\
    );
\TIM_ENA_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(1),
      Q => \TIM_ENA_reg_n_0_[1]\
    );
\TIM_ENA_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(20),
      Q => \TIM_ENA_reg_n_0_[20]\
    );
\TIM_ENA_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(21),
      Q => \TIM_ENA_reg_n_0_[21]\
    );
\TIM_ENA_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(22),
      Q => \TIM_ENA_reg_n_0_[22]\
    );
\TIM_ENA_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(23),
      Q => \TIM_ENA_reg_n_0_[23]\
    );
\TIM_ENA_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(24),
      Q => \TIM_ENA_reg_n_0_[24]\
    );
\TIM_ENA_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(25),
      Q => \TIM_ENA_reg_n_0_[25]\
    );
\TIM_ENA_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(26),
      Q => \TIM_ENA_reg_n_0_[26]\
    );
\TIM_ENA_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(27),
      Q => \TIM_ENA_reg_n_0_[27]\
    );
\TIM_ENA_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(28),
      Q => \TIM_ENA_reg_n_0_[28]\
    );
\TIM_ENA_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(29),
      Q => \TIM_ENA_reg_n_0_[29]\
    );
\TIM_ENA_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(2),
      Q => \TIM_ENA_reg_n_0_[2]\
    );
\TIM_ENA_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(30),
      Q => \TIM_ENA_reg_n_0_[30]\
    );
\TIM_ENA_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(31),
      Q => \TIM_ENA_reg_n_0_[31]\
    );
\TIM_ENA_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(3),
      Q => \TIM_ENA_reg_n_0_[3]\
    );
\TIM_ENA_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(4),
      Q => \TIM_ENA_reg_n_0_[4]\
    );
\TIM_ENA_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(5),
      Q => \TIM_ENA_reg_n_0_[5]\
    );
\TIM_ENA_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(6),
      Q => \TIM_ENA_reg_n_0_[6]\
    );
\TIM_ENA_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(7),
      Q => \TIM_ENA_reg_n_0_[7]\
    );
\TIM_ENA_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(8),
      Q => \TIM_ENA_reg_n_0_[8]\
    );
\TIM_ENA_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_ENA(0),
      CLR => wready_i_2_n_0,
      D => wdata(9),
      Q => \TIM_ENA_reg_n_0_[9]\
    );
\TIM_EVC[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(0),
      O => \TIM_EVC[0]_i_1_n_0\
    );
\TIM_EVC[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(10),
      O => \TIM_EVC[10]_i_1_n_0\
    );
\TIM_EVC[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(11),
      O => \TIM_EVC[11]_i_1_n_0\
    );
\TIM_EVC[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(12),
      O => \TIM_EVC[12]_i_1_n_0\
    );
\TIM_EVC[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(13),
      O => \TIM_EVC[13]_i_1_n_0\
    );
\TIM_EVC[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(14),
      O => \TIM_EVC[14]_i_1_n_0\
    );
\TIM_EVC[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(15),
      O => \TIM_EVC[15]_i_1_n_0\
    );
\TIM_EVC[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(16),
      O => \TIM_EVC[16]_i_1_n_0\
    );
\TIM_EVC[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(17),
      O => \TIM_EVC[17]_i_1_n_0\
    );
\TIM_EVC[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(18),
      O => \TIM_EVC[18]_i_1_n_0\
    );
\TIM_EVC[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(19),
      O => \TIM_EVC[19]_i_1_n_0\
    );
\TIM_EVC[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(1),
      O => \TIM_EVC[1]_i_1_n_0\
    );
\TIM_EVC[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(20),
      O => \TIM_EVC[20]_i_1_n_0\
    );
\TIM_EVC[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(21),
      O => \TIM_EVC[21]_i_1_n_0\
    );
\TIM_EVC[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(22),
      O => \TIM_EVC[22]_i_1_n_0\
    );
\TIM_EVC[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(23),
      O => \TIM_EVC[23]_i_1_n_0\
    );
\TIM_EVC[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(24),
      O => \TIM_EVC[24]_i_1_n_0\
    );
\TIM_EVC[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(25),
      O => \TIM_EVC[25]_i_1_n_0\
    );
\TIM_EVC[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(26),
      O => \TIM_EVC[26]_i_1_n_0\
    );
\TIM_EVC[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(27),
      O => \TIM_EVC[27]_i_1_n_0\
    );
\TIM_EVC[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(28),
      O => \TIM_EVC[28]_i_1_n_0\
    );
\TIM_EVC[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(29),
      O => \TIM_EVC[29]_i_1_n_0\
    );
\TIM_EVC[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(2),
      O => \TIM_EVC[2]_i_1_n_0\
    );
\TIM_EVC[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(30),
      O => \TIM_EVC[30]_i_1_n_0\
    );
\TIM_EVC[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8000FFFF"
    )
        port map (
      I0 => \TIM_CLR[31]_i_3_n_0\,
      I1 => awaddr(4),
      I2 => awaddr(3),
      I3 => awaddr(2),
      I4 => \TIM_EVC[31]_i_3_n_0\,
      O => \TIM_EVC[31]_i_1_n_0\
    );
\TIM_EVC[31]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(31),
      O => \TIM_EVC[31]_i_2_n_0\
    );
\TIM_EVC[31]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
        port map (
      I0 => p_3_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_2_in,
      O => \TIM_EVC[31]_i_3_n_0\
    );
\TIM_EVC[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(3),
      O => \TIM_EVC[3]_i_1_n_0\
    );
\TIM_EVC[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(4),
      O => \TIM_EVC[4]_i_1_n_0\
    );
\TIM_EVC[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(5),
      O => \TIM_EVC[5]_i_1_n_0\
    );
\TIM_EVC[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(6),
      O => \TIM_EVC[6]_i_1_n_0\
    );
\TIM_EVC[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(7),
      O => \TIM_EVC[7]_i_1_n_0\
    );
\TIM_EVC[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(8),
      O => \TIM_EVC[8]_i_1_n_0\
    );
\TIM_EVC[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF00"
    )
        port map (
      I0 => p_2_in,
      I1 => \TIM_CLR_reg_n_0_[0]\,
      I2 => p_3_in,
      I3 => wdata(9),
      O => \TIM_EVC[9]_i_1_n_0\
    );
\TIM_EVC_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[0]_i_1_n_0\,
      Q => p_2_in
    );
\TIM_EVC_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[10]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[10]\
    );
\TIM_EVC_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[11]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[11]\
    );
\TIM_EVC_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[12]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[12]\
    );
\TIM_EVC_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[13]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[13]\
    );
\TIM_EVC_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[14]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[14]\
    );
\TIM_EVC_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[15]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[15]\
    );
\TIM_EVC_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[16]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[16]\
    );
\TIM_EVC_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[17]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[17]\
    );
\TIM_EVC_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[18]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[18]\
    );
\TIM_EVC_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[19]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[19]\
    );
\TIM_EVC_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[1]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[1]\
    );
\TIM_EVC_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[20]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[20]\
    );
\TIM_EVC_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[21]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[21]\
    );
\TIM_EVC_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[22]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[22]\
    );
\TIM_EVC_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[23]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[23]\
    );
\TIM_EVC_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[24]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[24]\
    );
\TIM_EVC_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[25]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[25]\
    );
\TIM_EVC_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[26]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[26]\
    );
\TIM_EVC_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[27]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[27]\
    );
\TIM_EVC_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[28]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[28]\
    );
\TIM_EVC_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[29]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[29]\
    );
\TIM_EVC_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[2]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[2]\
    );
\TIM_EVC_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[30]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[30]\
    );
\TIM_EVC_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[31]_i_2_n_0\,
      Q => \TIM_EVC_reg_n_0_[31]\
    );
\TIM_EVC_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[3]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[3]\
    );
\TIM_EVC_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[4]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[4]\
    );
\TIM_EVC_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[5]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[5]\
    );
\TIM_EVC_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[6]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[6]\
    );
\TIM_EVC_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[7]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[7]\
    );
\TIM_EVC_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[8]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[8]\
    );
\TIM_EVC_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVC[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVC[9]_i_1_n_0\,
      Q => \TIM_EVC_reg_n_0_[9]\
    );
TIM_EVN0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => TIM_EVN0_carry_n_0,
      CO(2) => TIM_EVN0_carry_n_1,
      CO(1) => TIM_EVN0_carry_n_2,
      CO(0) => TIM_EVN0_carry_n_3,
      CYINIT => TIM_EVN(0),
      DI(3 downto 0) => B"0000",
      O(3) => TIM_EVN0_carry_n_4,
      O(2) => TIM_EVN0_carry_n_5,
      O(1) => TIM_EVN0_carry_n_6,
      O(0) => TIM_EVN0_carry_n_7,
      S(3 downto 0) => TIM_EVN(4 downto 1)
    );
\TIM_EVN0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => TIM_EVN0_carry_n_0,
      CO(3) => \TIM_EVN0_carry__0_n_0\,
      CO(2) => \TIM_EVN0_carry__0_n_1\,
      CO(1) => \TIM_EVN0_carry__0_n_2\,
      CO(0) => \TIM_EVN0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \TIM_EVN0_carry__0_n_4\,
      O(2) => \TIM_EVN0_carry__0_n_5\,
      O(1) => \TIM_EVN0_carry__0_n_6\,
      O(0) => \TIM_EVN0_carry__0_n_7\,
      S(3 downto 0) => TIM_EVN(8 downto 5)
    );
\TIM_EVN0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_EVN0_carry__0_n_0\,
      CO(3) => \TIM_EVN0_carry__1_n_0\,
      CO(2) => \TIM_EVN0_carry__1_n_1\,
      CO(1) => \TIM_EVN0_carry__1_n_2\,
      CO(0) => \TIM_EVN0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \TIM_EVN0_carry__1_n_4\,
      O(2) => \TIM_EVN0_carry__1_n_5\,
      O(1) => \TIM_EVN0_carry__1_n_6\,
      O(0) => \TIM_EVN0_carry__1_n_7\,
      S(3 downto 0) => TIM_EVN(12 downto 9)
    );
\TIM_EVN0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_EVN0_carry__1_n_0\,
      CO(3) => \TIM_EVN0_carry__2_n_0\,
      CO(2) => \TIM_EVN0_carry__2_n_1\,
      CO(1) => \TIM_EVN0_carry__2_n_2\,
      CO(0) => \TIM_EVN0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \TIM_EVN0_carry__2_n_4\,
      O(2) => \TIM_EVN0_carry__2_n_5\,
      O(1) => \TIM_EVN0_carry__2_n_6\,
      O(0) => \TIM_EVN0_carry__2_n_7\,
      S(3 downto 0) => TIM_EVN(16 downto 13)
    );
\TIM_EVN0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_EVN0_carry__2_n_0\,
      CO(3) => \TIM_EVN0_carry__3_n_0\,
      CO(2) => \TIM_EVN0_carry__3_n_1\,
      CO(1) => \TIM_EVN0_carry__3_n_2\,
      CO(0) => \TIM_EVN0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \TIM_EVN0_carry__3_n_4\,
      O(2) => \TIM_EVN0_carry__3_n_5\,
      O(1) => \TIM_EVN0_carry__3_n_6\,
      O(0) => \TIM_EVN0_carry__3_n_7\,
      S(3 downto 0) => TIM_EVN(20 downto 17)
    );
\TIM_EVN0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_EVN0_carry__3_n_0\,
      CO(3) => \TIM_EVN0_carry__4_n_0\,
      CO(2) => \TIM_EVN0_carry__4_n_1\,
      CO(1) => \TIM_EVN0_carry__4_n_2\,
      CO(0) => \TIM_EVN0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \TIM_EVN0_carry__4_n_4\,
      O(2) => \TIM_EVN0_carry__4_n_5\,
      O(1) => \TIM_EVN0_carry__4_n_6\,
      O(0) => \TIM_EVN0_carry__4_n_7\,
      S(3 downto 0) => TIM_EVN(24 downto 21)
    );
\TIM_EVN0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_EVN0_carry__4_n_0\,
      CO(3) => \TIM_EVN0_carry__5_n_0\,
      CO(2) => \TIM_EVN0_carry__5_n_1\,
      CO(1) => \TIM_EVN0_carry__5_n_2\,
      CO(0) => \TIM_EVN0_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \TIM_EVN0_carry__5_n_4\,
      O(2) => \TIM_EVN0_carry__5_n_5\,
      O(1) => \TIM_EVN0_carry__5_n_6\,
      O(0) => \TIM_EVN0_carry__5_n_7\,
      S(3 downto 0) => TIM_EVN(28 downto 25)
    );
\TIM_EVN0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_EVN0_carry__5_n_0\,
      CO(3 downto 2) => \NLW_TIM_EVN0_carry__6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \TIM_EVN0_carry__6_n_2\,
      CO(0) => \TIM_EVN0_carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_TIM_EVN0_carry__6_O_UNCONNECTED\(3),
      O(2) => \TIM_EVN0_carry__6_n_5\,
      O(1) => \TIM_EVN0_carry__6_n_6\,
      O(0) => \TIM_EVN0_carry__6_n_7\,
      S(3) => '0',
      S(2 downto 0) => TIM_EVN(31 downto 29)
    );
\TIM_EVN[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0A0A0800"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => TIM_EVN(0),
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[0]_i_1_n_0\
    );
\TIM_EVN[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__1_n_6\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[10]_i_1_n_0\
    );
\TIM_EVN[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__1_n_5\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[11]_i_1_n_0\
    );
\TIM_EVN[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__1_n_4\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[12]_i_1_n_0\
    );
\TIM_EVN[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__2_n_7\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[13]_i_1_n_0\
    );
\TIM_EVN[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__2_n_6\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[14]_i_1_n_0\
    );
\TIM_EVN[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__2_n_5\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[15]_i_1_n_0\
    );
\TIM_EVN[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__2_n_4\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[16]_i_1_n_0\
    );
\TIM_EVN[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__3_n_7\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[17]_i_1_n_0\
    );
\TIM_EVN[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__3_n_6\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[18]_i_1_n_0\
    );
\TIM_EVN[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__3_n_5\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[19]_i_1_n_0\
    );
\TIM_EVN[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => TIM_EVN0_carry_n_7,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[1]_i_1_n_0\
    );
\TIM_EVN[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__3_n_4\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[20]_i_1_n_0\
    );
\TIM_EVN[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__4_n_7\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[21]_i_1_n_0\
    );
\TIM_EVN[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__4_n_6\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[22]_i_1_n_0\
    );
\TIM_EVN[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__4_n_5\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[23]_i_1_n_0\
    );
\TIM_EVN[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__4_n_4\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[24]_i_1_n_0\
    );
\TIM_EVN[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__5_n_7\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[25]_i_1_n_0\
    );
\TIM_EVN[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__5_n_6\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[26]_i_1_n_0\
    );
\TIM_EVN[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__5_n_5\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[27]_i_1_n_0\
    );
\TIM_EVN[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__5_n_4\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[28]_i_1_n_0\
    );
\TIM_EVN[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__6_n_7\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[29]_i_1_n_0\
    );
\TIM_EVN[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => TIM_EVN0_carry_n_6,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[2]_i_1_n_0\
    );
\TIM_EVN[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__6_n_6\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[30]_i_1_n_0\
    );
\TIM_EVN[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0B080000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_3_n_0\,
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => p_2_in,
      I4 => p_3_in,
      O => \TIM_EVN[31]_i_1_n_0\
    );
\TIM_EVN[31]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => TIM_CNT(3),
      I1 => TIM_CNT(5),
      I2 => TIM_CNT(1),
      I3 => TIM_CNT(2),
      I4 => \TIM_EVN[31]_i_23_n_0\,
      O => \TIM_EVN[31]_i_10_n_0\
    );
\TIM_EVN[31]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0011000100000000"
    )
        port map (
      I0 => TIM_PRE(22),
      I1 => TIM_PRE(23),
      I2 => TIM_PRE(24),
      I3 => TIM_PRE(26),
      I4 => TIM_PRE(25),
      I5 => \TIM_CNT[31]_i_10_n_0\,
      O => \TIM_EVN[31]_i_11_n_0\
    );
\TIM_EVN[31]_i_12\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => TIM_CNT(30),
      I1 => TIM_CNT(31),
      O => \TIM_EVN[31]_i_12_n_0\
    );
\TIM_EVN[31]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => TIM_CNT(19),
      I1 => TIM_CNT(20),
      I2 => TIM_CNT(18),
      I3 => TIM_CNT(22),
      I4 => TIM_CNT(23),
      I5 => TIM_CNT(21),
      O => \TIM_EVN[31]_i_13_n_0\
    );
\TIM_EVN[31]_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => TIM_CNT(13),
      I1 => TIM_CNT(14),
      I2 => TIM_CNT(12),
      I3 => TIM_CNT(16),
      I4 => TIM_CNT(17),
      I5 => TIM_CNT(15),
      O => \TIM_EVN[31]_i_14_n_0\
    );
\TIM_EVN[31]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => TIM_CNT(7),
      I1 => TIM_CNT(8),
      I2 => TIM_CNT(6),
      I3 => TIM_CNT(10),
      I4 => TIM_CNT(11),
      I5 => TIM_CNT(9),
      O => \TIM_EVN[31]_i_15_n_0\
    );
\TIM_EVN[31]_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => TIM_CNT(1),
      I1 => TIM_CNT(2),
      I2 => TIM_CNT(0),
      I3 => TIM_CNT(4),
      I4 => TIM_CNT(5),
      I5 => TIM_CNT(3),
      O => \TIM_EVN[31]_i_16_n_0\
    );
\TIM_EVN[31]_i_17\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => TIM_CNT(24),
      I1 => TIM_CNT(26),
      I2 => TIM_CNT(25),
      O => \TIM_EVN[31]_i_17_n_0\
    );
\TIM_EVN[31]_i_18\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => TIM_CNT(16),
      I1 => TIM_CNT(17),
      O => \TIM_EVN[31]_i_18_n_0\
    );
\TIM_EVN[31]_i_19\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => TIM_CNT(26),
      I1 => TIM_CNT(24),
      I2 => TIM_CNT(29),
      I3 => TIM_CNT(27),
      O => \TIM_EVN[31]_i_19_n_0\
    );
\TIM_EVN[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__6_n_5\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[31]_i_2_n_0\
    );
\TIM_EVN[31]_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => TIM_CNT(21),
      I1 => TIM_CNT(23),
      I2 => TIM_CNT(18),
      I3 => TIM_CNT(20),
      I4 => TIM_CNT(25),
      I5 => TIM_CNT(22),
      O => \TIM_EVN[31]_i_20_n_0\
    );
\TIM_EVN[31]_i_21\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => TIM_CNT(12),
      I1 => TIM_CNT(14),
      O => \TIM_EVN[31]_i_21_n_0\
    );
\TIM_EVN[31]_i_22\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(13),
      I1 => TIM_CNT(15),
      O => \TIM_EVN[31]_i_22_n_0\
    );
\TIM_EVN[31]_i_23\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => TIM_CNT(8),
      I1 => TIM_CNT(6),
      I2 => TIM_CNT(11),
      I3 => TIM_CNT(9),
      O => \TIM_EVN[31]_i_23_n_0\
    );
\TIM_EVN[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF8B888888"
    )
        port map (
      I0 => \TIM_CNT1_carry__2_n_0\,
      I1 => \TIM_MOD_reg_n_0_[0]\,
      I2 => \TIM_EVN[31]_i_8_n_0\,
      I3 => \TIM_EVN[31]_i_9_n_0\,
      I4 => \TIM_EVN[31]_i_10_n_0\,
      I5 => p_2_in,
      O => \TIM_EVN[31]_i_3_n_0\
    );
\TIM_EVN[31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000008"
    )
        port map (
      I0 => \TIM_CNT[31]_i_12_n_0\,
      I1 => \TIM_EVN[31]_i_11_n_0\,
      I2 => TIM_PRE(28),
      I3 => TIM_PRE(29),
      I4 => TIM_PRE(30),
      I5 => TIM_PRE(31),
      O => \TIM_EVN[31]_i_4_n_0\
    );
\TIM_EVN[31]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000100000000"
    )
        port map (
      I0 => TIM_CNT(27),
      I1 => TIM_CNT(29),
      I2 => TIM_CNT(28),
      I3 => \TIM_EVN[31]_i_12_n_0\,
      I4 => \TIM_MOD_reg_n_0_[0]\,
      I5 => \TIM_CNT[31]_i_4_n_0\,
      O => \TIM_EVN[31]_i_5_n_0\
    );
\TIM_EVN[31]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_13_n_0\,
      I1 => \TIM_EVN[31]_i_14_n_0\,
      I2 => \TIM_EVN[31]_i_15_n_0\,
      I3 => \TIM_EVN[31]_i_16_n_0\,
      I4 => \TIM_EVN[31]_i_17_n_0\,
      O => \TIM_EVN[31]_i_6_n_0\
    );
\TIM_EVN[31]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \TIM_CNT1_carry__2_n_0\,
      I1 => \TIM_MOD_reg_n_0_[0]\,
      I2 => \TIM_CNT[31]_i_4_n_0\,
      O => \TIM_EVN[31]_i_7_n_0\
    );
\TIM_EVN[31]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \TIM_EVN[31]_i_18_n_0\,
      I1 => TIM_CNT(19),
      I2 => \TIM_EVN[31]_i_19_n_0\,
      I3 => \TIM_EVN[31]_i_12_n_0\,
      I4 => TIM_CNT(28),
      I5 => \TIM_EVN[31]_i_20_n_0\,
      O => \TIM_EVN[31]_i_8_n_0\
    );
\TIM_EVN[31]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000100000000"
    )
        port map (
      I0 => TIM_CNT(7),
      I1 => TIM_CNT(10),
      I2 => TIM_CNT(0),
      I3 => TIM_CNT(4),
      I4 => \TIM_EVN[31]_i_21_n_0\,
      I5 => \TIM_EVN[31]_i_22_n_0\,
      O => \TIM_EVN[31]_i_9_n_0\
    );
\TIM_EVN[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => TIM_EVN0_carry_n_5,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[3]_i_1_n_0\
    );
\TIM_EVN[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => TIM_EVN0_carry_n_4,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[4]_i_1_n_0\
    );
\TIM_EVN[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__0_n_7\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[5]_i_1_n_0\
    );
\TIM_EVN[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__0_n_6\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[6]_i_1_n_0\
    );
\TIM_EVN[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__0_n_5\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[7]_i_1_n_0\
    );
\TIM_EVN[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__0_n_4\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[8]_i_1_n_0\
    );
\TIM_EVN[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A08000"
    )
        port map (
      I0 => \TIM_EVN[31]_i_4_n_0\,
      I1 => \TIM_EVN[31]_i_5_n_0\,
      I2 => \TIM_EVN0_carry__1_n_7\,
      I3 => \TIM_EVN[31]_i_6_n_0\,
      I4 => \TIM_EVN[31]_i_7_n_0\,
      O => \TIM_EVN[9]_i_1_n_0\
    );
\TIM_EVN_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[0]_i_1_n_0\,
      Q => TIM_EVN(0)
    );
\TIM_EVN_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[10]_i_1_n_0\,
      Q => TIM_EVN(10)
    );
\TIM_EVN_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[11]_i_1_n_0\,
      Q => TIM_EVN(11)
    );
\TIM_EVN_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[12]_i_1_n_0\,
      Q => TIM_EVN(12)
    );
\TIM_EVN_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[13]_i_1_n_0\,
      Q => TIM_EVN(13)
    );
\TIM_EVN_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[14]_i_1_n_0\,
      Q => TIM_EVN(14)
    );
\TIM_EVN_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[15]_i_1_n_0\,
      Q => TIM_EVN(15)
    );
\TIM_EVN_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[16]_i_1_n_0\,
      Q => TIM_EVN(16)
    );
\TIM_EVN_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[17]_i_1_n_0\,
      Q => TIM_EVN(17)
    );
\TIM_EVN_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[18]_i_1_n_0\,
      Q => TIM_EVN(18)
    );
\TIM_EVN_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[19]_i_1_n_0\,
      Q => TIM_EVN(19)
    );
\TIM_EVN_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[1]_i_1_n_0\,
      Q => TIM_EVN(1)
    );
\TIM_EVN_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[20]_i_1_n_0\,
      Q => TIM_EVN(20)
    );
\TIM_EVN_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[21]_i_1_n_0\,
      Q => TIM_EVN(21)
    );
\TIM_EVN_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[22]_i_1_n_0\,
      Q => TIM_EVN(22)
    );
\TIM_EVN_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[23]_i_1_n_0\,
      Q => TIM_EVN(23)
    );
\TIM_EVN_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[24]_i_1_n_0\,
      Q => TIM_EVN(24)
    );
\TIM_EVN_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[25]_i_1_n_0\,
      Q => TIM_EVN(25)
    );
\TIM_EVN_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[26]_i_1_n_0\,
      Q => TIM_EVN(26)
    );
\TIM_EVN_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[27]_i_1_n_0\,
      Q => TIM_EVN(27)
    );
\TIM_EVN_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[28]_i_1_n_0\,
      Q => TIM_EVN(28)
    );
\TIM_EVN_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[29]_i_1_n_0\,
      Q => TIM_EVN(29)
    );
\TIM_EVN_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[2]_i_1_n_0\,
      Q => TIM_EVN(2)
    );
\TIM_EVN_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[30]_i_1_n_0\,
      Q => TIM_EVN(30)
    );
\TIM_EVN_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[31]_i_2_n_0\,
      Q => TIM_EVN(31)
    );
\TIM_EVN_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[3]_i_1_n_0\,
      Q => TIM_EVN(3)
    );
\TIM_EVN_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[4]_i_1_n_0\,
      Q => TIM_EVN(4)
    );
\TIM_EVN_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[5]_i_1_n_0\,
      Q => TIM_EVN(5)
    );
\TIM_EVN_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[6]_i_1_n_0\,
      Q => TIM_EVN(6)
    );
\TIM_EVN_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[7]_i_1_n_0\,
      Q => TIM_EVN(7)
    );
\TIM_EVN_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[8]_i_1_n_0\,
      Q => TIM_EVN(8)
    );
\TIM_EVN_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_EVN[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_EVN[9]_i_1_n_0\,
      Q => TIM_EVN(9)
    );
\TIM_MOD[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => awaddr(2),
      I1 => awaddr(4),
      I2 => awaddr(3),
      I3 => \TIM_CLR[31]_i_3_n_0\,
      O => TIM_MOD(0)
    );
\TIM_MOD_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(0),
      Q => \TIM_MOD_reg_n_0_[0]\
    );
\TIM_MOD_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(10),
      Q => \TIM_MOD_reg_n_0_[10]\
    );
\TIM_MOD_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(11),
      Q => \TIM_MOD_reg_n_0_[11]\
    );
\TIM_MOD_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(12),
      Q => \TIM_MOD_reg_n_0_[12]\
    );
\TIM_MOD_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(13),
      Q => \TIM_MOD_reg_n_0_[13]\
    );
\TIM_MOD_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(14),
      Q => \TIM_MOD_reg_n_0_[14]\
    );
\TIM_MOD_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(15),
      Q => \TIM_MOD_reg_n_0_[15]\
    );
\TIM_MOD_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(16),
      Q => \TIM_MOD_reg_n_0_[16]\
    );
\TIM_MOD_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(17),
      Q => \TIM_MOD_reg_n_0_[17]\
    );
\TIM_MOD_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(18),
      Q => \TIM_MOD_reg_n_0_[18]\
    );
\TIM_MOD_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(19),
      Q => \TIM_MOD_reg_n_0_[19]\
    );
\TIM_MOD_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(1),
      Q => \TIM_MOD_reg_n_0_[1]\
    );
\TIM_MOD_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(20),
      Q => \TIM_MOD_reg_n_0_[20]\
    );
\TIM_MOD_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(21),
      Q => \TIM_MOD_reg_n_0_[21]\
    );
\TIM_MOD_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(22),
      Q => \TIM_MOD_reg_n_0_[22]\
    );
\TIM_MOD_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(23),
      Q => \TIM_MOD_reg_n_0_[23]\
    );
\TIM_MOD_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(24),
      Q => \TIM_MOD_reg_n_0_[24]\
    );
\TIM_MOD_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(25),
      Q => \TIM_MOD_reg_n_0_[25]\
    );
\TIM_MOD_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(26),
      Q => \TIM_MOD_reg_n_0_[26]\
    );
\TIM_MOD_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(27),
      Q => \TIM_MOD_reg_n_0_[27]\
    );
\TIM_MOD_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(28),
      Q => \TIM_MOD_reg_n_0_[28]\
    );
\TIM_MOD_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(29),
      Q => \TIM_MOD_reg_n_0_[29]\
    );
\TIM_MOD_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(2),
      Q => \TIM_MOD_reg_n_0_[2]\
    );
\TIM_MOD_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(30),
      Q => \TIM_MOD_reg_n_0_[30]\
    );
\TIM_MOD_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(31),
      Q => \TIM_MOD_reg_n_0_[31]\
    );
\TIM_MOD_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(3),
      Q => \TIM_MOD_reg_n_0_[3]\
    );
\TIM_MOD_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(4),
      Q => \TIM_MOD_reg_n_0_[4]\
    );
\TIM_MOD_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(5),
      Q => \TIM_MOD_reg_n_0_[5]\
    );
\TIM_MOD_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(6),
      Q => \TIM_MOD_reg_n_0_[6]\
    );
\TIM_MOD_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(7),
      Q => \TIM_MOD_reg_n_0_[7]\
    );
\TIM_MOD_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(8),
      Q => \TIM_MOD_reg_n_0_[8]\
    );
\TIM_MOD_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_MOD(0),
      CLR => wready_i_2_n_0,
      D => wdata(9),
      Q => \TIM_MOD_reg_n_0_[9]\
    );
TIM_PRE0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => TIM_PRE0_carry_n_0,
      CO(2) => TIM_PRE0_carry_n_1,
      CO(1) => TIM_PRE0_carry_n_2,
      CO(0) => TIM_PRE0_carry_n_3,
      CYINIT => TIM_PRE(0),
      DI(3 downto 0) => TIM_PRE(4 downto 1),
      O(3 downto 0) => data1(4 downto 1),
      S(3) => TIM_PRE0_carry_i_1_n_0,
      S(2) => TIM_PRE0_carry_i_2_n_0,
      S(1) => TIM_PRE0_carry_i_3_n_0,
      S(0) => TIM_PRE0_carry_i_4_n_0
    );
\TIM_PRE0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => TIM_PRE0_carry_n_0,
      CO(3) => \TIM_PRE0_carry__0_n_0\,
      CO(2) => \TIM_PRE0_carry__0_n_1\,
      CO(1) => \TIM_PRE0_carry__0_n_2\,
      CO(0) => \TIM_PRE0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_PRE(8 downto 5),
      O(3 downto 0) => data1(8 downto 5),
      S(3) => \TIM_PRE0_carry__0_i_1_n_0\,
      S(2) => \TIM_PRE0_carry__0_i_2_n_0\,
      S(1) => \TIM_PRE0_carry__0_i_3_n_0\,
      S(0) => \TIM_PRE0_carry__0_i_4_n_0\
    );
\TIM_PRE0_carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(8),
      O => \TIM_PRE0_carry__0_i_1_n_0\
    );
\TIM_PRE0_carry__0_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(7),
      O => \TIM_PRE0_carry__0_i_2_n_0\
    );
\TIM_PRE0_carry__0_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(6),
      O => \TIM_PRE0_carry__0_i_3_n_0\
    );
\TIM_PRE0_carry__0_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(5),
      O => \TIM_PRE0_carry__0_i_4_n_0\
    );
\TIM_PRE0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_PRE0_carry__0_n_0\,
      CO(3) => \TIM_PRE0_carry__1_n_0\,
      CO(2) => \TIM_PRE0_carry__1_n_1\,
      CO(1) => \TIM_PRE0_carry__1_n_2\,
      CO(0) => \TIM_PRE0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_PRE(12 downto 9),
      O(3 downto 0) => data1(12 downto 9),
      S(3) => \TIM_PRE0_carry__1_i_1_n_0\,
      S(2) => \TIM_PRE0_carry__1_i_2_n_0\,
      S(1) => \TIM_PRE0_carry__1_i_3_n_0\,
      S(0) => \TIM_PRE0_carry__1_i_4_n_0\
    );
\TIM_PRE0_carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(12),
      O => \TIM_PRE0_carry__1_i_1_n_0\
    );
\TIM_PRE0_carry__1_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(11),
      O => \TIM_PRE0_carry__1_i_2_n_0\
    );
\TIM_PRE0_carry__1_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(10),
      O => \TIM_PRE0_carry__1_i_3_n_0\
    );
\TIM_PRE0_carry__1_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(9),
      O => \TIM_PRE0_carry__1_i_4_n_0\
    );
\TIM_PRE0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_PRE0_carry__1_n_0\,
      CO(3) => \TIM_PRE0_carry__2_n_0\,
      CO(2) => \TIM_PRE0_carry__2_n_1\,
      CO(1) => \TIM_PRE0_carry__2_n_2\,
      CO(0) => \TIM_PRE0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_PRE(16 downto 13),
      O(3 downto 0) => data1(16 downto 13),
      S(3) => \TIM_PRE0_carry__2_i_1_n_0\,
      S(2) => \TIM_PRE0_carry__2_i_2_n_0\,
      S(1) => \TIM_PRE0_carry__2_i_3_n_0\,
      S(0) => \TIM_PRE0_carry__2_i_4_n_0\
    );
\TIM_PRE0_carry__2_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(16),
      O => \TIM_PRE0_carry__2_i_1_n_0\
    );
\TIM_PRE0_carry__2_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(15),
      O => \TIM_PRE0_carry__2_i_2_n_0\
    );
\TIM_PRE0_carry__2_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(14),
      O => \TIM_PRE0_carry__2_i_3_n_0\
    );
\TIM_PRE0_carry__2_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(13),
      O => \TIM_PRE0_carry__2_i_4_n_0\
    );
\TIM_PRE0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_PRE0_carry__2_n_0\,
      CO(3) => \TIM_PRE0_carry__3_n_0\,
      CO(2) => \TIM_PRE0_carry__3_n_1\,
      CO(1) => \TIM_PRE0_carry__3_n_2\,
      CO(0) => \TIM_PRE0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_PRE(20 downto 17),
      O(3 downto 0) => data1(20 downto 17),
      S(3) => \TIM_PRE0_carry__3_i_1_n_0\,
      S(2) => \TIM_PRE0_carry__3_i_2_n_0\,
      S(1) => \TIM_PRE0_carry__3_i_3_n_0\,
      S(0) => \TIM_PRE0_carry__3_i_4_n_0\
    );
\TIM_PRE0_carry__3_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(20),
      O => \TIM_PRE0_carry__3_i_1_n_0\
    );
\TIM_PRE0_carry__3_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(19),
      O => \TIM_PRE0_carry__3_i_2_n_0\
    );
\TIM_PRE0_carry__3_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(18),
      O => \TIM_PRE0_carry__3_i_3_n_0\
    );
\TIM_PRE0_carry__3_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(17),
      O => \TIM_PRE0_carry__3_i_4_n_0\
    );
\TIM_PRE0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_PRE0_carry__3_n_0\,
      CO(3) => \TIM_PRE0_carry__4_n_0\,
      CO(2) => \TIM_PRE0_carry__4_n_1\,
      CO(1) => \TIM_PRE0_carry__4_n_2\,
      CO(0) => \TIM_PRE0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_PRE(24 downto 21),
      O(3 downto 0) => data1(24 downto 21),
      S(3) => \TIM_PRE0_carry__4_i_1_n_0\,
      S(2) => \TIM_PRE0_carry__4_i_2_n_0\,
      S(1) => \TIM_PRE0_carry__4_i_3_n_0\,
      S(0) => \TIM_PRE0_carry__4_i_4_n_0\
    );
\TIM_PRE0_carry__4_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(24),
      O => \TIM_PRE0_carry__4_i_1_n_0\
    );
\TIM_PRE0_carry__4_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(23),
      O => \TIM_PRE0_carry__4_i_2_n_0\
    );
\TIM_PRE0_carry__4_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(22),
      O => \TIM_PRE0_carry__4_i_3_n_0\
    );
\TIM_PRE0_carry__4_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(21),
      O => \TIM_PRE0_carry__4_i_4_n_0\
    );
\TIM_PRE0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_PRE0_carry__4_n_0\,
      CO(3) => \TIM_PRE0_carry__5_n_0\,
      CO(2) => \TIM_PRE0_carry__5_n_1\,
      CO(1) => \TIM_PRE0_carry__5_n_2\,
      CO(0) => \TIM_PRE0_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => TIM_PRE(28 downto 25),
      O(3 downto 0) => data1(28 downto 25),
      S(3) => \TIM_PRE0_carry__5_i_1_n_0\,
      S(2) => \TIM_PRE0_carry__5_i_2_n_0\,
      S(1) => \TIM_PRE0_carry__5_i_3_n_0\,
      S(0) => \TIM_PRE0_carry__5_i_4_n_0\
    );
\TIM_PRE0_carry__5_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(28),
      O => \TIM_PRE0_carry__5_i_1_n_0\
    );
\TIM_PRE0_carry__5_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(27),
      O => \TIM_PRE0_carry__5_i_2_n_0\
    );
\TIM_PRE0_carry__5_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(26),
      O => \TIM_PRE0_carry__5_i_3_n_0\
    );
\TIM_PRE0_carry__5_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(25),
      O => \TIM_PRE0_carry__5_i_4_n_0\
    );
\TIM_PRE0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \TIM_PRE0_carry__5_n_0\,
      CO(3 downto 2) => \NLW_TIM_PRE0_carry__6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \TIM_PRE0_carry__6_n_2\,
      CO(0) => \TIM_PRE0_carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1 downto 0) => TIM_PRE(30 downto 29),
      O(3) => \NLW_TIM_PRE0_carry__6_O_UNCONNECTED\(3),
      O(2 downto 0) => data1(31 downto 29),
      S(3) => '0',
      S(2) => \TIM_PRE0_carry__6_i_1_n_0\,
      S(1) => \TIM_PRE0_carry__6_i_2_n_0\,
      S(0) => \TIM_PRE0_carry__6_i_3_n_0\
    );
\TIM_PRE0_carry__6_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(31),
      O => \TIM_PRE0_carry__6_i_1_n_0\
    );
\TIM_PRE0_carry__6_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(30),
      O => \TIM_PRE0_carry__6_i_2_n_0\
    );
\TIM_PRE0_carry__6_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(29),
      O => \TIM_PRE0_carry__6_i_3_n_0\
    );
TIM_PRE0_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(4),
      O => TIM_PRE0_carry_i_1_n_0
    );
TIM_PRE0_carry_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(3),
      O => TIM_PRE0_carry_i_2_n_0
    );
TIM_PRE0_carry_i_3: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(2),
      O => TIM_PRE0_carry_i_3_n_0
    );
TIM_PRE0_carry_i_4: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_PRE(1),
      O => TIM_PRE0_carry_i_4_n_0
    );
\TIM_PRE[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A8AB"
    )
        port map (
      I0 => TIM_PRE_m(0),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => TIM_PRE(0),
      O => \TIM_PRE[0]_i_1_n_0\
    );
\TIM_PRE[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(10),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(10),
      O => \TIM_PRE[10]_i_1_n_0\
    );
\TIM_PRE[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(11),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(11),
      O => \TIM_PRE[11]_i_1_n_0\
    );
\TIM_PRE[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(12),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(12),
      O => \TIM_PRE[12]_i_1_n_0\
    );
\TIM_PRE[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(13),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(13),
      O => \TIM_PRE[13]_i_1_n_0\
    );
\TIM_PRE[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(14),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(14),
      O => \TIM_PRE[14]_i_1_n_0\
    );
\TIM_PRE[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(15),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(15),
      O => \TIM_PRE[15]_i_1_n_0\
    );
\TIM_PRE[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(16),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(16),
      O => \TIM_PRE[16]_i_1_n_0\
    );
\TIM_PRE[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(17),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(17),
      O => \TIM_PRE[17]_i_1_n_0\
    );
\TIM_PRE[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(18),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(18),
      O => \TIM_PRE[18]_i_1_n_0\
    );
\TIM_PRE[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(19),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(19),
      O => \TIM_PRE[19]_i_1_n_0\
    );
\TIM_PRE[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(1),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(1),
      O => \TIM_PRE[1]_i_1_n_0\
    );
\TIM_PRE[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(20),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(20),
      O => \TIM_PRE[20]_i_1_n_0\
    );
\TIM_PRE[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(21),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(21),
      O => \TIM_PRE[21]_i_1_n_0\
    );
\TIM_PRE[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(22),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(22),
      O => \TIM_PRE[22]_i_1_n_0\
    );
\TIM_PRE[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(23),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(23),
      O => \TIM_PRE[23]_i_1_n_0\
    );
\TIM_PRE[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(24),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(24),
      O => \TIM_PRE[24]_i_1_n_0\
    );
\TIM_PRE[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(25),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(25),
      O => \TIM_PRE[25]_i_1_n_0\
    );
\TIM_PRE[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(26),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(26),
      O => \TIM_PRE[26]_i_1_n_0\
    );
\TIM_PRE[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(27),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(27),
      O => \TIM_PRE[27]_i_1_n_0\
    );
\TIM_PRE[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(28),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(28),
      O => \TIM_PRE[28]_i_1_n_0\
    );
\TIM_PRE[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(29),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(29),
      O => \TIM_PRE[29]_i_1_n_0\
    );
\TIM_PRE[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(2),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(2),
      O => \TIM_PRE[2]_i_1_n_0\
    );
\TIM_PRE[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(30),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(30),
      O => \TIM_PRE[30]_i_1_n_0\
    );
\TIM_PRE[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \TIM_CLR_reg_n_0_[0]\,
      I1 => p_3_in,
      O => \TIM_PRE[31]_i_1_n_0\
    );
\TIM_PRE[31]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => TIM_PRE(11),
      I1 => TIM_PRE(10),
      I2 => TIM_PRE(9),
      I3 => TIM_PRE(8),
      O => \TIM_PRE[31]_i_10_n_0\
    );
\TIM_PRE[31]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(31),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(31),
      O => \TIM_PRE[31]_i_2_n_0\
    );
\TIM_PRE[31]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
        port map (
      I0 => \TIM_PRE[31]_i_4_n_0\,
      I1 => \TIM_PRE[31]_i_5_n_0\,
      I2 => \TIM_PRE[31]_i_6_n_0\,
      I3 => \TIM_PRE[31]_i_7_n_0\,
      O => \TIM_PRE[31]_i_3_n_0\
    );
\TIM_PRE[31]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \TIM_CNT[31]_i_5_n_0\,
      I1 => TIM_PRE(24),
      I2 => TIM_PRE(25),
      I3 => TIM_PRE(26),
      I4 => TIM_PRE(27),
      O => \TIM_PRE[31]_i_4_n_0\
    );
\TIM_PRE[31]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => TIM_PRE(18),
      I1 => TIM_PRE(19),
      I2 => TIM_PRE(16),
      I3 => TIM_PRE(17),
      I4 => \TIM_PRE[31]_i_8_n_0\,
      O => \TIM_PRE[31]_i_5_n_0\
    );
\TIM_PRE[31]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => TIM_PRE(6),
      I1 => TIM_PRE(7),
      I2 => TIM_PRE(4),
      I3 => TIM_PRE(5),
      I4 => \TIM_PRE[31]_i_9_n_0\,
      O => \TIM_PRE[31]_i_6_n_0\
    );
\TIM_PRE[31]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => TIM_PRE(12),
      I1 => TIM_PRE(13),
      I2 => TIM_PRE(14),
      I3 => TIM_PRE(15),
      I4 => \TIM_PRE[31]_i_10_n_0\,
      O => \TIM_PRE[31]_i_7_n_0\
    );
\TIM_PRE[31]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => TIM_PRE(23),
      I1 => TIM_PRE(22),
      I2 => TIM_PRE(21),
      I3 => TIM_PRE(20),
      O => \TIM_PRE[31]_i_8_n_0\
    );
\TIM_PRE[31]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => TIM_PRE(3),
      I1 => TIM_PRE(2),
      I2 => TIM_PRE(1),
      I3 => TIM_PRE(0),
      O => \TIM_PRE[31]_i_9_n_0\
    );
\TIM_PRE[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(3),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(3),
      O => \TIM_PRE[3]_i_1_n_0\
    );
\TIM_PRE[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(4),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(4),
      O => \TIM_PRE[4]_i_1_n_0\
    );
\TIM_PRE[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(5),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(5),
      O => \TIM_PRE[5]_i_1_n_0\
    );
\TIM_PRE[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(6),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(6),
      O => \TIM_PRE[6]_i_1_n_0\
    );
\TIM_PRE[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(7),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(7),
      O => \TIM_PRE[7]_i_1_n_0\
    );
\TIM_PRE[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(8),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(8),
      O => \TIM_PRE[8]_i_1_n_0\
    );
\TIM_PRE[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABA8"
    )
        port map (
      I0 => TIM_PRE_m(9),
      I1 => \TIM_PRE[31]_i_3_n_0\,
      I2 => \TIM_CLR_reg_n_0_[0]\,
      I3 => data1(9),
      O => \TIM_PRE[9]_i_1_n_0\
    );
\TIM_PRE_m[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => \TIM_CLR[31]_i_3_n_0\,
      I1 => awaddr(4),
      I2 => awaddr(3),
      I3 => awaddr(2),
      O => TIM_PRE_m_0(0)
    );
\TIM_PRE_m_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(0),
      Q => TIM_PRE_m(0)
    );
\TIM_PRE_m_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(10),
      Q => TIM_PRE_m(10)
    );
\TIM_PRE_m_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(11),
      Q => TIM_PRE_m(11)
    );
\TIM_PRE_m_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(12),
      Q => TIM_PRE_m(12)
    );
\TIM_PRE_m_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(13),
      Q => TIM_PRE_m(13)
    );
\TIM_PRE_m_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(14),
      Q => TIM_PRE_m(14)
    );
\TIM_PRE_m_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(15),
      Q => TIM_PRE_m(15)
    );
\TIM_PRE_m_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(16),
      Q => TIM_PRE_m(16)
    );
\TIM_PRE_m_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(17),
      Q => TIM_PRE_m(17)
    );
\TIM_PRE_m_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(18),
      Q => TIM_PRE_m(18)
    );
\TIM_PRE_m_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(19),
      Q => TIM_PRE_m(19)
    );
\TIM_PRE_m_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(1),
      Q => TIM_PRE_m(1)
    );
\TIM_PRE_m_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(20),
      Q => TIM_PRE_m(20)
    );
\TIM_PRE_m_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(21),
      Q => TIM_PRE_m(21)
    );
\TIM_PRE_m_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(22),
      Q => TIM_PRE_m(22)
    );
\TIM_PRE_m_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(23),
      Q => TIM_PRE_m(23)
    );
\TIM_PRE_m_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(24),
      Q => TIM_PRE_m(24)
    );
\TIM_PRE_m_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(25),
      Q => TIM_PRE_m(25)
    );
\TIM_PRE_m_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(26),
      Q => TIM_PRE_m(26)
    );
\TIM_PRE_m_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(27),
      Q => TIM_PRE_m(27)
    );
\TIM_PRE_m_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(28),
      Q => TIM_PRE_m(28)
    );
\TIM_PRE_m_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(29),
      Q => TIM_PRE_m(29)
    );
\TIM_PRE_m_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(2),
      Q => TIM_PRE_m(2)
    );
\TIM_PRE_m_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(30),
      Q => TIM_PRE_m(30)
    );
\TIM_PRE_m_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(31),
      Q => TIM_PRE_m(31)
    );
\TIM_PRE_m_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(3),
      Q => TIM_PRE_m(3)
    );
\TIM_PRE_m_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(4),
      Q => TIM_PRE_m(4)
    );
\TIM_PRE_m_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(5),
      Q => TIM_PRE_m(5)
    );
\TIM_PRE_m_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(6),
      Q => TIM_PRE_m(6)
    );
\TIM_PRE_m_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(7),
      Q => TIM_PRE_m(7)
    );
\TIM_PRE_m_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(8),
      Q => TIM_PRE_m(8)
    );
\TIM_PRE_m_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => TIM_PRE_m_0(0),
      CLR => wready_i_2_n_0,
      D => wdata(9),
      Q => TIM_PRE_m(9)
    );
\TIM_PRE_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[0]_i_1_n_0\,
      Q => TIM_PRE(0)
    );
\TIM_PRE_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[10]_i_1_n_0\,
      Q => TIM_PRE(10)
    );
\TIM_PRE_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[11]_i_1_n_0\,
      Q => TIM_PRE(11)
    );
\TIM_PRE_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[12]_i_1_n_0\,
      Q => TIM_PRE(12)
    );
\TIM_PRE_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[13]_i_1_n_0\,
      Q => TIM_PRE(13)
    );
\TIM_PRE_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[14]_i_1_n_0\,
      Q => TIM_PRE(14)
    );
\TIM_PRE_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[15]_i_1_n_0\,
      Q => TIM_PRE(15)
    );
\TIM_PRE_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[16]_i_1_n_0\,
      Q => TIM_PRE(16)
    );
\TIM_PRE_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[17]_i_1_n_0\,
      Q => TIM_PRE(17)
    );
\TIM_PRE_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[18]_i_1_n_0\,
      Q => TIM_PRE(18)
    );
\TIM_PRE_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[19]_i_1_n_0\,
      Q => TIM_PRE(19)
    );
\TIM_PRE_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[1]_i_1_n_0\,
      Q => TIM_PRE(1)
    );
\TIM_PRE_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[20]_i_1_n_0\,
      Q => TIM_PRE(20)
    );
\TIM_PRE_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[21]_i_1_n_0\,
      Q => TIM_PRE(21)
    );
\TIM_PRE_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[22]_i_1_n_0\,
      Q => TIM_PRE(22)
    );
\TIM_PRE_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[23]_i_1_n_0\,
      Q => TIM_PRE(23)
    );
\TIM_PRE_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[24]_i_1_n_0\,
      Q => TIM_PRE(24)
    );
\TIM_PRE_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[25]_i_1_n_0\,
      Q => TIM_PRE(25)
    );
\TIM_PRE_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[26]_i_1_n_0\,
      Q => TIM_PRE(26)
    );
\TIM_PRE_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[27]_i_1_n_0\,
      Q => TIM_PRE(27)
    );
\TIM_PRE_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[28]_i_1_n_0\,
      Q => TIM_PRE(28)
    );
\TIM_PRE_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[29]_i_1_n_0\,
      Q => TIM_PRE(29)
    );
\TIM_PRE_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[2]_i_1_n_0\,
      Q => TIM_PRE(2)
    );
\TIM_PRE_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[30]_i_1_n_0\,
      Q => TIM_PRE(30)
    );
\TIM_PRE_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[31]_i_2_n_0\,
      Q => TIM_PRE(31)
    );
\TIM_PRE_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[3]_i_1_n_0\,
      Q => TIM_PRE(3)
    );
\TIM_PRE_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[4]_i_1_n_0\,
      Q => TIM_PRE(4)
    );
\TIM_PRE_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[5]_i_1_n_0\,
      Q => TIM_PRE(5)
    );
\TIM_PRE_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[6]_i_1_n_0\,
      Q => TIM_PRE(6)
    );
\TIM_PRE_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[7]_i_1_n_0\,
      Q => TIM_PRE(7)
    );
\TIM_PRE_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[8]_i_1_n_0\,
      Q => TIM_PRE(8)
    );
\TIM_PRE_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \TIM_PRE[31]_i_1_n_0\,
      CLR => wready_i_2_n_0,
      D => \TIM_PRE[9]_i_1_n_0\,
      Q => TIM_PRE(9)
    );
arready_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5540"
    )
        port map (
      I0 => arvalid,
      I1 => rready,
      I2 => \^rvalid\,
      I3 => \^arready\,
      O => arready_i_1_n_0
    );
arready_reg: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => arready_i_1_n_0,
      PRE => wready_i_2_n_0,
      Q => \^arready\
    );
bvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F444"
    )
        port map (
      I0 => bready,
      I1 => \^bvalid\,
      I2 => wvalid,
      I3 => awvalid,
      O => bvalid_i_1_n_0
    );
bvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => wready_i_2_n_0,
      D => bvalid_i_1_n_0,
      Q => \^bvalid\
    );
\i__carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(8),
      O => \i__carry__0_i_1_n_0\
    );
\i__carry__0_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(7),
      O => \i__carry__0_i_2_n_0\
    );
\i__carry__0_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(6),
      O => \i__carry__0_i_3_n_0\
    );
\i__carry__0_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(5),
      O => \i__carry__0_i_4_n_0\
    );
\i__carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(12),
      O => \i__carry__1_i_1_n_0\
    );
\i__carry__1_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(11),
      O => \i__carry__1_i_2_n_0\
    );
\i__carry__1_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(10),
      O => \i__carry__1_i_3_n_0\
    );
\i__carry__1_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(9),
      O => \i__carry__1_i_4_n_0\
    );
\i__carry__2_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(16),
      O => \i__carry__2_i_1_n_0\
    );
\i__carry__2_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(15),
      O => \i__carry__2_i_2_n_0\
    );
\i__carry__2_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(14),
      O => \i__carry__2_i_3_n_0\
    );
\i__carry__2_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(13),
      O => \i__carry__2_i_4_n_0\
    );
\i__carry__3_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(20),
      O => \i__carry__3_i_1_n_0\
    );
\i__carry__3_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(19),
      O => \i__carry__3_i_2_n_0\
    );
\i__carry__3_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(18),
      O => \i__carry__3_i_3_n_0\
    );
\i__carry__3_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(17),
      O => \i__carry__3_i_4_n_0\
    );
\i__carry__4_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(24),
      O => \i__carry__4_i_1_n_0\
    );
\i__carry__4_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(23),
      O => \i__carry__4_i_2_n_0\
    );
\i__carry__4_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(22),
      O => \i__carry__4_i_3_n_0\
    );
\i__carry__4_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(21),
      O => \i__carry__4_i_4_n_0\
    );
\i__carry__5_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(28),
      O => \i__carry__5_i_1_n_0\
    );
\i__carry__5_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(27),
      O => \i__carry__5_i_2_n_0\
    );
\i__carry__5_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(26),
      O => \i__carry__5_i_3_n_0\
    );
\i__carry__5_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(25),
      O => \i__carry__5_i_4_n_0\
    );
\i__carry__6_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(31),
      O => \i__carry__6_i_1_n_0\
    );
\i__carry__6_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(30),
      O => \i__carry__6_i_2_n_0\
    );
\i__carry__6_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(29),
      O => \i__carry__6_i_3_n_0\
    );
\i__carry_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(4),
      O => \i__carry_i_1_n_0\
    );
\i__carry_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(3),
      O => \i__carry_i_2_n_0\
    );
\i__carry_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(2),
      O => \i__carry_i_3_n_0\
    );
\i__carry_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => TIM_CNT(1),
      O => \i__carry_i_4_n_0\
    );
\rdata[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[0]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[0]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(0)
    );
\rdata[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(0),
      I1 => p_2_in,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[0]\,
      I5 => TIM_EVN(0),
      O => \rdata[0]_i_2_n_0\
    );
\rdata[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(0),
      I1 => p_3_in,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(0),
      I5 => \TIM_CLR_reg_n_0_[0]\,
      O => \rdata[0]_i_3_n_0\
    );
\rdata[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[10]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[10]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(10)
    );
\rdata[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(10),
      I1 => \TIM_EVC_reg_n_0_[10]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[10]\,
      I5 => TIM_EVN(10),
      O => \rdata[10]_i_2_n_0\
    );
\rdata[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(10),
      I1 => \TIM_ENA_reg_n_0_[10]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(10),
      I5 => \TIM_CLR_reg_n_0_[10]\,
      O => \rdata[10]_i_3_n_0\
    );
\rdata[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[11]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[11]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(11)
    );
\rdata[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(11),
      I1 => \TIM_EVC_reg_n_0_[11]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[11]\,
      I5 => TIM_EVN(11),
      O => \rdata[11]_i_2_n_0\
    );
\rdata[11]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(11),
      I1 => \TIM_ENA_reg_n_0_[11]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(11),
      I5 => \TIM_CLR_reg_n_0_[11]\,
      O => \rdata[11]_i_3_n_0\
    );
\rdata[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[12]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[12]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(12)
    );
\rdata[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(12),
      I1 => \TIM_EVC_reg_n_0_[12]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[12]\,
      I5 => TIM_EVN(12),
      O => \rdata[12]_i_2_n_0\
    );
\rdata[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(12),
      I1 => \TIM_ENA_reg_n_0_[12]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(12),
      I5 => \TIM_CLR_reg_n_0_[12]\,
      O => \rdata[12]_i_3_n_0\
    );
\rdata[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[13]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[13]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(13)
    );
\rdata[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(13),
      I1 => \TIM_EVC_reg_n_0_[13]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[13]\,
      I5 => TIM_EVN(13),
      O => \rdata[13]_i_2_n_0\
    );
\rdata[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(13),
      I1 => \TIM_ENA_reg_n_0_[13]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(13),
      I5 => \TIM_CLR_reg_n_0_[13]\,
      O => \rdata[13]_i_3_n_0\
    );
\rdata[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[14]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[14]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(14)
    );
\rdata[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(14),
      I1 => \TIM_EVC_reg_n_0_[14]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[14]\,
      I5 => TIM_EVN(14),
      O => \rdata[14]_i_2_n_0\
    );
\rdata[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(14),
      I1 => \TIM_ENA_reg_n_0_[14]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(14),
      I5 => \TIM_CLR_reg_n_0_[14]\,
      O => \rdata[14]_i_3_n_0\
    );
\rdata[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[15]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[15]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(15)
    );
\rdata[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(15),
      I1 => \TIM_EVC_reg_n_0_[15]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[15]\,
      I5 => TIM_EVN(15),
      O => \rdata[15]_i_2_n_0\
    );
\rdata[15]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(15),
      I1 => \TIM_ENA_reg_n_0_[15]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(15),
      I5 => \TIM_CLR_reg_n_0_[15]\,
      O => \rdata[15]_i_3_n_0\
    );
\rdata[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[16]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[16]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(16)
    );
\rdata[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(16),
      I1 => \TIM_EVC_reg_n_0_[16]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[16]\,
      I5 => TIM_EVN(16),
      O => \rdata[16]_i_2_n_0\
    );
\rdata[16]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(16),
      I1 => \TIM_ENA_reg_n_0_[16]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(16),
      I5 => \TIM_CLR_reg_n_0_[16]\,
      O => \rdata[16]_i_3_n_0\
    );
\rdata[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[17]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[17]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(17)
    );
\rdata[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(17),
      I1 => \TIM_EVC_reg_n_0_[17]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[17]\,
      I5 => TIM_EVN(17),
      O => \rdata[17]_i_2_n_0\
    );
\rdata[17]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(17),
      I1 => \TIM_ENA_reg_n_0_[17]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(17),
      I5 => \TIM_CLR_reg_n_0_[17]\,
      O => \rdata[17]_i_3_n_0\
    );
\rdata[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[18]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[18]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(18)
    );
\rdata[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(18),
      I1 => \TIM_EVC_reg_n_0_[18]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[18]\,
      I5 => TIM_EVN(18),
      O => \rdata[18]_i_2_n_0\
    );
\rdata[18]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(18),
      I1 => \TIM_ENA_reg_n_0_[18]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(18),
      I5 => \TIM_CLR_reg_n_0_[18]\,
      O => \rdata[18]_i_3_n_0\
    );
\rdata[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[19]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[19]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(19)
    );
\rdata[19]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(19),
      I1 => \TIM_EVC_reg_n_0_[19]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[19]\,
      I5 => TIM_EVN(19),
      O => \rdata[19]_i_2_n_0\
    );
\rdata[19]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(19),
      I1 => \TIM_ENA_reg_n_0_[19]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(19),
      I5 => \TIM_CLR_reg_n_0_[19]\,
      O => \rdata[19]_i_3_n_0\
    );
\rdata[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[1]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[1]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(1)
    );
\rdata[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(1),
      I1 => \TIM_EVC_reg_n_0_[1]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[1]\,
      I5 => TIM_EVN(1),
      O => \rdata[1]_i_2_n_0\
    );
\rdata[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(1),
      I1 => \TIM_ENA_reg_n_0_[1]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(1),
      I5 => \TIM_CLR_reg_n_0_[1]\,
      O => \rdata[1]_i_3_n_0\
    );
\rdata[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[20]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[20]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(20)
    );
\rdata[20]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(20),
      I1 => \TIM_EVC_reg_n_0_[20]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[20]\,
      I5 => TIM_EVN(20),
      O => \rdata[20]_i_2_n_0\
    );
\rdata[20]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(20),
      I1 => \TIM_ENA_reg_n_0_[20]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(20),
      I5 => \TIM_CLR_reg_n_0_[20]\,
      O => \rdata[20]_i_3_n_0\
    );
\rdata[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[21]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[21]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(21)
    );
\rdata[21]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(21),
      I1 => \TIM_EVC_reg_n_0_[21]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[21]\,
      I5 => TIM_EVN(21),
      O => \rdata[21]_i_2_n_0\
    );
\rdata[21]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(21),
      I1 => \TIM_ENA_reg_n_0_[21]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(21),
      I5 => \TIM_CLR_reg_n_0_[21]\,
      O => \rdata[21]_i_3_n_0\
    );
\rdata[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[22]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[22]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(22)
    );
\rdata[22]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(22),
      I1 => \TIM_EVC_reg_n_0_[22]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[22]\,
      I5 => TIM_EVN(22),
      O => \rdata[22]_i_2_n_0\
    );
\rdata[22]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(22),
      I1 => \TIM_ENA_reg_n_0_[22]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(22),
      I5 => \TIM_CLR_reg_n_0_[22]\,
      O => \rdata[22]_i_3_n_0\
    );
\rdata[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[23]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[23]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(23)
    );
\rdata[23]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(23),
      I1 => \TIM_EVC_reg_n_0_[23]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[23]\,
      I5 => TIM_EVN(23),
      O => \rdata[23]_i_2_n_0\
    );
\rdata[23]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(23),
      I1 => \TIM_ENA_reg_n_0_[23]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(23),
      I5 => \TIM_CLR_reg_n_0_[23]\,
      O => \rdata[23]_i_3_n_0\
    );
\rdata[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[24]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[24]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(24)
    );
\rdata[24]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(24),
      I1 => \TIM_EVC_reg_n_0_[24]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[24]\,
      I5 => TIM_EVN(24),
      O => \rdata[24]_i_2_n_0\
    );
\rdata[24]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(24),
      I1 => \TIM_ENA_reg_n_0_[24]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(24),
      I5 => \TIM_CLR_reg_n_0_[24]\,
      O => \rdata[24]_i_3_n_0\
    );
\rdata[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[25]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[25]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(25)
    );
\rdata[25]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(25),
      I1 => \TIM_EVC_reg_n_0_[25]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[25]\,
      I5 => TIM_EVN(25),
      O => \rdata[25]_i_2_n_0\
    );
\rdata[25]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(25),
      I1 => \TIM_ENA_reg_n_0_[25]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(25),
      I5 => \TIM_CLR_reg_n_0_[25]\,
      O => \rdata[25]_i_3_n_0\
    );
\rdata[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[26]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[26]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(26)
    );
\rdata[26]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(26),
      I1 => \TIM_EVC_reg_n_0_[26]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[26]\,
      I5 => TIM_EVN(26),
      O => \rdata[26]_i_2_n_0\
    );
\rdata[26]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(26),
      I1 => \TIM_ENA_reg_n_0_[26]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(26),
      I5 => \TIM_CLR_reg_n_0_[26]\,
      O => \rdata[26]_i_3_n_0\
    );
\rdata[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[27]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[27]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(27)
    );
\rdata[27]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(27),
      I1 => \TIM_EVC_reg_n_0_[27]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[27]\,
      I5 => TIM_EVN(27),
      O => \rdata[27]_i_2_n_0\
    );
\rdata[27]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(27),
      I1 => \TIM_ENA_reg_n_0_[27]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(27),
      I5 => \TIM_CLR_reg_n_0_[27]\,
      O => \rdata[27]_i_3_n_0\
    );
\rdata[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[28]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[28]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(28)
    );
\rdata[28]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(28),
      I1 => \TIM_EVC_reg_n_0_[28]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[28]\,
      I5 => TIM_EVN(28),
      O => \rdata[28]_i_2_n_0\
    );
\rdata[28]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(28),
      I1 => \TIM_ENA_reg_n_0_[28]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(28),
      I5 => \TIM_CLR_reg_n_0_[28]\,
      O => \rdata[28]_i_3_n_0\
    );
\rdata[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[29]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[29]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(29)
    );
\rdata[29]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(29),
      I1 => \TIM_EVC_reg_n_0_[29]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[29]\,
      I5 => TIM_EVN(29),
      O => \rdata[29]_i_2_n_0\
    );
\rdata[29]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(29),
      I1 => \TIM_ENA_reg_n_0_[29]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(29),
      I5 => \TIM_CLR_reg_n_0_[29]\,
      O => \rdata[29]_i_3_n_0\
    );
\rdata[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[2]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[2]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(2)
    );
\rdata[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(2),
      I1 => \TIM_EVC_reg_n_0_[2]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[2]\,
      I5 => TIM_EVN(2),
      O => \rdata[2]_i_2_n_0\
    );
\rdata[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(2),
      I1 => \TIM_ENA_reg_n_0_[2]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(2),
      I5 => \TIM_CLR_reg_n_0_[2]\,
      O => \rdata[2]_i_3_n_0\
    );
\rdata[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[30]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[30]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(30)
    );
\rdata[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(30),
      I1 => \TIM_EVC_reg_n_0_[30]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[30]\,
      I5 => TIM_EVN(30),
      O => \rdata[30]_i_2_n_0\
    );
\rdata[30]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(30),
      I1 => \TIM_ENA_reg_n_0_[30]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(30),
      I5 => \TIM_CLR_reg_n_0_[30]\,
      O => \rdata[30]_i_3_n_0\
    );
\rdata[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[31]_i_4_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(31)
    );
\rdata[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(31),
      I1 => \TIM_EVC_reg_n_0_[31]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[31]\,
      I5 => TIM_EVN(31),
      O => \rdata[31]_i_2_n_0\
    );
\rdata[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
        port map (
      I0 => araddr(5),
      I1 => araddr(6),
      I2 => araddr(7),
      I3 => araddr(1),
      I4 => araddr(4),
      I5 => araddr(0),
      O => \rdata[31]_i_3_n_0\
    );
\rdata[31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(31),
      I1 => \TIM_ENA_reg_n_0_[31]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(31),
      I5 => \TIM_CLR_reg_n_0_[31]\,
      O => \rdata[31]_i_4_n_0\
    );
\rdata[31]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => araddr(5),
      I1 => araddr(6),
      I2 => araddr(7),
      I3 => araddr(1),
      I4 => araddr(4),
      I5 => araddr(0),
      O => \rdata[31]_i_5_n_0\
    );
\rdata[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[3]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[3]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(3)
    );
\rdata[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(3),
      I1 => \TIM_EVC_reg_n_0_[3]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[3]\,
      I5 => TIM_EVN(3),
      O => \rdata[3]_i_2_n_0\
    );
\rdata[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(3),
      I1 => \TIM_ENA_reg_n_0_[3]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(3),
      I5 => \TIM_CLR_reg_n_0_[3]\,
      O => \rdata[3]_i_3_n_0\
    );
\rdata[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[4]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[4]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(4)
    );
\rdata[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(4),
      I1 => \TIM_EVC_reg_n_0_[4]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[4]\,
      I5 => TIM_EVN(4),
      O => \rdata[4]_i_2_n_0\
    );
\rdata[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(4),
      I1 => \TIM_ENA_reg_n_0_[4]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(4),
      I5 => \TIM_CLR_reg_n_0_[4]\,
      O => \rdata[4]_i_3_n_0\
    );
\rdata[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[5]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[5]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(5)
    );
\rdata[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(5),
      I1 => \TIM_EVC_reg_n_0_[5]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[5]\,
      I5 => TIM_EVN(5),
      O => \rdata[5]_i_2_n_0\
    );
\rdata[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(5),
      I1 => \TIM_ENA_reg_n_0_[5]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(5),
      I5 => \TIM_CLR_reg_n_0_[5]\,
      O => \rdata[5]_i_3_n_0\
    );
\rdata[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[6]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[6]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(6)
    );
\rdata[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(6),
      I1 => \TIM_EVC_reg_n_0_[6]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[6]\,
      I5 => TIM_EVN(6),
      O => \rdata[6]_i_2_n_0\
    );
\rdata[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(6),
      I1 => \TIM_ENA_reg_n_0_[6]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(6),
      I5 => \TIM_CLR_reg_n_0_[6]\,
      O => \rdata[6]_i_3_n_0\
    );
\rdata[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[7]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[7]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(7)
    );
\rdata[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(7),
      I1 => \TIM_EVC_reg_n_0_[7]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[7]\,
      I5 => TIM_EVN(7),
      O => \rdata[7]_i_2_n_0\
    );
\rdata[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(7),
      I1 => \TIM_ENA_reg_n_0_[7]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(7),
      I5 => \TIM_CLR_reg_n_0_[7]\,
      O => \rdata[7]_i_3_n_0\
    );
\rdata[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[8]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[8]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(8)
    );
\rdata[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(8),
      I1 => \TIM_EVC_reg_n_0_[8]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[8]\,
      I5 => TIM_EVN(8),
      O => \rdata[8]_i_2_n_0\
    );
\rdata[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(8),
      I1 => \TIM_ENA_reg_n_0_[8]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(8),
      I5 => \TIM_CLR_reg_n_0_[8]\,
      O => \rdata[8]_i_3_n_0\
    );
\rdata[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \rdata[9]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => \rdata[9]_i_3_n_0\,
      I3 => \rdata[31]_i_5_n_0\,
      O => p_0_in(9)
    );
\rdata[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_CNT(9),
      I1 => \TIM_EVC_reg_n_0_[9]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => \TIM_MOD_reg_n_0_[9]\,
      I5 => TIM_EVN(9),
      O => \rdata[9]_i_2_n_0\
    );
\rdata[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => TIM_ARE(9),
      I1 => \TIM_ENA_reg_n_0_[9]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => TIM_PRE_m(9),
      I5 => \TIM_CLR_reg_n_0_[9]\,
      O => \rdata[9]_i_3_n_0\
    );
\rdata_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(0),
      Q => rdata(0)
    );
\rdata_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(10),
      Q => rdata(10)
    );
\rdata_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(11),
      Q => rdata(11)
    );
\rdata_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(12),
      Q => rdata(12)
    );
\rdata_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(13),
      Q => rdata(13)
    );
\rdata_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(14),
      Q => rdata(14)
    );
\rdata_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(15),
      Q => rdata(15)
    );
\rdata_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(16),
      Q => rdata(16)
    );
\rdata_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(17),
      Q => rdata(17)
    );
\rdata_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(18),
      Q => rdata(18)
    );
\rdata_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(19),
      Q => rdata(19)
    );
\rdata_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(1),
      Q => rdata(1)
    );
\rdata_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(20),
      Q => rdata(20)
    );
\rdata_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(21),
      Q => rdata(21)
    );
\rdata_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(22),
      Q => rdata(22)
    );
\rdata_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(23),
      Q => rdata(23)
    );
\rdata_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(24),
      Q => rdata(24)
    );
\rdata_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(25),
      Q => rdata(25)
    );
\rdata_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(26),
      Q => rdata(26)
    );
\rdata_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(27),
      Q => rdata(27)
    );
\rdata_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(28),
      Q => rdata(28)
    );
\rdata_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(29),
      Q => rdata(29)
    );
\rdata_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(2),
      Q => rdata(2)
    );
\rdata_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(30),
      Q => rdata(30)
    );
\rdata_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(31),
      Q => rdata(31)
    );
\rdata_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(3),
      Q => rdata(3)
    );
\rdata_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(4),
      Q => rdata(4)
    );
\rdata_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(5),
      Q => rdata(5)
    );
\rdata_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(6),
      Q => rdata(6)
    );
\rdata_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(7),
      Q => rdata(7)
    );
\rdata_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(8),
      Q => rdata(8)
    );
\rdata_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => wready_i_2_n_0,
      D => p_0_in(9),
      Q => rdata(9)
    );
rvalid_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => arvalid,
      I1 => rready,
      I2 => \^rvalid\,
      O => rvalid_i_1_n_0
    );
rvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => wready_i_2_n_0,
      D => rvalid_i_1_n_0,
      Q => \^rvalid\
    );
wready_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FFF0888"
    )
        port map (
      I0 => bready,
      I1 => \^bvalid\,
      I2 => wvalid,
      I3 => awvalid,
      I4 => \^wready\,
      O => wready_i_1_n_0
    );
wready_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst_n,
      O => wready_i_2_n_0
    );
wready_reg: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => wready_i_1_n_0,
      PRE => wready_i_2_n_0,
      Q => \^wready\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Timer_module_0_0 is
  port (
    clk_i : in STD_LOGIC;
    rst_n : in STD_LOGIC;
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
  attribute NotValidForBitStream of design_1_Timer_module_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_Timer_module_0_0 : entity is "design_1_Timer_module_0_0,Timer_module,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_Timer_module_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_Timer_module_0_0 : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_Timer_module_0_0 : entity is "Timer_module,Vivado 2025.2";
end design_1_Timer_module_0_0;

architecture STRUCTURE of design_1_Timer_module_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of arready : signal is "xilinx.com:interface:aximm:1.0 interface_aximm ARREADY";
  attribute X_INTERFACE_INFO of arvalid : signal is "xilinx.com:interface:aximm:1.0 interface_aximm ARVALID";
  attribute X_INTERFACE_INFO of awready : signal is "xilinx.com:interface:aximm:1.0 interface_aximm AWREADY";
  attribute X_INTERFACE_INFO of awvalid : signal is "xilinx.com:interface:aximm:1.0 interface_aximm AWVALID";
  attribute X_INTERFACE_INFO of bready : signal is "xilinx.com:interface:aximm:1.0 interface_aximm BREADY";
  attribute X_INTERFACE_INFO of bvalid : signal is "xilinx.com:interface:aximm:1.0 interface_aximm BVALID";
  attribute X_INTERFACE_INFO of clk_i : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk_i : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk_i : signal is "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF interface_aximm, FREQ_TOLERANCE_HZ 0, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
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
  awready <= \<const1>\;
  bresp(1) <= \<const0>\;
  bresp(0) <= \<const0>\;
  rresp(1) <= \<const0>\;
  rresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.design_1_Timer_module_0_0_Timer_module
     port map (
      araddr(7 downto 0) => araddr(7 downto 0),
      arready => arready,
      arvalid => arvalid,
      awaddr(7 downto 0) => awaddr(7 downto 0),
      awvalid => awvalid,
      bready => bready,
      bvalid => bvalid,
      clk_i => clk_i,
      rdata(31 downto 0) => rdata(31 downto 0),
      rready => rready,
      rst_n => rst_n,
      rvalid => rvalid,
      wdata(31 downto 0) => wdata(31 downto 0),
      wready => wready,
      wvalid => wvalid
    );
end STRUCTURE;
