/* =====================================================================
 *  FLASHER - ADIM 1: UART ECHO TESTI
 *  CV32E40P SoC - TEKNOFEST 2026 Cip Tasarim Yarismasi
 *
 *  Amac (izole dogrulama):
 *    - SW0 (GPIO_IDR[0]) == 1 ise "flasher modu": UART'tan gelen her
 *      bayti oldugu gibi geri yolla (echo). Bu, baud'un dogru, TX/RX'in
 *      calistigini ve UART_CFG bayrak temizleme sirasinin tuttugunu
 *      protokolden/flash'tan BAGIMSIZ olarak kanitlar.
 *    - SW0 == 0 ise "boot modu": simdilik sadece gorsel isaret (gercek
 *      boot akisi sonraki adimda entegre edilecek).
 *
 *  UART_CFG bit semantigi (UART_GU_AXI4-Lite.sv'den birebir):
 *    [0] TX start : SW 1 yazar, HW STOP state'inde 0'a ceker
 *    [1] RX ready : HW REPORT state'inde 1 yapar -- DIKKAT: REPORT
 *                   BOYUNCA HER CYCLE yeniden 1 yapiliyor. SW clear'i
 *                   REPORT penceresine denk gelirse EZILIR. Bu yuzden
 *                   clear "geri okuyunca 0 olana kadar" tekrarlanir.
 *    [2] TX done  : HW STOP state'inde 1 yapar (bir kez), SW temizler.
 * ===================================================================== */

#include "soc.h"

#define FLASHER_SWITCH_BIT  (1u << 0)   /* SW0 -> GPIO_IDR[0] (J15) */

#define CFG_TX_START  (1u << 0)
#define CFG_RX_READY  (1u << 1)
#define CFG_TX_DONE   (1u << 2)

/* 48 MHz / 115200 ~= 416. RTL RX tarafi UART_CPB[19:4] = 416>>4 = 26'yi
 * 16x oversampling limiti olarak kullaniyor (16*26 = 416 clk/bit). 416
 * 16'nin tam kati oldugu icin TX bit-suresi ile RX 16-tick toplami birebir
 * ortusiyor -> baud kaymasi birikmiyor. */
#define UART_BAUD_CPB  416u

/* -------------------------------------------------------------------- */
static void uart_init(void)
{
    Uart->UART_CPB = UART_BAUD_CPB;   /* baud boleni */
    Uart->UART_STP = 0u;              /* 1 stop bit */
    Uart->UART_CFG = 0u;              /* tum bayraklar temiz */
}

/* Bir bayt al. RX ready'yi bekle -> veriyi al -> bayragi GUVENLI temizle. */
static uint8_t uart_recv(void)
{
    while ((Uart->UART_CFG & CFG_RX_READY) == 0u) { /* RX ready bekle */ }

    uint8_t b = (uint8_t)(Uart->UART_RDR & 0xFFu);   /* ONCE veriyi al */

    /* RX ready'yi temizle. REPORT state'i biti her cycle yeniden 1 yaptigi
     * icin tek clear ezilebilir; geri okuyunca 0 olana kadar tekrarla.
     * RMW (&= ~bit) ile TX bitlerini (0,2) bozmuyoruz. */
    do {
        Uart->UART_CFG &= ~CFG_RX_READY;
    } while (Uart->UART_CFG & CFG_RX_READY);

    return b;
}

/* Bir bayt gonder. Veriyi yaz -> TX start -> TX done bekle -> bayragi temizle. */
static void uart_send(uint8_t b)
{
    Uart->UART_TDR  = b;                 /* ONCE veri (yoksa HW eski TDR'yi yollar) */
    Uart->UART_CFG |= CFG_TX_START;      /* SONRA TX start (RMW: RX bitini koru) */

    while ((Uart->UART_CFG & CFG_TX_DONE) == 0u) { /* TX done bekle */ }

    Uart->UART_CFG &= ~CFG_TX_DONE;      /* TX done'i elle temizle (HW temizlemiyor) */
}

/* -------------------------------------------------------------------- */
int main(void)
{
    uart_init();

    if (Gpio->GPIO_IDR & FLASHER_SWITCH_BIT) {
        /* ---- FLASHER MODU (Adim 1: sadece echo) ---- */
        Gpio->GPIO_ODR = 0xF1A5;         /* "flasher moduna girdim" isareti (TB handshake) */
        for (;;) {
            uint8_t b = uart_recv();
            uart_send(b);                /* geleni geri yolla */
        }
    } else {
        /* ---- BOOT MODU (simdilik sadece isaret) ---- */
        Gpio->GPIO_ODR = 0xB007;
        for (;;) { /* gercek boot akisi sonraki adimda buraya */ }
    }

    return 0;
}
