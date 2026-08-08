/* =====================================================================
 *  yz_bench.c  --  YZ hizlandirici  vs  yazilim gerceklemesi kiyas app'i
 *
 *  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
 *
 *  NE YAPAR
 *  --------
 *  Ayni 1960 baytlik ses ozelligini HEM hizlandiriciya HEM de CPU'da
 *  kosan TFLite yazilim gerceklemesine verir, ikisinin sinifini ve
 *  cevrim sayisini olcup UART'tan PC'ye bildirir. Sartnamenin iki
 *  maddesini de tek kosumda besler:
 *      Madde A (hizlanma) -> SC / HC orani
 *      Madde B (dogruluk) -> SW ve YZ siniflarinin veri kumesi uzerindeki
 *                            dogruluk oranlari
 *
 *  AYNI ORNEGI NASIL GORUYORLAR
 *  ----------------------------
 *  YZ RAM'in CPU portu yok; hizlandirici veriyi yalnizca UART_YZ -> DMA
 *  yolundan alir. Bu yuzden uart_mux.sv'de genel UART'in RX'i HER MODDA
 *  acik birakildi: PC tek gonderim yapar, ayni baytlar hem DMA'ya (YZ
 *  RAM) hem de CPU'ya (genel UART) ulasir. Iki taraf garantili ayni
 *  ornegi isler.
 *
 *  NEDEN KESME YOK
 *  ---------------
 *  main_app.c kesme guduml­udur; burada bilerek tamamen yoklamali
 *  (polling) yazildi. Olculen sey cevrim sayisi oldugu icin akisin
 *  tek parca ve gozle takip edilebilir olmasi, ISR'lara dagilmasindan
 *  daha degerli. Olcum penceresine kesme gecikmesi de karismaz.
 *
 *  RAPOR CERCEVESI (UART_YZ TX)
 *  ----------------------------
 *      YZ:<sinif>\n                             <- send_data.py bunu bekler
 *      SW:<sinif> HC:<cevrim> SC:<cevrim>\n     <- ek satir, eski akis
 *                                                  bu satiri yok sayar
 *
 *  KART KULLANIMI:  SW1 = 1, SW0 = 0  (GPIO_IDR[1:0] == 2)
 *      TX pini uart_mux'ta ancak bu kombinasyonda UART_YZ'ye baglanir.
 * ===================================================================== */

#include "soc.h"

#include "tflite_ref.h"

#ifdef SIMULATION
#include "sim_input.h"
#endif

/* =====================================================================
 *  Cevrim sayaci
 *
 *  TUZAK: CV32E40P'de mcountinhibit reset'te 1'dir
 *  (cv32e40p_cs_registers.sv: "implemented counters are disabled out of
 *  reset"). Asagidaki csrw yapilmazsa mcycle HIC saymaz ve butun
 *  olcumler 0 doner.
 * ===================================================================== */
static inline void perf_init(void)
{
    __asm__ volatile ("csrw 0x320, zero");   /* mcountinhibit = 0 */
    __asm__ volatile ("csrw 0xB00, zero");   /* mcycle = 0        */
}

static inline uint32_t mcycle(void)
{
    uint32_t v;
    __asm__ volatile ("csrr %0, 0xB00" : "=r"(v));
    return v;
}

/* =====================================================================
 *  UART
 *
 *  RX genel UART'tan (Uart), TX UART_YZ'den (UartAI) -- ikisi ayri
 *  cevre birimi, ikisinin de baud boleni kurulmali.
 * ===================================================================== */
static void uart_init(void)
{
    Uart->UART_CPB   = 434u;   /* 50 MHz / 434 = 115200 baud */
    UartAI->UART_CPB = 434u;
    UartAI->UART_STP.all = 0;  /* 1 stop bit */
}

#ifndef SIMULATION
/* Genel UART'tan bir bayt al.
 * RX-ready bayragi donanimca tutuldugu icin temizlemeyi geri okuyup
 * dogruluyoruz (main_boot.c'deki urx ile ayni kalip).
 * Simulasyonda girdi .rodata'dan geldigi icin kullanilmaz. */
static uint8_t gu_getc(void)
{
    while (!Uart->UART_CFG.bit.RXREADY);
    uint8_t b = Uart->UART_RDR;
    do { Uart->UART_CFG.bit.RXREADY = 0; } while (Uart->UART_CFG.bit.RXREADY);
    return b;
}
#endif

/* UART_YZ'den bir bayt gonder. */
static void yz_putc(uint8_t b)
{
    UartAI->UART_TDR             = b;
    UartAI->UART_CFG.bit.TXSTART = 1;
    while (!UartAI->UART_CFG.bit.TXDONE);
    UartAI->UART_CFG.bit.TXDONE  = 0;
}

/* Isaretsiz ondalik bas. rv32imc'de bolme donanimda (M uzantisi), bu
 * yuzden libgcc cagrisi olusmaz. */
static void yz_put_u32(uint32_t v)
{
    char buf[10];
    int  n = 0;

    if (v == 0) { yz_putc('0'); return; }
    while (v) { buf[n++] = (char)('0' + (v % 10u)); v /= 10u; }
    while (n)  yz_putc((uint8_t)buf[--n]);
}

static void yz_puts(const char *s)
{
    while (*s) yz_putc((uint8_t)*s++);
}

/* =====================================================================
 *  7-segment: hizlandiricinin sinifini goster (main_app.c ile ayni harita)
 * ===================================================================== */
static void show_class(uint32_t cls)
{
    switch (cls) {
        case 2:  Gpio->GPIO_ODR = 7;  break;   /* Evet       */
        case 3:  Gpio->GPIO_ODR = 8;  break;   /* Hayir      */
        case 0:  Gpio->GPIO_ODR = 9;  break;   /* Sessizlik  */
        case 1:  Gpio->GPIO_ODR = 10; break;   /* Bilinmeyen */
        default: break;
    }
}

/* =====================================================================
 *  Tamponlar
 *
 *  .bss'te statik: 1960 + 4000 = 5960 bayt. Yigina konsaydi 32KB Data
 *  RAM'de yine sigardi ama yerlesimi linker'da gormek daha iyi.
 * ===================================================================== */
static uint8_t        input[YZ_REF_INPUT_LEN];
static int8_t         scratch[YZ_REF_SCRATCH_LEN];
static yz_ref_result_t ref;

int main(void)
{
    perf_init();
    uart_init();

    Gpio->GPIO_ODR = 1;            /* hazir: veri bekliyorum */

    for (;;) {
        /* ---------------------------------------------------------
         *  1) Girdiyi al
         *
         *  Kartta: PC 1960 bayti bir kez gonderir; DMA YZ RAM'i doldurur,
         *  biz de ayni baytlari genel UART'tan okuruz. Bayt arasi
         *  115200 baud'da ~4340 cevrim var, bu dongu bunun cok altinda
         *  -- bayt kacirma riski yok.
         *
         *  Simulasyonda: UART'tan 1960 bayt gondermek 8.5 M cevrim
         *  suruyor ve olcecegimiz cikarimdan uzun. Girdi .rodata'ya
         *  gomulu gelir, testbench YZ RAM'i DMA ile doldurur.
         * --------------------------------------------------------- */
#ifdef SIMULATION
        for (int i = 0; i < YZ_REF_INPUT_LEN; ++i)
            input[i] = yz_sim_input[i];
#else
        for (int i = 0; i < YZ_REF_INPUT_LEN; ++i)
            input[i] = gu_getc();
#endif

        /* DMA'nin 1960. bayti da yazmasini bekle (load_pending seviye
         * sinyalidir, kesme acmadan da okunabilir). */
        while (!YzAccel->YZ_STATUS.bit.LOAD_PENDING);

        Gpio->GPIO_ODR = 6;        /* "INFRNC": cikarim basladi */

        /* ---------------------------------------------------------
         *  2) DONANIM cikarimi
         *  YZ_CTRL bitleri donanimda pulse uretir -> alan alan degil
         *  .all ile tek yazmada verilir.
         * --------------------------------------------------------- */
        uint32_t t0 = mcycle();
        YzAccel->YZ_CTRL.all = 0x3u;              /* START | LOAD_CLEAR */
        while (!YzAccel->YZ_STATUS.bit.INFER_PENDING);
        uint32_t hw_cycles = mcycle() - t0;

        uint32_t hw_cls = YzAccel->YZ_RESULT.bit.CLASS;
        YzAccel->YZ_CTRL.all = 0x4u;              /* INFER_CLEAR */

        /* ---------------------------------------------------------
         *  3) YAZILIM cikarimi (ayni girdi)
         * --------------------------------------------------------- */
        uint32_t t1 = mcycle();
        yz_ref_infer(input, scratch, &ref);
        uint32_t sw_cycles = mcycle() - t1;

        /* ---------------------------------------------------------
         *  4) Raporla
         * --------------------------------------------------------- */
        show_class(hw_cls);

        yz_puts("YZ:");
        yz_put_u32(hw_cls);
        yz_putc('\n');

        yz_puts("SW:");
        yz_put_u32(ref.cls);
        yz_puts(" HC:");
        yz_put_u32(hw_cycles);
        yz_puts(" SC:");
        yz_put_u32(sw_cycles);
        yz_putc('\n');
    }
}
