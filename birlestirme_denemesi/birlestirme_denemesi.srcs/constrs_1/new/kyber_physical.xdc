# -------------------------------------------------------------------------
# 1. ANA SAAT (CLOCK) PIN ATAMASI
# -------------------------------------------------------------------------
# NOT: W5 pini Basys3 kartının 100MHz saat pinidir. 
# Kendi kartının (Nexys, Zybo vb.) şemasından gerçek pin kodunu bulup W5 yerine onu yazmalısın.
set_property PACKAGE_PIN W5 [get_ports sys_clk_pin]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk_pin]

# Vivado'nun Timing Analizi yapabilmesi için fiziksel pinin frekansını tanımlıyoruz:
create_clock -add -name sys_clk_pin -period 10.000 [get_ports sys_clk_pin]


# -------------------------------------------------------------------------
# 2. FİZİKSEL RESET BUTONU PIN ATAMASI
# -------------------------------------------------------------------------
# NOT: U18 pini Basys3 kartındaki orta butondur. Kendi kartına göre değiştir.
set_property PACKAGE_PIN U18 [get_ports btn_reset]
set_property IOSTANDARD LVCMOS33 [get_ports btn_reset]