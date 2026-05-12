//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
//Date        : Sun May 10 17:02:45 2026
//Host        : Stradale running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (I2C_SCL_0,
    I2C_SDA_0,
    QSPI_CS_0,
    QSPI_IO0_0,
    QSPI_IO1_0,
    QSPI_IO2_0,
    QSPI_IO3_0,
    QSPI_SCLK_0,
    btn_reset,
    sys_clk_in);
  output I2C_SCL_0;
  inout I2C_SDA_0;
  output QSPI_CS_0;
  inout QSPI_IO0_0;
  inout QSPI_IO1_0;
  inout QSPI_IO2_0;
  inout QSPI_IO3_0;
  output QSPI_SCLK_0;
  input [0:0]btn_reset;
  input sys_clk_in;

  wire I2C_SCL_0;
  wire I2C_SDA_0;
  wire QSPI_CS_0;
  wire QSPI_IO0_0;
  wire QSPI_IO1_0;
  wire QSPI_IO2_0;
  wire QSPI_IO3_0;
  wire QSPI_SCLK_0;
  wire [0:0]btn_reset;
  wire sys_clk_in;

  design_1 design_1_i
       (.I2C_SCL_0(I2C_SCL_0),
        .I2C_SDA_0(I2C_SDA_0),
        .QSPI_CS_0(QSPI_CS_0),
        .QSPI_IO0_0(QSPI_IO0_0),
        .QSPI_IO1_0(QSPI_IO1_0),
        .QSPI_IO2_0(QSPI_IO2_0),
        .QSPI_IO3_0(QSPI_IO3_0),
        .QSPI_SCLK_0(QSPI_SCLK_0),
        .btn_reset(btn_reset),
        .sys_clk_in(sys_clk_in));
endmodule
