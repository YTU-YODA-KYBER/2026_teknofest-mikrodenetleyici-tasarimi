#!/usr/bin/env python3
# =====================================================================
#  hex_to_carray.py -- 1960 baytlik girdi hex'ini C dizisine cevirir
#
#  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
#
#  NIYE GEREKLI
#  ------------
#  Simulasyonda (yz_bench -DSIMULATION) uygulama ses verisini UART'tan
#  BEKLEMEZ: 1960 bayt x 10 bit x 434 cevrim = 8.5 M cevrim eder ve bu,
#  olcmek istedigimiz cikarimin kendisinden bile uzundur. Onun yerine
#  girdi .rodata'ya gomulur; testbench de ayni dosyayi YZ RAM'e DMA
#  uzerinden yukler. Boylece yazilim ile donanim AYNI ornegi isler.
#
#  KULLANIM
#  --------
#      python3 hex_to_carray.py ../../firmware/sound_samples/input_data_yes.hex
#      # -> firmware/yz_model/sim_input.h
# =====================================================================
"""Girdi hex'ini yz_bench'in gomulu test vektorune cevirir."""

import argparse
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
DEFAULT_IN = ROOT / "firmware/sound_samples/input_data_yes.hex"
DEFAULT_OUT = ROOT / "firmware/yz_model/sim_input.h"
N_BYTES = 1960


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("hex", nargs="?", default=str(DEFAULT_IN))
    ap.add_argument("-o", "--output", default=str(DEFAULT_OUT))
    args = ap.parse_args()

    src = Path(args.hex)
    vals = [int(t, 16) for t in src.read_text().split()]
    if len(vals) != N_BYTES:
        sys.exit(f"HATA: {src.name}: {len(vals)} bayt, {N_BYTES} bekleniyordu")
    if any(v > 0xFF for v in vals):
        sys.exit(f"HATA: {src.name}: 0xFF ustu deger var")

    lines = [f"""\
/* =====================================================================
 *  sim_input.h  --  URETILMIS DOSYA, ELLE DUZENLEME
 *
 *  Uretici : scripts/yz_tflite/hex_to_carray.py
 *  Kaynak  : {src.name}
 *
 *  yz_bench'in -DSIMULATION modunda kullandigi gomulu test vektoru.
 *  Testbench AYNI dosyayi YZ RAM'e DMA ile yukler; boylece yazilim ve
 *  donanim ayni ornegi isler ve siniflar karsilastirilabilir olur.
 * ===================================================================== */

#ifndef SIM_INPUT_H
#define SIM_INPUT_H

#include <stdint.h>

#define YZ_SIM_INPUT_SRC "{src.name}"

static const uint8_t yz_sim_input[{N_BYTES}] = {{"""]

    for i in range(0, N_BYTES, 16):
        lines.append("    " + ", ".join(f"0x{v:02X}" for v in vals[i:i + 16]) + ",")

    lines.append("};\n\n#endif /* SIM_INPUT_H */")

    out = Path(args.output)
    out.write_text("\n".join(lines) + "\n")
    print(f"[OK] {out.relative_to(ROOT)}  <- {src.name} ({N_BYTES} bayt)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
