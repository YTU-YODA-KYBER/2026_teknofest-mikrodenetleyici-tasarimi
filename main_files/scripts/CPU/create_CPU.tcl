create_project -force CPU_AXI4-Lite CPU_AXI4-Lite -part xc7a35tcpg236-1

add_files ./main_codes/rtl/desgin_sources/CPU/ -fileset sources_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property include_dirs [file normalize "./main_codes/rtl/include/CPU/"] \
    [list [get_filesets sources_1] [get_filesets sim_1]]
