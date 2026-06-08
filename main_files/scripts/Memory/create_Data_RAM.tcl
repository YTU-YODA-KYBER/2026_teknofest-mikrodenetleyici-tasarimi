create_project -force Data_RAM_AXI4-Lite Data_RAM_AXI4-Lite -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Memory/Data_RAM_AXI4-Lite_Wrapper/ -fileset sources_1
add_files ./main_codes/rtl/desgin_sources/Memory/RAM_def/ -fileset sources_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
