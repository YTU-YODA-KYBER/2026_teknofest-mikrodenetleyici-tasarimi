# =====================================================================
#  CV32E40P SoC Firmware Makefile
#  Kullanim:
#    make          -> normal derleme (build/firmware.hex)
#    make sim      -> simulasyon derlemesi (build_sim/firmware.hex,
#                     -DSIMULATION tanimlaniyor)
#    make clean    -> uretilen dosyalari sil
# =====================================================================

# --- Toolchain ---
PREFIX  = riscv32-unknown-elf
CC      = $(PREFIX)-gcc
LD      = $(PREFIX)-gcc
OBJCOPY = $(PREFIX)-objcopy
OBJDUMP = $(PREFIX)-objdump
NM      = $(PREFIX)-nm
SIZE    = $(PREFIX)-size

# --- Kaynak dosyalar ---
SRCS    = boot.S main.c

# --- Mimari ---
ARCH    = rv32imc_zicsr_zifencei
ABI     = ilp32

# --- Derleme bayraklari ---
CFLAGS  = -march=$(ARCH)     \
          -mabi=$(ABI)        \
          -O1                 \
          -g                  \
          -Wall               \
          -Wextra             \
          -nostdlib           \
          -ffreestanding      \
          -fno-builtin        \
          $(EXTRA_FLAGS)

# --- Linker bayraklari ---
LDFLAGS = -march=$(ARCH)     \
          -mabi=$(ABI)        \
          -nostdlib           \
          -T linker.ld

# --- Normal derleme ciktisi ---
BUILD_DIR   = build
ELF         = $(BUILD_DIR)/firmware.elf
HEX         = $(BUILD_DIR)/firmware.hex

# --- Simulasyon derleme ciktisi ---
SIM_DIR     = build_sim
SIM_ELF     = $(SIM_DIR)/firmware.elf
SIM_HEX     = $(SIM_DIR)/firmware.hex

# =====================================================================

.PHONY: all sim clean disasm size

# Normal derleme
all: $(HEX)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(ELF): $(SRCS) linker.ld | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) $(SRCS) -o $@

$(HEX): $(ELF)
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $(HEX) hazir"
	@$(SIZE) $<

# -----------------------------------------------------------------------
# Simulasyon derlemesi (-DSIMULATION tanimli)
# -----------------------------------------------------------------------
sim: EXTRA_FLAGS = -DSIMULATION
sim: $(SIM_HEX)

$(SIM_DIR):
	mkdir -p $(SIM_DIR)

$(SIM_ELF): $(SRCS) linker.ld | $(SIM_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) $(SRCS) -o $@

$(SIM_HEX): $(SIM_ELF)
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $(SIM_HEX) hazir"
	@$(SIZE) $<

# -----------------------------------------------------------------------
# Yardimci hedefler
# -----------------------------------------------------------------------

# Disassembly (koda bakma)
disasm: $(ELF)
	$(OBJDUMP) -d -S $<

# Sembol listesi + boyutlar
size: $(ELF)
	$(SIZE) $<
	@echo "--- Semboller ---"
	@$(NM) $< | sort

clean:
	rm -rf $(BUILD_DIR) $(SIM_DIR)
	@echo "[OK] Temizlendi"
