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
#     make prepare       -- firmware + uretilen RTL (mask ROM, yamali kopya) + filelist
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
# Makro met1 keep-out'lari: olculdu, DRT'yi kotulestiriyor -> varsayilan off
MODE      ?= off
# Calisma alani. Sartname geregi VARSAYILAN asic/run/ altidir (goreli yol).
# Diski dolan makinelerde ASIC_RUN_ROOT ile baska bir diske yonlendirilebilir;
# bu YEREL bir tercih olup depoda hicbir mutlak yol birakmaz.
ASIC_RUN_ROOT ?= $(ASIC_DIR)/run
RUN_DIR   := $(ASIC_RUN_ROOT)/$(RUN_TAG)

# ---------------------------------------------------------------------------
.PHONY: help
help:
	@echo "TEKNOFEST 2026 ASIC akisi -- kullanilabilir hedefler:"
	@echo "  make asic_run      akisi bastan sona calistir (ZORUNLU HEDEF)"
	@echo "  make asic_verify   teslim paketini denetle"
	@echo "  make asic_package  teslim icin hazirla (run/ bosalt + ozet + denetim)"
	@echo "  make asic_clean    asic/run/ altini temizle"
	@echo "  make prepare       uretilen RTL + filelist + config esitleme"
	@echo "  make verify_generated  uretilen RTL/ROM/keep-out bayat mi kontrol et"
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
#  ROM listesi artik gen_rom.py icindeki MANIFEST'te (tek dogruluk kaynagi);
#  Makefile ile betigin argumanlari ayrisamaz.
.PHONY: roms
roms:
	@echo "==> Mask ROM'lar uretiliyor"
	@$(PY) $(SCRIPTS)/gen_rom.py --all

.PHONY: vendor
vendor:
	@echo "==> Yamali RTL kopyalari uretiliyor"
	@$(PY) $(SCRIPTS)/patch_rtl.py

# ---------------------------------------------------------------------------
#  ASIC firmware'i (boot ROM + app hex) saat frekansina BAGLIDIR.
#
#  NEDEN AYRI BIR HEDEF?
#    `UART_CPB` sabiti derleme zamaninda `-DSYS_CLK_HZ` ile donar ve mask
#    ROM'a gomulur. Onceden `prepare` yalnizca gen_rom.py'yi kosuyordu; o da
#    mevcut .hex'ten .sv uretir. Yani CLOCK_PERIOD degisip firmware ELLE
#    derlenmezse:
#      - patch_rtl.py'nin config.yaml <-> FPGA/firmware/Makefile capraz
#        kontrolu GECER (iki dosya da guncellenmis olur),
#      - gen_rom.py --check "guncel" der (ROM ile hex tutarlidir),
#      - ama ROM'un ICINDEKI CPB bir onceki frekansa aittir.
#    2026-09-02'de 25 -> 30 MHz gecisinde tam bu oldu: hex hala CPB=217
#    tasiyordu (30 MHz'in dogrusu 260). Sessiz, kapilardan gecen bir hata.
#
#    Cozum: firmware derlemesi prepare zincirinin PARCASI. ASIC_CLK_HZ
#    override EDILMEZ -- FPGA/firmware/Makefile'daki deger tek beyan noktasi
#    olarak kalir ve patch_rtl.py onu config.yaml ile karsilastirmaya devam
#    eder (cift yonlu kapi korunur).
# ---------------------------------------------------------------------------
.PHONY: firmware
firmware:
	@echo "==> ASIC firmware derleniyor (boot + app, sim varyantlariyla)"
	@$(MAKE) -s -C $(ROOT_DIR)/FPGA/firmware \
	         asic_boot asic_app asic_sim_boot asic_sim_app

#  Makro keep-out'lari config.yaml'daki ROUTING_OBSTRUCTIONS blogunu doldurur;
#  kaynagi constraints/macro_placement.cfg'dir (elle koordinat yazilmaz).
.PHONY: keepout
keepout:
	@echo "==> Makro met1 keep-out'lari config.yaml'a esitleniyor"
	@$(PY) $(SCRIPTS)/gen_macro_keepout.py --mode $(MODE)

.PHONY: filelist
filelist:
	@echo "==> filelist.f uretiliyor ve config.yaml esitleniyor"
	@$(PY) $(SCRIPTS)/gen_filelist.py

.PHONY: prepare
prepare: vendor firmware roms filelist keepout

# ---------------------------------------------------------------------------
#  Uretilen RTL bayatlik kapisi
#
#  patch_rtl.py --check  : yamali kopyalar kaynak RTL ile uyumlu mu
#  gen_rom.py --all --check : mask ROM'lar kaynak hex ile uyumlu mu
#
#  Ikincisi eskiden YOKTU: firmware yeniden derlenip `make roms` unutuldugunda
#  BAYAT bir boot ROM sessizce silikona gidebiliyordu.
# ---------------------------------------------------------------------------
.PHONY: verify_generated
verify_generated:
	@echo "==> Uretilen RTL guncellik kontrolu"
	@$(PY) $(SCRIPTS)/patch_rtl.py --check
	@$(PY) $(SCRIPTS)/gen_rom.py --all --check
	@$(PY) $(SCRIPTS)/gen_macro_keepout.py --check --mode $(MODE)

.PHONY: asic_sim
asic_sim: check_env prepare
	@echo "==> ASIC islevsel regresyonlari calisiyor"
	@rm -rf "$(ASIC_DIR)/reports/general/asic_sim"
	@mkdir -p "$(ASIC_DIR)/reports/general/asic_sim"
	@$(PY) $(SCRIPTS)/run_asic_sim.py collision --report-dir "$(ASIC_DIR)/reports/general/asic_sim"
	@$(PY) $(SCRIPTS)/run_asic_sim.py instr_collision --report-dir "$(ASIC_DIR)/reports/general/asic_sim"
	@$(PY) $(SCRIPTS)/run_asic_sim.py mem --report-dir "$(ASIC_DIR)/reports/general/asic_sim"
	@$(PY) $(SCRIPTS)/run_asic_sim.py boot --report-dir "$(ASIC_DIR)/reports/general/asic_sim"
	@$(PY) $(SCRIPTS)/run_asic_sim.py yz --report-dir "$(ASIC_DIR)/reports/general/asic_sim"

# ---------------------------------------------------------------------------
#  2) ZORUNLU HEDEF: tam akis
#
#  AKIS UC FAZLIDIR -- NEDEN?
#    LibreLane Classic'in adim sirasi sabittir (flows/classic.py:79-87):
#        GlobalRouting -> CheckAntennas -> RepairDesignPostGRT
#        -> DiodesOnPorts -> RepairAntennas -> ResizerTimingPostGRT
#        -> STAMidPNR -> DetailedRouting
#    `RepairAntennas` anten jumper'larini GUIDE olarak ekler.
#    `ResizerTimingPostGRT` ise rsz_timing_postgrt.tcl:26-31'de KOSULSUZ bir
#    `global_route` calistirir (OpenROAD #5590 nedeniyle `if` blogu yorum
#    satirina alinmis). `GlobalRouter::saveGuides` her netin guide'ini
#    `clearGuides()` ile silip yeniden yazar. Jumper bir netlist hucresi
#    degil, YALNIZCA guide geometrisidir -- bu yuzden %100'u yok olur.
#    ODB denetimiyle olculdu (scripts/jumper_odb_audit.py):
#        repair_antennas sonrasi : 1.661 jumper guide, 1.422 "onarildi" bayragi
#        resizer sonrasi         :     0 jumper guide, 1.422 SAHIPSIZ bayrak
#
#    Ayrica met3 kaynak cezasi yalnizca ana GlobalRouting'den sonra
#    uygulanmalidir. Guncel UART RTL'sinde %15 ana GRT'de 56 asimla durdu;
#    %10 ise ayni faz-1 durumundan 0 asimla gecip tam signoff'u tamamladi.
#
#    Cozum: faz 1 taban config ile STAMidPNR-2'ye kadar; faz 2 met3 overlay'i
#    ile GlobalRouting'den ResizerTimingPostGRT'ye kadar; faz 3 ise jumper'i
#    resizer'in CIKTISI uzerine ekleyip sona kadar gider. Devam fazlarina
#    `--overwrite` VERILMEZ: flow.py:599 onceki fazlari silerdi.
#
#    Faz 3 overlay'i (experiments/antenna_jumper.yaml) icindeki
#    `RUN_POST_GRT_RESIZER_TIMING: false` resizer'i DEVRE DISI BIRAKMAZ --
#    resizer faz 2'de zaten kostu; bu bayrak yalnizca IKINCI kez kosup
#    jumper'lari yeniden silmesini engeller.
#
#    OLCULEN KAZANC: anten ihlalli net 1.935 -> 1.474 (-%23,8), pin
#    2.364 -> 1.870 (-%20,9); eklenen hucre 0, DRC 0, setup/hold degismedi.
#
#  BU HEDEF TESLIM EDILEN GDS'I AYNEN URETIR. Daha once faz 2 elle
#  kosuluyordu; `make asic_run` tek fazliydi ve teslim edilen anten
#  sayilarini UREMIYORDU (sartname Bolum 3.2.3 tutarlilik riski).
# ---------------------------------------------------------------------------
.PHONY: asic_run
asic_run: check_env prepare
	@echo "==> LibreLane Classic akisi basliyor (etiket: $(RUN_TAG))"
	@echo "    Faz 1/3: baslangictan OpenROAD.STAMidPNR-2'ye kadar (taban katman ayari)"
	@set +e; \
	$(PY) $(SCRIPTS)/run_flow.py --tag $(RUN_TAG) --overwrite \
	      --config $(ASIC_DIR)/config.yaml \
	      --to OpenROAD.STAMidPNR-2; \
	flow_rc=$$?; \
	if [ $$flow_rc -eq 0 ]; then \
	  sta2_dir=$$(ls -d $(RUN_DIR)/*-openroad-stamidpnr-2 2>/dev/null | tail -1); \
	  if [ -z "$$sta2_dir" ] || [ ! -f "$$sta2_dir/state_out.json" ]; then \
	    echo "HATA: faz 1 bitti ama STAMidPNR-2 state_out.json bulunamadi." >&2; \
	    echo "      Aranan: $(RUN_DIR)/*-openroad-stamidpnr-2/state_out.json" >&2; \
	    flow_rc=1; \
	  else \
	    echo "==> Faz 2/3: GlobalRouting -> ResizerTimingPostGRT (met3 %10 overlay)"; \
	    echo "    baslangic durumu: $$sta2_dir/state_out.json"; \
	    $(PY) $(SCRIPTS)/run_flow.py --tag $(RUN_TAG) \
	          --from OpenROAD.GlobalRouting --to OpenROAD.ResizerTimingPostGRT \
	          --config $(ASIC_DIR)/config.yaml \
	          --config $(ASIC_DIR)/experiments/grt_layer_met3_010.yaml \
	          --initial-state "$$sta2_dir/state_out.json"; \
	    flow_rc=$$?; \
	  fi; \
	fi; \
	if [ $$flow_rc -eq 0 ]; then \
	  rsz_dir=$$(ls -d $(RUN_DIR)/*-openroad-resizertimingpostgrt 2>/dev/null | tail -1); \
	  if [ -z "$$rsz_dir" ] || [ ! -f "$$rsz_dir/state_out.json" ]; then \
	    echo "HATA: faz 2 bitti ama ResizerTimingPostGRT state_out.json bulunamadi." >&2; \
	    echo "      Aranan: $(RUN_DIR)/*-openroad-resizertimingpostgrt/state_out.json" >&2; \
	    flow_rc=1; \
	  else \
	    echo "==> Faz 3/3: RepairAntennas'tan sona (met3 %10 + anten jumper overlay)"; \
	    echo "    baslangic durumu: $$rsz_dir/state_out.json"; \
	    $(PY) $(SCRIPTS)/run_flow.py --tag $(RUN_TAG) \
	          --from OpenROAD.RepairAntennas \
	          --config $(ASIC_DIR)/config.yaml \
	          --config $(ASIC_DIR)/experiments/grt_layer_met3_010.yaml \
	          --config $(ASIC_DIR)/experiments/antenna_jumper.yaml \
	          --initial-state "$$rsz_dir/state_out.json"; \
	    flow_rc=$$?; \
	  fi; \
	fi; \
	finalize_rc=0; \
	final_found=0; \
	collected=0; \
	# LibreLane her kismi faz sonunda final/metrics.json yazabilir. Bu dosya \
	# tek basina nihai signoff kaniti degildir; GDS yoksa collect.py eski \
	# teslim paketini kismen bosaltirdi. GDS, ucuncu fazin gercekten sonuna \
	# ulasildigini gosteren zorunlu fiziksel isarettir. \
	if [ -f "$(RUN_DIR)/final/metrics.json" ] && \
	   [ -f "$(RUN_DIR)/final/gds/top_module.gds" ]; then \
		final_found=1; \
		echo "==> Rapor ve ciktilar toplaniyor"; \
		$(PY) $(SCRIPTS)/collect.py --run-dir $(RUN_DIR) || finalize_rc=$$?; \
		if [ $$finalize_rc -eq 0 ]; then collected=1; fi; \
		if [ $$finalize_rc -eq 0 ]; then \
			echo "==> Surum bilgileri ve README sonuc ozeti guncelleniyor"; \
			$(PY) $(SCRIPTS)/gen_versions.py || finalize_rc=$$?; \
		fi; \
		if [ $$finalize_rc -eq 0 ]; then \
			$(PY) $(SCRIPTS)/gen_readme_results.py || finalize_rc=$$?; \
		fi; \
		if [ $$finalize_rc -eq 0 ]; then \
			$(MAKE) --no-print-directory checksums || finalize_rc=$$?; \
		fi; \
		if [ $$finalize_rc -eq 0 ]; then \
			$(MAKE) --no-print-directory asic_verify || finalize_rc=$$?; \
		fi; \
	else \
		echo "HATA: Akis nihai metrics+GDS uretmeden kesildi; onceki teslim ciktilari korunuyor." >&2; \
		if [ $$flow_rc -eq 0 ]; then finalize_rc=1; fi; \
	fi; \
	if [ $$flow_rc -ne 0 ]; then \
		if [ $$final_found -eq 0 ]; then \
			echo "HATA: LibreLane akisi basarisiz (kod $$flow_rc); toplanabilir final durum yok." >&2; \
		elif [ $$collected -eq 0 ]; then \
			echo "HATA: LibreLane kod $$flow_rc ile bitti ve final durum bulundu, ancak teslim sonlandirma adimi kod $$finalize_rc ile basarisiz oldu." >&2; \
		elif [ $$finalize_rc -ne 0 ]; then \
			echo "HATA: LibreLane kod $$flow_rc ile bitti; final ciktilar toplandi, sonraki teslim adimi kod $$finalize_rc ile basarisiz oldu." >&2; \
		else \
			echo "HATA: LibreLane kalite kapilarindan biri basarisiz (kod $$flow_rc); uretilen final ciktilar toplandi ve dogrulandi." >&2; \
		fi; \
		exit $$flow_rc; \
	fi; \
	if [ $$finalize_rc -ne 0 ]; then \
		echo "HATA: Akis tamamlandi fakat teslim sonlandirma adimi basarisiz (kod $$finalize_rc)." >&2; \
		exit $$finalize_rc; \
	fi; \
	echo "==> asic_run tamamlandi."

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
asic_verify: verify_generated
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
asic_package:
	@echo "==> Teslim paketi hazirlaniyor"
	@if pgrep -f 'scripts/run_flow[.]py' >/dev/null 2>&1; then \
	   echo "HATA: Etkin bir ASIC akisi varken paketleme yapilamaz."; exit 1; \
	 fi
	@if [ -L "$(ASIC_DIR)/run" ]; then \
	   echo "    asic/run symlink'i gercek bos dizine ceviriliyor"; \
	   rm -f "$(ASIC_DIR)/run"; \
	 fi
	@mkdir -p "$(ASIC_DIR)/run"
	@find "$(ASIC_DIR)/run" -mindepth 1 -maxdepth 1 ! -name '.gitkeep' -exec rm -rf {} +
	@touch "$(ASIC_DIR)/run/.gitkeep"
	@$(MAKE) --no-print-directory checksums
	@$(PY) $(SCRIPTS)/verify_deliverables.py --delivery

# ---------------------------------------------------------------------------
#  5) Temizlik -- yalnizca yeniden uretilebilir calisma ciktilari
# ---------------------------------------------------------------------------
.PHONY: asic_clean
asic_clean:
	@echo "==> asic/run/ temizleniyor"
	@if pgrep -f 'scripts/run_flow[.]py' >/dev/null 2>&1; then \
	   echo "HATA: Etkin bir ASIC akisi varken run/ temizlenemez."; \
	   echo "      Once kosumun tamamlanmasini bekleyin veya sureci guvenle durdurun."; \
	   exit 1; \
	 fi
	@if [ -L "$(ASIC_DIR)/run" ]; then \
	   echo "HATA: asic/run bir symlink; dis hedef guvenlik nedeniyle temizlenmedi."; \
	   echo "      Yalniz secili etiketi yenilemek icin make asic_run kullanin."; \
	   exit 1; \
	 fi
	@if [ -d "$(ASIC_DIR)/run" ]; then \
	   find "$(ASIC_DIR)/run/" -mindepth 1 -maxdepth 1 ! -name '.gitkeep' -exec rm -rf {} + ; \
	 fi
	@mkdir -p "$(ASIC_DIR)/run"
	@touch "$(ASIC_DIR)/run/.gitkeep"
