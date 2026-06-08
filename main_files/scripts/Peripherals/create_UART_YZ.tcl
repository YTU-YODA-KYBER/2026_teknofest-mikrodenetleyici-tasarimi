create_project -force UART_YZ_Module UART_YZ_Module -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Peripherals/UART_YZ/ -fileset sources_1
add_files ./main_codes/testbench/Peripherals/UART_YZ/ -fileset sim_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
