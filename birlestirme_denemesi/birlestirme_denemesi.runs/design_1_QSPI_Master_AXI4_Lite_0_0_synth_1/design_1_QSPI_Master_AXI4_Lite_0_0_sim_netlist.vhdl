-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
-- Date        : Sat May  9 17:15:06 2026
-- Host        : Stradale running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_QSPI_Master_AXI4_Lite_0_0_sim_netlist.vhdl
-- Design      : design_1_QSPI_Master_AXI4_Lite_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_QSPI_Master_AXI4_Lite is
  port (
    rst_n_0 : out STD_LOGIC;
    bvalid : out STD_LOGIC;
    awready : out STD_LOGIC;
    rvalid : out STD_LOGIC;
    arready : out STD_LOGIC;
    QSPI_CS_reg_0 : out STD_LOGIC;
    QSPI_SCLK_reg_0 : out STD_LOGIC;
    \fifo_status_reg[1]_0\ : out STD_LOGIC;
    QSPI_IO2_INST_0_i_1 : out STD_LOGIC;
    QSPI_IO1_INST_0_i_1 : out STD_LOGIC;
    rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    QSPI_IO0 : inout STD_LOGIC;
    QSPI_IO1 : inout STD_LOGIC;
    QSPI_IO2 : inout STD_LOGIC;
    QSPI_IO3 : inout STD_LOGIC;
    clk_i : in STD_LOGIC;
    wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rst_n : in STD_LOGIC;
    wvalid : in STD_LOGIC;
    awvalid : in STD_LOGIC;
    bready : in STD_LOGIC;
    arvalid : in STD_LOGIC;
    rready : in STD_LOGIC;
    QSPI_IO0_INST_0_i_1 : in STD_LOGIC;
    QSPI_IO2_INST_0_i_1_0 : in STD_LOGIC;
    QSPI_IO1_INST_0_i_1_0 : in STD_LOGIC;
    araddr : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_QSPI_Master_AXI4_Lite;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_QSPI_Master_AXI4_Lite is
  signal QSPI_ADR : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \QSPI_ADR_reg_n_0_[0]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[10]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[11]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[12]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[13]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[14]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[15]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[16]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[17]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[18]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[19]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[1]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[20]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[21]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[22]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[23]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[24]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[25]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[26]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[27]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[28]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[29]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[2]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[30]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[31]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[3]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[4]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[5]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[6]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[7]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[8]\ : STD_LOGIC;
  signal \QSPI_ADR_reg_n_0_[9]\ : STD_LOGIC;
  signal QSPI_CCR : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \QSPI_CCR[31]_i_2_n_0\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[0]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[10]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[11]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[12]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[13]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[14]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[15]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[16]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[17]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[18]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[19]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[1]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[20]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[21]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[22]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[23]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[24]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[2]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[3]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[4]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[5]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[6]\ : STD_LOGIC;
  signal \QSPI_CCR_reg_n_0_[7]\ : STD_LOGIC;
  signal QSPI_CS_i_1_n_0 : STD_LOGIC;
  signal QSPI_CS_i_2_n_0 : STD_LOGIC;
  signal \^qspi_cs_reg_0\ : STD_LOGIC;
  signal QSPI_DR : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \QSPI_DR[31]_i_2_n_0\ : STD_LOGIC;
  signal \QSPI_DR_read[31]_i_1_n_0\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[0]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[10]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[11]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[12]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[13]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[14]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[15]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[16]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[17]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[18]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[19]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[1]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[20]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[21]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[22]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[23]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[24]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[25]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[26]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[27]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[28]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[29]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[2]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[30]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[31]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[3]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[4]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[5]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[6]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[7]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[8]\ : STD_LOGIC;
  signal \QSPI_DR_read_reg_n_0_[9]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[0]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[10]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[11]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[12]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[13]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[14]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[15]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[16]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[17]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[18]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[19]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[1]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[20]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[21]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[22]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[23]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[24]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[25]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[26]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[27]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[28]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[29]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[2]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[30]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[31]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[3]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[4]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[5]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[6]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[7]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[8]\ : STD_LOGIC;
  signal \QSPI_DR_reg_n_0_[9]\ : STD_LOGIC;
  signal QSPI_FCR : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \QSPI_FCR_reg_n_0_[10]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[11]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[12]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[13]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[14]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[15]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[16]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[17]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[18]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[19]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[1]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[20]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[21]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[22]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[23]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[24]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[25]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[26]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[27]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[28]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[29]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[2]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[30]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[31]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[3]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[4]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[5]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[6]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[7]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[8]\ : STD_LOGIC;
  signal \QSPI_FCR_reg_n_0_[9]\ : STD_LOGIC;
  signal QSPI_IO1_INST_0_i_3_n_0 : STD_LOGIC;
  signal QSPI_SCLK_i_1_n_0 : STD_LOGIC;
  signal \^qspi_sclk_reg_0\ : STD_LOGIC;
  signal \QSPI_STA[1]_i_1_n_0\ : STD_LOGIC;
  signal \QSPI_STA[4]_i_1_n_0\ : STD_LOGIC;
  signal \QSPI_STA[5]_i_1_n_0\ : STD_LOGIC;
  signal \QSPI_STA[6]_i_1_n_0\ : STD_LOGIC;
  signal \QSPI_STA[7]_i_1_n_0\ : STD_LOGIC;
  signal \QSPI_STA[8]_i_1_n_0\ : STD_LOGIC;
  signal \QSPI_STA[9]_i_1_n_0\ : STD_LOGIC;
  signal \QSPI_STA_reg_n_0_[1]\ : STD_LOGIC;
  signal \QSPI_STA_reg_n_0_[4]\ : STD_LOGIC;
  signal \QSPI_STA_reg_n_0_[5]\ : STD_LOGIC;
  signal \QSPI_STA_reg_n_0_[7]\ : STD_LOGIC;
  signal \QSPI_STA_reg_n_0_[8]\ : STD_LOGIC;
  signal \QSPI_STA_reg_n_0_[9]\ : STD_LOGIC;
  signal address : STD_LOGIC;
  signal address_i_1_n_0 : STD_LOGIC;
  signal address_i_2_n_0 : STD_LOGIC;
  signal \^arready\ : STD_LOGIC;
  signal arready_i_1_n_0 : STD_LOGIC;
  signal \^awready\ : STD_LOGIC;
  signal awready_i_1_n_0 : STD_LOGIC;
  signal busy0 : STD_LOGIC;
  signal busy_i_1_n_0 : STD_LOGIC;
  signal \^bvalid\ : STD_LOGIC;
  signal bvalid_i_1_n_0 : STD_LOGIC;
  signal data2 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \data_byte_size[0]_i_1_n_0\ : STD_LOGIC;
  signal \data_byte_size[1]_i_1_n_0\ : STD_LOGIC;
  signal \data_byte_size[2]_i_1_n_0\ : STD_LOGIC;
  signal \data_byte_size[3]_i_1_n_0\ : STD_LOGIC;
  signal \data_byte_size[3]_i_2_n_0\ : STD_LOGIC;
  signal \data_byte_size[4]_i_1_n_0\ : STD_LOGIC;
  signal \data_byte_size[4]_i_2_n_0\ : STD_LOGIC;
  signal \data_byte_size[5]_i_1_n_0\ : STD_LOGIC;
  signal \data_byte_size[5]_i_2_n_0\ : STD_LOGIC;
  signal \data_byte_size[6]_i_1_n_0\ : STD_LOGIC;
  signal \data_byte_size[6]_i_2_n_0\ : STD_LOGIC;
  signal \data_byte_size[7]_i_1_n_0\ : STD_LOGIC;
  signal \data_byte_size[7]_i_2_n_0\ : STD_LOGIC;
  signal \data_byte_size[7]_i_3_n_0\ : STD_LOGIC;
  signal \data_byte_size[7]_i_4_n_0\ : STD_LOGIC;
  signal \data_byte_size[7]_i_5_n_0\ : STD_LOGIC;
  signal \data_mode[0]_i_1_n_0\ : STD_LOGIC;
  signal \data_mode[1]_i_1_n_0\ : STD_LOGIC;
  signal \data_mode[2]_i_1_n_0\ : STD_LOGIC;
  signal \data_mode[2]_i_2_n_0\ : STD_LOGIC;
  signal \data_mode__0\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \dummy_cycle[0]_i_1_n_0\ : STD_LOGIC;
  signal \dummy_cycle[1]_i_1_n_0\ : STD_LOGIC;
  signal \dummy_cycle[2]_i_1_n_0\ : STD_LOGIC;
  signal \dummy_cycle[3]_i_1_n_0\ : STD_LOGIC;
  signal \dummy_cycle[4]_i_1_n_0\ : STD_LOGIC;
  signal \dummy_cycle[4]_i_2_n_0\ : STD_LOGIC;
  signal \dummy_cycle[4]_i_3_n_0\ : STD_LOGIC;
  signal \dummy_cycle[4]_i_4_n_0\ : STD_LOGIC;
  signal \dummy_cycle[4]_i_5_n_0\ : STD_LOGIC;
  signal \dummy_cycle__0\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal fifo_error : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \fifo_error[0]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_error[1]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[4]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[4]_i_2_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[4]_i_3_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[5]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[5]_i_2_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[5]_i_3_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[6]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[6]_i_2_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[6]_i_3_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt[6]_i_4_n_0\ : STD_LOGIC;
  signal \fifo_rx_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \fifo_rx_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \fifo_rx_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal \fifo_rx_cnt_reg_n_0_[3]\ : STD_LOGIC;
  signal \fifo_rx_cnt_reg_n_0_[4]\ : STD_LOGIC;
  signal \fifo_rx_cnt_reg_n_0_[5]\ : STD_LOGIC;
  signal \fifo_rx_cnt_reg_n_0_[6]\ : STD_LOGIC;
  signal fifo_rx_pull_data : STD_LOGIC;
  signal fifo_rx_pull_data_i_1_n_0 : STD_LOGIC;
  signal fifo_rx_rdata : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fifo_rx_rdata0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fifo_rx_wdata : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \fifo_rx_wdata[31]_i_1_n_0\ : STD_LOGIC;
  signal fifo_rx_wr_en : STD_LOGIC;
  signal fifo_rx_wr_en_i_1_n_0 : STD_LOGIC;
  signal \fifo_status[0]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_status[1]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_status[1]_i_2_n_0\ : STD_LOGIC;
  signal \fifo_status[1]_i_3_n_0\ : STD_LOGIC;
  signal \fifo_status_reg_n_0_[0]\ : STD_LOGIC;
  signal \fifo_status_reg_n_0_[1]\ : STD_LOGIC;
  signal \fifo_tx_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[4]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[4]_i_2_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[4]_i_3_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[5]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[5]_i_2_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[5]_i_3_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[6]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[6]_i_2_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[6]_i_3_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt[6]_i_4_n_0\ : STD_LOGIC;
  signal \fifo_tx_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \fifo_tx_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \fifo_tx_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal \fifo_tx_cnt_reg_n_0_[3]\ : STD_LOGIC;
  signal \fifo_tx_cnt_reg_n_0_[4]\ : STD_LOGIC;
  signal \fifo_tx_cnt_reg_n_0_[5]\ : STD_LOGIC;
  signal \fifo_tx_cnt_reg_n_0_[6]\ : STD_LOGIC;
  signal fifo_tx_push_data : STD_LOGIC;
  signal fifo_tx_push_data_i_1_n_0 : STD_LOGIC;
  signal fifo_tx_rdata : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fifo_tx_rdata0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal fifo_tx_wdata : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \fifo_tx_wdata[31]_i_1_n_0\ : STD_LOGIC;
  signal fifo_tx_wr_en : STD_LOGIC;
  signal fifo_tx_wr_en0 : STD_LOGIC;
  signal fifo_tx_wr_en_i_1_n_0 : STD_LOGIC;
  signal instr_shadow : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \instr_shadow[7]_i_1_n_0\ : STD_LOGIC;
  signal \instr_shadow[7]_i_2_n_0\ : STD_LOGIC;
  signal \instr_shadow[7]_i_3_n_0\ : STD_LOGIC;
  signal \instr_shadow[7]_i_4_n_0\ : STD_LOGIC;
  signal io0_val_tristate_oe_i_1_n_0 : STD_LOGIC;
  signal io0_val_tristate_oe_i_2_n_0 : STD_LOGIC;
  signal io0_val_tristate_oe_i_3_n_0 : STD_LOGIC;
  signal io0_val_tristate_oe_i_4_n_0 : STD_LOGIC;
  signal io0_val_tristate_oe_reg_n_0 : STD_LOGIC;
  signal io1_val_tristate_oe_i_1_n_0 : STD_LOGIC;
  signal io1_val_tristate_oe_i_2_n_0 : STD_LOGIC;
  signal io1_val_tristate_oe_i_3_n_0 : STD_LOGIC;
  signal io1_val_tristate_oe_reg_n_0 : STD_LOGIC;
  signal io2_val_tristate_oe_i_1_n_0 : STD_LOGIC;
  signal io2_val_tristate_oe_i_2_n_0 : STD_LOGIC;
  signal io2_val_tristate_oe_i_3_n_0 : STD_LOGIC;
  signal io2_val_tristate_oe_reg_n_0 : STD_LOGIC;
  signal io3_val_tristate_oe_i_1_n_0 : STD_LOGIC;
  signal io3_val_tristate_oe_reg_n_0 : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal p_0_in0 : STD_LOGIC;
  signal p_0_in27_in : STD_LOGIC;
  signal p_0_in_0 : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_11_in : STD_LOGIC;
  signal p_1_in : STD_LOGIC;
  signal p_2_in : STD_LOGIC_VECTOR ( 1 to 1 );
  signal prscl_cnt1 : STD_LOGIC;
  signal \prscl_cnt1_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \prscl_cnt1_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \prscl_cnt1_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \prscl_cnt1_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \prscl_cnt1_carry__0_n_0\ : STD_LOGIC;
  signal \prscl_cnt1_carry__0_n_1\ : STD_LOGIC;
  signal \prscl_cnt1_carry__0_n_2\ : STD_LOGIC;
  signal \prscl_cnt1_carry__0_n_3\ : STD_LOGIC;
  signal \prscl_cnt1_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \prscl_cnt1_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \prscl_cnt1_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \prscl_cnt1_carry__1_n_2\ : STD_LOGIC;
  signal \prscl_cnt1_carry__1_n_3\ : STD_LOGIC;
  signal prscl_cnt1_carry_i_1_n_0 : STD_LOGIC;
  signal prscl_cnt1_carry_i_2_n_0 : STD_LOGIC;
  signal prscl_cnt1_carry_i_3_n_0 : STD_LOGIC;
  signal prscl_cnt1_carry_i_4_n_0 : STD_LOGIC;
  signal prscl_cnt1_carry_i_5_n_0 : STD_LOGIC;
  signal prscl_cnt1_carry_i_6_n_0 : STD_LOGIC;
  signal prscl_cnt1_carry_i_7_n_0 : STD_LOGIC;
  signal prscl_cnt1_carry_n_0 : STD_LOGIC;
  signal prscl_cnt1_carry_n_1 : STD_LOGIC;
  signal prscl_cnt1_carry_n_2 : STD_LOGIC;
  signal prscl_cnt1_carry_n_3 : STD_LOGIC;
  signal \prscl_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \prscl_cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal \prscl_cnt[4]_i_1_n_0\ : STD_LOGIC;
  signal \prscl_cnt[5]_i_1_n_0\ : STD_LOGIC;
  signal \prscl_cnt[5]_i_2_n_0\ : STD_LOGIC;
  signal prscl_cnt_reg : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal qspi_falling_edge : STD_LOGIC;
  signal qspi_falling_edge_i_2_n_0 : STD_LOGIC;
  signal qspi_falling_edge_i_3_n_0 : STD_LOGIC;
  signal qspi_falling_edge_i_4_n_0 : STD_LOGIC;
  signal qspi_falling_edge_i_5_n_0 : STD_LOGIC;
  signal qspi_falling_edge_i_6_n_0 : STD_LOGIC;
  signal qspi_falling_edge_i_7_n_0 : STD_LOGIC;
  signal qspi_rising_edge : STD_LOGIC;
  signal qspi_rising_edge_i_1_n_0 : STD_LOGIC;
  signal r_w_i_1_n_0 : STD_LOGIC;
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
  signal \^rst_n_0\ : STD_LOGIC;
  signal \^rvalid\ : STD_LOGIC;
  signal rvalid_i_1_n_0 : STD_LOGIC;
  signal rx_pull_once_i_1_n_0 : STD_LOGIC;
  signal rx_pull_once_reg_n_0 : STD_LOGIC;
  signal rx_rd_ptr : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \rx_rd_ptr[0]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[1]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[2]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[3]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[4]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[4]_i_2_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[5]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[5]_i_2_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[5]_i_3_n_0\ : STD_LOGIC;
  signal rx_wr_ptr : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \rx_wr_ptr[0]_i_1_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[1]_i_1_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[2]_i_1_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[3]_i_1_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[4]_i_1_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[5]_i_1_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[5]_i_2_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[5]_i_3_n_0\ : STD_LOGIC;
  signal sel0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal shift_byte : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \shift_byte[0]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[10]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[10]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[11]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[11]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[12]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[12]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[13]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[13]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[14]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[14]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[15]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[15]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[16]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[16]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[17]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[17]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[18]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[18]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[19]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[19]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[1]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[1]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[20]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[20]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[21]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[21]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[22]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[22]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[23]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[23]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[24]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[24]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[24]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[24]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[25]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[25]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[25]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[26]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[26]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[26]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[27]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[27]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[27]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[28]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[28]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[28]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[29]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[29]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[29]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[2]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[2]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[30]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[30]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[30]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[31]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[31]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[31]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[31]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[3]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[3]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[4]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[4]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[5]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[5]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[6]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[6]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_3_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_4_n_0\ : STD_LOGIC;
  signal \shift_byte[7]_i_5_n_0\ : STD_LOGIC;
  signal \shift_byte[8]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[8]_i_2_n_0\ : STD_LOGIC;
  signal \shift_byte[9]_i_1_n_0\ : STD_LOGIC;
  signal \shift_byte[9]_i_2_n_0\ : STD_LOGIC;
  signal \shift_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \shift_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \shift_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \shift_cnt[2]_i_2_n_0\ : STD_LOGIC;
  signal \shift_cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal \shift_cnt[3]_i_2_n_0\ : STD_LOGIC;
  signal \shift_cnt[3]_i_3_n_0\ : STD_LOGIC;
  signal \shift_cnt[4]_i_1_n_0\ : STD_LOGIC;
  signal \shift_cnt[4]_i_2_n_0\ : STD_LOGIC;
  signal \shift_cnt[5]_i_1_n_0\ : STD_LOGIC;
  signal \shift_cnt[5]_i_2_n_0\ : STD_LOGIC;
  signal \shift_cnt[5]_i_3_n_0\ : STD_LOGIC;
  signal \shift_cnt[5]_i_4_n_0\ : STD_LOGIC;
  signal \shift_cnt[5]_i_5_n_0\ : STD_LOGIC;
  signal \shift_cnt__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \to_do_list[0]_i_1_n_0\ : STD_LOGIC;
  signal \to_do_list[0]_i_2_n_0\ : STD_LOGIC;
  signal \to_do_list[0]_i_3_n_0\ : STD_LOGIC;
  signal \to_do_list[0]_i_4_n_0\ : STD_LOGIC;
  signal \to_do_list[1]_i_1_n_0\ : STD_LOGIC;
  signal \to_do_list[1]_i_2_n_0\ : STD_LOGIC;
  signal \to_do_list[1]_i_3_n_0\ : STD_LOGIC;
  signal \to_do_list[2]_i_1_n_0\ : STD_LOGIC;
  signal \to_do_list[2]_i_2_n_0\ : STD_LOGIC;
  signal \to_do_list[2]_i_3_n_0\ : STD_LOGIC;
  signal \to_do_list[2]_i_4_n_0\ : STD_LOGIC;
  signal \to_do_list[2]_i_5_n_0\ : STD_LOGIC;
  signal \to_do_list[2]_i_6_n_0\ : STD_LOGIC;
  signal \to_do_list[2]_i_7_n_0\ : STD_LOGIC;
  signal \to_do_list[3]_i_1_n_0\ : STD_LOGIC;
  signal \to_do_list[3]_i_2_n_0\ : STD_LOGIC;
  signal \to_do_list[3]_i_3_n_0\ : STD_LOGIC;
  signal \to_do_list_reg_n_0_[0]\ : STD_LOGIC;
  signal \to_do_list_reg_n_0_[1]\ : STD_LOGIC;
  signal \to_do_list_reg_n_0_[2]\ : STD_LOGIC;
  signal \to_do_list_reg_n_0_[3]\ : STD_LOGIC;
  signal tx_rd_ptr : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \tx_rd_ptr[0]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[1]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[2]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[3]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[4]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[5]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[5]_i_2_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[5]_i_3_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[5]_i_4_n_0\ : STD_LOGIC;
  signal tx_wr_ptr : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \tx_wr_ptr[0]_i_1_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[1]_i_1_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[2]_i_1_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[3]_i_1_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[4]_i_1_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[5]_i_1_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[5]_i_2_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[5]_i_3_n_0\ : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_12_14_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_15_17_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_18_20_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_21_23_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_24_26_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_27_29_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_30_31_DOC_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_30_31_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_RX_reg_0_63_9_11_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_12_14_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_15_17_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_18_20_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_21_23_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_24_26_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_27_29_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_30_31_DOC_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_30_31_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_FIFO_TX_reg_0_63_9_11_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_prscl_cnt1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_prscl_cnt1_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_prscl_cnt1_carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_prscl_cnt1_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_0_2 : label is "";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_0_2 : label is 2048;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_0_2 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE : string;
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_0_2 : label is "distributed";
  attribute RTL_RAM_TYPE : string;
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_0_2 : label is "RAM_SDP";
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of FIFO_RX_reg_0_63_0_2 : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of FIFO_RX_reg_0_63_0_2 : label is 63;
  attribute ram_offset : integer;
  attribute ram_offset of FIFO_RX_reg_0_63_0_2 : label is 0;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_0_2 : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of FIFO_RX_reg_0_63_0_2 : label is 2;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_12_14 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_12_14 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_12_14 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_12_14 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_12_14 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_12_14 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_12_14 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_12_14 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_12_14 : label is 12;
  attribute ram_slice_end of FIFO_RX_reg_0_63_12_14 : label is 14;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_15_17 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_15_17 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_15_17 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_15_17 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_15_17 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_15_17 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_15_17 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_15_17 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_15_17 : label is 15;
  attribute ram_slice_end of FIFO_RX_reg_0_63_15_17 : label is 17;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_18_20 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_18_20 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_18_20 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_18_20 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_18_20 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_18_20 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_18_20 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_18_20 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_18_20 : label is 18;
  attribute ram_slice_end of FIFO_RX_reg_0_63_18_20 : label is 20;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_21_23 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_21_23 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_21_23 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_21_23 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_21_23 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_21_23 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_21_23 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_21_23 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_21_23 : label is 21;
  attribute ram_slice_end of FIFO_RX_reg_0_63_21_23 : label is 23;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_24_26 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_24_26 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_24_26 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_24_26 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_24_26 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_24_26 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_24_26 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_24_26 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_24_26 : label is 24;
  attribute ram_slice_end of FIFO_RX_reg_0_63_24_26 : label is 26;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_27_29 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_27_29 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_27_29 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_27_29 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_27_29 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_27_29 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_27_29 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_27_29 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_27_29 : label is 27;
  attribute ram_slice_end of FIFO_RX_reg_0_63_27_29 : label is 29;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_30_31 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_30_31 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_30_31 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_30_31 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_30_31 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_30_31 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_30_31 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_30_31 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_30_31 : label is 30;
  attribute ram_slice_end of FIFO_RX_reg_0_63_30_31 : label is 31;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_3_5 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_3_5 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_3_5 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_3_5 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_3_5 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_3_5 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_3_5 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_3_5 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_3_5 : label is 3;
  attribute ram_slice_end of FIFO_RX_reg_0_63_3_5 : label is 5;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_6_8 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_6_8 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_6_8 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_6_8 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_6_8 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_6_8 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_6_8 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_6_8 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_6_8 : label is 6;
  attribute ram_slice_end of FIFO_RX_reg_0_63_6_8 : label is 8;
  attribute METHODOLOGY_DRC_VIOS of FIFO_RX_reg_0_63_9_11 : label is "";
  attribute RTL_RAM_BITS of FIFO_RX_reg_0_63_9_11 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_RX_reg_0_63_9_11 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_RX_reg";
  attribute RTL_RAM_STYLE of FIFO_RX_reg_0_63_9_11 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_RX_reg_0_63_9_11 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_RX_reg_0_63_9_11 : label is 0;
  attribute ram_addr_end of FIFO_RX_reg_0_63_9_11 : label is 63;
  attribute ram_offset of FIFO_RX_reg_0_63_9_11 : label is 0;
  attribute ram_slice_begin of FIFO_RX_reg_0_63_9_11 : label is 9;
  attribute ram_slice_end of FIFO_RX_reg_0_63_9_11 : label is 11;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_0_2 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_0_2 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_0_2 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_0_2 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_0_2 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_0_2 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_0_2 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_0_2 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_0_2 : label is 0;
  attribute ram_slice_end of FIFO_TX_reg_0_63_0_2 : label is 2;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_12_14 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_12_14 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_12_14 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_12_14 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_12_14 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_12_14 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_12_14 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_12_14 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_12_14 : label is 12;
  attribute ram_slice_end of FIFO_TX_reg_0_63_12_14 : label is 14;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_15_17 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_15_17 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_15_17 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_15_17 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_15_17 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_15_17 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_15_17 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_15_17 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_15_17 : label is 15;
  attribute ram_slice_end of FIFO_TX_reg_0_63_15_17 : label is 17;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_18_20 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_18_20 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_18_20 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_18_20 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_18_20 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_18_20 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_18_20 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_18_20 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_18_20 : label is 18;
  attribute ram_slice_end of FIFO_TX_reg_0_63_18_20 : label is 20;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_21_23 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_21_23 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_21_23 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_21_23 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_21_23 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_21_23 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_21_23 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_21_23 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_21_23 : label is 21;
  attribute ram_slice_end of FIFO_TX_reg_0_63_21_23 : label is 23;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_24_26 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_24_26 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_24_26 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_24_26 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_24_26 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_24_26 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_24_26 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_24_26 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_24_26 : label is 24;
  attribute ram_slice_end of FIFO_TX_reg_0_63_24_26 : label is 26;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_27_29 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_27_29 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_27_29 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_27_29 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_27_29 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_27_29 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_27_29 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_27_29 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_27_29 : label is 27;
  attribute ram_slice_end of FIFO_TX_reg_0_63_27_29 : label is 29;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_30_31 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_30_31 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_30_31 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_30_31 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_30_31 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_30_31 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_30_31 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_30_31 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_30_31 : label is 30;
  attribute ram_slice_end of FIFO_TX_reg_0_63_30_31 : label is 31;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_3_5 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_3_5 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_3_5 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_3_5 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_3_5 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_3_5 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_3_5 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_3_5 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_3_5 : label is 3;
  attribute ram_slice_end of FIFO_TX_reg_0_63_3_5 : label is 5;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_6_8 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_6_8 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_6_8 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_6_8 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_6_8 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_6_8 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_6_8 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_6_8 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_6_8 : label is 6;
  attribute ram_slice_end of FIFO_TX_reg_0_63_6_8 : label is 8;
  attribute METHODOLOGY_DRC_VIOS of FIFO_TX_reg_0_63_9_11 : label is "";
  attribute RTL_RAM_BITS of FIFO_TX_reg_0_63_9_11 : label is 2048;
  attribute RTL_RAM_NAME of FIFO_TX_reg_0_63_9_11 : label is "design_1_QSPI_Master_AXI4_Lite_0_0/inst/FIFO_TX_reg";
  attribute RTL_RAM_STYLE of FIFO_TX_reg_0_63_9_11 : label is "distributed";
  attribute RTL_RAM_TYPE of FIFO_TX_reg_0_63_9_11 : label is "RAM_SDP";
  attribute ram_addr_begin of FIFO_TX_reg_0_63_9_11 : label is 0;
  attribute ram_addr_end of FIFO_TX_reg_0_63_9_11 : label is 63;
  attribute ram_offset of FIFO_TX_reg_0_63_9_11 : label is 0;
  attribute ram_slice_begin of FIFO_TX_reg_0_63_9_11 : label is 9;
  attribute ram_slice_end of FIFO_TX_reg_0_63_9_11 : label is 11;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of QSPI_IO2_INST_0 : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of QSPI_IO3_INST_0 : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \QSPI_STA[1]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \QSPI_STA[4]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \QSPI_STA[5]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \QSPI_STA[6]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \QSPI_STA[7]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \QSPI_STA[8]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \QSPI_STA[9]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of busy_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \data_byte_size[0]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \data_byte_size[1]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \data_byte_size[2]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \data_byte_size[3]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \data_byte_size[3]_i_2\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \data_byte_size[4]_i_2\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \data_byte_size[5]_i_2\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \data_byte_size[7]_i_5\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \data_mode[2]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \dummy_cycle[0]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \dummy_cycle[1]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \dummy_cycle[4]_i_3\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \dummy_cycle[4]_i_4\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \dummy_cycle[4]_i_5\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \fifo_error[0]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \fifo_error[1]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \fifo_rx_cnt[0]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \fifo_rx_cnt[4]_i_2\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \fifo_rx_cnt[4]_i_3\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \fifo_rx_cnt[5]_i_2\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \fifo_rx_cnt[5]_i_3\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \fifo_tx_cnt[0]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \fifo_tx_cnt[1]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \fifo_tx_cnt[4]_i_2\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \fifo_tx_cnt[4]_i_3\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \fifo_tx_cnt[5]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \fifo_tx_cnt[5]_i_3\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of fifo_tx_wr_en_i_1 : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of io2_val_tristate_oe_i_3 : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of prscl_cnt1_carry_i_5 : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of prscl_cnt1_carry_i_7 : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \prscl_cnt[1]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \prscl_cnt[2]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \prscl_cnt[3]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \prscl_cnt[5]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of qspi_falling_edge_i_2 : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of qspi_falling_edge_i_5 : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of qspi_falling_edge_i_6 : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of qspi_rising_edge_i_1 : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \rx_rd_ptr[0]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \rx_rd_ptr[1]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \rx_rd_ptr[3]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rx_rd_ptr[4]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rx_rd_ptr[5]_i_3\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rx_wr_ptr[0]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \rx_wr_ptr[1]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \rx_wr_ptr[2]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \rx_wr_ptr[3]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \rx_wr_ptr[5]_i_2\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \rx_wr_ptr[5]_i_3\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \shift_byte[1]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \shift_byte[26]_i_2\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \shift_byte[27]_i_2\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \shift_byte[28]_i_2\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \shift_byte[29]_i_2\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \shift_byte[30]_i_2\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \shift_byte[31]_i_3\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \shift_byte[5]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \shift_byte[6]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \shift_byte[7]_i_2\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \shift_byte[7]_i_3\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \shift_byte[7]_i_4\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \shift_cnt[2]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \shift_cnt[2]_i_2\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \shift_cnt[3]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \shift_cnt[4]_i_2\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \shift_cnt[5]_i_4\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \shift_cnt[5]_i_5\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \to_do_list[0]_i_3\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \to_do_list[1]_i_3\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \to_do_list[2]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \to_do_list[2]_i_5\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \tx_rd_ptr[0]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \tx_rd_ptr[1]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \tx_wr_ptr[1]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \tx_wr_ptr[2]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \tx_wr_ptr[4]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \tx_wr_ptr[5]_i_2\ : label is "soft_lutpair1";
begin
  QSPI_CS_reg_0 <= \^qspi_cs_reg_0\;
  QSPI_SCLK_reg_0 <= \^qspi_sclk_reg_0\;
  arready <= \^arready\;
  awready <= \^awready\;
  bvalid <= \^bvalid\;
  rst_n_0 <= \^rst_n_0\;
  rvalid <= \^rvalid\;
FIFO_RX_reg_0_63_0_2: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(0),
      DIB => fifo_rx_wdata(1),
      DIC => fifo_rx_wdata(2),
      DID => '0',
      DOA => fifo_rx_rdata0(0),
      DOB => fifo_rx_rdata0(1),
      DOC => fifo_rx_rdata0(2),
      DOD => NLW_FIFO_RX_reg_0_63_0_2_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_12_14: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(12),
      DIB => fifo_rx_wdata(13),
      DIC => fifo_rx_wdata(14),
      DID => '0',
      DOA => fifo_rx_rdata0(12),
      DOB => fifo_rx_rdata0(13),
      DOC => fifo_rx_rdata0(14),
      DOD => NLW_FIFO_RX_reg_0_63_12_14_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_15_17: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(15),
      DIB => fifo_rx_wdata(16),
      DIC => fifo_rx_wdata(17),
      DID => '0',
      DOA => fifo_rx_rdata0(15),
      DOB => fifo_rx_rdata0(16),
      DOC => fifo_rx_rdata0(17),
      DOD => NLW_FIFO_RX_reg_0_63_15_17_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_18_20: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(18),
      DIB => fifo_rx_wdata(19),
      DIC => fifo_rx_wdata(20),
      DID => '0',
      DOA => fifo_rx_rdata0(18),
      DOB => fifo_rx_rdata0(19),
      DOC => fifo_rx_rdata0(20),
      DOD => NLW_FIFO_RX_reg_0_63_18_20_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_21_23: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(21),
      DIB => fifo_rx_wdata(22),
      DIC => fifo_rx_wdata(23),
      DID => '0',
      DOA => fifo_rx_rdata0(21),
      DOB => fifo_rx_rdata0(22),
      DOC => fifo_rx_rdata0(23),
      DOD => NLW_FIFO_RX_reg_0_63_21_23_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_24_26: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(24),
      DIB => fifo_rx_wdata(25),
      DIC => fifo_rx_wdata(26),
      DID => '0',
      DOA => fifo_rx_rdata0(24),
      DOB => fifo_rx_rdata0(25),
      DOC => fifo_rx_rdata0(26),
      DOD => NLW_FIFO_RX_reg_0_63_24_26_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_27_29: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(27),
      DIB => fifo_rx_wdata(28),
      DIC => fifo_rx_wdata(29),
      DID => '0',
      DOA => fifo_rx_rdata0(27),
      DOB => fifo_rx_rdata0(28),
      DOC => fifo_rx_rdata0(29),
      DOD => NLW_FIFO_RX_reg_0_63_27_29_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_30_31: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(30),
      DIB => fifo_rx_wdata(31),
      DIC => '0',
      DID => '0',
      DOA => fifo_rx_rdata0(30),
      DOB => fifo_rx_rdata0(31),
      DOC => NLW_FIFO_RX_reg_0_63_30_31_DOC_UNCONNECTED,
      DOD => NLW_FIFO_RX_reg_0_63_30_31_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_3_5: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(3),
      DIB => fifo_rx_wdata(4),
      DIC => fifo_rx_wdata(5),
      DID => '0',
      DOA => fifo_rx_rdata0(3),
      DOB => fifo_rx_rdata0(4),
      DOC => fifo_rx_rdata0(5),
      DOD => NLW_FIFO_RX_reg_0_63_3_5_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_6_8: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(6),
      DIB => fifo_rx_wdata(7),
      DIC => fifo_rx_wdata(8),
      DID => '0',
      DOA => fifo_rx_rdata0(6),
      DOB => fifo_rx_rdata0(7),
      DOC => fifo_rx_rdata0(8),
      DOD => NLW_FIFO_RX_reg_0_63_6_8_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_RX_reg_0_63_9_11: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => rx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => rx_wr_ptr(5 downto 0),
      DIA => fifo_rx_wdata(9),
      DIB => fifo_rx_wdata(10),
      DIC => fifo_rx_wdata(11),
      DID => '0',
      DOA => fifo_rx_rdata0(9),
      DOB => fifo_rx_rdata0(10),
      DOC => fifo_rx_rdata0(11),
      DOD => NLW_FIFO_RX_reg_0_63_9_11_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_rx_wr_en
    );
FIFO_TX_reg_0_63_0_2: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(0),
      DIB => fifo_tx_wdata(1),
      DIC => fifo_tx_wdata(2),
      DID => '0',
      DOA => fifo_tx_rdata0(0),
      DOB => fifo_tx_rdata0(1),
      DOC => fifo_tx_rdata0(2),
      DOD => NLW_FIFO_TX_reg_0_63_0_2_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_12_14: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(12),
      DIB => fifo_tx_wdata(13),
      DIC => fifo_tx_wdata(14),
      DID => '0',
      DOA => fifo_tx_rdata0(12),
      DOB => fifo_tx_rdata0(13),
      DOC => fifo_tx_rdata0(14),
      DOD => NLW_FIFO_TX_reg_0_63_12_14_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_15_17: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(15),
      DIB => fifo_tx_wdata(16),
      DIC => fifo_tx_wdata(17),
      DID => '0',
      DOA => fifo_tx_rdata0(15),
      DOB => fifo_tx_rdata0(16),
      DOC => fifo_tx_rdata0(17),
      DOD => NLW_FIFO_TX_reg_0_63_15_17_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_18_20: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(18),
      DIB => fifo_tx_wdata(19),
      DIC => fifo_tx_wdata(20),
      DID => '0',
      DOA => fifo_tx_rdata0(18),
      DOB => fifo_tx_rdata0(19),
      DOC => fifo_tx_rdata0(20),
      DOD => NLW_FIFO_TX_reg_0_63_18_20_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_21_23: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(21),
      DIB => fifo_tx_wdata(22),
      DIC => fifo_tx_wdata(23),
      DID => '0',
      DOA => fifo_tx_rdata0(21),
      DOB => fifo_tx_rdata0(22),
      DOC => fifo_tx_rdata0(23),
      DOD => NLW_FIFO_TX_reg_0_63_21_23_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_24_26: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(24),
      DIB => fifo_tx_wdata(25),
      DIC => fifo_tx_wdata(26),
      DID => '0',
      DOA => fifo_tx_rdata0(24),
      DOB => fifo_tx_rdata0(25),
      DOC => fifo_tx_rdata0(26),
      DOD => NLW_FIFO_TX_reg_0_63_24_26_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_27_29: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(27),
      DIB => fifo_tx_wdata(28),
      DIC => fifo_tx_wdata(29),
      DID => '0',
      DOA => fifo_tx_rdata0(27),
      DOB => fifo_tx_rdata0(28),
      DOC => fifo_tx_rdata0(29),
      DOD => NLW_FIFO_TX_reg_0_63_27_29_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_30_31: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(30),
      DIB => fifo_tx_wdata(31),
      DIC => '0',
      DID => '0',
      DOA => fifo_tx_rdata0(30),
      DOB => fifo_tx_rdata0(31),
      DOC => NLW_FIFO_TX_reg_0_63_30_31_DOC_UNCONNECTED,
      DOD => NLW_FIFO_TX_reg_0_63_30_31_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_3_5: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(3),
      DIB => fifo_tx_wdata(4),
      DIC => fifo_tx_wdata(5),
      DID => '0',
      DOA => fifo_tx_rdata0(3),
      DOB => fifo_tx_rdata0(4),
      DOC => fifo_tx_rdata0(5),
      DOD => NLW_FIFO_TX_reg_0_63_3_5_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_6_8: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(6),
      DIB => fifo_tx_wdata(7),
      DIC => fifo_tx_wdata(8),
      DID => '0',
      DOA => fifo_tx_rdata0(6),
      DOB => fifo_tx_rdata0(7),
      DOC => fifo_tx_rdata0(8),
      DOD => NLW_FIFO_TX_reg_0_63_6_8_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
FIFO_TX_reg_0_63_9_11: unisim.vcomponents.RAM64M
     port map (
      ADDRA(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => tx_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => tx_wr_ptr(5 downto 0),
      DIA => fifo_tx_wdata(9),
      DIB => fifo_tx_wdata(10),
      DIC => fifo_tx_wdata(11),
      DID => '0',
      DOA => fifo_tx_rdata0(9),
      DOB => fifo_tx_rdata0(10),
      DOC => fifo_tx_rdata0(11),
      DOD => NLW_FIFO_TX_reg_0_63_9_11_DOD_UNCONNECTED,
      WCLK => clk_i,
      WE => fifo_tx_wr_en
    );
\QSPI_ADR[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01000000"
    )
        port map (
      I0 => awaddr(0),
      I1 => awaddr(4),
      I2 => awaddr(1),
      I3 => awaddr(2),
      I4 => \QSPI_CCR[31]_i_2_n_0\,
      O => QSPI_ADR(0)
    );
\QSPI_ADR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(0),
      Q => \QSPI_ADR_reg_n_0_[0]\
    );
\QSPI_ADR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(10),
      Q => \QSPI_ADR_reg_n_0_[10]\
    );
\QSPI_ADR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(11),
      Q => \QSPI_ADR_reg_n_0_[11]\
    );
\QSPI_ADR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(12),
      Q => \QSPI_ADR_reg_n_0_[12]\
    );
\QSPI_ADR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(13),
      Q => \QSPI_ADR_reg_n_0_[13]\
    );
\QSPI_ADR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(14),
      Q => \QSPI_ADR_reg_n_0_[14]\
    );
\QSPI_ADR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(15),
      Q => \QSPI_ADR_reg_n_0_[15]\
    );
\QSPI_ADR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(16),
      Q => \QSPI_ADR_reg_n_0_[16]\
    );
\QSPI_ADR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(17),
      Q => \QSPI_ADR_reg_n_0_[17]\
    );
\QSPI_ADR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(18),
      Q => \QSPI_ADR_reg_n_0_[18]\
    );
\QSPI_ADR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(19),
      Q => \QSPI_ADR_reg_n_0_[19]\
    );
\QSPI_ADR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(1),
      Q => \QSPI_ADR_reg_n_0_[1]\
    );
\QSPI_ADR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(20),
      Q => \QSPI_ADR_reg_n_0_[20]\
    );
\QSPI_ADR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(21),
      Q => \QSPI_ADR_reg_n_0_[21]\
    );
\QSPI_ADR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(22),
      Q => \QSPI_ADR_reg_n_0_[22]\
    );
\QSPI_ADR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(23),
      Q => \QSPI_ADR_reg_n_0_[23]\
    );
\QSPI_ADR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(24),
      Q => \QSPI_ADR_reg_n_0_[24]\
    );
\QSPI_ADR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(25),
      Q => \QSPI_ADR_reg_n_0_[25]\
    );
\QSPI_ADR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(26),
      Q => \QSPI_ADR_reg_n_0_[26]\
    );
\QSPI_ADR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(27),
      Q => \QSPI_ADR_reg_n_0_[27]\
    );
\QSPI_ADR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(28),
      Q => \QSPI_ADR_reg_n_0_[28]\
    );
\QSPI_ADR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(29),
      Q => \QSPI_ADR_reg_n_0_[29]\
    );
\QSPI_ADR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(2),
      Q => \QSPI_ADR_reg_n_0_[2]\
    );
\QSPI_ADR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(30),
      Q => \QSPI_ADR_reg_n_0_[30]\
    );
\QSPI_ADR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(31),
      Q => \QSPI_ADR_reg_n_0_[31]\
    );
\QSPI_ADR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(3),
      Q => \QSPI_ADR_reg_n_0_[3]\
    );
\QSPI_ADR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(4),
      Q => \QSPI_ADR_reg_n_0_[4]\
    );
\QSPI_ADR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(5),
      Q => \QSPI_ADR_reg_n_0_[5]\
    );
\QSPI_ADR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(6),
      Q => \QSPI_ADR_reg_n_0_[6]\
    );
\QSPI_ADR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(7),
      Q => \QSPI_ADR_reg_n_0_[7]\
    );
\QSPI_ADR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(8),
      Q => \QSPI_ADR_reg_n_0_[8]\
    );
\QSPI_ADR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_ADR(0),
      CLR => \^rst_n_0\,
      D => wdata(9),
      Q => \QSPI_ADR_reg_n_0_[9]\
    );
\QSPI_CCR[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => awaddr(0),
      I1 => awaddr(4),
      I2 => awaddr(1),
      I3 => awaddr(2),
      I4 => \QSPI_CCR[31]_i_2_n_0\,
      O => QSPI_CCR(0)
    );
\QSPI_CCR[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000040"
    )
        port map (
      I0 => awaddr(3),
      I1 => awvalid,
      I2 => wvalid,
      I3 => awaddr(5),
      I4 => awaddr(7),
      I5 => awaddr(6),
      O => \QSPI_CCR[31]_i_2_n_0\
    );
\QSPI_CCR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(0),
      Q => \QSPI_CCR_reg_n_0_[0]\
    );
\QSPI_CCR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(10),
      Q => \QSPI_CCR_reg_n_0_[10]\
    );
\QSPI_CCR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(11),
      Q => \QSPI_CCR_reg_n_0_[11]\
    );
\QSPI_CCR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(12),
      Q => \QSPI_CCR_reg_n_0_[12]\
    );
\QSPI_CCR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(13),
      Q => \QSPI_CCR_reg_n_0_[13]\
    );
\QSPI_CCR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(14),
      Q => \QSPI_CCR_reg_n_0_[14]\
    );
\QSPI_CCR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(15),
      Q => \QSPI_CCR_reg_n_0_[15]\
    );
\QSPI_CCR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(16),
      Q => \QSPI_CCR_reg_n_0_[16]\
    );
\QSPI_CCR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(17),
      Q => \QSPI_CCR_reg_n_0_[17]\
    );
\QSPI_CCR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(18),
      Q => \QSPI_CCR_reg_n_0_[18]\
    );
\QSPI_CCR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(19),
      Q => \QSPI_CCR_reg_n_0_[19]\
    );
\QSPI_CCR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(1),
      Q => \QSPI_CCR_reg_n_0_[1]\
    );
\QSPI_CCR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(20),
      Q => \QSPI_CCR_reg_n_0_[20]\
    );
\QSPI_CCR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(21),
      Q => \QSPI_CCR_reg_n_0_[21]\
    );
\QSPI_CCR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(22),
      Q => \QSPI_CCR_reg_n_0_[22]\
    );
\QSPI_CCR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(23),
      Q => \QSPI_CCR_reg_n_0_[23]\
    );
\QSPI_CCR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(24),
      Q => \QSPI_CCR_reg_n_0_[24]\
    );
\QSPI_CCR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(25),
      Q => p_0_in_0(0)
    );
\QSPI_CCR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(26),
      Q => p_0_in_0(1)
    );
\QSPI_CCR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(27),
      Q => p_0_in_0(2)
    );
\QSPI_CCR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(28),
      Q => p_0_in_0(3)
    );
\QSPI_CCR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(29),
      Q => p_0_in_0(4)
    );
\QSPI_CCR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(2),
      Q => \QSPI_CCR_reg_n_0_[2]\
    );
\QSPI_CCR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(30),
      Q => p_0_in_0(5)
    );
\QSPI_CCR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(31),
      Q => p_0_in0
    );
\QSPI_CCR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(3),
      Q => \QSPI_CCR_reg_n_0_[3]\
    );
\QSPI_CCR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(4),
      Q => \QSPI_CCR_reg_n_0_[4]\
    );
\QSPI_CCR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(5),
      Q => \QSPI_CCR_reg_n_0_[5]\
    );
\QSPI_CCR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(6),
      Q => \QSPI_CCR_reg_n_0_[6]\
    );
\QSPI_CCR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(7),
      Q => \QSPI_CCR_reg_n_0_[7]\
    );
\QSPI_CCR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(8),
      Q => data2(0)
    );
\QSPI_CCR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_CCR(0),
      CLR => \^rst_n_0\,
      D => wdata(9),
      Q => data2(1)
    );
QSPI_CS_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF05FFDDAA00AAC8"
    )
        port map (
      I0 => QSPI_CS_i_2_n_0,
      I1 => qspi_falling_edge,
      I2 => \fifo_status_reg_n_0_[0]\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => busy0,
      I5 => \^qspi_cs_reg_0\,
      O => QSPI_CS_i_1_n_0
    );
QSPI_CS_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000040"
    )
        port map (
      I0 => r_w_reg_n_0,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \fifo_status_reg_n_0_[0]\,
      I3 => \to_do_list_reg_n_0_[3]\,
      I4 => \to_do_list_reg_n_0_[1]\,
      I5 => \to_do_list_reg_n_0_[2]\,
      O => QSPI_CS_i_2_n_0
    );
QSPI_CS_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FD"
    )
        port map (
      I0 => \instr_shadow[7]_i_4_n_0\,
      I1 => \instr_shadow[7]_i_3_n_0\,
      I2 => \instr_shadow[7]_i_2_n_0\,
      I3 => \QSPI_STA_reg_n_0_[1]\,
      O => busy0
    );
QSPI_CS_reg: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => QSPI_CS_i_1_n_0,
      PRE => \^rst_n_0\,
      Q => \^qspi_cs_reg_0\
    );
\QSPI_DR[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
        port map (
      I0 => awaddr(2),
      I1 => awaddr(1),
      I2 => awaddr(0),
      I3 => awaddr(4),
      I4 => awaddr(3),
      I5 => \QSPI_DR[31]_i_2_n_0\,
      O => QSPI_DR(0)
    );
\QSPI_DR[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFFFFFF"
    )
        port map (
      I0 => awaddr(6),
      I1 => awaddr(7),
      I2 => awaddr(5),
      I3 => wvalid,
      I4 => awvalid,
      O => \QSPI_DR[31]_i_2_n_0\
    );
\QSPI_DR_read[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0E00"
    )
        port map (
      I0 => rx_pull_once_reg_n_0,
      I1 => fifo_rx_pull_data,
      I2 => \QSPI_STA_reg_n_0_[5]\,
      I3 => rst_n,
      O => \QSPI_DR_read[31]_i_1_n_0\
    );
\QSPI_DR_read_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(0),
      Q => \QSPI_DR_read_reg_n_0_[0]\,
      R => '0'
    );
\QSPI_DR_read_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(10),
      Q => \QSPI_DR_read_reg_n_0_[10]\,
      R => '0'
    );
\QSPI_DR_read_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(11),
      Q => \QSPI_DR_read_reg_n_0_[11]\,
      R => '0'
    );
\QSPI_DR_read_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(12),
      Q => \QSPI_DR_read_reg_n_0_[12]\,
      R => '0'
    );
\QSPI_DR_read_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(13),
      Q => \QSPI_DR_read_reg_n_0_[13]\,
      R => '0'
    );
\QSPI_DR_read_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(14),
      Q => \QSPI_DR_read_reg_n_0_[14]\,
      R => '0'
    );
\QSPI_DR_read_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(15),
      Q => \QSPI_DR_read_reg_n_0_[15]\,
      R => '0'
    );
\QSPI_DR_read_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(16),
      Q => \QSPI_DR_read_reg_n_0_[16]\,
      R => '0'
    );
\QSPI_DR_read_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(17),
      Q => \QSPI_DR_read_reg_n_0_[17]\,
      R => '0'
    );
\QSPI_DR_read_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(18),
      Q => \QSPI_DR_read_reg_n_0_[18]\,
      R => '0'
    );
\QSPI_DR_read_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(19),
      Q => \QSPI_DR_read_reg_n_0_[19]\,
      R => '0'
    );
\QSPI_DR_read_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(1),
      Q => \QSPI_DR_read_reg_n_0_[1]\,
      R => '0'
    );
\QSPI_DR_read_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(20),
      Q => \QSPI_DR_read_reg_n_0_[20]\,
      R => '0'
    );
\QSPI_DR_read_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(21),
      Q => \QSPI_DR_read_reg_n_0_[21]\,
      R => '0'
    );
\QSPI_DR_read_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(22),
      Q => \QSPI_DR_read_reg_n_0_[22]\,
      R => '0'
    );
\QSPI_DR_read_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(23),
      Q => \QSPI_DR_read_reg_n_0_[23]\,
      R => '0'
    );
\QSPI_DR_read_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(24),
      Q => \QSPI_DR_read_reg_n_0_[24]\,
      R => '0'
    );
\QSPI_DR_read_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(25),
      Q => \QSPI_DR_read_reg_n_0_[25]\,
      R => '0'
    );
\QSPI_DR_read_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(26),
      Q => \QSPI_DR_read_reg_n_0_[26]\,
      R => '0'
    );
\QSPI_DR_read_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(27),
      Q => \QSPI_DR_read_reg_n_0_[27]\,
      R => '0'
    );
\QSPI_DR_read_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(28),
      Q => \QSPI_DR_read_reg_n_0_[28]\,
      R => '0'
    );
\QSPI_DR_read_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(29),
      Q => \QSPI_DR_read_reg_n_0_[29]\,
      R => '0'
    );
\QSPI_DR_read_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(2),
      Q => \QSPI_DR_read_reg_n_0_[2]\,
      R => '0'
    );
\QSPI_DR_read_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(30),
      Q => \QSPI_DR_read_reg_n_0_[30]\,
      R => '0'
    );
\QSPI_DR_read_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(31),
      Q => \QSPI_DR_read_reg_n_0_[31]\,
      R => '0'
    );
\QSPI_DR_read_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(3),
      Q => \QSPI_DR_read_reg_n_0_[3]\,
      R => '0'
    );
\QSPI_DR_read_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(4),
      Q => \QSPI_DR_read_reg_n_0_[4]\,
      R => '0'
    );
\QSPI_DR_read_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(5),
      Q => \QSPI_DR_read_reg_n_0_[5]\,
      R => '0'
    );
\QSPI_DR_read_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(6),
      Q => \QSPI_DR_read_reg_n_0_[6]\,
      R => '0'
    );
\QSPI_DR_read_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(7),
      Q => \QSPI_DR_read_reg_n_0_[7]\,
      R => '0'
    );
\QSPI_DR_read_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(8),
      Q => \QSPI_DR_read_reg_n_0_[8]\,
      R => '0'
    );
\QSPI_DR_read_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \QSPI_DR_read[31]_i_1_n_0\,
      D => fifo_rx_rdata(9),
      Q => \QSPI_DR_read_reg_n_0_[9]\,
      R => '0'
    );
\QSPI_DR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(0),
      Q => \QSPI_DR_reg_n_0_[0]\
    );
\QSPI_DR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(10),
      Q => \QSPI_DR_reg_n_0_[10]\
    );
\QSPI_DR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(11),
      Q => \QSPI_DR_reg_n_0_[11]\
    );
\QSPI_DR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(12),
      Q => \QSPI_DR_reg_n_0_[12]\
    );
\QSPI_DR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(13),
      Q => \QSPI_DR_reg_n_0_[13]\
    );
\QSPI_DR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(14),
      Q => \QSPI_DR_reg_n_0_[14]\
    );
\QSPI_DR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(15),
      Q => \QSPI_DR_reg_n_0_[15]\
    );
\QSPI_DR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(16),
      Q => \QSPI_DR_reg_n_0_[16]\
    );
\QSPI_DR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(17),
      Q => \QSPI_DR_reg_n_0_[17]\
    );
\QSPI_DR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(18),
      Q => \QSPI_DR_reg_n_0_[18]\
    );
\QSPI_DR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(19),
      Q => \QSPI_DR_reg_n_0_[19]\
    );
\QSPI_DR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(1),
      Q => \QSPI_DR_reg_n_0_[1]\
    );
\QSPI_DR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(20),
      Q => \QSPI_DR_reg_n_0_[20]\
    );
\QSPI_DR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(21),
      Q => \QSPI_DR_reg_n_0_[21]\
    );
\QSPI_DR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(22),
      Q => \QSPI_DR_reg_n_0_[22]\
    );
\QSPI_DR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(23),
      Q => \QSPI_DR_reg_n_0_[23]\
    );
\QSPI_DR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(24),
      Q => \QSPI_DR_reg_n_0_[24]\
    );
\QSPI_DR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(25),
      Q => \QSPI_DR_reg_n_0_[25]\
    );
\QSPI_DR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(26),
      Q => \QSPI_DR_reg_n_0_[26]\
    );
\QSPI_DR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(27),
      Q => \QSPI_DR_reg_n_0_[27]\
    );
\QSPI_DR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(28),
      Q => \QSPI_DR_reg_n_0_[28]\
    );
\QSPI_DR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(29),
      Q => \QSPI_DR_reg_n_0_[29]\
    );
\QSPI_DR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(2),
      Q => \QSPI_DR_reg_n_0_[2]\
    );
\QSPI_DR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(30),
      Q => \QSPI_DR_reg_n_0_[30]\
    );
\QSPI_DR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(31),
      Q => \QSPI_DR_reg_n_0_[31]\
    );
\QSPI_DR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(3),
      Q => \QSPI_DR_reg_n_0_[3]\
    );
\QSPI_DR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(4),
      Q => \QSPI_DR_reg_n_0_[4]\
    );
\QSPI_DR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(5),
      Q => \QSPI_DR_reg_n_0_[5]\
    );
\QSPI_DR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(6),
      Q => \QSPI_DR_reg_n_0_[6]\
    );
\QSPI_DR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(7),
      Q => \QSPI_DR_reg_n_0_[7]\
    );
\QSPI_DR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(8),
      Q => \QSPI_DR_reg_n_0_[8]\
    );
\QSPI_DR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_DR(0),
      CLR => \^rst_n_0\,
      D => wdata(9),
      Q => \QSPI_DR_reg_n_0_[9]\
    );
\QSPI_FCR[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00001000"
    )
        port map (
      I0 => awaddr(1),
      I1 => awaddr(2),
      I2 => \QSPI_CCR[31]_i_2_n_0\,
      I3 => awaddr(4),
      I4 => awaddr(0),
      O => QSPI_FCR(0)
    );
\QSPI_FCR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(0),
      Q => p_1_in
    );
\QSPI_FCR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(10),
      Q => \QSPI_FCR_reg_n_0_[10]\
    );
\QSPI_FCR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(11),
      Q => \QSPI_FCR_reg_n_0_[11]\
    );
\QSPI_FCR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(12),
      Q => \QSPI_FCR_reg_n_0_[12]\
    );
\QSPI_FCR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(13),
      Q => \QSPI_FCR_reg_n_0_[13]\
    );
\QSPI_FCR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(14),
      Q => \QSPI_FCR_reg_n_0_[14]\
    );
\QSPI_FCR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(15),
      Q => \QSPI_FCR_reg_n_0_[15]\
    );
\QSPI_FCR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(16),
      Q => \QSPI_FCR_reg_n_0_[16]\
    );
\QSPI_FCR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(17),
      Q => \QSPI_FCR_reg_n_0_[17]\
    );
\QSPI_FCR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(18),
      Q => \QSPI_FCR_reg_n_0_[18]\
    );
\QSPI_FCR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(19),
      Q => \QSPI_FCR_reg_n_0_[19]\
    );
\QSPI_FCR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(1),
      Q => \QSPI_FCR_reg_n_0_[1]\
    );
\QSPI_FCR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(20),
      Q => \QSPI_FCR_reg_n_0_[20]\
    );
\QSPI_FCR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(21),
      Q => \QSPI_FCR_reg_n_0_[21]\
    );
\QSPI_FCR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(22),
      Q => \QSPI_FCR_reg_n_0_[22]\
    );
\QSPI_FCR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(23),
      Q => \QSPI_FCR_reg_n_0_[23]\
    );
\QSPI_FCR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(24),
      Q => \QSPI_FCR_reg_n_0_[24]\
    );
\QSPI_FCR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(25),
      Q => \QSPI_FCR_reg_n_0_[25]\
    );
\QSPI_FCR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(26),
      Q => \QSPI_FCR_reg_n_0_[26]\
    );
\QSPI_FCR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(27),
      Q => \QSPI_FCR_reg_n_0_[27]\
    );
\QSPI_FCR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(28),
      Q => \QSPI_FCR_reg_n_0_[28]\
    );
\QSPI_FCR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(29),
      Q => \QSPI_FCR_reg_n_0_[29]\
    );
\QSPI_FCR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(2),
      Q => \QSPI_FCR_reg_n_0_[2]\
    );
\QSPI_FCR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(30),
      Q => \QSPI_FCR_reg_n_0_[30]\
    );
\QSPI_FCR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(31),
      Q => \QSPI_FCR_reg_n_0_[31]\
    );
\QSPI_FCR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(3),
      Q => \QSPI_FCR_reg_n_0_[3]\
    );
\QSPI_FCR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(4),
      Q => \QSPI_FCR_reg_n_0_[4]\
    );
\QSPI_FCR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(5),
      Q => \QSPI_FCR_reg_n_0_[5]\
    );
\QSPI_FCR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(6),
      Q => \QSPI_FCR_reg_n_0_[6]\
    );
\QSPI_FCR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(7),
      Q => \QSPI_FCR_reg_n_0_[7]\
    );
\QSPI_FCR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(8),
      Q => \QSPI_FCR_reg_n_0_[8]\
    );
\QSPI_FCR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => QSPI_FCR(0),
      CLR => \^rst_n_0\,
      D => wdata(9),
      Q => \QSPI_FCR_reg_n_0_[9]\
    );
QSPI_IO0_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => io0_val_tristate_oe_reg_n_0,
      I1 => QSPI_IO0_INST_0_i_1,
      O => QSPI_IO0
    );
QSPI_IO0_INST_0_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4F4F4FFF4F4F400"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[1]\,
      I1 => busy0,
      I2 => \shift_cnt[5]_i_4_n_0\,
      I3 => io0_val_tristate_oe_i_3_n_0,
      I4 => io0_val_tristate_oe_i_4_n_0,
      I5 => QSPI_IO0_INST_0_i_1,
      O => \fifo_status_reg[1]_0\
    );
QSPI_IO1_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => io1_val_tristate_oe_reg_n_0,
      I1 => QSPI_IO1_INST_0_i_1_0,
      O => QSPI_IO1
    );
QSPI_IO1_INST_0_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABB8A88"
    )
        port map (
      I0 => \shift_cnt[5]_i_4_n_0\,
      I1 => \data_mode[2]_i_2_n_0\,
      I2 => QSPI_IO1_INST_0_i_3_n_0,
      I3 => io2_val_tristate_oe_i_3_n_0,
      I4 => QSPI_IO1_INST_0_i_1_0,
      O => QSPI_IO1_INST_0_i_1
    );
QSPI_IO1_INST_0_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A88AAAAAAAAAAAAA"
    )
        port map (
      I0 => \to_do_list[1]_i_3_n_0\,
      I1 => \data_mode__0\(0),
      I2 => \data_mode__0\(1),
      I3 => \data_mode__0\(2),
      I4 => qspi_falling_edge,
      I5 => r_w_reg_n_0,
      O => QSPI_IO1_INST_0_i_3_n_0
    );
QSPI_IO2_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => io2_val_tristate_oe_reg_n_0,
      I1 => QSPI_IO2_INST_0_i_1_0,
      O => QSPI_IO2
    );
QSPI_IO2_INST_0_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABB8A88"
    )
        port map (
      I0 => \shift_cnt[5]_i_4_n_0\,
      I1 => \data_mode[2]_i_2_n_0\,
      I2 => io2_val_tristate_oe_i_2_n_0,
      I3 => io2_val_tristate_oe_i_3_n_0,
      I4 => QSPI_IO2_INST_0_i_1_0,
      O => QSPI_IO2_INST_0_i_1
    );
QSPI_IO3_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => io3_val_tristate_oe_reg_n_0,
      I1 => QSPI_IO2_INST_0_i_1_0,
      O => QSPI_IO3
    );
QSPI_SCLK_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B4"
    )
        port map (
      I0 => \^qspi_cs_reg_0\,
      I1 => prscl_cnt1,
      I2 => \^qspi_sclk_reg_0\,
      O => QSPI_SCLK_i_1_n_0
    );
QSPI_SCLK_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => QSPI_SCLK_i_1_n_0,
      Q => \^qspi_sclk_reg_0\
    );
\QSPI_STA[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_2_in(1),
      I1 => p_0_in0,
      O => \QSPI_STA[1]_i_1_n_0\
    );
\QSPI_STA[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => p_0_in0,
      I1 => \fifo_rx_cnt[6]_i_3_n_0\,
      I2 => \fifo_rx_cnt_reg_n_0_[6]\,
      O => \QSPI_STA[4]_i_1_n_0\
    );
\QSPI_STA[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \fifo_rx_cnt[6]_i_3_n_0\,
      I1 => p_0_in0,
      I2 => \fifo_rx_cnt_reg_n_0_[6]\,
      O => \QSPI_STA[5]_i_1_n_0\
    );
\QSPI_STA[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \fifo_tx_cnt[6]_i_4_n_0\,
      I1 => \fifo_tx_cnt_reg_n_0_[6]\,
      I2 => p_0_in0,
      O => \QSPI_STA[6]_i_1_n_0\
    );
\QSPI_STA[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => p_0_in0,
      I1 => \fifo_tx_cnt[6]_i_4_n_0\,
      I2 => \fifo_tx_cnt_reg_n_0_[6]\,
      O => \QSPI_STA[7]_i_1_n_0\
    );
\QSPI_STA[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => fifo_error(0),
      I1 => p_0_in0,
      O => \QSPI_STA[8]_i_1_n_0\
    );
\QSPI_STA[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => fifo_error(1),
      I1 => p_0_in0,
      O => \QSPI_STA[9]_i_1_n_0\
    );
\QSPI_STA_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \QSPI_STA[1]_i_1_n_0\,
      Q => \QSPI_STA_reg_n_0_[1]\
    );
\QSPI_STA_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \QSPI_STA[4]_i_1_n_0\,
      Q => \QSPI_STA_reg_n_0_[4]\
    );
\QSPI_STA_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \QSPI_STA[5]_i_1_n_0\,
      Q => \QSPI_STA_reg_n_0_[5]\
    );
\QSPI_STA_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \QSPI_STA[6]_i_1_n_0\,
      Q => p_0_in27_in
    );
\QSPI_STA_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \QSPI_STA[7]_i_1_n_0\,
      Q => \QSPI_STA_reg_n_0_[7]\
    );
\QSPI_STA_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \QSPI_STA[8]_i_1_n_0\,
      Q => \QSPI_STA_reg_n_0_[8]\
    );
\QSPI_STA_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \QSPI_STA[9]_i_1_n_0\,
      Q => \QSPI_STA_reg_n_0_[9]\
    );
address_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFBF0080"
    )
        port map (
      I0 => wdata(0),
      I1 => address_i_2_n_0,
      I2 => awaddr(4),
      I3 => awaddr(0),
      I4 => address,
      O => address_i_1_n_0
    );
address_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \QSPI_CCR[31]_i_2_n_0\,
      I1 => awaddr(2),
      I2 => awaddr(1),
      O => address_i_2_n_0
    );
address_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => address_i_1_n_0,
      Q => address
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
      PRE => \^rst_n_0\,
      Q => \^arready\
    );
awready_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"77777000"
    )
        port map (
      I0 => wvalid,
      I1 => awvalid,
      I2 => bready,
      I3 => \^bvalid\,
      I4 => \^awready\,
      O => awready_i_1_n_0
    );
awready_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst_n,
      O => \^rst_n_0\
    );
awready_reg: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => awready_i_1_n_0,
      PRE => \^rst_n_0\,
      Q => \^awready\
    );
busy_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFF2020"
    )
        port map (
      I0 => busy0,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \fifo_status_reg_n_0_[0]\,
      I3 => qspi_falling_edge,
      I4 => p_2_in(1),
      O => busy_i_1_n_0
    );
busy_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => busy_i_1_n_0,
      Q => p_2_in(1)
    );
bvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F88"
    )
        port map (
      I0 => wvalid,
      I1 => awvalid,
      I2 => bready,
      I3 => \^bvalid\,
      O => bvalid_i_1_n_0
    );
bvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => bvalid_i_1_n_0,
      Q => \^bvalid\
    );
\data_byte_size[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A3"
    )
        port map (
      I0 => sel0(0),
      I1 => \QSPI_CCR_reg_n_0_[16]\,
      I2 => \fifo_status_reg_n_0_[1]\,
      O => \data_byte_size[0]_i_1_n_0\
    );
\data_byte_size[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8BB8"
    )
        port map (
      I0 => sel0(1),
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \QSPI_CCR_reg_n_0_[16]\,
      I3 => \QSPI_CCR_reg_n_0_[17]\,
      O => \data_byte_size[1]_i_1_n_0\
    );
\data_byte_size[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"47747474"
    )
        port map (
      I0 => sel0(2),
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \QSPI_CCR_reg_n_0_[18]\,
      I3 => \QSPI_CCR_reg_n_0_[16]\,
      I4 => \QSPI_CCR_reg_n_0_[17]\,
      O => \data_byte_size[2]_i_1_n_0\
    );
\data_byte_size[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"9F90909F"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \fifo_status_reg_n_0_[1]\,
      I3 => \QSPI_CCR_reg_n_0_[19]\,
      I4 => \data_byte_size[3]_i_2_n_0\,
      O => \data_byte_size[3]_i_1_n_0\
    );
\data_byte_size[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[17]\,
      I1 => \QSPI_CCR_reg_n_0_[16]\,
      I2 => \QSPI_CCR_reg_n_0_[18]\,
      O => \data_byte_size[3]_i_2_n_0\
    );
\data_byte_size[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E1FFE100E100E1FF"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => sel0(4),
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \data_byte_size[4]_i_2_n_0\,
      I5 => \QSPI_CCR_reg_n_0_[20]\,
      O => \data_byte_size[4]_i_1_n_0\
    );
\data_byte_size[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[18]\,
      I1 => \QSPI_CCR_reg_n_0_[16]\,
      I2 => \QSPI_CCR_reg_n_0_[17]\,
      I3 => \QSPI_CCR_reg_n_0_[19]\,
      O => \data_byte_size[4]_i_2_n_0\
    );
\data_byte_size[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E100E1FFE1FFE100"
    )
        port map (
      I0 => sel0(4),
      I1 => \data_byte_size[5]_i_2_n_0\,
      I2 => sel0(5),
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \QSPI_CCR_reg_n_0_[21]\,
      I5 => \data_byte_size[7]_i_5_n_0\,
      O => \data_byte_size[5]_i_1_n_0\
    );
\data_byte_size[5]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      O => \data_byte_size[5]_i_2_n_0\
    );
\data_byte_size[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"909F9F909F909F90"
    )
        port map (
      I0 => \data_byte_size[6]_i_2_n_0\,
      I1 => sel0(6),
      I2 => \fifo_status_reg_n_0_[1]\,
      I3 => \QSPI_CCR_reg_n_0_[22]\,
      I4 => \data_byte_size[7]_i_5_n_0\,
      I5 => \QSPI_CCR_reg_n_0_[21]\,
      O => \data_byte_size[6]_i_1_n_0\
    );
\data_byte_size[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => sel0(4),
      I3 => sel0(5),
      O => \data_byte_size[6]_i_2_n_0\
    );
\data_byte_size[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAABAAAAAAAAAAA"
    )
        port map (
      I0 => \instr_shadow[7]_i_1_n_0\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => \fifo_status_reg_n_0_[1]\,
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \to_do_list[2]_i_3_n_0\,
      I5 => \data_byte_size[7]_i_3_n_0\,
      O => \data_byte_size[7]_i_1_n_0\
    );
\data_byte_size[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8BB8B8B8B8B8B8B8"
    )
        port map (
      I0 => \data_byte_size[7]_i_4_n_0\,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \QSPI_CCR_reg_n_0_[23]\,
      I3 => \QSPI_CCR_reg_n_0_[21]\,
      I4 => \data_byte_size[7]_i_5_n_0\,
      I5 => \QSPI_CCR_reg_n_0_[22]\,
      O => \data_byte_size[7]_i_2_n_0\
    );
\data_byte_size[7]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => qspi_falling_edge,
      I1 => \dummy_cycle[4]_i_4_n_0\,
      I2 => \to_do_list_reg_n_0_[2]\,
      I3 => \to_do_list_reg_n_0_[3]\,
      O => \data_byte_size[7]_i_3_n_0\
    );
\data_byte_size[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000001"
    )
        port map (
      I0 => sel0(6),
      I1 => sel0(5),
      I2 => sel0(4),
      I3 => sel0(3),
      I4 => sel0(2),
      I5 => sel0(7),
      O => \data_byte_size[7]_i_4_n_0\
    );
\data_byte_size[7]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[20]\,
      I1 => \QSPI_CCR_reg_n_0_[19]\,
      I2 => \QSPI_CCR_reg_n_0_[17]\,
      I3 => \QSPI_CCR_reg_n_0_[16]\,
      I4 => \QSPI_CCR_reg_n_0_[18]\,
      O => \data_byte_size[7]_i_5_n_0\
    );
\data_byte_size_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \data_byte_size[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \data_byte_size[0]_i_1_n_0\,
      Q => sel0(0)
    );
\data_byte_size_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \data_byte_size[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \data_byte_size[1]_i_1_n_0\,
      Q => sel0(1)
    );
\data_byte_size_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \data_byte_size[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \data_byte_size[2]_i_1_n_0\,
      Q => sel0(2)
    );
\data_byte_size_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \data_byte_size[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \data_byte_size[3]_i_1_n_0\,
      Q => sel0(3)
    );
\data_byte_size_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \data_byte_size[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \data_byte_size[4]_i_1_n_0\,
      Q => sel0(4)
    );
\data_byte_size_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \data_byte_size[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \data_byte_size[5]_i_1_n_0\,
      Q => sel0(5)
    );
\data_byte_size_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \data_byte_size[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \data_byte_size[6]_i_1_n_0\,
      Q => sel0(6)
    );
\data_byte_size_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \data_byte_size[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \data_byte_size[7]_i_2_n_0\,
      Q => sel0(7)
    );
\data_mode[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4FFF4F4F4F00"
    )
        port map (
      I0 => data2(1),
      I1 => data2(0),
      I2 => \fifo_status_reg_n_0_[1]\,
      I3 => \data_mode[2]_i_2_n_0\,
      I4 => \to_do_list[1]_i_2_n_0\,
      I5 => \data_mode__0\(0),
      O => \data_mode[0]_i_1_n_0\
    );
\data_mode[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404000"
    )
        port map (
      I0 => data2(0),
      I1 => data2(1),
      I2 => \fifo_status_reg_n_0_[1]\,
      I3 => \data_mode[2]_i_2_n_0\,
      I4 => \to_do_list[1]_i_2_n_0\,
      I5 => \data_mode__0\(1),
      O => \data_mode[1]_i_1_n_0\
    );
\data_mode[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"808080FF80808000"
    )
        port map (
      I0 => data2(0),
      I1 => data2(1),
      I2 => \fifo_status_reg_n_0_[1]\,
      I3 => \data_mode[2]_i_2_n_0\,
      I4 => \to_do_list[1]_i_2_n_0\,
      I5 => \data_mode__0\(2),
      O => \data_mode[2]_i_1_n_0\
    );
\data_mode[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[1]\,
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => qspi_falling_edge,
      I3 => busy0,
      O => \data_mode[2]_i_2_n_0\
    );
\data_mode_reg[0]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => \data_mode[0]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => \data_mode__0\(0)
    );
\data_mode_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \data_mode[1]_i_1_n_0\,
      Q => \data_mode__0\(1)
    );
\data_mode_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \data_mode[2]_i_1_n_0\,
      Q => \data_mode__0\(2)
    );
\dummy_cycle[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"74"
    )
        port map (
      I0 => \dummy_cycle__0\(0),
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \QSPI_CCR_reg_n_0_[11]\,
      O => \dummy_cycle[0]_i_1_n_0\
    );
\dummy_cycle[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9F90"
    )
        port map (
      I0 => \dummy_cycle__0\(0),
      I1 => \dummy_cycle__0\(1),
      I2 => \fifo_status_reg_n_0_[1]\,
      I3 => \QSPI_CCR_reg_n_0_[12]\,
      O => \dummy_cycle[1]_i_1_n_0\
    );
\dummy_cycle[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E1FFE100"
    )
        port map (
      I0 => \dummy_cycle__0\(0),
      I1 => \dummy_cycle__0\(1),
      I2 => \dummy_cycle__0\(2),
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \QSPI_CCR_reg_n_0_[13]\,
      O => \dummy_cycle[2]_i_1_n_0\
    );
\dummy_cycle[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE01FFFFFE010000"
    )
        port map (
      I0 => \dummy_cycle__0\(2),
      I1 => \dummy_cycle__0\(1),
      I2 => \dummy_cycle__0\(0),
      I3 => \dummy_cycle__0\(3),
      I4 => \fifo_status_reg_n_0_[1]\,
      I5 => \QSPI_CCR_reg_n_0_[14]\,
      O => \dummy_cycle[3]_i_1_n_0\
    );
\dummy_cycle[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EAAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \instr_shadow[7]_i_1_n_0\,
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => qspi_falling_edge,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \dummy_cycle[4]_i_3_n_0\,
      I5 => \dummy_cycle[4]_i_4_n_0\,
      O => \dummy_cycle[4]_i_1_n_0\
    );
\dummy_cycle[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FD55FFFFFD550000"
    )
        port map (
      I0 => \dummy_cycle[4]_i_4_n_0\,
      I1 => \dummy_cycle__0\(3),
      I2 => \dummy_cycle[4]_i_5_n_0\,
      I3 => \dummy_cycle__0\(4),
      I4 => \fifo_status_reg_n_0_[1]\,
      I5 => \QSPI_CCR_reg_n_0_[15]\,
      O => \dummy_cycle[4]_i_2_n_0\
    );
\dummy_cycle[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \to_do_list_reg_n_0_[2]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      O => \dummy_cycle[4]_i_3_n_0\
    );
\dummy_cycle[4]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \dummy_cycle__0\(0),
      I1 => \dummy_cycle__0\(1),
      I2 => \dummy_cycle__0\(2),
      I3 => \dummy_cycle__0\(3),
      I4 => \dummy_cycle__0\(4),
      O => \dummy_cycle[4]_i_4_n_0\
    );
\dummy_cycle[4]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \dummy_cycle__0\(2),
      I1 => \dummy_cycle__0\(1),
      I2 => \dummy_cycle__0\(0),
      O => \dummy_cycle[4]_i_5_n_0\
    );
\dummy_cycle_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \dummy_cycle[4]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \dummy_cycle[0]_i_1_n_0\,
      Q => \dummy_cycle__0\(0)
    );
\dummy_cycle_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \dummy_cycle[4]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \dummy_cycle[1]_i_1_n_0\,
      Q => \dummy_cycle__0\(1)
    );
\dummy_cycle_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \dummy_cycle[4]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \dummy_cycle[2]_i_1_n_0\,
      Q => \dummy_cycle__0\(2)
    );
\dummy_cycle_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \dummy_cycle[4]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \dummy_cycle[3]_i_1_n_0\,
      Q => \dummy_cycle__0\(3)
    );
\dummy_cycle_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \dummy_cycle[4]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \dummy_cycle[4]_i_2_n_0\,
      Q => \dummy_cycle__0\(4)
    );
\fifo_error[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFE0"
    )
        port map (
      I0 => rx_pull_once_reg_n_0,
      I1 => fifo_rx_pull_data,
      I2 => \QSPI_STA_reg_n_0_[4]\,
      I3 => fifo_error(0),
      O => \fifo_error[0]_i_1_n_0\
    );
\fifo_error[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
        port map (
      I0 => fifo_tx_wr_en,
      I1 => p_0_in27_in,
      I2 => fifo_error(1),
      O => \fifo_error[1]_i_1_n_0\
    );
\fifo_error_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \fifo_error[0]_i_1_n_0\,
      Q => fifo_error(0)
    );
\fifo_error_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \fifo_error[1]_i_1_n_0\,
      Q => fifo_error(1)
    );
\fifo_rx_cnt[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000BBBA"
    )
        port map (
      I0 => fifo_rx_wr_en_i_1_n_0,
      I1 => \QSPI_STA_reg_n_0_[5]\,
      I2 => fifo_rx_pull_data,
      I3 => rx_pull_once_reg_n_0,
      I4 => \fifo_rx_cnt_reg_n_0_[0]\,
      O => \fifo_rx_cnt[0]_i_1_n_0\
    );
\fifo_rx_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6666666600009990"
    )
        port map (
      I0 => \fifo_rx_cnt_reg_n_0_[1]\,
      I1 => \fifo_rx_cnt_reg_n_0_[0]\,
      I2 => rx_pull_once_reg_n_0,
      I3 => fifo_rx_pull_data,
      I4 => \QSPI_STA_reg_n_0_[5]\,
      I5 => fifo_rx_wr_en_i_1_n_0,
      O => \fifo_rx_cnt[1]_i_1_n_0\
    );
\fifo_rx_cnt[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3CCC8882"
    )
        port map (
      I0 => \rx_rd_ptr[4]_i_2_n_0\,
      I1 => \fifo_rx_cnt_reg_n_0_[2]\,
      I2 => \fifo_rx_cnt_reg_n_0_[0]\,
      I3 => \fifo_rx_cnt_reg_n_0_[1]\,
      I4 => fifo_rx_wr_en_i_1_n_0,
      O => \fifo_rx_cnt[2]_i_1_n_0\
    );
\fifo_rx_cnt[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2CE0E0E0E0E0E0C2"
    )
        port map (
      I0 => \rx_rd_ptr[4]_i_2_n_0\,
      I1 => fifo_rx_wr_en_i_1_n_0,
      I2 => \fifo_rx_cnt_reg_n_0_[3]\,
      I3 => \fifo_rx_cnt_reg_n_0_[0]\,
      I4 => \fifo_rx_cnt_reg_n_0_[1]\,
      I5 => \fifo_rx_cnt_reg_n_0_[2]\,
      O => \fifo_rx_cnt[3]_i_1_n_0\
    );
\fifo_rx_cnt[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F80408F4"
    )
        port map (
      I0 => \fifo_rx_cnt[4]_i_2_n_0\,
      I1 => \rx_rd_ptr[4]_i_2_n_0\,
      I2 => fifo_rx_wr_en_i_1_n_0,
      I3 => \fifo_rx_cnt_reg_n_0_[4]\,
      I4 => \fifo_rx_cnt[4]_i_3_n_0\,
      O => \fifo_rx_cnt[4]_i_1_n_0\
    );
\fifo_rx_cnt[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \fifo_rx_cnt_reg_n_0_[3]\,
      I1 => \fifo_rx_cnt_reg_n_0_[1]\,
      I2 => \fifo_rx_cnt_reg_n_0_[0]\,
      I3 => \fifo_rx_cnt_reg_n_0_[2]\,
      O => \fifo_rx_cnt[4]_i_2_n_0\
    );
\fifo_rx_cnt[4]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \fifo_rx_cnt_reg_n_0_[2]\,
      I1 => \fifo_rx_cnt_reg_n_0_[1]\,
      I2 => \fifo_rx_cnt_reg_n_0_[0]\,
      I3 => \fifo_rx_cnt_reg_n_0_[3]\,
      O => \fifo_rx_cnt[4]_i_3_n_0\
    );
\fifo_rx_cnt[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F00F8844"
    )
        port map (
      I0 => \fifo_rx_cnt[5]_i_2_n_0\,
      I1 => \rx_rd_ptr[4]_i_2_n_0\,
      I2 => \fifo_rx_cnt[5]_i_3_n_0\,
      I3 => \fifo_rx_cnt_reg_n_0_[5]\,
      I4 => fifo_rx_wr_en_i_1_n_0,
      O => \fifo_rx_cnt[5]_i_1_n_0\
    );
\fifo_rx_cnt[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \fifo_rx_cnt_reg_n_0_[4]\,
      I1 => \fifo_rx_cnt_reg_n_0_[2]\,
      I2 => \fifo_rx_cnt_reg_n_0_[0]\,
      I3 => \fifo_rx_cnt_reg_n_0_[1]\,
      I4 => \fifo_rx_cnt_reg_n_0_[3]\,
      O => \fifo_rx_cnt[5]_i_2_n_0\
    );
\fifo_rx_cnt[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => \fifo_rx_cnt_reg_n_0_[3]\,
      I1 => \fifo_rx_cnt_reg_n_0_[0]\,
      I2 => \fifo_rx_cnt_reg_n_0_[1]\,
      I3 => \fifo_rx_cnt_reg_n_0_[2]\,
      I4 => \fifo_rx_cnt_reg_n_0_[4]\,
      O => \fifo_rx_cnt[5]_i_3_n_0\
    );
\fifo_rx_cnt[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFF0E"
    )
        port map (
      I0 => rx_pull_once_reg_n_0,
      I1 => fifo_rx_pull_data,
      I2 => \QSPI_STA_reg_n_0_[5]\,
      I3 => fifo_rx_wr_en_i_1_n_0,
      I4 => p_1_in,
      O => \fifo_rx_cnt[6]_i_1_n_0\
    );
\fifo_rx_cnt[6]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FF04488"
    )
        port map (
      I0 => \fifo_rx_cnt[6]_i_3_n_0\,
      I1 => \rx_rd_ptr[4]_i_2_n_0\,
      I2 => \fifo_rx_cnt[6]_i_4_n_0\,
      I3 => \fifo_rx_cnt_reg_n_0_[6]\,
      I4 => fifo_rx_wr_en_i_1_n_0,
      O => \fifo_rx_cnt[6]_i_2_n_0\
    );
\fifo_rx_cnt[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \fifo_rx_cnt_reg_n_0_[5]\,
      I1 => \fifo_rx_cnt_reg_n_0_[3]\,
      I2 => \fifo_rx_cnt_reg_n_0_[1]\,
      I3 => \fifo_rx_cnt_reg_n_0_[0]\,
      I4 => \fifo_rx_cnt_reg_n_0_[2]\,
      I5 => \fifo_rx_cnt_reg_n_0_[4]\,
      O => \fifo_rx_cnt[6]_i_3_n_0\
    );
\fifo_rx_cnt[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \fifo_rx_cnt_reg_n_0_[5]\,
      I1 => \fifo_rx_cnt_reg_n_0_[4]\,
      I2 => \fifo_rx_cnt_reg_n_0_[2]\,
      I3 => \fifo_rx_cnt_reg_n_0_[1]\,
      I4 => \fifo_rx_cnt_reg_n_0_[0]\,
      I5 => \fifo_rx_cnt_reg_n_0_[3]\,
      O => \fifo_rx_cnt[6]_i_4_n_0\
    );
\fifo_rx_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_rx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_rx_cnt[0]_i_1_n_0\,
      Q => \fifo_rx_cnt_reg_n_0_[0]\
    );
\fifo_rx_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_rx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_rx_cnt[1]_i_1_n_0\,
      Q => \fifo_rx_cnt_reg_n_0_[1]\
    );
\fifo_rx_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_rx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_rx_cnt[2]_i_1_n_0\,
      Q => \fifo_rx_cnt_reg_n_0_[2]\
    );
\fifo_rx_cnt_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_rx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_rx_cnt[3]_i_1_n_0\,
      Q => \fifo_rx_cnt_reg_n_0_[3]\
    );
\fifo_rx_cnt_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_rx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_rx_cnt[4]_i_1_n_0\,
      Q => \fifo_rx_cnt_reg_n_0_[4]\
    );
\fifo_rx_cnt_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_rx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_rx_cnt[5]_i_1_n_0\,
      Q => \fifo_rx_cnt_reg_n_0_[5]\
    );
\fifo_rx_cnt_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_rx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_rx_cnt[6]_i_2_n_0\,
      Q => \fifo_rx_cnt_reg_n_0_[6]\
    );
fifo_rx_pull_data_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04000000"
    )
        port map (
      I0 => araddr(4),
      I1 => araddr(3),
      I2 => araddr(2),
      I3 => arvalid,
      I4 => \rdata[31]_i_2_n_0\,
      O => fifo_rx_pull_data_i_1_n_0
    );
fifo_rx_pull_data_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => fifo_rx_pull_data_i_1_n_0,
      Q => fifo_rx_pull_data
    );
\fifo_rx_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(0),
      Q => fifo_rx_rdata(0),
      R => '0'
    );
\fifo_rx_rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(10),
      Q => fifo_rx_rdata(10),
      R => '0'
    );
\fifo_rx_rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(11),
      Q => fifo_rx_rdata(11),
      R => '0'
    );
\fifo_rx_rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(12),
      Q => fifo_rx_rdata(12),
      R => '0'
    );
\fifo_rx_rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(13),
      Q => fifo_rx_rdata(13),
      R => '0'
    );
\fifo_rx_rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(14),
      Q => fifo_rx_rdata(14),
      R => '0'
    );
\fifo_rx_rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(15),
      Q => fifo_rx_rdata(15),
      R => '0'
    );
\fifo_rx_rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(16),
      Q => fifo_rx_rdata(16),
      R => '0'
    );
\fifo_rx_rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(17),
      Q => fifo_rx_rdata(17),
      R => '0'
    );
\fifo_rx_rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(18),
      Q => fifo_rx_rdata(18),
      R => '0'
    );
\fifo_rx_rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(19),
      Q => fifo_rx_rdata(19),
      R => '0'
    );
\fifo_rx_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(1),
      Q => fifo_rx_rdata(1),
      R => '0'
    );
\fifo_rx_rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(20),
      Q => fifo_rx_rdata(20),
      R => '0'
    );
\fifo_rx_rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(21),
      Q => fifo_rx_rdata(21),
      R => '0'
    );
\fifo_rx_rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(22),
      Q => fifo_rx_rdata(22),
      R => '0'
    );
\fifo_rx_rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(23),
      Q => fifo_rx_rdata(23),
      R => '0'
    );
\fifo_rx_rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(24),
      Q => fifo_rx_rdata(24),
      R => '0'
    );
\fifo_rx_rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(25),
      Q => fifo_rx_rdata(25),
      R => '0'
    );
\fifo_rx_rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(26),
      Q => fifo_rx_rdata(26),
      R => '0'
    );
\fifo_rx_rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(27),
      Q => fifo_rx_rdata(27),
      R => '0'
    );
\fifo_rx_rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(28),
      Q => fifo_rx_rdata(28),
      R => '0'
    );
\fifo_rx_rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(29),
      Q => fifo_rx_rdata(29),
      R => '0'
    );
\fifo_rx_rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(2),
      Q => fifo_rx_rdata(2),
      R => '0'
    );
\fifo_rx_rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(30),
      Q => fifo_rx_rdata(30),
      R => '0'
    );
\fifo_rx_rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(31),
      Q => fifo_rx_rdata(31),
      R => '0'
    );
\fifo_rx_rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(3),
      Q => fifo_rx_rdata(3),
      R => '0'
    );
\fifo_rx_rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(4),
      Q => fifo_rx_rdata(4),
      R => '0'
    );
\fifo_rx_rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(5),
      Q => fifo_rx_rdata(5),
      R => '0'
    );
\fifo_rx_rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(6),
      Q => fifo_rx_rdata(6),
      R => '0'
    );
\fifo_rx_rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(7),
      Q => fifo_rx_rdata(7),
      R => '0'
    );
\fifo_rx_rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(8),
      Q => fifo_rx_rdata(8),
      R => '0'
    );
\fifo_rx_rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_rx_rdata0(9),
      Q => fifo_rx_rdata(9),
      R => '0'
    );
\fifo_rx_wdata[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => fifo_rx_wr_en_i_1_n_0,
      I1 => rst_n,
      O => \fifo_rx_wdata[31]_i_1_n_0\
    );
\fifo_rx_wdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(24),
      Q => fifo_rx_wdata(0),
      R => '0'
    );
\fifo_rx_wdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(18),
      Q => fifo_rx_wdata(10),
      R => '0'
    );
\fifo_rx_wdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(19),
      Q => fifo_rx_wdata(11),
      R => '0'
    );
\fifo_rx_wdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(20),
      Q => fifo_rx_wdata(12),
      R => '0'
    );
\fifo_rx_wdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(21),
      Q => fifo_rx_wdata(13),
      R => '0'
    );
\fifo_rx_wdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(22),
      Q => fifo_rx_wdata(14),
      R => '0'
    );
\fifo_rx_wdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(23),
      Q => fifo_rx_wdata(15),
      R => '0'
    );
\fifo_rx_wdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(8),
      Q => fifo_rx_wdata(16),
      R => '0'
    );
\fifo_rx_wdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(9),
      Q => fifo_rx_wdata(17),
      R => '0'
    );
\fifo_rx_wdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(10),
      Q => fifo_rx_wdata(18),
      R => '0'
    );
\fifo_rx_wdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(11),
      Q => fifo_rx_wdata(19),
      R => '0'
    );
\fifo_rx_wdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(25),
      Q => fifo_rx_wdata(1),
      R => '0'
    );
\fifo_rx_wdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(12),
      Q => fifo_rx_wdata(20),
      R => '0'
    );
\fifo_rx_wdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(13),
      Q => fifo_rx_wdata(21),
      R => '0'
    );
\fifo_rx_wdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(14),
      Q => fifo_rx_wdata(22),
      R => '0'
    );
\fifo_rx_wdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(15),
      Q => fifo_rx_wdata(23),
      R => '0'
    );
\fifo_rx_wdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(0),
      Q => fifo_rx_wdata(24),
      R => '0'
    );
\fifo_rx_wdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(1),
      Q => fifo_rx_wdata(25),
      R => '0'
    );
\fifo_rx_wdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(2),
      Q => fifo_rx_wdata(26),
      R => '0'
    );
\fifo_rx_wdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(3),
      Q => fifo_rx_wdata(27),
      R => '0'
    );
\fifo_rx_wdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(4),
      Q => fifo_rx_wdata(28),
      R => '0'
    );
\fifo_rx_wdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(5),
      Q => fifo_rx_wdata(29),
      R => '0'
    );
\fifo_rx_wdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(26),
      Q => fifo_rx_wdata(2),
      R => '0'
    );
\fifo_rx_wdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(6),
      Q => fifo_rx_wdata(30),
      R => '0'
    );
\fifo_rx_wdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(7),
      Q => fifo_rx_wdata(31),
      R => '0'
    );
\fifo_rx_wdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(27),
      Q => fifo_rx_wdata(3),
      R => '0'
    );
\fifo_rx_wdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(28),
      Q => fifo_rx_wdata(4),
      R => '0'
    );
\fifo_rx_wdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(29),
      Q => fifo_rx_wdata(5),
      R => '0'
    );
\fifo_rx_wdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(30),
      Q => fifo_rx_wdata(6),
      R => '0'
    );
\fifo_rx_wdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(31),
      Q => fifo_rx_wdata(7),
      R => '0'
    );
\fifo_rx_wdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(16),
      Q => fifo_rx_wdata(8),
      R => '0'
    );
\fifo_rx_wdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_rx_wdata[31]_i_1_n_0\,
      D => shift_byte(17),
      Q => fifo_rx_wdata(9),
      R => '0'
    );
fifo_rx_wr_en_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000002000000"
    )
        port map (
      I0 => \to_do_list_reg_n_0_[3]\,
      I1 => \to_do_list_reg_n_0_[2]\,
      I2 => \to_do_list_reg_n_0_[1]\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \fifo_status_reg_n_0_[0]\,
      I5 => r_w_reg_n_0,
      O => fifo_rx_wr_en_i_1_n_0
    );
fifo_rx_wr_en_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => fifo_rx_wr_en_i_1_n_0,
      Q => fifo_rx_wr_en
    );
\fifo_status[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0100FFFFFF000000"
    )
        port map (
      I0 => \to_do_list_reg_n_0_[3]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => \to_do_list_reg_n_0_[2]\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \fifo_status[1]_i_2_n_0\,
      I5 => \fifo_status_reg_n_0_[0]\,
      O => \fifo_status[0]_i_1_n_0\
    );
\fifo_status[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFFFFFFFF0000"
    )
        port map (
      I0 => \to_do_list_reg_n_0_[2]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => \to_do_list_reg_n_0_[3]\,
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \fifo_status[1]_i_2_n_0\,
      I5 => \fifo_status_reg_n_0_[1]\,
      O => \fifo_status[1]_i_1_n_0\
    );
\fifo_status[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEEEEEEEEEFFEF"
    )
        port map (
      I0 => \instr_shadow[7]_i_1_n_0\,
      I1 => \fifo_status[1]_i_3_n_0\,
      I2 => r_w_reg_n_0,
      I3 => qspi_falling_edge,
      I4 => \shift_byte[7]_i_3_n_0\,
      I5 => \to_do_list[1]_i_3_n_0\,
      O => \fifo_status[1]_i_2_n_0\
    );
\fifo_status[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D0D00000F0D00000"
    )
        port map (
      I0 => \to_do_list_reg_n_0_[2]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => \fifo_status_reg_n_0_[1]\,
      I3 => qspi_falling_edge,
      I4 => \fifo_status_reg_n_0_[0]\,
      I5 => \dummy_cycle[4]_i_4_n_0\,
      O => \fifo_status[1]_i_3_n_0\
    );
\fifo_status_reg[0]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => '1',
      D => \fifo_status[0]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => \fifo_status_reg_n_0_[0]\
    );
\fifo_status_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \fifo_status[1]_i_1_n_0\,
      Q => \fifo_status_reg_n_0_[1]\
    );
\fifo_tx_cnt[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AE"
    )
        port map (
      I0 => \tx_rd_ptr[5]_i_3_n_0\,
      I1 => fifo_tx_push_data,
      I2 => p_0_in27_in,
      I3 => \fifo_tx_cnt_reg_n_0_[0]\,
      O => \fifo_tx_cnt[0]_i_1_n_0\
    );
\fifo_tx_cnt[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F00F0440"
    )
        port map (
      I0 => p_0_in27_in,
      I1 => fifo_tx_push_data,
      I2 => \fifo_tx_cnt_reg_n_0_[1]\,
      I3 => \fifo_tx_cnt_reg_n_0_[0]\,
      I4 => \tx_rd_ptr[5]_i_3_n_0\,
      O => \fifo_tx_cnt[1]_i_1_n_0\
    );
\fifo_tx_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABABA10100000AA"
    )
        port map (
      I0 => \tx_rd_ptr[5]_i_3_n_0\,
      I1 => p_0_in27_in,
      I2 => fifo_tx_push_data,
      I3 => \fifo_tx_cnt_reg_n_0_[1]\,
      I4 => \fifo_tx_cnt_reg_n_0_[0]\,
      I5 => \fifo_tx_cnt_reg_n_0_[2]\,
      O => \fifo_tx_cnt[2]_i_1_n_0\
    );
\fifo_tx_cnt[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEEEEEE44000000A"
    )
        port map (
      I0 => \tx_rd_ptr[5]_i_3_n_0\,
      I1 => fifo_tx_wr_en0,
      I2 => \fifo_tx_cnt_reg_n_0_[0]\,
      I3 => \fifo_tx_cnt_reg_n_0_[1]\,
      I4 => \fifo_tx_cnt_reg_n_0_[2]\,
      I5 => \fifo_tx_cnt_reg_n_0_[3]\,
      O => \fifo_tx_cnt[3]_i_1_n_0\
    );
\fifo_tx_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88888844444744"
    )
        port map (
      I0 => \fifo_tx_cnt[4]_i_2_n_0\,
      I1 => \tx_rd_ptr[5]_i_3_n_0\,
      I2 => p_0_in27_in,
      I3 => fifo_tx_push_data,
      I4 => \fifo_tx_cnt[4]_i_3_n_0\,
      I5 => \fifo_tx_cnt_reg_n_0_[4]\,
      O => \fifo_tx_cnt[4]_i_1_n_0\
    );
\fifo_tx_cnt[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \fifo_tx_cnt_reg_n_0_[3]\,
      I1 => \fifo_tx_cnt_reg_n_0_[1]\,
      I2 => \fifo_tx_cnt_reg_n_0_[0]\,
      I3 => \fifo_tx_cnt_reg_n_0_[2]\,
      O => \fifo_tx_cnt[4]_i_2_n_0\
    );
\fifo_tx_cnt[4]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \fifo_tx_cnt_reg_n_0_[2]\,
      I1 => \fifo_tx_cnt_reg_n_0_[1]\,
      I2 => \fifo_tx_cnt_reg_n_0_[0]\,
      I3 => \fifo_tx_cnt_reg_n_0_[3]\,
      O => \fifo_tx_cnt[4]_i_3_n_0\
    );
\fifo_tx_cnt[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88888844444744"
    )
        port map (
      I0 => \fifo_tx_cnt[5]_i_2_n_0\,
      I1 => \tx_rd_ptr[5]_i_3_n_0\,
      I2 => p_0_in27_in,
      I3 => fifo_tx_push_data,
      I4 => \fifo_tx_cnt[5]_i_3_n_0\,
      I5 => \fifo_tx_cnt_reg_n_0_[5]\,
      O => \fifo_tx_cnt[5]_i_1_n_0\
    );
\fifo_tx_cnt[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \fifo_tx_cnt_reg_n_0_[4]\,
      I1 => \fifo_tx_cnt_reg_n_0_[2]\,
      I2 => \fifo_tx_cnt_reg_n_0_[0]\,
      I3 => \fifo_tx_cnt_reg_n_0_[1]\,
      I4 => \fifo_tx_cnt_reg_n_0_[3]\,
      O => \fifo_tx_cnt[5]_i_2_n_0\
    );
\fifo_tx_cnt[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => \fifo_tx_cnt_reg_n_0_[3]\,
      I1 => \fifo_tx_cnt_reg_n_0_[0]\,
      I2 => \fifo_tx_cnt_reg_n_0_[1]\,
      I3 => \fifo_tx_cnt_reg_n_0_[2]\,
      I4 => \fifo_tx_cnt_reg_n_0_[4]\,
      O => \fifo_tx_cnt[5]_i_3_n_0\
    );
\fifo_tx_cnt[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFF4"
    )
        port map (
      I0 => p_0_in27_in,
      I1 => fifo_tx_push_data,
      I2 => \tx_rd_ptr[5]_i_3_n_0\,
      I3 => \QSPI_FCR_reg_n_0_[1]\,
      O => \fifo_tx_cnt[6]_i_1_n_0\
    );
\fifo_tx_cnt[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FFFF0010201020"
    )
        port map (
      I0 => \fifo_tx_cnt[6]_i_3_n_0\,
      I1 => p_0_in27_in,
      I2 => fifo_tx_push_data,
      I3 => \fifo_tx_cnt_reg_n_0_[6]\,
      I4 => \fifo_tx_cnt[6]_i_4_n_0\,
      I5 => \tx_rd_ptr[5]_i_3_n_0\,
      O => \fifo_tx_cnt[6]_i_2_n_0\
    );
\fifo_tx_cnt[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \fifo_tx_cnt_reg_n_0_[5]\,
      I1 => \fifo_tx_cnt_reg_n_0_[4]\,
      I2 => \fifo_tx_cnt_reg_n_0_[2]\,
      I3 => \fifo_tx_cnt_reg_n_0_[1]\,
      I4 => \fifo_tx_cnt_reg_n_0_[0]\,
      I5 => \fifo_tx_cnt_reg_n_0_[3]\,
      O => \fifo_tx_cnt[6]_i_3_n_0\
    );
\fifo_tx_cnt[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \fifo_tx_cnt_reg_n_0_[5]\,
      I1 => \fifo_tx_cnt_reg_n_0_[3]\,
      I2 => \fifo_tx_cnt_reg_n_0_[1]\,
      I3 => \fifo_tx_cnt_reg_n_0_[0]\,
      I4 => \fifo_tx_cnt_reg_n_0_[2]\,
      I5 => \fifo_tx_cnt_reg_n_0_[4]\,
      O => \fifo_tx_cnt[6]_i_4_n_0\
    );
\fifo_tx_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_tx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_tx_cnt[0]_i_1_n_0\,
      Q => \fifo_tx_cnt_reg_n_0_[0]\
    );
\fifo_tx_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_tx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_tx_cnt[1]_i_1_n_0\,
      Q => \fifo_tx_cnt_reg_n_0_[1]\
    );
\fifo_tx_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_tx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_tx_cnt[2]_i_1_n_0\,
      Q => \fifo_tx_cnt_reg_n_0_[2]\
    );
\fifo_tx_cnt_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_tx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_tx_cnt[3]_i_1_n_0\,
      Q => \fifo_tx_cnt_reg_n_0_[3]\
    );
\fifo_tx_cnt_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_tx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_tx_cnt[4]_i_1_n_0\,
      Q => \fifo_tx_cnt_reg_n_0_[4]\
    );
\fifo_tx_cnt_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_tx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_tx_cnt[5]_i_1_n_0\,
      Q => \fifo_tx_cnt_reg_n_0_[5]\
    );
\fifo_tx_cnt_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \fifo_tx_cnt[6]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \fifo_tx_cnt[6]_i_2_n_0\,
      Q => \fifo_tx_cnt_reg_n_0_[6]\
    );
fifo_tx_push_data_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
        port map (
      I0 => awaddr(2),
      I1 => awaddr(1),
      I2 => awaddr(0),
      I3 => awaddr(4),
      I4 => awaddr(3),
      I5 => \QSPI_DR[31]_i_2_n_0\,
      O => fifo_tx_push_data_i_1_n_0
    );
fifo_tx_push_data_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => fifo_tx_push_data_i_1_n_0,
      Q => fifo_tx_push_data
    );
\fifo_tx_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(0),
      Q => fifo_tx_rdata(0),
      R => '0'
    );
\fifo_tx_rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(10),
      Q => fifo_tx_rdata(10),
      R => '0'
    );
\fifo_tx_rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(11),
      Q => fifo_tx_rdata(11),
      R => '0'
    );
\fifo_tx_rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(12),
      Q => fifo_tx_rdata(12),
      R => '0'
    );
\fifo_tx_rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(13),
      Q => fifo_tx_rdata(13),
      R => '0'
    );
\fifo_tx_rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(14),
      Q => fifo_tx_rdata(14),
      R => '0'
    );
\fifo_tx_rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(15),
      Q => fifo_tx_rdata(15),
      R => '0'
    );
\fifo_tx_rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(16),
      Q => fifo_tx_rdata(16),
      R => '0'
    );
\fifo_tx_rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(17),
      Q => fifo_tx_rdata(17),
      R => '0'
    );
\fifo_tx_rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(18),
      Q => fifo_tx_rdata(18),
      R => '0'
    );
\fifo_tx_rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(19),
      Q => fifo_tx_rdata(19),
      R => '0'
    );
\fifo_tx_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(1),
      Q => fifo_tx_rdata(1),
      R => '0'
    );
\fifo_tx_rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(20),
      Q => fifo_tx_rdata(20),
      R => '0'
    );
\fifo_tx_rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(21),
      Q => fifo_tx_rdata(21),
      R => '0'
    );
\fifo_tx_rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(22),
      Q => fifo_tx_rdata(22),
      R => '0'
    );
\fifo_tx_rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(23),
      Q => fifo_tx_rdata(23),
      R => '0'
    );
\fifo_tx_rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(24),
      Q => fifo_tx_rdata(24),
      R => '0'
    );
\fifo_tx_rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(25),
      Q => fifo_tx_rdata(25),
      R => '0'
    );
\fifo_tx_rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(26),
      Q => fifo_tx_rdata(26),
      R => '0'
    );
\fifo_tx_rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(27),
      Q => fifo_tx_rdata(27),
      R => '0'
    );
\fifo_tx_rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(28),
      Q => fifo_tx_rdata(28),
      R => '0'
    );
\fifo_tx_rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(29),
      Q => fifo_tx_rdata(29),
      R => '0'
    );
\fifo_tx_rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(2),
      Q => fifo_tx_rdata(2),
      R => '0'
    );
\fifo_tx_rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(30),
      Q => fifo_tx_rdata(30),
      R => '0'
    );
\fifo_tx_rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(31),
      Q => fifo_tx_rdata(31),
      R => '0'
    );
\fifo_tx_rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(3),
      Q => fifo_tx_rdata(3),
      R => '0'
    );
\fifo_tx_rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(4),
      Q => fifo_tx_rdata(4),
      R => '0'
    );
\fifo_tx_rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(5),
      Q => fifo_tx_rdata(5),
      R => '0'
    );
\fifo_tx_rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(6),
      Q => fifo_tx_rdata(6),
      R => '0'
    );
\fifo_tx_rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(7),
      Q => fifo_tx_rdata(7),
      R => '0'
    );
\fifo_tx_rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(8),
      Q => fifo_tx_rdata(8),
      R => '0'
    );
\fifo_tx_rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => fifo_tx_rdata0(9),
      Q => fifo_tx_rdata(9),
      R => '0'
    );
\fifo_tx_wdata[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => p_0_in27_in,
      I1 => fifo_tx_push_data,
      I2 => rst_n,
      O => \fifo_tx_wdata[31]_i_1_n_0\
    );
\fifo_tx_wdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[0]\,
      Q => fifo_tx_wdata(0),
      R => '0'
    );
\fifo_tx_wdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[10]\,
      Q => fifo_tx_wdata(10),
      R => '0'
    );
\fifo_tx_wdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[11]\,
      Q => fifo_tx_wdata(11),
      R => '0'
    );
\fifo_tx_wdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[12]\,
      Q => fifo_tx_wdata(12),
      R => '0'
    );
\fifo_tx_wdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[13]\,
      Q => fifo_tx_wdata(13),
      R => '0'
    );
\fifo_tx_wdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[14]\,
      Q => fifo_tx_wdata(14),
      R => '0'
    );
\fifo_tx_wdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[15]\,
      Q => fifo_tx_wdata(15),
      R => '0'
    );
\fifo_tx_wdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[16]\,
      Q => fifo_tx_wdata(16),
      R => '0'
    );
\fifo_tx_wdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[17]\,
      Q => fifo_tx_wdata(17),
      R => '0'
    );
\fifo_tx_wdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[18]\,
      Q => fifo_tx_wdata(18),
      R => '0'
    );
\fifo_tx_wdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[19]\,
      Q => fifo_tx_wdata(19),
      R => '0'
    );
\fifo_tx_wdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[1]\,
      Q => fifo_tx_wdata(1),
      R => '0'
    );
\fifo_tx_wdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[20]\,
      Q => fifo_tx_wdata(20),
      R => '0'
    );
\fifo_tx_wdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[21]\,
      Q => fifo_tx_wdata(21),
      R => '0'
    );
\fifo_tx_wdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[22]\,
      Q => fifo_tx_wdata(22),
      R => '0'
    );
\fifo_tx_wdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[23]\,
      Q => fifo_tx_wdata(23),
      R => '0'
    );
\fifo_tx_wdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[24]\,
      Q => fifo_tx_wdata(24),
      R => '0'
    );
\fifo_tx_wdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[25]\,
      Q => fifo_tx_wdata(25),
      R => '0'
    );
\fifo_tx_wdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[26]\,
      Q => fifo_tx_wdata(26),
      R => '0'
    );
\fifo_tx_wdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[27]\,
      Q => fifo_tx_wdata(27),
      R => '0'
    );
\fifo_tx_wdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[28]\,
      Q => fifo_tx_wdata(28),
      R => '0'
    );
\fifo_tx_wdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[29]\,
      Q => fifo_tx_wdata(29),
      R => '0'
    );
\fifo_tx_wdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[2]\,
      Q => fifo_tx_wdata(2),
      R => '0'
    );
\fifo_tx_wdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[30]\,
      Q => fifo_tx_wdata(30),
      R => '0'
    );
\fifo_tx_wdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[31]\,
      Q => fifo_tx_wdata(31),
      R => '0'
    );
\fifo_tx_wdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[3]\,
      Q => fifo_tx_wdata(3),
      R => '0'
    );
\fifo_tx_wdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[4]\,
      Q => fifo_tx_wdata(4),
      R => '0'
    );
\fifo_tx_wdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[5]\,
      Q => fifo_tx_wdata(5),
      R => '0'
    );
\fifo_tx_wdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[6]\,
      Q => fifo_tx_wdata(6),
      R => '0'
    );
\fifo_tx_wdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[7]\,
      Q => fifo_tx_wdata(7),
      R => '0'
    );
\fifo_tx_wdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[8]\,
      Q => fifo_tx_wdata(8),
      R => '0'
    );
\fifo_tx_wdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => \fifo_tx_wdata[31]_i_1_n_0\,
      D => \QSPI_DR_reg_n_0_[9]\,
      Q => fifo_tx_wdata(9),
      R => '0'
    );
fifo_tx_wr_en_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"4"
    )
        port map (
      I0 => p_0_in27_in,
      I1 => fifo_tx_push_data,
      O => fifo_tx_wr_en_i_1_n_0
    );
fifo_tx_wr_en_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => fifo_tx_wr_en_i_1_n_0,
      Q => fifo_tx_wr_en
    );
\instr_shadow[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000054550000"
    )
        port map (
      I0 => \QSPI_STA_reg_n_0_[1]\,
      I1 => \instr_shadow[7]_i_2_n_0\,
      I2 => \instr_shadow[7]_i_3_n_0\,
      I3 => \instr_shadow[7]_i_4_n_0\,
      I4 => \fifo_status_reg_n_0_[0]\,
      I5 => \fifo_status_reg_n_0_[1]\,
      O => \instr_shadow[7]_i_1_n_0\
    );
\instr_shadow[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
        port map (
      I0 => instr_shadow(0),
      I1 => \QSPI_CCR_reg_n_0_[0]\,
      I2 => \QSPI_CCR_reg_n_0_[1]\,
      I3 => instr_shadow(1),
      I4 => \QSPI_CCR_reg_n_0_[2]\,
      I5 => instr_shadow(2),
      O => \instr_shadow[7]_i_2_n_0\
    );
\instr_shadow[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
        port map (
      I0 => instr_shadow(3),
      I1 => \QSPI_CCR_reg_n_0_[3]\,
      I2 => \QSPI_CCR_reg_n_0_[5]\,
      I3 => instr_shadow(5),
      I4 => \QSPI_CCR_reg_n_0_[4]\,
      I5 => instr_shadow(4),
      O => \instr_shadow[7]_i_3_n_0\
    );
\instr_shadow[7]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => instr_shadow(7),
      I1 => \QSPI_CCR_reg_n_0_[7]\,
      I2 => instr_shadow(6),
      I3 => \QSPI_CCR_reg_n_0_[6]\,
      O => \instr_shadow[7]_i_4_n_0\
    );
\instr_shadow_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \instr_shadow[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \QSPI_CCR_reg_n_0_[0]\,
      Q => instr_shadow(0)
    );
\instr_shadow_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \instr_shadow[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \QSPI_CCR_reg_n_0_[1]\,
      Q => instr_shadow(1)
    );
\instr_shadow_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \instr_shadow[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \QSPI_CCR_reg_n_0_[2]\,
      Q => instr_shadow(2)
    );
\instr_shadow_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \instr_shadow[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \QSPI_CCR_reg_n_0_[3]\,
      Q => instr_shadow(3)
    );
\instr_shadow_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \instr_shadow[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \QSPI_CCR_reg_n_0_[4]\,
      Q => instr_shadow(4)
    );
\instr_shadow_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \instr_shadow[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \QSPI_CCR_reg_n_0_[5]\,
      Q => instr_shadow(5)
    );
\instr_shadow_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \instr_shadow[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \QSPI_CCR_reg_n_0_[6]\,
      Q => instr_shadow(6)
    );
\instr_shadow_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \instr_shadow[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \QSPI_CCR_reg_n_0_[7]\,
      Q => instr_shadow(7)
    );
io0_val_tristate_oe_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8FFB8B8B800"
    )
        port map (
      I0 => io0_val_tristate_oe_i_2_n_0,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \QSPI_CCR_reg_n_0_[7]\,
      I3 => io0_val_tristate_oe_i_3_n_0,
      I4 => io0_val_tristate_oe_i_4_n_0,
      I5 => io0_val_tristate_oe_reg_n_0,
      O => io0_val_tristate_oe_i_1_n_0
    );
io0_val_tristate_oe_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(28),
      I2 => shift_byte(31),
      I3 => \data_mode__0\(0),
      I4 => shift_byte(30),
      I5 => \data_mode__0\(1),
      O => io0_val_tristate_oe_i_2_n_0
    );
io0_val_tristate_oe_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
        port map (
      I0 => \instr_shadow[7]_i_1_n_0\,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \fifo_status_reg_n_0_[0]\,
      I3 => qspi_falling_edge,
      O => io0_val_tristate_oe_i_3_n_0
    );
io0_val_tristate_oe_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000000044440044"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[0]\,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \shift_byte[7]_i_4_n_0\,
      I3 => r_w_reg_n_0,
      I4 => qspi_falling_edge,
      I5 => \to_do_list[1]_i_3_n_0\,
      O => io0_val_tristate_oe_i_4_n_0
    );
io0_val_tristate_oe_reg: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => io0_val_tristate_oe_i_1_n_0,
      Q => io0_val_tristate_oe_reg_n_0,
      R => '0'
    );
io1_val_tristate_oe_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8FFB8B8B800"
    )
        port map (
      I0 => shift_byte(29),
      I1 => \data_mode__0\(2),
      I2 => shift_byte(31),
      I3 => \data_mode[2]_i_2_n_0\,
      I4 => io1_val_tristate_oe_i_2_n_0,
      I5 => io1_val_tristate_oe_reg_n_0,
      O => io1_val_tristate_oe_i_1_n_0
    );
io1_val_tristate_oe_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000400051515151"
    )
        port map (
      I0 => \shift_byte[7]_i_3_n_0\,
      I1 => r_w_reg_n_0,
      I2 => qspi_falling_edge,
      I3 => io1_val_tristate_oe_i_3_n_0,
      I4 => \data_mode__0\(0),
      I5 => \to_do_list[1]_i_3_n_0\,
      O => io1_val_tristate_oe_i_2_n_0
    );
io1_val_tristate_oe_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => \data_mode__0\(1),
      O => io1_val_tristate_oe_i_3_n_0
    );
io1_val_tristate_oe_reg: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => io1_val_tristate_oe_i_1_n_0,
      Q => io1_val_tristate_oe_reg_n_0,
      R => '0'
    );
io2_val_tristate_oe_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABB8A88"
    )
        port map (
      I0 => shift_byte(30),
      I1 => \data_mode[2]_i_2_n_0\,
      I2 => io2_val_tristate_oe_i_2_n_0,
      I3 => io2_val_tristate_oe_i_3_n_0,
      I4 => io2_val_tristate_oe_reg_n_0,
      O => io2_val_tristate_oe_i_1_n_0
    );
io2_val_tristate_oe_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA8AAAAAAAAAAAAA"
    )
        port map (
      I0 => \to_do_list[1]_i_3_n_0\,
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(2),
      I3 => \data_mode__0\(0),
      I4 => qspi_falling_edge,
      I5 => r_w_reg_n_0,
      O => io2_val_tristate_oe_i_2_n_0
    );
io2_val_tristate_oe_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000F100"
    )
        port map (
      I0 => r_w_reg_n_0,
      I1 => \to_do_list[1]_i_3_n_0\,
      I2 => qspi_falling_edge,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \fifo_status_reg_n_0_[0]\,
      O => io2_val_tristate_oe_i_3_n_0
    );
io2_val_tristate_oe_reg: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => io2_val_tristate_oe_i_1_n_0,
      Q => io2_val_tristate_oe_reg_n_0,
      R => '0'
    );
io3_val_tristate_oe_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABB8A88"
    )
        port map (
      I0 => shift_byte(31),
      I1 => \data_mode[2]_i_2_n_0\,
      I2 => io2_val_tristate_oe_i_2_n_0,
      I3 => io2_val_tristate_oe_i_3_n_0,
      I4 => io3_val_tristate_oe_reg_n_0,
      O => io3_val_tristate_oe_i_1_n_0
    );
io3_val_tristate_oe_reg: unisim.vcomponents.FDRE
     port map (
      C => clk_i,
      CE => '1',
      D => io3_val_tristate_oe_i_1_n_0,
      Q => io3_val_tristate_oe_reg_n_0,
      R => '0'
    );
prscl_cnt1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => prscl_cnt1_carry_n_0,
      CO(2) => prscl_cnt1_carry_n_1,
      CO(1) => prscl_cnt1_carry_n_2,
      CO(0) => prscl_cnt1_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_prscl_cnt1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => prscl_cnt1_carry_i_1_n_0,
      S(2) => prscl_cnt1_carry_i_2_n_0,
      S(1) => prscl_cnt1_carry_i_3_n_0,
      S(0) => prscl_cnt1_carry_i_4_n_0
    );
\prscl_cnt1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => prscl_cnt1_carry_n_0,
      CO(3) => \prscl_cnt1_carry__0_n_0\,
      CO(2) => \prscl_cnt1_carry__0_n_1\,
      CO(1) => \prscl_cnt1_carry__0_n_2\,
      CO(0) => \prscl_cnt1_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_prscl_cnt1_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \prscl_cnt1_carry__0_i_1_n_0\,
      S(2) => \prscl_cnt1_carry__0_i_2_n_0\,
      S(1) => \prscl_cnt1_carry__0_i_3_n_0\,
      S(0) => \prscl_cnt1_carry__0_i_4_n_0\
    );
\prscl_cnt1_carry__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(0),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(2),
      I4 => p_0_in_0(4),
      I5 => p_0_in_0(3),
      O => \prscl_cnt1_carry__0_i_1_n_0\
    );
\prscl_cnt1_carry__0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(0),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(2),
      I4 => p_0_in_0(4),
      I5 => p_0_in_0(3),
      O => \prscl_cnt1_carry__0_i_2_n_0\
    );
\prscl_cnt1_carry__0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(0),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(2),
      I4 => p_0_in_0(4),
      I5 => p_0_in_0(3),
      O => \prscl_cnt1_carry__0_i_3_n_0\
    );
\prscl_cnt1_carry__0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(0),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(2),
      I4 => p_0_in_0(4),
      I5 => p_0_in_0(3),
      O => \prscl_cnt1_carry__0_i_4_n_0\
    );
\prscl_cnt1_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \prscl_cnt1_carry__0_n_0\,
      CO(3) => \NLW_prscl_cnt1_carry__1_CO_UNCONNECTED\(3),
      CO(2) => prscl_cnt1,
      CO(1) => \prscl_cnt1_carry__1_n_2\,
      CO(0) => \prscl_cnt1_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_prscl_cnt1_carry__1_O_UNCONNECTED\(3 downto 0),
      S(3) => '0',
      S(2) => \prscl_cnt1_carry__1_i_1_n_0\,
      S(1) => \prscl_cnt1_carry__1_i_2_n_0\,
      S(0) => \prscl_cnt1_carry__1_i_3_n_0\
    );
\prscl_cnt1_carry__1_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(0),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(2),
      I4 => p_0_in_0(4),
      I5 => p_0_in_0(3),
      O => \prscl_cnt1_carry__1_i_1_n_0\
    );
\prscl_cnt1_carry__1_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(0),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(2),
      I4 => p_0_in_0(4),
      I5 => p_0_in_0(3),
      O => \prscl_cnt1_carry__1_i_2_n_0\
    );
\prscl_cnt1_carry__1_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(0),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(2),
      I4 => p_0_in_0(4),
      I5 => p_0_in_0(3),
      O => \prscl_cnt1_carry__1_i_3_n_0\
    );
prscl_cnt1_carry_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(0),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(2),
      I4 => p_0_in_0(4),
      I5 => p_0_in_0(3),
      O => prscl_cnt1_carry_i_1_n_0
    );
prscl_cnt1_carry_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(0),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(2),
      I4 => p_0_in_0(4),
      I5 => p_0_in_0(3),
      O => prscl_cnt1_carry_i_2_n_0
    );
prscl_cnt1_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0069"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => prscl_cnt1_carry_i_5_n_0,
      I2 => prscl_cnt_reg(5),
      I3 => prscl_cnt1_carry_i_6_n_0,
      O => prscl_cnt1_carry_i_3_n_0
    );
prscl_cnt1_carry_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4120000800084120"
    )
        port map (
      I0 => prscl_cnt_reg(0),
      I1 => prscl_cnt_reg(1),
      I2 => p_0_in_0(1),
      I3 => p_0_in_0(0),
      I4 => prscl_cnt_reg(2),
      I5 => p_0_in_0(2),
      O => prscl_cnt1_carry_i_4_n_0
    );
prscl_cnt1_carry_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => p_0_in_0(3),
      I1 => p_0_in_0(4),
      I2 => p_0_in_0(2),
      I3 => p_0_in_0(1),
      I4 => p_0_in_0(0),
      O => prscl_cnt1_carry_i_5_n_0
    );
prscl_cnt1_carry_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"777BBBBDDDDEEEE7"
    )
        port map (
      I0 => prscl_cnt_reg(3),
      I1 => p_0_in_0(4),
      I2 => p_0_in_0(2),
      I3 => prscl_cnt1_carry_i_7_n_0,
      I4 => p_0_in_0(3),
      I5 => prscl_cnt_reg(4),
      O => prscl_cnt1_carry_i_6_n_0
    );
prscl_cnt1_carry_i_7: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => p_0_in_0(0),
      I1 => p_0_in_0(1),
      O => prscl_cnt1_carry_i_7_n_0
    );
\prscl_cnt[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => prscl_cnt1,
      I1 => prscl_cnt_reg(0),
      O => p_0_in(0)
    );
\prscl_cnt[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => prscl_cnt_reg(1),
      I1 => prscl_cnt_reg(0),
      I2 => prscl_cnt1,
      O => p_0_in(1)
    );
\prscl_cnt[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1540"
    )
        port map (
      I0 => prscl_cnt1,
      I1 => prscl_cnt_reg(0),
      I2 => prscl_cnt_reg(1),
      I3 => prscl_cnt_reg(2),
      O => \prscl_cnt[2]_i_1_n_0\
    );
\prscl_cnt[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"15554000"
    )
        port map (
      I0 => prscl_cnt1,
      I1 => prscl_cnt_reg(1),
      I2 => prscl_cnt_reg(0),
      I3 => prscl_cnt_reg(2),
      I4 => prscl_cnt_reg(3),
      O => \prscl_cnt[3]_i_1_n_0\
    );
\prscl_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1555555540000000"
    )
        port map (
      I0 => prscl_cnt1,
      I1 => prscl_cnt_reg(0),
      I2 => prscl_cnt_reg(3),
      I3 => prscl_cnt_reg(1),
      I4 => prscl_cnt_reg(2),
      I5 => prscl_cnt_reg(4),
      O => \prscl_cnt[4]_i_1_n_0\
    );
\prscl_cnt[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5104"
    )
        port map (
      I0 => prscl_cnt1,
      I1 => prscl_cnt_reg(0),
      I2 => \prscl_cnt[5]_i_2_n_0\,
      I3 => prscl_cnt_reg(5),
      O => \prscl_cnt[5]_i_1_n_0\
    );
\prscl_cnt[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => prscl_cnt_reg(3),
      I1 => prscl_cnt_reg(1),
      I2 => prscl_cnt_reg(2),
      I3 => prscl_cnt_reg(4),
      O => \prscl_cnt[5]_i_2_n_0\
    );
\prscl_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => p_11_in,
      CLR => \^rst_n_0\,
      D => p_0_in(0),
      Q => prscl_cnt_reg(0)
    );
\prscl_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => p_11_in,
      CLR => \^rst_n_0\,
      D => p_0_in(1),
      Q => prscl_cnt_reg(1)
    );
\prscl_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => p_11_in,
      CLR => \^rst_n_0\,
      D => \prscl_cnt[2]_i_1_n_0\,
      Q => prscl_cnt_reg(2)
    );
\prscl_cnt_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => p_11_in,
      CLR => \^rst_n_0\,
      D => \prscl_cnt[3]_i_1_n_0\,
      Q => prscl_cnt_reg(3)
    );
\prscl_cnt_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => p_11_in,
      CLR => \^rst_n_0\,
      D => \prscl_cnt[4]_i_1_n_0\,
      Q => prscl_cnt_reg(4)
    );
\prscl_cnt_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => p_11_in,
      CLR => \^rst_n_0\,
      D => \prscl_cnt[5]_i_1_n_0\,
      Q => prscl_cnt_reg(5)
    );
qspi_falling_edge_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^qspi_cs_reg_0\,
      O => p_11_in
    );
qspi_falling_edge_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => qspi_falling_edge_i_3_n_0,
      I1 => \^qspi_sclk_reg_0\,
      I2 => qspi_falling_edge_i_4_n_0,
      O => qspi_falling_edge_i_2_n_0
    );
qspi_falling_edge_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4004100100400410"
    )
        port map (
      I0 => qspi_falling_edge_i_5_n_0,
      I1 => p_0_in_0(5),
      I2 => qspi_falling_edge_i_6_n_0,
      I3 => prscl_cnt_reg(4),
      I4 => prscl_cnt_reg(5),
      I5 => p_0_in_0(4),
      O => qspi_falling_edge_i_3_n_0
    );
qspi_falling_edge_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000100000000"
    )
        port map (
      I0 => p_0_in_0(3),
      I1 => p_0_in_0(4),
      I2 => p_0_in_0(2),
      I3 => p_0_in_0(1),
      I4 => p_0_in_0(5),
      I5 => p_0_in_0(0),
      O => qspi_falling_edge_i_4_n_0
    );
qspi_falling_edge_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EBBBBEEE"
    )
        port map (
      I0 => qspi_falling_edge_i_7_n_0,
      I1 => prscl_cnt_reg(3),
      I2 => prscl_cnt_reg(2),
      I3 => prscl_cnt_reg(1),
      I4 => p_0_in_0(3),
      O => qspi_falling_edge_i_5_n_0
    );
qspi_falling_edge_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => prscl_cnt_reg(2),
      I1 => prscl_cnt_reg(1),
      I2 => prscl_cnt_reg(3),
      O => qspi_falling_edge_i_6_n_0
    );
qspi_falling_edge_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F6FFFF6FFF6FF6FF"
    )
        port map (
      I0 => p_0_in_0(0),
      I1 => prscl_cnt_reg(0),
      I2 => prscl_cnt_reg(1),
      I3 => p_0_in_0(1),
      I4 => p_0_in_0(2),
      I5 => prscl_cnt_reg(2),
      O => qspi_falling_edge_i_7_n_0
    );
qspi_falling_edge_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => p_11_in,
      CLR => \^rst_n_0\,
      D => qspi_falling_edge_i_2_n_0,
      Q => qspi_falling_edge
    );
qspi_rising_edge_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => qspi_falling_edge_i_4_n_0,
      I1 => \^qspi_sclk_reg_0\,
      I2 => qspi_falling_edge_i_3_n_0,
      O => qspi_rising_edge_i_1_n_0
    );
qspi_rising_edge_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => p_11_in,
      CLR => \^rst_n_0\,
      D => qspi_rising_edge_i_1_n_0,
      Q => qspi_rising_edge
    );
r_w_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BB88FFFFBB883000"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[10]\,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \fifo_status_reg_n_0_[0]\,
      I3 => busy0,
      I4 => \to_do_list[1]_i_2_n_0\,
      I5 => r_w_reg_n_0,
      O => r_w_i_1_n_0
    );
r_w_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => r_w_i_1_n_0,
      Q => r_w_reg_n_0
    );
\rdata[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[0]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => p_1_in,
      O => \rdata[0]_i_1_n_0\
    );
\rdata[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[0]\,
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[0]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[0]\,
      I5 => araddr(4),
      O => \rdata[0]_i_2_n_0\
    );
\rdata[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[10]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[10]\,
      O => \rdata[10]_i_1_n_0\
    );
\rdata[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FAC000000AC"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[10]\,
      I1 => \QSPI_CCR_reg_n_0_[10]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[10]\,
      O => \rdata[10]_i_2_n_0\
    );
\rdata[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[11]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[11]\,
      O => \rdata[11]_i_1_n_0\
    );
\rdata[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FCA000000CA"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[11]\,
      I1 => \QSPI_ADR_reg_n_0_[11]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[11]\,
      O => \rdata[11]_i_2_n_0\
    );
\rdata[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[12]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[12]\,
      O => \rdata[12]_i_1_n_0\
    );
\rdata[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FAC000000AC"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[12]\,
      I1 => \QSPI_CCR_reg_n_0_[12]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[12]\,
      O => \rdata[12]_i_2_n_0\
    );
\rdata[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[13]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[13]\,
      O => \rdata[13]_i_1_n_0\
    );
\rdata[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[13]\,
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[13]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[13]\,
      I5 => araddr(4),
      O => \rdata[13]_i_2_n_0\
    );
\rdata[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[14]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[14]\,
      O => \rdata[14]_i_1_n_0\
    );
\rdata[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FCA000000CA"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[14]\,
      I1 => \QSPI_ADR_reg_n_0_[14]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[14]\,
      O => \rdata[14]_i_2_n_0\
    );
\rdata[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[15]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[15]\,
      O => \rdata[15]_i_1_n_0\
    );
\rdata[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FAC000000AC"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[15]\,
      I1 => \QSPI_CCR_reg_n_0_[15]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[15]\,
      O => \rdata[15]_i_2_n_0\
    );
\rdata[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[16]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[16]\,
      O => \rdata[16]_i_1_n_0\
    );
\rdata[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[16]\,
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[16]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[16]\,
      I5 => araddr(4),
      O => \rdata[16]_i_2_n_0\
    );
\rdata[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[17]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[17]\,
      O => \rdata[17]_i_1_n_0\
    );
\rdata[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FCA000000CA"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[17]\,
      I1 => \QSPI_ADR_reg_n_0_[17]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[17]\,
      O => \rdata[17]_i_2_n_0\
    );
\rdata[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[18]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[18]\,
      O => \rdata[18]_i_1_n_0\
    );
\rdata[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FAC000000AC"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[18]\,
      I1 => \QSPI_CCR_reg_n_0_[18]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[18]\,
      O => \rdata[18]_i_2_n_0\
    );
\rdata[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[19]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[19]\,
      O => \rdata[19]_i_1_n_0\
    );
\rdata[19]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FAC000000AC"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[19]\,
      I1 => \QSPI_CCR_reg_n_0_[19]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[19]\,
      O => \rdata[19]_i_2_n_0\
    );
\rdata[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"080808A808080808"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[1]_i_2_n_0\,
      I2 => araddr(4),
      I3 => araddr(3),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[1]\,
      O => \rdata[1]_i_1_n_0\
    );
\rdata[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \QSPI_STA_reg_n_0_[1]\,
      I1 => \QSPI_DR_read_reg_n_0_[1]\,
      I2 => araddr(3),
      I3 => \QSPI_ADR_reg_n_0_[1]\,
      I4 => araddr(2),
      I5 => \QSPI_CCR_reg_n_0_[1]\,
      O => \rdata[1]_i_2_n_0\
    );
\rdata[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[20]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[20]\,
      O => \rdata[20]_i_1_n_0\
    );
\rdata[20]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FAC000000AC"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[20]\,
      I1 => \QSPI_CCR_reg_n_0_[20]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[20]\,
      O => \rdata[20]_i_2_n_0\
    );
\rdata[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[21]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[21]\,
      O => \rdata[21]_i_1_n_0\
    );
\rdata[21]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[21]\,
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[21]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[21]\,
      I5 => araddr(4),
      O => \rdata[21]_i_2_n_0\
    );
\rdata[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[22]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[22]\,
      O => \rdata[22]_i_1_n_0\
    );
\rdata[22]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FAC000000AC"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[22]\,
      I1 => \QSPI_CCR_reg_n_0_[22]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[22]\,
      O => \rdata[22]_i_2_n_0\
    );
\rdata[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[23]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[23]\,
      O => \rdata[23]_i_1_n_0\
    );
\rdata[23]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FCA000000CA"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[23]\,
      I1 => \QSPI_ADR_reg_n_0_[23]\,
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[23]\,
      O => \rdata[23]_i_2_n_0\
    );
\rdata[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[24]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[24]\,
      O => \rdata[24]_i_1_n_0\
    );
\rdata[24]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[24]\,
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[24]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[24]\,
      I5 => araddr(4),
      O => \rdata[24]_i_2_n_0\
    );
\rdata[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[25]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[25]\,
      O => \rdata[25]_i_1_n_0\
    );
\rdata[25]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => p_0_in_0(0),
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[25]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[25]\,
      I5 => araddr(4),
      O => \rdata[25]_i_2_n_0\
    );
\rdata[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[26]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[26]\,
      O => \rdata[26]_i_1_n_0\
    );
\rdata[26]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => p_0_in_0(1),
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[26]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[26]\,
      I5 => araddr(4),
      O => \rdata[26]_i_2_n_0\
    );
\rdata[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[27]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[27]\,
      O => \rdata[27]_i_1_n_0\
    );
\rdata[27]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => p_0_in_0(2),
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[27]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[27]\,
      I5 => araddr(4),
      O => \rdata[27]_i_2_n_0\
    );
\rdata[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[28]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[28]\,
      O => \rdata[28]_i_1_n_0\
    );
\rdata[28]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000FAC000000AC"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[28]\,
      I1 => p_0_in_0(3),
      I2 => araddr(2),
      I3 => araddr(3),
      I4 => araddr(4),
      I5 => \QSPI_DR_read_reg_n_0_[28]\,
      O => \rdata[28]_i_2_n_0\
    );
\rdata[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[29]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[29]\,
      O => \rdata[29]_i_1_n_0\
    );
\rdata[29]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => p_0_in_0(4),
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[29]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[29]\,
      I5 => araddr(4),
      O => \rdata[29]_i_2_n_0\
    );
\rdata[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[2]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[2]\,
      O => \rdata[2]_i_1_n_0\
    );
\rdata[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[2]\,
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[2]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[2]\,
      I5 => araddr(4),
      O => \rdata[2]_i_2_n_0\
    );
\rdata[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[30]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[30]\,
      O => \rdata[30]_i_1_n_0\
    );
\rdata[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[30]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[30]\,
      I5 => araddr(4),
      O => \rdata[30]_i_2_n_0\
    );
\rdata[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[31]_i_3_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[31]\,
      O => \rdata[31]_i_1_n_0\
    );
\rdata[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => araddr(5),
      I1 => araddr(6),
      I2 => araddr(7),
      I3 => araddr(0),
      I4 => araddr(1),
      O => \rdata[31]_i_2_n_0\
    );
\rdata[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => p_0_in0,
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[31]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[31]\,
      I5 => araddr(4),
      O => \rdata[31]_i_3_n_0\
    );
\rdata[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888A8888888888"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[3]_i_2_n_0\,
      I2 => araddr(3),
      I3 => araddr(4),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[3]\,
      O => \rdata[3]_i_1_n_0\
    );
\rdata[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000033E200E2"
    )
        port map (
      I0 => \QSPI_CCR_reg_n_0_[3]\,
      I1 => araddr(2),
      I2 => \QSPI_ADR_reg_n_0_[3]\,
      I3 => araddr(3),
      I4 => \QSPI_DR_read_reg_n_0_[3]\,
      I5 => araddr(4),
      O => \rdata[3]_i_2_n_0\
    );
\rdata[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"080808A808080808"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[4]_i_2_n_0\,
      I2 => araddr(4),
      I3 => araddr(3),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[4]\,
      O => \rdata[4]_i_1_n_0\
    );
\rdata[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \QSPI_STA_reg_n_0_[4]\,
      I1 => \QSPI_DR_read_reg_n_0_[4]\,
      I2 => araddr(3),
      I3 => \QSPI_ADR_reg_n_0_[4]\,
      I4 => araddr(2),
      I5 => \QSPI_CCR_reg_n_0_[4]\,
      O => \rdata[4]_i_2_n_0\
    );
\rdata[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"080808A808080808"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[5]_i_2_n_0\,
      I2 => araddr(4),
      I3 => araddr(3),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[5]\,
      O => \rdata[5]_i_1_n_0\
    );
\rdata[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \QSPI_STA_reg_n_0_[5]\,
      I1 => \QSPI_DR_read_reg_n_0_[5]\,
      I2 => araddr(3),
      I3 => \QSPI_ADR_reg_n_0_[5]\,
      I4 => araddr(2),
      I5 => \QSPI_CCR_reg_n_0_[5]\,
      O => \rdata[5]_i_2_n_0\
    );
\rdata[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"080808A808080808"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[6]_i_2_n_0\,
      I2 => araddr(4),
      I3 => araddr(3),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[6]\,
      O => \rdata[6]_i_1_n_0\
    );
\rdata[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => p_0_in27_in,
      I1 => \QSPI_DR_read_reg_n_0_[6]\,
      I2 => araddr(3),
      I3 => \QSPI_ADR_reg_n_0_[6]\,
      I4 => araddr(2),
      I5 => \QSPI_CCR_reg_n_0_[6]\,
      O => \rdata[6]_i_2_n_0\
    );
\rdata[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"080808A808080808"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[7]_i_2_n_0\,
      I2 => araddr(4),
      I3 => araddr(3),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[7]\,
      O => \rdata[7]_i_1_n_0\
    );
\rdata[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \QSPI_STA_reg_n_0_[7]\,
      I1 => \QSPI_DR_read_reg_n_0_[7]\,
      I2 => araddr(3),
      I3 => \QSPI_ADR_reg_n_0_[7]\,
      I4 => araddr(2),
      I5 => \QSPI_CCR_reg_n_0_[7]\,
      O => \rdata[7]_i_2_n_0\
    );
\rdata[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"080808A808080808"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[8]_i_2_n_0\,
      I2 => araddr(4),
      I3 => araddr(3),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[8]\,
      O => \rdata[8]_i_1_n_0\
    );
\rdata[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \QSPI_STA_reg_n_0_[8]\,
      I1 => \QSPI_DR_read_reg_n_0_[8]\,
      I2 => araddr(3),
      I3 => \QSPI_ADR_reg_n_0_[8]\,
      I4 => araddr(2),
      I5 => data2(0),
      O => \rdata[8]_i_2_n_0\
    );
\rdata[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"080808A808080808"
    )
        port map (
      I0 => \rdata[31]_i_2_n_0\,
      I1 => \rdata[9]_i_2_n_0\,
      I2 => araddr(4),
      I3 => araddr(3),
      I4 => araddr(2),
      I5 => \QSPI_FCR_reg_n_0_[9]\,
      O => \rdata[9]_i_1_n_0\
    );
\rdata[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \QSPI_STA_reg_n_0_[9]\,
      I1 => \QSPI_DR_read_reg_n_0_[9]\,
      I2 => araddr(3),
      I3 => \QSPI_ADR_reg_n_0_[9]\,
      I4 => araddr(2),
      I5 => data2(1),
      O => \rdata[9]_i_2_n_0\
    );
\rdata_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[0]_i_1_n_0\,
      Q => rdata(0)
    );
\rdata_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[10]_i_1_n_0\,
      Q => rdata(10)
    );
\rdata_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[11]_i_1_n_0\,
      Q => rdata(11)
    );
\rdata_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[12]_i_1_n_0\,
      Q => rdata(12)
    );
\rdata_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[13]_i_1_n_0\,
      Q => rdata(13)
    );
\rdata_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[14]_i_1_n_0\,
      Q => rdata(14)
    );
\rdata_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[15]_i_1_n_0\,
      Q => rdata(15)
    );
\rdata_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[16]_i_1_n_0\,
      Q => rdata(16)
    );
\rdata_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[17]_i_1_n_0\,
      Q => rdata(17)
    );
\rdata_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[18]_i_1_n_0\,
      Q => rdata(18)
    );
\rdata_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[19]_i_1_n_0\,
      Q => rdata(19)
    );
\rdata_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[1]_i_1_n_0\,
      Q => rdata(1)
    );
\rdata_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[20]_i_1_n_0\,
      Q => rdata(20)
    );
\rdata_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[21]_i_1_n_0\,
      Q => rdata(21)
    );
\rdata_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[22]_i_1_n_0\,
      Q => rdata(22)
    );
\rdata_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[23]_i_1_n_0\,
      Q => rdata(23)
    );
\rdata_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[24]_i_1_n_0\,
      Q => rdata(24)
    );
\rdata_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[25]_i_1_n_0\,
      Q => rdata(25)
    );
\rdata_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[26]_i_1_n_0\,
      Q => rdata(26)
    );
\rdata_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[27]_i_1_n_0\,
      Q => rdata(27)
    );
\rdata_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[28]_i_1_n_0\,
      Q => rdata(28)
    );
\rdata_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[29]_i_1_n_0\,
      Q => rdata(29)
    );
\rdata_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[2]_i_1_n_0\,
      Q => rdata(2)
    );
\rdata_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[30]_i_1_n_0\,
      Q => rdata(30)
    );
\rdata_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[31]_i_1_n_0\,
      Q => rdata(31)
    );
\rdata_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[3]_i_1_n_0\,
      Q => rdata(3)
    );
\rdata_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[4]_i_1_n_0\,
      Q => rdata(4)
    );
\rdata_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[5]_i_1_n_0\,
      Q => rdata(5)
    );
\rdata_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[6]_i_1_n_0\,
      Q => rdata(6)
    );
\rdata_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[7]_i_1_n_0\,
      Q => rdata(7)
    );
\rdata_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[8]_i_1_n_0\,
      Q => rdata(8)
    );
\rdata_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => arvalid,
      CLR => \^rst_n_0\,
      D => \rdata[9]_i_1_n_0\,
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
      CLR => \^rst_n_0\,
      D => rvalid_i_1_n_0,
      Q => \^rvalid\
    );
rx_pull_once_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
        port map (
      I0 => rx_pull_once_reg_n_0,
      I1 => \to_do_list_reg_n_0_[2]\,
      I2 => \to_do_list_reg_n_0_[1]\,
      I3 => \to_do_list_reg_n_0_[3]\,
      I4 => \to_do_list[2]_i_2_n_0\,
      I5 => r_w_reg_n_0,
      O => rx_pull_once_i_1_n_0
    );
rx_pull_once_reg: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => rx_pull_once_i_1_n_0,
      Q => rx_pull_once_reg_n_0
    );
\rx_rd_ptr[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"000E"
    )
        port map (
      I0 => rx_pull_once_reg_n_0,
      I1 => fifo_rx_pull_data,
      I2 => \QSPI_STA_reg_n_0_[5]\,
      I3 => rx_rd_ptr(0),
      O => \rx_rd_ptr[0]_i_1_n_0\
    );
\rx_rd_ptr[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000E0E00"
    )
        port map (
      I0 => rx_pull_once_reg_n_0,
      I1 => fifo_rx_pull_data,
      I2 => \QSPI_STA_reg_n_0_[5]\,
      I3 => rx_rd_ptr(1),
      I4 => rx_rd_ptr(0),
      O => \rx_rd_ptr[1]_i_1_n_0\
    );
\rx_rd_ptr[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000E0E0E0E000000"
    )
        port map (
      I0 => rx_pull_once_reg_n_0,
      I1 => fifo_rx_pull_data,
      I2 => \QSPI_STA_reg_n_0_[5]\,
      I3 => rx_rd_ptr(0),
      I4 => rx_rd_ptr(1),
      I5 => rx_rd_ptr(2),
      O => \rx_rd_ptr[2]_i_1_n_0\
    );
\rx_rd_ptr[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2AAA8000"
    )
        port map (
      I0 => \rx_rd_ptr[4]_i_2_n_0\,
      I1 => rx_rd_ptr(1),
      I2 => rx_rd_ptr(0),
      I3 => rx_rd_ptr(2),
      I4 => rx_rd_ptr(3),
      O => \rx_rd_ptr[3]_i_1_n_0\
    );
\rx_rd_ptr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2AAAAAAA80000000"
    )
        port map (
      I0 => \rx_rd_ptr[4]_i_2_n_0\,
      I1 => rx_rd_ptr(2),
      I2 => rx_rd_ptr(0),
      I3 => rx_rd_ptr(1),
      I4 => rx_rd_ptr(3),
      I5 => rx_rd_ptr(4),
      O => \rx_rd_ptr[4]_i_1_n_0\
    );
\rx_rd_ptr[4]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
        port map (
      I0 => \QSPI_STA_reg_n_0_[5]\,
      I1 => fifo_rx_pull_data,
      I2 => rx_pull_once_reg_n_0,
      O => \rx_rd_ptr[4]_i_2_n_0\
    );
\rx_rd_ptr[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAFE"
    )
        port map (
      I0 => p_1_in,
      I1 => rx_pull_once_reg_n_0,
      I2 => fifo_rx_pull_data,
      I3 => \QSPI_STA_reg_n_0_[5]\,
      O => \rx_rd_ptr[5]_i_1_n_0\
    );
\rx_rd_ptr[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0E000E0E000E0000"
    )
        port map (
      I0 => rx_pull_once_reg_n_0,
      I1 => fifo_rx_pull_data,
      I2 => \QSPI_STA_reg_n_0_[5]\,
      I3 => \rx_rd_ptr[5]_i_3_n_0\,
      I4 => rx_rd_ptr(4),
      I5 => rx_rd_ptr(5),
      O => \rx_rd_ptr[5]_i_2_n_0\
    );
\rx_rd_ptr[5]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => rx_rd_ptr(2),
      I1 => rx_rd_ptr(0),
      I2 => rx_rd_ptr(1),
      I3 => rx_rd_ptr(3),
      O => \rx_rd_ptr[5]_i_3_n_0\
    );
\rx_rd_ptr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \rx_rd_ptr[0]_i_1_n_0\,
      Q => rx_rd_ptr(0)
    );
\rx_rd_ptr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \rx_rd_ptr[1]_i_1_n_0\,
      Q => rx_rd_ptr(1)
    );
\rx_rd_ptr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \rx_rd_ptr[2]_i_1_n_0\,
      Q => rx_rd_ptr(2)
    );
\rx_rd_ptr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \rx_rd_ptr[3]_i_1_n_0\,
      Q => rx_rd_ptr(3)
    );
\rx_rd_ptr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \rx_rd_ptr[4]_i_1_n_0\,
      Q => rx_rd_ptr(4)
    );
\rx_rd_ptr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \rx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \rx_rd_ptr[5]_i_2_n_0\,
      Q => rx_rd_ptr(5)
    );
\rx_wr_ptr[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => rx_wr_ptr(0),
      I1 => fifo_rx_wr_en_i_1_n_0,
      O => \rx_wr_ptr[0]_i_1_n_0\
    );
\rx_wr_ptr[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6F"
    )
        port map (
      I0 => rx_wr_ptr(1),
      I1 => rx_wr_ptr(0),
      I2 => fifo_rx_wr_en_i_1_n_0,
      O => \rx_wr_ptr[1]_i_1_n_0\
    );
\rx_wr_ptr[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FD5"
    )
        port map (
      I0 => fifo_rx_wr_en_i_1_n_0,
      I1 => rx_wr_ptr(0),
      I2 => rx_wr_ptr(1),
      I3 => rx_wr_ptr(2),
      O => \rx_wr_ptr[2]_i_1_n_0\
    );
\rx_wr_ptr[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFD555"
    )
        port map (
      I0 => fifo_rx_wr_en_i_1_n_0,
      I1 => rx_wr_ptr(1),
      I2 => rx_wr_ptr(0),
      I3 => rx_wr_ptr(2),
      I4 => rx_wr_ptr(3),
      O => \rx_wr_ptr[3]_i_1_n_0\
    );
\rx_wr_ptr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFD5555555"
    )
        port map (
      I0 => fifo_rx_wr_en_i_1_n_0,
      I1 => rx_wr_ptr(2),
      I2 => rx_wr_ptr(0),
      I3 => rx_wr_ptr(1),
      I4 => rx_wr_ptr(3),
      I5 => rx_wr_ptr(4),
      O => \rx_wr_ptr[4]_i_1_n_0\
    );
\rx_wr_ptr[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => p_1_in,
      I1 => fifo_rx_wr_en_i_1_n_0,
      O => \rx_wr_ptr[5]_i_1_n_0\
    );
\rx_wr_ptr[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"D2FF"
    )
        port map (
      I0 => rx_wr_ptr(4),
      I1 => \rx_wr_ptr[5]_i_3_n_0\,
      I2 => rx_wr_ptr(5),
      I3 => fifo_rx_wr_en_i_1_n_0,
      O => \rx_wr_ptr[5]_i_2_n_0\
    );
\rx_wr_ptr[5]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => rx_wr_ptr(2),
      I1 => rx_wr_ptr(0),
      I2 => rx_wr_ptr(1),
      I3 => rx_wr_ptr(3),
      O => \rx_wr_ptr[5]_i_3_n_0\
    );
\rx_wr_ptr_reg[0]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \rx_wr_ptr[5]_i_1_n_0\,
      D => \rx_wr_ptr[0]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => rx_wr_ptr(0)
    );
\rx_wr_ptr_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \rx_wr_ptr[5]_i_1_n_0\,
      D => \rx_wr_ptr[1]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => rx_wr_ptr(1)
    );
\rx_wr_ptr_reg[2]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \rx_wr_ptr[5]_i_1_n_0\,
      D => \rx_wr_ptr[2]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => rx_wr_ptr(2)
    );
\rx_wr_ptr_reg[3]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \rx_wr_ptr[5]_i_1_n_0\,
      D => \rx_wr_ptr[3]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => rx_wr_ptr(3)
    );
\rx_wr_ptr_reg[4]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \rx_wr_ptr[5]_i_1_n_0\,
      D => \rx_wr_ptr[4]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => rx_wr_ptr(4)
    );
\rx_wr_ptr_reg[5]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \rx_wr_ptr[5]_i_1_n_0\,
      D => \rx_wr_ptr[5]_i_2_n_0\,
      PRE => \^rst_n_0\,
      Q => rx_wr_ptr(5)
    );
\shift_byte[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => fifo_tx_rdata(24),
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => QSPI_IO0,
      I3 => r_w_reg_n_0,
      O => \shift_byte[0]_i_1_n_0\
    );
\shift_byte[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[2]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(18),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[10]_i_2_n_0\,
      O => \shift_byte[10]_i_1_n_0\
    );
\shift_byte[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(8),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(9),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(6),
      O => \shift_byte[10]_i_2_n_0\
    );
\shift_byte[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[3]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(19),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[11]_i_2_n_0\,
      O => \shift_byte[11]_i_1_n_0\
    );
\shift_byte[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(9),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(10),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(7),
      O => \shift_byte[11]_i_2_n_0\
    );
\shift_byte[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[4]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(20),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[12]_i_2_n_0\,
      O => \shift_byte[12]_i_1_n_0\
    );
\shift_byte[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(10),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(11),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(8),
      O => \shift_byte[12]_i_2_n_0\
    );
\shift_byte[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[5]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(21),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[13]_i_2_n_0\,
      O => \shift_byte[13]_i_1_n_0\
    );
\shift_byte[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(11),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(12),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(9),
      O => \shift_byte[13]_i_2_n_0\
    );
\shift_byte[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[6]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(22),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[14]_i_2_n_0\,
      O => \shift_byte[14]_i_1_n_0\
    );
\shift_byte[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(12),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(13),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(10),
      O => \shift_byte[14]_i_2_n_0\
    );
\shift_byte[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[7]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(23),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[15]_i_2_n_0\,
      O => \shift_byte[15]_i_1_n_0\
    );
\shift_byte[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(13),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(14),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(11),
      O => \shift_byte[15]_i_2_n_0\
    );
\shift_byte[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[8]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(8),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[16]_i_2_n_0\,
      O => \shift_byte[16]_i_1_n_0\
    );
\shift_byte[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(14),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(15),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(12),
      O => \shift_byte[16]_i_2_n_0\
    );
\shift_byte[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[9]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(9),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[17]_i_2_n_0\,
      O => \shift_byte[17]_i_1_n_0\
    );
\shift_byte[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(15),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(16),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(13),
      O => \shift_byte[17]_i_2_n_0\
    );
\shift_byte[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[10]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(10),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[18]_i_2_n_0\,
      O => \shift_byte[18]_i_1_n_0\
    );
\shift_byte[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(16),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(17),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(14),
      O => \shift_byte[18]_i_2_n_0\
    );
\shift_byte[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[11]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(11),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[19]_i_2_n_0\,
      O => \shift_byte[19]_i_1_n_0\
    );
\shift_byte[19]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(17),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(18),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(15),
      O => \shift_byte[19]_i_2_n_0\
    );
\shift_byte[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => fifo_tx_rdata(25),
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[1]_i_2_n_0\,
      O => \shift_byte[1]_i_1_n_0\
    );
\shift_byte[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1F001F0F1F001000"
    )
        port map (
      I0 => \data_mode__0\(1),
      I1 => \data_mode__0\(2),
      I2 => r_w_reg_n_0,
      I3 => shift_byte(0),
      I4 => \data_mode__0\(0),
      I5 => QSPI_IO1,
      O => \shift_byte[1]_i_2_n_0\
    );
\shift_byte[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[12]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(12),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[20]_i_2_n_0\,
      O => \shift_byte[20]_i_1_n_0\
    );
\shift_byte[20]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(18),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(19),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(16),
      O => \shift_byte[20]_i_2_n_0\
    );
\shift_byte[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[13]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(13),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[21]_i_2_n_0\,
      O => \shift_byte[21]_i_1_n_0\
    );
\shift_byte[21]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(19),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(20),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(17),
      O => \shift_byte[21]_i_2_n_0\
    );
\shift_byte[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[14]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(14),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[22]_i_2_n_0\,
      O => \shift_byte[22]_i_1_n_0\
    );
\shift_byte[22]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(20),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(21),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(18),
      O => \shift_byte[22]_i_2_n_0\
    );
\shift_byte[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[15]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(15),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[23]_i_2_n_0\,
      O => \shift_byte[23]_i_1_n_0\
    );
\shift_byte[23]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(21),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(22),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(19),
      O => \shift_byte[23]_i_2_n_0\
    );
\shift_byte[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEAAAAFEEEAAAA"
    )
        port map (
      I0 => \shift_byte[24]_i_3_n_0\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => r_w_reg_n_0,
      I3 => \to_do_list_reg_n_0_[3]\,
      I4 => \to_do_list[2]_i_2_n_0\,
      I5 => \to_do_list_reg_n_0_[2]\,
      O => \shift_byte[24]_i_1_n_0\
    );
\shift_byte[24]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[16]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(0),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[24]_i_4_n_0\,
      O => \shift_byte[24]_i_2_n_0\
    );
\shift_byte[24]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00008A8000000000"
    )
        port map (
      I0 => \shift_byte[7]_i_4_n_0\,
      I1 => qspi_falling_edge,
      I2 => r_w_reg_n_0,
      I3 => qspi_rising_edge,
      I4 => \fifo_status_reg_n_0_[0]\,
      I5 => \fifo_status_reg_n_0_[1]\,
      O => \shift_byte[24]_i_3_n_0\
    );
\shift_byte[24]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(22),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(23),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(20),
      O => \shift_byte[24]_i_4_n_0\
    );
\shift_byte[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \shift_byte[25]_i_2_n_0\,
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[25]_i_3_n_0\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \QSPI_CCR_reg_n_0_[0]\,
      O => \shift_byte[25]_i_1_n_0\
    );
\shift_byte[25]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[17]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(1),
      O => \shift_byte[25]_i_2_n_0\
    );
\shift_byte[25]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(21),
      I2 => \data_mode__0\(1),
      I3 => shift_byte(23),
      I4 => shift_byte(24),
      I5 => \data_mode__0\(0),
      O => \shift_byte[25]_i_3_n_0\
    );
\shift_byte[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \shift_byte[26]_i_2_n_0\,
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[26]_i_3_n_0\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \QSPI_CCR_reg_n_0_[1]\,
      O => \shift_byte[26]_i_1_n_0\
    );
\shift_byte[26]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[18]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(2),
      O => \shift_byte[26]_i_2_n_0\
    );
\shift_byte[26]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(22),
      I2 => \data_mode__0\(1),
      I3 => shift_byte(24),
      I4 => shift_byte(25),
      I5 => \data_mode__0\(0),
      O => \shift_byte[26]_i_3_n_0\
    );
\shift_byte[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \shift_byte[27]_i_2_n_0\,
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[27]_i_3_n_0\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \QSPI_CCR_reg_n_0_[2]\,
      O => \shift_byte[27]_i_1_n_0\
    );
\shift_byte[27]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[19]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(3),
      O => \shift_byte[27]_i_2_n_0\
    );
\shift_byte[27]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(23),
      I2 => \data_mode__0\(1),
      I3 => shift_byte(25),
      I4 => shift_byte(26),
      I5 => \data_mode__0\(0),
      O => \shift_byte[27]_i_3_n_0\
    );
\shift_byte[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \shift_byte[28]_i_2_n_0\,
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[28]_i_3_n_0\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \QSPI_CCR_reg_n_0_[3]\,
      O => \shift_byte[28]_i_1_n_0\
    );
\shift_byte[28]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[20]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(4),
      O => \shift_byte[28]_i_2_n_0\
    );
\shift_byte[28]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(24),
      I2 => \data_mode__0\(1),
      I3 => shift_byte(26),
      I4 => shift_byte(27),
      I5 => \data_mode__0\(0),
      O => \shift_byte[28]_i_3_n_0\
    );
\shift_byte[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \shift_byte[29]_i_2_n_0\,
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[29]_i_3_n_0\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \QSPI_CCR_reg_n_0_[4]\,
      O => \shift_byte[29]_i_1_n_0\
    );
\shift_byte[29]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[21]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(5),
      O => \shift_byte[29]_i_2_n_0\
    );
\shift_byte[29]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(25),
      I2 => \data_mode__0\(1),
      I3 => shift_byte(27),
      I4 => shift_byte(28),
      I5 => \data_mode__0\(0),
      O => \shift_byte[29]_i_3_n_0\
    );
\shift_byte[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAEA0000AAEAAAEA"
    )
        port map (
      I0 => \shift_byte[2]_i_2_n_0\,
      I1 => QSPI_IO2,
      I2 => \data_mode__0\(2),
      I3 => r_w_reg_n_0,
      I4 => fifo_tx_rdata(26),
      I5 => \fifo_status_reg_n_0_[0]\,
      O => \shift_byte[2]_i_1_n_0\
    );
\shift_byte[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF888"
    )
        port map (
      I0 => shift_byte(1),
      I1 => \data_mode__0\(0),
      I2 => \data_mode__0\(1),
      I3 => shift_byte(0),
      I4 => \fifo_status_reg_n_0_[0]\,
      O => \shift_byte[2]_i_2_n_0\
    );
\shift_byte[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \shift_byte[30]_i_2_n_0\,
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[30]_i_3_n_0\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \QSPI_CCR_reg_n_0_[5]\,
      O => \shift_byte[30]_i_1_n_0\
    );
\shift_byte[30]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[22]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(6),
      O => \shift_byte[30]_i_2_n_0\
    );
\shift_byte[30]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(26),
      I2 => \data_mode__0\(1),
      I3 => shift_byte(28),
      I4 => \data_mode__0\(0),
      I5 => shift_byte(29),
      O => \shift_byte[30]_i_3_n_0\
    );
\shift_byte[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \instr_shadow[7]_i_1_n_0\,
      I1 => \shift_byte[24]_i_1_n_0\,
      O => \shift_byte[31]_i_1_n_0\
    );
\shift_byte[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \shift_byte[31]_i_3_n_0\,
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[31]_i_4_n_0\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \QSPI_CCR_reg_n_0_[6]\,
      O => \shift_byte[31]_i_2_n_0\
    );
\shift_byte[31]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[23]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(7),
      O => \shift_byte[31]_i_3_n_0\
    );
\shift_byte[31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(27),
      I2 => shift_byte(29),
      I3 => \data_mode__0\(1),
      I4 => shift_byte(30),
      I5 => \data_mode__0\(0),
      O => \shift_byte[31]_i_4_n_0\
    );
\shift_byte[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAEA0000AAEAAAEA"
    )
        port map (
      I0 => \shift_byte[3]_i_2_n_0\,
      I1 => QSPI_IO3,
      I2 => \data_mode__0\(2),
      I3 => r_w_reg_n_0,
      I4 => fifo_tx_rdata(27),
      I5 => \fifo_status_reg_n_0_[0]\,
      O => \shift_byte[3]_i_1_n_0\
    );
\shift_byte[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF888"
    )
        port map (
      I0 => shift_byte(2),
      I1 => \data_mode__0\(0),
      I2 => \data_mode__0\(1),
      I3 => shift_byte(1),
      I4 => \fifo_status_reg_n_0_[0]\,
      O => \shift_byte[3]_i_2_n_0\
    );
\shift_byte[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => fifo_tx_rdata(28),
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[4]_i_2_n_0\,
      O => \shift_byte[4]_i_1_n_0\
    );
\shift_byte[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(0),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(3),
      I4 => shift_byte(2),
      I5 => \data_mode__0\(1),
      O => \shift_byte[4]_i_2_n_0\
    );
\shift_byte[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => fifo_tx_rdata(29),
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[5]_i_2_n_0\,
      O => \shift_byte[5]_i_1_n_0\
    );
\shift_byte[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(4),
      I4 => shift_byte(3),
      I5 => \data_mode__0\(1),
      O => \shift_byte[5]_i_2_n_0\
    );
\shift_byte[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => fifo_tx_rdata(30),
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[6]_i_2_n_0\,
      O => \shift_byte[6]_i_1_n_0\
    );
\shift_byte[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(2),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(5),
      I4 => shift_byte(4),
      I5 => \data_mode__0\(1),
      O => \shift_byte[6]_i_2_n_0\
    );
\shift_byte[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBAAABAAAAAAAAA"
    )
        port map (
      I0 => \tx_rd_ptr[5]_i_3_n_0\,
      I1 => \shift_byte[7]_i_3_n_0\,
      I2 => qspi_rising_edge,
      I3 => r_w_reg_n_0,
      I4 => qspi_falling_edge,
      I5 => \shift_byte[7]_i_4_n_0\,
      O => \shift_byte[7]_i_1_n_0\
    );
\shift_byte[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => fifo_tx_rdata(31),
      I1 => \fifo_status_reg_n_0_[0]\,
      I2 => \shift_byte[7]_i_5_n_0\,
      O => \shift_byte[7]_i_2_n_0\
    );
\shift_byte[7]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[0]\,
      I1 => \fifo_status_reg_n_0_[1]\,
      O => \shift_byte[7]_i_3_n_0\
    );
\shift_byte[7]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"16"
    )
        port map (
      I0 => \data_mode__0\(0),
      I1 => \data_mode__0\(2),
      I2 => \data_mode__0\(1),
      O => \shift_byte[7]_i_4_n_0\
    );
\shift_byte[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \data_mode__0\(2),
      I1 => shift_byte(3),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(6),
      I4 => shift_byte(5),
      I5 => \data_mode__0\(1),
      O => \shift_byte[7]_i_5_n_0\
    );
\shift_byte[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[0]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(16),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[8]_i_2_n_0\,
      O => \shift_byte[8]_i_1_n_0\
    );
\shift_byte[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(6),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(7),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(4),
      O => \shift_byte[8]_i_2_n_0\
    );
\shift_byte[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \QSPI_ADR_reg_n_0_[1]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => fifo_tx_rdata(17),
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \shift_byte[9]_i_2_n_0\,
      O => \shift_byte[9]_i_1_n_0\
    );
\shift_byte[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => shift_byte(7),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => shift_byte(8),
      I4 => \data_mode__0\(2),
      I5 => shift_byte(5),
      O => \shift_byte[9]_i_2_n_0\
    );
\shift_byte_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[0]_i_1_n_0\,
      Q => shift_byte(0)
    );
\shift_byte_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[10]_i_1_n_0\,
      Q => shift_byte(10)
    );
\shift_byte_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[11]_i_1_n_0\,
      Q => shift_byte(11)
    );
\shift_byte_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[12]_i_1_n_0\,
      Q => shift_byte(12)
    );
\shift_byte_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[13]_i_1_n_0\,
      Q => shift_byte(13)
    );
\shift_byte_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[14]_i_1_n_0\,
      Q => shift_byte(14)
    );
\shift_byte_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[15]_i_1_n_0\,
      Q => shift_byte(15)
    );
\shift_byte_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[16]_i_1_n_0\,
      Q => shift_byte(16)
    );
\shift_byte_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[17]_i_1_n_0\,
      Q => shift_byte(17)
    );
\shift_byte_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[18]_i_1_n_0\,
      Q => shift_byte(18)
    );
\shift_byte_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[19]_i_1_n_0\,
      Q => shift_byte(19)
    );
\shift_byte_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[1]_i_1_n_0\,
      Q => shift_byte(1)
    );
\shift_byte_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[20]_i_1_n_0\,
      Q => shift_byte(20)
    );
\shift_byte_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[21]_i_1_n_0\,
      Q => shift_byte(21)
    );
\shift_byte_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[22]_i_1_n_0\,
      Q => shift_byte(22)
    );
\shift_byte_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[23]_i_1_n_0\,
      Q => shift_byte(23)
    );
\shift_byte_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[24]_i_2_n_0\,
      Q => shift_byte(24)
    );
\shift_byte_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[31]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[25]_i_1_n_0\,
      Q => shift_byte(25)
    );
\shift_byte_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[31]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[26]_i_1_n_0\,
      Q => shift_byte(26)
    );
\shift_byte_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[31]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[27]_i_1_n_0\,
      Q => shift_byte(27)
    );
\shift_byte_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[31]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[28]_i_1_n_0\,
      Q => shift_byte(28)
    );
\shift_byte_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[31]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[29]_i_1_n_0\,
      Q => shift_byte(29)
    );
\shift_byte_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[2]_i_1_n_0\,
      Q => shift_byte(2)
    );
\shift_byte_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[31]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[30]_i_1_n_0\,
      Q => shift_byte(30)
    );
\shift_byte_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[31]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[31]_i_2_n_0\,
      Q => shift_byte(31)
    );
\shift_byte_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[3]_i_1_n_0\,
      Q => shift_byte(3)
    );
\shift_byte_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[4]_i_1_n_0\,
      Q => shift_byte(4)
    );
\shift_byte_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[5]_i_1_n_0\,
      Q => shift_byte(5)
    );
\shift_byte_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[6]_i_1_n_0\,
      Q => shift_byte(6)
    );
\shift_byte_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[7]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[7]_i_2_n_0\,
      Q => shift_byte(7)
    );
\shift_byte_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[8]_i_1_n_0\,
      Q => shift_byte(8)
    );
\shift_byte_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_byte[24]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_byte[9]_i_1_n_0\,
      Q => shift_byte(9)
    );
\shift_cnt[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"14FF"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[0]\,
      I1 => \shift_cnt__0\(0),
      I2 => \data_mode__0\(0),
      I3 => \fifo_status_reg_n_0_[1]\,
      O => \shift_cnt[0]_i_1_n_0\
    );
\shift_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"14411414FFFFFFFF"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[0]\,
      I1 => \shift_cnt__0\(1),
      I2 => \data_mode__0\(1),
      I3 => \shift_cnt__0\(0),
      I4 => \data_mode__0\(0),
      I5 => \fifo_status_reg_n_0_[1]\,
      O => \shift_cnt[1]_i_1_n_0\
    );
\shift_cnt[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0096FFFF"
    )
        port map (
      I0 => \shift_cnt__0\(2),
      I1 => \data_mode__0\(2),
      I2 => \shift_cnt[2]_i_2_n_0\,
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \fifo_status_reg_n_0_[1]\,
      O => \shift_cnt[2]_i_1_n_0\
    );
\shift_cnt[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \data_mode__0\(0),
      I1 => \shift_cnt__0\(0),
      I2 => \shift_cnt__0\(1),
      I3 => \data_mode__0\(1),
      O => \shift_cnt[2]_i_2_n_0\
    );
\shift_cnt[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0900"
    )
        port map (
      I0 => \shift_cnt__0\(3),
      I1 => \shift_cnt[3]_i_2_n_0\,
      I2 => \fifo_status_reg_n_0_[0]\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \shift_cnt[3]_i_3_n_0\,
      O => \shift_cnt[3]_i_1_n_0\
    );
\shift_cnt[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D0FD0000FFFFD0FD"
    )
        port map (
      I0 => \data_mode__0\(0),
      I1 => \shift_cnt__0\(0),
      I2 => \shift_cnt__0\(1),
      I3 => \data_mode__0\(1),
      I4 => \shift_cnt__0\(2),
      I5 => \data_mode__0\(2),
      O => \shift_cnt[3]_i_2_n_0\
    );
\shift_cnt[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888000"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[0]\,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => sel0(0),
      I3 => \to_do_list[2]_i_3_n_0\,
      I4 => \to_do_list_reg_n_0_[1]\,
      O => \shift_cnt[3]_i_3_n_0\
    );
\shift_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A2A2A2A2A2020202"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[1]\,
      I1 => \shift_cnt[4]_i_2_n_0\,
      I2 => \fifo_status_reg_n_0_[0]\,
      I3 => sel0(1),
      I4 => \to_do_list[2]_i_3_n_0\,
      I5 => \to_do_list_reg_n_0_[1]\,
      O => \shift_cnt[4]_i_1_n_0\
    );
\shift_cnt[4]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"56"
    )
        port map (
      I0 => \shift_cnt__0\(4),
      I1 => \shift_cnt[3]_i_2_n_0\,
      I2 => \shift_cnt__0\(3),
      O => \shift_cnt[4]_i_2_n_0\
    );
\shift_cnt[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF44F0"
    )
        port map (
      I0 => \shift_cnt[5]_i_3_n_0\,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \shift_cnt[5]_i_4_n_0\,
      I3 => \fifo_status_reg_n_0_[0]\,
      I4 => \instr_shadow[7]_i_1_n_0\,
      O => \shift_cnt[5]_i_1_n_0\
    );
\shift_cnt[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020202A2"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[1]\,
      I1 => \shift_cnt[5]_i_5_n_0\,
      I2 => \fifo_status_reg_n_0_[0]\,
      I3 => \to_do_list[2]_i_3_n_0\,
      I4 => \to_do_list_reg_n_0_[1]\,
      O => \shift_cnt[5]_i_2_n_0\
    );
\shift_cnt[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01005555"
    )
        port map (
      I0 => \to_do_list_reg_n_0_[1]\,
      I1 => sel0(1),
      I2 => sel0(0),
      I3 => \to_do_list[2]_i_3_n_0\,
      I4 => \data_byte_size[7]_i_3_n_0\,
      O => \shift_cnt[5]_i_3_n_0\
    );
\shift_cnt[5]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \to_do_list[1]_i_3_n_0\,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => qspi_falling_edge,
      O => \shift_cnt[5]_i_4_n_0\
    );
\shift_cnt[5]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5556"
    )
        port map (
      I0 => \shift_cnt__0\(5),
      I1 => \shift_cnt[3]_i_2_n_0\,
      I2 => \shift_cnt__0\(4),
      I3 => \shift_cnt__0\(3),
      O => \shift_cnt[5]_i_5_n_0\
    );
\shift_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_cnt[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_cnt[0]_i_1_n_0\,
      Q => \shift_cnt__0\(0)
    );
\shift_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_cnt[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_cnt[1]_i_1_n_0\,
      Q => \shift_cnt__0\(1)
    );
\shift_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_cnt[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_cnt[2]_i_1_n_0\,
      Q => \shift_cnt__0\(2)
    );
\shift_cnt_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_cnt[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_cnt[3]_i_1_n_0\,
      Q => \shift_cnt__0\(3)
    );
\shift_cnt_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_cnt[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_cnt[4]_i_1_n_0\,
      Q => \shift_cnt__0\(4)
    );
\shift_cnt_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \shift_cnt[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \shift_cnt[5]_i_2_n_0\,
      Q => \shift_cnt__0\(5)
    );
\to_do_list[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"555554F0"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[1]\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => \to_do_list_reg_n_0_[0]\,
      I3 => \to_do_list[0]_i_2_n_0\,
      I4 => \to_do_list[3]_i_2_n_0\,
      O => \to_do_list[0]_i_1_n_0\
    );
\to_do_list[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000D0000000000"
    )
        port map (
      I0 => r_w_reg_n_0,
      I1 => qspi_falling_edge,
      I2 => \fifo_status_reg_n_0_[0]\,
      I3 => \fifo_status_reg_n_0_[1]\,
      I4 => \to_do_list[0]_i_3_n_0\,
      I5 => \to_do_list[0]_i_4_n_0\,
      O => \to_do_list[0]_i_2_n_0\
    );
\to_do_list[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => \shift_cnt__0\(1),
      I1 => \data_mode__0\(1),
      I2 => \data_mode__0\(0),
      I3 => \shift_cnt__0\(0),
      O => \to_do_list[0]_i_3_n_0\
    );
\to_do_list[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000009"
    )
        port map (
      I0 => \shift_cnt__0\(2),
      I1 => \data_mode__0\(2),
      I2 => \shift_cnt__0\(4),
      I3 => \shift_cnt__0\(3),
      I4 => \shift_cnt__0\(5),
      O => \to_do_list[0]_i_4_n_0\
    );
\to_do_list[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"222F2220"
    )
        port map (
      I0 => address,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \to_do_list[1]_i_2_n_0\,
      I3 => \to_do_list[3]_i_2_n_0\,
      I4 => \to_do_list_reg_n_0_[1]\,
      O => \to_do_list[1]_i_1_n_0\
    );
\to_do_list[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000D000D0000"
    )
        port map (
      I0 => r_w_reg_n_0,
      I1 => qspi_falling_edge,
      I2 => \shift_byte[7]_i_3_n_0\,
      I3 => \to_do_list[1]_i_3_n_0\,
      I4 => \to_do_list_reg_n_0_[0]\,
      I5 => \to_do_list_reg_n_0_[1]\,
      O => \to_do_list[1]_i_2_n_0\
    );
\to_do_list[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6FF6FFFF"
    )
        port map (
      I0 => \shift_cnt__0\(0),
      I1 => \data_mode__0\(0),
      I2 => \data_mode__0\(1),
      I3 => \shift_cnt__0\(1),
      I4 => \to_do_list[0]_i_4_n_0\,
      O => \to_do_list[1]_i_3_n_0\
    );
\to_do_list[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2F2F2FFF2F2F2F00"
    )
        port map (
      I0 => \to_do_list[2]_i_2_n_0\,
      I1 => \to_do_list[2]_i_3_n_0\,
      I2 => \to_do_list[2]_i_4_n_0\,
      I3 => \to_do_list[3]_i_2_n_0\,
      I4 => \to_do_list[2]_i_5_n_0\,
      I5 => \to_do_list_reg_n_0_[2]\,
      O => \to_do_list[2]_i_1_n_0\
    );
\to_do_list[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[1]\,
      I1 => \fifo_status_reg_n_0_[0]\,
      O => \to_do_list[2]_i_2_n_0\
    );
\to_do_list[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => sel0(5),
      I1 => sel0(4),
      I2 => sel0(3),
      I3 => sel0(2),
      I4 => sel0(6),
      I5 => sel0(7),
      O => \to_do_list[2]_i_3_n_0\
    );
\to_do_list[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAAAAB"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[1]\,
      I1 => \QSPI_CCR_reg_n_0_[14]\,
      I2 => \QSPI_CCR_reg_n_0_[15]\,
      I3 => \QSPI_CCR_reg_n_0_[11]\,
      I4 => \QSPI_CCR_reg_n_0_[13]\,
      I5 => \QSPI_CCR_reg_n_0_[12]\,
      O => \to_do_list[2]_i_4_n_0\
    );
\to_do_list[2]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ABAAAAAA"
    )
        port map (
      I0 => \to_do_list[2]_i_6_n_0\,
      I1 => \to_do_list_reg_n_0_[0]\,
      I2 => \to_do_list_reg_n_0_[1]\,
      I3 => \to_do_list_reg_n_0_[2]\,
      I4 => \to_do_list[0]_i_2_n_0\,
      O => \to_do_list[2]_i_5_n_0\
    );
\to_do_list[2]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000E20000"
    )
        port map (
      I0 => \to_do_list_reg_n_0_[3]\,
      I1 => \to_do_list_reg_n_0_[2]\,
      I2 => \to_do_list[2]_i_7_n_0\,
      I3 => \to_do_list[2]_i_3_n_0\,
      I4 => \to_do_list[2]_i_2_n_0\,
      I5 => \to_do_list_reg_n_0_[1]\,
      O => \to_do_list[2]_i_6_n_0\
    );
\to_do_list[2]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
        port map (
      I0 => qspi_falling_edge,
      I1 => \dummy_cycle__0\(4),
      I2 => \dummy_cycle__0\(3),
      I3 => \dummy_cycle__0\(2),
      I4 => \dummy_cycle__0\(1),
      I5 => \dummy_cycle__0\(0),
      O => \to_do_list[2]_i_7_n_0\
    );
\to_do_list[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"545454FF54545400"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[1]\,
      I1 => data2(0),
      I2 => data2(1),
      I3 => \to_do_list[3]_i_2_n_0\,
      I4 => \to_do_list[3]_i_3_n_0\,
      I5 => \to_do_list_reg_n_0_[3]\,
      O => \to_do_list[3]_i_1_n_0\
    );
\to_do_list[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ABAAAAAA"
    )
        port map (
      I0 => \instr_shadow[7]_i_1_n_0\,
      I1 => sel0(1),
      I2 => sel0(0),
      I3 => \to_do_list[2]_i_3_n_0\,
      I4 => \to_do_list[0]_i_2_n_0\,
      O => \to_do_list[3]_i_2_n_0\
    );
\to_do_list[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000200"
    )
        port map (
      I0 => \to_do_list[0]_i_2_n_0\,
      I1 => \to_do_list_reg_n_0_[1]\,
      I2 => \to_do_list_reg_n_0_[2]\,
      I3 => \to_do_list_reg_n_0_[3]\,
      I4 => \to_do_list_reg_n_0_[0]\,
      O => \to_do_list[3]_i_3_n_0\
    );
\to_do_list_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \to_do_list[0]_i_1_n_0\,
      Q => \to_do_list_reg_n_0_[0]\
    );
\to_do_list_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \to_do_list[1]_i_1_n_0\,
      Q => \to_do_list_reg_n_0_[1]\
    );
\to_do_list_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \to_do_list[2]_i_1_n_0\,
      Q => \to_do_list_reg_n_0_[2]\
    );
\to_do_list_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => '1',
      CLR => \^rst_n_0\,
      D => \to_do_list[3]_i_1_n_0\,
      Q => \to_do_list_reg_n_0_[3]\
    );
\tx_rd_ptr[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0070"
    )
        port map (
      I0 => \tx_rd_ptr[5]_i_4_n_0\,
      I1 => tx_rd_ptr(5),
      I2 => \tx_rd_ptr[5]_i_3_n_0\,
      I3 => tx_rd_ptr(0),
      O => \tx_rd_ptr[0]_i_1_n_0\
    );
\tx_rd_ptr[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00707000"
    )
        port map (
      I0 => \tx_rd_ptr[5]_i_4_n_0\,
      I1 => tx_rd_ptr(5),
      I2 => \tx_rd_ptr[5]_i_3_n_0\,
      I3 => tx_rd_ptr(1),
      I4 => tx_rd_ptr(0),
      O => \tx_rd_ptr[1]_i_1_n_0\
    );
\tx_rd_ptr[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0070707070000000"
    )
        port map (
      I0 => \tx_rd_ptr[5]_i_4_n_0\,
      I1 => tx_rd_ptr(5),
      I2 => \tx_rd_ptr[5]_i_3_n_0\,
      I3 => tx_rd_ptr(0),
      I4 => tx_rd_ptr(1),
      I5 => tx_rd_ptr(2),
      O => \tx_rd_ptr[2]_i_1_n_0\
    );
\tx_rd_ptr[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAA0000"
    )
        port map (
      I0 => tx_rd_ptr(3),
      I1 => tx_rd_ptr(2),
      I2 => tx_rd_ptr(0),
      I3 => tx_rd_ptr(1),
      I4 => \tx_rd_ptr[5]_i_3_n_0\,
      O => \tx_rd_ptr[3]_i_1_n_0\
    );
\tx_rd_ptr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2888888888888888"
    )
        port map (
      I0 => \tx_rd_ptr[5]_i_3_n_0\,
      I1 => tx_rd_ptr(4),
      I2 => tx_rd_ptr(2),
      I3 => tx_rd_ptr(0),
      I4 => tx_rd_ptr(1),
      I5 => tx_rd_ptr(3),
      O => \tx_rd_ptr[4]_i_1_n_0\
    );
\tx_rd_ptr[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \QSPI_FCR_reg_n_0_[1]\,
      I1 => \tx_rd_ptr[5]_i_3_n_0\,
      O => \tx_rd_ptr[5]_i_1_n_0\
    );
\tx_rd_ptr[5]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => \tx_rd_ptr[5]_i_3_n_0\,
      I1 => tx_rd_ptr(5),
      I2 => \tx_rd_ptr[5]_i_4_n_0\,
      O => \tx_rd_ptr[5]_i_2_n_0\
    );
\tx_rd_ptr[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000008000"
    )
        port map (
      I0 => \fifo_status_reg_n_0_[0]\,
      I1 => \fifo_status_reg_n_0_[1]\,
      I2 => \to_do_list_reg_n_0_[3]\,
      I3 => r_w_reg_n_0,
      I4 => \to_do_list_reg_n_0_[2]\,
      I5 => \to_do_list_reg_n_0_[1]\,
      O => \tx_rd_ptr[5]_i_3_n_0\
    );
\tx_rd_ptr[5]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => tx_rd_ptr(4),
      I1 => tx_rd_ptr(3),
      I2 => tx_rd_ptr(1),
      I3 => tx_rd_ptr(0),
      I4 => tx_rd_ptr(2),
      O => \tx_rd_ptr[5]_i_4_n_0\
    );
\tx_rd_ptr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \tx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \tx_rd_ptr[0]_i_1_n_0\,
      Q => tx_rd_ptr(0)
    );
\tx_rd_ptr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \tx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \tx_rd_ptr[1]_i_1_n_0\,
      Q => tx_rd_ptr(1)
    );
\tx_rd_ptr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \tx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \tx_rd_ptr[2]_i_1_n_0\,
      Q => tx_rd_ptr(2)
    );
\tx_rd_ptr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \tx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \tx_rd_ptr[3]_i_1_n_0\,
      Q => tx_rd_ptr(3)
    );
\tx_rd_ptr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \tx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \tx_rd_ptr[4]_i_1_n_0\,
      Q => tx_rd_ptr(4)
    );
\tx_rd_ptr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_i,
      CE => \tx_rd_ptr[5]_i_1_n_0\,
      CLR => \^rst_n_0\,
      D => \tx_rd_ptr[5]_i_2_n_0\,
      Q => tx_rd_ptr(5)
    );
\tx_wr_ptr[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
        port map (
      I0 => tx_wr_ptr(0),
      I1 => p_0_in27_in,
      I2 => fifo_tx_push_data,
      O => \tx_wr_ptr[0]_i_1_n_0\
    );
\tx_wr_ptr[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F6FF"
    )
        port map (
      I0 => tx_wr_ptr(1),
      I1 => tx_wr_ptr(0),
      I2 => p_0_in27_in,
      I3 => fifo_tx_push_data,
      O => \tx_wr_ptr[1]_i_1_n_0\
    );
\tx_wr_ptr[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFFFBBB"
    )
        port map (
      I0 => p_0_in27_in,
      I1 => fifo_tx_push_data,
      I2 => tx_wr_ptr(0),
      I3 => tx_wr_ptr(1),
      I4 => tx_wr_ptr(2),
      O => \tx_wr_ptr[2]_i_1_n_0\
    );
\tx_wr_ptr[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFFFBBBBBBB"
    )
        port map (
      I0 => p_0_in27_in,
      I1 => fifo_tx_push_data,
      I2 => tx_wr_ptr(1),
      I3 => tx_wr_ptr(0),
      I4 => tx_wr_ptr(2),
      I5 => tx_wr_ptr(3),
      O => \tx_wr_ptr[3]_i_1_n_0\
    );
\tx_wr_ptr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFD5555555"
    )
        port map (
      I0 => fifo_tx_wr_en0,
      I1 => tx_wr_ptr(2),
      I2 => tx_wr_ptr(0),
      I3 => tx_wr_ptr(1),
      I4 => tx_wr_ptr(3),
      I5 => tx_wr_ptr(4),
      O => \tx_wr_ptr[4]_i_1_n_0\
    );
\tx_wr_ptr[4]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => fifo_tx_push_data,
      I1 => p_0_in27_in,
      O => fifo_tx_wr_en0
    );
\tx_wr_ptr[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => \QSPI_FCR_reg_n_0_[1]\,
      I1 => p_0_in27_in,
      I2 => fifo_tx_push_data,
      O => \tx_wr_ptr[5]_i_1_n_0\
    );
\tx_wr_ptr[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFD2FFFF"
    )
        port map (
      I0 => tx_wr_ptr(4),
      I1 => \tx_wr_ptr[5]_i_3_n_0\,
      I2 => tx_wr_ptr(5),
      I3 => p_0_in27_in,
      I4 => fifo_tx_push_data,
      O => \tx_wr_ptr[5]_i_2_n_0\
    );
\tx_wr_ptr[5]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => tx_wr_ptr(2),
      I1 => tx_wr_ptr(0),
      I2 => tx_wr_ptr(1),
      I3 => tx_wr_ptr(3),
      O => \tx_wr_ptr[5]_i_3_n_0\
    );
\tx_wr_ptr_reg[0]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \tx_wr_ptr[5]_i_1_n_0\,
      D => \tx_wr_ptr[0]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => tx_wr_ptr(0)
    );
\tx_wr_ptr_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \tx_wr_ptr[5]_i_1_n_0\,
      D => \tx_wr_ptr[1]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => tx_wr_ptr(1)
    );
\tx_wr_ptr_reg[2]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \tx_wr_ptr[5]_i_1_n_0\,
      D => \tx_wr_ptr[2]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => tx_wr_ptr(2)
    );
\tx_wr_ptr_reg[3]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \tx_wr_ptr[5]_i_1_n_0\,
      D => \tx_wr_ptr[3]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => tx_wr_ptr(3)
    );
\tx_wr_ptr_reg[4]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \tx_wr_ptr[5]_i_1_n_0\,
      D => \tx_wr_ptr[4]_i_1_n_0\,
      PRE => \^rst_n_0\,
      Q => tx_wr_ptr(4)
    );
\tx_wr_ptr_reg[5]\: unisim.vcomponents.FDPE
     port map (
      C => clk_i,
      CE => \tx_wr_ptr[5]_i_1_n_0\,
      D => \tx_wr_ptr[5]_i_2_n_0\,
      PRE => \^rst_n_0\,
      Q => tx_wr_ptr(5)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
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
    rvalid : out STD_LOGIC;
    QSPI_SCLK : out STD_LOGIC;
    QSPI_CS : out STD_LOGIC;
    QSPI_IO0 : inout STD_LOGIC;
    QSPI_IO1 : inout STD_LOGIC;
    QSPI_IO2 : inout STD_LOGIC;
    QSPI_IO3 : inout STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "design_1_QSPI_Master_AXI4_Lite_0_0,QSPI_Master_AXI4_Lite,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "QSPI_Master_AXI4_Lite,Vivado 2025.2";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \<const0>\ : STD_LOGIC;
  signal QSPI_IO0_INST_0_i_1_n_0 : STD_LOGIC;
  signal QSPI_IO1_INST_0_i_1_n_0 : STD_LOGIC;
  signal QSPI_IO2_INST_0_i_1_n_0 : STD_LOGIC;
  signal \^awready\ : STD_LOGIC;
  signal inst_n_0 : STD_LOGIC;
  signal inst_n_7 : STD_LOGIC;
  signal inst_n_8 : STD_LOGIC;
  signal inst_n_9 : STD_LOGIC;
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
QSPI_IO0_INST_0_i_1: unisim.vcomponents.FDCE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk_i,
      CE => '1',
      CLR => inst_n_0,
      D => inst_n_7,
      Q => QSPI_IO0_INST_0_i_1_n_0
    );
QSPI_IO1_INST_0_i_1: unisim.vcomponents.FDCE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk_i,
      CE => '1',
      CLR => inst_n_0,
      D => inst_n_9,
      Q => QSPI_IO1_INST_0_i_1_n_0
    );
QSPI_IO2_INST_0_i_1: unisim.vcomponents.FDCE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk_i,
      CE => '1',
      CLR => inst_n_0,
      D => inst_n_8,
      Q => QSPI_IO2_INST_0_i_1_n_0
    );
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_QSPI_Master_AXI4_Lite
     port map (
      QSPI_CS_reg_0 => QSPI_CS,
      QSPI_IO0 => QSPI_IO0,
      QSPI_IO0_INST_0_i_1 => QSPI_IO0_INST_0_i_1_n_0,
      QSPI_IO1 => QSPI_IO1,
      QSPI_IO1_INST_0_i_1 => inst_n_9,
      QSPI_IO1_INST_0_i_1_0 => QSPI_IO1_INST_0_i_1_n_0,
      QSPI_IO2 => QSPI_IO2,
      QSPI_IO2_INST_0_i_1 => inst_n_8,
      QSPI_IO2_INST_0_i_1_0 => QSPI_IO2_INST_0_i_1_n_0,
      QSPI_IO3 => QSPI_IO3,
      QSPI_SCLK_reg_0 => QSPI_SCLK,
      araddr(7 downto 0) => araddr(7 downto 0),
      arready => arready,
      arvalid => arvalid,
      awaddr(7 downto 0) => awaddr(7 downto 0),
      awready => \^awready\,
      awvalid => awvalid,
      bready => bready,
      bvalid => bvalid,
      clk_i => clk_i,
      \fifo_status_reg[1]_0\ => inst_n_7,
      rdata(31 downto 0) => rdata(31 downto 0),
      rready => rready,
      rst_n => rst_n,
      rst_n_0 => inst_n_0,
      rvalid => rvalid,
      wdata(31 downto 0) => wdata(31 downto 0),
      wvalid => wvalid
    );
end STRUCTURE;
