# Add your design files into the Vivado project
# 
# To add design files, use
#   add_files <PATH_TO_YOUR_DESIGN_FOLDER>
# Example:
#   add_files ../user/rtl/teknotest_wrapper.sv
#
# To add include directories, use
#   set_property include_dirs [file normalize <PATH_TO_YOUR_INCLUDE_FOLDER>] [list [get_filesets sources_1] [get_filesets sim_1]]
# Example:
#   set_property include_dirs [file normalize "../user/rtl/core/include/"] [list [get_filesets sources_1] [get_filesets sim_1]]
#
# If you need to add verilog defines, use
#   set_property verilog_define {<YOUR_DEFINES>} [list [get_filesets sources_1] [get_filesets sim_1]]
# Example:
#   set_property verilog_define {SIMULATION USE_CG_BEHAV_MODELS} [list [get_filesets sources_1] [get_filesets sim_1]]
# 
# Note1: Keep in mind that you will be in teknotest directory, set your file/folder paths relative to that directory 
# Note2: You can use slashes(/) in Windows too to seperate the paths

set_property include_dirs [file normalize "../rtl/include/"] \
    [list [get_filesets sources_1] [get_filesets sim_1]]

add_files ../rtl/
