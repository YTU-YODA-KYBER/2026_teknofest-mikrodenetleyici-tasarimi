-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
-- Date        : Sat May  9 17:16:57 2026
-- Host        : Stradale running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_Instr_Splitter_0_0/design_1_Instr_Splitter_0_0_sim_netlist.vhdl
-- Design      : design_1_Instr_Splitter_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Instr_Splitter_0_0_Instr_Splitter is
  port (
    axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    b_rvalid : in STD_LOGIC;
    i_rvalid : in STD_LOGIC;
    i_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    b_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    i_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_Instr_Splitter_0_0_Instr_Splitter : entity is "Instr_Splitter";
end design_1_Instr_Splitter_0_0_Instr_Splitter;

architecture STRUCTURE of design_1_Instr_Splitter_0_0_Instr_Splitter is
begin
\axi_rdata[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(0),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(0),
      O => axi_rdata(0)
    );
\axi_rdata[10]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(10),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(10),
      O => axi_rdata(10)
    );
\axi_rdata[11]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(11),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(11),
      O => axi_rdata(11)
    );
\axi_rdata[12]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(12),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(12),
      O => axi_rdata(12)
    );
\axi_rdata[13]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(13),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(13),
      O => axi_rdata(13)
    );
\axi_rdata[14]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(14),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(14),
      O => axi_rdata(14)
    );
\axi_rdata[15]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(15),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(15),
      O => axi_rdata(15)
    );
\axi_rdata[16]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(16),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(16),
      O => axi_rdata(16)
    );
\axi_rdata[17]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(17),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(17),
      O => axi_rdata(17)
    );
\axi_rdata[18]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(18),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(18),
      O => axi_rdata(18)
    );
\axi_rdata[19]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(19),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(19),
      O => axi_rdata(19)
    );
\axi_rdata[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(1),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(1),
      O => axi_rdata(1)
    );
\axi_rdata[20]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(20),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(20),
      O => axi_rdata(20)
    );
\axi_rdata[21]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(21),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(21),
      O => axi_rdata(21)
    );
\axi_rdata[22]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(22),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(22),
      O => axi_rdata(22)
    );
\axi_rdata[23]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(23),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(23),
      O => axi_rdata(23)
    );
\axi_rdata[24]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(24),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(24),
      O => axi_rdata(24)
    );
\axi_rdata[25]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(25),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(25),
      O => axi_rdata(25)
    );
\axi_rdata[26]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(26),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(26),
      O => axi_rdata(26)
    );
\axi_rdata[27]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(27),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(27),
      O => axi_rdata(27)
    );
\axi_rdata[28]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(28),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(28),
      O => axi_rdata(28)
    );
\axi_rdata[29]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(29),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(29),
      O => axi_rdata(29)
    );
\axi_rdata[2]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(2),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(2),
      O => axi_rdata(2)
    );
\axi_rdata[30]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(30),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(30),
      O => axi_rdata(30)
    );
\axi_rdata[31]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(31),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(31),
      O => axi_rdata(31)
    );
\axi_rdata[3]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(3),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(3),
      O => axi_rdata(3)
    );
\axi_rdata[4]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(4),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(4),
      O => axi_rdata(4)
    );
\axi_rdata[5]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(5),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(5),
      O => axi_rdata(5)
    );
\axi_rdata[6]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(6),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(6),
      O => axi_rdata(6)
    );
\axi_rdata[7]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(7),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(7),
      O => axi_rdata(7)
    );
\axi_rdata[8]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(8),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(8),
      O => axi_rdata(8)
    );
\axi_rdata[9]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rdata(9),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rdata(9),
      O => axi_rdata(9)
    );
\axi_rresp[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rresp(0),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rresp(0),
      O => axi_rresp(0)
    );
\axi_rresp[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B888"
    )
        port map (
      I0 => b_rresp(1),
      I1 => b_rvalid,
      I2 => i_rvalid,
      I3 => i_rresp(1),
      O => axi_rresp(1)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Instr_Splitter_0_0 is
  port (
    clk_i : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    axi_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_awvalid : in STD_LOGIC;
    axi_awready : out STD_LOGIC;
    axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_wlast : in STD_LOGIC;
    axi_wvalid : in STD_LOGIC;
    axi_wready : out STD_LOGIC;
    axi_bready : in STD_LOGIC;
    axi_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_bvalid : out STD_LOGIC;
    axi_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_arvalid : in STD_LOGIC;
    axi_arready : out STD_LOGIC;
    axi_rready : in STD_LOGIC;
    axi_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_rlast : out STD_LOGIC;
    axi_rvalid : out STD_LOGIC;
    i_awid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    i_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    i_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    i_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    i_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    i_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    i_awvalid : out STD_LOGIC;
    i_awready : in STD_LOGIC;
    i_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    i_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    i_wlast : out STD_LOGIC;
    i_wvalid : out STD_LOGIC;
    i_wready : in STD_LOGIC;
    i_bready : out STD_LOGIC;
    i_bid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    i_bvalid : in STD_LOGIC;
    i_arid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    i_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    i_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    i_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    i_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    i_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    i_arvalid : out STD_LOGIC;
    i_arready : in STD_LOGIC;
    i_rready : out STD_LOGIC;
    i_rid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    i_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    i_rlast : in STD_LOGIC;
    i_rvalid : in STD_LOGIC;
    b_awid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    b_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    b_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    b_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    b_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    b_awvalid : out STD_LOGIC;
    b_awready : in STD_LOGIC;
    b_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    b_wlast : out STD_LOGIC;
    b_wvalid : out STD_LOGIC;
    b_wready : in STD_LOGIC;
    b_bready : out STD_LOGIC;
    b_bid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    b_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    b_bvalid : in STD_LOGIC;
    b_arid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    b_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    b_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    b_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    b_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    b_arvalid : out STD_LOGIC;
    b_arready : in STD_LOGIC;
    b_rready : out STD_LOGIC;
    b_rid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    b_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    b_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    b_rlast : in STD_LOGIC;
    b_rvalid : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_Instr_Splitter_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_Instr_Splitter_0_0 : entity is "design_1_Instr_Splitter_0_0,Instr_Splitter,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_Instr_Splitter_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_Instr_Splitter_0_0 : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_Instr_Splitter_0_0 : entity is "Instr_Splitter,Vivado 2025.2";
end design_1_Instr_Splitter_0_0;

architecture STRUCTURE of design_1_Instr_Splitter_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^axi_araddr\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_arready_INST_0_i_1_n_0 : STD_LOGIC;
  signal axi_arready_INST_0_i_2_n_0 : STD_LOGIC;
  signal axi_arready_INST_0_i_3_n_0 : STD_LOGIC;
  signal axi_arready_INST_0_i_4_n_0 : STD_LOGIC;
  signal \^axi_rready\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of axi_arready : signal is "xilinx.com:interface:aximm:1.0 axi ARREADY";
  attribute X_INTERFACE_INFO of axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 axi ARVALID";
  attribute X_INTERFACE_INFO of axi_awready : signal is "xilinx.com:interface:aximm:1.0 axi AWREADY";
  attribute X_INTERFACE_INFO of axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 axi AWVALID";
  attribute X_INTERFACE_INFO of axi_bready : signal is "xilinx.com:interface:aximm:1.0 axi BREADY";
  attribute X_INTERFACE_INFO of axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 axi BVALID";
  attribute X_INTERFACE_INFO of axi_rlast : signal is "xilinx.com:interface:aximm:1.0 axi RLAST";
  attribute X_INTERFACE_INFO of axi_rready : signal is "xilinx.com:interface:aximm:1.0 axi RREADY";
  attribute X_INTERFACE_INFO of axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 axi RVALID";
  attribute X_INTERFACE_INFO of axi_wlast : signal is "xilinx.com:interface:aximm:1.0 axi WLAST";
  attribute X_INTERFACE_INFO of axi_wready : signal is "xilinx.com:interface:aximm:1.0 axi WREADY";
  attribute X_INTERFACE_INFO of axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 axi WVALID";
  attribute X_INTERFACE_INFO of b_arready : signal is "xilinx.com:interface:aximm:1.0 b ARREADY";
  attribute X_INTERFACE_INFO of b_arvalid : signal is "xilinx.com:interface:aximm:1.0 b ARVALID";
  attribute X_INTERFACE_INFO of b_awready : signal is "xilinx.com:interface:aximm:1.0 b AWREADY";
  attribute X_INTERFACE_INFO of b_awvalid : signal is "xilinx.com:interface:aximm:1.0 b AWVALID";
  attribute X_INTERFACE_INFO of b_bready : signal is "xilinx.com:interface:aximm:1.0 b BREADY";
  attribute X_INTERFACE_INFO of b_bvalid : signal is "xilinx.com:interface:aximm:1.0 b BVALID";
  attribute X_INTERFACE_INFO of b_rlast : signal is "xilinx.com:interface:aximm:1.0 b RLAST";
  attribute X_INTERFACE_INFO of b_rready : signal is "xilinx.com:interface:aximm:1.0 b RREADY";
  attribute X_INTERFACE_INFO of b_rvalid : signal is "xilinx.com:interface:aximm:1.0 b RVALID";
  attribute X_INTERFACE_INFO of b_wlast : signal is "xilinx.com:interface:aximm:1.0 b WLAST";
  attribute X_INTERFACE_INFO of b_wready : signal is "xilinx.com:interface:aximm:1.0 b WREADY";
  attribute X_INTERFACE_INFO of b_wvalid : signal is "xilinx.com:interface:aximm:1.0 b WVALID";
  attribute X_INTERFACE_INFO of clk_i : signal is "xilinx.com:signal:clock:1.0 clk_i CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk_i : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk_i : signal is "XIL_INTERFACENAME clk_i, FREQ_TOLERANCE_HZ 0, ASSOCIATED_BUSIF b:i:axi, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of i_arready : signal is "xilinx.com:interface:aximm:1.0 i ARREADY";
  attribute X_INTERFACE_INFO of i_arvalid : signal is "xilinx.com:interface:aximm:1.0 i ARVALID";
  attribute X_INTERFACE_INFO of i_awready : signal is "xilinx.com:interface:aximm:1.0 i AWREADY";
  attribute X_INTERFACE_INFO of i_awvalid : signal is "xilinx.com:interface:aximm:1.0 i AWVALID";
  attribute X_INTERFACE_INFO of i_bready : signal is "xilinx.com:interface:aximm:1.0 i BREADY";
  attribute X_INTERFACE_INFO of i_bvalid : signal is "xilinx.com:interface:aximm:1.0 i BVALID";
  attribute X_INTERFACE_INFO of i_rlast : signal is "xilinx.com:interface:aximm:1.0 i RLAST";
  attribute X_INTERFACE_INFO of i_rready : signal is "xilinx.com:interface:aximm:1.0 i RREADY";
  attribute X_INTERFACE_INFO of i_rvalid : signal is "xilinx.com:interface:aximm:1.0 i RVALID";
  attribute X_INTERFACE_INFO of i_wlast : signal is "xilinx.com:interface:aximm:1.0 i WLAST";
  attribute X_INTERFACE_INFO of i_wready : signal is "xilinx.com:interface:aximm:1.0 i WREADY";
  attribute X_INTERFACE_INFO of i_wvalid : signal is "xilinx.com:interface:aximm:1.0 i WVALID";
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_MODE of rst_n : signal is "slave";
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, ASSOCIATED_RESET rst_n, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of axi_araddr : signal is "xilinx.com:interface:aximm:1.0 axi ARADDR";
  attribute X_INTERFACE_INFO of axi_arburst : signal is "xilinx.com:interface:aximm:1.0 axi ARBURST";
  attribute X_INTERFACE_INFO of axi_arid : signal is "xilinx.com:interface:aximm:1.0 axi ARID";
  attribute X_INTERFACE_INFO of axi_arlen : signal is "xilinx.com:interface:aximm:1.0 axi ARLEN";
  attribute X_INTERFACE_INFO of axi_arprot : signal is "xilinx.com:interface:aximm:1.0 axi ARPROT";
  attribute X_INTERFACE_INFO of axi_arsize : signal is "xilinx.com:interface:aximm:1.0 axi ARSIZE";
  attribute X_INTERFACE_INFO of axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 axi AWADDR";
  attribute X_INTERFACE_INFO of axi_awburst : signal is "xilinx.com:interface:aximm:1.0 axi AWBURST";
  attribute X_INTERFACE_INFO of axi_awid : signal is "xilinx.com:interface:aximm:1.0 axi AWID";
  attribute X_INTERFACE_MODE of axi_awid : signal is "slave";
  attribute X_INTERFACE_PARAMETER of axi_awid : signal is "XIL_INTERFACENAME axi, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of axi_awlen : signal is "xilinx.com:interface:aximm:1.0 axi AWLEN";
  attribute X_INTERFACE_INFO of axi_awprot : signal is "xilinx.com:interface:aximm:1.0 axi AWPROT";
  attribute X_INTERFACE_INFO of axi_awsize : signal is "xilinx.com:interface:aximm:1.0 axi AWSIZE";
  attribute X_INTERFACE_INFO of axi_bid : signal is "xilinx.com:interface:aximm:1.0 axi BID";
  attribute X_INTERFACE_INFO of axi_bresp : signal is "xilinx.com:interface:aximm:1.0 axi BRESP";
  attribute X_INTERFACE_INFO of axi_rdata : signal is "xilinx.com:interface:aximm:1.0 axi RDATA";
  attribute X_INTERFACE_INFO of axi_rid : signal is "xilinx.com:interface:aximm:1.0 axi RID";
  attribute X_INTERFACE_INFO of axi_rresp : signal is "xilinx.com:interface:aximm:1.0 axi RRESP";
  attribute X_INTERFACE_INFO of axi_wdata : signal is "xilinx.com:interface:aximm:1.0 axi WDATA";
  attribute X_INTERFACE_INFO of axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 axi WSTRB";
  attribute X_INTERFACE_INFO of b_araddr : signal is "xilinx.com:interface:aximm:1.0 b ARADDR";
  attribute X_INTERFACE_INFO of b_arburst : signal is "xilinx.com:interface:aximm:1.0 b ARBURST";
  attribute X_INTERFACE_INFO of b_arid : signal is "xilinx.com:interface:aximm:1.0 b ARID";
  attribute X_INTERFACE_INFO of b_arlen : signal is "xilinx.com:interface:aximm:1.0 b ARLEN";
  attribute X_INTERFACE_INFO of b_arprot : signal is "xilinx.com:interface:aximm:1.0 b ARPROT";
  attribute X_INTERFACE_INFO of b_arsize : signal is "xilinx.com:interface:aximm:1.0 b ARSIZE";
  attribute X_INTERFACE_INFO of b_awaddr : signal is "xilinx.com:interface:aximm:1.0 b AWADDR";
  attribute X_INTERFACE_INFO of b_awburst : signal is "xilinx.com:interface:aximm:1.0 b AWBURST";
  attribute X_INTERFACE_INFO of b_awid : signal is "xilinx.com:interface:aximm:1.0 b AWID";
  attribute X_INTERFACE_MODE of b_awid : signal is "master";
  attribute X_INTERFACE_PARAMETER of b_awid : signal is "XIL_INTERFACENAME b, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of b_awlen : signal is "xilinx.com:interface:aximm:1.0 b AWLEN";
  attribute X_INTERFACE_INFO of b_awprot : signal is "xilinx.com:interface:aximm:1.0 b AWPROT";
  attribute X_INTERFACE_INFO of b_awsize : signal is "xilinx.com:interface:aximm:1.0 b AWSIZE";
  attribute X_INTERFACE_INFO of b_bid : signal is "xilinx.com:interface:aximm:1.0 b BID";
  attribute X_INTERFACE_INFO of b_bresp : signal is "xilinx.com:interface:aximm:1.0 b BRESP";
  attribute X_INTERFACE_INFO of b_rdata : signal is "xilinx.com:interface:aximm:1.0 b RDATA";
  attribute X_INTERFACE_INFO of b_rid : signal is "xilinx.com:interface:aximm:1.0 b RID";
  attribute X_INTERFACE_INFO of b_rresp : signal is "xilinx.com:interface:aximm:1.0 b RRESP";
  attribute X_INTERFACE_INFO of b_wdata : signal is "xilinx.com:interface:aximm:1.0 b WDATA";
  attribute X_INTERFACE_INFO of b_wstrb : signal is "xilinx.com:interface:aximm:1.0 b WSTRB";
  attribute X_INTERFACE_INFO of i_araddr : signal is "xilinx.com:interface:aximm:1.0 i ARADDR";
  attribute X_INTERFACE_INFO of i_arburst : signal is "xilinx.com:interface:aximm:1.0 i ARBURST";
  attribute X_INTERFACE_INFO of i_arid : signal is "xilinx.com:interface:aximm:1.0 i ARID";
  attribute X_INTERFACE_INFO of i_arlen : signal is "xilinx.com:interface:aximm:1.0 i ARLEN";
  attribute X_INTERFACE_INFO of i_arprot : signal is "xilinx.com:interface:aximm:1.0 i ARPROT";
  attribute X_INTERFACE_INFO of i_arsize : signal is "xilinx.com:interface:aximm:1.0 i ARSIZE";
  attribute X_INTERFACE_INFO of i_awaddr : signal is "xilinx.com:interface:aximm:1.0 i AWADDR";
  attribute X_INTERFACE_INFO of i_awburst : signal is "xilinx.com:interface:aximm:1.0 i AWBURST";
  attribute X_INTERFACE_INFO of i_awid : signal is "xilinx.com:interface:aximm:1.0 i AWID";
  attribute X_INTERFACE_MODE of i_awid : signal is "master";
  attribute X_INTERFACE_PARAMETER of i_awid : signal is "XIL_INTERFACENAME i, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of i_awlen : signal is "xilinx.com:interface:aximm:1.0 i AWLEN";
  attribute X_INTERFACE_INFO of i_awprot : signal is "xilinx.com:interface:aximm:1.0 i AWPROT";
  attribute X_INTERFACE_INFO of i_awsize : signal is "xilinx.com:interface:aximm:1.0 i AWSIZE";
  attribute X_INTERFACE_INFO of i_bid : signal is "xilinx.com:interface:aximm:1.0 i BID";
  attribute X_INTERFACE_INFO of i_bresp : signal is "xilinx.com:interface:aximm:1.0 i BRESP";
  attribute X_INTERFACE_INFO of i_rdata : signal is "xilinx.com:interface:aximm:1.0 i RDATA";
  attribute X_INTERFACE_INFO of i_rid : signal is "xilinx.com:interface:aximm:1.0 i RID";
  attribute X_INTERFACE_INFO of i_rresp : signal is "xilinx.com:interface:aximm:1.0 i RRESP";
  attribute X_INTERFACE_INFO of i_wdata : signal is "xilinx.com:interface:aximm:1.0 i WDATA";
  attribute X_INTERFACE_INFO of i_wstrb : signal is "xilinx.com:interface:aximm:1.0 i WSTRB";
begin
  \^axi_araddr\(31 downto 0) <= axi_araddr(31 downto 0);
  \^axi_rready\ <= axi_rready;
  axi_awready <= \<const0>\;
  axi_bid(3) <= \<const0>\;
  axi_bid(2) <= \<const0>\;
  axi_bid(1) <= \<const0>\;
  axi_bid(0) <= \<const0>\;
  axi_bresp(1) <= \<const0>\;
  axi_bresp(0) <= \<const0>\;
  axi_bvalid <= \<const0>\;
  axi_rid(3) <= \<const0>\;
  axi_rid(2) <= \<const0>\;
  axi_rid(1) <= \<const0>\;
  axi_rid(0) <= \<const0>\;
  axi_rlast <= \<const0>\;
  axi_wready <= \<const0>\;
  b_araddr(31 downto 0) <= \^axi_araddr\(31 downto 0);
  b_arburst(1) <= \<const0>\;
  b_arburst(0) <= \<const0>\;
  b_arid(3) <= \<const0>\;
  b_arid(2) <= \<const0>\;
  b_arid(1) <= \<const0>\;
  b_arid(0) <= \<const0>\;
  b_arlen(7) <= \<const0>\;
  b_arlen(6) <= \<const0>\;
  b_arlen(5) <= \<const0>\;
  b_arlen(4) <= \<const0>\;
  b_arlen(3) <= \<const0>\;
  b_arlen(2) <= \<const0>\;
  b_arlen(1) <= \<const0>\;
  b_arlen(0) <= \<const0>\;
  b_arprot(2) <= \<const0>\;
  b_arprot(1) <= \<const0>\;
  b_arprot(0) <= \<const0>\;
  b_arsize(2) <= \<const0>\;
  b_arsize(1) <= \<const0>\;
  b_arsize(0) <= \<const0>\;
  b_awaddr(31) <= \<const0>\;
  b_awaddr(30) <= \<const0>\;
  b_awaddr(29) <= \<const0>\;
  b_awaddr(28) <= \<const0>\;
  b_awaddr(27) <= \<const0>\;
  b_awaddr(26) <= \<const0>\;
  b_awaddr(25) <= \<const0>\;
  b_awaddr(24) <= \<const0>\;
  b_awaddr(23) <= \<const0>\;
  b_awaddr(22) <= \<const0>\;
  b_awaddr(21) <= \<const0>\;
  b_awaddr(20) <= \<const0>\;
  b_awaddr(19) <= \<const0>\;
  b_awaddr(18) <= \<const0>\;
  b_awaddr(17) <= \<const0>\;
  b_awaddr(16) <= \<const0>\;
  b_awaddr(15) <= \<const0>\;
  b_awaddr(14) <= \<const0>\;
  b_awaddr(13) <= \<const0>\;
  b_awaddr(12) <= \<const0>\;
  b_awaddr(11) <= \<const0>\;
  b_awaddr(10) <= \<const0>\;
  b_awaddr(9) <= \<const0>\;
  b_awaddr(8) <= \<const0>\;
  b_awaddr(7) <= \<const0>\;
  b_awaddr(6) <= \<const0>\;
  b_awaddr(5) <= \<const0>\;
  b_awaddr(4) <= \<const0>\;
  b_awaddr(3) <= \<const0>\;
  b_awaddr(2) <= \<const0>\;
  b_awaddr(1) <= \<const0>\;
  b_awaddr(0) <= \<const0>\;
  b_awburst(1) <= \<const0>\;
  b_awburst(0) <= \<const0>\;
  b_awid(3) <= \<const0>\;
  b_awid(2) <= \<const0>\;
  b_awid(1) <= \<const0>\;
  b_awid(0) <= \<const0>\;
  b_awlen(7) <= \<const0>\;
  b_awlen(6) <= \<const0>\;
  b_awlen(5) <= \<const0>\;
  b_awlen(4) <= \<const0>\;
  b_awlen(3) <= \<const0>\;
  b_awlen(2) <= \<const0>\;
  b_awlen(1) <= \<const0>\;
  b_awlen(0) <= \<const0>\;
  b_awprot(2) <= \<const0>\;
  b_awprot(1) <= \<const0>\;
  b_awprot(0) <= \<const0>\;
  b_awsize(2) <= \<const0>\;
  b_awsize(1) <= \<const0>\;
  b_awsize(0) <= \<const0>\;
  b_awvalid <= \<const0>\;
  b_bready <= \<const0>\;
  b_rready <= \^axi_rready\;
  b_wdata(31) <= \<const0>\;
  b_wdata(30) <= \<const0>\;
  b_wdata(29) <= \<const0>\;
  b_wdata(28) <= \<const0>\;
  b_wdata(27) <= \<const0>\;
  b_wdata(26) <= \<const0>\;
  b_wdata(25) <= \<const0>\;
  b_wdata(24) <= \<const0>\;
  b_wdata(23) <= \<const0>\;
  b_wdata(22) <= \<const0>\;
  b_wdata(21) <= \<const0>\;
  b_wdata(20) <= \<const0>\;
  b_wdata(19) <= \<const0>\;
  b_wdata(18) <= \<const0>\;
  b_wdata(17) <= \<const0>\;
  b_wdata(16) <= \<const0>\;
  b_wdata(15) <= \<const0>\;
  b_wdata(14) <= \<const0>\;
  b_wdata(13) <= \<const0>\;
  b_wdata(12) <= \<const0>\;
  b_wdata(11) <= \<const0>\;
  b_wdata(10) <= \<const0>\;
  b_wdata(9) <= \<const0>\;
  b_wdata(8) <= \<const0>\;
  b_wdata(7) <= \<const0>\;
  b_wdata(6) <= \<const0>\;
  b_wdata(5) <= \<const0>\;
  b_wdata(4) <= \<const0>\;
  b_wdata(3) <= \<const0>\;
  b_wdata(2) <= \<const0>\;
  b_wdata(1) <= \<const0>\;
  b_wdata(0) <= \<const0>\;
  b_wlast <= \<const0>\;
  b_wstrb(3) <= \<const0>\;
  b_wstrb(2) <= \<const0>\;
  b_wstrb(1) <= \<const0>\;
  b_wstrb(0) <= \<const0>\;
  b_wvalid <= \<const0>\;
  i_araddr(31 downto 0) <= \^axi_araddr\(31 downto 0);
  i_arburst(1) <= \<const0>\;
  i_arburst(0) <= \<const0>\;
  i_arid(3) <= \<const0>\;
  i_arid(2) <= \<const0>\;
  i_arid(1) <= \<const0>\;
  i_arid(0) <= \<const0>\;
  i_arlen(7) <= \<const0>\;
  i_arlen(6) <= \<const0>\;
  i_arlen(5) <= \<const0>\;
  i_arlen(4) <= \<const0>\;
  i_arlen(3) <= \<const0>\;
  i_arlen(2) <= \<const0>\;
  i_arlen(1) <= \<const0>\;
  i_arlen(0) <= \<const0>\;
  i_arprot(2) <= \<const0>\;
  i_arprot(1) <= \<const0>\;
  i_arprot(0) <= \<const0>\;
  i_arsize(2) <= \<const0>\;
  i_arsize(1) <= \<const0>\;
  i_arsize(0) <= \<const0>\;
  i_awaddr(31) <= \<const0>\;
  i_awaddr(30) <= \<const0>\;
  i_awaddr(29) <= \<const0>\;
  i_awaddr(28) <= \<const0>\;
  i_awaddr(27) <= \<const0>\;
  i_awaddr(26) <= \<const0>\;
  i_awaddr(25) <= \<const0>\;
  i_awaddr(24) <= \<const0>\;
  i_awaddr(23) <= \<const0>\;
  i_awaddr(22) <= \<const0>\;
  i_awaddr(21) <= \<const0>\;
  i_awaddr(20) <= \<const0>\;
  i_awaddr(19) <= \<const0>\;
  i_awaddr(18) <= \<const0>\;
  i_awaddr(17) <= \<const0>\;
  i_awaddr(16) <= \<const0>\;
  i_awaddr(15) <= \<const0>\;
  i_awaddr(14) <= \<const0>\;
  i_awaddr(13) <= \<const0>\;
  i_awaddr(12) <= \<const0>\;
  i_awaddr(11) <= \<const0>\;
  i_awaddr(10) <= \<const0>\;
  i_awaddr(9) <= \<const0>\;
  i_awaddr(8) <= \<const0>\;
  i_awaddr(7) <= \<const0>\;
  i_awaddr(6) <= \<const0>\;
  i_awaddr(5) <= \<const0>\;
  i_awaddr(4) <= \<const0>\;
  i_awaddr(3) <= \<const0>\;
  i_awaddr(2) <= \<const0>\;
  i_awaddr(1) <= \<const0>\;
  i_awaddr(0) <= \<const0>\;
  i_awburst(1) <= \<const0>\;
  i_awburst(0) <= \<const0>\;
  i_awid(3) <= \<const0>\;
  i_awid(2) <= \<const0>\;
  i_awid(1) <= \<const0>\;
  i_awid(0) <= \<const0>\;
  i_awlen(7) <= \<const0>\;
  i_awlen(6) <= \<const0>\;
  i_awlen(5) <= \<const0>\;
  i_awlen(4) <= \<const0>\;
  i_awlen(3) <= \<const0>\;
  i_awlen(2) <= \<const0>\;
  i_awlen(1) <= \<const0>\;
  i_awlen(0) <= \<const0>\;
  i_awprot(2) <= \<const0>\;
  i_awprot(1) <= \<const0>\;
  i_awprot(0) <= \<const0>\;
  i_awsize(2) <= \<const0>\;
  i_awsize(1) <= \<const0>\;
  i_awsize(0) <= \<const0>\;
  i_awvalid <= \<const0>\;
  i_bready <= \<const0>\;
  i_rready <= \^axi_rready\;
  i_wdata(31) <= \<const0>\;
  i_wdata(30) <= \<const0>\;
  i_wdata(29) <= \<const0>\;
  i_wdata(28) <= \<const0>\;
  i_wdata(27) <= \<const0>\;
  i_wdata(26) <= \<const0>\;
  i_wdata(25) <= \<const0>\;
  i_wdata(24) <= \<const0>\;
  i_wdata(23) <= \<const0>\;
  i_wdata(22) <= \<const0>\;
  i_wdata(21) <= \<const0>\;
  i_wdata(20) <= \<const0>\;
  i_wdata(19) <= \<const0>\;
  i_wdata(18) <= \<const0>\;
  i_wdata(17) <= \<const0>\;
  i_wdata(16) <= \<const0>\;
  i_wdata(15) <= \<const0>\;
  i_wdata(14) <= \<const0>\;
  i_wdata(13) <= \<const0>\;
  i_wdata(12) <= \<const0>\;
  i_wdata(11) <= \<const0>\;
  i_wdata(10) <= \<const0>\;
  i_wdata(9) <= \<const0>\;
  i_wdata(8) <= \<const0>\;
  i_wdata(7) <= \<const0>\;
  i_wdata(6) <= \<const0>\;
  i_wdata(5) <= \<const0>\;
  i_wdata(4) <= \<const0>\;
  i_wdata(3) <= \<const0>\;
  i_wdata(2) <= \<const0>\;
  i_wdata(1) <= \<const0>\;
  i_wdata(0) <= \<const0>\;
  i_wlast <= \<const0>\;
  i_wstrb(3) <= \<const0>\;
  i_wstrb(2) <= \<const0>\;
  i_wstrb(1) <= \<const0>\;
  i_wstrb(0) <= \<const0>\;
  i_wvalid <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
axi_arready_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02030200"
    )
        port map (
      I0 => b_arready,
      I1 => axi_arready_INST_0_i_1_n_0,
      I2 => axi_arready_INST_0_i_2_n_0,
      I3 => \^axi_araddr\(28),
      I4 => i_arready,
      O => axi_arready
    );
axi_arready_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \^axi_araddr\(24),
      I1 => \^axi_araddr\(17),
      I2 => \^axi_araddr\(26),
      I3 => \^axi_araddr\(16),
      I4 => axi_arready_INST_0_i_3_n_0,
      I5 => axi_arready_INST_0_i_4_n_0,
      O => axi_arready_INST_0_i_1_n_0
    );
axi_arready_INST_0_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \^axi_araddr\(29),
      I1 => \^axi_araddr\(30),
      I2 => \^axi_araddr\(31),
      O => axi_arready_INST_0_i_2_n_0
    );
axi_arready_INST_0_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^axi_araddr\(21),
      I1 => \^axi_araddr\(23),
      I2 => \^axi_araddr\(18),
      I3 => \^axi_araddr\(22),
      O => axi_arready_INST_0_i_3_n_0
    );
axi_arready_INST_0_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^axi_araddr\(20),
      I1 => \^axi_araddr\(27),
      I2 => \^axi_araddr\(19),
      I3 => \^axi_araddr\(25),
      O => axi_arready_INST_0_i_4_n_0
    );
axi_rvalid_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => b_rvalid,
      I1 => i_rvalid,
      O => axi_rvalid
    );
b_arvalid_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000020000"
    )
        port map (
      I0 => axi_arvalid,
      I1 => \^axi_araddr\(31),
      I2 => \^axi_araddr\(30),
      I3 => \^axi_araddr\(29),
      I4 => \^axi_araddr\(28),
      I5 => axi_arready_INST_0_i_1_n_0,
      O => b_arvalid
    );
i_arvalid_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
        port map (
      I0 => axi_arvalid,
      I1 => \^axi_araddr\(28),
      I2 => \^axi_araddr\(31),
      I3 => \^axi_araddr\(30),
      I4 => \^axi_araddr\(29),
      I5 => axi_arready_INST_0_i_1_n_0,
      O => i_arvalid
    );
inst: entity work.design_1_Instr_Splitter_0_0_Instr_Splitter
     port map (
      axi_rdata(31 downto 0) => axi_rdata(31 downto 0),
      axi_rresp(1 downto 0) => axi_rresp(1 downto 0),
      b_rdata(31 downto 0) => b_rdata(31 downto 0),
      b_rresp(1 downto 0) => b_rresp(1 downto 0),
      b_rvalid => b_rvalid,
      i_rdata(31 downto 0) => i_rdata(31 downto 0),
      i_rresp(1 downto 0) => i_rresp(1 downto 0),
      i_rvalid => i_rvalid
    );
end STRUCTURE;
