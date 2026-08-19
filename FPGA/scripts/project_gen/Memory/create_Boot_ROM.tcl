create_project -force Boot_ROM_AXI4-Lite Boot_ROM_AXI4-Lite -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Memory/Boot_ROM_AXI4-Lite_Wrapper/ -fileset sources_1
add_files ./main_codes/rtl/desgin_sources/Memory/Boot_ROM_def/ -fileset sources_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
