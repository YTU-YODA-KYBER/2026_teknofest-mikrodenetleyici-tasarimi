// ---------------------------------------------------------------------
//  bram_yz -- YZ hizlandiricisinin girdi RAM'i (ses ozellik haritasi)
//
//  DERINLIK NEREDEN GELIYOR?
//    Sartname YZ hizlandiricisinin TOPLAM bellegini 30 KB ile sinirliyor.
//    Hizlandiricinin kendi bellekleri (fc_weights_rom_p4 16.000 B +
//    conv_buf_ram 4.000 B + weights_rom_p8 640 B + bias/skor register
//    dizileri 176 B) 20.816 bayt tutuyor; girdi RAM'ine kalan pay
//    30.720 - 20.816 = 9.904 bayttir. Ayrintili tablo:
//    verification/ai_accel_reports/README.md
//
//    Modelin girdisi her zaman 1960 bayt (49x40) oldugu icin fiilen ilk
//    1960 adres kullanilir, gerisi rezervdir.
//
//  ADDR_WIDTH neden 14?
//    11 bit 1960 bayti adreslemeye yeterdi, ama o zaman ust adres bitleri
//    sabit 0'a baglanir ve sentez BRAM'in bir kismini optimize edip atar;
//    kaynak raporu ayrilan bellegi gostermez. Adres yolu DEPTH'i
//    adresleyecek genislikte tutuluyor.
// ---------------------------------------------------------------------
module bram_yz #(
    parameter DATA_WIDTH = 8,        // bayt bayt
    parameter ADDR_WIDTH = 14,       // 9904'u adresleyen en kucuk genislik
    parameter DEPTH      = 9904      // 30 KB toplam butcesinden girdi RAM'ine kalan pay
)(
    input  logic                  clk,
    input  logic                  we,
    input  logic [ADDR_WIDTH-1:0] waddr,
    input  logic [DATA_WIDTH-1:0] wdata,
    input  logic [ADDR_WIDTH-1:0] raddr,
    output logic [DATA_WIDTH-1:0] rdata
);
    (* ram_style = "block" *)
    logic [DATA_WIDTH-1:0] ram [0:DEPTH-1];
    always_ff @(posedge clk) if (we) ram[waddr] <= wdata;
    always_ff @(posedge clk) rdata <= ram[raddr];
endmodule
