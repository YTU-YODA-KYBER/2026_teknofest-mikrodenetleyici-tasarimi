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
//  Icerik : {used} / {depth} kelime x {width} bit  ({bits} bit)
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


def gen_boot_rom(words, depth, width, nibbles, src, orig):
    body = emit_initial(words, depth, width, nibbles, arr="rom")
    return HEADER.format(module="boot_rom", src=src, used=len(words), depth=depth,
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


def gen_rom_1p(module, words, depth, width, nibbles, addr_w, src, orig):
    body = emit_initial(words, depth, width, nibbles, arr="mem")
    return HEADER.format(module=module, src=src, used=len(words), depth=depth,
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


def main():
    ap = argparse.ArgumentParser(description="hex -> sentezlenebilir mask ROM")
    ap.add_argument("--kind", required=True, choices=sorted(KINDS))
    ap.add_argument("--hex", required=True, type=pathlib.Path)
    ap.add_argument("--out", required=True, type=pathlib.Path)
    ap.add_argument("--orig", default="(orijinal RTL)")
    a = ap.parse_args()

    k = KINDS[a.kind]
    if not a.hex.is_file():
        sys.exit(f"HATA: hex dosyasi yok: {a.hex}")
    words, nib = read_hex(a.hex, k["width"], k["depth"])
    if not words:
        sys.exit(f"HATA: {a.hex} bos")

    if a.kind == "boot_rom":
        text = k["fn"](words, k["depth"], k["width"], nib, a.hex.name, a.orig)
    else:
        text = k["fn"](a.kind, words, k["depth"], k["width"], nib, k["addr_w"], a.hex.name, a.orig)

    a.out.parent.mkdir(parents=True, exist_ok=True)
    a.out.write_text(text)
    print(f"  {a.out.name:32s} <- {a.hex.name:24s} "
          f"{len(words)}/{k['depth']} kelime x {k['width']} bit")


if __name__ == "__main__":
    main()
