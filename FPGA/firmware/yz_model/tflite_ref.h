/* =====================================================================
 *  tflite_ref.h  --  micro_speech modelinin YAZILIM gerceklemesi (API)
 *
 *  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
 *
 *  Sartnamenin "RISC-V cekirdegi uzerinde calisan yazilim gerceklemesi"
 *  dedigi baseline budur: TFLite Micro'nun reference kernel'lerinin
 *  freestanding C portu (bkz. tflite_ref.c).
 *
 *  TASINABILIR: soc.h, kesme, cevre birimi, stdlib bagimliligi YOK --
 *  sadece <stdint.h>. Ayni dosya hem host PC'de (dogruluk kiyasi) hem
 *  RV32'de (hizlanma olcumu) derlenir.
 * ===================================================================== */

#ifndef TFLITE_REF_H
#define TFLITE_REF_H

#include <stdint.h>

#include "tflite_model_data.h"

#define YZ_REF_INPUT_LEN    YZ_INPUT_LEN     /* 1960 bayt, offset-binary */
#define YZ_REF_SCRATCH_LEN  YZ_FC_IN         /* 4000 int8, conv cikisi   */
#define YZ_REF_N_CLASS      YZ_N_CLASS       /* 4                        */

typedef struct {
    /* FC'nin ham int32 akumulatorleri. Hizlandiricinin `fc_scores`'u ile
     * AYNI buyukluk -- bit-bit karsilastirma buradan yapilir. */
    int32_t acc[YZ_REF_N_CLASS];

    /* TFLite'in gercek cikis tensoru (`add_1`): akumulatorler int8'e
     * requantize edilmis hali. Hizlandirici bu adimi ATLAR. */
    int8_t  out[YZ_REF_N_CLASS];

    /* TFLite'in cevabi: argmax(out).
     * Softmax monoton oldugu icin argmax(softmax(out)) ile aynidir. */
    uint8_t cls;

    /* Hizlandiricinin kurali: argmax(acc). Normalde cls ile aynidir;
     * ayrilmasi int8 doygunlugu demektir (teshis icin tutuluyor). */
    uint8_t cls_acc;
} yz_ref_result_t;

/* ---------------------------------------------------------------------
 *  Tek cikarim.
 *    input   : YZ_REF_INPUT_LEN bayt, wav_to_yz.py ciktisiyla ayni bicim
 *              (uint8 = int8_ozellik + 128, offset-binary)
 *    scratch : YZ_REF_SCRATCH_LEN baytlik ara tampon (conv cikisi).
 *              Cagiran saglar; fonksiyon icinde statik tampon YOK ki
 *              RV32'de yerlesimi linker'a birakilabilsin.
 *    r       : sonuc
 * ------------------------------------------------------------------- */
void yz_ref_infer(const uint8_t *input, int8_t *scratch, yz_ref_result_t *r);

#endif /* TFLITE_REF_H */
