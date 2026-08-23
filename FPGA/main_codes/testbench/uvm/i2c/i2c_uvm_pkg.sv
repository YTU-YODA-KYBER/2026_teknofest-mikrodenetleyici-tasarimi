//=============================================================================
//  i2c_uvm_pkg.sv  --  I2C Master UVM ortami
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  DUT: main_codes/rtl/desgin_sources/Peripherals/I2C/I2C_Master_AXI4_Lite.sv
//  Taban adres: 0x4002_0000
//=============================================================================
`ifndef I2C_UVM_PKG_SV
`define I2C_UVM_PKG_SV
`timescale 1ns/1ps

package i2c_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import i2c_slave_pkg::*;

    `include "i2c_reg_block.svh"
    `include "i2c_scoreboard.svh"
    `include "i2c_env.svh"
    `include "i2c_test_lib.svh"

endpackage : i2c_uvm_pkg

`endif
