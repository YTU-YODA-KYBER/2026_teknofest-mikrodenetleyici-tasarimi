/* =====================================================================
 *  ref_run.c  --  tflite_ref'in host (PC) surucusu
 *
 *  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
 *
 *  Komut satirindan verilen 1960 baytlik girdi hex'lerini sirayla yazilim
 *  referansindan gecirir ve her biri icin tek satir CSV basar:
 *
 *      dosya,sinif,sinif_acc,acc0..acc3,out0..out3
 *
 *      sinif     : TFLite'in cevabi   -> argmax(int8 requantize cikis)
 *      sinif_acc : donanimin kurali   -> argmax(ham int32 akumulator)
 *      acc0..3   : hizlandiricinin fc_scores'u ile dogrudan karsilastirilir
 *
 *  NEDEN AYRI BIR SURUCU
 *  ---------------------
 *  Model kodu (firmware/yz_model/tflite_ref.c) tasinabilir kalmali: dosya
 *  okumasi, printf, argv gibi hicbir sey icermez ki ayni dosya RV32'ye de
 *  derlenebilsin. Host'a ozgu her sey burada durur.
 *
 *  Derleme: bkz. Makefile (`make` -> ./ref_run)
 * ===================================================================== */

#include <stdio.h>

#include "tflite_ref.h"

/* ---------------------------------------------------------------------
 *  Girdi hex'i oku.
 *  Bicim: satir basina bir bayt, buyuk harf hex; wav_to_yz.py ciktisi ve
 *  firmware/sound_samples/ altindaki dosyalarla ayni. Tam YZ_REF_INPUT_LEN
 *  bayt olmali -- donanimda da DMA sayaci tam bu sayida load_done uretir,
 *  eksik/fazla veri sessizce kayar.
 * ------------------------------------------------------------------- */
static int read_input_hex(const char *path, uint8_t *buf)
{
    FILE *f = fopen(path, "r");
    if (!f) {
        fprintf(stderr, "HATA: acilamadi: %s\n", path);
        return -1;
    }

    char line[64];
    int n = 0;
    while (fgets(line, sizeof line, f)) {
        char *p = line;
        while (*p == ' ' || *p == '\t') ++p;
        if (*p == '\n' || *p == '\r' || *p == '\0' || *p == '/') continue;

        if (n >= YZ_REF_INPUT_LEN) { ++n; break; }

        unsigned v;
        if (sscanf(p, "%x", &v) != 1 || v > 0xFF) {
            fprintf(stderr, "HATA: %s: gecersiz hex satiri: %s", path, line);
            fclose(f);
            return -1;
        }
        buf[n++] = (uint8_t)v;
    }
    fclose(f);

    if (n != YZ_REF_INPUT_LEN) {
        fprintf(stderr, "HATA: %s: %d bayt, %d bekleniyordu\n",
                path, n, YZ_REF_INPUT_LEN);
        return -1;
    }
    return 0;
}

int main(int argc, char **argv)
{
    if (argc < 2) {
        fprintf(stderr,
                "kullanim: %s <girdi.hex> [girdi.hex ...]\n"
                "cikti (CSV): dosya,sinif,sinif_acc,acc0..3,out0..3\n", argv[0]);
        return 2;
    }

    /* Host'ta yigin bol; RV32 tarafinda bu tamponlar Data RAM'e tasinacak. */
    static uint8_t input[YZ_REF_INPUT_LEN];
    static int8_t  scratch[YZ_REF_SCRATCH_LEN];

    printf("dosya,sinif,sinif_acc,acc0,acc1,acc2,acc3,out0,out1,out2,out3\n");

    int fail = 0;
    for (int i = 1; i < argc; ++i) {
        if (read_input_hex(argv[i], input) != 0) { fail = 1; continue; }

        yz_ref_result_t r;
        yz_ref_infer(input, scratch, &r);

        printf("%s,%u,%u,%d,%d,%d,%d,%d,%d,%d,%d\n", argv[i],
               (unsigned)r.cls, (unsigned)r.cls_acc,
               r.acc[0], r.acc[1], r.acc[2], r.acc[3],
               r.out[0], r.out[1], r.out[2], r.out[3]);
    }
    return fail;
}
