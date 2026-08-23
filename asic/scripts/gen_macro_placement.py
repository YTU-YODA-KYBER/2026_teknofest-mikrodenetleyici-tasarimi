#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  gen_macro_placement.py -- 15 SRAM makrosu icin elle floorplan yerlesimi uretir
#
#  CIKTI: asic/constraints/macro_placement.cfg
#         (LibreLane MACRO_PLACEMENT_CFG bicimi: "<instance> <x> <y> <yon>")
#
#  YERLESIM MANTIGI
#    * Makrolar DONDURULMEZ (yon N). SRAM'lerin guc pinleri met3 uzerinde YATAY
#      seritlerdir; PDN'in met4 DIKEY seritleri bunlari dik keserek baglanir.
#      90 derece dondurulurse ikisi paralel kalir ve makro guc baglantisi
#      guvenilmez hale gelir.
#    * Sinyal pinlerinin cogu makronun ALT ve UST kenarindadir (met4; 74 alt,
#      35 ust, 16 orta). Bu yuzden satirlar arasina genis YATAY kanallar
#      birakilir; sutunlar arasindaki bosluk dar tutulabilir.
#    * Ayni belleğe ait bankalar yan yana yerlestirilir; boylece banka secme
#      mantigi ve adres yollari kisa kalir.
#
#  Instance adlari sentezlenmis netlist'ten OKUNUR; elle yazilmaz.
# ---------------------------------------------------------------------------
import argparse
import pathlib
import re
import sys

ASIC = pathlib.Path(__file__).resolve().parent.parent

# --- geometri (mikron) ---
MACRO_W, MACRO_H = 683.10, 416.54      # sky130_sram_2kbyte_1rw1r_32x512_8
MACRO1K_W, MACRO1K_H = 479.78, 397.50  # sky130_sram_1kbyte_1rw1r_32x256_8
COL_GAP_DEF = 30.0                      # sutunlar arasi (yan kenarda pin yok)
ROW_GAP_DEF = 150.0                     # satirlar arasi (alt/ust pinler icin)
NCOL, NROW = 4, 4                       # "4x4" izgarasi (varsayilan)

# ---------------------------------------------------------------------------
#  NEDEN IKINCI BIR IZGARA VAR?  ("3x5")
#
#  SRAM makrolarinin LEF'i met1 ve met2'yi TAMAMEN, met3 ve met4'u ise %98
#  oraninda kapatir; makro uzerinde kesintisiz tek bir dikey sutun ya da yatay
#  satir yoktur. Serbest kalan tek katman met5'tir ve o da YATAYdir.
#
#  Sonuc: SKY130'da dikey yonlu iki katman (met2, met4) makro uzerinden HIC
#  gecemez. Butun dikey trafik makrolar ARASINDAKI sutun kanallarina sikisir.
#  4x4 izgarada bu kanallarin toplami 3 x 120 + 2 x 204 = 768 um idi; die 3500
#  um genis oldugu halde dikey yollamaya ayrilan pay %22'de kaliyordu ve global
#  routing met2'de tikaniyordu (kullanim yalnizca %52 iken 72.909 overflow --
#  yani darbogaz genel kaynak degil, YEREL kanal genisligiydi).
#
#  "3x5" izgarasi ayni 15 makroyu 3 sutun x 5 satira dizer: sutun sayisi azalir,
#  aradaki kanallar genisler (768 -> ~1450 um, +%89). Karsiliginda satir
#  kanallari daralir, ama yatay katmanlarin (met1/met3) yaninda met5 makro
#  uzerinden serbest gectigi icin bu tarafta kacis yolu vardir.
#  Die BUYUTULMEZ -- daha once die buyutmek tel uzunlugunu artirip overflow'u
#  kotulestirmisti (3600x3200 denemesi: 257.887).
# ---------------------------------------------------------------------------
NCOL_3X5, NROW_3X5 = 3, 5

# ---------------------------------------------------------------------------
#  YERLESIM: her bellegin bankalari 2x2 KUME olarak bitisik yerlestirilir.
#
#  NEDEN ONEMLI?  Her bellek bloğunun 32-bit veri yolu, 9-bit adresi, bayt
#  maskesi ve kontrol sinyalleri TEK bir AXI denetleyicisinde toplanir. Bankalar
#  die'in genisligine yayilirsa (ilk denemelerde oyleydi: bankalar 2,4 mm
#  arayla) bu yollar cipin ustunden gecen devasa bir tel yildizina donusur ve
#  global routing tikanir. Bankalari 2x2 kume yapmak, denetleyicinin kumeye
#  bitisik yerlestirilmesine ve yollarin kisa kalmasina izin verir.
#
#  Izgara konumu (sutun, satir); (3,3) bos birakilir.
# ---------------------------------------------------------------------------
PLACEMENT = [
    # --- Instruction RAM: sol-alt 2x2 kume ---
    ("instr_bram_ctrl_inst.instr_ram.u_mem.g_2k[0].u_cell.u_sram", 0, 0),
    ("instr_bram_ctrl_inst.instr_ram.u_mem.g_2k[1].u_cell.u_sram", 1, 0),
    ("instr_bram_ctrl_inst.instr_ram.u_mem.g_2k[2].u_cell.u_sram", 0, 1),
    ("instr_bram_ctrl_inst.instr_ram.u_mem.g_2k[3].u_cell.u_sram", 1, 1),
    # --- Data RAM: sag-alt 2x2 kume ---
    ("data_bram_ctrl_inst.data_ram.u_mem.g_2k[0].u_cell.u_sram", 2, 0),
    ("data_bram_ctrl_inst.data_ram.u_mem.g_2k[1].u_cell.u_sram", 3, 0),
    ("data_bram_ctrl_inst.data_ram.u_mem.g_2k[2].u_cell.u_sram", 2, 1),
    ("data_bram_ctrl_inst.data_ram.u_mem.g_2k[3].u_cell.u_sram", 3, 1),
    # --- YZ girdi RAM'i: sol-ust 2x2 kume + 1 KB makro ---
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_2k[0].u_cell.u_sram", 0, 2),
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_2k[1].u_cell.u_sram", 1, 2),
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_2k[2].u_cell.u_sram", 0, 3),
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_2k[3].u_cell.u_sram", 1, 3),
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_1k.u_cell.u_sram",    2, 3),
    # --- Konvolusyon tamponu: YZ kumesine bitisik ---
    ("conv_accelerator_inst.u_conv_buf_ram.u_mem.u_mem.g_2k[0].u_cell.u_sram", 2, 2),
    ("conv_accelerator_inst.u_conv_buf_ram.u_mem.u_mem.g_2k[1].u_cell.u_sram", 3, 2),
]
# 3x5 izgarasi icin yerlesim. IMEM ve DMEM 2x2 kume olarak korunur (CPU'nun
# kritik yollari); conv tamponunun iki bankasi yan yana kalir. YZ girdi RAM'i
# 5 bankasiyla tek sutuna dizilir -- 3 sutunlu izgarada bir bellek zorunlu
# olarak dikey yigin olur ve bunun icin en uygunu YZ RAM'dir: hizlandirici
# oraya cevrim basina tek kelime erisir, CPU'nun kritik yolunda degildir.
PLACEMENT_3X5 = [
    # --- Instruction RAM: sol-alt 2x2 kume ---
    ("instr_bram_ctrl_inst.instr_ram.u_mem.g_2k[0].u_cell.u_sram", 0, 0),
    ("instr_bram_ctrl_inst.instr_ram.u_mem.g_2k[1].u_cell.u_sram", 1, 0),
    ("instr_bram_ctrl_inst.instr_ram.u_mem.g_2k[2].u_cell.u_sram", 0, 1),
    ("instr_bram_ctrl_inst.instr_ram.u_mem.g_2k[3].u_cell.u_sram", 1, 1),
    # --- Data RAM: sol-orta 2x2 kume ---
    ("data_bram_ctrl_inst.data_ram.u_mem.g_2k[0].u_cell.u_sram", 0, 2),
    ("data_bram_ctrl_inst.data_ram.u_mem.g_2k[1].u_cell.u_sram", 1, 2),
    ("data_bram_ctrl_inst.data_ram.u_mem.g_2k[2].u_cell.u_sram", 0, 3),
    ("data_bram_ctrl_inst.data_ram.u_mem.g_2k[3].u_cell.u_sram", 1, 3),
    # --- Konvolusyon tamponu: ust satirda yan yana ---
    ("conv_accelerator_inst.u_conv_buf_ram.u_mem.u_mem.g_2k[0].u_cell.u_sram", 0, 4),
    ("conv_accelerator_inst.u_conv_buf_ram.u_mem.u_mem.g_2k[1].u_cell.u_sram", 1, 4),
    # --- YZ girdi RAM'i: sag sutun (5 banka dikey yigin) ---
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_2k[0].u_cell.u_sram", 2, 0),
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_2k[1].u_cell.u_sram", 2, 1),
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_2k[2].u_cell.u_sram", 2, 2),
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_2k[3].u_cell.u_sram", 2, 3),
    ("yz_bram_ctrl_inst.yz_ram.u_mem.u_mem.g_1k.u_cell.u_sram",    2, 4),
]




def netlist_instances(nl: pathlib.Path):
    txt = nl.read_text()
    found = {}
    for cell, inst in re.findall(r"^\s*(sky130_sram_\w+)\s+\\(\S+)\s*\(", txt, re.M):
        found[inst] = cell
    return found


def die_from_config():
    """DIE_AREA'yi config.yaml'dan okur -- elle yazilan varsayilan kayardi."""
    cfg = ASIC / "config.yaml"
    m = re.search(r"^DIE_AREA:\s*\[([^\]]*)\]", cfg.read_text(), re.M)
    if not m:
        sys.exit("HATA: config.yaml icinde DIE_AREA bulunamadi")
    x0, y0, x1, y1 = [float(v) for v in m.group(1).split(",")]
    return x1 - x0, y1 - y0


def main():
    ap = argparse.ArgumentParser()
    dw, dh = die_from_config()
    ap.add_argument("--netlist", required=True, type=pathlib.Path)
    ap.add_argument("--grid", choices=("4x4", "3x5"), default="3x5",
                    help="makro izgarasi; 3x5 dikey kanallari genisletir")
    ap.add_argument("--die-width", type=float, default=dw)
    ap.add_argument("--die-height", type=float, default=dh)
    ap.add_argument("--col-gap", type=float, default=None,
                    help="sutunlar arasi bosluk (um); varsayilan izgaradan")
    ap.add_argument("--row-gap", type=float, default=None,
                    help="satirlar arasi yollama kanali (um)")
    ap.add_argument("--out", type=pathlib.Path,
                    default=ASIC / "constraints" / "macro_placement.cfg")
    a = ap.parse_args()

    # Izgaraya gore harita + varsayilan kanal genislikleri
    if a.grid == "3x5":
        PLACE, NC, NR = PLACEMENT_3X5, NCOL_3X5, NROW_3X5
        col_gap = 400.0 if a.col_gap is None else a.col_gap
        row_gap = 150.0 if a.row_gap is None else a.row_gap
    else:
        PLACE, NC, NR = PLACEMENT, NCOL, NROW
        col_gap = COL_GAP_DEF if a.col_gap is None else a.col_gap
        row_gap = ROW_GAP_DEF if a.row_gap is None else a.row_gap

    found = netlist_instances(a.netlist)
    if not found:
        sys.exit(f"HATA: {a.netlist} icinde SRAM makrosu bulunamadi")

    wanted = [inst for inst, _, _ in PLACE]
    missing = [w for w in wanted if w not in found]
    extra = [f for f in found if f not in wanted]
    if missing or extra:
        sys.exit(f"HATA: netlist ile beklenen makro listesi uyusmuyor\n"
                 f"  eksik: {missing}\n  fazla: {extra}")

    # Izgara: sol-alttan baslar, once sutunlar dolar
    COL_GAP, ROW_GAP = col_gap, row_gap
    block_w = NC * MACRO_W + (NC - 1) * COL_GAP
    block_h = NR * MACRO_H + (NR - 1) * ROW_GAP
    x0 = round((a.die_width - block_w) / 2, 2)
    y0 = round((a.die_height - block_h) / 2, 2)
    if x0 < 0 or y0 < 0:
        sys.exit(f"HATA: die ({a.die_width} x {a.die_height}) makro blogunu "
                 f"({block_w:.1f} x {block_h:.1f}) almiyor")

    lines = [
        "# ------------------------------------------------------------------",
        "#  SKY130 SRAM makro yerlesimi -- OTOMATIK URETILMIS",
        "#  Ureten: asic/scripts/gen_macro_placement.py",
        f"#  Die: {a.die_width} x {a.die_height} um",
        f"#  Makro blogu: {block_w:.2f} x {block_h:.2f} um, sol-alt ({x0}, {y0})",
        f"#  Izgara: {NC} sutun x {NR} satir; kanal payi asagida.",
        f"#  Sutun araligi {COL_GAP} um -> dikey kanal toplami "
        f"{(NC - 1) * COL_GAP + 2 * x0:.0f} um",
        f"#  Satir araligi {ROW_GAP} um -> yatay kanal toplami "
        f"{(NR - 1) * ROW_GAP + 2 * y0:.0f} um",
        "#  (met2/met4 makro uzerinden GECEMEZ; dikey kanal genisligi global",
        "#   routing'in gercek darbogazidir -- ayrintisi bu dosyanin ureteci",
        "#   gen_macro_placement.py basindaki aciklamada.)",
        "#  Yon: hepsi N -- makro guc pinleri (met3, yatay) PDN'in met4 dikey",
        "#       seritleriyle dik kesissin diye dondurulmemistir.",
        "# ------------------------------------------------------------------",
    ]
    for inst, col, row in PLACE:
        x = round(x0 + col * (MACRO_W + COL_GAP), 2)
        y = round(y0 + row * (MACRO_H + ROW_GAP), 2)
        lines.append(f"{inst} {x} {y} N")

    a.out.parent.mkdir(parents=True, exist_ok=True)
    a.out.write_text("\n".join(lines) + "\n")
    print(f"{a.out.name}: {len(wanted)} makro, die {a.die_width} x {a.die_height} um")
    print(f"  makro blogu {block_w:.1f} x {block_h:.1f} um  @ ({x0}, {y0})")
    macro_area = 14 * MACRO_W * MACRO_H + 1 * MACRO1K_W * MACRO1K_H
    die_area = a.die_width * a.die_height
    print(f"  makro alani {macro_area/1e6:.3f} mm² / die {die_area/1e6:.3f} mm² "
          f"= %{100*macro_area/die_area:.1f}")
    print(f"  std hucrelere kalan: {(die_area-macro_area)/1e6:.3f} mm²")


if __name__ == "__main__":
    main()
