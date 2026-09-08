# ---------------------------------------------------------------------------
#  asic/filelist.f -- ASIC fiziksel tasarim akisinda kullanilan RTL kaynaklari
#
#  URETEN: asic/scripts/gen_filelist.py   (`make filelist`)
#
#  Butun yollar bu dosyanin bulundugu asic/ dizinine gorelidir; makineye ozgu
#  mutlak yol yoktur. Sira HDL derleme bagimliliklarini karsilar: once
#  paketler, sonra alt moduller, en sonda ust modul.
#
#  FPGA AKISIYLA FARKLAR -- mevcut RTL'in tek satiri bile degistirilmemistir;
#  fark yalnizca bu listede hangi dosyanin secildigidir:
#
#    1) fpga_top.sv listede YOKTUR. Xilinx clk_wiz_0 (MMCM) IP'sine baglidir;
#       ASIC'te ust modul dogrudan top_module'dur, saat pad'den gelir.
#
#    2) Memory/BRAM_defines/*.sv ve YZ hizlandiricinin ROM/RAM dosyalari yerine
#       asic_rtl/ altindaki AYNI ISIMLI moduller kullanilir:
#         * degisken bellekler (Instr/Data RAM, YZ girdi RAM'i, conv tamponu)
#           -> SKY130 SRAM makrolari
#         * kalici bellekler (Boot ROM, YZ agirlik ROM'lari)
#           -> standart hucrelerden orulmus mask ROM (silikonda guc verildiginde
#              hazir; SRAM makrosu ilklendirilemedigi icin zorunlu)
#       Esdegerlik kaniti: asic_rtl/testbench/tb_asic_mem_equiv.sv
#
#    3) Xilinx IOBUF primitifinin teknolojiden bagimsiz karsiligi eklenmistir.
#
#    4) CV32E40P FPU=0 ile yapilandirildigi icin fpnew agaci ve fp_wrapper
#       listede yoktur (elaborate edilmeyen generate blogunda kalirlar).
#
#  Include dizini: ../FPGA/main_codes/rtl/include/CPU
# ---------------------------------------------------------------------------

+incdir+../FPGA/main_codes/rtl/include/CPU


# --- Paketler ve typedef'ler -- her seyden once derlenmeli ---
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/include/cv32e40p_pkg.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/include/cv32e40p_apu_core_pkg.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/include/cv32e40p_fpu_pkg.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/vendor/pulp_platform_common_cells/src/cf_math_pkg.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/openhw_obi_to_axi/axi_pkg.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/openhw_obi_to_axi/obi_pkg.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/bizim_kodlar/axi_req_rsp_ports.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/bizim_kodlar/obi_req_rsp_ports.sv

# --- Yamali RTL kopyalari -- orijinallerine DOKUNULMAMISTIR (bkz. asic/scripts/patch_rtl.py) ---
../asic_rtl/patched/obi_to_axi_asic.sv
../asic_rtl/patched/cv32e40p_obi_to_axi_wrapper_asic.sv
../asic_rtl/patched/instr_bram_axi_ctrl_asic.sv
../asic_rtl/patched/data_bram_axi_ctrl_asic.sv
../asic_rtl/patched/GPIO_AXI4_Lite_asic.sv
../asic_rtl/patched/Timer_AXI4_Lite_asic.sv
../asic_rtl/patched/QSPI_Master_AXI4_Lite_asic.sv
../asic_rtl/patched/UART_GU_AXI4_Lite_asic.sv
../asic_rtl/patched/UART_YZ_AXI4_Lite_asic.sv
../asic_rtl/patched/conv_accelerator_asic.v

# --- ASIC teknoloji sarmalayicisi (FPGA akisinda YOKTUR) ---
../asic_rtl/tech/xilinx_iobuf_stub.sv
../asic_rtl/tech/axi_read_arbiter2.sv

# --- ASIC degisken bellekleri: SKY130 SRAM makro sarmalayicilari ---
../asic_rtl/mem/sram32_cell.sv
../asic_rtl/mem/sram32_cell_1k.sv
../asic_rtl/mem/sram32_bank.sv
../asic_rtl/mem/sram8_bank.sv
../asic_rtl/mem/bram_instr_asic.sv
../asic_rtl/mem/bram_data_asic.sv
../asic_rtl/mem/bram_yz_asic.sv
../asic_rtl/mem/conv_buf_ram_asic.sv

# --- ASIC kalici bellekleri: uretilmis mask ROM'lar (gen_rom.py ciktisi) ---
../asic_rtl/gen/boot_rom_asic.sv
../asic_rtl/gen/weights_rom_p8_asic.v
../asic_rtl/gen/fc_weights_rom_p4_asic.v

# --- CV32E40P -- ucuncu taraf yardimci moduller (pulp-platform) ---
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/vendor/pulp_platform_common_cells/include/common_cells/src/fifo_v3.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/vendor/pulp_platform_common_cells/src/lzc.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/vendor/pulp_platform_common_cells/src/rr_arb_tree.sv

# --- CV32E40P RISC-V cekirdegi ---
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_aligner.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_alu.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_alu_div.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_apu_disp.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_clock_gate.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_compressed_decoder.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_controller.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_core.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_cs_registers.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_decoder.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_ex_stage.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_ff_one.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_fifo.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_hwloop_regs.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_id_stage.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_if_stage.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_int_controller.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_load_store_unit.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_mult.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_obi_interface.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_popcnt.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_prefetch_buffer.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_prefetch_controller.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_register_file_ff.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_sleep_unit.sv
../FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/cv32e40p_top.sv

# --- Bellek AXI4-Lite kontrolculeri ---
../FPGA/main_codes/rtl/desgin_sources/Memory/Boot_ROM_AXI4-Lite_Wrapper/boot_bram_axi_ctrl.sv
../FPGA/main_codes/rtl/desgin_sources/Memory/YZ_RAM_AXI4-Lite/yz_bram_axi_ctrl.sv

# --- Ara baglanti ---
../FPGA/main_codes/rtl/desgin_sources/Interconnect/Instruction_Splitter/Instruction_Splitter.sv
../FPGA/main_codes/rtl/desgin_sources/Interconnect/Interconnect/AXI4_Interconnect.sv

# --- Cevre birimleri ---
../FPGA/main_codes/rtl/desgin_sources/Peripherals/I2C/I2C_Master_AXI4_Lite.sv

# --- YZ hizlandirici ---
../FPGA/main_codes/rtl/desgin_sources/AI_Accelerator/yz_csr_wrapper.sv

# --- ASIC reset synchronizer'li ust modul (en son) ---
../asic_rtl/patched/Top_module_asic.sv
