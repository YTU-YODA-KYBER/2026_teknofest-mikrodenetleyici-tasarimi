# =====================================================================
#  CV32E40P SoC Firmware Makefile
#
#  Kullanim:
#    make             -> bootloader + uygulama (ikisi birden)
#    make boot        -> sadece bootloader  -> build_boot/firmware.hex
#    make app         -> sadece uygulama    -> build_app/firmware.hex + app.bin
#    make sim         -> bootloader sim     -> build_boot_sim/firmware.hex
#    make sim_app     -> uygulama sim       -> build_app_sim/firmware.hex + app.bin
#    make clean       -> uretilen dosyalari sil
#    make disasm_boot -> bootloader disassembly
#    make disasm_app  -> uygulama disassembly
#    make size        -> her iki binary icin boyut raporu
#
#  Cikti dosyalari:
#    build_boot/firmware.hex  -> $readmemh ile Boot ROM'a yuklenir
#    build_app/firmware.hex          -> $readmemh ile INSTRRAM'e dogrudan yuklenir
#    build_app/app.bin          -> QSPI flash'a yazilir (gercek donanim)
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

# --- Ortak derleme bayraklari ---
CFLAGS = -march=$(ARCH)     \
         -mabi=$(ABI)        \
         -O1                 \
         -g                  \
         -Wall               \
         -Wextra             \
         -nostdlib           \
         -ffreestanding      \
         -fno-builtin        \
         $(EXTRA_FLAGS)

# --- Ortak baglama bayraklari ---
LDFLAGS = -march=$(ARCH)    \
          -mabi=$(ABI)       \
          -nostdlib

# =====================================================================
# BOOTLOADER
#   Kaynak : boot.S + main.c (QSPI okuma + INSTRRAM yazma + jump)
#   Linker : linker.ld       (IMEM = 0x00000000, 1KB Boot ROM)
#   Cikti  : build_boot/firmware.hex  -> Boot ROM'a yuklenir
# =====================================================================
BOOT_SRCS = boot.S main.c
BOOT_LD   = linker.ld
BOOT_DIR  = build_boot
BOOT_ELF  = $(BOOT_DIR)/bootloader.elf
BOOT_HEX  = $(BOOT_DIR)/firmware.hex

# =====================================================================
# UYGULAMA
#   Kaynak : boot.S + app_main.c (Timer, UART, GPIO, I2C, QSPI testleri)
#   Linker : linker_app.ld        (IMEM = 0x10000000, 8KB INSTRRAM)
#   Cikti  : build_app/firmware.hex   -> INSTRRAM'e dogrudan yukleme (sim)
#            build_app/app.bin   -> QSPI flash'a yazma (gercek donanim)
# =====================================================================
APP_SRCS = boot.S app_main.c
APP_LD   = linker_app.ld
APP_DIR  = build_app
APP_ELF  = $(APP_DIR)/app.elf
APP_HEX  = $(APP_DIR)/firmware.hex
APP_BIN  = $(APP_DIR)/app.bin

# =====================================================================
# SIMULASYON DIZINLERI
# =====================================================================
SIM_BOOT_DIR = build_boot_sim
SIM_BOOT_ELF = $(SIM_BOOT_DIR)/bootloader.elf
SIM_BOOT_HEX = $(SIM_BOOT_DIR)/firmware.hex

SIM_APP_DIR  = build_app_sim
SIM_APP_ELF  = $(SIM_APP_DIR)/app.elf
SIM_APP_HEX  = $(SIM_APP_DIR)/firmware.hex
SIM_APP_BIN  = $(SIM_APP_DIR)/app.bin

# =====================================================================

.PHONY: all boot app sim sim_app clean disasm_boot disasm_app size

# Varsayilan hedef: ikisini birden derle
all: boot app

# -----------------------------------------------------------------
# BOOTLOADER derleme
# -----------------------------------------------------------------
boot: $(BOOT_HEX)

$(BOOT_DIR):
	mkdir -p $(BOOT_DIR)

$(BOOT_ELF): $(BOOT_SRCS) $(BOOT_LD) | $(BOOT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(BOOT_LD) $(BOOT_SRCS) -o $@

$(BOOT_HEX): $(BOOT_ELF)
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK]  $(BOOT_HEX)  ->  Boot ROM icin ($readmemh)"
	@$(SIZE) $<

# -----------------------------------------------------------------
# UYGULAMA derleme
# -----------------------------------------------------------------
app: $(APP_HEX) $(APP_BIN)

$(APP_DIR):
	mkdir -p $(APP_DIR)

$(APP_ELF): $(APP_SRCS) $(APP_LD) | $(APP_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(APP_LD) $(APP_SRCS) -o $@

$(APP_HEX): $(APP_ELF)
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK]  $(APP_HEX)   ->  INSTRRAM dogrudan yukleme (sim)"
	@$(SIZE) $<

$(APP_BIN): $(APP_ELF)
	$(OBJCOPY) -O binary $< $@
	@echo "[OK]  $(APP_BIN)   ->  QSPI flash programlama"

# -----------------------------------------------------------------
# SIMULASYON — bootloader  (-DSIMULATION aktif)
# -----------------------------------------------------------------
sim: EXTRA_FLAGS = -DSIMULATION
sim: $(SIM_BOOT_HEX)

$(SIM_BOOT_DIR):
	mkdir -p $(SIM_BOOT_DIR)

$(SIM_BOOT_ELF): $(BOOT_SRCS) $(BOOT_LD) | $(SIM_BOOT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(BOOT_LD) $(BOOT_SRCS) -o $@

$(SIM_BOOT_HEX): $(SIM_BOOT_ELF)
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK]  $(SIM_BOOT_HEX)  hazir"
	@$(SIZE) $<

# -----------------------------------------------------------------
# SIMULASYON — uygulama  (-DSIMULATION aktif)
# -----------------------------------------------------------------
sim_app: EXTRA_FLAGS = -DSIMULATION
sim_app: $(SIM_APP_HEX) $(SIM_APP_BIN)

$(SIM_APP_DIR):
	mkdir -p $(SIM_APP_DIR)

$(SIM_APP_ELF): $(APP_SRCS) $(APP_LD) | $(SIM_APP_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(APP_LD) $(APP_SRCS) -o $@

$(SIM_APP_HEX): $(SIM_APP_ELF)
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK]  $(SIM_APP_HEX)  hazir"
	@$(SIZE) $<

$(SIM_APP_BIN): $(SIM_APP_ELF)
	$(OBJCOPY) -O binary $< $@
	@echo "[OK]  $(SIM_APP_BIN)  hazir"

# -----------------------------------------------------------------
# YARDIMCI HEDEFLER
# -----------------------------------------------------------------
disasm_boot: $(BOOT_ELF)
	$(OBJDUMP) -d -S $<

disasm_app: $(APP_ELF)
	$(OBJDUMP) -d -S $<

size: $(BOOT_ELF) $(APP_ELF)
	@echo "========================================="
	@echo " Bootloader  (Boot ROM, max 1KB)"
	@echo "========================================="
	@$(SIZE) $(BOOT_ELF)
	@echo ""
	@echo "========================================="
	@echo " Uygulama    (INSTRRAM, max 8KB)"
	@echo "========================================="
	@$(SIZE) $(APP_ELF)
	@echo ""
	@echo "--- Semboller: Bootloader ---"
	@$(NM) $(BOOT_ELF) | sort
	@echo ""
	@echo "--- Semboller: Uygulama ---"
	@$(NM) $(APP_ELF) | sort

clean:
	rm -rf $(BOOT_DIR) $(APP_DIR) $(SIM_BOOT_DIR) $(SIM_APP_DIR)
	@echo "[OK] Temizlendi"

# =====================================================================
# CIRCLE LED DEMO  (DTR deneyi - BootROM'a gomulu tek binary)
#   Kaynak : boot.S + circle.c
#   Linker : linker.ld   (IMEM = 0x00000000, 1KB Boot ROM)
#   Cikti  : build_circle/firmware.hex  -> Boot ROM'a $readmemh ile yuklenir
# =====================================================================
CIRCLE_SRCS = boot.S circle.c
CIRCLE_LD   = linker.ld
CIRCLE_DIR  = build_circle
CIRCLE_ELF  = $(CIRCLE_DIR)/circle.elf
CIRCLE_HEX  = $(CIRCLE_DIR)/firmware.hex

.PHONY: circle disasm_circle

circle: $(CIRCLE_HEX)

$(CIRCLE_DIR):
	mkdir -p $(CIRCLE_DIR)

$(CIRCLE_ELF): $(CIRCLE_SRCS) $(CIRCLE_LD) | $(CIRCLE_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(CIRCLE_LD) $(CIRCLE_SRCS) -o $@

$(CIRCLE_HEX): $(CIRCLE_ELF)
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK]  $(CIRCLE_HEX)  ->  Boot ROM ($$readmemh)"
	@$(SIZE) $<

disasm_circle: $(CIRCLE_ELF)
	$(OBJDUMP) -d -S $<

# =====================================================================
# CIRCLE SIM  (testbench icin: -DSIMULATION -> LOOPS_PER_MS = 5)
#   Cikti: build_circle_sim/firmware.hex  -> tb_top.sv $readmemh'e ver
# =====================================================================
CIRCLE_SIM_DIR = build_circle_sim
CIRCLE_SIM_ELF = $(CIRCLE_SIM_DIR)/circle.elf
CIRCLE_SIM_HEX = $(CIRCLE_SIM_DIR)/firmware.hex

.PHONY: sim_circle

sim_circle: EXTRA_FLAGS = -DSIMULATION
sim_circle: $(CIRCLE_SIM_HEX)

$(CIRCLE_SIM_DIR):
	mkdir -p $(CIRCLE_SIM_DIR)

$(CIRCLE_SIM_ELF): $(CIRCLE_SRCS) $(CIRCLE_LD) | $(CIRCLE_SIM_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(CIRCLE_LD) $(CIRCLE_SRCS) -o $@

$(CIRCLE_SIM_HEX): $(CIRCLE_SIM_ELF)
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK]  $(CIRCLE_SIM_HEX)  ->  testbench BootROM'una ver"
	@$(SIZE) $<


# QSPI flash yazma/okuma testi (BootROM'a gomulu tek binary)
QTEST_SRCS = boot.S qspi_flash_test.c
QTEST_LD   = linker.ld
QTEST_DIR  = build_qspi_test
QTEST_ELF  = $(QTEST_DIR)/qspi_flash_test.elf
QTEST_HEX  = $(QTEST_DIR)/firmware.hex

.PHONY: qspi_test
qspi_test: $(QTEST_HEX)
$(QTEST_DIR):
	mkdir -p $(QTEST_DIR)
$(QTEST_ELF): $(QTEST_SRCS) $(QTEST_LD) | $(QTEST_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(QTEST_LD) $(QTEST_SRCS) -o $@
$(QTEST_HEX): $(QTEST_ELF)
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@$(SIZE) $<
