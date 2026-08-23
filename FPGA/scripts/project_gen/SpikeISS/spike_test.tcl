# =====================================================================
#  SPIKE ISS LOCKSTEP PROJESI
#  ------------------------------------------------------------------
#  Ne yapar: CV32E40P'nin komut izini (trace_core_00000000.log) uretecek
#            simulasyon-only bir Vivado projesi kurar. Uretilen iz,
#            spike'in --log-commits ciktisiyla karsilastirilir.
#
#  NEREDE CALISTIRILIR: mainfiles/FPGA/ kokunde
#      vivado -mode batch -source scripts/project_gen/SpikeISS/spike_test.tcl
#    veya Vivado Tcl Console'da:
#      cd /home/luxyxp/Documents/mainfiles/FPGA
#      source scripts/project_gen/SpikeISS/spike_test.tcl
#
#  Bu proje SENTEZ ICIN DEGILDIR; sadece davranissal simulasyon kosar.
# =====================================================================

# ---------------------------------------------------------------------
#  Test programinin hex'i (objcopy -O verilog --verilog-data-width=4 ciktisi)
#  Spike akisi depo DISINDA yasadigi icin yol burada tek degiskende duruyor.
#  Baska bir programi kosturmak istersen sadece burayi degistir.
# ---------------------------------------------------------------------
set spike_hex /home/luxyxp/Documents/spike_try/verif/build/test.hex

create_project -force spike_test ./Vivado_projects/spike_test -part xc7a100tcsg324-1

# ---------------------------------------------------------------------
#  RTL — ana projenin tamami (dosyalarin hicbirine dokunulmuyor)
# ---------------------------------------------------------------------
add_files ./main_codes/rtl/ -fileset sources_1
set_property include_dirs ./main_codes/rtl/include [get_filesets sources_1]

# Clocking Wizard IP (fpga_top.sv onu ornekliyor; sim'de fpga_top devre disi)
add_files ./main_codes/ip/clk_wiz_0/clk_wiz_0.xci

# ---------------------------------------------------------------------
#  CV32E40P TRACER (upstream bhv/ dosyalari)
#  Sadece sim_1'e eklenir: sentezlenemez kod, sources_1'e ASLA girmemeli.
#  cv32e40p_instr_trace.svh `include ile cekiliyor -> dosya olarak degil,
#  include_dirs ile gorunur yapiliyor.
# ---------------------------------------------------------------------
set bhv_dir ./main_codes/testbench/spike_iss/cv32e40p-cv32e40p_v1.8.2/bhv

add_files -fileset sim_1 $bhv_dir/include/cv32e40p_tracer_pkg.sv
add_files -fileset sim_1 $bhv_dir/cv32e40p_tracer.sv

# ---------------------------------------------------------------------
#  Testbench
# ---------------------------------------------------------------------
add_files -fileset sim_1 ./main_codes/testbench/spike_iss/spike_iss_test.sv

set_property include_dirs [list \
    $bhv_dir                    \
    $bhv_dir/include            \
    ./main_codes/rtl/include    \
] [get_filesets sim_1]

# ---------------------------------------------------------------------
#  Bellek dosyalari
#   - test.hex : testbench INSTRRAM'e yukluyor ($fopen ile, isimle)
#   - boot.hex : Boot ROM'un $readmemh'i bos kalmasin diye (bu testte
#                boot_addr = 0x10000000 oldugu icin ICERIGI KULLANILMIYOR)
# ---------------------------------------------------------------------
if {[file exists $spike_hex]} {
    add_files -fileset sim_1 $spike_hex
    set_property file_type "Memory File" [get_files $spike_hex]
} else {
    puts "UYARI: $spike_hex bulunamadi."
    puts "       Once spike akisinda derleyip objcopy ile hex uret:"
    puts "         riscv-none-elf-objcopy -O verilog --verilog-data-width=4 \\"
    puts "             build/test.elf build/test.hex"
    puts "       Sonra bu scripti tekrar kosar veya dosyayi elle sim_1'e eklersin."
}

add_files -fileset sim_1 ./firmware/makefile_outputs/boot.hex
set_property file_type "Memory File" [get_files ./firmware/makefile_outputs/boot.hex]

# ---------------------------------------------------------------------
#  YZ hizlandiricisinin agirlik ROM'lari
#  Kullanilmiyor ama RTL'in tamami projede oldugu icin $readmemh'leri
#  bos kalmasin (aksi halde her elaborate'te uyari yagmuru).
# ---------------------------------------------------------------------
set yz_hex_dir ./main_codes/rtl/desgin_sources/AI_Accelerator
set yz_hex_files [list \
    $yz_hex_dir/weights_p8.hex    \
    $yz_hex_dir/fc_weights_p4.hex \
    $yz_hex_dir/biases.hex        \
    $yz_hex_dir/fc_biases.hex     \
]
add_files -fileset sources_1 $yz_hex_files
set_property file_type "Memory File" [get_files $yz_hex_files]
set_property used_in_synthesis  true [get_files $yz_hex_files]
set_property used_in_simulation true [get_files $yz_hex_files]

# ---------------------------------------------------------------------
#  fpga_top ve clk_wiz simulasyona girmez — testbench dogrudan
#  top_module'u orneklyor (parametreleri ezebilmek icin).
# ---------------------------------------------------------------------
set_property used_in_simulation false [get_files fpga_top.sv]
set_property used_in_simulation false [get_files clk_wiz_0.xci]

# ---------------------------------------------------------------------
#  TRACER'I ACAN DEFINE
#
#  DIKKAT — define'i "xsim.compile.xvlog.more_options" ile -d olarak
#  vermek YETMEZ. O secenek sadece xvlog komut satirina eklenir; Vivado'nun
#  KENDI hiyerarsi cozucusu onu gormez. Tracer `ifdef icinde ornekleniyor,
#  Vivado da define'i bilmedigi icin "bu modul hicbir yerde kullanilmiyor"
#  deyip cv32e40p_tracer.sv'yi derleme sirasindan tamamen ATAR ve
#  elaborate'te "Module <cv32e40p_tracer> not found" hatasi alirsin.
#
#  Fileset'in VERILOG_DEFINE property'si ise hem hiyerarsi cozucuye hem
#  xvlog'a gecer. Dogru yol budur.
# ---------------------------------------------------------------------
set_property verilog_define {CV32E40P_TRACE_EXECUTION} [get_filesets sim_1]

# ---------------------------------------------------------------------
#  UVM KUTUPHANESI
#  v1.8.2 tracer'i `uvm_info makrolarini kullaniyor (import uvm_pkg::*).
#  XSim'in kendi UVM 1.2 kutuphanesi var; -L uvm ile baglaniyor ve
#  HEM xvlog HEM xelab tarafina verilmeli.
# ---------------------------------------------------------------------
set_property -name {xsim.compile.xvlog.more_options} \
             -value {-L uvm} \
             -objects [get_filesets sim_1]

set_property -name {xsim.elaborate.xelab.more_options} \
             -value {-L uvm} \
             -objects [get_filesets sim_1]

# Simulasyon suresi: testbench kendi kendine $finish ediyor
# (sonsuz dongu tespiti / watchdog), o yuzden -runall.
set_property -name {xsim.simulate.runtime} -value {all} -objects [get_filesets sim_1]

# ---------------------------------------------------------------------
#  Derleme sirasi ve top
#  cv32e40p_tracer_pkg, tracer'dan ONCE derlenmeli.
# ---------------------------------------------------------------------
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property top spike_iss_test [get_filesets sim_1]

reorder_files -fileset sim_1 -front \
    [get_files -of_objects [get_filesets sim_1] *cv32e40p_tracer_pkg.sv]
update_compile_order -fileset sim_1

puts ""
puts "======================================================================"
puts " spike_test projesi hazir."
puts "   Simulasyon : Flow Navigator -> Run Simulation -> Run Behavioral"
puts "   Trace      : <proje>/spike_test.sim/sim_1/behav/xsim/trace_core_00000000.log"
puts "======================================================================"
