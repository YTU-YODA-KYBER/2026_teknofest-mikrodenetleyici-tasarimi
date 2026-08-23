#!/bin/bash
#=============================================================================
#  run_smoke.sh  --  Adim 0 kapi testleri
#
#  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi
#
#  Yedi blogun ortami yazilmadan ONCE, simulatorun bu tasarimin ihtiyac
#  duydugu bes dil ozelligini gercekten kaldirdigini kanitlar:
#
#    Madde 1  UVM cekirdegi ayakta mi          (t_uvm_hello.sv)
#    Madde 2  bind calisiyor mu                (t_smoke_gpio.sv)
#    Madde 3  SVA calisiyor mu                 (t_smoke_gpio.sv)
#    Madde 4  covergroup calisiyor mu          (t_smoke_gpio.sv + kapsam ciktisi)
#    Madde 5  uvm_reg ayakta mi                (t_smoke_gpio.sv)
#
#  Kullanim:
#      source /usr/Verilator_uvm/env.sh
#      bash run_smoke.sh
#=============================================================================
set -u

UVMDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOT="$(cd "$UVMDIR/../../.." && pwd)"
RTL="$ROOT/main_codes/rtl/desgin_sources"
CHK="$ROOT/main_codes/testbench/AXI_protocol_check"
OBJ="${UVM_OBJ_ROOT:-/usr/Verilator_uvm/build}"
UVM_HOME="${UVM_HOME:-/usr/Verilator_uvm/uvm}"

VFLAGS="--binary -j $(nproc) --timing --assert
        --coverage-line --coverage-toggle --coverage-user
        -Wno-fatal --error-limit 10000"

INCS="+incdir+$UVM_HOME +incdir+$CHK +incdir+$CHK/Bind_for_peripherals
      +incdir+$UVMDIR/common +incdir+$UVMDIR/agents"

hata=0

echo "======================================================================"
echo "  ADIM 0 -- SMOKE KAPI TESTLERI"
echo "======================================================================"
verilator --version

#---- Madde 1: UVM cekirdegi ------------------------------------------------
D="$OBJ/smoke/hello"; rm -rf "$D"; mkdir -p "$D"
( cd "$D" && verilator $VFLAGS --top-module t_uvm_hello \
     $INCS $UVM_HOME/uvm_pkg_all_v2020_3_1_nodpi.svh \
     "$UVMDIR/smoke/t_uvm_hello.sv" -o t_uvm_hello > verilate.log 2>&1 )
if [ $? -ne 0 ]; then
    echo "  Madde 1 : KALDI (derlenmedi)"; grep -m5 "^%Error" "$D/verilate.log"; hata=1
else
    ( cd "$D" && ./obj_dir/t_uvm_hello > run.log 2>&1 )
    if grep -q "MADDE 1 GECTI" "$D/run.log"; then echo "  Madde 1 (UVM cekirdegi) : GECTI"
    else echo "  Madde 1 (UVM cekirdegi) : KALDI"; hata=1; fi
fi

#---- Madde 2,3,4,5: gercek GPIO RTL'i uzerinde -----------------------------
D="$OBJ/smoke/gpio"; rm -rf "$D"; mkdir -p "$D"
( cd "$D" && verilator $VFLAGS --top-module t_smoke_gpio \
     $INCS \
     $UVM_HOME/uvm_pkg_all_v2020_3_1_nodpi.svh \
     "$CHK/axi_chk_pkg.sv" "$CHK/axi4lite_protocol_checker.sv" \
     "$RTL/Peripherals/GPIO/GPIO_AXI4_Lite.sv" \
     "$UVMDIR/common/axil_if.sv" "$UVMDIR/common/axil_pkg.sv" \
     "$UVMDIR/smoke/t_smoke_gpio.sv" -o t_smoke_gpio > verilate.log 2>&1 )
if [ $? -ne 0 ]; then
    echo "  Madde 2-5 : KALDI (derlenmedi)"; grep -m5 "^%Error" "$D/verilate.log"; hata=1
else
    ( cd "$D" && ./obj_dir/t_smoke_gpio +verilator+coverage+file+"$D/coverage.dat" > run.log 2>&1 )
    grep -E "Madde [235]" "$D/run.log" | sed 's/^/  /'
    grep -qE "Madde 2 \(bind\)       : GECTI" "$D/run.log" || hata=1
    grep -qE "Madde 3 \(SVA\)        : GECTI" "$D/run.log" || hata=1
    grep -qE "Madde 5 \(uvm_reg\)    : GECTI" "$D/run.log" || hata=1

    # Madde 4: covergroup bin'leri kapsam ciktisinda gorunmeli
    n=$(grep -c "v_covergroup/" "$D/coverage.dat" 2>/dev/null || echo 0)
    if [ "$n" -gt 0 ]; then
        echo "  Madde 4 (covergroup)    : GECTI  ($n bin kapsam ciktisinda)"
    else
        echo "  Madde 4 (covergroup)    : KALDI  (kapsam ciktisinda bin yok)"; hata=1
    fi
fi

echo "======================================================================"
if [ $hata -eq 0 ]; then
    echo "  SONUC : 5/5 GECTI -- ortam kurulumu icin GO"
else
    echo "  SONUC : KALDI -- ayrinti icin $OBJ/smoke/*/run.log"
fi
echo "======================================================================"
exit $hata
