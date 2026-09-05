# TEKNOFEST 2026 final FPGA build
#
# Bu betik FPGA/ kokunden calisir ve Main_MCU_Project.tcl ile projeyi sifirdan
# kurduktan sonra sentez, implementasyon, signoff raporlari ve bitstream'i
# uretir. Grafik arayuz veya kullanici etkilesimi gerektirmez.

set script_dir [file dirname [file normalize [info script]]]
set fpga_dir   [file dirname $script_dir]
set report_dir [file join $fpga_dir verification vivado_reports]
set synth_dir  [file join $report_dir synthesis]
set impl_dir   [file join $report_dir implementation]
set timing_dir [file join $report_dir timing_report]
set power_dir  [file join $report_dir power]
set bit_dir    [file join $fpga_dir bitstream_files]
# Kaynak XCI eski proje adini goreli cikti yolu olarak tasiyor. Vivado bu
# cekirdek icin repo kokunde Full_MCU_Project.gen olusturdugundan, temiz kosum
# garantisi icin bu uretilen dizini de akisin basinda ve sonunda temizle.
set legacy_ip_output_dir [file normalize [file join $fpga_dir .. Full_MCU_Project.gen]]

foreach dir [list $synth_dir $impl_dir $timing_dir $power_dir $bit_dir] {
    file mkdir $dir
}

# Basarisiz bir yeni kosumun eski raporlari guncelmis gibi birakmamasi icin
# yalnizca bu betigin urettigi teslim dosyalarini bastan temizle.
set output_files [list \
    [file join $synth_dir fpga_top_utilization_synth.rpt] \
    [file join $synth_dir error_free_synthesis.log] \
    [file join $impl_dir fpga_top_utilization_impl.rpt] \
    [file join $impl_dir fpga_top_route_status.rpt] \
    [file join $impl_dir fpga_top_drc.rpt] \
    [file join $impl_dir error_free_implementation.log] \
    [file join $timing_dir timing_report.txt] \
    [file join $power_dir fpga_top_power.rpt] \
    [file join $bit_dir fpga_top.bit] \
]
foreach output_file $output_files {
    if {[file exists $output_file]} {
        file delete -force $output_file
    }
}
if {[file exists $legacy_ip_output_dir]} {
    file delete -force $legacy_ip_output_dir
}

if {[info exists ::env(FPGA_JOBS)]} {
    set jobs $::env(FPGA_JOBS)
} else {
    set jobs 4
}
if {![string is integer -strict $jobs] || $jobs < 1} {
    error "FPGA_JOBS pozitif bir tam sayi olmalidir (alinan: '$jobs')"
}

proc require_complete_run {run_name} {
    set status [get_property STATUS [get_runs $run_name]]
    puts "==> $run_name durumu: $status"
    if {![string match "*Complete*" $status]} {
        error "$run_name basarisiz veya eksik tamamlandi: $status"
    }
}

cd $fpga_dir
puts "==> Vivado projesi temiz olarak olusturuluyor"
set project_dir [file join $fpga_dir Vivado_projects Main_MCU_Project]
if {[file exists $project_dir]} {
    file delete -force $project_dir
}
source [file join $script_dir project_gen Main_MCU_Project.tcl]
set_param general.maxThreads $jobs

puts "==> Sentez baslatiliyor ($jobs is parcacigi)"
launch_runs synth_1 -jobs $jobs
wait_on_run synth_1
require_complete_run synth_1

open_run synth_1
report_utilization -file \
    [file join $synth_dir fpga_top_utilization_synth.rpt]
close_design

set synth_run_dir [get_property DIRECTORY [get_runs synth_1]]
set synth_log [file join $synth_run_dir runme.log]
if {![file isfile $synth_log]} {
    error "Sentez calisma gunlugu bulunamadi: $synth_log"
}
file copy -force $synth_log [file join $synth_dir error_free_synthesis.log]

puts "==> Implementasyon ve bitstream baslatiliyor ($jobs is parcacigi)"
launch_runs impl_1 -to_step write_bitstream -jobs $jobs
wait_on_run impl_1
require_complete_run impl_1

open_run impl_1
report_utilization -file \
    [file join $impl_dir fpga_top_utilization_impl.rpt]
report_route_status -file \
    [file join $impl_dir fpga_top_route_status.rpt]
report_drc -file \
    [file join $impl_dir fpga_top_drc.rpt]
report_timing_summary -delay_type min_max -report_unconstrained -max_paths 100 \
    -file [file join $timing_dir timing_report.txt]
report_power -file \
    [file join $power_dir fpga_top_power.rpt]

set impl_run_dir [get_property DIRECTORY [get_runs impl_1]]
set impl_log [file join $impl_run_dir runme.log]
if {![file isfile $impl_log]} {
    error "Implementasyon calisma gunlugu bulunamadi: $impl_log"
}
file copy -force $impl_log [file join $impl_dir error_free_implementation.log]

set top_name [get_property TOP [get_filesets sources_1]]
set generated_bit [file join $impl_run_dir ${top_name}.bit]
if {![file isfile $generated_bit]} {
    error "Bitstream bulunamadi: $generated_bit"
}
file copy -force $generated_bit [file join $bit_dir fpga_top.bit]

puts "==> FPGA final build tamamlandi"
puts "    raporlar : $report_dir"
puts "    bitstream: [file join $bit_dir fpga_top.bit]"
close_project
if {[file exists $legacy_ip_output_dir]} {
    file delete -force $legacy_ip_output_dir
}
