//=============================================================================
//  yz_uvm_pkg.sv  --  YZ hizlandirici CSR UVM ortami
//
//  YTU YODA KYBER  |  TEKNOFEST 2026
//
//  DUT: main_codes/rtl/desgin_sources/AI_Accelerator/yz_csr_wrapper.sv
//  Taban adres: 0x4006_0000
//
//  Sartnamenin "YZ hizlandiricinin AXI arayuzu de dogrulanmalidir" maddesinin
//  karsiligi budur: hizlandiricinin CPU'ya bakan tek AXI4-Lite arayuzu bu
//  sarmalayicidir.
//=============================================================================
`ifndef YZ_UVM_PKG_SV
`define YZ_UVM_PKG_SV
`timescale 1ns/1ps

package yz_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axil_pkg::*;
    import yz_accel_pkg::*;

    `include "yz_reg_block.svh"
    `include "yz_scoreboard.svh"
    `include "yz_env.svh"
    `include "yz_test_lib.svh"

endpackage : yz_uvm_pkg

`endif
