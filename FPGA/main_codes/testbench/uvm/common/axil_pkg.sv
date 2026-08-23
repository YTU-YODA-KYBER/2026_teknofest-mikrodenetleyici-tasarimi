//=============================================================================
//  axil_pkg.sv  --  Ortak AXI4-Lite UVM paketi
//
//  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi
//
//  Tasarimdaki yedi AXI4-Lite slave'i (GPIO, Timer, UART_GU, UART_YZ, I2C,
//  QSPI, YZ CSR) ayni indirgenmis alt kumeyi konusur: WSTRB, PROT, ID ve
//  burst YOKTUR, hepsi 1 outstanding'dir ve AW ile W'yi ayni cevrimde bekler.
//  Bu yuzden tek bir agent yedisine birden yeter; bloklar arasinda degisen
//  sey yalnizca taban adres ve register haritasidir.
//
//  Dosya duzeni:
//    axil_item.svh        transaction
//    axil_cfg.svh         agent yapilandirmasi
//    axil_driver.svh      master surucusu (uc kilit kisit dosyasinda anlatilir)
//    axil_monitor.svh     pasif monitor
//    axil_coverage.svh    fonksiyonel kapsam
//    axil_agent.svh       sequencer + surucu + monitor + kapsam
//    axil_seq_lib.svh     ortak dizi kutuphanesi
//    axil_reg_adapter.svh uvm_reg <-> axil_item cevirici
//    axil_scoreboard.svh  golge register dosyasi (taban)
//    axil_base_env.svh    ortak ortam
//    axil_base_test.svh   ortak test tabani
//=============================================================================
`ifndef AXIL_PKG_SV
`define AXIL_PKG_SV
`timescale 1ns/1ps

package axil_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "axil_item.svh"
    `include "axil_cfg.svh"
    `include "axil_driver.svh"
    `include "axil_monitor.svh"
    `include "axil_coverage.svh"
    `include "axil_agent.svh"
    `include "axil_seq_lib.svh"
    `include "axil_reg_adapter.svh"
    `include "axil_scoreboard.svh"
    `include "axil_base_env.svh"
    `include "axil_base_test.svh"

endpackage : axil_pkg

`endif
