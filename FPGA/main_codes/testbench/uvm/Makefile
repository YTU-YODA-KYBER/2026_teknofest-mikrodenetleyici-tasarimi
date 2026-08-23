#==============================================================================
#  Makefile  --  UVM dogrulama ortami (Verilator)
#
#  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi
#
#  Kullanim:
#     source /usr/Verilator_uvm/env.sh
#     make smoke                       adim 0 kapi testleri
#     make build BLK=gpio              tek blogu derle
#     make run   BLK=gpio TEST=gpio_reset_test SEED=1
#     make gpio                        derle + varsayilan testi kostur
#     make regression                  butun bloklar x butun testler x tohumlar
#     make coverage                    kapsam raporunu uret (genhtml)
#     make clean
#
#  NOT: butun derleme ciktilari OBJ_ROOT altina gider. /home bolumunde
#  yalnizca birkac GB bos oldugu icin obj_dir'ler DEPOYA veya /home'a
#  yazilmaz.
#==============================================================================

UVM_HOME  ?= /usr/Verilator_uvm/uvm
OBJ_ROOT  ?= /usr/Verilator_uvm/build
J         ?= $(shell nproc)
SEED      ?= 1

ROOT      := $(abspath $(CURDIR)/../../..)
RTL       := $(ROOT)/main_codes/rtl/desgin_sources
CHK       := $(ROOT)/main_codes/testbench/AXI_protocol_check
UVMDIR    := $(ROOT)/main_codes/testbench/uvm
COMMON    := $(UVMDIR)/common
AGENTS    := $(UVMDIR)/agents
STUBS     := $(UVMDIR)/verilator/stubs

UVM_SRC   := $(UVM_HOME)/uvm_pkg_all_v2020_3_1_nodpi.svh

#------------------------------------------------------------------------------
#  Verilator bayraklari
#
#  DIKKAT -- --coverage KULLANILMAZ, ihtiyac duyulan alt bayraklar tek tek
#  verilir. Verilator 5.050'de iki alt metrik ic hata uretiyor:
#
#    --coverage-expr : 'bind' edilmis bir modulun assert action block'uyla
#                      birleşince ->  V3Localize.cpp:203: AstVarRef not
#                      under function
#    --coverage-fsm  : "always @(posedge clk) if (!rst_n) <tek deyim>"
#                      kalibinda    ->  V3FsmDetect.cpp:1065: Empty reset
#                      branch unexpectedly survived to FSM detection
#
#  Kullandigimiz uc metrik (line / toggle / user) sorunsuz calisiyor ve
#  ihtiyacimiz olan hepsi bu. Ayrintisi verification/uvm/README.md'de.
#------------------------------------------------------------------------------
VFLAGS := --binary -j $(J) --timing --assert \
          --coverage-line --coverage-toggle --coverage-user \
          -Wno-fatal --error-limit 10000 \
          --x-assign unique --x-initial unique

INCS := +incdir+$(UVM_HOME) \
        +incdir+$(CHK) \
        +incdir+$(CHK)/Bind_for_peripherals \
        +incdir+$(COMMON) \
        +incdir+$(AGENTS)

COMMON_SRC := $(CHK)/axi_chk_pkg.sv \
              $(CHK)/axi4lite_protocol_checker.sv \
              $(COMMON)/axil_if.sv \
              $(COMMON)/axil_pkg.sv

#------------------------------------------------------------------------------
#  Blok tanimlari
#------------------------------------------------------------------------------
BLOCKS := gpio timer uart_gu uart_yz i2c qspi yz_csr

# gpio
gpio_TOP  := tb_gpio
gpio_SRC  := $(RTL)/Peripherals/GPIO/GPIO_AXI4_Lite.sv \
             $(AGENTS)/gpio_pad_if.sv \
             $(AGENTS)/gpio_pad_pkg.sv \
             $(UVMDIR)/gpio/gpio_uvm_pkg.sv \
             $(UVMDIR)/gpio/tb_gpio.sv
gpio_INC  := +incdir+$(UVMDIR)/gpio
gpio_TESTS := gpio_reset_test gpio_bitwalk_test gpio_ro_test \
              gpio_unmapped_test gpio_random_test gpio_reset_mid_test \
              gpio_pad_test gpio_display_test gpio_stress_test
gpio_DEFAULT := gpio_reset_test

# timer
timer_TOP  := tb_timer
timer_SRC  := $(RTL)/Peripherals/Timer/Timer_AXI4_Lite.sv \
              $(UVMDIR)/timer/timer_uvm_pkg.sv \
              $(UVMDIR)/timer/tb_timer.sv
timer_INC  := +incdir+$(UVMDIR)/timer
timer_TESTS := timer_reset_test timer_bitwalk_test timer_ro_test \
               timer_unmapped_test timer_random_test timer_reset_mid_test \
               timer_count_test timer_event_test timer_stress_test
timer_DEFAULT := timer_reset_test

# uart_gu
uart_gu_TOP  := tb_uart_gu
uart_gu_SRC  := $(RTL)/Peripherals/UART_GU/UART_GU_AXI4-Lite.sv \
                $(AGENTS)/uart_if.sv \
                $(AGENTS)/uart_pkg.sv \
                $(UVMDIR)/uart/uart_uvm_pkg.sv \
                $(UVMDIR)/uart_gu/uart_gu_uvm_pkg.sv \
                $(UVMDIR)/uart_gu/tb_uart_gu.sv
uart_gu_INC  := +incdir+$(UVMDIR)/uart +incdir+$(UVMDIR)/uart_gu
uart_gu_TESTS := uart_gu_reset_test uart_gu_bitwalk_test uart_gu_ro_test \
                 uart_gu_unmapped_test uart_gu_random_test \
                 uart_gu_reset_mid_test uart_gu_tx_test uart_gu_rx_test \
                 uart_gu_baud_test uart_gu_duplex_test \
                 uart_gu_cpb_zero_test uart_gu_stress_test
uart_gu_DEFAULT := uart_gu_reset_test

# uart_yz
uart_yz_TOP  := tb_uart_yz
uart_yz_SRC  := $(RTL)/Peripherals/UART_YZ/UART_YZ_AXI4-Lite.sv \
                $(AGENTS)/uart_if.sv \
                $(AGENTS)/uart_pkg.sv \
                $(UVMDIR)/uart/uart_uvm_pkg.sv \
                $(UVMDIR)/uart_yz/uart_yz_uvm_pkg.sv \
                $(UVMDIR)/uart_yz/tb_uart_yz.sv
uart_yz_INC  := +incdir+$(UVMDIR)/uart +incdir+$(UVMDIR)/uart_yz
uart_yz_TESTS := uart_yz_reset_test uart_yz_bitwalk_test uart_yz_ro_test \
                 uart_yz_unmapped_test uart_yz_random_test \
                 uart_yz_reset_mid_test uart_yz_tx_test uart_yz_rx_test \
                 uart_yz_baud_test uart_yz_duplex_test \
                 uart_yz_cpb_zero_test uart_yz_dma_test uart_yz_stress_test
uart_yz_DEFAULT := uart_yz_reset_test

# yz_csr  (YZ hizlandiricinin CPU'ya bakan AXI4-Lite arayuzu)
yz_csr_TOP  := tb_yz_csr
yz_csr_SRC  := $(RTL)/AI_Accelerator/yz_csr_wrapper.sv \
               $(AGENTS)/yz_accel_if.sv \
               $(AGENTS)/yz_accel_pkg.sv \
               $(UVMDIR)/yz_csr/yz_uvm_pkg.sv \
               $(UVMDIR)/yz_csr/tb_yz_csr.sv
yz_csr_INC  := +incdir+$(UVMDIR)/yz_csr
yz_csr_TESTS := yz_reset_test yz_ro_test yz_unmapped_test yz_random_test \
                yz_reset_mid_test yz_csr_test yz_stress_test
yz_csr_DEFAULT := yz_reset_test

# i2c   (Xilinx IOBUF primitifi icin stub gerekir)
i2c_TOP  := tb_i2c
i2c_SRC  := $(STUBS)/IOBUF.sv \
            $(RTL)/Peripherals/I2C/I2C_Master_AXI4_Lite.sv \
            $(AGENTS)/i2c_if.sv \
            $(AGENTS)/i2c_slave_pkg.sv \
            $(UVMDIR)/i2c/i2c_uvm_pkg.sv \
            $(UVMDIR)/i2c/tb_i2c.sv
i2c_INC  := +incdir+$(UVMDIR)/i2c
i2c_TESTS := i2c_reset_test i2c_bitwalk_test i2c_ro_test i2c_unmapped_test \
             i2c_random_test i2c_reset_mid_test i2c_nby_test \
             i2c_write_test i2c_read_test i2c_nack_test i2c_flags_test \
             i2c_stress_test
i2c_DEFAULT := i2c_reset_test

# qspi  (Xilinx IOBUF primitifi icin stub gerekir)
qspi_TOP  := tb_qspi
qspi_SRC  := $(STUBS)/IOBUF.sv \
             $(RTL)/Peripherals/QSPI/QSPI_Master_AXI4_Lite.sv \
             $(AGENTS)/qspi_if.sv \
             $(AGENTS)/qspi_flash_pkg.sv \
             $(UVMDIR)/qspi/qspi_uvm_pkg.sv \
             $(UVMDIR)/qspi/tb_qspi.sv
qspi_INC  := +incdir+$(UVMDIR)/qspi
qspi_TESTS := qspi_reset_test qspi_bitwalk_test qspi_ro_test \
              qspi_unmapped_test qspi_random_test qspi_reset_mid_test \
              qspi_fifo_test qspi_dma_test qspi_flash_test qspi_modes_test \
              qspi_stress_test
qspi_DEFAULT := qspi_reset_test

#------------------------------------------------------------------------------
BLK   ?= gpio
TEST  ?= $($(BLK)_DEFAULT)
BDIR   = $(OBJ_ROOT)/$(BLK)

.PHONY: all smoke build run clean regression coverage $(BLOCKS)

all: $(BLK)

$(BLOCKS):
	$(MAKE) build BLK=$@
	$(MAKE) run   BLK=$@ TEST=$($@_DEFAULT) SEED=$(SEED)

build:
	@mkdir -p $(BDIR)
	@verilator $(VFLAGS) --top-module $($(BLK)_TOP) \
	    --Mdir $(BDIR)/obj_dir -o $($(BLK)_TOP) \
	    $(INCS) $($(BLK)_INC) \
	    $(UVM_SRC) $(COMMON_SRC) $($(BLK)_SRC) \
	    > $(BDIR)/verilate.log 2>&1 || \
	    { echo "[UVM] $(BLK) DERLENMEDI:"; \
	      grep -E "^%Error" $(BDIR)/verilate.log | head -20; exit 1; }
	@grep -qE "^%Error" $(BDIR)/verilate.log && \
	    { echo "[UVM] $(BLK) DERLENMEDI:"; \
	      grep -E "^%Error" $(BDIR)/verilate.log | head -20; exit 1; } || true
	@echo "[UVM] $(BLK) derlendi -> $(BDIR)/obj_dir/$($(BLK)_TOP)"

run:
	@mkdir -p $(BDIR)/logs
	@cd $(BDIR) && ./obj_dir/$($(BLK)_TOP) \
	    +UVM_TESTNAME=$(TEST) \
	    +verilator+seed+$(SEED) \
	    +verilator+coverage+file+$(BDIR)/logs/$(TEST)_seed$(SEED).dat \
	    2>&1 | tee $(BDIR)/logs/$(TEST)_seed$(SEED).log
	@echo "[UVM] $(BLK)/$(TEST) seed=$(SEED) bitti"

smoke:
	@bash $(UVMDIR)/verilator/run_smoke.sh

regression:
	@python3 $(UVMDIR)/verilator/run_regression.py

coverage:
	@python3 $(UVMDIR)/verilator/make_coverage.py

clean:
	rm -rf $(OBJ_ROOT)/gpio $(OBJ_ROOT)/timer $(OBJ_ROOT)/uart_gu \
	       $(OBJ_ROOT)/uart_yz $(OBJ_ROOT)/i2c $(OBJ_ROOT)/qspi \
	       $(OBJ_ROOT)/yz_csr $(OBJ_ROOT)/smoke*
