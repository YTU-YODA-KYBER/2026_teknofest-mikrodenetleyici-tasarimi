# -------------------------------------------------------------------------
# CV32E40P OBI-to-AXI WRAPPER - 50 MHz ZAMANLAMA KISITLAMALARI (SDC)
# -------------------------------------------------------------------------

# -------------------------------------------------------------------------
# 1. TEMEL ZAMANLAMA DEĞERLERİ
# -------------------------------------------------------------------------
# 50 MHz Frekans -> Periyot: 20.0 ns
set CLK_PERIOD 20.0

# Giriş ve çıkışlar için %20 güvenlik marjı bırakıyoruz (4.0 ns)
set I_DELAY 2.0
set O_DELAY 2.0

# -------------------------------------------------------------------------
# 2. SAAT (CLOCK) VE RESET KISITLAMALARI
# -------------------------------------------------------------------------
# Sentez aracına saat sinyalinin frekansını tanımlıyoruz
create_clock -name core_clk -period $CLK_PERIOD [get_ports clk_i]

set_property CLOCK_BUFFER_TYPE BUFG [get_ports clk_i]

# Gerçek dünyadaki fiziksel sinyal bozulmaları (Jitter) için 0.5 ns belirsizlik ekliyoruz
set_clock_uncertainty -setup 0.5 [get_clocks core_clk]
set_clock_uncertainty -hold 0.05 [get_clocks core_clk]

# Asenkron Reset sinyalinin zamanlama analizine girmesini engelliyoruz (False Path)
set_false_path -from [get_ports rst_ni]

# -------------------------------------------------------------------------
# 3. GİRİŞ GECİKMELERİ (INPUT DELAYS)
# AXI Interconnect'ten gelip işlemciye giren sinyaller
# -------------------------------------------------------------------------

# --- INSTRUCTION AXI GİRİŞLERİ ---
set_input_delay $I_DELAY -clock core_clk [get_ports axi_instr_arready]
set_input_delay $I_DELAY -clock core_clk [get_ports {axi_instr_rid[*] axi_instr_rdata[*] axi_instr_rresp[*] axi_instr_rlast axi_instr_rvalid}]

# --- DATA AXI GİRİŞLERİ ---
# Write Kanalları (AW, W, B)
set_input_delay $I_DELAY -clock core_clk [get_ports axi_data_awready]
set_input_delay $I_DELAY -clock core_clk [get_ports axi_data_wready]
set_input_delay $I_DELAY -clock core_clk [get_ports {axi_data_bid[*] axi_data_bresp[*] axi_data_bvalid}]

# Read Kanalları (AR, R)
set_input_delay $I_DELAY -clock core_clk [get_ports axi_data_arready]
set_input_delay $I_DELAY -clock core_clk [get_ports {axi_data_rid[*] axi_data_rdata[*] axi_data_rresp[*] axi_data_rlast axi_data_rvalid}]

# -------------------------------------------------------------------------
# 4. ÇIKIŞ GECİKMELERİ (OUTPUT DELAYS)
# İşlemciden çıkıp AXI Interconnect'e giden sinyaller
# -------------------------------------------------------------------------

# --- INSTRUCTION AXI ÇIKIŞLARI ---
# Instruction tarafı sadece komut okuduğu için AW ve W kanalları kullanılmıyor (Sadece AR ve R)
set_output_delay $O_DELAY -clock core_clk [get_ports {axi_instr_arid[*] axi_instr_araddr[*] axi_instr_arlen[*] axi_instr_arsize[*] axi_instr_arburst[*] axi_instr_arprot[*] axi_instr_arvalid}]
set_output_delay $O_DELAY -clock core_clk [get_ports axi_instr_rready]

# --- DATA AXI ÇIKIŞLARI ---
# Write Address ve Write Data Kanalları
set_output_delay $O_DELAY -clock core_clk [get_ports {axi_data_awid[*] axi_data_awaddr[*] axi_data_awlen[*] axi_data_awsize[*] axi_data_awburst[*] axi_data_awprot[*] axi_data_awvalid}]
set_output_delay $O_DELAY -clock core_clk [get_ports {axi_data_wdata[*] axi_data_wstrb[*] axi_data_wlast axi_data_wvalid}]
set_output_delay $O_DELAY -clock core_clk [get_ports axi_data_bready]

# Read Address ve Read Response Kanalları
set_output_delay $O_DELAY -clock core_clk [get_ports {axi_data_arid[*] axi_data_araddr[*] axi_data_arlen[*] axi_data_arsize[*] axi_data_arburst[*] axi_data_arprot[*] axi_data_arvalid}]
set_output_delay $O_DELAY -clock core_clk [get_ports axi_data_rready]

# -------------------------------------------------------------------------
# SON
# -------------------------------------------------------------------------