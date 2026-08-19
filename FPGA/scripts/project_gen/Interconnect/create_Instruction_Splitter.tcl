create_project -force Instruction_Splitter_Module Instruction_Splitter_Module -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/Interconnect/Instruction_Splitter/ -fileset sources_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
