# Post-route RCX tabanli design-rule ECO.
#
# Nihai ayrintili rota uzerinden cikartilmis SPEF'ler okunur. Hazir OpenRAM
# makrolarinin Liberty dosyalarindaki 0,040 ns giris slew siniri izinli SKY130
# stdcell'leriyle fiziksel olarak karsilanamadigi icin global repair_design
# RSZ-0090 ile daha baslamadan durur. Bu adim bunun yerine nihai STA raporundan
# makroya bagli olmayan ihlal aglarini secer ve ayni resizer motorunu ag bazinda
# calistirir. Makro modeli, signoff esigi ve SDC degistirilmez.

source $::env(SCRIPTS_DIR)/openroad/common/io.tcl
source $::env(SCRIPTS_DIR)/openroad/common/resizer.tcl

read_current_odb
set_propagated_clock [all_clocks]
set_dont_touch_objects

foreach corner_name [lln::get_corner_names] {
    set matched 0
    for {set index 0} {$index < $::env(POSTROUTE_SPEF_COUNT)} {incr index} {
        lassign $::env(POSTROUTE_SPEF_$index) corner_pattern spef_path
        if {[string match $corner_pattern $corner_name]} {
            puts "Post-route ECO: $corner_name <- $spef_path"
            read_spef -corner $corner_name $spef_path
            set matched 1
            break
        }
    }
    if {!$matched} {
        puts stderr "Post-route ECO: '$corner_name' icin SPEF bulunamadi"
        exit 1
    }
}

puts "%OL_CREATE_REPORT postroute_eco_before.rpt"
report_check_types -max_slew -max_capacitance -max_fanout -violators
puts "%OL_END_REPORT"

# report_check_types makine-okunur cikti vermiyor. Ayni raporu gecici bir
# dosyaya yonlendirip yalniz VIOLATED satirlarinin ilk sutununu aliyoruz.
set candidate_report "$::env(STEP_DIR)/postroute_eco_candidates.rpt"
report_check_types -max_slew -max_capacitance -max_fanout -violators > $candidate_report

set report_fd [open $candidate_report r]
set report_text [read $report_fd]
close $report_fd

set candidate_objects [list]
foreach line [split $report_text "\n"] {
    if {[regexp {^\s*(\S+)\s+\S+\s+\S+\s+-\S+\s+\(VIOLATED\)\s*$} $line -> object_name]} {
        lappend candidate_objects $object_name
    }
}

# Nihai ODB FillInsertion sonrasidir. ECO hucrelerine yer acmak icin filler ve
# decap'ler kaldirilir; kuyruktaki FillInsertion bunlari yeniden ekleyecektir.
remove_fillers

# repair_net_cmd hangi surucu hucreleri yeniden boyutlandiracagini onceden
# bildirmez. Degisen hucrelerin tum pin aglarini daha sonra yeniden
# yollayabilmek icin baslangic master'larini kaydet.
set original_master_by_inst [dict create]
foreach db_inst [[ord::get_db_block] getInsts] {
    dict set original_master_by_inst [$db_inst getName] [[$db_inst getMaster] getName]
}

set candidate_nets [dict create]
set skipped_macro_objects 0
set unmapped_objects 0
foreach object_name $candidate_objects {
    # Hazir SRAM pinlerine giden aglar repair_net'in ayni RSZ-0090 denetimini
    # tetikler. Bu pinlerin kendisini ve makroya temas eden tum aglari disarida
    # birakmak signoff'u gizlemez: nihai STA bunlari aynen raporlamaya devam eder.
    if {[string match "*u_sram/*" $object_name]} {
        incr skipped_macro_objects
        continue
    }

    # OpenSTA koleksiyon kaliplari bus koseli parantezlerini glob sayar.
    regsub -all {\[} $object_name {\\[} object_pattern
    regsub -all {\]} $object_pattern {\\]} object_pattern
    set object [get_pins -quiet $object_pattern]
    if {[llength $object] == 0} {
        # Top-level port ihlalleri ayni agdaki surucu pininde de raporlanir.
        # Bu OpenSTA surumu get_nets -of_objects Port islemini desteklemiyor.
        incr unmapped_objects
        continue
    }
    set nets [get_nets -quiet -of_objects $object]
    foreach net $nets {
        dict set candidate_nets [get_full_name $net] 1
    }
}

set repaired_nets 0
set skipped_macro_nets 0
set failed_nets 0
set cleared_route_nets 0
foreach net_name [dict keys $candidate_nets] {
    regsub -all {\[} $net_name {\\[} net_pattern
    regsub -all {\]} $net_pattern {\\]} net_pattern
    set net [get_nets -quiet $net_pattern]
    if {[llength $net] == 0} {
        incr failed_nets
        continue
    }

    set touches_macro 0
    foreach pin [get_pins -quiet -of_objects $net] {
        if {[string match "*u_sram/*" [get_full_name $pin]]} {
            set touches_macro 1
            break
        }
    }
    if {$touches_macro} {
        incr skipped_macro_nets
        continue
    }

    # max_wire_length=0; sadece mevcut slew/cap/fanout limitleri uygulanir.
    # Her ag ayri cagrildigi icin alakasiz 0,040 ns makro pinleri global
    # on-kontrolu durduramaz.
    if {[catch {rsz::repair_net_cmd $net 0 0 0} repair_error]} {
        puts stderr "Post-route ECO: '$net_name' onarilamadi: $repair_error"
        incr failed_nets
    } else {
        incr repaired_nets
    }

    # Boyutu degisen hucrenin eski pin geometrisine giden ayrintili rota,
    # DRT'de baglantisiz kalabilir. Yalniz hedef agin normal dbWire'ini
    # kaldir; PDN/special-wire geometrisine dokunma. Sonraki GRT+DRT bu agi
    # yeni pin konumuna bastan baglar.
    set db_net [[ord::get_db_block] findNet $net_name]
    if {$db_net != "NULL"} {
        set db_wire [$db_net getWire]
        if {$db_wire != "NULL"} {
            odb::dbWire_destroy $db_wire
            incr cleared_route_nets
        }
    }
}

# Yeniden boyutlanan bir hucrenin yalniz ihlalli cikis agi degil, giris
# pinleri de geometrik olarak yer degistirebilir. Bu hucrelere temas eden
# kalan normal rotalari da temizle; aksi halde DRT eski pine ulasan parcayi
# baglantisiz sayar. Ayni ag ikinci kez gorulurse getWire NULL doner.
set resized_instances 0
set resized_incident_routes 0
foreach db_inst [[ord::get_db_block] getInsts] {
    set inst_name [$db_inst getName]
    if {![dict exists $original_master_by_inst $inst_name]} {
        continue
    }
    set old_master [dict get $original_master_by_inst $inst_name]
    set new_master [[$db_inst getMaster] getName]
    if {$old_master eq $new_master} {
        continue
    }
    incr resized_instances
    foreach db_iterm [$db_inst getITerms] {
        set db_net [$db_iterm getNet]
        if {$db_net == "NULL"} {
            continue
        }
        set db_wire [$db_net getWire]
        if {$db_wire != "NULL"} {
            odb::dbWire_destroy $db_wire
            incr resized_incident_routes
        }
    }
}

puts "Post-route ECO: [llength $candidate_objects] ihlal nesnesi, [dict size $candidate_nets] aday ag"
puts "Post-route ECO: $repaired_nets ag islendi; $skipped_macro_objects makro nesnesi ve $skipped_macro_nets makro agi atlandi; $unmapped_objects nesne eslenemedi; $failed_nets ag basarisiz"
puts "Post-route ECO: $cleared_route_nets hedef agin eski ayrintili rotasi temizlendi"
puts "Post-route ECO: $resized_instances hucre boyutlandi; bunlara temas eden ek $resized_incident_routes rota temizlendi"

# common/dpl.tcl once fill/decap hucrelerini kaldirir, sonra yalniz degisen
# standart hucreleri yasal satirlara yerlestirir.
source $::env(SCRIPTS_DIR)/openroad/common/dpl.tcl
unset_dont_touch_objects

source $::env(SCRIPTS_DIR)/openroad/common/set_rc.tcl
estimate_parasitics -placement

puts "%OL_CREATE_REPORT postroute_eco_after_placement.rpt"
report_check_types -max_slew -max_capacitance -max_fanout -violators
puts "%OL_END_REPORT"

write_metric_int "postroute_eco__candidate_object_count" [llength $candidate_objects]
write_metric_int "postroute_eco__candidate_net_count" [dict size $candidate_nets]
write_metric_int "postroute_eco__processed_net_count" $repaired_nets
write_metric_int "postroute_eco__skipped_macro_object_count" $skipped_macro_objects
write_metric_int "postroute_eco__skipped_macro_net_count" $skipped_macro_nets
write_metric_int "postroute_eco__unmapped_object_count" $unmapped_objects
write_metric_int "postroute_eco__failed_net_count" $failed_nets
write_metric_int "postroute_eco__cleared_route_net_count" $cleared_route_nets
write_metric_int "postroute_eco__resized_instance_count" $resized_instances
write_metric_int "postroute_eco__resized_incident_route_count" $resized_incident_routes
write_views
