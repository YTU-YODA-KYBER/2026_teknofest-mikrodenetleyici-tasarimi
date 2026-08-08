create_project -force ai_accel_system_test ./Vivado_projects/ai_accel_system_test -part xc7a100tcsg324-1

# Bütün RTL ve protocol check kodlarını ekleme
add_files ./main_codes/rtl/ -fileset sources_1
add_files ./main_codes/testbench/AXI_protocol_check/axi_chk_pkg.sv -fileset sim_1
add_files ./main_codes/testbench/AXI_protocol_check/axi4lite_bind.svh -fileset sim_1
add_files ./main_codes/testbench/AXI_protocol_check/axi4lite_protocol_checker.sv -fileset sim_1
add_files ./main_codes/testbench/Peripherals/QSPI/Micron_sim_model.v -fileset sim_1
add_files ./main_codes/testbench/System_Test/ai_accel_test.sv -fileset sim_1
add_files ./firmware/sound_samples/ -fileset sim_1

# Verilog Header kodlarını belirtme
set_property include_dirs ./main_codes/rtl/include [get_filesets sources_1]
set_property file_type "Verilog Header" [get_files *axi4lite_bind.svh]

# Constraint ekleme
add_files -fileset constrs_1 ./main_codes/constraint/nexys_a7_soc.xdc

# Clocking Wizard IP bloğunu ekle
add_files ./main_codes/ip/clk_wiz_0/clk_wiz_0.xci

# Firmware bellek dosyası
add_files ./firmware/makefile_outputs/sim_app.hex
set_property file_type "Memory File" [get_files ./firmware/makefile_outputs/sim_app.hex]

# Hex dosyalarının yolları
set yz_hex_dir ./main_codes/rtl/desgin_sources/AI_Accelerator
set sound_samples_dir ./firmware/sound_samples/

set yz_hex_files [list \
    $yz_hex_dir/weights_p8.hex     \
    $yz_hex_dir/fc_weights_p4.hex  \
    $yz_hex_dir/biases.hex      \
    $yz_hex_dir/fc_biases.hex   \
]

set sound_samples [list \
    $sound_samples_dir/input_data_no.hex     \
    $sound_samples_dir/input_data_yes.hex  \
    $sound_samples_dir/input_data_sessizlik.hex      \
]

# AI Hex Dosyaları
add_files -fileset sources_1 $yz_hex_files
add_files -fileset sources_1 $sound_samples
set_property file_type "Memory File" [get_files $yz_hex_files]
set_property file_type "Memory File" [get_files $sound_samples]

set_property used_in_synthesis  true [get_files $yz_hex_files]
set_property used_in_simulation true [get_files $yz_hex_files]

set_property used_in_synthesis  true [get_files $sound_samples]
set_property used_in_simulation true [get_files $sound_samples]

set_property used_in_simulation false [get_files fpga_top.sv]
set_property used_in_simulation false [get_files clk_wiz_0.xci]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property top ai_accel_test [get_filesets sim_1]

# 3. Paket sıralaması ve son hiyerarşi güncellemesi
reorder_files -fileset sim_1 -front [get_files -of_objects [get_filesets sim_1] *axi_chk_pkg.sv]
update_compile_order -fileset sim_1
