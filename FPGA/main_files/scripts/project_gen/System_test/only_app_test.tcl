create_project -force ai_accel_system_test ./Vivado_projects/ai_accel_system_test -part xc7a100tcsg324-1

# Bütün RTL ve protocol check kodlarını ekleme
add_files ./main_codes/rtl/ -fileset sources_1
set_property used_in_synthesis  false [get_files ./main_codes/rtl/desgin_sources/Top_Module/Top_module.sv]
add_files ./main_codes/only_app_code/Top_module_for_app_code.sv -fileset sources_1

# Verilog Header kodlarını belirtme
set_property include_dirs ./main_codes/rtl/include [get_filesets sources_1]

# Constraint ekleme
add_files -fileset constrs_1 ./main_codes/constraint/nexys_a7_soc.xdc

# Clocking Wizard IP bloğunu ekle
add_files ./main_codes/ip/clk_wiz_0/clk_wiz_0.xci

# Firmware bellek dosyası
add_files ./firmware/makefile_outputs/app_bootrom.hex -fileset sources_1
set_property file_type "Memory File" [get_files ./firmware/makefile_outputs/app_bootrom.hex]

# Hex dosyalarının yolları
set yz_hex_dir ./main_codes/rtl/desgin_sources/AI_Accelerator

set yz_hex_files [list \
    $yz_hex_dir/weights_p8.hex     \
    $yz_hex_dir/fc_weights_p4.hex  \
    $yz_hex_dir/biases.hex      \
    $yz_hex_dir/fc_biases.hex   \
]

# AI Hex Dosyaları
add_files -fileset sources_1 $yz_hex_files
set_property file_type "Memory File" [get_files $yz_hex_files]

update_compile_order -fileset sources_1
