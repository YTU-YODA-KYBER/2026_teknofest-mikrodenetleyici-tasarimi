create_project -force QSPI_Module QSPI_Module -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Peripherals/QSPI/ -fileset sources_1
add_files ./main_codes/testbench/Peripherals/QSPI/ -fileset sim_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
