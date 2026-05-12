-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
-- Date        : Sat May  9 17:18:41 2026
-- Host        : Stradale running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_cv32e40p_obi_to_axi_0_0/design_1_cv32e40p_obi_to_axi_0_0_stub.vhdl
-- Design      : design_1_cv32e40p_obi_to_axi_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_cv32e40p_obi_to_axi_0_0 is
  Port ( 
    clk_i : in STD_LOGIC;
    rst_ni : in STD_LOGIC;
    interrupt_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    interrupt_ack : out STD_LOGIC;
    interrupt_id : out STD_LOGIC_VECTOR ( 4 downto 0 );
    axi_instr_arid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_instr_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_instr_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_instr_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_instr_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_instr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_instr_arvalid : out STD_LOGIC;
    axi_instr_arready : in STD_LOGIC;
    axi_instr_rready : out STD_LOGIC;
    axi_instr_rid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_instr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_instr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_instr_rlast : in STD_LOGIC;
    axi_instr_rvalid : in STD_LOGIC;
    axi_instr_awid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_instr_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_instr_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_instr_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_instr_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_instr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_instr_awvalid : out STD_LOGIC;
    axi_instr_awready : in STD_LOGIC;
    axi_instr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_instr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_instr_wlast : out STD_LOGIC;
    axi_instr_wvalid : out STD_LOGIC;
    axi_instr_wready : in STD_LOGIC;
    axi_instr_bready : out STD_LOGIC;
    axi_instr_bid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_instr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_instr_bvalid : in STD_LOGIC;
    axi_data_awid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_data_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_data_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_data_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_data_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_data_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_data_awvalid : out STD_LOGIC;
    axi_data_awready : in STD_LOGIC;
    axi_data_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_data_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_data_wlast : out STD_LOGIC;
    axi_data_wvalid : out STD_LOGIC;
    axi_data_wready : in STD_LOGIC;
    axi_data_bready : out STD_LOGIC;
    axi_data_bid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_data_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_data_bvalid : in STD_LOGIC;
    axi_data_arid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_data_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_data_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_data_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_data_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_data_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_data_arvalid : out STD_LOGIC;
    axi_data_arready : in STD_LOGIC;
    axi_data_rready : out STD_LOGIC;
    axi_data_rid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_data_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_data_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_data_rlast : in STD_LOGIC;
    axi_data_rvalid : in STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_cv32e40p_obi_to_axi_0_0 : entity is "design_1_cv32e40p_obi_to_axi_0_0,cv32e40p_obi_to_axi_wrapper,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_cv32e40p_obi_to_axi_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_cv32e40p_obi_to_axi_0_0 : entity is "package_project";
end design_1_cv32e40p_obi_to_axi_0_0;

architecture stub of design_1_cv32e40p_obi_to_axi_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "clk_i,rst_ni,interrupt_i[31:0],interrupt_ack,interrupt_id[4:0],axi_instr_arid[3:0],axi_instr_araddr[31:0],axi_instr_arlen[7:0],axi_instr_arsize[2:0],axi_instr_arburst[1:0],axi_instr_arprot[2:0],axi_instr_arvalid,axi_instr_arready,axi_instr_rready,axi_instr_rid[3:0],axi_instr_rdata[31:0],axi_instr_rresp[1:0],axi_instr_rlast,axi_instr_rvalid,axi_instr_awid[3:0],axi_instr_awaddr[31:0],axi_instr_awlen[7:0],axi_instr_awsize[2:0],axi_instr_awburst[1:0],axi_instr_awprot[2:0],axi_instr_awvalid,axi_instr_awready,axi_instr_wdata[31:0],axi_instr_wstrb[3:0],axi_instr_wlast,axi_instr_wvalid,axi_instr_wready,axi_instr_bready,axi_instr_bid[3:0],axi_instr_bresp[1:0],axi_instr_bvalid,axi_data_awid[3:0],axi_data_awaddr[31:0],axi_data_awlen[7:0],axi_data_awsize[2:0],axi_data_awburst[1:0],axi_data_awprot[2:0],axi_data_awvalid,axi_data_awready,axi_data_wdata[31:0],axi_data_wstrb[3:0],axi_data_wlast,axi_data_wvalid,axi_data_wready,axi_data_bready,axi_data_bid[3:0],axi_data_bresp[1:0],axi_data_bvalid,axi_data_arid[3:0],axi_data_araddr[31:0],axi_data_arlen[7:0],axi_data_arsize[2:0],axi_data_arburst[1:0],axi_data_arprot[2:0],axi_data_arvalid,axi_data_arready,axi_data_rready,axi_data_rid[3:0],axi_data_rdata[31:0],axi_data_rresp[1:0],axi_data_rlast,axi_data_rvalid";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk_i : signal is "xilinx.com:signal:clock:1.0 clk_i CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk_i : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk_i : signal is "XIL_INTERFACENAME clk_i, FREQ_TOLERANCE_HZ 0, ASSOCIATED_BUSIF axi_data:axi_instr, FREQ_HZ 50000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst_ni : signal is "xilinx.com:signal:reset:1.0 rst_ni RST";
  attribute X_INTERFACE_MODE of rst_ni : signal is "slave";
  attribute X_INTERFACE_PARAMETER of rst_ni : signal is "XIL_INTERFACENAME rst_ni, POLARITY ACTIVE_LOW, ASSOCIATED_RESET rst_ni, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of axi_instr_arid : signal is "xilinx.com:interface:aximm:1.0 axi_instr ARID";
  attribute X_INTERFACE_MODE of axi_instr_arid : signal is "master";
  attribute X_INTERFACE_PARAMETER of axi_instr_arid : signal is "XIL_INTERFACENAME axi_instr, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of axi_instr_araddr : signal is "xilinx.com:interface:aximm:1.0 axi_instr ARADDR";
  attribute X_INTERFACE_INFO of axi_instr_arlen : signal is "xilinx.com:interface:aximm:1.0 axi_instr ARLEN";
  attribute X_INTERFACE_INFO of axi_instr_arsize : signal is "xilinx.com:interface:aximm:1.0 axi_instr ARSIZE";
  attribute X_INTERFACE_INFO of axi_instr_arburst : signal is "xilinx.com:interface:aximm:1.0 axi_instr ARBURST";
  attribute X_INTERFACE_INFO of axi_instr_arprot : signal is "xilinx.com:interface:aximm:1.0 axi_instr ARPROT";
  attribute X_INTERFACE_INFO of axi_instr_arvalid : signal is "xilinx.com:interface:aximm:1.0 axi_instr ARVALID";
  attribute X_INTERFACE_INFO of axi_instr_arready : signal is "xilinx.com:interface:aximm:1.0 axi_instr ARREADY";
  attribute X_INTERFACE_INFO of axi_instr_rready : signal is "xilinx.com:interface:aximm:1.0 axi_instr RREADY";
  attribute X_INTERFACE_INFO of axi_instr_rid : signal is "xilinx.com:interface:aximm:1.0 axi_instr RID";
  attribute X_INTERFACE_INFO of axi_instr_rdata : signal is "xilinx.com:interface:aximm:1.0 axi_instr RDATA";
  attribute X_INTERFACE_INFO of axi_instr_rresp : signal is "xilinx.com:interface:aximm:1.0 axi_instr RRESP";
  attribute X_INTERFACE_INFO of axi_instr_rlast : signal is "xilinx.com:interface:aximm:1.0 axi_instr RLAST";
  attribute X_INTERFACE_INFO of axi_instr_rvalid : signal is "xilinx.com:interface:aximm:1.0 axi_instr RVALID";
  attribute X_INTERFACE_INFO of axi_instr_awid : signal is "xilinx.com:interface:aximm:1.0 axi_instr AWID";
  attribute X_INTERFACE_INFO of axi_instr_awaddr : signal is "xilinx.com:interface:aximm:1.0 axi_instr AWADDR";
  attribute X_INTERFACE_INFO of axi_instr_awlen : signal is "xilinx.com:interface:aximm:1.0 axi_instr AWLEN";
  attribute X_INTERFACE_INFO of axi_instr_awsize : signal is "xilinx.com:interface:aximm:1.0 axi_instr AWSIZE";
  attribute X_INTERFACE_INFO of axi_instr_awburst : signal is "xilinx.com:interface:aximm:1.0 axi_instr AWBURST";
  attribute X_INTERFACE_INFO of axi_instr_awprot : signal is "xilinx.com:interface:aximm:1.0 axi_instr AWPROT";
  attribute X_INTERFACE_INFO of axi_instr_awvalid : signal is "xilinx.com:interface:aximm:1.0 axi_instr AWVALID";
  attribute X_INTERFACE_INFO of axi_instr_awready : signal is "xilinx.com:interface:aximm:1.0 axi_instr AWREADY";
  attribute X_INTERFACE_INFO of axi_instr_wdata : signal is "xilinx.com:interface:aximm:1.0 axi_instr WDATA";
  attribute X_INTERFACE_INFO of axi_instr_wstrb : signal is "xilinx.com:interface:aximm:1.0 axi_instr WSTRB";
  attribute X_INTERFACE_INFO of axi_instr_wlast : signal is "xilinx.com:interface:aximm:1.0 axi_instr WLAST";
  attribute X_INTERFACE_INFO of axi_instr_wvalid : signal is "xilinx.com:interface:aximm:1.0 axi_instr WVALID";
  attribute X_INTERFACE_INFO of axi_instr_wready : signal is "xilinx.com:interface:aximm:1.0 axi_instr WREADY";
  attribute X_INTERFACE_INFO of axi_instr_bready : signal is "xilinx.com:interface:aximm:1.0 axi_instr BREADY";
  attribute X_INTERFACE_INFO of axi_instr_bid : signal is "xilinx.com:interface:aximm:1.0 axi_instr BID";
  attribute X_INTERFACE_INFO of axi_instr_bresp : signal is "xilinx.com:interface:aximm:1.0 axi_instr BRESP";
  attribute X_INTERFACE_INFO of axi_instr_bvalid : signal is "xilinx.com:interface:aximm:1.0 axi_instr BVALID";
  attribute X_INTERFACE_INFO of axi_data_awid : signal is "xilinx.com:interface:aximm:1.0 axi_data AWID";
  attribute X_INTERFACE_MODE of axi_data_awid : signal is "master";
  attribute X_INTERFACE_PARAMETER of axi_data_awid : signal is "XIL_INTERFACENAME axi_data, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 50000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of axi_data_awaddr : signal is "xilinx.com:interface:aximm:1.0 axi_data AWADDR";
  attribute X_INTERFACE_INFO of axi_data_awlen : signal is "xilinx.com:interface:aximm:1.0 axi_data AWLEN";
  attribute X_INTERFACE_INFO of axi_data_awsize : signal is "xilinx.com:interface:aximm:1.0 axi_data AWSIZE";
  attribute X_INTERFACE_INFO of axi_data_awburst : signal is "xilinx.com:interface:aximm:1.0 axi_data AWBURST";
  attribute X_INTERFACE_INFO of axi_data_awprot : signal is "xilinx.com:interface:aximm:1.0 axi_data AWPROT";
  attribute X_INTERFACE_INFO of axi_data_awvalid : signal is "xilinx.com:interface:aximm:1.0 axi_data AWVALID";
  attribute X_INTERFACE_INFO of axi_data_awready : signal is "xilinx.com:interface:aximm:1.0 axi_data AWREADY";
  attribute X_INTERFACE_INFO of axi_data_wdata : signal is "xilinx.com:interface:aximm:1.0 axi_data WDATA";
  attribute X_INTERFACE_INFO of axi_data_wstrb : signal is "xilinx.com:interface:aximm:1.0 axi_data WSTRB";
  attribute X_INTERFACE_INFO of axi_data_wlast : signal is "xilinx.com:interface:aximm:1.0 axi_data WLAST";
  attribute X_INTERFACE_INFO of axi_data_wvalid : signal is "xilinx.com:interface:aximm:1.0 axi_data WVALID";
  attribute X_INTERFACE_INFO of axi_data_wready : signal is "xilinx.com:interface:aximm:1.0 axi_data WREADY";
  attribute X_INTERFACE_INFO of axi_data_bready : signal is "xilinx.com:interface:aximm:1.0 axi_data BREADY";
  attribute X_INTERFACE_INFO of axi_data_bid : signal is "xilinx.com:interface:aximm:1.0 axi_data BID";
  attribute X_INTERFACE_INFO of axi_data_bresp : signal is "xilinx.com:interface:aximm:1.0 axi_data BRESP";
  attribute X_INTERFACE_INFO of axi_data_bvalid : signal is "xilinx.com:interface:aximm:1.0 axi_data BVALID";
  attribute X_INTERFACE_INFO of axi_data_arid : signal is "xilinx.com:interface:aximm:1.0 axi_data ARID";
  attribute X_INTERFACE_INFO of axi_data_araddr : signal is "xilinx.com:interface:aximm:1.0 axi_data ARADDR";
  attribute X_INTERFACE_INFO of axi_data_arlen : signal is "xilinx.com:interface:aximm:1.0 axi_data ARLEN";
  attribute X_INTERFACE_INFO of axi_data_arsize : signal is "xilinx.com:interface:aximm:1.0 axi_data ARSIZE";
  attribute X_INTERFACE_INFO of axi_data_arburst : signal is "xilinx.com:interface:aximm:1.0 axi_data ARBURST";
  attribute X_INTERFACE_INFO of axi_data_arprot : signal is "xilinx.com:interface:aximm:1.0 axi_data ARPROT";
  attribute X_INTERFACE_INFO of axi_data_arvalid : signal is "xilinx.com:interface:aximm:1.0 axi_data ARVALID";
  attribute X_INTERFACE_INFO of axi_data_arready : signal is "xilinx.com:interface:aximm:1.0 axi_data ARREADY";
  attribute X_INTERFACE_INFO of axi_data_rready : signal is "xilinx.com:interface:aximm:1.0 axi_data RREADY";
  attribute X_INTERFACE_INFO of axi_data_rid : signal is "xilinx.com:interface:aximm:1.0 axi_data RID";
  attribute X_INTERFACE_INFO of axi_data_rdata : signal is "xilinx.com:interface:aximm:1.0 axi_data RDATA";
  attribute X_INTERFACE_INFO of axi_data_rresp : signal is "xilinx.com:interface:aximm:1.0 axi_data RRESP";
  attribute X_INTERFACE_INFO of axi_data_rlast : signal is "xilinx.com:interface:aximm:1.0 axi_data RLAST";
  attribute X_INTERFACE_INFO of axi_data_rvalid : signal is "xilinx.com:interface:aximm:1.0 axi_data RVALID";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "cv32e40p_obi_to_axi_wrapper,Vivado 2025.2";
begin
end;
