#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  gen_filelist.py -- asic/filelist.f dosyasini uretir.
#
#  Kaynak agac main_codes/rtl/ altindadir; bu betik oradaki butun .sv/.v
#  dosyalarini tarar, ASIC akisina girmeyenleri ayiklar, FPGA'ya ozgu bellek
#  modullerini asic_rtl/ karsiliklariyla degistirir ve sonucu HDL derleme
#  bagimliliklarini karsilayan bir sirada yazar (paketler once, ust modul son).
#
#  Boylece filelist.f elle tutulmaz; RTL agacina dosya eklenirse `make filelist`
#  ile yeniden uretilir ve sartnamenin "eksiksiz olmali" sarti korunur.
# ---------------------------------------------------------------------------
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]      # mainfiles/
RTL = ROOT / "FPGA/main_codes/rtl"          # FPGA ile ORTAK, degistirilmeyen RTL
ASIC_RTL = ROOT / "asic_rtl"                # yalnizca ASIC akisinin RTL'i
ASIC = ROOT / "asic"

# --- FPGA karsiligi ASIC'te BASKA bir dosyayla degistirilenler ---
REPLACED = {
    "desgin_sources/Memory/BRAM_defines/bram_instr_def.sv",
    "desgin_sources/Memory/BRAM_defines/bram_data_def.sv",
    "desgin_sources/Memory/BRAM_defines/bram_yz_def.sv",
    "desgin_sources/Memory/BRAM_defines/boot_rom_def.sv",
    "desgin_sources/AI_Accelerator/conv_buf_ram.v",
    "desgin_sources/AI_Accelerator/fc_weights_rom_p4.v",
    "desgin_sources/AI_Accelerator/weights_rom_p8.v",
    # --- asic/scripts/patch_rtl.py tarafindan yamali kopyasi uretilenler ---
    # (surulmeyen AXI yanit kodlari, kullanilmayan yazma kanali, sifir genislikli
    #  parca-secim; gerekceler uretilen dosyalarin basinda yazili)
    "desgin_sources/CPU/openhw_obi_to_axi/obi_to_axi.sv",
    "desgin_sources/CPU/bizim_kodlar/cv32e40p_obi_to_axi_wrapper.sv",
    "desgin_sources/Peripherals/GPIO/GPIO_AXI4_Lite.sv",
    "desgin_sources/Peripherals/Timer/Timer_AXI4_Lite.sv",
    "desgin_sources/Peripherals/QSPI/QSPI_Master_AXI4_Lite.sv",
    "desgin_sources/Peripherals/UART_GU/UART_GU_AXI4-Lite.sv",
    "desgin_sources/Peripherals/UART_YZ/UART_YZ_AXI4-Lite.sv",
    "desgin_sources/Memory/Instrurction_RAM_AXI4-Lite_Wrapper/instr_bram_axi_ctrl.sv",
    "desgin_sources/Memory/Data_RAM_AXI4-Lite_Wrapper/data_bram_axi_ctrl.sv",
    "desgin_sources/AI_Accelerator/conv_accelerator.v",
    "desgin_sources/Top_Module/Top_module.sv",
}

# --- ASIC akisina hic girmeyenler, gerekcesiyle ---
EXCLUDED = {
    "desgin_sources/fpga_top.sv":
        "Xilinx clk_wiz_0 (MMCM) IP bagimliligi; ASIC ust modulu top_module'dur",
    # CV32E40P FPU=0 ile yapilandirildigi icin (cv32e40p_top.sv:159 generate
    # blogu elaborate edilmez) fpnew agaci olu koddur. Ayrica fpnew_pkg.sv:50
    # Yosys'in desteklemedigi bir yapi kullanir (struct tipinin paketlenmis
    # dizisi localparam icinde).
    "desgin_sources/CPU/cv32e40p_rtl/vendor/fpnew/fpnew_pkg.sv":
        "FPU=0; kullanilmiyor",
    "desgin_sources/CPU/cv32e40p_rtl/vendor/fpnew/fpnew_top.sv":
        "FPU=0; kullanilmiyor",
    "desgin_sources/CPU/cv32e40p_rtl/vendor/fpnew/fpnew_opgroup_block.sv":
        "FPU=0; kullanilmiyor",
    "desgin_sources/CPU/cv32e40p_rtl/vendor/fpnew/fpnew_opgroup_fmt_slice.sv":
        "FPU=0; kullanilmiyor",
    "desgin_sources/CPU/cv32e40p_rtl/cv32e40p_fp_wrapper.sv":
        "FPU=0; yalnizca fpu_gen generate blogunda instantiate edilir",
}

# --- derleme sirasi: paketler her seyden once ---
PKG_ORDER = [
    "desgin_sources/CPU/cv32e40p_rtl/include/cv32e40p_pkg.sv",
    "desgin_sources/CPU/cv32e40p_rtl/include/cv32e40p_apu_core_pkg.sv",
    "desgin_sources/CPU/cv32e40p_rtl/include/cv32e40p_fpu_pkg.sv",
    "desgin_sources/CPU/cv32e40p_rtl/vendor/pulp_platform_common_cells/src/cf_math_pkg.sv",
    "desgin_sources/CPU/openhw_obi_to_axi/axi_pkg.sv",
    "desgin_sources/CPU/openhw_obi_to_axi/obi_pkg.sv",
    "desgin_sources/CPU/bizim_kodlar/axi_req_rsp_ports.sv",
    "desgin_sources/CPU/bizim_kodlar/obi_req_rsp_ports.sv",
]

ASIC_PATCHED = [
    "patched/obi_to_axi_asic.sv",
    "patched/cv32e40p_obi_to_axi_wrapper_asic.sv",
    "patched/instr_bram_axi_ctrl_asic.sv",
    "patched/data_bram_axi_ctrl_asic.sv",
    "patched/GPIO_AXI4_Lite_asic.sv",
    "patched/Timer_AXI4_Lite_asic.sv",
    "patched/QSPI_Master_AXI4_Lite_asic.sv",
    "patched/UART_GU_AXI4_Lite_asic.sv",
    "patched/UART_YZ_AXI4_Lite_asic.sv",
    "patched/conv_accelerator_asic.v",
]
ASIC_TECH = ["tech/xilinx_iobuf_stub.sv", "tech/axi_read_arbiter2.sv"]
ASIC_MEM = ["mem/sram32_cell.sv", "mem/sram32_cell_1k.sv",
            "mem/sram32_bank.sv", "mem/sram8_bank.sv",
            "mem/bram_instr_asic.sv", "mem/bram_data_asic.sv",
            "mem/bram_yz_asic.sv", "mem/conv_buf_ram_asic.sv"]
ASIC_ROM = ["gen/boot_rom_asic.sv", "gen/weights_rom_p8_asic.v",
            "gen/fc_weights_rom_p4_asic.v"]
ASIC_TOP = ["patched/Top_module_asic.sv"]

BUCKETS = [
    ("desgin_sources/CPU/cv32e40p_rtl/vendor/", "vendor",
     "CV32E40P -- ucuncu taraf yardimci moduller (pulp-platform)"),
    ("desgin_sources/CPU/cv32e40p_rtl/", "core", "CV32E40P RISC-V cekirdegi"),
    ("desgin_sources/CPU/", "bridge", "OBI <-> AXI4 koprusu"),
    ("desgin_sources/Memory/", "mem", "Bellek AXI4-Lite kontrolculeri"),
    ("desgin_sources/Interconnect/", "icon", "Ara baglanti"),
    ("desgin_sources/Peripherals/", "periph", "Cevre birimleri"),
    ("desgin_sources/AI_Accelerator/", "ai", "YZ hizlandirici"),
    ("desgin_sources/Top_Module/", "top", "Ust modul (en son)"),
]

HEADER = """# ---------------------------------------------------------------------------
#  asic/filelist.f -- ASIC fiziksel tasarim akisinda kullanilan RTL kaynaklari
#
#  URETEN: asic/scripts/gen_filelist.py   (`make filelist`)
#
#  Butun yollar bu dosyanin bulundugu asic/ dizinine gorelidir; makineye ozgu
#  mutlak yol yoktur. Sira HDL derleme bagimliliklarini karsilar: once
#  paketler, sonra alt moduller, en sonda ust modul.
#
#  FPGA AKISIYLA FARKLAR -- mevcut RTL'in tek satiri bile degistirilmemistir;
#  fark yalnizca bu listede hangi dosyanin secildigidir:
#
#    1) fpga_top.sv listede YOKTUR. Xilinx clk_wiz_0 (MMCM) IP'sine baglidir;
#       ASIC'te ust modul dogrudan top_module'dur, saat pad'den gelir.
#
#    2) Memory/BRAM_defines/*.sv ve YZ hizlandiricinin ROM/RAM dosyalari yerine
#       asic_rtl/ altindaki AYNI ISIMLI moduller kullanilir:
#         * degisken bellekler (Instr/Data RAM, YZ girdi RAM'i, conv tamponu)
#           -> SKY130 SRAM makrolari
#         * kalici bellekler (Boot ROM, YZ agirlik ROM'lari)
#           -> standart hucrelerden orulmus mask ROM (silikonda guc verildiginde
#              hazir; SRAM makrosu ilklendirilemedigi icin zorunlu)
#       Esdegerlik kaniti: asic_rtl/testbench/tb_asic_mem_equiv.sv
#
#    3) Xilinx IOBUF primitifinin teknolojiden bagimsiz karsiligi eklenmistir.
#
#    4) CV32E40P FPU=0 ile yapilandirildigi icin fpnew agaci ve fp_wrapper
#       listede yoktur (elaborate edilmeyen generate blogunda kalirlar).
#
#  Include dizini: ../FPGA/main_codes/rtl/include/CPU
# ---------------------------------------------------------------------------

+incdir+../FPGA/main_codes/rtl/include/CPU
"""


def main():
    all_rtl = sorted(p for p in RTL.rglob("*") if p.suffix in (".sv", ".v"))
    names = {str(p.relative_to(RTL)) for p in all_rtl}

    for s in list(PKG_ORDER) + sorted(REPLACED) + sorted(EXCLUDED):
        if s not in names:
            sys.exit(f"HATA: beklenen kaynak dosya yok: {s}")
    for s in ASIC_PATCHED + ASIC_TECH + ASIC_MEM + ASIC_ROM + ASIC_TOP:
        if not (ASIC_RTL / s).is_file():
            sys.exit(f"HATA: ASIC kaynagi yok: asic_rtl/{s}"
                     f"  (`make roms` calistirildi mi?)")

    AS = ASIC_RTL
    groups = {}
    for p in all_rtl:
        n = str(p.relative_to(RTL))
        if n in EXCLUDED or n in REPLACED or n in PKG_ORDER:
            continue
        for prefix, key, _ in BUCKETS:
            if n.startswith(prefix):
                groups.setdefault(key, []).append(p)
                break
        else:
            sys.exit(f"HATA: siniflandirilamayan dosya: {n}")

    sections = [
        ("Paketler ve typedef'ler -- her seyden once derlenmeli",
         [RTL / s for s in PKG_ORDER]),
        ("Yamali RTL kopyalari -- orijinallerine DOKUNULMAMISTIR "
         "(bkz. asic/scripts/patch_rtl.py)",
         [AS / s for s in ASIC_PATCHED]),
        ("ASIC teknoloji sarmalayicisi (FPGA akisinda YOKTUR)",
         [AS / s for s in ASIC_TECH]),
        ("ASIC degisken bellekleri: SKY130 SRAM makro sarmalayicilari",
         [AS / s for s in ASIC_MEM]),
        ("ASIC kalici bellekleri: uretilmis mask ROM'lar (gen_rom.py ciktisi)",
         [AS / s for s in ASIC_ROM]),
    ] + [(title, groups.get(key, [])) for _, key, title in BUCKETS] + [
        ("ASIC reset synchronizer'li ust modul (en son)",
         [AS / s for s in ASIC_TOP]),
    ]

    out, n = [HEADER], 0
    for title, files in sections:
        if not files:
            continue
        out.append(f"\n# --- {title} ---")
        for f in files:
            out.append("../" + str(f.relative_to(ROOT)))
            n += 1

    (ASIC / "filelist.f").write_text("\n".join(out) + "\n")
    sync_config_yaml(sections)
    print(f"filelist.f: {n} kaynak dosya")
    for title, files in sections:
        if files:
            print(f"   {len(files):3d}  {title}")
    print(f"   ---\n   {len(EXCLUDED)} dosya bilerek disarida, {len(REPLACED)} dosya ASIC karsiligiyla degistirildi")


BEGIN = "# >>> OTOMATIK URETILEN BLOK -- asic/filelist.f (make filelist) <<<"
END = "# >>> OTOMATIK URETILEN BLOK SONU <<<"


def sync_config_yaml(sections):
    """config.yaml icindeki VERILOG_* bloklarini filelist.f ile esitler.

    Sartname (Bolum 4): "LibreLane yapilandirmasinda kullanilan RTL kaynaklari
    ile asic/filelist.f icerigi birbiriyle uyumlu olmalidir."  Iki listeyi de
    ayni yerden uretmek, ayrisma ihtimalini yapisal olarak ortadan kaldirir.
    """
    cfg = ASIC / "config.yaml"
    text = cfg.read_text()
    if BEGIN not in text or END not in text:
        sys.exit("HATA: config.yaml icinde otomatik blok isaretleri bulunamadi")

    incdirs, files = [], []
    for line in (ASIC / "filelist.f").read_text().splitlines():
        line = line.split("#", 1)[0].strip()
        if not line:
            continue
        if line.startswith("+incdir+"):
            incdirs.append(line[len("+incdir+"):])
        elif not line.startswith(("+", "-")):
            files.append(line)

    block = [BEGIN, "VERILOG_INCLUDE_DIRS:"]
    block += [f"  - dir::{d}" for d in incdirs]
    block.append("VERILOG_FILES:")
    for title, fl in sections:
        if not fl:
            continue
        block.append(f"  # --- {title} ---")
        for f in fl:
            block.append("  - dir::../" + str(f.relative_to(ROOT)))
    block.append(END)

    head = text.split(BEGIN)[0]
    tail = text.split(END, 1)[1]
    cfg.write_text(head + "\n".join(block) + tail)
    print(f"config.yaml esitlendi: {len(files)} VERILOG_FILES, {len(incdirs)} include dizini")


if __name__ == "__main__":
    main()
