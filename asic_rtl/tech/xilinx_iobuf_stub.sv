// ---------------------------------------------------------------------------
//  IOBUF -- Xilinx unisim primitifinin teknolojiden bagimsiz karsiligi
//
//  QSPI_Master_AXI4_Lite.sv (4 adet) ve I2C_Master_AXI4_Lite.sv (1 adet) bu
//  primitifi ISIMLE instantiate ediyor. ASIC akisinda Vivado'nun unisim
//  kutuphanesi yok, bu yuzden ayni isim ve ayni port listesiyle davranissal
//  bir modul veriyoruz. Dosya YALNIZCA asic/filelist.f icindedir; Vivado
//  projeleri bu dosyayi hic gormez, dolayisiyla FPGA akisi degismez.
//
//  Xilinx semantigi:
//     T = 1  -> pad yuksek empedansta (giris modu)
//     T = 0  -> pad I ile surulur     (cikis modu)
//     O      -> pad uzerindeki deger (her zaman okunur)
//
//  Yosys `$_TBUF_` hucresini uretir; LibreLane bunu SYNTH_TRISTATE_MAP ile
//  sky130_fd_sc_hd__ebufn_* hucrelerine haritalar (bkz. asic/config.yaml).
// ---------------------------------------------------------------------------
`default_nettype wire
module IOBUF (
    output O,
    inout  IO,
    input  I,
    input  T
);
    assign IO = T ? 1'bz : I;
    assign O  = IO;
endmodule
