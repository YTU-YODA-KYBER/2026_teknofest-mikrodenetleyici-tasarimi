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
#  TUM ciktilar tek klasore yazilir: makefile_outputs/
#  Dosya adi hangi hedeften geldigini soyler; sim buildleri "sim_" onekli.
#
#  Hedefler:
#    make boot          -> makefile_outputs/boot.hex + boot.elf     (HW Boot ROM: erase ACIK)
#    make sim_boot      -> makefile_outputs/sim_boot.hex            (SIM: -DFLASHER_NO_ERASE)
#    make app           -> makefile_outputs/app.hex + app.bin       (main_app, HW, flash yolu)
#    make sim_app       -> makefile_outputs/sim_app.hex             (main_app, SIM, BOOT ROM'dan kosar)
#    make app_bootrom   -> makefile_outputs/app_bootrom.hex         (main_app, HW,  BOOT ROM'dan kosar)
#    make circle        -> makefile_outputs/circle.hex + circle.bin (circle, HW)
#    make echo          -> makefile_outputs/echo.hex                (UART echo testi)
#    make flash_vmf     -> makefile_outputs/app.vmf                 (Micron sim modeli icin)
#    make sim_flash_vmf -> makefile_outputs/sim_app.vmf
#    make size          -> boyut raporu (boot + app)
#    make clean         -> makefile_outputs/ (+ eski build_* artiklari) sil
#
#  Cikti dosyalari ne ise yarar:
#    makefile_outputs/boot.hex      -> Boot ROM'a $readmemh (TCL bunu "Memory File"
#                                      olarak ekler; top_module INIT_FILE_boot="boot.hex")
#    makefile_outputs/sim_boot.hex  -> Ayni sey, sim buildi (boot_test.sv bunu ister)
#    makefile_outputs/app.hex       -> main_app hex; send_data.py bunu UART'tan
#                                      flasher'a gonderir (hex2vmf girdisi de budur)
#    makefile_outputs/app.bin       -> Ayni app'in ham binary'si (harici programlayici)
#    makefile_outputs/sim_app.hex   -> main_app, BOOT ROM linker'i ile (0x00000000);
#                                      ai_accel_test.sv INIT_FILE_boot="sim_app.hex" ile
#                                      dogrudan Boot ROM'a yukler -> flasher/flash/DMA
#                                      zinciri beklenmeden app kosar
#    makefile_outputs/app_bootrom.hex-> Ayni sey, kart icin; App_Bootrom_Project.tcl
#                                      sentez generic'i ile Boot ROM'a gomulur
#    makefile_outputs/app.vmf       -> SIM'de Micron flash modeline; sim dizinine
#                                      "mem_Q512.vmf" adiyla kopyalanir
# =====================================================================

# --- Toolchain ---
#  Prefix, PATH'te kurulu olan toolchain'e gore otomatik secilir; asagidaki
#  listede ilk bulunan kullanilir. Elle zorlamak icin:
#      make PREFIX=riscv32-unknown-elf <hedef>
#  (komut satirindan verilen deger buradaki atamayi her zaman ezer)
RISCV_PREFIXES := riscv-none-elf riscv32-unknown-elf riscv64-unknown-elf \
                  riscv32-corev-elf riscv64-elf riscv-none-embed
PREFIX := $(firstword $(foreach p,$(RISCV_PREFIXES),\
            $(if $(shell command -v $(p)-gcc 2>/dev/null),$(p))))

ifeq ($(PREFIX),)
ifneq ($(MAKECMDGOALS),clean)
$(error RISC-V toolchain bulunamadi. Aranan prefixler: $(RISCV_PREFIXES). \
Toolchain-i kurup PATH-e ekleyin ya da: make PREFIX=<prefix> $(MAKECMDGOALS))
endif
endif

CC      = $(PREFIX)-gcc
OBJCOPY = $(PREFIX)-objcopy
OBJDUMP = $(PREFIX)-objdump
NM      = $(PREFIX)-nm
SIZE    = $(PREFIX)-size

# --- Mimari ---
ARCH = rv32imc_zicsr_zifencei
ABI  = ilp32

# --- Derleme / baglama bayraklari ---
#  -fstrict-volatile-bitfields: soc.h'taki register union'larinda bitfield
#  erisimi daima container tipiyle (uint32) yapilsin. AXI4-Lite bayt erisimi
#  kabul etmiyor; derleyicinin bir biti sb/lb ile okuyup yazmasi cevre
#  birimini bozardi.
CFLAGS  = -march=$(ARCH) -mabi=$(ABI) -O1 -g -Wall -Wextra \
          -nostdlib -ffreestanding -fno-builtin -fstrict-volatile-bitfields \
          $(EXTRA_FLAGS)
LDFLAGS = -march=$(ARCH) -mabi=$(ABI) -nostdlib

# --- vmf uretici ---
#  NOT: hex2vmf.py su an repoda YOK; flash_vmf/sim_flash_vmf hedefleri script
#  eklenene kadar calismaz. Script gelince bu satiri degistirmeye gerek yok.
HEX2VMF   = hex2vmf.py
FLASH_OFF ?= 0

# --- INSTRRAM'in linkteki gercek adresi. $readmemh ile yuklenen BRAM
#     dizisi 0-tabanli oldugu icin verilog hex uretilirken bu miktar
#     cikarilir (rebase), yoksa xsim "Out of bounds address" verip
#     yuklemeyi tamamen iptal eder / donanimda BRAM bos kalir. ---
APP_BASE  = 0x10000000

# =====================================================================
#  Kaynak / linker / cikti tanimlari
# =====================================================================
#  Tek cikti klasoru: hedefler birbirini ezmesin diye ELF/HEX adlari
#  hedef adiyla ayni koke sahiptir (boot.*, sim_boot.*, app.*, ...).
OUT_DIR = makefile_outputs

# Eski surumden kalan klasorler (sadece "clean" temizlesin diye tutuluyor)
LEGACY_DIRS = build_boot build_boot_sim build_app build_app_sim build_circle build_echo

BOOT_SRCS = boot.S main_boot.c
BOOT_LD   = linker.ld                 # Boot ROM (0x00000000)

APP_SRCS  = boot.S main_app.c
APP_LD    = linker_app.ld             # INSTRRAM (0x10000000) -> flash/DMA yolu
#  Ayni uygulamayi Boot ROM'dan kosturmak icin BOOT_LD (0x00000000) kullanilir.
#  Boylece flash + flasher + DMA zincirine hic girmeden app denenebilir; RTL'de
#  $readmemh eklemek ya da boot_addr'i degistirmek gerekmez.
APP_BOOTROM_LD = $(BOOT_LD)

CIRCLE_SRCS = boot.S circle.c
CIRCLE_LD   = linker_app.ld           # INSTRRAM (0x10000000)

ECHO_SRCS = boot.S flasher_echo_test.c
ECHO_LD   = linker.ld                 # Boot ROM (0x00000000)

#  YZ BENCH: hizlandirici <-> yazilim gerceklemesi kiyasi.
#  Boot ROM'dan kosar (flash/flasher/DMA zincirine hic girmez).
#  KENDI linker script'i vardir: 16KB'lik FC agirligi .rodata'da durdugu
#  icin 32KB Boot ROM + 32KB Data RAM ister. Ana projenin linker.ld'si
#  (1KB/8KB, sartname siniri) BU YUZDEN DEGISTIRILMEZ; RTL tarafinda da
#  parametreler yalnizca yz_bench_test.tcl/.sv tarafindan ezilir.
BENCH_SRCS  = boot.S yz_bench.c yz_model/tflite_ref.c
BENCH_LD    = linker_bench.ld
#  -O2: baseline kasitli yavaslatilmis gorunmemeli; -Iyz_model model
#  basliklari icin.
BENCH_FLAGS = -O2 -Iyz_model

.PHONY: all boot sim_boot app sim_app app_bootrom circle echo bench sim_bench \
        flash_vmf sim_flash_vmf size disasm_boot disasm_app clean

all: boot app

$(OUT_DIR):
	mkdir -p $@

# =====================================================================
#  BOOT  (Boot ROM: flasher + boot)
# =====================================================================
# --- HW: erase ACIK (gercek flash silinmeli) ---
boot: $(OUT_DIR)/boot.hex
$(OUT_DIR)/boot.elf: $(BOOT_SRCS) $(BOOT_LD) Makefile | $(OUT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(BOOT_LD) $(BOOT_SRCS) -o $@
$(OUT_DIR)/boot.hex: $(OUT_DIR)/boot.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (HW Boot ROM, erase ACIK)"
	@$(SIZE) $<

# --- SIM: erase KAPALI (-DFLASHER_NO_ERASE) ---
sim_boot: EXTRA_FLAGS = -DFLASHER_NO_ERASE
sim_boot: $(OUT_DIR)/sim_boot.hex
$(OUT_DIR)/sim_boot.elf: $(BOOT_SRCS) $(BOOT_LD) Makefile | $(OUT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(BOOT_LD) $(BOOT_SRCS) -o $@
$(OUT_DIR)/sim_boot.hex: $(OUT_DIR)/sim_boot.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (SIM Boot ROM, erase KAPALI)"
	@$(SIZE) $<

# =====================================================================
#  APP  (main_app -> INSTRRAM'e boot edilecek asil uygulama)
# =====================================================================
# --- HW: app.hex (send_data.py / hex2vmf girdisi) + app.bin (harici programlayici) ---
app: $(OUT_DIR)/app.hex $(OUT_DIR)/app.bin
$(OUT_DIR)/app.elf: $(APP_SRCS) $(APP_LD) Makefile | $(OUT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(APP_LD) $(APP_SRCS) -o $@
$(OUT_DIR)/app.hex: $(OUT_DIR)/app.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 --change-addresses -$(APP_BASE) $< $@
	@echo "[OK] $@   (main_app hex, INSTRRAM-rebased @0)"
	@$(SIZE) $<
$(OUT_DIR)/app.bin: $(OUT_DIR)/app.elf
	$(OBJCOPY) -O binary $< $@
	@echo "[OK] $@   (HW flash programlama)"

# --- SIM: app'i dogrudan BOOT ROM'dan kostur ---
#  Linker: linker.ld (IMEM = 0x00000000). Hex zaten 0-tabanli oldugu icin
#  --change-addresses YOK; rebase edilmis INSTRRAM imaji Boot ROM'a konursa
#  kod calisir gibi gorunur ama _sidata / mutlak adresler hala 0x1000xxxx'i
#  gosterdiginden .data bos INSTRRAM'den kopyalanir ve app coker.
#  ai_accel_test.sv bu dosyayi INIT_FILE_boot("sim_app.hex") ile ister.
sim_app: EXTRA_FLAGS = -DSIMULATION
sim_app: $(OUT_DIR)/sim_app.hex
$(OUT_DIR)/sim_app.elf: $(APP_SRCS) $(APP_BOOTROM_LD) Makefile | $(OUT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(APP_BOOTROM_LD) $(APP_SRCS) -o $@
$(OUT_DIR)/sim_app.hex: $(OUT_DIR)/sim_app.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (main_app hex, SIM, BOOT ROM @0x00000000)"
	@$(SIZE) $<

# --- HW: app'i Boot ROM'a gomup karttan kostur (flash/flasher/DMA yok) ---
#  Kullanimi: make app_bootrom  ->  vivado -source scripts/App_Bootrom_Project.tcl
#  TCL, fpga_top'un INIT_FILE_boot generic'ini "app_bootrom.hex" yapar.
app_bootrom: $(OUT_DIR)/app_bootrom.hex
$(OUT_DIR)/app_bootrom.elf: $(APP_SRCS) $(APP_BOOTROM_LD) Makefile | $(OUT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(APP_BOOTROM_LD) $(APP_SRCS) -o $@
$(OUT_DIR)/app_bootrom.hex: $(OUT_DIR)/app_bootrom.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (main_app hex, HW, BOOT ROM @0x00000000)"
	@$(SIZE) $<

# =====================================================================
#  CIRCLE  (eski LED demosu, Boot ROM/INSTRRAM dogrulamasi icin)
# =====================================================================
circle: $(OUT_DIR)/circle.hex $(OUT_DIR)/circle.bin
$(OUT_DIR)/circle.elf: $(CIRCLE_SRCS) $(CIRCLE_LD) Makefile | $(OUT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(CIRCLE_LD) $(CIRCLE_SRCS) -o $@
$(OUT_DIR)/circle.hex: $(OUT_DIR)/circle.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 --change-addresses -$(APP_BASE) $< $@
	@echo "[OK] $@   (circle app hex, INSTRRAM-rebased @0)"
	@$(SIZE) $<
$(OUT_DIR)/circle.bin: $(OUT_DIR)/circle.elf
	$(OBJCOPY) -O binary $< $@
	@echo "[OK] $@   (HW flash programlama)"

# =====================================================================
#  YZ BENCH  (hizlandirici vs yazilim gerceklemesi)
# =====================================================================
# --- KART: bench.hex ---
#  Vivado tarafinda fpga_top'un INIT_FILE_boot generic'i ile secilir:
#      set_property generic {INIT_FILE_boot=bench.hex} [current_fileset]
#  Boylece boot.hex / app_bootrom.hex uzerine YAZILMAZ.
bench: EXTRA_FLAGS = $(BENCH_FLAGS)
bench: $(OUT_DIR)/bench.hex
$(OUT_DIR)/bench.elf: $(BENCH_SRCS) $(BENCH_LD) Makefile | $(OUT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(BENCH_LD) $(BENCH_SRCS) -o $@
$(OUT_DIR)/bench.hex: $(OUT_DIR)/bench.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (yz_bench, HW, BOOT ROM @0x00000000)"
	@$(SIZE) $<

# --- SIM: sim_bench.hex ---
#  -DSIMULATION: ses verisi UART'tan BEKLENMEZ, .rodata'ya gomulu gelir
#  (1960 bayt UART = 8.5 M cevrim, olculecek cikarimdan uzun).
#  yz_bench_test.sv bu dosyayi INIT_FILE_boot("sim_bench.hex") ile ister.
sim_bench: EXTRA_FLAGS = $(BENCH_FLAGS) -DSIMULATION
sim_bench: $(OUT_DIR)/sim_bench.hex
$(OUT_DIR)/sim_bench.elf: $(BENCH_SRCS) $(BENCH_LD) Makefile | $(OUT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(BENCH_LD) $(BENCH_SRCS) -o $@
$(OUT_DIR)/sim_bench.hex: $(OUT_DIR)/sim_bench.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (yz_bench, SIM, gomulu girdi)"
	@$(SIZE) $<

# =====================================================================
#  FLASH VMF  (app hex -> Micron sim modeli imaji)
#    Sim dizinine "mem_Q512.vmf" adiyla kopyalanmalidir.
#    FLASH_OFF, main_boot.c'deki FLASH_ADDR ile AYNI olmali.
# =====================================================================
flash_vmf: $(OUT_DIR)/app.hex
	python3 $(HEX2VMF) $(OUT_DIR)/app.hex $(OUT_DIR)/app.vmf $(FLASH_OFF)
#  NOT: sim_app.hex artik BOOT ROM imajidir (0x00000000), flash'a yazilamaz;
#  bu yuzden sim vmf'i de INSTRRAM linkli app.hex'ten uretilir.
sim_flash_vmf: $(OUT_DIR)/app.hex
	python3 $(HEX2VMF) $(OUT_DIR)/app.hex $(OUT_DIR)/sim_app.vmf $(FLASH_OFF)

# =====================================================================
#  ECHO  (UART echo testi -> Boot ROM'da kosar)
# =====================================================================
echo: $(OUT_DIR)/echo.hex
$(OUT_DIR)/echo.elf: $(ECHO_SRCS) $(ECHO_LD) Makefile | $(OUT_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -T $(ECHO_LD) $(ECHO_SRCS) -o $@
$(OUT_DIR)/echo.hex: $(OUT_DIR)/echo.elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $< $@
	@echo "[OK] $@   (UART echo testi)"
	@$(SIZE) $<

# =====================================================================
#  YARDIMCI
# =====================================================================
disasm_boot: $(OUT_DIR)/boot.elf
	$(OBJDUMP) -d -S $<
disasm_app: $(OUT_DIR)/app.elf
	$(OBJDUMP) -d -S $<

size: $(OUT_DIR)/boot.elf $(OUT_DIR)/app.elf
	@echo "==================================================="
	@echo " main_boot.c  (Boot ROM  - linker.ld, 1KB'ye sigmali)"
	@echo "==================================================="
	@$(SIZE) $(OUT_DIR)/boot.elf
	@echo ""
	@echo "==================================================="
	@echo " main_app.c   (INSTRRAM app - linker_app.ld, max 8KB)"
	@echo "==================================================="
	@$(SIZE) $(OUT_DIR)/app.elf

clean:
	rm -rf $(OUT_DIR) $(LEGACY_DIRS)
	@echo "[OK] Temizlendi"
