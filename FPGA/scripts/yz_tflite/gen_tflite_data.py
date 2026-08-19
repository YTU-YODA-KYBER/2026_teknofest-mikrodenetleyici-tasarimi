#!/usr/bin/env python3
# =====================================================================
#  gen_tflite_data.py -- .tflite'tan yazilim referansinin sabitlerini uretir
#
#  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
#
#  NE URETIR
#  ---------
#  firmware/yz_model/tflite_model_data.h
#      geometri (#define), agirliklar, bias'lar, TFLite'in kuantize
#      carpanlari (Q31 multiplier + shift), zero-point'ler.
#
#  NEDEN ELLE KOPYALANMIYOR
#  ------------------------
#  Sabitleri bir kere kopyalayip birakirsan, .tflite ya da hizlandirici
#  degistigi gun yazilim referansi SESSIZCE yanlisa doner ve dogruluk
#  kiyasi anlamini kaybeder. Bu script her kosumda hem uretir hem de
#  asagidaki caprazlari dogrular; biri tutmazsa durur.
#
#  CAPRAZ KONTROLLER
#  -----------------
#    1. .tflite agirliklari  ==  AI_Accelerator/weights.hex, fc_weights.hex
#    2. .tflite bias'lari    ==  biases.hex, fc_biases.hex
#    3. .tflite agirliklari  ==  paketlenmis weights_p8.hex, fc_weights_p4.hex
#       (RTL'in GERCEKTEN okudugu ROM'lar bunlar)
#    4. TFLite carpanlari    ~=  conv_accelerator.v'deki M0_FLAT / SHR_FLAT
#       (birebir olmasi beklenmez; sapma raporlanir)
#    5. Geometri             ==  conv_accelerator.v localparam'lari
#
#  KULLANIM
#  --------
#      python3 gen_tflite_data.py            # uret + dogrula
#      python3 gen_tflite_data.py --check    # sadece dogrula, yazma
# =====================================================================
"""micro_speech .tflite -> tflite_model_data.h + capraz dogrulama."""

import argparse
import math
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from tflite_parse import parse_model                     # noqa: E402

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
ACCEL = ROOT / "main_codes/rtl/desgin_sources/AI_Accelerator"
RTL = ACCEL / "conv_accelerator.v"
OUT_H_FILE = ROOT / "firmware/yz_model/tflite_model_data.h"
TFLITE = ROOT.parent / "tflite_files/micro_speech_quantized.tflite"


# ---------------------------------------------------------------------
#  gemmlowp / TFLite QuantizeMultiplier
#
#  Gercek carpan M (0 < M < 1) ikiye ayrilir:  M = q31 * 2^(shift-31)
#  q31 [2^30, 2^31) araliginda bir int32, shift ise negatif bir kaydirma.
#  Calisma zamaninda MultiplyByQuantizedMultiplier bu ikiliyi kullanir.
#
#  Kaynak: tensorflow/lite/kernels/internal/quantization_util.cc
# ---------------------------------------------------------------------
def quantize_multiplier(m):
    if m == 0.0:
        return 0, 0
    frac, shift = math.frexp(m)              # m = frac * 2^shift, frac in [0.5, 1)
    q = int(round(frac * (1 << 31)))
    if q == (1 << 31):                       # frac 1.0'a yuvarlandi
        q //= 2
        shift += 1
    if shift < -31:                          # carpan 0'a cokuyor
        return 0, 0
    assert -31 <= shift <= 0, f"beklenmeyen shift={shift} (M={m})"
    return q, shift


# ---------------------------------------------------------------------
#  Depo dosyalarini okuma
# ---------------------------------------------------------------------
def read_hex_bytes(path, n):
    """Satir basina bir bayt hex. CRLF ve eksik son satir sonu tolere edilir."""
    vals = [int(t, 16) for t in path.read_text().split()]
    if len(vals) != n:
        sys.exit(f"HATA: {path.name}: {len(vals)} deger, {n} bekleniyordu")
    return [v - 256 if v > 127 else v for v in vals]      # int8'e cevir


def read_hex_words(path, n, width):
    """Satir basina bir kelime; `width` bayt genisliginde."""
    toks = path.read_text().split()
    if len(toks) != n:
        sys.exit(f"HATA: {path.name}: {len(toks)} deger, {n} bekleniyordu")
    out = []
    for t in toks:
        if len(t) != width * 2:
            sys.exit(f"HATA: {path.name}: '{t}' {width*2} haneli olmali")
        out.append(int(t, 16))
    return out


def read_hex_i32(path, n):
    return [v - (1 << 32) if v >= (1 << 31) else v
            for v in read_hex_words(path, n, 4)]


def rtl_localparam(text, name):
    m = re.search(rf"localparam\s+{name}\s*=\s*(\d+)\s*;", text)
    if not m:
        sys.exit(f"HATA: {RTL.name} icinde localparam {name} bulunamadi")
    return int(m.group(1))


def rtl_flat_array(text, name, width, n):
    """M0_FLAT / SHR_FLAT gibi duzlestirilmis vektorleri okur.

    RTL'de en soldaki deger en YUKSEK indekstir (ch7 once yazilmis), bu
    yuzden liste ters cevrilir.
    """
    m = re.search(name + r"\s*=\s*\{(.*?)\}\s*;", text, re.S)
    if not m:
        sys.exit(f"HATA: {RTL.name} icinde {name} bulunamadi")
    vals = [int(x) for x in re.findall(rf"{width}'d(\d+)", m.group(1))]
    if len(vals) != n:
        sys.exit(f"HATA: {name}: {len(vals)} deger, {n} bekleniyordu")
    return vals[::-1]


# ---------------------------------------------------------------------
#  Modelden cikarim
# ---------------------------------------------------------------------
class ModelData:
    def __init__(self, path):
        m = parse_model(path)
        self.model = m

        dw = m.op("DEPTHWISE_CONV_2D")
        fc = m.op("FULLY_CONNECTED")

        t_in   = m.tensors[dw.inputs[0]]
        t_w    = m.tensors[dw.inputs[1]]
        t_b    = m.tensors[dw.inputs[2]]
        t_relu = m.tensors[dw.outputs[0]]
        t_fw   = m.tensors[fc.inputs[1]]
        t_fb   = m.tensors[fc.inputs[2]]
        t_out  = m.tensors[fc.outputs[0]]

        # --- geometri ---
        _, self.in_h, self.in_w, in_ch = t_in.shape
        _, self.f_h, self.f_w, self.n_ch = t_w.shape
        _, self.out_h, self.out_w, out_ch = t_relu.shape
        self.n_class = t_out.shape[1]
        self.stride = dw.options["stride_h"]
        self.depth_mult = dw.options["depth_multiplier"]

        if in_ch != 1:
            sys.exit(f"HATA: giris kanali {in_ch}; hizlandiricinin depthwise "
                     f"yaklasimi yalnizca 1 kanal icin gecerli")
        if out_ch != self.n_ch or self.depth_mult != self.n_ch:
            sys.exit("HATA: kanal sayilari tutarsiz")
        if dw.options["stride_w"] != self.stride:
            sys.exit("HATA: yatay/dikey stride farkli, RTL tek stride varsayiyor")
        if dw.options["padding"] != "SAME":
            sys.exit(f"HATA: padding {dw.options['padding']}, SAME bekleniyordu")
        if dw.options["activation"] != "RELU":
            sys.exit(f"HATA: aktivasyon {dw.options['activation']}, RELU bekleniyordu")

        # SAME dolgu, TFLite'in ComputePadding kurali ile
        pad_h = max((self.out_h - 1) * self.stride + self.f_h - self.in_h, 0)
        pad_w = max((self.out_w - 1) * self.stride + self.f_w - self.in_w, 0)
        self.pad_top = pad_h // 2
        self.pad_left = pad_w // 2

        # --- zero-point'ler ---
        self.in_zp = t_in.zero_point[0]
        self.conv_out_zp = t_relu.zero_point[0]
        self.fc_out_zp = t_out.zero_point[0]

        # --- agirlik / bias verileri ---
        self.conv_w = [b - 256 if b > 127 else b for b in t_w.data]
        self.fc_w = [b - 256 if b > 127 else b for b in t_fw.data]
        self.conv_b = self._i32(t_b.data)
        self.fc_b = self._i32(t_fb.data)

        n_w = self.f_h * self.f_w * self.n_ch
        if len(self.conv_w) != n_w:
            sys.exit(f"HATA: conv agirligi {len(self.conv_w)}, {n_w} bekleniyordu")
        self.fc_in = self.out_h * self.out_w * self.n_ch
        if len(self.fc_w) != self.n_class * self.fc_in:
            sys.exit("HATA: FC agirlik boyutu tutarsiz")

        # --- carpanlar ---
        s_in = t_in.scale[0]
        s_relu = t_relu.scale[0]
        self.conv_real = [s_in * s / s_relu for s in t_w.scale]
        self.conv_mult, self.conv_shift = zip(
            *(quantize_multiplier(m_) for m_ in self.conv_real))

        self.fc_real = s_relu * t_fw.scale[0] / t_out.scale[0]
        self.fc_mult, self.fc_shift = quantize_multiplier(self.fc_real)

        # --- aktivasyon sinirlari ---
        # Fused ReLU, nicemlenmis alanda 0.0'in karsiligina (zero-point)
        # kirpar; ust sinir int8'in tepesidir.
        self.conv_amin, self.conv_amax = self.conv_out_zp, 127
        self.fc_amin, self.fc_amax = -128, 127

    @staticmethod
    def _i32(data):
        out = []
        for i in range(0, len(data), 4):
            v = int.from_bytes(data[i:i + 4], "little")
            out.append(v - (1 << 32) if v >= (1 << 31) else v)
        return out


# ---------------------------------------------------------------------
#  Capraz kontroller
# ---------------------------------------------------------------------
def verify(md):
    ok = True

    def check(name, cond, detail=""):
        nonlocal ok
        print(f"  [{'OK ' if cond else 'HATA'}] {name}{'  ' + detail if detail else ''}")
        ok = ok and cond

    print("\n--- 1/5  .tflite agirliklari <-> duz hex dosyalari ---")
    check("weights.hex", read_hex_bytes(ACCEL / "weights.hex", len(md.conv_w))
          == md.conv_w)
    check("fc_weights.hex", read_hex_bytes(ACCEL / "fc_weights.hex", len(md.fc_w))
          == md.fc_w)

    print("\n--- 2/5  .tflite bias'lari <-> hex dosyalari ---")
    check("biases.hex", read_hex_i32(ACCEL / "biases.hex", md.n_ch) == md.conv_b)
    check("fc_biases.hex", read_hex_i32(ACCEL / "fc_biases.hex", md.n_class)
          == md.fc_b)

    # RTL bu ikisini degil, asagidaki paketlenmis surumleri okur. Duz dosyalar
    # guncel olup paketlenmisler bayat kalirsa donanim eski agirliklarla kosar.
    print("\n--- 3/5  .tflite agirliklari <-> RTL'in okudugu paketlenmis ROM'lar ---")
    n_tap = md.f_h * md.f_w
    p8 = read_hex_words(ACCEL / "weights_p8.hex", n_tap, 8)
    exp8 = [sum((md.conv_w[k * md.n_ch + c] & 0xFF) << (8 * c)
                for c in range(md.n_ch)) for k in range(n_tap)]
    check("weights_p8.hex", p8 == exp8,
          "(tap basina 8 kanal, kanal 0 = en dusuk bayt)")

    p4 = read_hex_words(ACCEL / "fc_weights_p4.hex", md.fc_in, 4)
    exp4 = [sum((md.fc_w[c * md.fc_in + i] & 0xFF) << (8 * c)
                for c in range(md.n_class)) for i in range(md.fc_in)]
    check("fc_weights_p4.hex", p4 == exp4,
          "(girdi basina 4 sinif, sinif 0 = en dusuk bayt)")

    print("\n--- 4/5  TFLite carpanlari <-> RTL'in M0/SHR yaklasimi ---")
    text = RTL.read_text()
    m0 = rtl_flat_array(text, "M0_FLAT", 18, md.n_ch)
    shr = rtl_flat_array(text, "SHR_FLAT", 5, md.n_ch)
    print(f"  {'kanal':<6}{'TFLite M':>14}{'RTL M0/2^SHR':>16}{'bagil hata':>13}")
    worst = 0.0
    for c in range(md.n_ch):
        rtl_m = m0[c] / (1 << shr[c])
        err = abs(rtl_m - md.conv_real[c]) / md.conv_real[c]
        worst = max(worst, err)
        print(f"  {c:<6}{md.conv_real[c]:>14.9f}{rtl_m:>16.9f}{err:>12.2e}")
    # 18-bit M0 ~5.4 ondalik hane tasir; 1e-5 uzeri sapma yuvarlama degil
    # yanlis sabit demektir.
    check("conv carpanlari", worst < 1e-4, f"en buyuk bagil hata {worst:.2e}")

    print(f"\n  NOT: RTL FC cikisini requantize ETMEZ (ham int32 argmax).")
    print(f"       TFLite ise int8'e sikistirir: scale, zp={md.fc_out_zp}, "
          f"carpan {md.fc_real:.9f}")
    print(f"       -> iki tarafin argmax'i doygunluk halinde AYRISABILIR; "
          f"olculecek fark budur.")

    print("\n--- 5/5  Geometri <-> conv_accelerator.v localparam'lari ---")
    for name, val in (("INPUT_H", md.in_h), ("INPUT_W", md.in_w),
                      ("FILTER_H", md.f_h), ("FILTER_W", md.f_w),
                      ("STRIDE", md.stride), ("PAD_TOP", md.pad_top),
                      ("PAD_LEFT", md.pad_left), ("OUT_H", md.out_h),
                      ("OUT_W", md.out_w), ("N_CH", md.n_ch),
                      ("N_CLASS", md.n_class)):
        r = rtl_localparam(text, name)
        check(f"{name} = {val}", r == val, "" if r == val else f"RTL: {r}")

    return ok


# ---------------------------------------------------------------------
#  Baslik uretimi
# ---------------------------------------------------------------------
def c_array(name, ctype, vals, per_line):
    lines = [f"static const {ctype} {name}[{len(vals)}] = {{"]
    for i in range(0, len(vals), per_line):
        lines.append("    " + ", ".join(f"{v:>4}" for v in vals[i:i + per_line]) + ",")
    lines.append("};")
    return "\n".join(lines)


def emit(md):
    m = md
    parts = [f"""\
/* =====================================================================
 *  tflite_model_data.h  --  URETILMIS DOSYA, ELLE DUZENLEME
 *
 *  Uretici : scripts/yz_tflite/gen_tflite_data.py
 *  Kaynak  : tflite_files/micro_speech_quantized.tflite
 *
 *  Model: {m.in_h}x{m.in_w}x1 int8
 *         -> DepthwiseConv2D ({m.f_h}x{m.f_w}, stride {m.stride}, SAME,
 *            depth_multiplier {m.depth_mult}, fused ReLU)
 *         -> {m.out_h}x{m.out_w}x{m.n_ch} int8
 *         -> FullyConnected ({m.fc_in} -> {m.n_class}) -> int8
 *         -> Softmax (argmax'i degistirmez, uygulanmaz)
 *
 *  Carpanlar TFLite'in QuantizeMultiplier'i ile uretilmistir:
 *      M = mult * 2^(shift-31),   mult in [2^30, 2^31)
 *  Calisma zamaninda MultiplyByQuantizedMultiplier ile uygulanir.
 * ===================================================================== */

#ifndef TFLITE_MODEL_DATA_H
#define TFLITE_MODEL_DATA_H

#include <stdint.h>

/* --- geometri --- */
#define YZ_IN_H          {m.in_h}
#define YZ_IN_W          {m.in_w}
#define YZ_IN_CH         1
#define YZ_FILTER_H      {m.f_h}
#define YZ_FILTER_W      {m.f_w}
#define YZ_STRIDE        {m.stride}
#define YZ_PAD_TOP       {m.pad_top}
#define YZ_PAD_LEFT      {m.pad_left}
#define YZ_OUT_H         {m.out_h}
#define YZ_OUT_W         {m.out_w}
#define YZ_N_CH          {m.n_ch}
#define YZ_DEPTH_MULT    {m.depth_mult}
#define YZ_FC_IN         {m.fc_in}
#define YZ_N_CLASS       {m.n_class}
#define YZ_INPUT_LEN     ({m.in_h} * {m.in_w})

/* --- zero-point'ler ---
 *  Girisin zp'si {m.in_zp}: host'un gonderdigi uint8 zaten (q_in + 128)
 *  oldugu icin yazilim tarafinda da cikarma yapilmaz (offset-binary). */
#define YZ_INPUT_ZP      ({m.in_zp})
#define YZ_CONV_OUT_ZP   ({m.conv_out_zp})
#define YZ_FC_OUT_ZP     ({m.fc_out_zp})

/* --- aktivasyon kirpma sinirlari --- */
#define YZ_CONV_ACT_MIN  ({m.conv_amin})
#define YZ_CONV_ACT_MAX  ({m.conv_amax})
#define YZ_FC_ACT_MIN    ({m.fc_amin})
#define YZ_FC_ACT_MAX    ({m.fc_amax})

/* --- FC carpani (tek tensor scale) --- */
#define YZ_FC_MULT       ({m.fc_mult})
#define YZ_FC_SHIFT      ({m.fc_shift})
"""]

    parts.append("\n/* --- DepthwiseConv2D agirliklari ---\n"
                 " *  Duzen (TFLite [1, f_h, f_w, kanal]):\n"
                 " *      yz_conv_w[(fy * YZ_FILTER_W + fx) * YZ_N_CH + ch]\n"
                 " */\n"
                 + c_array("yz_conv_w", "int8_t", m.conv_w, m.n_ch))

    parts.append("\n/* --- DepthwiseConv2D bias'lari (int32, per-channel) --- */\n"
                 + c_array("yz_conv_b", "int32_t", m.conv_b, 4))

    parts.append("\n/* --- Conv per-channel requant carpanlari --- */\n"
                 + c_array("yz_conv_mult", "int32_t", list(m.conv_mult), 4)
                 + "\n"
                 + c_array("yz_conv_shift", "int32_t", list(m.conv_shift), 8))

    parts.append("\n/* --- FullyConnected agirliklari ---\n"
                 " *  Duzen (TFLite [sinif, girdi]) -- SINIF-major, conv'un\n"
                 " *  tersine! yz_fc_w[sinif * YZ_FC_IN + i]\n"
                 " *  Girdi indeksi:  i = (oy * YZ_OUT_W + ox) * YZ_N_CH + ch\n"
                 " */\n"
                 + c_array("yz_fc_w", "int8_t", m.fc_w, 16))

    parts.append("\n/* --- FullyConnected bias'lari --- */\n"
                 + c_array("yz_fc_b", "int32_t", m.fc_b, 4))

    parts.append("\n#endif /* TFLITE_MODEL_DATA_H */\n")
    return "\n".join(parts)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--model", default=str(TFLITE), help=".tflite yolu")
    ap.add_argument("--check", action="store_true",
                    help="sadece dogrula, baslik yazma")
    args = ap.parse_args()

    print(f"model : {args.model}")
    md = ModelData(args.model)
    print(f"        {md.in_h}x{md.in_w}x1 -> conv{md.f_h}x{md.f_w}/s{md.stride} "
          f"x{md.n_ch} -> {md.out_h}x{md.out_w}x{md.n_ch} -> fc{md.fc_in}->{md.n_class}")

    if not verify(md):
        print("\nSONUC: CAPRAZ KONTROL BASARISIZ -- baslik uretilmedi.")
        return 1

    if args.check:
        print("\nSONUC: tum kontroller tamam (--check, dosya yazilmadi).")
        return 0

    OUT_H_FILE.write_text(emit(md))
    print(f"\nSONUC: tum kontroller tamam.")
    print(f"  yazildi: {OUT_H_FILE.relative_to(ROOT)} "
          f"({OUT_H_FILE.stat().st_size // 1024} KB)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
