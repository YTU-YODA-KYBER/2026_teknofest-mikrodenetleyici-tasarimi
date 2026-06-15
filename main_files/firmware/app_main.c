#include "soc.h"

/* Kaba gecikme - volatile parametre sayesinde optimizer tarafindan
 * atilmaz; bare-metal timing icin zorunludur. */
static void delay(volatile uint32_t n)
{
    while (n--) { }
}

int main(void)
{
    /* ---------------- TIMER ----------------
     * Sistem saati hizinda yukari say, 0xFF'te sifirla */
    Timer->TIM_PRE = 0;          /* bolme yok                */
    Timer->TIM_ARE = 0xFF;       /* 0xFF'te auto-reload      */
    Timer->TIM_MOD = 1;          /* 1 = yukari say           */
    Timer->TIM_ENA = 1;          /* sayaci baslat            */
    /* oku: uint32_t now = Timer->TIM_CNT; */

    /* ---------------- GPIO ----------------- */
    Gpio->GPIO_ODR = 0xAAAA;     /* cikis deseni             */
    /* oku: uint32_t in = Gpio->GPIO_IDR & 0xFFFF; */

    /* ---------------- UART -----------------
     * baud = 48 MHz / 416 = 115200 */
    Uart->UART_CPB = 416;
    Uart->UART_STP = 0;          /* 1 stop bit               */

    Uart->UART_TDR = 'O';
    Uart->UART_CFG = 1;                         /* TX start              */
    while (!(Uart->UART_CFG & 0x4)) { }         /* TX done bekle ([2])   */
    Uart->UART_CFG &= ~0x4;                     /* TX done temizle       */

    Uart->UART_TDR = 'K';
    Uart->UART_CFG = 1;
    while (!(Uart->UART_CFG & 0x4)) { }
    Uart->UART_CFG &= ~0x4;

    /* UART RX ornegi:
     *   while (!(Uart->UART_CFG & 0x2)) { }   // RX ready ([1])
     *   uint8_t c = Uart->UART_RDR & 0xFF;
     *   Uart->UART_CFG &= ~0x2;
     */

    /* ---------------- I2C ------------------
     * Slave 0x50'ye 2 bayt yaz */
    I2c->I2C_NBY = 2;
    I2c->I2C_ADR = 0x50;
    I2c->I2C_TDR = 0xABCD;      /* LSB once: 0xCD sonra 0xAB */
    I2c->I2C_CFG = 0x1;         /* TX enable ([0])           */
    while (!(I2c->I2C_CFG & 0x2)) { }           /* TX done ([1])         */
    I2c->I2C_CFG &= ~0x3;                       /* enable+done temizle   */

    /* I2C RX ornegi:
     *   I2c->I2C_NBY = 2;
     *   I2c->I2C_ADR = 0x50;
     *   I2c->I2C_CFG = 0x4;                  // RX enable ([2])
     *   while (!(I2c->I2C_CFG & 0x8)) { }    // RX done ([3])
     *   uint32_t d = I2c->I2C_RDR;
     *   I2c->I2C_CFG &= ~0xC;
     */

    /* ---------------- QSPI -----------------
     * Flash JEDEC ID oku (RDID=0x9F, 3 bayt, x1) */
    Qspi->QSPI_ADR = 0x000000;
    Qspi->QSPI_CCR = 0x9F | (0x1 << 8) | (2 << 16);
    while (!(Qspi->QSPI_STA & 0x1)) { }         /* done ([0])            */
    /* uint32_t id = Qspi->QSPI_DR; */
    Qspi->QSPI_CCR = (1U << 31);               /* STA temizle           */

    /* ---------------- Ana dongu ------------
     * UART'tan periyodik karakter */
    while (1) {
        Uart->UART_TDR = '.';
        Uart->UART_CFG = 1;
        while (!(Uart->UART_CFG & 0x4)) { }
        Uart->UART_CFG &= ~0x4;
        delay(50000);
    }

    return 0;
}
