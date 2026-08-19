create_project -force GPIO_Module ./Vivado_projects/GPIO_Module -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Peripherals/GPIO/ -fileset sources_1
add_files ./main_codes/testbench/Peripherals/GPIO/ -fileset sim_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# AXI Protocol Checker
add_files ./main_codes/testbench/AXI_protocol_check/axi_chk_pkg.sv -fileset sim_1
add_files ./main_codes/testbench/AXI_protocol_check/Bind_for_peripherals/axi4lite_bind_gpio.svh -fileset sim_1
add_files ./main_codes/testbench/AXI_protocol_check/axi4lite_protocol_checker.sv -fileset sim_1
set_property file_type "Verilog Header" [get_files *axi4lite_bind_gpio.svh]
reorder_files -fileset sim_1 -front [get_files -of_objects [get_filesets sim_1] *axi_chk_pkg.sv]
update_compile_order -fileset sim_1
