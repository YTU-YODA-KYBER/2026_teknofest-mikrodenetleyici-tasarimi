#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  run_asic_sim.py -- ASIC yapilandirmasinin islevsel dogrulamasi (XSim)
#
#  NE YAPAR?
#    asic/filelist.f'teki RTL'i -- yani SKY130 SRAM makrolari ve mask ROM'larla
#    kurulmus SoC'yi -- mevcut sistem testbench'leriyle simule eder. Boylece
#    sartname Bolum 1.3'un "zorunlu SRAM makrosu ... islevsel dogrulama
#    testlerinde kullanilmalidir" sarti sistem seviyesinde karsilanir.
#
#  TESTLER
#    collision       : tb_data_bram_collision -- DATA SRAM DMA/AXI cakisma
#                                                ve backpressure kosullari
#    instr_collision : tb_instr_bram_collision -- IMEM DMA cakismasi ile iki
#                                                 master read arbitraji
#    mem   : tb_asic_mem_equiv   -- ASIC bellek sarmalayicilarinin orijinal FPGA
#                                   modulleriyle bit-bit esdegerligi
#    boot  : boot_test           -- Boot ROM'dan acilis, QSPI flash'tan uygulamayi
#                                   Instruction RAM'e yukleme (IMEM SRAM'i surer)
#    yz    : ai_accel_test       -- YZ hizlandirici cikarimi (YZ girdi RAM'i ve
#                                   konvolusyon tamponu SRAM'lerini surer)
#
#  BOOT ROM ICERIGI HAKKINDA
#    ASIC'te Boot ROM bir mask ROM'dur; icerigi sentez aninda RTL'e gomulur.
#    Sistem testleri (FPGA akisinda oldugu gibi) kart firmware'i yerine
#    simulasyon firmware'ini ister (sim_boot.hex / sim_app.hex). Bu betik o
#    testler icin gecici bir ROM varyanti uretir; DONANIM yapisi birebir
#    aynidir, yalnizca gomulu firmware farklidir. Teslim edilen GDSII'de kart
#    firmware'i (boot.hex) gomuludur.
# ---------------------------------------------------------------------------
import argparse
import os
import pathlib
import shutil
import subprocess
import sys
import json
import re

ASIC = pathlib.Path(__file__).resolve().parent.parent
ROOT = ASIC.parent
FPGA = ROOT / "FPGA"
TB = FPGA / "main_codes/testbench"


def uart_cpb_from_config(baud: int = 115200) -> int:
    """config.yaml'daki CLOCK_PERIOD'dan beklenen UART bolucusunu turetir.

    FPGA/firmware/soc.h icindeki UART_CPB_FOR() ile AYNI formuldur:
        CPB = (f + baud/2) / baud        (en yakina yuvarlama)

    NEDEN BURADA?  Firmware bolucuyu SYS_CLK_HZ'den turetir ve ASIC derlemesi
    -DSYS_CLK_HZ ile ezilir (FPGA/firmware/Makefile: asic_boot / asic_app).
    Testbench tarafinda sabit bir sayi yazili kalirsa periyot degistiginde
    ikisi sessizce ayrisir ve YZ testinin dogrulama assertion'i yanlis
    gerekceyle patlar. Tek dogruluk kaynagi config.yaml'dir.
    """
    cfg = (ASIC / "config.yaml").read_text()
    m = re.search(r"^CLOCK_PERIOD:\s*([\d.]+)\s*$", cfg, re.M)
    if not m:
        sys.exit("HATA: config.yaml icinde CLOCK_PERIOD bulunamadi")
    f_hz = 1e9 / float(m.group(1))
    return int((f_hz + baud / 2) // baud)
FW = FPGA / "firmware/makefile_outputs"
AI = FPGA / "main_codes/rtl/desgin_sources/AI_Accelerator"
# `make asic_sim` Vivado xsim (xvlog/xelab) kullanir. Kurulum yolu makineye
# ozgudur, bu yuzden depoda SABIT bir mutlak yol tutulmaz (sartname Bolum 4);
# yol yalnizca VIVADO_ROOT ortam degiskeniyle verilir.
VIVADO = pathlib.Path(os.environ["VIVADO_ROOT"]) if os.environ.get("VIVADO_ROOT") else None

sys.path.insert(0, str(ASIC / "scripts"))
from filelist import parse  # noqa: E402

TESTS = {
    "collision": dict(
        top="tb_data_bram_collision",
        rtl_from_filelist=False,
        rtl=[ROOT / "asic_rtl/mem/sram32_cell.sv",
             ROOT / "asic_rtl/mem/sram32_bank.sv",
             ROOT / "asic_rtl/mem/bram_data_asic.sv",
             ROOT / "asic_rtl/patched/data_bram_axi_ctrl_asic.sv"],
        extra=[ROOT / "asic_rtl/testbench/tb_data_bram_collision.sv"],
        hexes=[], ai_hexes=[], boot_hex=None,
    ),
    "instr_collision": dict(
        top="tb_instr_bram_collision",
        rtl_from_filelist=False,
        rtl=[ROOT / "asic_rtl/tech/axi_read_arbiter2.sv",
             ROOT / "asic_rtl/mem/sram32_cell.sv",
             ROOT / "asic_rtl/mem/sram32_bank.sv",
             ROOT / "asic_rtl/mem/bram_instr_asic.sv",
             ROOT / "asic_rtl/patched/instr_bram_axi_ctrl_asic.sv"],
        extra=[ROOT / "asic_rtl/testbench/tb_instr_bram_collision.sv"],
        hexes=[], ai_hexes=[], boot_hex=None,
    ),
    "mem": dict(
        top="tb_asic_mem_equiv",
        rtl_from_filelist=False,
        extra=[ROOT / "asic_rtl/testbench/tb_asic_mem_equiv.sv"],
        hexes=["boot.hex"],
        ai_hexes=["weights_p8.hex", "fc_weights_p4.hex"],
        boot_hex=None,
    ),
    "boot": dict(
        top="boot_test",
        rtl_from_filelist=True,
        extra=[TB / "AXI_protocol_check/axi_chk_pkg.sv",
               TB / "AXI_protocol_check/axi4lite_protocol_checker.sv",
               TB / "Peripherals/QSPI/Micron_sim_model.v",
               TB / "System_Test/boot_test.sv"],
        incdirs=[TB / "AXI_protocol_check"],
        hexes=[],
        ai_hexes=["weights_p8.hex", "fc_weights_p4.hex", "biases.hex", "fc_biases.hex"],
        boot_hex="asic_sim_boot.hex",
    ),
    "yz": dict(
        top="ai_accel_test",
        rtl_from_filelist=True,
        extra=[TB / "AXI_protocol_check/axi_chk_pkg.sv",
               TB / "AXI_protocol_check/axi4lite_protocol_checker.sv",
               TB / "System_Test/ai_accel_test.sv"],
        incdirs=[TB / "AXI_protocol_check"],
        hexes=[],
        ai_hexes=["weights_p8.hex", "fc_weights_p4.hex", "biases.hex", "fc_biases.hex"],
        sound=True,
        boot_hex="asic_sim_app.hex",
    ),
}

PASS_MARKERS = {
    "collision": ("SONUC: BASARILI",),
    "instr_collision": ("SONUC: BASARILI",),
    "mem":  ("SONUC: BASARILI",),
    "boot": ("TAM SISTEM TESTI: BASARILI", "SONUC                      : GECTI"),
    "yz":   ("YZ HIZLANDIRICI TESTI: BASARILI", "SONUC                      : GECTI"),
}

SRAM_MODELS = [
    "sky130_sram_2kbyte_1rw1r_32x512_8.v",
    "sky130_sram_1kbyte_1rw1r_32x256_8.v",
]


def run(cmd, cwd, log):
    print(f"    $ {' '.join(str(c) for c in cmd[:3])} …")
    with open(log, "w") as f:
        r = subprocess.run(cmd, cwd=cwd, stdout=f, stderr=subprocess.STDOUT, text=True)
    return r.returncode


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("test", choices=sorted(TESTS))
    ap.add_argument("--work", type=pathlib.Path,
                    default=pathlib.Path(os.environ.get("ASIC_SIM_DIR",
                                                        str(ASIC / "run/sim"))))
    ap.add_argument("--report-dir", type=pathlib.Path,
                    help="tamamlanan test loglarini kalici rapor agacina kopyala")
    ap.add_argument("--real-uart", action="store_true",
                    help="YZ testinde gercek 434 clk/bit kullan (varsayilan: dogruladiktan sonra 16 clk/bit)")
    a = ap.parse_args()
    t = TESTS[a.test]

    # Betik Makefile disindan da kullanilabilir. Bu durumda stale bir generated
    # RTL kopyasini sessizce test etmek, gercekte akisa girecek kaynakla PASS
    # logunun ayrismasina yol acar; simulasyondan once kaynak hash'lerini denetle.
    patch_check = subprocess.run(
        [sys.executable, str(ASIC / "scripts/patch_rtl.py"), "--check"],
        cwd=ASIC,
    )
    if patch_check.returncode != 0:
        sys.exit("HATA: yamali RTL guncel degil; once `make vendor` calistirin.")

    if VIVADO is None:
        sys.exit("HATA: `make asic_sim` Vivado xsim gerektirir.\n"
                 "      Vivado kurulum dizinini VIVADO_ROOT ile verin, orn:\n"
                 "      export VIVADO_ROOT=/opt/Xilinx/Vivado/2025.2")
    settings = VIVADO / "settings64.sh"
    if not settings.is_file():
        sys.exit(f"HATA: Vivado bulunamadi: {settings}\n"
                 f"      VIVADO_ROOT dogru kurulum dizinini gostermeli.")

    w = a.work / a.test
    if w.exists():
        shutil.rmtree(w)
    w.mkdir(parents=True)

    # --- yardimci veri dosyalari calisma dizinine ---
    for h in t.get("ai_hexes", []):
        shutil.copy2(AI / h, w)
    for h in t.get("hexes", []):
        # boot.hex ozel: `mem` esdegerlik testi bunu ALTIN REFERANS olarak
        # $readmemh eder ve uretilen boot_rom_asic.sv ile karsilastirir. O ROM
        # artik ASIC derlemesinden (asic_boot.hex) uretiliyor -- FPGA'ninkinden
        # UART bolucusu kadar farklidir (50 MHz -> 434, 25 MHz -> 217).
        # FPGA hex'i referans birakilirsa test bu KASITLI farki hata sayar:
        #   boot_rom.b beklenen=0x1b200713 (addi a4,x0,434)
        #                alinan=0x0d900713 (addi a4,x0,217)
        # Bu yuzden ayni ada ASIC hex'i kopyalanir; boylece esdegerlik testi
        # ASIC ROM'unu ASIC kaynagiyla karsilastirir.
        if h == "boot.hex" and (FW / "asic_boot.hex").is_file():
            shutil.copy2(FW / "asic_boot.hex", w / "boot.hex")
        else:
            shutil.copy2(FW / h, w)
    if t.get("sound"):
        for s in ("input_data_yes.hex", "input_data_no.hex", "input_data_sessizlik.hex"):
            p = FPGA / "firmware/sound_samples" / s
            if p.is_file():
                shutil.copy2(p, w)

    # --- RTL listesi ---
    incdirs, files = parse()
    sram_dir = pathlib.Path(os.environ["PDK_ROOT"]) / "sky130A/libs.ref/sky130_sram_macros/verilog"
    v_models = [sram_dir / m for m in SRAM_MODELS]

    if t["rtl_from_filelist"]:
        rtl = list(files)
        # Boot ROM icerigini simulasyon firmware'i ile degistir
        if t.get("boot_hex"):
            gen = w / "boot_rom_sim.sv"
            #  Simulasyon ROM'u 4KB'dir: "uygulamayi boot ROM'dan kostur"
            #  senaryosunda imaj (softmax exp tablosuyla birlikte) 1KB'i asar.
            #  Silikona giden boot ROM buradan ETKILENMEZ; o gen_rom.py --all
            #  ile varsayilan 256 kelime derinliginde uretilir.
            subprocess.run([sys.executable, str(ASIC / "scripts/gen_rom.py"),
                            "--kind", "boot_rom",
                            "--hex", str(FW / t["boot_hex"]),
                            "--out", str(gen),
                            "--depth", "1024",
                            "--orig", "Memory/BRAM_defines/boot_rom_def.sv"],
                           check=True, stdout=subprocess.DEVNULL)
            rtl = [gen if p.name == "boot_rom_asic.sv" else p for p in rtl]
    else:
        AS = ROOT / "asic_rtl"
        rtl = t.get("rtl") or [AS / f for f in (
            "mem/sram32_cell.sv", "mem/sram32_cell_1k.sv",
            "mem/sram32_bank.sv", "mem/sram8_bank.sv",
            "gen/boot_rom_asic.sv", "gen/weights_rom_p8_asic.v",
            "gen/fc_weights_rom_p4_asic.v")]

    # (yardimci asagida tanimli)
    # YZ sistem testi gercek 115200-baud zamanlamasiyla 3 x 1960 bayt yollar;
    # bu, olay-gudumlu RTL simulasyonunda saatler surer. Varsayilan hizli mod
    # once firmware'in UART_CPB register'ini dogru 434 degerine kurdugunu
    # KONTROL EDER, sonra sadece test boyunca DUT register'i ve TB gondericisini
    # birlikte 16 clk/bit'e alir. UART cercevesi, alici durum makinesi, DMA,
    # SRAM yazimlari, kesmeler ve cikarim yolu atlanmaz.
    # Beklenen UART bolucusu SABIT DEGILDIR -- firmware onu saat frekansindan
    # turetir (FPGA/firmware/soc.h: UART_CPB_115200 = (f + baud/2) / baud).
    # Burada AYNI formul config.yaml'daki CLOCK_PERIOD'dan yeniden hesaplanir,
    # boylece periyot degistiginde testbench ile firmware ayrisamaz.
    #   50 ns -> 20 MHz -> 174     40 ns -> 25 MHz -> 217
    #  Iki UART farkli hizda kosar: YZ veri akisi 1 Mbps, genel UART 115200.
    #  Ikisinin de bolucusu ayni formulden turetilir.
    expected_yz_cpb = uart_cpb_from_config(1000000)
    expected_gu_cpb = uart_cpb_from_config(115200)

    extra = list(t["extra"])
    fast_uart = a.test == "yz" and not a.real_uart
    if fast_uart:
        src = TB / "System_Test/ai_accel_test.sv"
        text = src.read_text()
        text, n_yz = re.subn(
            r"localparam int\s+YZ_CLKS_PER_BIT\s*=\s*\d+\s*;",
            "localparam int  YZ_CLKS_PER_BIT = 16; // ASIC_SIM hizli UART",
            text,
            count=1,
        )
        text, n_gu = re.subn(
            r"localparam int\s+GU_CLKS_PER_BIT\s*=\s*\d+\s*;",
            "localparam int  GU_CLKS_PER_BIT = 16; // ASIC_SIM hizli UART",
            text,
            count=1,
        )
        anchor = "        if (dut.uart_yz_inst.UART_CPB != YZ_CLKS_PER_BIT)\n"
        injection = (
            f"        if (dut.uart_yz_inst.UART_CPB != {expected_yz_cpb})\n"
            f"            $fatal(1, \"[TB] Firmware UART_YZ_CPB=%0d kurdu; beklenen gercek deger {expected_yz_cpb}\",\n"
            "                   dut.uart_yz_inst.UART_CPB);\n"
            f"        if (dut.uart_gu_inst.UART_CPB != {expected_gu_cpb})\n"
            f"            $fatal(1, \"[TB] Firmware UART_GU_CPB=%0d kurdu; beklenen gercek deger {expected_gu_cpb}\",\n"
            "                   dut.uart_gu_inst.UART_CPB);\n"
            f"        $display(\"[TB] ASIC_SIM: UART_YZ {expected_yz_cpb} / UART_GU {expected_gu_cpb} -> %0d clk/bit hizlandiriliyor\",\n"
            "                 YZ_CLKS_PER_BIT);\n"
            "        dut.uart_yz_inst.UART_CPB = YZ_CLKS_PER_BIT;\n"
            "        dut.uart_gu_inst.UART_CPB = GU_CLKS_PER_BIT;\n\n"
            + anchor
        )
        if n_yz != 1 or n_gu != 1 or text.count(anchor) != 1:
            sys.exit("HATA: ai_accel_test.sv hizli-UART donusum kalibi eslesmedi")
        text = text.replace(anchor, injection, 1)
        text = text.replace(
            "YZ UART: %0d clk/bit (1 Mbps)  |  genel UART: %0d clk/bit (115200)",
            "YZ UART: %0d clk/bit  |  genel UART: %0d clk/bit (ASIC_SIM hizli mod)",
            1,
        )
        fast_tb = w / "ai_accel_test_fast_uart.sv"
        fast_tb.write_text(text)
        extra = [fast_tb if p == src else p for p in extra]

    # --- boot testi: TB'nin UART bolucusunu ASIC frekansina hizala -----------
    # boot_test.sv `localparam int CPB` degerini SABIT tasir (FPGA'nin 50 MHz'i
    # icin secilmisti). ASIC mask ROM'u artik ASIC frekansindan turetilmis
    # boluce kuruyor (asic_boot.hex); TB sabit kalirsa gonderici ile alici
    # ayrisir ve test islevsel bir hata olmadigi halde patlar.
    #
    # Kaynak testbench DEGISTIRILMEZ; yalnizca bu kosum icin calisma dizinine
    # yamali bir kopya yazilir -- yz testindeki hizli-UART kalibiyla ayni yontem.
    if a.test == "boot":
        bsrc = TB / "System_Test/boot_test.sv"
        btext = bsrc.read_text()
        btext, n_b = re.subn(
            r"(localparam int\s+CPB\s*=\s*)\d+(\s*;)",
            rf"\g<1>{expected_gu_cpb}\g<2>",
            btext,
            count=1,
        )
        if n_b != 1:
            sys.exit("HATA: boot_test.sv icinde 'localparam int CPB' kalibi eslesmedi")
        btb = w / "boot_test_asic_cpb.sv"
        btb.write_text(btext)
        extra = [btb if p == bsrc else p for p in extra]
        print(f"    boot TB UART bolucusu {expected_gu_cpb} clk/bit'e hizalandi "
              f"(config.yaml CLOCK_PERIOD'dan turetildi)")

    inc_args = []
    for d in list(incdirs) + [pathlib.Path(p) for p in t.get("incdirs", [])]:
        inc_args += ["-i", str(d)]

    sh = f"source {settings} >/dev/null && "
    logs = w / "logs"
    logs.mkdir()

    print(f"\n=== ASIC islevsel simulasyon: {a.test}  ({t['top']}) ===")
    print(f"    calisma dizini: {w}")

    steps = [
        ("1-sram-modelleri",
         ["bash", "-c", sh + "xvlog --relax " + " ".join(f'"{p}"' for p in v_models)]),
        ("2-rtl",
         ["bash", "-c", sh + "xvlog -sv --relax -d SRAM_SIM -d SRAM_ASSERTIONS -d AXI_ASSERTIONS " +
          " ".join(inc_args) + " " + " ".join(f'"{p}"' for p in rtl)]),
        ("3-testbench",
         ["bash", "-c", sh + "xvlog -sv --relax -d SRAM_SIM -d SRAM_ASSERTIONS -d AXI_ASSERTIONS " +
          " ".join(inc_args) + " " + " ".join(f'"{p}"' for p in extra)]),
        ("4-elaborate",
         ["bash", "-c", sh + f"xelab --relax -mt off -debug off {t['top']} -s sim_top"]),
        ("5-simule",
         ["bash", "-c", sh + "xsim sim_top -runall"]),
    ]
    for name, cmd in steps:
        log = logs / f"{name}.log"
        rc = run(cmd, w, log)
        if rc != 0:
            print(f"\n  ADIM BASARISIZ: {name}  (kod {rc})")
            print(f"  --- {log} son satirlar ---")
            print("\n".join(pathlib.Path(log).read_text().splitlines()[-25:]))
            return rc

    out = (logs / "5-simule.log").read_text()
    print("\n--- simulasyon ciktisi (ozet) ---")
    keep = [l for l in out.splitlines()
            if any(k in l for k in ("SONUC", "BASARILI", "BASARISIZ", "PASS", "FAIL",
                                    "HATA", "ERROR", "Fatal", "YZ:", "ihlal", "$finish"))]
    print("\n".join(keep[-40:]) or out[-2000:])
    # NOT: SRAM_ASSERTIONS / AXI_ASSERTIONS derleme sirasinda TANIMLANIR
    # (bkz. yukaridaki xvlog adimlari). Onceden hicbir yerde tanimlanmadigi
    # icin sram32_bank ve axi_read_arbiter2 icindeki assertion'lar OLU KODDU
    # ve regresyon ayni-adres cakismasini / cift-grant hatasini yakalayamiyordu.
    # "Error:" XSim'in $error/$fatal ciktisinin onekidir.
    bad_tokens = ("BASARISIZ", "FAIL", "Fatal", "ERROR:", "HATA:",
                  "simultaneously!", "Error:")
    bad = any(k in out for k in bad_tokens)
    missing = [m for m in PASS_MARKERS[a.test] if m not in out]
    if missing:
        print("  HATA: beklenen basari isaretleri bulunamadi: " + ", ".join(missing))
        bad = True
    print(f"\n=== {a.test}: {'BASARISIZ' if bad else 'BASARILI'} ===")

    if a.report_dir is not None:
        dst = a.report_dir / a.test
        if dst.exists():
            shutil.rmtree(dst)
        dst.mkdir(parents=True)
        shutil.copytree(logs, dst / "logs")
        (dst / "result.json").write_text(json.dumps({
            "test": a.test,
            "top": t["top"],
            "passed": not bad,
            "required_markers": list(PASS_MARKERS[a.test]),
            "missing_markers": missing,
            "fast_uart": fast_uart,
        }, indent=2, ensure_ascii=False) + "\n")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
