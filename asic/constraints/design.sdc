# ===========================================================================
#  YTU YODA KYBER -- TEKNOFEST 2026 Cip Tasarim Yarismasi
#  top_module zamanlama kisitlari (LibreLane Classic / SKY130A)
#
#  Bu dosya hem PnR (PNR_SDC_FILE) hem de nihai signoff STA (SIGNOFF_SDC_FILE)
#  icin kullanilir; sartname Bolum 6.2 uyarinca tek dosya teslim edilir.
#
#  TASARIMIN SAAT YAPISI
#    Tek saat alani vardir: clk_i. Tasarimda gercek bir clock gating hucresi
#    yoktur -- CV32E40P'nin cv32e40p_clock_gate modulu bu yapilandirmada
#    pass-through'dur (cv32e40p_clock_gate.sv:5) ve FPU=0 oldugu icin ikinci
#    ICG generate edilmez. Dolayisiyla saat uzerinde hicbir kombinasyonel
#    mantik yoktur ve generated clock tanimi gerekmez.
#
#    I2C_SCL ve QSPI_SCLK cikis pinleri bolunmus saat GIBI gorunur ama
#    tasarim icinde saat olarak KULLANILMAZ: ikisi de clk_i ile suruLen birer
#    flip-flop cikisidir (I2C_Master_AXI4_Lite.sv:113, QSPI_Master_AXI4_Lite.sv:172).
#    Bu yuzden generated clock degil, normal cikis olarak kisitlanirlar.
#
#  TEK ZAMANLAMA ISTISNASI: HARICI RESET -> RESET SYNCHRONIZER
#    ASIC top'unda rst_ni yalniz iki ASYNC_REG flopunun async reset pinlerine
#    gider. Harici deassert saatle iliskisiz oldugundan bu iki recovery/removal
#    arc'i yapisal olarak zamanlanamaz; iki-kademeli synchronizer metastabiliteyi
#    ic reset agacina gecmeden sondurur. False-path yalniz HARICI porta uygulanir.
#    Synchronizer Q'sundan butun ic async-reset pinlerine giden rst_sys_ni agaci
#    kesilmez; recovery/removal ve slew/fanout kontrolleri gercek STA'da kalir.
# ===========================================================================

# ---------------------------------------------------------------------------
#  1) Birincil saat
# ---------------------------------------------------------------------------
set clk_port  [lindex $::env(CLOCK_PORT) 0]
set clk_input [get_ports $clk_port]

create_clock $clk_input -name $clk_port -period $::env(CLOCK_PERIOD)
set clocks [get_clocks $clk_port]

puts "\[SDC] Birincil saat: $clk_port, periyot $::env(CLOCK_PERIOD) ns"

# ---------------------------------------------------------------------------
#  2) Saat belirsizligi ve gecis suresi
#     Degerler yarismanin referans LibreLane/SKY130 varsayilanlaridir; CTS
#     oncesi ideal saat varsayimini telafi etmek icin acikca beyan ediliyor.
# ---------------------------------------------------------------------------
if { [info exists ::env(CLOCK_UNCERTAINTY_CONSTRAINT)] } {
    set_clock_uncertainty $::env(CLOCK_UNCERTAINTY_CONSTRAINT) $clocks
    puts "\[SDC] Saat belirsizligi: $::env(CLOCK_UNCERTAINTY_CONSTRAINT) ns"
}
if { [info exists ::env(CLOCK_TRANSITION_CONSTRAINT)] } {
    set_clock_transition $::env(CLOCK_TRANSITION_CONSTRAINT) $clocks
    puts "\[SDC] Saat gecis suresi: $::env(CLOCK_TRANSITION_CONSTRAINT) ns"
}
if { [info exists ::env(TIME_DERATING_CONSTRAINT)] } {
    set d [expr {$::env(TIME_DERATING_CONSTRAINT) / 100.0}]
    set_timing_derate -early [expr {1 - $d}]
    set_timing_derate -late  [expr {1 + $d}]
    puts "\[SDC] Zamanlama derate: %$::env(TIME_DERATING_CONSTRAINT)"
}

# ---------------------------------------------------------------------------
#  3) Giris / cikis gecikmeleri
#     Tasarim bir ASIC BLOGU olarak teslim edilir (pad ring sartname Bolum 2
#     geregi kapsam disidir), bu yuzden butun G/C'ler cekirdek tarafi sinyal
#     olarak, periyodun %IO_DELAY_CONSTRAINT'i kadar gecikmeyle kisitlanir.
#     Cift yonlu pinler (I2C_SDA, QSPI_IO0..3) hem all_inputs hem all_outputs
#     icinde yer alir; ikisinden de kisitlanirlar.
# ---------------------------------------------------------------------------
set io_delay [expr {$::env(CLOCK_PERIOD) * $::env(IO_DELAY_CONSTRAINT) / 100.0}]

# Kurulu OpenSTA, Synopsys'in `remove_from_collection` komutunu desteklemiyor.
# Bu nedenle koleksiyonun mevcut Tcl-listesi gösterimi kullanilir; ancak saat
# herhangi bir nedenle bulunamazsa lsearch'in -1 sonucunun son GERCEK girisi
# sildigi sessiz hata acik bir kabul kapisiyla onlenir.
set all_inputs_wo_clk [all_inputs]
set clk_indx [lsearch $all_inputs_wo_clk $clk_input]
if { $clk_indx < 0 } {
    error "SDC: saat portu all_inputs koleksiyonunda bulunamadi: $clk_port"
}
set all_inputs_wo_clk [lreplace $all_inputs_wo_clk $clk_indx $clk_indx]

set_input_delay  $io_delay -clock $clocks $all_inputs_wo_clk
set_output_delay $io_delay -clock $clocks [all_outputs]

puts "\[SDC] Giris/cikis gecikmesi: $io_delay ns"

# ---------------------------------------------------------------------------
#  4) Giris gecis suresi (surucu hucre) ve cikis yuku
#     Bunlar olmadan STA girisleri ideal (sifir gecis) kabul eder ve iyimser
#     sonuc verir; sartname Bolum 3.2 bu degerlerin verilmesini oneriyor.
# ---------------------------------------------------------------------------
# Saat pini icin ayri bir surucu hucre tanimlanmamissa genel surucu kullanilir
# (LibreLane base.sdc ile ayni davranis).
set drv_cell $::env(SYNTH_DRIVING_CELL)
if { [info exists ::env(SYNTH_CLK_DRIVING_CELL)] && $::env(SYNTH_CLK_DRIVING_CELL) ne "" } {
    set clk_drv_cell $::env(SYNTH_CLK_DRIVING_CELL)
} else {
    set clk_drv_cell $drv_cell
}

set_driving_cell \
    -lib_cell [lindex [split $drv_cell "/"] 0] \
    -pin      [lindex [split $drv_cell "/"] 1] \
    $all_inputs_wo_clk

set_driving_cell \
    -lib_cell [lindex [split $clk_drv_cell "/"] 0] \
    -pin      [lindex [split $clk_drv_cell "/"] 1] \
    $clk_input

set_load [expr {$::env(OUTPUT_CAP_LOAD) / 1000.0}] [all_outputs]

puts "\[SDC] Surucu hucre: $drv_cell  |  cikis yuku: [expr {$::env(OUTPUT_CAP_LOAD)/1000.0}] pF"

# ---------------------------------------------------------------------------
#  5) Tasarim kurallari
#     PDK tarafindan saglanan degerler kullanilir; tanimsiz olan atlanir.
# ---------------------------------------------------------------------------
if { [info exists ::env(MAX_FANOUT_CONSTRAINT)] } {
    set_max_fanout $::env(MAX_FANOUT_CONSTRAINT) [current_design]
}
if { [info exists ::env(MAX_TRANSITION_CONSTRAINT)] } {
    set_max_transition $::env(MAX_TRANSITION_CONSTRAINT) [current_design]
}
if { [info exists ::env(MAX_CAPACITANCE_CONSTRAINT)] } {
    set_max_capacitance $::env(MAX_CAPACITANCE_CONSTRAINT) [current_design]
}

# ---------------------------------------------------------------------------
#  6) Asenkron resetin recovery/removal zamanlamasi
#
#  rst_ni butun tasarimda `always_ff @(posedge clk_i or negedge rst_ni)`
#  bicimindeki asenkron, aktif-dusuk reset girisidir. Assert asenkrondur;
#  deassert ise ASIC top icindeki iki kademeli synchronizer tarafindan clk_i'ye
#  senkronize edilir. Ic reset agacindaki dagitim gecikmesi recovery/removal
#  marjini tuketebilecegi icin bu kontroller gercek STA'da gorunur kalmalidir.
#
#  Onceki mimaride `set_false_path -from rst_ni` yanlisti, cunku ayni port
#  4.662 ic flop ve kombinasyonel mantigi dogrudan suruyordu. ASIC'e ozgu top
#  yamasi artik yapisal bir reset synchronizer ekler; portun tek fanout'u bu
#  iki flopun async resetidir. Bu nedenle dis asinron sinir icin istisna
#  dogrudur, ic reset agacinin kontrolleri ise gorunur kalir.
# ---------------------------------------------------------------------------
set_false_path -from [get_ports rst_ni]

# ---------------------------------------------------------------------------
#  7) Saat yayilimi
#     CTS oncesi adimlar ideal saat ister; CTS sonrasi ve signoff'ta gercek
#     saat agaci gecikmeleri kullanilir. LibreLane bu bayragi kendisi ayarlar.
# ---------------------------------------------------------------------------
if { [info exists ::env(LIBRELANE_SDC_IDEAL_CLOCKS)] && $::env(LIBRELANE_SDC_IDEAL_CLOCKS) } {
    unset_propagated_clock [all_clocks]
} elseif { [info exists ::env(OPENLANE_SDC_IDEAL_CLOCKS)] && $::env(OPENLANE_SDC_IDEAL_CLOCKS) } {
    unset_propagated_clock [all_clocks]
} else {
    set_propagated_clock [all_clocks]
}
