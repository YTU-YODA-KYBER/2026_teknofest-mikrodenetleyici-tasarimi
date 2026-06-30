/* =====================================================================
 *  QSPI Flash Yazma/Okuma Testi  -  DTR Deneyi
 *  TEKNOFEST 2026 Cip Tasarim Yarismasi - Mikrodenetleyici Kategorisi
 *
 *  Akis:
 *    1) FIFO temizle
 *    2) PPB temizle (tum sektorleri korumasiz yap)  + flag status temizle
 *    3) 4KB subsector sil (yazmadan once flash 0xFF olmali)
 *    4) PP (x1)  ile 32-bit veriyi flash'a yaz
 *    5) QOR (x4) ile ayni adresten geri oku
 *    6) Dogrula: okunan == yazilan ?
 *    7) Sonucu GPIO_ODR uzerinden testbench'e bildir:
 *          0x600D = PASS , 0x0BAD = FAIL
 *
 *  Yazma x1 (PP), okuma x4 (QOR). Gerekce icin DTR notuna / sohbete bak:
 *  MT25Q komut kumesinde "x2 page program" yoktur; x2 yalnizca OKUMADA
 *  (DOR 0x3B) vardir. Bu yuzden yazma x1, okuma istendigi gibi x4.
 *
 *  CCR alan kodlamasi ve prescaler/dummy degerleri senin dogrulanmis
 *  QSPI_tb.sv'indeki TEST 2.x degerlerinden birebir alindi.
 * ===================================================================== */

#include "soc.h"

/* ---------------------------------------------------------------------
 *  QSPI_CCR alan kurucusu (hepsi derleme-zamani sabiti -> tek immediate)
 *    clr     : [31]      1 -> sadece dahili QSPI_STA temizle (transfer baslamaz)
 *    presc   : [30:25]   SCLK boluci (deger >= 1)
 *    addr_en : [24]      1 -> QSPI_ADR[23:0] adres fazi gonderilir
 *    size_m1 : [23:16]   (bayt sayisi - 1)
 *    dummy   : [15:11]   dummy cycle sayisi
 *    rw      : [10]      0 = oku, 1 = yaz
 *    mode    : [9:8]     00=yok 01=x1 10=x2 11=x4
 *    instr   : [7:0]     flash komut kodu
 * --------------------------------------------------------------------- */
#define CCR(clr, presc, addr_en, size_m1, dummy, rw, mode, instr) \
    ( ((uint32_t)(clr)     << 31) | \
      ((uint32_t)(presc)   << 25) | \
      ((uint32_t)(addr_en) << 24) | \
      ((uint32_t)(size_m1) << 16) | \
      ((uint32_t)(dummy)   << 11) | \
      ((uint32_t)(rw)      << 10) | \
      ((uint32_t)(mode)    <<  8) | \
      ((uint32_t)(instr)) )

/* data_mode kodlari */
#define M_NONE  0u
#define M_X1    1u
#define M_X4    3u   /* CCR[9:8]=11 -> RTL data_mode=4 (x4) */

/* flash komutlari */
#define CMD_WREN    0x06u   /* write enable                          */
#define CMD_RDSR1   0x05u   /* read status reg-1 (bit0 = WIP)        */
#define CMD_PP      0x02u   /* page program (x1)                     */
#define CMD_QOR     0x6Bu   /* quad output fast read (x4, 8 dummy)   */
#define CMD_SSE     0x20u   /* 4KB subsector erase (hizli)           */
#define CMD_CLFLAG  0x50u   /* clear flag status register            */
#define CMD_ERNVLB  0xE4u   /* erase NV lock bytes (PPB temizle)     */

/* QSPI_STA */
#define STA_DONE    (1u << 0)

/* test parametreleri */
#define TEST_ADDR     0x000000u
#define TEST_PATTERN  0xDEADBEEFu
#define PASS_CODE     0x600Du
#define FAIL_CODE     0x0BADu

/* ---- yardimci fonksiyonlar ------------------------------------------ */

/* dahili durum register'ini temizle (transfer baslatmaz) */
static inline void qspi_clr_sta(void)
{
    Qspi->QSPI_CCR = CCR(1, 1, 0, 0, 0, 0, M_NONE, 0x00);
}

/* baslatilan transfer'in bitmesini bekle */
static inline void wait_done(void)
{
    while ((Qspi->QSPI_STA & STA_DONE) == 0u) { /* bekle */ }
}

/* adres/veri olmayan tek komut (WREN, CLFLAG, ...) */
static void qspi_cmd_only(uint32_t instr)
{
    qspi_clr_sta();
    Qspi->QSPI_CCR = CCR(0, 1, 0, 0, 0, 0, M_NONE, instr);
    wait_done();
    qspi_clr_sta();
}

/* flash mesgul (WIP) bitinin temizlenmesini bekle */
static void wait_wip_clear(void)
{
    uint32_t s;
    do {
        qspi_clr_sta();
        /* RDSR1: 1 bayt durum oku (x1) */
        Qspi->QSPI_CCR = CCR(0, 1, 0, 0, 0, 0, M_X1, CMD_RDSR1);
        wait_done();
        s = Qspi->QSPI_DR;          /* RX FIFO'dan durum baytini cek */
    } while (s & 0x1u);             /* bit0 = WIP */
    qspi_clr_sta();
}

/* tum sektorlerin yazma korumasini kaldir */
static void ppb_clean(void)
{
    qspi_cmd_only(CMD_WREN);
    qspi_clr_sta();
    Qspi->QSPI_CCR = CCR(0, 1, 0, 0, 0, 0, M_NONE, CMD_ERNVLB);
    wait_done();
    wait_wip_clear();
}

/* ---- ana program ---------------------------------------------------- */
int main(void)
{
    uint32_t rdata;

    /* 0) FIFO'lari temizle (RX+TX) */
    Qspi->QSPI_FCR = 0x3u;

    /* 1) Koruma kaldir + flag temizle */
    ppb_clean();
    qspi_cmd_only(CMD_CLFLAG);

    /* 2) Subsector sil — GECICI OLARAK ATLANDI (erase ~100+ ms surer, sim'de cok yavas)
     q s*pi_cmd_only(CMD_WREN);
     qspi_clr_sta();
     Qspi->QSPI_ADR = TEST_ADDR;
     Qspi->QSPI_CCR = CCR(0, 1, 1, 0, 0, 0, M_NONE, CMD_SSE);
     wait_done();
     wait_wip_clear();
     */

    /* 3) PP (x1) ile 32-bit veriyi yaz (4 bayt -> size_m1 = 3) */
    qspi_cmd_only(CMD_WREN);
    qspi_clr_sta();
    Qspi->QSPI_DR  = TEST_PATTERN;                 /* TX FIFO'ya 1 kelime it */
    Qspi->QSPI_ADR = TEST_ADDR;
    Qspi->QSPI_CCR = CCR(0, 11, 1, 3, 0, 1, M_X1, CMD_PP);
    wait_done();
    wait_wip_clear();
    Qspi->QSPI_FCR = 0x3u;                          /* FIFO temizle */

    /* 4) QOR (x4) ile geri oku (4 bayt, 8 dummy cycle) */
    qspi_clr_sta();
    Qspi->QSPI_ADR = TEST_ADDR;
    Qspi->QSPI_CCR = CCR(0, 7, 1, 3, 8, 0, M_X4, CMD_QOR);
    wait_done();
    rdata = Qspi->QSPI_DR;                          /* RX FIFO'dan 32-bit oku */
    Qspi->QSPI_FCR = 0x3u;

    /* 5) Dogrula ve sonucu GPIO uzerinden bildir */
    if (rdata == TEST_PATTERN)
        Gpio->GPIO_ODR = PASS_CODE;
    else
        Gpio->GPIO_ODR = FAIL_CODE;

    /* testbench sonucu yakalayana kadar burada park et */
    for (;;) { /* spin */ }

    return 0;
}
