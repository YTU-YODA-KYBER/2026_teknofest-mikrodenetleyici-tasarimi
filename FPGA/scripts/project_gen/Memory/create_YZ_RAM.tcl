create_project -force YZ_RAM ./Vivado_projects/YZ_RAM -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Memory/YZ_RAM_AXI4-Lite/ -fileset sources_1
add_files ./main_codes/rtl/desgin_sources/Memory/BRAM_defines/bram_yz_def.sv -fileset sources_1
add_files ./main_codes/testbench/Memory/ -fileset sim_1

set_property top yz_bram_ctrl_tb [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
