create_project -force I2C_Module I2C_Module -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Peripherals/I2C/ -fileset sources_1
add_files ./main_codes/testbench/Peripherals/I2C/ -fileset sim_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
