# =====================================================================
#  yz_bench_test.tcl  --  Hizlandirici / yazilim gerceklemesi hiz kiyasi
#
#  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
#
#  ONCE FIRMWARE:
#      cd firmware && make sim_bench     # simulasyon icin (gomulu girdi)
#      cd firmware && make bench         # kart icin (UART'tan ses alir)
#
#  SIMULASYON (Madde A - hizlanma):
#      Vivado Tcl Console'da bu scripti source et, sonra "Run Simulation".
#      yz_bench_test.sv, sim_bench.hex'i Boot ROM'a yukler.
#      Beklenen sure: ~5 M cevrim, xsim'de birkac dakika.
#
#  BITSTREAM (Madde B - kart uzerinde dogruluk):
#      Ayni proje sentezlenir; fpga_top'un INIT_FILE_boot generic'i
#      asagida bench.hex'e cekilir, boyle olunca boot.hex uzerine
#      YAZILMAZ.
#
#  ANA PROJEYE ETKISI YOK
#  ----------------------
#  Bench, 32KB Boot ROM + 32KB Data RAM ister (yazilim gerceklemesinin
#  16KB'lik FC agirligi .rodata'da durur). Bu ihtiyac paylasilan RTL'e
#  YAZILMAZ; Top_module.sv sartnamedeki 1KB/8KB degerlerinde kalir ve
#  parametreler yalnizca burada (sentez) ve yz_bench_test.sv'de (sim)
#  ezilir. Firmware tarafinda da ayri bir script vardir:
#  firmware/linker_bench.ld. Yani bu senaryo istenildigi kadar tekrar
#  kosturulabilir, ana proje hic etkilenmez.
#
#  NOT: Bu proje UART/DMA/AXI yolunu dogrulamaz (ai_accel_test.tcl'in
#  isi). Burada olculen sey cikarim suresidir.
# =====================================================================

create_project -force yz_bench_test ./Vivado_projects/yz_bench_test -part xc7a100tcsg324-1

# Butun RTL
add_files ./main_codes/rtl/ -fileset sources_1
add_files ./main_codes/testbench/System_Test/yz_bench_test.sv -fileset sim_1
add_files ./firmware/sound_samples/ -fileset sim_1

# Verilog Header yolu
set_property include_dirs ./main_codes/rtl/include [get_filesets sources_1]

# Constraint
add_files -fileset constrs_1 ./main_codes/constraint/nexys_a7_soc.xdc

# Clocking Wizard IP
add_files ./main_codes/ip/clk_wiz_0/clk_wiz_0.xci

# --- Firmware bellek dosyalari ---
#  sim_bench.hex : testbench INIT_FILE_boot("sim_bench.hex") ile ister
#  bench.hex     : sentezde fpga_top generic'i ile secilir
set fw_dir ./firmware/makefile_outputs
set fw_hex [list $fw_dir/sim_bench.hex $fw_dir/bench.hex]
add_files -fileset sources_1 $fw_hex
set_property file_type "Memory File" [get_files $fw_hex]

# --- Hizlandirici agirlik / bias ROM'lari ---
set yz_hex_dir ./main_codes/rtl/desgin_sources/AI_Accelerator
set yz_hex_files [list \
    $yz_hex_dir/weights_p8.hex     \
    $yz_hex_dir/fc_weights_p4.hex  \
    $yz_hex_dir/biases.hex         \
    $yz_hex_dir/fc_biases.hex      \
]

# --- Testbench'in YZ RAM'e yukledigi ses ornekleri ---
set sound_samples_dir ./firmware/sound_samples
set sound_samples [list \
    $sound_samples_dir/input_data_no.hex        \
    $sound_samples_dir/input_data_yes.hex       \
    $sound_samples_dir/input_data_sessizlik.hex \
]

add_files -fileset sources_1 $yz_hex_files
add_files -fileset sources_1 $sound_samples
set_property file_type "Memory File" [get_files $yz_hex_files]
set_property file_type "Memory File" [get_files $sound_samples]

set_property used_in_synthesis  true [get_files $yz_hex_files]
set_property used_in_simulation true [get_files $yz_hex_files]
set_property used_in_synthesis  false [get_files $sound_samples]
set_property used_in_simulation true  [get_files $sound_samples]

# Simulasyonda dogrudan top_module orneklenir; kart sarmalayicisi ve
# clock wizard devre disi.
set_property used_in_simulation false [get_files fpga_top.sv]
set_property used_in_simulation false [get_files clk_wiz_0.xci]

# Sentezde Boot ROM'a bench.hex gitsin (boot.hex'e dokunmadan).
#  Sentez ayarlari -- RTL'e HIC DOKUNULMADAN, sadece generic ile:
#    INIT_FILE_boot : Boot ROM'a bench.hex gitsin (boot.hex'e dokunmadan)
#    ADDR_WIDTH_*   : Boot ROM + Data RAM 32KB (2^13 kelime x 4 bayt)
#
#  Ana projenin varsayilanlari (1KB / 8KB) sartname sinirlaridir ve
#  Top_module.sv icinde oyle kalir; yalnizca bu senaryo onlari ezer.
#
#  String generic'te tirnak ZORUNLU; tirnaksiz yazilirsa Vivado degeri
#  sayi sanip sessizce bos birakir ve Boot ROM bos sentezlenir.
set_property generic {INIT_FILE_boot="bench.hex" ADDR_WIDTH_boot=13 ADDR_WIDTH_data=13} \
             [get_filesets sources_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property top yz_bench_test [get_filesets sim_1]
set_property top fpga_top      [get_filesets sources_1]

update_compile_order -fileset sim_1
