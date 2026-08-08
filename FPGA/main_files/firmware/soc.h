#ifndef SOC_H
#define SOC_H

#include <stdint.h>
#include <stddef.h>

/* =====================================================================
 *  CV32E40P SoC - Donanim Soyutlama Basligi
 *  TEKNOFEST 2026 Cip Tasarim Yarismasi - Mikrodenetleyici Kategorisi
 *
 *  Butun cevre birimi register'lari burada tanimlidir; .c dosyalari
 *  sadece "soc.h"i include eder, kendi adres/bit tanimlarini YAPMAZ.
 *
 *  Bu baslik SADECE register haritasini (struct + union + base adres)
 *  verir. Register'lara yazilan degerler .c dosyalarinda dogrudan sayi
 *  olarak yazilir (flash komutu, veri modu, baud boleni, sinif indeksi...);
 *  bunlarin anlami asagida ilgili register'in yorumunda tablo halindedir.
 *
 *  ERISIM STILI:
 *    - Bit alani olan register'lar union'dir:
 *          Uart->UART_CFG.all      -> 32-bit tamami (tek erisim)
 *          Uart->UART_CFG.bit.TXDONE -> tek bit
 *    - Sadece sayisal deger tutanlar (sayac, bolen, veri) duz uint32'dir:
 *          Timer->TIM_ARE = 1000;
 *          Uart->UART_TDR = 'A';
 *
 *  DIKKAT - bitfield yazmasi daima OKU-DEGISTIR-YAZ'dir:
 *    Donanim tarafindan surulen bayraklar (UART_CFG[1] gibi HW'in her
 *    cycle 1 yaptigi bitler) tek clear ile silinmeyebilir; geri okuyup
 *    dogrulayan bir dongu gerekir. Yazmanin kendisi bir OLAY tetikliyorsa
 *    (QSPI_CCR -> transfer basi, YZ_CTRL -> pulse) alan alan degil, degeri
 *    tek seferde .all ile yaz. QSPI_CCR icin QSPI_CCR_MAKE() makrosu var.
 *
 *  Bitfield'lar LSB'den baslar (RISC-V little-endian, GCC bit sirasi) ve
 *  container uint32 oldugu icin derleyici 32-bit lw/sw uretir -- AXI4-Lite
 *  bayt erisimi kabul etmedigi icin bu sart (Makefile: -fstrict-volatile-bitfields).
 * ===================================================================== */

/* ---------------------------------------------------------------------
 *  Sistem saati
 *  fpga_top icindeki clk_wiz_0: 100 MHz * 10 / 20 = 50 MHz.
 * --------------------------------------------------------------------- */
#define SYS_CLK_HZ   50000000UL

/* ---------------------------------------------------------------------
 *  Bellek haritasi (AXI4_Interconnect.sv'deki sel_* ile ayni olmali)
 * --------------------------------------------------------------------- */
#define BOOTROM_BASE   0x00000000UL   /* Boot ROM       1 KB  */
#define INSTRRAM_BASE  0x10000000UL   /* Instruction RAM 8 KB */
#define MTVEC_BASE     0x1F000000UL   /* trap vektoru         */
#define DATARAM_BASE   0x20000000UL   /* Data RAM        8 KB */

/* =====================================================================
 *  TIMER  (base 0x40000000)
 *  Sayma hizi = SYS_CLK_HZ / (TIM_PRE + 1).  TIM_ARE'ye ulasinca
 *  TIM_EVN bir artar ve sayac basa doner.
 * ===================================================================== */
typedef union {
    uint32_t all;
    struct {
        uint32_t CLR  : 1;   /* [0] 1 yaz -> TIM_CNT sifirlanir (HW geri 0 yapar) */
        uint32_t rsvd : 31;
    } bit;
} TIM_CLR_t;

typedef union {
    uint32_t all;
    struct {
        uint32_t ENA  : 1;   /* [0] 1 = say, 0 = dur */
        uint32_t rsvd : 31;
    } bit;
} TIM_ENA_t;

typedef union {
    uint32_t all;
    struct {
        uint32_t UP   : 1;   /* [0] 1 = yukari sayici, 0 = asagi sayici */
        uint32_t rsvd : 31;
    } bit;
} TIM_MOD_t;

typedef union {
    uint32_t all;
    struct {
        uint32_t CLR  : 1;   /* [0] 1 yaz -> TIM_EVN sifirlanir (HW geri 0 yapar) */
        uint32_t rsvd : 31;
    } bit;
} TIM_EVC_t;

typedef struct {
    volatile uint32_t  TIM_PRE;   /* 0x00 RW prescaler (0 = sistem saati hizi)   */
    volatile uint32_t  TIM_ARE;   /* 0x04 RW auto-reload (sayma siniri)          */
    volatile TIM_CLR_t TIM_CLR;   /* 0x08 RW sayac sifirla                       */
    volatile TIM_ENA_t TIM_ENA;   /* 0x0C RW sayaci calistir/durdur              */
    volatile TIM_MOD_t TIM_MOD;   /* 0x10 RW sayma yonu                          */
    volatile uint32_t  TIM_CNT;   /* 0x14 RO anlik sayac degeri                  */
    volatile uint32_t  TIM_EVN;   /* 0x18 RO ARE'ye her ulasimda +1              */
    volatile TIM_EVC_t TIM_EVC;   /* 0x1C RW olay sayacini sifirla               */
} Timer_t;

#define Timer  ((Timer_t *) 0x40000000UL)

/* =====================================================================
 *  GPIO  (base 0x40010000)
 *  IDR: 16 switch (SW0..SW15), ODR: [15:0] -> LED / 7-segment.
 *  GPIO_AXI4_Lite.sv ayni zamanda 7-segment surucusudur: gosterilecek
 *  degeri ODR'den, gosterim modunu IDR[1:0]'dan alir.
 * ===================================================================== */
typedef union {
    uint32_t all;
    struct {
        uint32_t SW0  : 1;   /* [0] 1 = flasher modu, 0 = flash'tan boot */
        uint32_t SW1  : 1;   /* [1] 1 = YZ-UART modu (uart_mux secimi)   */
        uint32_t SW   : 14;  /* [15:2] kalan switch'ler                  */
        uint32_t rsvd : 16;  /* [31:16] donanimda yok                    */
    } bit;
} GPIO_IDR_t;

typedef struct {
    volatile GPIO_IDR_t GPIO_IDR;  /* 0x00 RO giris (switch) */
    volatile uint32_t   GPIO_ODR;  /* 0x04 RW cikis [15:0]   */
} Gpio_t;

#define Gpio  ((Gpio_t *) 0x40010000UL)

/* =====================================================================
 *  UART  (genel kullanim 0x40040000, YZ veri akisi 0x40050000)
 *  Iki cevre birimi register bazinda birebir aynidir; UART_YZ ek olarak
 *  aldigi bayti DMA ile YZ bellegine yazar. Ikisi de ayni fiziksel pine
 *  baglidir, uart_mux SW1 ile birini secer.
 *
 *  baud = 50 MHz / UART_CPB.  TX bit suresi dogrudan CPB'dir; RX tarafi
 *  CPB[19:4]'u 16x oversampling limiti olarak kullanir, bu yuzden CPB'yi
 *  16'nin kati secmek RX/TX kaymasini engeller.
 *
 *  Sik kullanilan bolenler (CPB olarak dogrudan yazilir):
 *      115200 -> 434     230400 -> 217     9600 -> 5208
 * ===================================================================== */

typedef union {
    uint32_t all;
    struct {
        uint32_t STP  : 2;   /* [1:0] 00 = 1 bit, 01 = 1.5 bit, 1X = 2 bit */
        uint32_t rsvd : 30;
    } bit;
} UART_STP_t;

typedef union {
    uint32_t all;
    struct {
        uint32_t TXSTART : 1;  /* [0] SW 1 yazar -> gonderim baslar, HW 0'a ceker   */
        uint32_t RXREADY : 1;  /* [1] HW 1 yapar (REPORT boyunca!), SW 0'a cekmeli  */
        uint32_t TXDONE  : 1;  /* [2] HW 1 yapar, SW 0'a cekmeli                    */
        uint32_t rsvd    : 29;
    } bit;
} UART_CFG_t;

typedef struct {
    volatile uint32_t   UART_CPB;  /* 0x00 RW clock-per-bit (baud bolen) */
    volatile UART_STP_t UART_STP;  /* 0x04 RW stop bit                   */
    volatile uint32_t   UART_RDR;  /* 0x08 RO [7:0] alinan veri          */
    volatile uint32_t   UART_TDR;  /* 0x0C RW [7:0] gonderilecek veri    */
    volatile UART_CFG_t UART_CFG;  /* 0x10 RW kontrol/durum bayraklari   */
} Uart_t;

#define Uart    ((Uart_t *) 0x40040000UL)   /* genel kullanim UART */
#define UartAI  ((Uart_t *) 0x40050000UL)   /* YZ-stream UART      */

/* =====================================================================
 *  I2C Master  (base 0x40020000)
 *  SCL 400 kHz, 7-bit adres, transfer basina 1-4 bayt.
 *  TX ve RX ayni anda enable EDILEMEZ.
 * ===================================================================== */
typedef union {
    uint32_t all;
    struct {
        uint32_t TXEN   : 1;  /* [0] 1 iken TDR'yi NBY bayt gonderir       */
        uint32_t TXDONE : 1;  /* [1] HW 1 yapar; I2C_CLR.TXDONE ile silinir */
        uint32_t RXEN   : 1;  /* [2] 1 iken NBY bayt okur                  */
        uint32_t RXDONE : 1;  /* [3] HW 1 yapar; I2C_CLR.RXDONE ile silinir */
        uint32_t rsvd   : 28;
    } bit;
} I2C_CFG_t;

typedef union {
    uint32_t all;
    struct {
        uint32_t TXDONE : 1;  /* [0] 1 yaz -> I2C_CFG.TXDONE temizlenir */
        uint32_t RXDONE : 1;  /* [1] 1 yaz -> I2C_CFG.RXDONE temizlenir */
        uint32_t rsvd   : 30;
    } bit;
} I2C_CLR_t;

typedef struct {
    volatile uint32_t  I2C_NBY;   /* 0x00 RW bayt sayisi (HW 1-4 arasina kirpar)   */
    volatile uint32_t  I2C_ADR;   /* 0x04 RW [6:0] slave adresi                    */
    volatile uint32_t  I2C_RDR;   /* 0x08 RO okunan veri (ilk bayt = LSB)          */
    volatile uint32_t  I2C_TDR;   /* 0x0C RW gonderilecek veri (LSB once)          */
    volatile I2C_CFG_t I2C_CFG;   /* 0x10 RW kontrol/durum                         */
    volatile I2C_CLR_t I2C_CLR;   /* 0x14 WO done bayraklarini temizle             */
} I2c_t;

#define I2c  ((I2c_t *) 0x40020000UL)

/* =====================================================================
 *  QSPI Master  (base 0x40030000)
 *  SPI mode 0, SDR, x1/x2/x4 veri modu, 64 x 32-bit TX/RX FIFO.
 *
 *  QSPI_CCR'a YAZMAK TRANSFERI BASLATIR -> alan alan yazma, degeri tek
 *  seferde kur:  Qspi->QSPI_CCR.all = QSPI_CCR_MAKE(...);
 * ===================================================================== */
typedef union {
    uint32_t all;
    struct {
        uint32_t INSTR   : 8;  /* [7:0]   flash komut degeri (asagidaki tablo)  */
        uint32_t MODE    : 2;  /* [9:8]   veri modu: 0=yok 1=x1 2=x2 3=x4       */
        uint32_t RW      : 1;  /* [10]    0 = oku, 1 = yaz                      */
        uint32_t DUMMY   : 5;  /* [15:11] dummy cycle sayisi                    */
        uint32_t SIZE_M1 : 8;  /* [23:16] veri uzunlugu - 1 (bayt)              */
        uint32_t ADDR_EN : 1;  /* [24]    1 = QSPI_ADR'yi de gonder             */
        uint32_t PRESC   : 6;  /* [30:25] SCLK prescaler (deger kadar bolme)    */
        uint32_t CLR     : 1;  /* [31]    1 = QSPI_STA'yi temizle               */
    } bit;
} QSPI_CCR_t;

/* CCR degerini tek seferde kurmak icin (bit alanlariyla ayni sira degil,
 * okurken en anlamli alandan basladigi icin CCR yorumuyla ayni duzende). */
#define QSPI_CCR_MAKE(clr, presc, addr_en, size_m1, dummy, rw, mode, instr) \
    ( ((uint32_t)(clr)     << 31) | ((uint32_t)(presc)   << 25) |           \
      ((uint32_t)(addr_en) << 24) | ((uint32_t)(size_m1) << 16) |           \
      ((uint32_t)(dummy)   << 11) | ((uint32_t)(rw)      << 10) |           \
      ((uint32_t)(mode)    <<  8) | ((uint32_t)(instr)) )

typedef union {
    uint32_t all;
    struct {
        uint32_t DONE    : 1;  /* [0]     transfer bitti                       */
        uint32_t BUSY    : 1;  /* [1]     transfer suruyor                     */
        uint32_t rsvd0   : 2;  /* [3:2]                                        */
        uint32_t RXFULL  : 1;  /* [4]     RX FIFO dolu  (64 kelime)            */
        uint32_t RXEMPTY : 1;  /* [5]     RX FIFO bos                          */
        uint32_t TXFULL  : 1;  /* [6]     TX FIFO dolu                         */
        uint32_t TXEMPTY : 1;  /* [7]     TX FIFO bos                          */
        uint32_t ERR     : 4;  /* [11:8]  0=yok 1=bos RX okundu 2=dolu TX'e yazildi */
        uint32_t rsvd1   : 20;
    } bit;
} QSPI_STA_t;

typedef union {
    uint32_t all;
    struct {
        uint32_t RXFLUSH : 1;  /* [0] RX FIFO bosalt */
        uint32_t TXFLUSH : 1;  /* [1] TX FIFO bosalt */
        uint32_t rsvd    : 30;
    } bit;
} QSPI_FCR_t;

typedef union {
    uint32_t all;
    struct {
        uint32_t START : 1;  /* [0] yazarken: DMA basla / okurken: DMA hala aktif */
        uint32_t rsvd  : 31;
    } bit;
} QSPI_DMA_t;

typedef struct {
    volatile QSPI_CCR_t QSPI_CCR;  /* 0x00 RW yazinca transfer baslar          */
    volatile uint32_t   QSPI_ADR;  /* 0x04 RW [23:0] flash adresi              */
    volatile uint32_t   QSPI_DR;   /* 0x08 RW veri (yaz -> TX FIFO, oku -> RX) */
    volatile QSPI_STA_t QSPI_STA;  /* 0x0C RO durum                            */
    volatile QSPI_FCR_t QSPI_FCR;  /* 0x10 RW FIFO flush                       */
    volatile QSPI_DMA_t QSPI_DMA;  /* 0x14 RW yaz = dma_start, oku = dma_valid */
} Qspi_t;

#define Qspi  ((Qspi_t *) 0x40030000UL)

/* ---------------------------------------------------------------------
 *  QSPI_CCR.INSTR alanina yazilacak flash komut degerleri
 *  (MT25QL256 / uyumlu). Kodda dogrudan sayi olarak yazilir.
 *
 *    0x03 READ     normal oku            0x02 PP     page program
 *    0x3B DOR      dual output read      0x32 QPP    quad page program
 *    0x6B QOR      quad output read      0x20 SSE    4 KB sektor sil
 *    0x05 RDSR1    durum reg. 1          0xD8 SE     64 KB sektor sil
 *                  ([0] = WIP, 1 = yazma/silme suruyor)
 *    0x07 RDSR2    durum reg. 2          0x06 WREN   yazma izni
 *    0x35 RDCR     konfig reg.           0x04 WRDI   yazma iznini kaldir
 *    0x01 WRR      durum reg. yaz        0x30 CLSR   hata bayraklarini sil
 *    0x9F RDID     JEDEC ID              0x99 RESET
 *    0x90 READ_ID  aygit ID              0xAB RES    uyandir
 *    0xE4 ERNVLB   blok koruma (NVLB) sil
 * --------------------------------------------------------------------- */

/* =====================================================================
 *  YZ Hizlandirici CSR  (base 0x40060000, yz_csr_wrapper.sv)
 *  Akis: UART_YZ -> DMA -> YZ bellegi -> LOAD_DONE kesmesi -> START ->
 *        cikarim -> INFER_DONE kesmesi -> YZ_RESULT.
 *
 *  YZ_CTRL'in her biti bir OLAYDIR (donanimda 1 cycle pulse olur, geri
 *  okunmaz) -> alan alan degil, .all ile tek seferde yaz.
 * ===================================================================== */
typedef union {
    uint32_t all;
    struct {
        uint32_t START       : 1;  /* [0] cikarimi baslat            */
        uint32_t LOAD_CLEAR  : 1;  /* [1] load_done kesmesini temizle  */
        uint32_t INFER_CLEAR : 1;  /* [2] infer_done kesmesini temizle */
        uint32_t rsvd        : 29;
    } bit;
} YZ_CTRL_t;

typedef union {
    uint32_t all;
    struct {
        uint32_t BUSY          : 1;  /* [0] cikarim suruyor       */
        uint32_t LOAD_PENDING  : 1;  /* [1] veri yuklendi kesmesi */
        uint32_t INFER_PENDING : 1;  /* [2] cikarim bitti kesmesi */
        uint32_t rsvd          : 29;
    } bit;
} YZ_STATUS_t;

typedef union {
    uint32_t all;
    struct {
        uint32_t CLASS : 2;  /* [1:0] sinif: 0=sessizlik 1=bilinmeyen 2=evet 3=hayir */
        uint32_t rsvd  : 30;
    } bit;
} YZ_RESULT_t;

typedef struct {
    volatile YZ_CTRL_t   YZ_CTRL;    /* 0x00 WO kontrol (pulse'lar)  */
    volatile YZ_STATUS_t YZ_STATUS;  /* 0x04 RO durum                */
    volatile YZ_RESULT_t YZ_RESULT;  /* 0x08 RO cikarim sonucu       */
} YzAccel_t;

#define YzAccel  ((YzAccel_t *) 0x40060000UL)

/* ---------------------------------------------------------------------
 *  YZ_RESULT.CLASS degerleri (TFLite Micro Speech standart sirasi):
 *      0 = sessizlik   1 = bilinmeyen   2 = evet   3 = hayir
 *  Sira hizlandiricinin fc_weights.hex sirasina baglidir; "yes" gonderince
 *  beklenen sinif cikmiyorsa once bu esleme kontrol edilir.
 *
 *  YZ girisi tam 1960 bayt olmalidir (yz bellegi 2048 >= 1960).
 * --------------------------------------------------------------------- */

/* ---------------------------------------------------------------------
 *  Kesme hatlari (Top_module.sv: interrupt_i = {14'b0, infer, load, 16'b0})
 *  mie/mcause icinde kullanilan bit numaralari:
 *      16 = YZ bellegine yukleme bitti (load_done)
 *      17 = cikarim bitti              (infer_done)
 * --------------------------------------------------------------------- */

/* =====================================================================
 *  Register haritasi derleme zamaninda dogrulanir: bir alan eklenir ya da
 *  siralama bozulursa asagidaki kontroller derlemeyi durdurur.
 * ===================================================================== */
_Static_assert(offsetof(Timer_t, TIM_EVC)   == 0x1C, "Timer harita hatasi");
_Static_assert(offsetof(Gpio_t,  GPIO_ODR)  == 0x04, "GPIO harita hatasi");
_Static_assert(offsetof(Uart_t,  UART_CFG)  == 0x10, "UART harita hatasi");
_Static_assert(offsetof(I2c_t,   I2C_CLR)   == 0x14, "I2C harita hatasi");
_Static_assert(offsetof(Qspi_t,  QSPI_DMA)  == 0x14, "QSPI harita hatasi");
_Static_assert(offsetof(YzAccel_t, YZ_RESULT) == 0x08, "YZ harita hatasi");
_Static_assert(sizeof(UART_CFG_t) == 4, "union boyutu 32-bit olmali");

#endif /* SOC_H */
