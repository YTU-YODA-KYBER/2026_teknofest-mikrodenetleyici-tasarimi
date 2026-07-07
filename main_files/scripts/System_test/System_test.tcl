create_project -force System_Test_sim System_Test_sim -part xc7a35tcpg236-1

# Bütün RTL kodlarını ekleme
add_files ./main_codes/rtl/ -fileset sources_1

add_files ./main_codes/testbench/System_Test/system_test/ -fileset sim_1

set_property used_in_simulation false [get_files fpga_top.sv]

# Verilog Header kodlarını belirtme
set_property include_dirs ./main_codes/rtl/include [get_filesets sources_1]

# Constraint ekleme
add_files -fileset constrs_1 ./main_codes/constraint/nexys_a7_soc.xdc

# Clocking Wizard IP bloğunu ekle
add_files ./main_codes/ip/clk_wiz_0/clk_wiz_0.xci
set_property used_in_simulation false [get_files clk_wiz_0.xci]

# 1. Dosyayı projeye ekle
add_files ./firmware/build_main_sim/firmware.hex

# 2. Dosya türünü "Memory File" olarak ayarla
set_property file_type "Memory File" [get_files ./firmware/build_main_sim/firmware.hex]

update_compile_order -fileset sources_1
update_compile_order -fileset constrs_1
update_compile_order -fileset sim_1
