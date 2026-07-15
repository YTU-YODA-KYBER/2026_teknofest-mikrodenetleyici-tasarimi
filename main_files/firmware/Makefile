# =====================================================================
#  CV32E40P SoC Firmware Makefile  (TEKNOFEST 2026)
#
#  Kaynak dosyalar:
#    main_boot.c          -> Boot ROM  (FLASHER + BOOT, SW0 ile dallanir)
#    main_app.c           -> Uygulama  (flash'a yazilir, INSTRRAM'e boot edilir;
#                             irq_init + trap_handler + YZ ISR'lari icerir)
#    circle.c             -> Eski LED demo (Boot ROM/INSTRRAM dogrulamasi icin)
#    flasher_echo_test.c  -> UART echo testi (Boot ROM'da kosar)
#
#  Hedefler:
#    make boot           -> build_boot/firmware.hex        (HW Boot ROM: erase ACIK)
#    make sim_boot       -> build_boot_sim/firmware.hex    (SIM: -DFLASHER_NO_ERASE)
#    make app            -> build_app/firmware.hex + app.bin        (main_app, HW)
#    make sim_app        -> build_app_sim/firmware.hex              (main_app, SIM)
#    make circle         -> build_circle/firmware.hex + circle.bin  (circle, HW)
#    make flash_vmf     -> build_app/mem_Q512.vmf         (Micron sim modeli icin)
#    make sim_flash_vmf -> build_app_sim/mem_Q512.vmf
#    make echo          -> build_echo/firmware.hex        (UART echo testi)
#    make size          -> boyut raporu (main_boot + main_app)
#    make clean         -> uretilen dizinleri sil
#
#  Cikti dosyalari ne ise yarar:
#    build_boot/firmware.hex    -> Boot ROM'a $readmemh (bitstream INIT / TB)
#    build_app/firmware.hex     -> main_app hex (hex2vmf girdisi + sim kisayolu)
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

# --- INSTRRAM'in linkteki gercek adresi. $readmemh ile yuklenen BRAM
#     dizisi 0-tabanli oldugu icin verilog hex uretilirken bu miktar
#     cikarilir (rebase), yoksa xsim "Out of bounds address" verip
#     yuklemeyi tamamen iptal eder / donanimda BRAM bos kalir. ---
APP_BASE  = 0x10000000

# =====================================================================
#  Kaynak / linker / dizin tanimlari
# =====================================================================
BOOT_SRCS = boot.S main_boot.c
BOOT_LD   = linker.ld                 # Boot ROM (0x00000000)
BOOT_DIR      = build_boot
BOOT_SIM_DIR  = build_boot_sim

APP_SRCS  = boot.S main_app.c
APP_LD    = linker_app.ld             # INSTRRAM (0x10000000)
APP_DIR      = build_app
APP_SIM_DIR  = build_app_sim

CIRCLE_SRCS = boot.S circle.c
CIRCLE_LD   = linker_app.ld             # INSTRRAM (0x10000000)
CIRCLE_DIR  = build_circle

ECHO_SRCS = boot.S flasher_echo_test.c
ECHO_LD   = linker.ld                 # Boot ROM (0x00000000)
ECHO_DIR  = build_echo

.PHONY: all boot sim_boot app sim_app circle echo flash_vmf sim_flash_vmf \
        size disasm_boot disasm_app clean

all: boot app

# =====================================================================
#  BOOT  (Boot ROM: flasher + boot)
# =====================================================================
# --- HW: erase ACIK (gercek flash silinmeli) ---
boot: $(BOOT_DIR)/firmware.hex
$(BOOT_DIR):
	mkdir -p $@
$(BOOT_DIR)/main_boot.elf: $(BOOT_SRCS) $(BOOT_LD) | $(BOOT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(BOOT_LD) $(BOOT_SRCS) -o $@
$(BOOT_DIR)/firmware.hex: $(BOOT_DIR)/main_boot.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (HW Boot ROM, erase ACIK)"
	@$(SIZE) $<

# --- SIM: erase KAPALI (-DFLASHER_NO_ERASE) ---
sim_boot: EXTRA_FLAGS = -DFLASHER_NO_ERASE
sim_boot: $(BOOT_SIM_DIR)/firmware.hex
$(BOOT_SIM_DIR):
	mkdir -p $@
$(BOOT_SIM_DIR)/main_boot.elf: $(BOOT_SRCS) $(BOOT_LD) | $(BOOT_SIM_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(BOOT_LD) $(BOOT_SRCS) -o $@
$(BOOT_SIM_DIR)/firmware.hex: $(BOOT_SIM_DIR)/main_boot.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (SIM Boot ROM, erase KAPALI)"
	@$(SIZE) $<

# =====================================================================
#  APP  (main_app -> INSTRRAM'e boot edilecek asil uygulama)
# =====================================================================
# --- HW: firmware.hex (hex2vmf girdisi) + app.bin (harici programlayici) ---
app: $(APP_DIR)/firmware.hex $(APP_DIR)/app.bin
$(APP_DIR):
	mkdir -p $@
$(APP_DIR)/app.elf: $(APP_SRCS) $(APP_LD) | $(APP_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(APP_LD) $(APP_SRCS) -o $@
$(APP_DIR)/firmware.hex: $(APP_DIR)/app.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 --change-addresses -$(APP_BASE) $< $@
	@echo "[OK] $@   (main_app hex, INSTRRAM-rebased @0)"
	@$(SIZE) $<
$(APP_DIR)/app.bin: $(APP_DIR)/app.elf
	$(OBJCOPY) -O binary $< $@
	@echo "[OK] $@   (HW flash programlama)"

# --- SIM: -DSIMULATION (gerekirse main_app.c icinde sim kisaltmalari icin) ---
sim_app: EXTRA_FLAGS = -DSIMULATION
sim_app: $(APP_SIM_DIR)/firmware.hex
$(APP_SIM_DIR):
	mkdir -p $@
$(APP_SIM_DIR)/app.elf: $(APP_SRCS) $(APP_LD) | $(APP_SIM_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(APP_LD) $(APP_SRCS) -o $@
$(APP_SIM_DIR)/firmware.hex: $(APP_SIM_DIR)/app.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 --change-addresses -$(APP_BASE) $< $@
	@echo "[OK] $@   (main_app hex, SIM, INSTRRAM-rebased @0)"
	@$(SIZE) $<

# =====================================================================
#  CIRCLE  (eski LED demosu, Boot ROM/INSTRRAM dogrulamasi icin)
# =====================================================================
circle: $(CIRCLE_DIR)/firmware.hex $(CIRCLE_DIR)/circle.bin
$(CIRCLE_DIR):
	mkdir -p $@
$(CIRCLE_DIR)/circle.elf: $(CIRCLE_SRCS) $(CIRCLE_LD) | $(CIRCLE_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(CIRCLE_LD) $(CIRCLE_SRCS) -o $@
$(CIRCLE_DIR)/firmware.hex: $(CIRCLE_DIR)/circle.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 --change-addresses -$(APP_BASE) $< $@
	@echo "[OK] $@   (circle app hex, INSTRRAM-rebased @0)"
	@$(SIZE) $<
$(CIRCLE_DIR)/circle.bin: $(CIRCLE_DIR)/circle.elf
	$(OBJCOPY) -O binary $< $@
	@echo "[OK] $@   (HW flash programlama)"

# =====================================================================
#  FLASH VMF  (main_app hex -> Micron sim modeli mem_Q512.vmf)
#    FLASH_OFF, main_boot.c'deki FLASH_ADDR ile AYNI olmali.
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
disasm_boot: $(BOOT_DIR)/main_boot.elf
	$(OBJDUMP) -d -S $<
disasm_app: $(APP_DIR)/app.elf
	$(OBJDUMP) -d -S $<

size: $(BOOT_DIR)/main_boot.elf $(APP_DIR)/app.elf
	@echo "==================================================="
	@echo " main_boot.c  (Boot ROM  - linker.ld, 1KB'ye sigmali)"
	@echo "==================================================="
	@$(SIZE) $(BOOT_DIR)/main_boot.elf
	@echo ""
	@echo "==================================================="
	@echo " main_app.c   (INSTRRAM app - linker_app.ld, max 8KB)"
	@echo "==================================================="
	@$(SIZE) $(APP_DIR)/app.elf

clean:
	rm -rf $(BOOT_DIR) $(BOOT_SIM_DIR) $(APP_DIR) $(APP_SIM_DIR) $(CIRCLE_DIR) $(ECHO_DIR)
	@echo "[OK] Temizlendi"
