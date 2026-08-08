create_project -force Interconnect_Module Interconnect_Module -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Interconnect/Interconnect/ -fileset sources_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
