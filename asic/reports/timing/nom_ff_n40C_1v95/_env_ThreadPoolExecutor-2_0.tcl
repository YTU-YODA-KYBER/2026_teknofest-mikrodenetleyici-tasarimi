set ::env(STEP_ID) OpenROAD.STAPostPNR
set ::env(TECH_LEF) /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
set ::env(MACRO_LEFS) "/home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_2kbyte_1rw1r_32x512_8/lef/sky130_sram_2kbyte_1rw1r_32x512_8.lef /home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_1kbyte_1rw1r_32x256_8/lef/sky130_sram_1kbyte_1rw1r_32x256_8.lef"
set ::env(STD_CELL_LIBRARY) sky130_fd_sc_hd
set ::env(VDD_PIN) VPWR
set ::env(GND_PIN) VGND
set ::env(TECH_LEFS) "\"nom_*\" /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef \"min_*\" /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__min.tlef \"max_*\" /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__max.tlef"
set ::env(PRIMARY_GDSII_STREAMOUT_TOOL) klayout
set ::env(DEFAULT_CORNER) nom_tt_025C_1v80
set ::env(STA_CORNERS) "nom_tt_025C_1v80 nom_ss_100C_1v60 nom_ff_n40C_1v95 min_tt_025C_1v80 min_ss_100C_1v60 min_ff_n40C_1v95 max_tt_025C_1v80 max_ss_100C_1v60 max_ff_n40C_1v95"
set ::env(RT_MIN_LAYER) met1
set ::env(RT_MAX_LAYER) met4
set ::env(SCL_GROUND_PINS) "VGND VNB"
set ::env(SCL_POWER_PINS) "VPWR VPB"
set ::env(TRISTATE_CELLS) "\"sky130_fd_sc_hd__ebuf*\""
set ::env(FILL_CELLS) "sky130_fd_sc_hd__fill_8 sky130_fd_sc_hd__fill_4 sky130_fd_sc_hd__fill_2 sky130_fd_sc_hd__fill_1"
set ::env(DECAP_CELLS) sky130_fd_sc_hd__decap_3
set ::env(LIB) "\"*_tt_025C_1v80\" /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib \"*_ss_100C_1v60\" /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ss_100C_1v60.lib \"*_ff_n40C_1v95\" /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_n40C_1v95.lib"
set ::env(CELL_LEFS) "/home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd.lef"
set ::env(CELL_GDS) /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd.gds
set ::env(CELL_VERILOG_MODELS) "/home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
set ::env(CELL_BB_VERILOG_MODELS) "/home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd__blackbox.v /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd__blackbox_pp.v"
set ::env(CELL_SPICE_MODELS) "/home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__decap_12.spice /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__decap_20_12.spice /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__decap_40_12.spice /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__decap_60_12.spice /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__decap_80_12.spice /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_12.spice /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_2.spice /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_4.spice /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_8.spice /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice"
set ::env(CELL_CDLS) /home/luxyxp/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/cdl/sky130_fd_sc_hd.cdl
set ::env(SYNTH_EXCLUDED_CELL_FILE) /home/luxyxp/.ciel/sky130A/libs.tech/openlane/sky130_fd_sc_hd/no_synth.cells
set ::env(PNR_EXCLUDED_CELL_FILE) /home/luxyxp/.ciel/sky130A/libs.tech/openlane/sky130_fd_sc_hd/drc_exclude.cells
set ::env(OUTPUT_CAP_LOAD) 33.442
set ::env(MAX_FANOUT_CONSTRAINT) 25
set ::env(MAX_TRANSITION_CONSTRAINT) 0.75
set ::env(MAX_CAPACITANCE_CONSTRAINT) 0.2
set ::env(CLOCK_UNCERTAINTY_CONSTRAINT) 0.25
set ::env(CLOCK_TRANSITION_CONSTRAINT) 0.1499999999999999944488848768742172978818416595458984375
set ::env(TIME_DERATING_CONSTRAINT) 5
set ::env(IO_DELAY_CONSTRAINT) 20
set ::env(SYNTH_DRIVING_CELL) sky130_fd_sc_hd__inv_2/Y
set ::env(SYNTH_CLK_DRIVING_CELL) sky130_fd_sc_hd__clkbuf_16/X
set ::env(SYNTH_TIEHI_CELL) sky130_fd_sc_hd__conb_1/HI
set ::env(SYNTH_TIELO_CELL) sky130_fd_sc_hd__conb_1/LO
set ::env(SYNTH_BUFFER_CELL) sky130_fd_sc_hd__buf_2/A/X
set ::env(PLACE_SITE) unithd
set ::env(CELL_PAD_EXCLUDE) "\"sky130_fd_sc_hd__tap*\" \"sky130_fd_sc_hd__decap*\" \"sky130_ef_sc_hd__decap*\" \"sky130_fd_sc_hd__fill*\""
set ::env(DIODE_CELL) sky130_fd_sc_hd__diode_2/DIODE
set ::env(WELLTAP_CELL) sky130_fd_sc_hd__tapvpwrvgnd_1
set ::env(ENDCAP_CELL) sky130_fd_sc_hd__decap_3
set ::env(DESIGN_NAME) top_module
set ::env(CLOCK_PERIOD) 35.714285714285715
set ::env(CLOCK_PORT) clk_i
set ::env(CLOCK_NET) clk_i
set ::env(DIE_AREA) "0 0 4200 3600"
set ::env(EXTRA_EXCLUDED_CELLS) "sky130_fd_sc_hd__clkdlybuf4s15_2 sky130_fd_sc_hd__clkdlybuf4s18_2 sky130_fd_sc_hd__clkdlybuf4s25_1 sky130_fd_sc_hd__clkdlybuf4s25_2 sky130_fd_sc_hd__clkdlybuf4s50_1 sky130_fd_sc_hd__clkdlybuf4s50_2"
set ::env(MACROS) "sky130_sram_2kbyte_1rw1r_32x512_8 \"gds /home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_2kbyte_1rw1r_32x512_8/gds/sky130_sram_2kbyte_1rw1r_32x512_8.gds lef /home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_2kbyte_1rw1r_32x512_8/lef/sky130_sram_2kbyte_1rw1r_32x512_8.lef instances \\\"\\\" vh /home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_2kbyte_1rw1r_32x512_8/verilog/sky130_sram_2kbyte_1rw1r_32x512_8.bb.v nl \\\"\\\" pnl \\\"\\\" spef \\\"\\\" lib \\\"\\\\\\\"*\\\\\\\" /home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_2kbyte_1rw1r_32x512_8/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib\\\" spice \\\"\\\" sdf \\\"\\\" json_h None\" sky130_sram_1kbyte_1rw1r_32x256_8 \"gds /home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_1kbyte_1rw1r_32x256_8/gds/sky130_sram_1kbyte_1rw1r_32x256_8.gds lef /home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_1kbyte_1rw1r_32x256_8/lef/sky130_sram_1kbyte_1rw1r_32x256_8.lef instances \\\"\\\" vh /home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_1kbyte_1rw1r_32x256_8/verilog/sky130_sram_1kbyte_1rw1r_32x256_8.bb.v nl \\\"\\\" pnl \\\"\\\" spef \\\"\\\" lib \\\"\\\\\\\"*\\\\\\\" /home/luxyxp/Documents/mainfiles/asic/macros/sky130_sram_1kbyte_1rw1r_32x256_8/lib/sky130_sram_1kbyte_1rw1r_32x256_8_TT_1p8V_25C.lib\\\" spice \\\"\\\" sdf \\\"\\\" json_h None\""
set ::env(FALLBACK_SDC) /nix/store/5jsqcdxd774ydqqjk8zkw3zk47dxbryb-python3-3.13.9-env/lib/python3.13/site-packages/librelane/scripts/base.sdc
set ::env(PAD_EDGE_SPACING) 0
set ::env(SET_RC_VERBOSE) 0
set ::env(LAYERS_RC) "\"*tt*\" \"li1 \\\"res 0.07176 cap 0.0001499\\\" met1 \\\"res 0.0008929 cap 0.000172375\\\" met2 \\\"res 0.0008929 cap 0.000136233\\\" met3 \\\"res 0.0001567 cap 0.000214962\\\" met4 \\\"res 0.0001567 cap 0.000154087\\\" met5 \\\"res 0.00001781 cap 0.000154087\\\"\" \"*ss*\" \"li1 \\\"res 0.093288 cap 0.00019487\\\" met1 \\\"res 0.00116077 cap 0.000224088\\\" met2 \\\"res 0.00116077 cap 0.000177103\\\" met3 \\\"res 0.00020371 cap 0.000279451\\\" met4 \\\"res 0.00020371 cap 0.000200313\\\" met5 \\\"res 0.000023153 cap 0.000200313\\\"\" \"*ff*\" \"li1 \\\"res 0.050232 cap 0.00010493\\\" met1 \\\"res 0.00062503 cap 0.000120662\\\" met2 \\\"res 0.00062503 cap 0.0000953631\\\" met3 \\\"res 0.00010969 cap 0.000150473\\\" met4 \\\"res 0.00010969 cap 0.000107861\\\" met5 \\\"res 0.000012467 cap 0.000107861\\\"\""
set ::env(SIGNAL_WIRE_RC_LAYERS) "met1 met2 met3 met4"
set ::env(CLOCK_WIRE_RC_LAYERS) "met2 met3 met4"
set ::env(PDN_CONNECT_MACROS_TO_GRID) 1
set ::env(PDN_MACRO_CONNECTIONS) "\".*u_sram VPWR VGND vccd1 vssd1\""
set ::env(PDN_ENABLE_GLOBAL_CONNECTIONS) 1
set ::env(PNR_SDC_FILE) /home/luxyxp/Documents/mainfiles/asic/constraints/design.sdc
set ::env(DEDUPLICATE_CORNERS) 1
set ::env(STA_MACRO_PRIORITIZE_NL) 1
set ::env(STA_THREADS) 1
set ::env(SIGNOFF_SDC_FILE) /home/luxyxp/Documents/mainfiles/asic/constraints/design.sdc
set ::env(CURRENT_NL) /home/luxyxp/Documents/mainfiles/asic/run/rtl2gds/54-openroad-fillinsertion/top_module.nl.v
set ::env(CURRENT_SPEF) "\"nom_*\" /home/luxyxp/Documents/mainfiles/asic/run/rtl2gds/56-openroad-rcx/nom/top_module.nom.spef \"min_*\" /home/luxyxp/Documents/mainfiles/asic/run/rtl2gds/56-openroad-rcx/min/top_module.min.spef \"max_*\" /home/luxyxp/Documents/mainfiles/asic/run/rtl2gds/56-openroad-rcx/max/top_module.max.spef"
set ::env(CURRENT_ODB) /home/luxyxp/Documents/mainfiles/asic/run/rtl2gds/55-odb-cellfrequencytables/top_module.odb
set ::env(SAVE_SDC) /home/luxyxp/Documents/mainfiles/asic/run/rtl2gds/57-openroad-stapostpnr/top_module.sdc
set ::env(OPENLANE_SDC_IDEAL_CLOCKS) 0
