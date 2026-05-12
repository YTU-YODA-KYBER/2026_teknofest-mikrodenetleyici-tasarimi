// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat May  9 17:17:12 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_blk_mem_gen_0_0/design_1_blk_mem_gen_0_0_sim_netlist.v
// Design      : design_1_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_blk_mem_gen_0_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_blk_mem_gen_0_0
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    web,
    addrb,
    dinb,
    doutb,
    rsta_busy,
    rstb_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST" *) input rstb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [31:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;
  output rsta_busy;
  output rstb_busy;

  wire [31:0]addra;
  wire [31:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire rsta;
  wire rsta_busy;
  wire rstb;
  wire rstb_busy;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.7492 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  design_1_blk_mem_gen_0_0_blk_mem_gen_v8_4_12 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addrb[12:2],1'b0,1'b0}),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(rstb),
        .rstb_busy(rstb_busy),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YqH9kwIC39+qbZg4PSfFsXuB9k9wnuxNryS/CfnEri6Ci9fSC6fsrQ/T/hnt3u/yolbJ8DJa1Qu6
Qnm24A9jLbA+fu3Nsmm6/rM6a4vU6OfVl/gTFd/CiWDutv6Dhn6Lim4uUNPahoOR/A2Yc4Zo2tdI
kMLO9gn9WlH2l3O2oXs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XJYO2VHd/cnMxQd3i7/2qRhl57dl+doEKuhAunQyv3vpGRG/jlNxj8PqrgLoF0HMdqE3qJUVE/oq
kBSapqjVjLDMOrNGQ+Tc6VGsKMZH8FE/TXHQJ/IM5Iuiu2eozEwwVUomF+7cfqn+9OsVsqCONQ1M
g0oRlangiqasJDhhMfnlGGqwAwmgWRGQA6dmhTuua1s8zdvIv540zY6p5au8cAKVhqyyKK7wbxEE
SGuFqX+NYoyRV+rfWCcWM+hJEmnWS8LNAKkd13YE2+17sPYzUdZ23DmTxXK6KlAxKFW27CBySUfg
qdNXp2DSs2KAQYih27pBNMuHfGbM/ATFPWFvxg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lYoEi/e8HsDTz6N11EDe/B/iitERmeYndlCklmCluwgb0N4W80JUGVlkd7NlRZHRNhxaNBJPkcjC
n61nO0tb17NwsMwjbY5TF8JWRYTNw1JXCFacvQYrdKv4/7QNQEtwVGiCLxFhOA8aHlWMZIrc2fri
VRMVWaEBcPwCGorlVIM=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QEw9fEsWFbdX0OQLvYs/gl+zyEOW3ak9TdQVaq+0AXXOT3LIqF7wDxJ6ZBnlf9mNbdsUVH5tAz1o
H8u7ihJl1L3THEvugW+TS8hkvVbEA9rKO2vV15KAj4Lla7UdFT/xDfe79RFarlLI7yGrubjgdoRi
QWy//UKsffG7IWNwmoSuppWiWB4ZHJtkunNyIkm70JPGyZF62VxJg1MTT+5LUbZG5vZjjuHZud9w
xJaKv1tFP/x8RVqLU5gPOqGqTW7/nKO2S+450Vo4D9vAmBVVcXpaL1EbSmCvQ+qJmcQKtf9qYFRV
Zko08hbpHjPxstqvTDro01jRzB8592m4xU2TWA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TC7q853CWBPPJgbRfgDV1lmjUwSAtliljShAyNFg8sfRfwDzchthzoSPH1UCHV++E2JXacEKq1lB
UWsNP92U4Xh0/Gu+6esOI0pJb8I+TRTxyBN1I4cRQEfQHcwfhbSdeH3yX9OV3opLEqYmT37hWU+J
zCawYnxVESI0FtRzEXve9gdEWlrKKckrT/hp4mvxxOjvOkOSQBvy0elgUOqh6mEOZl+JnUbsR+Wm
CoZLE1eefMZy3FnVmyDNPv3JPXi88aLXMyimal0MYFkTiS4XJiGT3eAIMIbksehXY+eYi/KFpZWQ
GHpX+lG3UmiWWLwyPakFwKEHbrBc70AlJ2eV9g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j9nmCKgjPWNChPbpSW6EWLrMA6oCG2JGPoum8px09v0PEAh0DRXZi0J8HPzXUsZgOEMcKpA7X54u
YFcDDCLAQ+urha/eSPbQYHQh4yGCursxAQ1C6LEyNQ2wJ0eLlO2bJeAl/gof06zqsYVM2lLJVNv5
wao1k2bmgPdfpfY3c9vPD0fSMuZPS41EoRS0cQhO5GTZnKdjxm6tEUL3GnTjB8ynSCIbCJUsMtAX
4FRHNa52gudx5B5fagR+lXgFhE7e++rWTJELr7SYB+r5Es8qZLTpCH8TrQxEkV0rY/+e4sAjNE2D
gHw8GD7VcUtc15B8y1BbVmh29qc8Nd3V2i/miA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UkCD6I/Vye4qNoNoa3hIexBXG3xyKUJPAHAjIo7UcNVCDXpMQiYEtPDqExZMfiPlJn2nswCYIfIJ
FYWqMCloKSQyyI/7yZ2EtbyWEklb/P5IyZyvGi6hhFUo/JFTb12b4bK0gZPr+bCDdlVQKTx5GVHz
wptdUJO2omSj8axVMPbLRRtVzlJIZ29dTJ2ATXVXAcBxPnFfHRAMnYYKLeeLExX61vQvpqrkLQHm
XG7hpVzJi56gYKAzxa2BLq072OCVpVS70bfWlhlSTVcSlCrUf+EcarEk4FD8+Ih2NCvrqremG6yn
TtcBn8Xr8M/6zhOYvLi6AD6eArDMKA8n+Ccv8A==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
A5y5QVZU8yjPexRVPioSiAGohCHD5DX5FVobuMyhcgQRExLUhPvnnS8HOtxTj/2IapEcz68gFMGG
Hpi+m725u85/om/Vze9pGIW9Mn328Kz2FIg3W5EvGstfGwY+48LiAGAmTR269JS4lJGVYWYOz7Xk
S8cEsFd2m7j8iyKtARJzD90+UdXq/cIIh725jC9i8nbgxB364zddvm1Z/DF3JRw1qFp6GGcuRai1
KNcJ1j8c9wtIgktpsteU3e5+bxHEw8NT3gWXUFYjm00NDq97Jals8Jjktmum2nQxoF7ivPacfEey
gnSF6jRMkTsZObzc30hAhs0CEtc33hZLhPLHSn8pQ0WyvKJLHdd5s2yckgTZtqxC1Sbwe7WEgNXe
ZMX3pIkz+aoXsAL7GBLyVBMVQcyMoF0w8QGAaTe8sqatABwPqXidYRqNROTf62IYcMpV89XYgaTv
EwIn/oni9KOFd2BFVxRZbFGGC4IjvigsTBUijI+Dk6kVnDh240clGcc4

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Omtp+lCaqUx7Z4qdFj2zrN8LpCkit2eX4hlMtig+ielGm/x4FSZkpjoFmiqdKFPi2eg0pg09MSai
XyGH68UzAR7Xrj8f1jlIoUmMKp4GcxfdqfTeuu7kWGOJEP6cvgTjSJFj2gawDv7f4yZcltnK2x0L
e4GW/rBTmGvZtKWb2ahjINLxPuh3dDaSaWdb+zVgbtyrI5FrjxBkq+aOxSjyNsqnCx1L0uWbxnkl
88NbXN3dTaECXHNm/fsleayM5hKis7kTv9BFajJMGy+BhQlmIYpE+F5zchnTTFUFJZCz1sX9Fc8e
HcY7irB8mR3ajdzjUZLBQEMktp096Nheq3U75A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hpeBLwN9x2ZFDwroYLlUe5GjjDepHik2l0c2s3/6S7JPCRkzQSyt2V1Ad/JewAs/QNp5SXSbYYB4
rQl0My1LDMF3xw43r0g2IbcyHVpPhGp0W5msuQdF67afnsRv90iJYWLMI3QkYGCTWAzl4HrLxFSg
3z8XZRK670IcxznOrlvgHmIKsvubZrBkuc1EynrVb9Nw16QnIx2rc4WgcEXeFf+4i1RoYLDd3gXK
NFCNMdtaRYUThunFP6Z4ViZ5UnDmKq+IMhd31jTaqIlWOBDxPI1+v5RJYxIyTbn4rxlKR2fNbl5/
z4OUjBTd+1GH3I2OXlqmAOvIhpe2Z2HH7nZu/A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Mt2RhTSUwEIEWeNARbyL+EdfS1UF6nPaL/fKl/7oO2gina93egwCWDLl1fbBtkfaPco0cu4MJ9K3
OraAsyHRlY+MNShmJ1LzAIA1LjZx4y55lu9dlQqSUXR7AW7wVbkg1864mK+hM/1XygU0jvebKNW9
B7xSER+asLO6pxi0mt7uC2PHxLPAYEszFhmnap82TtbDGdQ2qtyekY+ngs+N2fAdsblxVwJruiMl
e6XJ127M8N1mYwhWU2HtRpBOSnnKoHgD9fG51XK/rhk8DxT66QnX9uLPB+H25eDupBJGi1Y5o6x8
hOwZiSUVlBLh7brfzevh7+eRn+7es6wBas0+3w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 61312)
`pragma protect data_block
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
`pragma protect end_protected
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
