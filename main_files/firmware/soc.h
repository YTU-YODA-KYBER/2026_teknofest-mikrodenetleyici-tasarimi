#ifndef SOC_H
#define SOC_H

#include <stdint.h>
#include <stddef.h>

/* =====================================================================
 *  CV32E40P SoC - Donanim Soyutlama Basligi
 *  TEKNOFEST 2026 Cip Tasarim Yarismasi - Mikrodenetleyici Kategorisi
 *
 *  Erisim ornegi (TI C2000 tarzi):
 *      Timer->TIM_PRE = 0;
 *      Timer->TIM_ENA = 1;
 *      uint32_t c = Timer->TIM_CNT;
 *      Gpio->GPIO_ODR = 0xAAAA;
 *      Uart->UART_TDR = 'A';
 * ===================================================================== */

/* ---------------------------------------------------------------------
 *  Sistem saati
 * --------------------------------------------------------------------- */
#define SYS_CLK_HZ   48000000UL

/* =====================================================================
 *  TIMER  (base 0x40000000)
 * ===================================================================== */
typedef struct {
    volatile uint32_t TIM_PRE;   /* 0x00 RW prescaler (0 = sistem saati hizi) */
    volatile uint32_t TIM_ARE;   /* 0x04 RW auto-reload */
    volatile uint32_t TIM_CLR;   /* 0x08 RW [0]=1 -> CNT sifirla */
    volatile uint32_t TIM_ENA;   /* 0x0C RW [0]=1 say, 0 dur */
    volatile uint32_t TIM_MOD;   /* 0x10 RW [0]=1 yukari, 0 asagi */
    volatile uint32_t TIM_CNT;   /* 0x14 RO sayac degeri */
    volatile uint32_t TIM_EVN;   /* 0x18 RO her ARE'ye ulasimda +1 */
    volatile uint32_t TIM_EVC;   /* 0x1C RW [0]=1 -> EVN sifirla */
} Timer_t;

#define Timer  ((Timer_t *) 0x40000000UL)

/* =====================================================================
 *  GPIO  (base 0x40010000)
 *  [15:0] giris (IDR) / cikis (ODR), [31:16] etkisiz
 * ===================================================================== */
typedef struct {
    volatile uint32_t GPIO_IDR;  /* 0x00 RO giris veri */
    volatile uint32_t GPIO_ODR;  /* 0x04 RW cikis veri */
} Gpio_t;

#define Gpio  ((Gpio_t *) 0x40010000UL)

/* =====================================================================
 *  UART  (genel kullanim base 0x40040000)
 *  baud = SYS_CLK_HZ / UART_CPB
 *
 *  UART_CFG bitleri:
 *    [0] TX start  : 1 yaz -> gonderimi baslat (bitince HW 0'a ceker)
 *    [1] RX ready  : veri gelince HW 1 yapar, SW 0'a cekmeli
 *    [2] TX done   : gonderim bitince HW 1 yapar, SW 0'a cekmeli
 *  UART_STP[1:0]: 00=1bit, 01=1.5bit, 1X=2bit
 * ===================================================================== */
typedef struct {
    volatile uint32_t UART_CPB;  /* 0x00 RW clock-per-bit (baud bolen) */
    volatile uint32_t UART_STP;  /* 0x04 RW [1:0] stop bit */
    volatile uint32_t UART_RDR;  /* 0x08 RO [7:0] alinan veri */
    volatile uint32_t UART_TDR;  /* 0x0C RW [7:0] gonderilecek veri */
    volatile uint32_t UART_CFG;  /* 0x10 RW config/durum */
} Uart_t;

#define Uart    ((Uart_t *) 0x40040000UL)   /* genel kullanim UART */
#define UartAI  ((Uart_t *) 0x40050000UL)   /* YZ-stream UART       */

/* =====================================================================
 *  I2C Master  (base 0x40020000)
 *  SCL 400 kHz, 7-bit adres, 1-4 bayt. TX ve RX ayni anda enable edilemez.
 *
 *  I2C_CFG bitleri:
 *    [0] TX enable    : 1 iken TDR'yi NBY bayt gonderir
 *    [1] TX done      : gonderim bitince HW 1, SW 0'a cekmeli
 *    [2] RX enable    : 1 iken NBY bayt okur
 *    [3] RX done      : okuma bitince HW 1, SW 0'a cekmeli
 * ===================================================================== */
typedef struct {
    volatile uint32_t I2C_NBY;   /* 0x00 RW bayt sayisi (1-4) */
    volatile uint32_t I2C_ADR;   /* 0x04 RW [6:0] slave adresi */
    volatile uint32_t I2C_RDR;   /* 0x08 RO okunan veri (ilk bayt = LSB) */
    volatile uint32_t I2C_TDR;   /* 0x0C RW gonderilecek veri (LSB once) */
    volatile uint32_t I2C_CFG;   /* 0x10 RW config/durum */
} I2c_t;

#define I2c  ((I2c_t *) 0x40020000UL)

/* =====================================================================
 *  QSPI Master  (base 0x40030000)
 *  SPI mode 0, SDR, x1/x2/x4. 64x32-bit TX/RX FIFO.
 *
 *  QSPI_CCR bit alanlari:
 *    [7:0]   Instruction (flash komut degeri)
 *    [9:8]   Veri modu: 00=yok 01=x1 10=x2 11=x4
 *    [10]    0=oku 1=yaz
 *    [15:11] Dummy cycle sayisi
 *    [23:16] (deger+1) bayt
 *    [30:25] SCLK prescaler (deger+1 bolme)
 *    [31]    1=QSPI_STA temizle
 *  QSPI_STA bitleri:
 *    [0] done  [1] busy
 *    [4] RXfull [5] RXempty [6] TXfull [7] TXempty
 *    [11:8] FIFO hata kodu (0=yok 1=RXempty-read 2=TXfull-write)
 *  QSPI_FCR bitleri: [0] RX flush, [1] TX flush
 *
 *  Flash komut degerleri (MT25QL256 / uyumlu):
 *    READ=0x03 DOR=0x3B QOR=0x6B PP=0x02 QPP=0x32 SE=0xD8
 *    READ_ID=0x90 RDID=0x9F RES=0xAB RDSR1=0x05 RDSR2=0x07
 *    RDCR=0x35 WRR=0x01 WRDI=0x04 WREN=0x06 CLSR=0x30 RESET=0x99
 *
 *  QSPI_ADDR (0x14): takimin ekledigi register (PC tarafindan 1/0)
 * ===================================================================== */
typedef struct {
    volatile uint32_t QSPI_CCR;  /* 0x00 RW yazinca transfer baslar */
    volatile uint32_t QSPI_ADR;  /* 0x04 RW [23:0] flash adresi */
    volatile uint32_t QSPI_DR;   /* 0x08 RW veri (TX/RX FIFO) */
    volatile uint32_t QSPI_STA;  /* 0x0C RO durum */
    volatile uint32_t QSPI_FCR;  /* 0x10 RW FIFO flush */
    volatile uint32_t dma_start; /* 0x14 RW ek register (PC 1/0) */
} Qspi_t;

#define Qspi  ((Qspi_t *) 0x40030000UL)

#endif /* SOC_H */
