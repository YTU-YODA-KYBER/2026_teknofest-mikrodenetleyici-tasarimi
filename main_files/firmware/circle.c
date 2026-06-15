/* =====================================================================
 *  circle.c  -  GPIO LED Animasyon Demosu
 *  TEKNOFEST 2026 Cip Tasarim Yarismasi - Mikrodenetleyici Kategorisi
 *  YTU YODA KYBER - CV32E40P SoC
 *
 *  AMAC (DTR deneyi):
 *    BootROM'a gomulu tek-binary olarak kosan bu program, CV32E40P
 *    cekirdeginin boot ettigini, AXI ara baglanti uzerinden GPIO cevre
 *    birimine eristigini ve FPGA (Basys3) uzerinde fiziksel cikti
 *    uretebildigini gosterir. Karttaki 16 LED (LD0..LD15) uzerinde
 *    surekli donen/suren bir isik deseni oynatilir.
 *
 *  AKIS:
 *    boot.S  ->  sp kur, .data kopyala, .bss sifirla, main() cagir
 *    main()  ->  GPIO_ODR'ye 16-bitlik desenler yazip aralarinda bekle
 *
 *  ADRES HARITASI (soc.h):
 *    Gpio->GPIO_ODR @ 0x40010004  ([15:0] -> LD0..LD15, [31:16] etkisiz)
 *
 *  TASARIM NOTLARI:
 *    - Initialize global YOK: program saf BootROM'dan kosar, RAM'de
 *      yalnizca stack kullanilir (read-only ROM ile uyumlu).
 *    - Gecikme parametrik busy-wait: LOOPS_PER_MS'i goz karari ayarla.
 *      48 MHz'de adim basina ~STEP_MS milisaniye hedeflenir.
 * ===================================================================== */

#include "soc.h"

/* ---------------------------------------------------------------------
 *  Ayarlanabilir parametreler
 * --------------------------------------------------------------------- */
#define NUM_LEDS       16u      /* Basys3 uzerindeki LED sayisi          */
#define STEP_MS        90u      /* her animasyon adimi arasi bekleme (ms)*/

/* 48 MHz'de ~ (48000 cevrim/ms) / (~8 cevrim/dongu) ~= 6000.
 * Animasyon cok hizliysa BUYUT, cok yavassa KUCULT.
 *
 * SIMULASYON NOTU:
 *   Gercek LOOPS_PER_MS ile her adim ~4.3 milyon clock cycle surer;
 *   simülatör saatlerce calismak zorunda kalir.
 *   make sim_circle -DSIMULATION flag'i ile derler, her adim ~40 cycle'a
 *   duser: GPIO_ODR degisimlerini waveform'da hemen gorebilirsin. */
#ifdef SIMULATION
#define LOOPS_PER_MS   5u       /* sim: her adim ~40 cycle (~birkas ns) */
#else
#define LOOPS_PER_MS   6000u    /* gercek donanim: ~90 ms/adim @ 48 MHz */
#endif

/* ---------------------------------------------------------------------
 *  Yardimci: LED'lere 16-bitlik desen yaz
 * --------------------------------------------------------------------- */
static inline void leds_write(uint16_t value)
{
    Gpio->GPIO_ODR = (uint32_t)value;   /* [31:16] donanimda etkisiz */
}

/* ---------------------------------------------------------------------
 *  Yardimci: kaba busy-wait gecikmesi (ms cinsinden, yaklasik)
 *  volatile sayac + nop ile derleyici donguyu eleyemez.
 * --------------------------------------------------------------------- */
static void delay_ms(uint32_t ms)
{
    volatile uint32_t n = ms * LOOPS_PER_MS;
    while (n--) {
        __asm__ volatile ("nop");
    }
}

/* ---------------------------------------------------------------------
 *  Desen 1: Tek isik donen (rotate-left + wrap)
 *  0x0001 -> 0x0002 -> ... -> 0x8000 -> 0x0001 (basa sarar)
 * --------------------------------------------------------------------- */
static void anim_rotate(uint32_t laps)
{
    uint16_t p = 0x0001u;
    for (uint32_t lap = 0; lap < laps; lap++) {
        for (uint32_t i = 0; i < NUM_LEDS; i++) {
            leds_write(p);
            delay_ms(STEP_MS);
            /* 16-bit dairesel kaydirma */
            p = (uint16_t)((p << 1) | (p >> (NUM_LEDS - 1)));
        }
    }
}

/* ---------------------------------------------------------------------
 *  Desen 2: Gidip-gelen tek isik (Knight Rider)
 *  ileri: 0..15, geri: 14..1  (uc noktalar tekrar vurulmaz)
 * --------------------------------------------------------------------- */
static void anim_bounce(uint32_t rounds)
{
    for (uint32_t r = 0; r < rounds; r++) {
        for (uint32_t i = 0; i < NUM_LEDS; i++) {
            leds_write((uint16_t)(1u << i));
            delay_ms(STEP_MS);
        }
        for (uint32_t i = NUM_LEDS - 2u; i >= 1u; i--) {
            leds_write((uint16_t)(1u << i));
            delay_ms(STEP_MS);
        }
    }
}

/* ---------------------------------------------------------------------
 *  Desen 3: Dolan-bosalan supurme
 *  once bit bit dolar (tum LED'ler yanana kadar), sonra bit bit boşalir
 * --------------------------------------------------------------------- */
static void anim_fill_empty(uint32_t rounds)
{
    for (uint32_t r = 0; r < rounds; r++) {
        uint16_t p = 0x0000u;
        for (uint32_t i = 0; i < NUM_LEDS; i++) {       /* dol */
            p = (uint16_t)(p | (1u << i));
            leds_write(p);
            delay_ms(STEP_MS);
        }
        for (uint32_t i = 0; i < NUM_LEDS; i++) {       /* bosalt */
            p = (uint16_t)(p & ~(1u << i));
            leds_write(p);
            delay_ms(STEP_MS);
        }
    }
}

/* ---------------------------------------------------------------------
 *  main: desenleri sirayla, sonsuza kadar oynat
 * --------------------------------------------------------------------- */
int main(void)
{
    leds_write(0x0000u);   /* baslangicta tum LED'ler sonuk */

    while (1) {
        anim_rotate(2);        /* tek isik 2 tur doner       */
        anim_bounce(2);        /* 2 kez gidip gelir          */
        anim_fill_empty(2);    /* 2 kez dolar-bosalir        */
    }

    return 0;   /* ulasilmaz; boot.S burada _hang'e duser */
}
