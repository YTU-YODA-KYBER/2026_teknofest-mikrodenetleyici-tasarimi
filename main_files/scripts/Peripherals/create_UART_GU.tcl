create_project -force UART_GU_Module UART_GU_Module -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Peripherals/UART_GU/ -fileset sources_1
add_files ./main_codes/testbench/Peripherals/UART_GU/ -fileset sim_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
