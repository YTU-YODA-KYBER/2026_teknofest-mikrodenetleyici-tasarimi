* Cycle 0      Port All    0.00 ns:      : Idle cycle (no positive clock edge)
* Cycle 1      Port 0      4.00 ns:      : W data 1 address 00000001
* Cycle 2      Port 0      8.00 ns:      : W data 0 address 11111111 to write value
* Cycle 3      Port 0      12.00 ns:      : Clock only on port 0
* Cycle 4      Port 0      16.00 ns:      : R data 1 address 00000001 to set dout caps
* Cycle 5      Port 0      20.00 ns:      : R data 0 address 11111111 to check W0 worked
* Cycle 6      Port 0      24.00 ns:      : Clock only on port 0
* Cycle 7      Port All    28.00 ns:      : Idle cycle (if read takes >1 cycle)
* Cycle 8      Port 0      32.00 ns:      : W data 1 address 11111111 to write value
* Cycle 9      Port 0      36.00 ns:      : Clock only on port 0
* Cycle 10     Port 0      40.00 ns:      : W data 0 address 00000001 to clear din caps
* Cycle 11     Port 0      44.00 ns:      : Clock only on port 0
* Cycle 12     Port 0      48.00 ns:      : R data 0 address 00000001 to clear dout caps
* Cycle 13     Port 0      52.00 ns:      : R data 1 address 11111111 to check W1 worked
* Cycle 14     Port All    56.00 ns:      : Idle cycle (if read takes >1 cycle))
* Read ports 0
.meas tran delay_lh0 TRIG v(clk0) VAL=0.9 FALL=1 TD=52.0n TARG v(dout0_31) VAL=0.9 RISE=1 TD=52.0n

.meas tran delay_hl0 TRIG v(clk0) VAL=0.9 FALL=1 TD=20.0n TARG v(dout0_31) VAL=0.9 FALL=1 TD=20.0n

.meas tran slew_lh0 TRIG v(dout0_31) VAL=0.18000000000000002 RISE=1 TD=52.0n TARG v(dout0_31) VAL=1.62 RISE=1 TD=52.0n

.meas tran slew_hl0 TRIG v(dout0_31) VAL=1.62 FALL=1 TD=20.0n TARG v(dout0_31) VAL=0.18000000000000002 FALL=1 TD=20.0n

.meas tran read1_power0 avg par('(-1*v(vdd)*I(vvdd))') from=52.0n to=56.0n

.meas tran read0_power0 avg par('(-1*v(vdd)*I(vvdd))') from=20.0n to=24.0n

.meas tran disabled_read1_power0 avg par('(-1*v(vdd)*I(vvdd))') from=44.0n to=48.0n

.meas tran disabled_read0_power0 avg par('(-1*v(vdd)*I(vvdd))') from=24.0n to=28.0n

.meas tran v_bl_read_zero0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.bl_0_63) AT=25.0n 

.meas tran v_br_read_zero0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) AT=25.0n 

.meas tran v_bl_read_one0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.bl_0_63) AT=57.0n 

.meas tran v_br_read_one0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) AT=57.0n 

.meas tran v_delay_lh0 FIND v(dout0_31) AT=57.0n 

.meas tran v_delay_hl0 FIND v(dout0_31) AT=25.0n 

.meas tran delay_sen0 TRIG v(clk0) VAL=0.9 FALL=1 TD=22.0n TARG v(Xsky130_sram_1kbyte_1rw1r_32x256_8.s_en0) VAL=0.9 RISE=1 TD=22.0n

.meas tran v_q_a11111111_b31_read_zero0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=25.0n 

.meas tran v_q_a11111111_b31_read_one0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=57.0n 

.meas tran v_qbar_a11111111_b31_read_zero0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q_bar) AT=25.0n 

.meas tran v_qbar_a11111111_b31_read_one0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q_bar) AT=57.0n 

* Write ports 0
.meas tran write1_power0 avg par('(-1*v(vdd)*I(vvdd))') from=32.0n to=36.0n

.meas tran write0_power0 avg par('(-1*v(vdd)*I(vvdd))') from=8.0n to=12.0n

.meas tran disabled_write1_power0 avg par('(-1*v(vdd)*I(vvdd))') from=36.0n to=40.0n

.meas tran disabled_write0_power0 avg par('(-1*v(vdd)*I(vvdd))') from=12.0n to=16.0n

.meas tran v_q_a11111111_b31_write_zero0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=13.0n 

.meas tran v_q_a11111111_b31_write_one0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=37.0n 

.meas tran v_qbar_a11111111_b31_write_zero0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q_bar) AT=13.0n 

.meas tran v_qbar_a11111111_b31_write_one0 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q_bar) AT=37.0n 

* Diagnostic samples around the write-one operation.  These do not affect the
* circuit; they localize a failed write between the registered inputs, write
* controls, column mux, and selected storage cell.
.meas tran diag_din31       FIND v(din0_31) AT=37.0n
.meas tran diag_bank_din31  FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.bank_din0[31]) AT=37.0n
.meas tran diag_wmask3      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.bank_wmask0[3]) AT=37.0n
.meas tran diag_wen         FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.w_en0) AT=37.0n
.meas tran diag_wl_en       FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.wl_en0) AT=37.0n
.meas tran diag_col_sel0    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.sel0_0) AT=37.0n
.meas tran diag_col_sel1    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.sel0_1) AT=37.0n
.meas tran diag_wdrv_sel3   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.wdriver_sel_3) AT=37.0n
.meas tran diag_bl_out31    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.bl_out_31) AT=37.0n
.meas tran diag_br_out31    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.br_out_31) AT=37.0n
.meas tran diag_wl127       FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.wl_0_127) AT=37.0n
.meas tran diag_bl63        FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.bl_0_63) AT=37.0n
.meas tran diag_br63        FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) AT=37.0n
.meas tran diag_q62_after_zero FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c62.Q) AT=13.0n
.meas tran diag_qbar62_after_zero FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c62.Q_bar) AT=13.0n
.meas tran diag_q62         FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c62.Q) AT=37.0n
.meas tran diag_qbar62      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c62.Q_bar) AT=37.0n

.meas tran active33_wen       FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.w_en0) AT=33.0n
.meas tran active33_wl_en     FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.wl_en0) AT=33.0n
.meas tran active33_wdrv_sel3 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.wdriver_sel_3) AT=33.0n
.meas tran active33_sel0      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.sel0_0) AT=33.0n
.meas tran active33_sel1      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.sel0_1) AT=33.0n
.meas tran active33_wl127     FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.wl_0_127) AT=33.0n
.meas tran active33_blout31   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.bl_out_31) AT=33.0n
.meas tran active33_brout31   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.br_out_31) AT=33.0n
.meas tran active33_bl63      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.bl_0_63) AT=33.0n
.meas tran active33_br63      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) AT=33.0n
.meas tran active33_q63       FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=33.0n
.meas tran active33_qbar63    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q_bar) AT=33.0n
.meas tran active35_wen       FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.w_en0) AT=35.0n
.meas tran active35_wl_en     FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.wl_en0) AT=35.0n
.meas tran active35_wdrv_sel3 FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.wdriver_sel_3) AT=35.0n
.meas tran active35_sel0      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.sel0_0) AT=35.0n
.meas tran active35_sel1      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.sel0_1) AT=35.0n
.meas tran active35_wl127     FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.wl_0_127) AT=35.0n
.meas tran active35_blout31   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.bl_out_31) AT=35.0n
.meas tran active35_brout31   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.br_out_31) AT=35.0n
.meas tran active35_bl63      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.bl_0_63) AT=35.0n
.meas tran active35_br63      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) AT=35.0n
.meas tran active35_q63       FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=35.0n
.meas tran active35_qbar63    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q_bar) AT=35.0n

.meas tran pulse_wen_max       MAX v(Xsky130_sram_1kbyte_1rw1r_32x256_8.w_en0) FROM=32.0n TO=36.0n
.meas tran pulse_wdrv_sel3_max MAX v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.wdriver_sel_3) FROM=32.0n TO=36.0n
.meas tran pulse_wl127_max     MAX v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.wl_0_127) FROM=32.0n TO=36.0n
.meas tran pulse_br63_min      MIN v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) FROM=32.0n TO=36.0n
.meas tran pulse_q63_max       MAX v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) FROM=32.0n TO=36.0n

.meas tran pulse341_wen  FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.w_en0) AT=34.1n
.meas tran pulse341_wsel FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.wdriver_sel_3) AT=34.1n
.meas tran pulse341_wl   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.wl_0_127) AT=34.1n
.meas tran pulse341_bl   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.bl_0_63) AT=34.1n
.meas tran pulse341_br   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) AT=34.1n
.meas tran pulse341_q    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=34.1n
.meas tran pulse345_wen  FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.w_en0) AT=34.5n
.meas tran pulse345_wsel FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.wdriver_sel_3) AT=34.5n
.meas tran pulse345_wl   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.wl_0_127) AT=34.5n
.meas tran pulse345_bl   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.bl_0_63) AT=34.5n
.meas tran pulse345_br   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) AT=34.5n
.meas tran pulse345_q    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=34.5n
.meas tran pulse349_wen  FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.w_en0) AT=34.9n
.meas tran pulse349_wsel FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.wdriver_sel_3) AT=34.9n
.meas tran pulse349_wl   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.wl_0_127) AT=34.9n
.meas tran pulse349_bl   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.bl_0_63) AT=34.9n
.meas tran pulse349_br   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) AT=34.9n
.meas tran pulse349_q    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=34.9n
.meas tran pulse353_wen  FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.w_en0) AT=35.3n
.meas tran pulse353_wsel FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xport_data0.wdriver_sel_3) AT=35.3n
.meas tran pulse353_wl   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.wl_0_127) AT=35.3n
.meas tran pulse353_bl   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.bl_0_63) AT=35.3n
.meas tran pulse353_br   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.br_0_63) AT=35.3n
.meas tran pulse353_q    FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.Q) AT=35.3n

* Inputs of the control_logic_rw write-enable gate.
.meas tran ctrl_we_max      MAX v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.we) FROM=32.0n TO=35.5n
.meas tran ctrl_rblbar_max  MAX v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.rbl_bl_delay_bar) FROM=32.0n TO=35.5n
.meas tran ctrl_gclkbar_max MAX v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.gated_clk_bar) FROM=32.0n TO=35.5n
.meas tran ctrl_rbl_min     MIN v(Xsky130_sram_1kbyte_1rw1r_32x256_8.rbl_bl0) FROM=32.0n TO=35.5n
.meas tran ctrl341_we       FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.we) AT=34.1n
.meas tran ctrl341_rbl      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.rbl_bl0) AT=34.1n
.meas tran ctrl341_rbldly   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.rbl_bl_delay) AT=34.1n
.meas tran ctrl341_rblbar   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.rbl_bl_delay_bar) AT=34.1n
.meas tran ctrl341_gclkbar  FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.gated_clk_bar) AT=34.1n
.meas tran ctrl345_we       FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.we) AT=34.5n
.meas tran ctrl345_rbl      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.rbl_bl0) AT=34.5n
.meas tran ctrl345_rbldly   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.rbl_bl_delay) AT=34.5n
.meas tran ctrl345_rblbar   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.rbl_bl_delay_bar) AT=34.5n
.meas tran ctrl345_gclkbar  FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.gated_clk_bar) AT=34.5n
.meas tran ctrl349_we       FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.we) AT=34.9n
.meas tran ctrl349_rbl      FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.rbl_bl0) AT=34.9n
.meas tran ctrl349_rbldly   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.rbl_bl_delay) AT=34.9n
.meas tran ctrl349_rblbar   FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.rbl_bl_delay_bar) AT=34.9n
.meas tran ctrl349_gclkbar  FIND v(Xsky130_sram_1kbyte_1rw1r_32x256_8.xcontrol0.gated_clk_bar) AT=34.9n
