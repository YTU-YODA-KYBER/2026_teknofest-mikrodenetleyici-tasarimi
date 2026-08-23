//=============================================================================
//  axil_if.sv  --  Cevre birimlerinin indirgenmis AXI4-Lite arayuzu
//
//  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi
//
//  Tasarimdaki yedi slave de AYNI indirgenmis AXI4-Lite'i konusur:
//  WSTRB, PROT, ID, burst/len/size YOKTUR. Bu arayuz o alt kumeyi tarif eder.
//
//  NEDEN CLOCKING BLOCK YOK:
//    Uyaran negedge'de surulur, ornekleme posedge'de yapilir; bu ayrim
//    surucu/monitor gorevlerinde ACIKCA yazilmistir. Mevcut duz testbench'ler
//    de ayni idiomu kullaniyor (posedge'de surmek sifir genislikli VALID
//    darbeleri uretip QSPI'da 600 binden fazla sahte protokol ihlali
//    dogurmustu). Clocking block ayni isi yapardi ama simulator bagimliligi
//    ekler; kanitlanmis idiom tercih edildi.
//=============================================================================
`ifndef AXIL_IF_SV
`define AXIL_IF_SV
`timescale 1ns/1ps

interface axil_if #(
    parameter int ADDR_W = 32,
    parameter int DATA_W = 32
) (
    input logic clk,
    input logic rst_n
);

    // ---- Write Address kanali ----
    logic [ADDR_W-1:0] awaddr;
    logic              awvalid;
    logic              awready;

    // ---- Write Data kanali ----
    logic [DATA_W-1:0] wdata;
    logic              wvalid;
    logic              wready;

    // ---- Write Response kanali ----
    logic [1:0]        bresp;
    logic              bvalid;
    logic              bready;

    // ---- Read Address kanali ----
    logic [ADDR_W-1:0] araddr;
    logic              arvalid;
    logic              arready;

    // ---- Read Data kanali ----
    logic [DATA_W-1:0] rdata;
    logic [1:0]        rresp;
    logic              rvalid;
    logic              rready;

    // Test tarafinin reset istegi. Testbench ust modulu bunu kendi power-on
    // reset'iyle VE'leyerek rst_n'i uretir; boylece "islem ortasinda reset"
    // testi RTL'e veya ust module ozel kod eklemeden yazilabilir.
    bit rst_req = 1'b0;

    // Master tarafinin surdugu sinyalleri bosa alir (surucu reset'te cagirir)
    task automatic idle_master();
        awaddr  <= '0;
        awvalid <= 1'b0;
        wdata   <= '0;
        wvalid  <= 1'b0;
        bready  <= 1'b0;
        araddr  <= '0;
        arvalid <= 1'b0;
        rready  <= 1'b0;
    endtask

endinterface : axil_if

`endif
