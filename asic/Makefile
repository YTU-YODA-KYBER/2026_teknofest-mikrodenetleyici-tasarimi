# ===========================================================================
#  YTU YODA KYBER -- TEKNOFEST 2026 Cip Tasarim Yarismasi (Mikrodenetleyici)
#  ASIC fiziksel tasarim akisi otomasyonu   (LibreLane 3.0.6 / SKY130A)
#
#  ON KOSUL: LibreLane ortami acik olmali.
#     cd asic && nix develop ./environment
#
#  ZORUNLU HEDEF (sartname Bolum 8):
#     make asic_run      -- akisi bastan sona calistirir, rapor ve ciktilari toplar
#
#  EK HEDEFLER:
#     make asic_verify   -- teslim edilen rapor ve ciktilarin varligini denetler
#     make asic_clean    -- asic/run/ altindaki gecici dosyalari temizler
#     make prepare       -- uretilen RTL (mask ROM'lar, yamali kopyalar) + filelist
#     make checksums     -- SHA-256 ozetlerini uretir
#
#  Butun yollar bu dosyaya gorelidir; makineye ozgu mutlak yol yoktur.
# ===========================================================================

SHELL       := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

ASIC_DIR  := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
ROOT_DIR  := $(abspath $(ASIC_DIR)/..)
RTL_DIR   := $(ROOT_DIR)/FPGA/main_codes/rtl
FW_OUT    := $(ROOT_DIR)/FPGA/firmware/makefile_outputs
AI_DIR    := $(RTL_DIR)/desgin_sources/AI_Accelerator
GEN_DIR   := $(ROOT_DIR)/asic_rtl/gen
SCRIPTS   := $(ASIC_DIR)/scripts
PY        := python3

RUN_TAG   ?= rtl2gds
RUN_DIR   := $(ASIC_DIR)/run/$(RUN_TAG)

# ---------------------------------------------------------------------------
.PHONY: help
help:
	@echo "TEKNOFEST 2026 ASIC akisi -- kullanilabilir hedefler:"
	@echo "  make asic_run      akisi bastan sona calistir (ZORUNLU HEDEF)"
	@echo "  make asic_verify   teslim paketini denetle"
	@echo "  make asic_package  teslim icin hazirla (run/ bosalt + ozet + denetim)"
	@echo "  make asic_clean    asic/run/ altini temizle"
	@echo "  make prepare       uretilen RTL + filelist + config esitleme"
	@echo "  make checksums     SHA-256 ozetleri"
	@echo ""
	@echo "Once LibreLane ortamina girin:  nix develop ./environment"

# ---------------------------------------------------------------------------
#  Ortam denetimi -- akisi calistiran her hedef once bunu ister
# ---------------------------------------------------------------------------
.PHONY: check_env
check_env:
	@command -v librelane >/dev/null 2>&1 || { \
	   echo "HATA: 'librelane' bulunamadi."; \
	   echo "      Once LibreLane ortamina girin:  nix develop ./environment"; \
	   exit 1; }
	@$(PY) -c "import librelane" 2>/dev/null || { \
	   echo "HATA: librelane python paketi bulunamadi."; exit 1; }
	@if [ -z "$${PDK_ROOT:-}" ]; then \
	   echo "NOT: PDK_ROOT tanimli degil, ciel varsayilani kullanilacak."; fi

# ---------------------------------------------------------------------------
#  1) Uretilen RTL: mask ROM'lar + ucuncu taraf yamali kopyalar
#
#  Kalici bellekler (Boot ROM, YZ agirlik ROM'lari) SRAM makrosuna konamaz --
#  silikonda ilklendirilemezler. Icerikleri hex kaynaklarindan RTL'e gomulur.
# ---------------------------------------------------------------------------
.PHONY: roms
roms:
	@echo "==> Mask ROM'lar uretiliyor"
	@$(PY) $(SCRIPTS)/gen_rom.py --kind boot_rom \
	    --hex $(FW_OUT)/boot.hex \
	    --out $(GEN_DIR)/boot_rom_asic.sv \
	    --orig "Memory/BRAM_defines/boot_rom_def.sv"
	@$(PY) $(SCRIPTS)/gen_rom.py --kind weights_rom_p8 \
	    --hex $(AI_DIR)/weights_p8.hex \
	    --out $(GEN_DIR)/weights_rom_p8_asic.v \
	    --orig "AI_Accelerator/weights_rom_p8.v"
	@$(PY) $(SCRIPTS)/gen_rom.py --kind fc_weights_rom_p4 \
	    --hex $(AI_DIR)/fc_weights_p4.hex \
	    --out $(GEN_DIR)/fc_weights_rom_p4_asic.v \
	    --orig "AI_Accelerator/fc_weights_rom_p4.v"

.PHONY: vendor
vendor:
	@echo "==> Yamali RTL kopyalari uretiliyor"
	@$(PY) $(SCRIPTS)/patch_rtl.py

.PHONY: filelist
filelist:
	@echo "==> filelist.f uretiliyor ve config.yaml esitleniyor"
	@$(PY) $(SCRIPTS)/gen_filelist.py

.PHONY: prepare
prepare: roms vendor filelist

# ---------------------------------------------------------------------------
#  2) ZORUNLU HEDEF: tam akis
# ---------------------------------------------------------------------------
.PHONY: asic_run
asic_run: check_env asic_clean prepare
	@echo "==> LibreLane Classic akisi basliyor (etiket: $(RUN_TAG))"
	@$(PY) $(SCRIPTS)/run_flow.py --tag $(RUN_TAG) --overwrite
	@echo "==> Rapor ve ciktilar toplaniyor"
	@$(PY) $(SCRIPTS)/collect.py --run-dir $(RUN_DIR)
	@echo "==> Surum bilgileri ve README sonuc ozeti guncelleniyor"
	@$(PY) $(SCRIPTS)/gen_versions.py
	@$(PY) $(SCRIPTS)/gen_readme_results.py
	@$(MAKE) --no-print-directory checksums
	@echo "==> asic_run tamamlandi."

# Makro yerlesimi sentezlenmis netlist'ten uretilir; floorplan degistiginde
# once `make macro_placement` calistirilir.
.PHONY: macro_placement
macro_placement:
	@$(PY) $(SCRIPTS)/gen_macro_placement.py \
	    --netlist $$(ls $(RUN_DIR)/*yosys-synthesis/*.nl.v | head -1)

# ---------------------------------------------------------------------------
#  3) Teslim denetimi
# ---------------------------------------------------------------------------
.PHONY: asic_verify
asic_verify:
	@$(PY) $(SCRIPTS)/verify_deliverables.py

.PHONY: checksums
checksums:
	@$(PY) $(SCRIPTS)/gen_checksums.py

# ---------------------------------------------------------------------------
#  4) Teslim paketi hazirligi
#
#  asic/run/ gelistirme sirasinda kok bolumdeki genis bir dizine SYMLINK
#  olabilir (bu makinede oyle: /home bolumu kucuk). Sartname (Bolum 4) teslimde
#  bu dizinin BOS olmasini istiyor; bu hedef symlink'i gercek bos bir dizine
#  cevirir ve ozetleri yeniden uretir.
# ---------------------------------------------------------------------------
.PHONY: asic_package
asic_package: asic_clean
	@echo "==> Teslim paketi hazirlaniyor"
	@if [ -L "$(ASIC_DIR)/run" ]; then \
	   echo "    asic/run symlink'i gercek bos dizine ceviriliyor"; \
	   rm -f "$(ASIC_DIR)/run"; \
	 fi
	@mkdir -p "$(ASIC_DIR)/run"
	@touch "$(ASIC_DIR)/run/.gitkeep"
	@$(MAKE) --no-print-directory checksums
	@$(MAKE) --no-print-directory asic_verify

# ---------------------------------------------------------------------------
#  5) Temizlik -- yalnizca yeniden uretilebilir calisma ciktilari
# ---------------------------------------------------------------------------
.PHONY: asic_clean
asic_clean:
	@echo "==> asic/run/ temizleniyor"
	@if [ -d "$(ASIC_DIR)/run" ]; then \
	   find "$(ASIC_DIR)/run/" -mindepth 1 -maxdepth 1 ! -name '.gitkeep' -exec rm -rf {} + ; \
	 fi
	@mkdir -p "$(ASIC_DIR)/run"
	@touch "$(ASIC_DIR)/run/.gitkeep"
