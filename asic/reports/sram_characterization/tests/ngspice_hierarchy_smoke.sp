* Minimal ngspice hierarchical-node naming smoke test.
.subckt leaf in out
rdelay in q 1k
cstore q 0 1p
ebuf out 0 q 0 1
.ends leaf

.subckt middle in out
xleaf in out leaf
.ends middle

xtop in out middle
vin in 0 pulse(0 1.8 0 1p 1p 10n 20n)
.tran 0.1n 2n
.meas tran top_down find v(xtop.xleaf.q) at=1n
.meas tran leaf_first find v(xleaf.xtop.q) at=1n
.end
