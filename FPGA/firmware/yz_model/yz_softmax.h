/* =====================================================================
 *  yz_softmax.h  --  URETILMIS DOSYA, ELLE DUZENLEME
 *
 *  Uretici : scripts/yz_tflite/gen_tflite_data.py
 *  Kaynak  : tflite_files/micro_speech_quantized.tflite
 *
 *  Modelin Softmax katmani (sartname EK-1 madde 4) CPU'da uygulanir:
 *  hizlandirici FC'nin ham int32 akumulatorlerini YZ_SCORE0..3
 *  yazmaclarinda birakir, kesme servisi bunlari once int8'e requantize
 *  eder, sonra buradaki tablo ile softmax'a cevirir.
 *
 *      q_i    = clamp(MultiplyByQuantizedMultiplier(acc_i, MULT, SHIFT)
 *                     + FC_OUT_ZP, -128, 127)
 *      e_i    = (d = max_j(q_j) - q_i) < LUT_LEN ? EXP_LUT[d] : 0
 *      p_i    = e_i / sum(e)                        (0..1)
 *      skor_i = round(p_i / OUT_SCALE) + OUT_ZP     (int8, tel uzerindeki bicim)
 *
 *  EXP_LUT[d] = round(65535 * exp(-0.09173192083835602 * d)).
 *  d = max(q) - q_i teorik olarak 0..255'tir, ama exp bu olcekte
 *  d = 131'de sifira iner; tablo orada kesilir ve daha buyuk
 *  farklar sifir kabul edilir. Kayan nokta yalnizca bu tabloyu uretirken
 *  kullanilir; cihazda tamsayi aritmetigi yeter.
 * ===================================================================== */

#ifndef YZ_SOFTMAX_H
#define YZ_SOFTMAX_H

#include <stdint.h>

#define YZ_N_CLASS          4

/* FC cikisini int8'e sikistiran requant sabitleri */
#define YZ_FC_MULT          (1932201080)
#define YZ_FC_SHIFT         (-11)
#define YZ_FC_OUT_ZP        (14)

/* Softmax cikis tensorunun nicemlemesi */
#define YZ_SM_OUT_SCALE_INV (256)
#define YZ_SM_OUT_ZP        (-128)

#define YZ_EXP_LUT_LEN      132

static const uint16_t yz_exp_lut[132] = {
    65535, 59791, 54550, 49769, 45407, 41427, 37796, 34483,
    31460, 28703, 26187, 23892, 21798, 19887, 18144, 16554,
    15103, 13779, 12571, 11469, 10464, 9547, 8710, 7947,
    7250, 6615, 6035, 5506, 5023, 4583, 4181, 3815,
    3480, 3175, 2897, 2643, 2411, 2200, 2007, 1831,
    1671, 1524, 1391, 1269, 1158, 1056,  964,  879,
     802,  732,  668,  609,  556,  507,  463,  422,
     385,  351,  321,  292,  267,  243,  222,  203,
     185,  169,  154,  140,  128,  117,  107,   97,
      89,   81,   74,   67,   61,   56,   51,   47,
      43,   39,   35,   32,   30,   27,   25,   22,
      20,   19,   17,   16,   14,   13,   12,   11,
      10,    9,    8,    7,    7,    6,    6,    5,
       5,    4,    4,    4,    3,    3,    3,    2,
       2,    2,    2,    2,    2,    1,    1,    1,
       1,    1,    1,    1,    1,    1,    1,    1,
       1,    0,    0,    0,
};
#endif /* YZ_SOFTMAX_H */
