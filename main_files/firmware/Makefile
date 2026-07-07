# =====================================================================
#  CV32E40P SoC Firmware Makefile  (TEKNOFEST 2026)
#
#  Kaynak dosyalar:
#    main.c              -> Boot ROM  (FLASHER + BOOT, SW0 ile dallanir)
#    circle.c            -> Uygulama  (flash'a yazilir, INSTRRAM'e boot edilir)
#    flasher_echo_test.c -> UART echo testi (Boot ROM'da kosar)
#
#  Hedefler:
#    make main          -> build_main/firmware.hex        (HW Boot ROM: erase ACIK)
#    make sim_main      -> build_main_sim/firmware.hex    (SIM: -DFLASHER_NO_ERASE)
#    make app           -> build_app/firmware.hex + app.bin        (circle, HW)
#    make sim_app       -> build_app_sim/firmware.hex              (circle, SIM)
#    make flash_vmf     -> build_app/mem_Q512.vmf         (Micron sim modeli icin)
#    make sim_flash_vmf -> build_app_sim/mem_Q512.vmf
#    make echo          -> build_echo/firmware.hex        (UART echo testi)
#    make size          -> boyut raporu (main + circle)
#    make clean         -> uretilen dizinleri sil
#
#  Cikti dosyalari ne ise yarar:
#    build_main/firmware.hex    -> Boot ROM'a $readmemh (bitstream INIT / TB)
#    build_app/firmware.hex     -> circle app hex (hex2vmf girdisi + sim kisayolu)
#    build_app/app.bin          -> HW'de flash'a harici programlayici ile yazma
#    build_app/mem_Q512.vmf     -> SIM'de Micron flash modeline (boot testi)
# =====================================================================

# --- Toolchain ---
PREFIX  = riscv32-unknown-elf
CC      = $(PREFIX)-gcc
OBJCOPY = $(PREFIX)-objcopy
OBJDUMP = $(PREFIX)-objdump
NM      = $(PREFIX)-nm
SIZE    = $(PREFIX)-size

# --- Mimari ---
ARCH = rv32imc_zicsr_zifencei
ABI  = ilp32

# --- Derleme / baglama bayraklari ---
CFLAGS  = -march=$(ARCH) -mabi=$(ABI) -O1 -g -Wall -Wextra \
          -nostdlib -ffreestanding -fno-builtin $(EXTRA_FLAGS)
LDFLAGS = -march=$(ARCH) -mabi=$(ABI) -nostdlib

# --- vmf uretici ---
HEX2VMF   = hex2vmf.py
FLASH_OFF ?= 0

# =====================================================================
#  Kaynak / linker / dizin tanimlari
# =====================================================================
MAIN_SRCS = boot.S main.c
MAIN_LD   = linker.ld                 # Boot ROM (0x00000000)
MAIN_DIR      = build_main
MAIN_SIM_DIR  = build_main_sim

APP_SRCS  = boot.S circle.c
APP_LD    = linker_app.ld             # INSTRRAM (0x10000000)
APP_DIR      = build_app
APP_SIM_DIR  = build_app_sim

ECHO_SRCS = boot.S flasher_echo_test.c
ECHO_LD   = linker.ld                 # Boot ROM (0x00000000)
ECHO_DIR  = build_echo

.PHONY: all main sim_main app sim_app echo flash_vmf sim_flash_vmf \
        size disasm_main disasm_app clean

all: main app

# =====================================================================
#  MAIN  (Boot ROM: flasher + boot)
# =====================================================================
# --- HW: erase ACIK (gercek flash silinmeli) ---
main: $(MAIN_DIR)/firmware.hex
$(MAIN_DIR):
	mkdir -p $@
$(MAIN_DIR)/main.elf: $(MAIN_SRCS) $(MAIN_LD) | $(MAIN_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(MAIN_LD) $(MAIN_SRCS) -o $@
$(MAIN_DIR)/firmware.hex: $(MAIN_DIR)/main.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (HW Boot ROM, erase ACIK)"
	@$(SIZE) $<

# --- SIM: erase KAPALI (-DFLASHER_NO_ERASE) ---
sim_main: EXTRA_FLAGS = -DFLASHER_NO_ERASE
sim_main: $(MAIN_SIM_DIR)/firmware.hex
$(MAIN_SIM_DIR):
	mkdir -p $@
$(MAIN_SIM_DIR)/main.elf: $(MAIN_SRCS) $(MAIN_LD) | $(MAIN_SIM_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(MAIN_LD) $(MAIN_SRCS) -o $@
$(MAIN_SIM_DIR)/firmware.hex: $(MAIN_SIM_DIR)/main.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (SIM Boot ROM, erase KAPALI)"
	@$(SIZE) $<

# =====================================================================
#  APP  (circle -> INSTRRAM'e boot edilecek uygulama)
# =====================================================================
# --- HW: firmware.hex (hex2vmf girdisi) + app.bin (harici programlayici) ---
app: $(APP_DIR)/firmware.hex $(APP_DIR)/app.bin
$(APP_DIR):
	mkdir -p $@
$(APP_DIR)/app.elf: $(APP_SRCS) $(APP_LD) | $(APP_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(APP_LD) $(APP_SRCS) -o $@
$(APP_DIR)/firmware.hex: $(APP_DIR)/app.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (circle app hex)"
	@$(SIZE) $<
$(APP_DIR)/app.bin: $(APP_DIR)/app.elf
	$(OBJCOPY) -O binary $< $@
	@echo "[OK] $@   (HW flash programlama)"

# --- SIM: -DSIMULATION (circle.c'deki LOOPS_PER_MS kisalir) ---
sim_app: EXTRA_FLAGS = -DSIMULATION
sim_app: $(APP_SIM_DIR)/firmware.hex
$(APP_SIM_DIR):
	mkdir -p $@
$(APP_SIM_DIR)/app.elf: $(APP_SRCS) $(APP_LD) | $(APP_SIM_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(APP_LD) $(APP_SRCS) -o $@
$(APP_SIM_DIR)/firmware.hex: $(APP_SIM_DIR)/app.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (circle app hex, SIM)"
	@$(SIZE) $<

# =====================================================================
#  FLASH VMF  (circle app hex -> Micron sim modeli mem_Q512.vmf)
#    FLASH_OFF, main.c'deki FLASH_ADDR ile AYNI olmali.
# =====================================================================
flash_vmf: $(APP_DIR)/firmware.hex
	python3 $(HEX2VMF) $(APP_DIR)/firmware.hex $(APP_DIR)/mem_Q512.vmf $(FLASH_OFF)
sim_flash_vmf: $(APP_SIM_DIR)/firmware.hex
	python3 $(HEX2VMF) $(APP_SIM_DIR)/firmware.hex $(APP_SIM_DIR)/mem_Q512.vmf $(FLASH_OFF)

# =====================================================================
#  ECHO  (UART echo testi -> Boot ROM'da kosar)
# =====================================================================
echo: $(ECHO_DIR)/firmware.hex
$(ECHO_DIR):
	mkdir -p $@
$(ECHO_DIR)/echo.elf: $(ECHO_SRCS) $(ECHO_LD) | $(ECHO_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(ECHO_LD) $(ECHO_SRCS) -o $@
$(ECHO_DIR)/firmware.hex: $(ECHO_DIR)/echo.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (UART echo testi)"
	@$(SIZE) $<

# =====================================================================
#  YARDIMCI
# =====================================================================
disasm_main: $(MAIN_DIR)/main.elf
	$(OBJDUMP) -d -S $<
disasm_app: $(APP_DIR)/app.elf
	$(OBJDUMP) -d -S $<

size: $(MAIN_DIR)/main.elf $(APP_DIR)/app.elf
	@echo "==================================================="
	@echo " main.c    (Boot ROM  - linker.ld, 1KB'ye sigmali)"
	@echo "==================================================="
	@$(SIZE) $(MAIN_DIR)/main.elf
	@echo ""
	@echo "==================================================="
	@echo " circle.c  (INSTRRAM app - linker_app.ld, max 8KB)"
	@echo "==================================================="
	@$(SIZE) $(APP_DIR)/app.elf

clean:
	rm -rf $(MAIN_DIR) $(MAIN_SIM_DIR) $(APP_DIR) $(APP_SIM_DIR) $(ECHO_DIR)
	@echo "[OK] Temizlendi"
