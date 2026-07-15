# Projeyi ve tüm otomatik çıktıları (.gen dahil) 'build' klasörü altında topluyoruz
create_project -force Full_MCU_Project ./Vivado_projects/Full_MCU_Project -part xc7a100tcsg324-1

# Bütün RTL kodlarını ekleme
add_files ./main_codes/rtl/ -fileset sources_1

# Verilog Header kodlarını belirtme
set_property include_dirs ./main_codes/rtl/include [get_filesets sources_1]

# Constraint ekleme
add_files -fileset constrs_1 ./main_codes/constraint/nexys_a7_soc.xdc

# Clocking Wizard IP bloğunu ekle ve çıktılarını otomatik üret
add_files ./main_codes/ip/clk_wiz_0/clk_wiz_0.xci

# 1. Dosyayı projeye ekle
add_files ./firmware/build_main/firmware.hex
# 2. Dosya türünü "Memory File" olarak ayarla
set_property file_type "Memory File" [get_files ./firmware/build_main/firmware.hex]

set yz_hex_dir ./main_codes/rtl/desgin_sources/AI_Accelerator

set yz_hex_files [list \
    $yz_hex_dir/weights.hex     \
    $yz_hex_dir/fc_weights.hex  \
    $yz_hex_dir/biases.hex      \
    $yz_hex_dir/fc_biases.hex   \
]

add_files -fileset sources_1 $yz_hex_files
set_property file_type "Memory File" [get_files $yz_hex_files]
set_property used_in_synthesis  true [get_files $yz_hex_files]
set_property used_in_simulation true [get_files $yz_hex_files]

set_property used_in_simulation false [get_files fpga_top.sv]
set_property used_in_simulation false [get_files clk_wiz_0.xci]

update_compile_order -fileset sources_1
update_compile_order -fileset constrs_1
