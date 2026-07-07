/* =====================================================================
 *  Boot ROM  -  CV32E40P SoC  (TEKNOFEST 2026)
 *
 *  Reset sonrasi SW0 (GPIO_IDR[0]) modu secer:
 *    1 -> FLASHER : UART'tan app'i al, QSPI flash'a yaz, dogrula.
 *    0 -> BOOT    : flash'tan app'i QOR ile oku, DMA ile INSTRRAM'e
 *                   yaz, 0x10000000'a atla (app kendi boot.S'iyle kalkar).
 * ===================================================================== */

#include "soc.h"

/* ---- QSPI_CCR alan kurucusu ---- */
#define CCR(clr,presc,addr_en,size_m1,dummy,rw,mode,instr) \
    ( ((uint32_t)(clr)     <<31) | ((uint32_t)(presc)  <<25) | \
      ((uint32_t)(addr_en) <<24) | ((uint32_t)(size_m1)<<16) | \
      ((uint32_t)(dummy)   <<11) | ((uint32_t)(rw)     <<10) | \
      ((uint32_t)(mode)    << 8) | ((uint32_t)(instr)) )

#define M_NONE 0u
#define M_X1   1u
#define M_X4   3u
#define CMD_WREN   0x06u
#define CMD_RDSR1  0x05u
#define CMD_PP     0x02u
#define CMD_QOR    0x6Bu
#define CMD_SSE    0x20u
#define CMD_ERNVLB 0xE4u
#define DONE (1u << 0)

/* ---- konfig ---- */
#define SW_FLASHER  (1u << 0)
#define FLASH_ADDR  0x000000u      /* app'in flash'taki bas adresi          */
#define APP_BYTES   8192u          /* app boyutu: BOOT bu kadar okur;        */
                                   /* flasher'a da bu kadar bayt gonder      */
#define INSTRRAM    0x10000000u
#define MAX_APP     8192u          /* flasher erase ust siniri (sadece HW)   */
#define UART_BAUD    416u           /* 48 MHz / 115200                        */

_Static_assert(APP_BYTES % 4u == 0u && APP_BYTES <= MAX_APP, "app boyutu gecersiz");

/* ---- ortak QSPI ---- */
static inline void qspi_clr(void)  { Qspi->QSPI_CCR = CCR(1,1,0,0,0,0,0,0); }  /* STA temizle */
static inline void wait_done(void) { while (!(Qspi->QSPI_STA & DONE)); }

/* =====================================================================
 *  FLASHER  (SW0 = 1)
 * ===================================================================== */

/* adres/veri olmayan tek komut (WREN, ERNVLB) */
static void cmd_only(uint32_t instr) {
    qspi_clr();
    Qspi->QSPI_CCR = CCR(0,1,0,0,0,0,M_NONE,instr);
    wait_done();
    qspi_clr();
}

/* flash mesgul (WIP) biti temizlenene kadar bekle */
static void wait_wip(void) {
    uint32_t s;
    do {
        qspi_clr();
        Qspi->QSPI_CCR = CCR(0,1,0,0,0,0,M_X1,CMD_RDSR1);
        wait_done();
        s = Qspi->QSPI_DR;
    } while (s & 1u);
    qspi_clr();
}

/* UART bir bayt al. RX-ready REPORT boyunca donanimca tutuldugu icin
 * clear'i geri okuyunca 0 olana kadar tekrarla. */
static uint8_t urx(void) {
    while (!(Uart->UART_CFG & (1u<<1)));
    uint8_t b = Uart->UART_RDR;
    do { Uart->UART_CFG &= ~(1u<<1); } while (Uart->UART_CFG & (1u<<1));
    return b;
}

/* UART bir bayt gonder (TX-done'i elle temizle). */
static void utx(uint8_t b) {
    Uart->UART_TDR  = b;
    Uart->UART_CFG |= (1u<<0);
    while (!(Uart->UART_CFG & (1u<<2)));
    Uart->UART_CFG &= ~(1u<<2);
}

/* 4 bayt -> 32-bit (ilk gelen bayt MSB = flash / boot sirasi) */
static uint32_t urx_word(void) {
    uint32_t w = 0;
    for (int i = 0; i < 4; i++) w = (w<<8) | urx();
    return w;
}

/* n bayti UART'tan al, TX FIFO'yu doldur, PP ile yaz; word toplamini dondur */
static uint32_t pp_chunk(uint32_t addr, uint32_t n) {
    uint32_t sum = 0;
    cmd_only(CMD_WREN);
    qspi_clr();
    Qspi->QSPI_FCR = 0x3u;
    for (uint32_t i = 0; i < (n>>2); i++) {
        uint32_t w = urx_word();
        Qspi->QSPI_DR = w;
        sum += w;
    }
    Qspi->QSPI_ADR = addr;
    Qspi->QSPI_CCR = CCR(0,11,1,n-1,0,1,M_X1,CMD_PP);
    wait_done();
    wait_wip();
    return sum;
}

/* n bayti QOR ile geri oku, word toplamini dondur (dogrulama) */
static uint32_t qor_sum(uint32_t addr, uint32_t n) {
    uint32_t sum = 0;
    Qspi->QSPI_FCR = 0x3u;
    qspi_clr();
    Qspi->QSPI_ADR = addr;
    Qspi->QSPI_CCR = CCR(0,7,1,n-1,8,0,M_X4,CMD_QOR);
    wait_done();
    for (uint32_t i = 0; i < (n>>2); i++) sum += Qspi->QSPI_DR;
    Qspi->QSPI_FCR = 0x3u;
    return sum;
}

static void flasher(void) {
    Gpio->GPIO_ODR = 0x0001;         /* Flash hazır hale getiriliyor. */

    Uart->UART_CPB = UART_BAUD;       /* tek satir baud (diger UART reg'leri reset'te 0) */
    Qspi->QSPI_FCR = 0x3u;

    /* koruma kaldir (ppb_clean) */
    cmd_only(CMD_WREN);
    qspi_clr();
    Qspi->QSPI_CCR = CCR(0,1,0,0,0,0,M_NONE,CMD_ERNVLB);
    wait_done();
    wait_wip();

#ifndef FLASHER_NO_ERASE
    /* HW: hedef bolgeyi READY'den ONCE sil (akis ortasinda durma -> overrun yok).
     * sim'de -DFLASHER_NO_ERASE ile atlanir (bolge zaten 0xFF; erase cok yavas).
     * NOT: SSE'nin CCR'indaki rw/mode'u kendi calisan QSPI konfigurasyonuna gore dogrula. */

    Gpio->GPIO_ODR = 0x0001;         /* Flash hazır hale getiriliyor. */

    for (uint32_t a = FLASH_ADDR; a < FLASH_ADDR + MAX_APP; a += 4096u) {
        cmd_only(CMD_WREN);
        qspi_clr();
        Qspi->QSPI_ADR = a;
        Qspi->QSPI_CCR = CCR(0,1,1,0,0,0,M_NONE,CMD_SSE);
        wait_done();
        wait_wip();
    }
#endif

    Gpio->GPIO_ODR = 0x0002;         /* hazir: LENGTH + veri bekliyorum */

    uint32_t total = urx_word();     /* LENGTH (MSB-first) */

    /* yazma: chunk basina ACK (flow control -> overrun yok) */
    uint32_t addr = FLASH_ADDR, rem = total, wsum = 0;
    while (rem) {
        uint32_t n = (rem >= 256u) ? 256u : rem;
        wsum += pp_chunk(addr, n);
        utx(0x06);                   /* ACK -> PC sonraki chunk'i gonderebilir */
        addr += n; rem -= n;
    }

    /* dogrula: geri oku, checksum karsilastir */
    uint32_t rsum = 0;
    addr = FLASH_ADDR; rem = total;
    while (rem) {
        uint32_t n = (rem >= 256u) ? 256u : rem;
        rsum += qor_sum(addr, n);
        addr += n; rem -= n;
    }

    Gpio->GPIO_ODR = (wsum == rsum) ? 0x0003u : 0x0004u;
}

/* =====================================================================
 *  BOOT  (SW0 = 0)
 * ===================================================================== */
static void boot(void) {
    uint32_t addr = FLASH_ADDR, rem = APP_BYTES;
    while (rem) {
        uint32_t n = (rem >= 256u) ? 256u : rem;
        qspi_clr();
        Qspi->QSPI_ADR = addr;
        Qspi->QSPI_CCR = CCR(0,7,1,n-1,8,0,M_X4,CMD_QOR);  /* QOR oku -> RX FIFO */
        wait_done();
        Qspi->dma_start = 1;                                /* DMA: RX FIFO -> INSTRRAM */
        while (Qspi->dma_start);                            /* dma_valid dusene (drain bitti) kadar */
        addr += n; rem -= n;
    }
    ((void (*)(void)) INSTRRAM)();   /* app'e atla; geri donmez */
}

/* =====================================================================
 *  main: switch'e gore dallan
 * ===================================================================== */
int main(void) {
    if (Gpio->GPIO_IDR & SW_FLASHER) flasher();
    else                             boot();
    for (;;);
    return 0;
}
