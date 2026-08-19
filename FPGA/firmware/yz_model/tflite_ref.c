/* =====================================================================
 *  tflite_ref.c  --  micro_speech modelinin YAZILIM gerceklemesi
 *
 *  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
 *
 *  NE BU DOSYA
 *  -----------
 *  TFLite Micro'nun referans cekirdeklerinin freestanding C portu:
 *      tensorflow/lite/kernels/internal/reference/integer_ops/
 *          depthwise_conv.h   -> DepthwiseConvPerChannel
 *          fully_connected.h  -> FullyConnected
 *      tensorflow/lite/kernels/internal/common.h
 *          MultiplyByQuantizedMultiplier
 *      gemmlowp/fixedpoint/fixedpoint.h
 *          SaturatingRoundingDoublingHighMul, RoundingDivideByPOT
 *
 *  Sartname (EK-1) baseline'i "micro/kernels adresindeki temel
 *  fonksiyonlar" olarak tanimliyor; aritmetigi ve dongu duzeni bu yuzden
 *  referanstan SAPTIRILMADI. Model sabitleri tflite_model_data.h'tadir ve
 *  dogrudan micro_speech_quantized.tflite'tan uretilir.
 *
 *  ADIL BASELINE
 *  -------------
 *  Bu kod ayni zamanda "hizlanma" maddesinin kiyas noktasi. Kasitli
 *  yavaslatma yok: referans dongu duzeni korunuyor, -O2 ile derleniyor.
 *  Ama donanima ozgu hicbir kisayol da eklenmedi (8 kanali paralel
 *  isleme, tek BRAM okumasinda butun agirliklari cekme gibi) -- olcmek
 *  istedigimiz fark zaten tam olarak odur.
 *
 *  TASMA ANALIZI (int32 yeterli mi?)
 *  ---------------------------------
 *      conv akumulatoru : 80 tap x 255 x 127          =   2.590.800
 *      FC   akumulatoru : 4000 girdi x 255 x 127      = 129.540.000
 *  Ikisi de int32'ye (2.147.483.647) rahat sigar -> ne sarma ne de
 *  isaretli tasma (C'de tanimsiz davranis) olusur. Dolayisiyla bu kodun
 *  host'ta ve RV32'de ayni sonucu vermesi garantidir.
 * ===================================================================== */

#include "tflite_ref.h"

/* =====================================================================
 *  gemmlowp sabit-nokta yardimcilari
 * ===================================================================== */

/* ---------------------------------------------------------------------
 *  a ve b'yi Q0.31 kesirler gibi carpip sonucu yine int32'ye yuvarlar
 *  ("doubling high mul": tam carpimin ust 32 biti, 2 ile carpilmis).
 *
 *  DIKKAT: `/ (1LL << 31)` bilerek boyle yazildi -- C'de tam sayi bolmesi
 *  SIFIRA dogru budar, `>> 31` ise ASAGI. Negatif degerlerde ikisi farkli
 *  sonuc verir ve gemmlowp'un tanimi bolmedir. Kaydirmaya cevirirsen
 *  referanstan sapar, TFLite ile bit-exact olmazsin.
 * ------------------------------------------------------------------- */
static int32_t saturating_rounding_doubling_high_mul(int32_t a, int32_t b)
{
    /* Tek doygunluk durumu: INT32_MIN * INT32_MIN taser. */
    if (a == (int32_t)0x80000000 && b == (int32_t)0x80000000)
        return (int32_t)0x7FFFFFFF;

    int64_t ab = (int64_t)a * (int64_t)b;
    /* Sifirdan uzaga yuvarlama: pozitifte +2^30, negatifte -(2^30 - 1) */
    int64_t nudge = (ab >= 0) ? (1 << 30) : (1 - (1 << 30));
    return (int32_t)((ab + nudge) / (1LL << 31));
}

/* ---------------------------------------------------------------------
 *  2^exponent'e yuvarlayarak bol (yarim degerler sifirdan uzaga gider).
 * ------------------------------------------------------------------- */
static int32_t rounding_divide_by_pot(int32_t x, int exponent)
{
    if (exponent == 0)
        return x;

    const int32_t mask      = ((int32_t)1 << exponent) - 1;
    const int32_t remainder = x & mask;
    const int32_t threshold = (mask >> 1) + (x < 0 ? 1 : 0);

    return (x >> exponent) + (remainder > threshold ? 1 : 0);
}

/* ---------------------------------------------------------------------
 *  x * M, burada M = multiplier * 2^(shift-31).
 *
 *  Modelimizde butun shift'ler negatif (M < 1), yani left_shift daima 0
 *  kalir; yine de referanstaki genel hali koruyoruz.
 * ------------------------------------------------------------------- */
static int32_t multiply_by_quantized_multiplier(int32_t x, int32_t multiplier,
                                                int shift)
{
    const int left_shift  = (shift > 0) ?  shift : 0;
    const int right_shift = (shift > 0) ?      0 : -shift;

    return rounding_divide_by_pot(
        saturating_rounding_doubling_high_mul(x * ((int32_t)1 << left_shift),
                                             multiplier),
        right_shift);
}

static int32_t clamp(int32_t v, int32_t lo, int32_t hi)
{
    if (v < lo) return lo;
    if (v > hi) return hi;
    return v;
}

/* =====================================================================
 *  DepthwiseConv2D (int8, per-channel) + fused ReLU
 *
 *  Referans: reference_integer_ops::DepthwiseConvPerChannel
 *
 *  Girdi kanali 1 oldugu icin dis `in_channel` dongusu tek turdur ve
 *  cikis kanali dogrudan depth_multiplier indeksidir:
 *      output_channel = m + in_channel * depth_multiplier = m
 *
 *  Dolgu: sinir disi tap'ler referanstaki gibi `inside` kontroluyle
 *  ATLANIR. Bu, girdi zero-point'i ile doldurmakla ayni seydir -- cunku
 *  atlanan tap'in katkisi (input_val + input_offset) = 0 olurdu.
 * ===================================================================== */
static void depthwise_conv(const uint8_t *input, int8_t *output)
{
    const int32_t input_offset = -YZ_INPUT_ZP;      /* +128 */

    for (int out_y = 0; out_y < YZ_OUT_H; ++out_y) {
        const int in_y_origin = out_y * YZ_STRIDE - YZ_PAD_TOP;

        for (int out_x = 0; out_x < YZ_OUT_W; ++out_x) {
            const int in_x_origin = out_x * YZ_STRIDE - YZ_PAD_LEFT;

            for (int m = 0; m < YZ_DEPTH_MULT; ++m) {
                const int out_ch = m;               /* in_channel == 0 */
                int32_t acc = 0;

                for (int fy = 0; fy < YZ_FILTER_H; ++fy) {
                    const int in_y = in_y_origin + fy;

                    for (int fx = 0; fx < YZ_FILTER_W; ++fx) {
                        const int in_x = in_x_origin + fx;

                        const int inside = (in_x >= 0) && (in_x < YZ_IN_W) &&
                                           (in_y >= 0) && (in_y < YZ_IN_H);
                        if (!inside)
                            continue;

                        /* Girdi tamponu OFFSET-BINARY: bayt = q_in + 128.
                         * Referans kernel int8 `q_in` bekler, o yuzden 128
                         * cikariyoruz. (int8_t)'ye cast ETME -- bayt 128'in
                         * uzerindeyken 256 cikarir, 128 degil. */
                        const int32_t input_val =
                            (int32_t)input[in_y * YZ_IN_W + in_x] - 128;
                        const int32_t filter_val =
                            yz_conv_w[(fy * YZ_FILTER_W + fx) * YZ_N_CH + out_ch];

                        acc += filter_val * (input_val + input_offset);
                    }
                }

                acc += yz_conv_b[out_ch];
                acc = multiply_by_quantized_multiplier(acc,
                                                       yz_conv_mult[out_ch],
                                                       yz_conv_shift[out_ch]);
                acc += YZ_CONV_OUT_ZP;
                acc = clamp(acc, YZ_CONV_ACT_MIN, YZ_CONV_ACT_MAX);

                output[(out_y * YZ_OUT_W + out_x) * YZ_N_CH + out_ch] =
                    (int8_t)acc;
            }
        }
    }
}

/* =====================================================================
 *  FullyConnected (int8)
 *
 *  Referans: reference_integer_ops::FullyConnected
 *
 *  Agirlik tensoru [sinif][girdi] duzenindedir -- conv'un tersine SINIF
 *  disda. Girdi ise conv cikisinin NHWC duzlestirmesi:
 *      i = (out_y * OUT_W + out_x) * N_CH + ch
 *
 *  Agirlik zero-point'i 0 oldugu icin filter_offset terimi dusuyor.
 * ===================================================================== */
static void fully_connected(const int8_t *input, yz_ref_result_t *r)
{
    const int32_t input_offset = -YZ_CONV_OUT_ZP;   /* +128 */

    for (int out_c = 0; out_c < YZ_N_CLASS; ++out_c) {
        const int8_t *w = &yz_fc_w[out_c * YZ_FC_IN];
        int32_t acc = 0;

        for (int d = 0; d < YZ_FC_IN; ++d)
            acc += (int32_t)w[d] * ((int32_t)input[d] + input_offset);

        acc += yz_fc_b[out_c];
        r->acc[out_c] = acc;                        /* donanimin fc_scores'u */

        /* TFLite burada durmaz: cikisi int8'e requantize eder.
         * Hizlandirici bu adimi atlayip ham int32'de argmax alir. */
        int32_t q = multiply_by_quantized_multiplier(acc, YZ_FC_MULT,
                                                     YZ_FC_SHIFT);
        q += YZ_FC_OUT_ZP;
        r->out[out_c] = (int8_t)clamp(q, YZ_FC_ACT_MIN, YZ_FC_ACT_MAX);
    }
}

/* =====================================================================
 *  Argmax
 *
 *  Esitlikte en KUCUK indeks kazanir (kesin `>`), hizlandiricinin
 *  S_ARGMAX durumuyla ayni kural.
 * ===================================================================== */
static uint8_t argmax_i32(const int32_t *v)
{
    uint8_t best = 0;
    for (int i = 1; i < YZ_N_CLASS; ++i)
        if (v[i] > v[best]) best = (uint8_t)i;
    return best;
}

static uint8_t argmax_i8(const int8_t *v)
{
    uint8_t best = 0;
    for (int i = 1; i < YZ_N_CLASS; ++i)
        if (v[i] > v[best]) best = (uint8_t)i;
    return best;
}

/* ===================================================================== */
void yz_ref_infer(const uint8_t *input, int8_t *scratch, yz_ref_result_t *r)
{
    depthwise_conv(input, scratch);
    fully_connected(scratch, r);

    /* Softmax uygulanmaz: tek scale/zp ile monoton bir donusum oldugundan
     * argmax'i degistiremez (argmax(softmax(out)) == argmax(out)). */
    r->cls     = argmax_i8(r->out);
    r->cls_acc = argmax_i32(r->acc);
}
