* Standalone smoke test for the exact control DFF subcircuit used by the SRAM.
.lib "/home/luxyxp/.ciel/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.include "/tmp/openram_luxyxp_152448_temp/trimmed.sp"

Vvdd vdd 0 1.8
Vclk clk 0 PULSE(0 1.8 1n 0.04n 0.04n 0.96n 2n)
Vcsb csb 0 PWL(0 1.8 0.70n 1.8 0.74n 0)
Vweb web 0 PWL(0 1.8 0.70n 1.8 0.74n 0)

Xctrl_dffs csb web cs_bar cs we_bar we clk vdd 0 dff_buf_array

.meas tran smoke_cs      FIND v(cs) AT=1.5n
.meas tran smoke_cs_bar  FIND v(cs_bar) AT=1.5n
.meas tran smoke_we      FIND v(we) AT=1.5n
.meas tran smoke_we_bar  FIND v(we_bar) AT=1.5n
.tran 5p 3n UIC
.options reltol=0.001 method=gear
.end
