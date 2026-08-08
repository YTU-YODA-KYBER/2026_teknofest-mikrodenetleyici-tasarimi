/* =====================================================================
 *  Boot ROM  -  CV32E40P SoC  (TEKNOFEST 2026)
 *
 *  Reset sonrasi SW0 (GPIO_IDR[0]) modu secer:
 *    1 -> FLASHER : UART'tan app'i al, QSPI flash'a yaz, dogrula.
 *    0 -> BOOT    : flash'tan app'i QOR ile oku, DMA ile INSTRRAM'e
 *                   yaz, 0x10000000'a atla (app kendi boot.S'iyle kalkar).
 * ===================================================================== */

#include "soc.h"

/* ---- konfig ---- */
#define FLASH_ADDR  0x000000u      /* app'in flash'taki bas adresi          */
#define APP_BYTES   8192u          /* app boyutu: BOOT bu kadar okur;        */
                                   /* flasher'a da bu kadar bayt gonder      */
#define MAX_APP     8192u          /* flasher erase ust siniri (sadece HW)   */

_Static_assert(APP_BYTES % 4u == 0u && APP_BYTES <= MAX_APP, "app boyutu gecersiz");

/* ---- ortak QSPI ----
 * CCR'a yazmak transferi baslattigi icin deger daima tek seferde kurulur. */
static inline void qspi_clr(void)  { Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(1,1,0,0,0,0,0,0); }  /* STA temizle */
static inline void wait_done(void) { while (!Qspi->QSPI_STA.bit.DONE); }

/* =====================================================================
 *  FLASHER  (SW0 = 1)
 * ===================================================================== */

/* adres/veri olmayan tek komut (WREN, ERNVLB) */
static void cmd_only(uint32_t instr) {
    qspi_clr();
    Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(0,1,0,0,0,0,0,instr);
    wait_done();
    qspi_clr();
}

/* flash mesgul (WIP) biti temizlenene kadar bekle */
static void wait_wip(void) {
    uint32_t s;
    do {
        qspi_clr();
        Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(0,1,0,0,0,0,1,0x05);  /* x1 mod, RDSR1 */
        wait_done();
        s = Qspi->QSPI_DR;
    } while (s & 1u);                    /* SR1[0] = WIP */
    qspi_clr();
}

/* UART bir bayt al. RX-ready REPORT boyunca donanimca tutuldugu icin
 * clear'i geri okuyunca 0 olana kadar tekrarla. */
static uint8_t urx(void) {
    while (!Uart->UART_CFG.bit.RXREADY);
    uint8_t b = Uart->UART_RDR;
    do { Uart->UART_CFG.bit.RXREADY = 0; } while (Uart->UART_CFG.bit.RXREADY);
    return b;
}

/* UART bir bayt gonder (TX-done'i elle temizle). */
static void utx(uint8_t b) {
    Uart->UART_TDR = b;
    Uart->UART_CFG.bit.TXSTART = 1;
    while (!Uart->UART_CFG.bit.TXDONE);
    Uart->UART_CFG.bit.TXDONE = 0;
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
    cmd_only(0x06);                  /* WREN */
    qspi_clr();
    Qspi->QSPI_FCR.all = 0x3u;       /* RX + TX FIFO flush */
    for (uint32_t i = 0; i < (n>>2); i++) {
        uint32_t w = urx_word();
        Qspi->QSPI_DR = w;
        sum += w;
    }
    Qspi->QSPI_ADR = addr;
    Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(0,11,1,n-1,0,1,1,0x02);  /* x1 yaz, PP */
    wait_done();
    wait_wip();
    return sum;
}

/* n bayti QOR ile geri oku, word toplamini dondur (dogrulama) */
static uint32_t qor_sum(uint32_t addr, uint32_t n) {
    uint32_t sum = 0;
    Qspi->QSPI_FCR.all = 0x3u;       /* RX + TX FIFO flush */
    qspi_clr();
    Qspi->QSPI_ADR = addr;
    Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(0,7,1,n-1,8,0,3,0x6B);  /* x4 oku, QOR */
    wait_done();
    for (uint32_t i = 0; i < (n>>2); i++) sum += Qspi->QSPI_DR;
    Qspi->QSPI_FCR.all = 0x3u;       /* RX + TX FIFO flush */
    return sum;
}

static void flasher(void) {
    Gpio->GPIO_ODR = 0x0001;         /* Flash hazır hale getiriliyor. */

    Uart->UART_CPB = 434u;            /* 50 MHz / 434 = 115200 baud (diger UART reg'leri reset'te 0) */
    Qspi->QSPI_FCR.all = 0x3u;       /* RX + TX FIFO flush */

    /* koruma kaldir (ppb_clean) */
    cmd_only(0x06);                  /* WREN */
    qspi_clr();
    Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(0,1,0,0,0,0,0,0xE4);  /* ERNVLB */
    wait_done();
    wait_wip();

#ifndef FLASHER_NO_ERASE
    /* HW: hedef bolgeyi READY'den ONCE sil (akis ortasinda durma -> overrun yok).
     * sim'de -DFLASHER_NO_ERASE ile atlanir (bolge zaten 0xFF; erase cok yavas).
     * NOT: SSE'nin CCR'indaki rw/mode'u kendi calisan QSPI konfigurasyonuna gore dogrula. */

    Gpio->GPIO_ODR = 0x0001;         /* Flash hazır hale getiriliyor. */

    for (uint32_t a = FLASH_ADDR; a < FLASH_ADDR + MAX_APP; a += 4096u) {
        cmd_only(0x06);                  /* WREN */
        qspi_clr();
        Qspi->QSPI_ADR = a;
        Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(0,1,1,0,0,0,0,0x20);  /* SSE (4 KB sil) */
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
        Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(0,7,1,n-1,8,0,3,0x6B);  /* x4 oku, QOR -> RX FIFO */
        wait_done();
        Qspi->QSPI_DMA.all = 1;                    /* DMA: RX FIFO -> INSTRRAM (tek yazma) */
        while (Qspi->QSPI_DMA.bit.START);          /* okurken dma_valid: drain bitene kadar */
        addr += n; rem -= n;
    }
    ((void (*)(void)) INSTRRAM_BASE)();   /* app'e atla; geri donmez */
}

/* =====================================================================
 *  main: switch'e gore dallan
 * ===================================================================== */
int main(void) {
    if (Gpio->GPIO_IDR.bit.SW0) flasher();
    else                        boot();
    for (;;);
    return 0;
}
