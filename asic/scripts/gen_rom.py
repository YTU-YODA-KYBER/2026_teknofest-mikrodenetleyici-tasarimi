#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  gen_rom.py -- $readmemh hex dosyalarindan sentezlenebilir mask ROM uretir.
#
#  NEDEN?
#    ASIC'te Boot ROM, YZ agirlik ve bias ROM'lari KALICI belleklerdir; SRAM
#    makrosuna konamazlar (silikonda ilklendirilemezler). Karsiligi standart
#    hucrelerden orulen bir mask ROM'dur. Uretilen modul, orijinal RTL'in
#    `reg mem[..]` + `initial` yapisini birebir korur; boylece Yosys'in ROM
#    cikarimi (memory_map) devreye girer ve ABC icerigi mantiksal olarak
#    sikistirir (olculen: 128.000 bit -> 10.826 hucre, 0,065 mm²).
#
#    Duz `case` ifadesi yerine `initial` kullanilmasinin sebebi budur.
#
#  Ayrica $readmemh'in yol cozumu araca gore degisir (Yosys kaynak dosyaya,
#  XSim calisma dizinine gore cozer); icerigi RTL'e gomerek bu farki ortadan
#  kaldiriyoruz.
#
#  Kullanim: asic/Makefile icindeki `roms` hedefi cagirir.
# ---------------------------------------------------------------------------
import argparse
import hashlib
import pathlib
import sys


def read_hex(path: pathlib.Path, width_bits: int, depth: int):
    """$readmemh bicimindeki dosyayi {adres: deger} sozlugune cevirir."""
    words = {}
    addr = 0
    nibbles = width_bits // 4
    text = path.read_text()
    # // ve /* */ yorumlarini at
    out, i, in_block = [], 0, False
    while i < len(text):
        if in_block:
            if text.startswith("*/", i):
                in_block, i = False, i + 2
            else:
                i += 1
        elif text.startswith("/*", i):
            in_block, i = True, i + 2
        elif text.startswith("//", i):
            while i < len(text) and text[i] != "\n":
                i += 1
        else:
            out.append(text[i])
            i += 1
    for tok in "".join(out).split():
        if tok.startswith("@"):
            addr = int(tok[1:], 16)
            continue
        if addr >= depth:
            sys.exit(f"HATA: {path.name} icindeki adres {addr} >= derinlik {depth}")
        val = int(tok, 16)
        if val >= (1 << width_bits):
            sys.exit(f"HATA: {path.name}[{addr}] = {tok} genislige ({width_bits} bit) sigmiyor")
        words[addr] = val
        addr += 1
    return words, nibbles


HEADER = """// ---------------------------------------------------------------------------
//  {module} -- OTOMATIK URETILMIS DOSYA, ELLE DUZENLEME.
//
//  Ureten : asic/scripts/gen_rom.py
//  Kaynak : {src}
//  Kaynak SHA256 : {sha}
//  Icerik : {used} / {depth} kelime x {width} bit  ({bits} bit)
//
//  Kaynak hex'in SHA256'si BILEREK bu basliktadir: `gen_rom.py --all --check`
//  uretimi bellekte tekrarlayip diskteki dosyayla metin bazinda karsilastirir.
//  Boylece firmware/agirliklar yeniden uretildiginde ve `make roms`
//  unutuldugunda BAYAT bir ROM sessizce senteze giremez (patch_rtl.py'nin
//  yamali kopyalar icin yaptigi kontrolun ROM karsiligi).
//
//  Bu modul ASIC akisinda {orig} dosyasinin
//  yerine gecer (modul adi ve port listesi birebir aynidir). Icerik silikonda
//  mask ROM olarak standart hucrelerden orulur; SRAM makrosu KULLANILMAZ,
//  cunku bu bellek kalicidir ve guc verildiginde hazir olmalidir.
// ---------------------------------------------------------------------------
"""


def emit_initial(words, depth, width, nibbles, arr="mem", indent="        "):
    lines = []
    if len(words) < depth:
        lines.append(f"{indent}for (i = 0; i < {depth}; i = i + 1) {arr}[i] = {width}'h0;")
    for a in sorted(words):
        lines.append(f"{indent}{arr}[{a}] = {width}'h{words[a]:0{nibbles}X};")
    return "\n".join(lines)


def gen_boot_rom(words, depth, width, nibbles, src, orig, sha):
    body = emit_initial(words, depth, width, nibbles, arr="rom")
    return HEADER.format(module="boot_rom", src=src, sha=sha, used=len(words), depth=depth,
                         width=width, bits=len(words) * width, orig=orig) + f"""
module boot_rom #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10,
    parameter INIT_FILE  = "boot_code.mem"   // ASIC'te kullanilmaz, uyum icin korundu
)(
    input  logic                  clk,

    input  logic [ADDR_WIDTH-1:0] addr_a,
    output logic [DATA_WIDTH-1:0] rdata_a,

    input  logic [ADDR_WIDTH-1:0] addr_b,
    output logic [DATA_WIDTH-1:0] rdata_b
);
    localparam int DEPTH = 1 << ADDR_WIDTH;

    logic [DATA_WIDTH-1:0] rom [0:DEPTH-1];

    integer i;
    initial begin
{body}
    end

    // Iki bagimsiz senkron okuma portu (komut getirme + veri erisimi).
    always_ff @(posedge clk) begin
        rdata_a <= rom[addr_a];
        rdata_b <= rom[addr_b];
    end

endmodule
"""


def gen_rom_1p(module, words, depth, width, nibbles, addr_w, src, orig, sha):
    body = emit_initial(words, depth, width, nibbles, arr="mem")
    return HEADER.format(module=module, src=src, sha=sha, used=len(words), depth=depth,
                         width=width, bits=len(words) * width, orig=orig) + f"""
module {module} (
    input  wire                  clk,
    input  wire [{addr_w - 1}:0] addr,
    output reg  [{width - 1}:0] dout
);
    reg [{width - 1}:0] mem [0:{depth - 1}];

    integer i;
    initial begin
{body}
    end

    always @(posedge clk) begin
        dout <= mem[addr];
    end
endmodule
"""


KINDS = {
    "boot_rom":          dict(width=32, depth=256,  addr_w=8,  fn=gen_boot_rom),
    "weights_rom_p8":    dict(width=64, depth=80,   addr_w=7,  fn=gen_rom_1p),
    "fc_weights_rom_p4": dict(width=32, depth=4000, addr_w=12, fn=gen_rom_1p),
}


ASIC_DIR = pathlib.Path(__file__).resolve().parent.parent
ROOT     = ASIC_DIR.parent
FW_OUT   = ROOT / "FPGA/firmware/makefile_outputs"
AI_DIR   = ROOT / "FPGA/main_codes/rtl/desgin_sources/AI_Accelerator"
GEN_DIR  = ROOT / "asic_rtl/gen"

# Tek dogruluk kaynagi: hem `--all` uretimi hem `--all --check` bunu kullanir,
# boylece Makefile ile gen_rom.py'nin argumanlari ayrisamaz.
MANIFEST = [
    # ASIC mask ROM'u ASIC'E OZGU derlemeden gelir (asic_boot.hex), FPGA'nin
    # boot.hex'inden DEGIL. Sebep: UART bolucusu saat frekansindan turetilir
    # (soc.h: UART_CPB_115200 = f(SYS_CLK_HZ)); FPGA 50 MHz'te 434, ASIC
    # 25 MHz'te 217 kullanir. Tek bir hex paylasilsaydi taraflardan biri
    # mutlaka yanlis baud'a kayardi.
    #   uretim: cd FPGA/firmware && make asic
    # Iki hex ayni kaynaktan derlenir; yalnizca -DSYS_CLK_HZ farklidir ve
    # olculen fark 3 BAYTTIR (434 -> 217 anlik sabiti).
    dict(kind="boot_rom",
         hex=FW_OUT / "asic_boot.hex",
         out=GEN_DIR / "boot_rom_asic.sv",
         orig="Memory/BRAM_defines/boot_rom_def.sv"),
    dict(kind="weights_rom_p8",
         hex=AI_DIR / "weights_p8.hex",
         out=GEN_DIR / "weights_rom_p8_asic.v",
         orig="AI_Accelerator/weights_rom_p8.v"),
    dict(kind="fc_weights_rom_p4",
         hex=AI_DIR / "fc_weights_p4.hex",
         out=GEN_DIR / "fc_weights_rom_p4_asic.v",
         orig="AI_Accelerator/fc_weights_rom_p4.v"),
]


def render(kind: str, hexpath: pathlib.Path, orig: str):
    """Uretilecek dosya metnini DISKE YAZMADAN dondurur."""
    k = KINDS[kind]
    if not hexpath.is_file():
        sys.exit(f"HATA: hex dosyasi yok: {hexpath}")
    words, nib = read_hex(hexpath, k["width"], k["depth"])
    if not words:
        sys.exit(f"HATA: {hexpath} bos")
    sha = hashlib.sha256(hexpath.read_bytes()).hexdigest()
    if kind == "boot_rom":
        text = k["fn"](words, k["depth"], k["width"], nib, hexpath.name, orig, sha)
    else:
        text = k["fn"](kind, words, k["depth"], k["width"], nib, k["addr_w"],
                       hexpath.name, orig, sha)
    return text, words, k


def main():
    ap = argparse.ArgumentParser(description="hex -> sentezlenebilir mask ROM")
    ap.add_argument("--kind", choices=sorted(KINDS))
    ap.add_argument("--hex", type=pathlib.Path)
    ap.add_argument("--out", type=pathlib.Path)
    ap.add_argument("--orig", default="(orijinal RTL)")
    ap.add_argument("--all", action="store_true",
                    help="MANIFEST'teki butun ROM'lari isle")
    ap.add_argument("--check", action="store_true",
                    help="uretme, diskteki dosya guncel mi diye DOGRULA "
                         "(bayat ROM senteze girmesin)")
    a = ap.parse_args()

    if a.all:
        jobs = MANIFEST
    else:
        if not (a.kind and a.hex and a.out):
            sys.exit("HATA: --all verilmediyse --kind, --hex ve --out zorunludur")
        jobs = [dict(kind=a.kind, hex=a.hex, out=a.out, orig=a.orig)]

    stale = []
    for j in jobs:
        text, words, k = render(j["kind"], j["hex"], j["orig"])
        out = j["out"]
        if a.check:
            if not out.is_file():
                stale.append((out, "dosya yok"))
                continue
            if out.read_text() != text:
                stale.append((out, f"{j['hex'].name} ile uyumsuz (BAYAT)"))
                continue
            print(f"  {out.name:32s} <- {j['hex'].name:24s} guncel")
        else:
            out.parent.mkdir(parents=True, exist_ok=True)
            out.write_text(text)
            print(f"  {out.name:32s} <- {j['hex'].name:24s} "
                  f"{len(words)}/{k['depth']} kelime x {k['width']} bit")

    if stale:
        print("\nHATA: uretilen ROM'lar kaynak hex dosyalariyla uyumsuz:")
        for out, why in stale:
            print(f"  {out}  --  {why}")
        print("\nDuzeltme:  make roms      (veya: python3 scripts/gen_rom.py --all)")
        sys.exit(1)

    if a.check:
        print(f"  toplam {len(jobs)} ROM guncel")


if __name__ == "__main__":
    main()
