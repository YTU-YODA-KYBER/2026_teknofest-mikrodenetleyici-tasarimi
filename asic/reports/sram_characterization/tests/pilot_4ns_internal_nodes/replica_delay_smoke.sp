* Standalone delay-chain measurement using the exact SRAM/PDK subcircuits.
.lib "/home/luxyxp/.ciel/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.include "/tmp/openram_luxyxp_152448_temp/trimmed.sp"

Vvdd vdd 0 1.8
Vrbl rbl 0 PWL(0 1.8 0.98n 1.8 1.02n 0 12n 0)
Xdelay rbl rbl_delay vdd 0 delay_chain
Xinv rbl_delay rbl_delay_bar vdd 0 pinv_0

.meas tran rbl_fall_delay TRIG v(rbl) VAL=0.9 FALL=1 TARG v(rbl_delay) VAL=0.9 FALL=1
.meas tran rblbar_rise_delay TRIG v(rbl) VAL=0.9 FALL=1 TARG v(rbl_delay_bar) VAL=0.9 RISE=1
.meas tran final_rbl_delay FIND v(rbl_delay) AT=12n
.meas tran final_rblbar FIND v(rbl_delay_bar) AT=12n
.tran 5p 12n UIC
.options reltol=0.001 method=gear
.end
