* Match the real SRAM hierarchy and instance-name lengths without PDK models.
.subckt bitcell p n
rbit p q 1k
rbitbar q_bar n 1k
.ends bitcell

.subckt bitcell_array p n
xbit_r127_c63 p n bitcell
.ends bitcell_array

.subckt replica_bitcell_array p n s_en0
xbitcell_array p n bitcell_array
rsense s_en0 0 1k
.ends replica_bitcell_array

.subckt bank q q_bar s_en0
xbitcell_array q q_bar s_en0 replica_bitcell_array
.ends bank

.subckt sky130_sram_1kbyte_1rw1r_32x256_8 out
xbank0 q q_bar s_en0 bank
rout q out 1k
.ends sky130_sram_1kbyte_1rw1r_32x256_8

xsky130_sram_1kbyte_1rw1r_32x256_8 out_long sky130_sram_1kbyte_1rw1r_32x256_8
xsram out_short sky130_sram_1kbyte_1rw1r_32x256_8
voutlong out_long 0 0
voutshort out_short 0 0
.tran 0.1n 1n
.meas tran sen find v(xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.s_en0) at=0.5n
.meas tran q_internal find v(xsky130_sram_1kbyte_1rw1r_32x256_8.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.q) at=0.5n
.meas tran short_sen find v(xsram.xbank0.s_en0) at=0.5n
.meas tran short_q_internal find v(xsram.xbank0.xbitcell_array.xbitcell_array.xbit_r127_c63.q) at=0.5n
.meas tran actual_long_sen find v(xsky130_sram_1kbyte_1rw1r_32x256_8.s_en0) at=0.5n
.meas tran actual_short_sen find v(xsram.s_en0) at=0.5n
.end
