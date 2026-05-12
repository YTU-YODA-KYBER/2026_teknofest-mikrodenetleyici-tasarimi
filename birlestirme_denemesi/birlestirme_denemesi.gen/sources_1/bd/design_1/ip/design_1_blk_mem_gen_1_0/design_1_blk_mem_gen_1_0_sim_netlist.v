// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Sat May  9 17:15:18 2026
// Host        : Stradale running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/deniz/Documents/TEKNOFEST_Modules/birlestirme_denemesi/birlestirme_denemesi.gen/sources_1/bd/design_1/ip/design_1_blk_mem_gen_1_0/design_1_blk_mem_gen_1_0_sim_netlist.v
// Design      : design_1_blk_mem_gen_1_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_blk_mem_gen_1_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_blk_mem_gen_1_0
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
  design_1_blk_mem_gen_1_0_blk_mem_gen_v8_4_12 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 53440)
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
