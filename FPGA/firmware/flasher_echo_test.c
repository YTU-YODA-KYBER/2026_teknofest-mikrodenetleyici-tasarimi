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
 *  UART_CFG bitleri soc.h'ta tanimlidir. Kritik nokta: RXREADY'yi HW,
 *  REPORT state'i BOYUNCA HER CYCLE yeniden 1 yapar; tek clear ezilebilir,
 *  bu yuzden clear "geri okuyunca 0 olana kadar" tekrarlanir.
 * ===================================================================== */

#include "soc.h"

/* Register/bit tanimlari soc.h'ta (Uart, Gpio).
 * Baud boleni 434: 50 MHz / 434 = 115200. RTL RX tarafi UART_CPB[19:4]'u
 * 16x oversampling limiti olarak kullanir (16 * 27 = 432 clk/bit); TX ise
 * CPB'yi dogrudan kullanir, aradaki 2 clk fark bit basina %0.5'in altinda. */

/* -------------------------------------------------------------------- */
static void uart_init(void)
{
    Uart->UART_CPB     = 434u;   /* baud boleni: 50 MHz / 434 = 115200 */
    Uart->UART_STP.all = 0u;     /* 1 stop bit */
    Uart->UART_CFG.all = 0u;     /* tum bayraklar temiz */
}

/* Bir bayt al. RX ready'yi bekle -> veriyi al -> bayragi GUVENLI temizle. */
static uint8_t uart_recv(void)
{
    while (!Uart->UART_CFG.bit.RXREADY) { /* RX ready bekle */ }

    uint8_t b = (uint8_t)(Uart->UART_RDR & 0xFFu);   /* ONCE veriyi al */

    /* RX ready'yi temizle. REPORT state'i biti her cycle yeniden 1 yaptigi
     * icin tek clear ezilebilir; geri okuyunca 0 olana kadar tekrarla.
     * Bitfield yazmasi oku-degistir-yaz oldugu icin TX bitleri (0,2) korunur. */
    do {
        Uart->UART_CFG.bit.RXREADY = 0;
    } while (Uart->UART_CFG.bit.RXREADY);

    return b;
}

/* Bir bayt gonder. Veriyi yaz -> TX start -> TX done bekle -> bayragi temizle. */
static void uart_send(uint8_t b)
{
    Uart->UART_TDR = b;                  /* ONCE veri (yoksa HW eski TDR'yi yollar) */
    Uart->UART_CFG.bit.TXSTART = 1;      /* SONRA TX start (RMW: RX bitini koru) */

    while (!Uart->UART_CFG.bit.TXDONE) { /* TX done bekle */ }

    Uart->UART_CFG.bit.TXDONE = 0;       /* TX done'i elle temizle (HW temizlemiyor) */
}

/* -------------------------------------------------------------------- */
int main(void)
{
    uart_init();

    if (Gpio->GPIO_IDR.bit.SW0) {        /* SW0 -> GPIO_IDR[0] (J15) */
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
