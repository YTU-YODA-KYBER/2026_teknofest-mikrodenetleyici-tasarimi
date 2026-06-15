#include "soc.h"

/* Flash'ta uygulamanin basladigi adres (byte cinsinden) */
#define APP_FLASH_ADDR   0x000000UL

/* INSTRRAM */
#define INSTRRAM_BASE    0x10000000UL
#define INSTRRAM_SIZE    (8 * 1024)           /* 8 KB            */
#define INSTRRAM_WORDS   (INSTRRAM_SIZE / 4)  /* 2048 word       */

/* QSPI RX FIFO kapasitesi: 64 x 32-bit = 256 byte.
 * Her transfer en fazla bu kadar veri tasiyabilir. */
#define CHUNK_WORDS      64
#define CHUNK_BYTES      (CHUNK_WORDS * 4)    /* 256 byte        */

/* -----------------------------------------------------------------
 * qspi_flush: RX FIFO'yu bosalt (onceki artik veriye karsi onlem)
 * ----------------------------------------------------------------- */
static void qspi_flush(void)
{
    Qspi->QSPI_FCR = 0x1;   /* QSPI_FCR[0] = RX FIFO flush */
}

/* -----------------------------------------------------------------
 * qspi_read_chunk
 *   flash_addr : Flash'ta okunacak baslangic adresi (byte)
 *   dst        : Hedef bellek adresi (32-bit pointer)
 *   words      : Okunacak word sayisi (max CHUNK_WORDS = 64)
 *
 * QSPI_CCR bit alanlari:
 *   [7:0]   = Instruction (READ = 0x03)
 *   [9:8]   = Veri modu   (01 = x1)
 *   [10]    = Yon          (0 = okuma)
 *   [15:11] = Dummy cycle  (READ icin 0)
 *   [23:16] = Bayt sayisi  (deger + 1 bayt okunur)
 *   [31]    = STA temizle
 * ----------------------------------------------------------------- */
static void qspi_read_chunk(uint32_t flash_addr,
                            volatile uint32_t *dst,
                            uint32_t words)
{
    uint32_t bytes = words * 4;

    qspi_flush();

    Qspi->QSPI_ADR = flash_addr;

    Qspi->QSPI_CCR = 0x03              /* READ komutu          */
                   | (0x1 << 8)        /* x1 veri modu         */
                   | (0x0 << 10)       /* okuma yonu           */
                   | (0x0 << 11)       /* dummy cycle yok      */
                   | ((bytes - 1) << 16); /* bayt sayisi - 1   */

    /* Transfer bitmesini bekle (QSPI_STA[0] = done) */
    while (!(Qspi->QSPI_STA & 0x1)) { }

    /* RX FIFO'daki verileri hedefe al */
    for (uint32_t i = 0; i < words; i++) {
        /* QSPI_STA[5] = RX empty; veri gelene kadar bekle */
        while (Qspi->QSPI_STA & 0x20) { }
        dst[i] = Qspi->QSPI_DR;
    }

    /* Status registerini temizle (QSPI_CCR[31] = 1) */
    Qspi->QSPI_CCR = (1U << 31);
}

/* -----------------------------------------------------------------
 * main: Bootloader giris noktasi
 *   1. Flash'taki uygulama binary'sini INSTRRAM'e kopyala
 *   2. INSTRRAM'e jump et (_start -> uygulama main)
 * ----------------------------------------------------------------- */
int main(void)
{
    volatile uint32_t *instrram = (volatile uint32_t *) INSTRRAM_BASE;
    uint32_t copied = 0;

    /* Flash -> INSTRRAM kopyalama dongusu.
     * Her iterasyonda FIFO kapasitesi kadar (max 256 byte) okunur. */
    while (copied < INSTRRAM_WORDS) {
        uint32_t remaining = INSTRRAM_WORDS - copied;
        uint32_t chunk = (remaining > CHUNK_WORDS) ? CHUNK_WORDS : remaining;

        qspi_read_chunk(APP_FLASH_ADDR + (copied * 4),
                        instrram + copied,
                        chunk);
        copied += chunk;
    }

    /* INSTRRAM'in bas adresine jump et.
     * Oradaki _start: SP'yi kurar, BSS'i sifirlar, app main()'i cagirir. */
    void (*app_entry)(void) = (void (*)(void)) INSTRRAM_BASE;
    app_entry();   /* geri donmez */

    /* Buraya asla gelinmez */
    while (1) { }
    return 0;
}
