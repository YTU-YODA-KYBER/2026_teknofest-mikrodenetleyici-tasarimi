// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat May  9 17:15:17 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top design_1_blk_mem_gen_2_0 -prefix
//               design_1_blk_mem_gen_2_0_ design_1_blk_mem_gen_1_0_sim_netlist.v
// Design      : design_1_blk_mem_gen_1_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_blk_mem_gen_1_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_blk_mem_gen_2_0
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    rsta_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  output rsta_busy;

  wire [31:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire rsta;
  wire rsta_busy;
  wire [3:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.3746 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
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
  design_1_blk_mem_gen_2_0_blk_mem_gen_v8_4_12 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
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
        .web({1'b0,1'b0,1'b0,1'b0}));
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 53168)
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
