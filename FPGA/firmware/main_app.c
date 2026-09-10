/* =====================================================================
 *  main_app.c  —  INSTRRAM'de çalışan ana uygulama
 *  main() kurulumları yapar, sonra for(;;) ile durur.
 *  İş mantığı kesme-güdümlüdür; ISR'lar içine yazılır.
 *
 *  Akış: UART_YZ -> (HW DMA) -> YZ bellek -> load_done IRQ -> hızlandırıcı
 *        start -> infer_done IRQ -> sonucu GPIO_ODR'ye yaz -> 7-segment
 *        + sınıfı ve softmax skorlarını genel UART'tan PC'ye gönder.
 * ===================================================================== */

#include "soc.h"
#include "yz_model/yz_softmax.h"

/* Register tanımları soc.h'tadır (YzAccel, UartAI, Gpio);
 * register'lara yazılan değerler burada doğrudan sayı olarak verilir. */

/* --- GENEL UART üzerinden tek bayt gönder (blocking) ---
 *  Şartname Bölüm 4.2.2 madde 5: "CPU kesme servisi (ISR) ile sonucu alıp
 *  GENEL UART üzerinden yazdıracaktır."
 *
 *  Protokol (UART RTL'i): TDR'ye bayt yaz -> CFG.TXSTART=1 ile başlat ->
 *  HW stop bit'te TXSTART'ı 0, TXDONE'ı 1 yapar -> TXDONE'ı SW temizler.
 *  TXDONE temizlenmezse sonraki gönderimde while döngüsü anında geçer
 *  (bit alanı yazması read-modify-write olduğu için eski 1 geri yazılır). */
static void yz_putc(uint8_t b)
{
    Uart->UART_TDR             = b;
    Uart->UART_CFG.bit.TXSTART = 1;
    while (!Uart->UART_CFG.bit.TXDONE);
    Uart->UART_CFG.bit.TXDONE  = 0;
}

/* İşaretli ondalık sayı bas (-128..127 aralığı yeter) */
static void yz_puti(int32_t v)
{
    uint32_t m;

    if (v < 0) { yz_putc('-'); m = (uint32_t)(-v); }
    else       {               m = (uint32_t)v;    }

    if (m >= 100u) yz_putc((uint8_t)('0' + m / 100u));
    if (m >=  10u) yz_putc((uint8_t)('0' + (m / 10u) % 10u));
    yz_putc((uint8_t)('0' + m % 10u));
}

/* =====================================================================
 *  Softmax (şartname EK-1 madde 4)
 *
 *  Hızlandırıcı FC katmanının ham int32 akümülatörlerini YZ_SCORE[0..3]'te
 *  bırakır. TFLite bu akümülatörleri önce int8'e requantize eder, sonra
 *  softmax uygular; iki adımı da burada tekrarlıyoruz. Sabitler ve exp
 *  tablosu .tflite'tan üretilir (yz_model/yz_softmax.h).
 * ===================================================================== */

/* gemmlowp SaturatingRoundingDoublingHighMul: (a*b) >> 31, yuvarlamalı */
static int32_t sat_round_dbl_high_mul(int32_t a, int32_t b)
{
    int64_t ab  = (int64_t)a * (int64_t)b;
    int32_t nudge = (ab >= 0) ? (1 << 30) : (1 - (1 << 30));
    int32_t r = (int32_t)((ab + nudge) / (1LL << 31));
    /* Tek taşma durumu: -2^31 * -2^31 */
    return (a == INT32_MIN && b == INT32_MIN) ? INT32_MAX : r;
}

/* gemmlowp RoundingDivideByPOT: en yakına yuvarlayan 2^exp bölmesi */
static int32_t round_div_by_pot(int32_t x, int exp)
{
    const int32_t mask      = (1 << exp) - 1;
    const int32_t remainder = x & mask;
    const int32_t threshold = (mask >> 1) + ((x < 0) ? 1 : 0);
    return (x >> exp) + ((remainder > threshold) ? 1 : 0);
}

/* Bu modelde FC çarpanının kaydırması negatif, yani requant tek yönlü sağa
 * kaydırmadır. Model değişip shift pozitife dönerse sola kaydırma dalı da
 * gerekir; sessizce yanlış sonuç üretmemesi için derlemede yakalanır. */
_Static_assert(YZ_FC_SHIFT < 0, "FC shift pozitif: sola kaydirma dali eksik");

/* acc[0..3] -> softmax'ın int8 çıkışı (tel üzerindeki biçim) */
static void yz_softmax(const int32_t *acc, int32_t *out)
{
    int32_t  q[YZ_N_CLASS], qmax = -128;
    uint32_t e[YZ_N_CLASS], sum = 0;
    int i;

    /* 1) FC akümülatörünü modelin int8 çıkış tensörüne sıkıştır */
    for (i = 0; i < YZ_N_CLASS; ++i) {
        int32_t v = round_div_by_pot(
                        sat_round_dbl_high_mul(acc[i], YZ_FC_MULT),
                        -YZ_FC_SHIFT) + YZ_FC_OUT_ZP;
        if (v < -128) v = -128;
        if (v >  127) v =  127;
        q[i] = v;
        if (v > qmax) qmax = v;
    }

    /* 2) exp(S*(q_i - qmax)) tabloya bakılarak. Fark 0..255 olabilir; tablo
     *    exp'in sıfıra indiği noktada kesildiği için üstü sıfır sayılır. */
    for (i = 0; i < YZ_N_CLASS; ++i) {
        int32_t d = qmax - q[i];
        e[i] = (d < YZ_EXP_LUT_LEN) ? yz_exp_lut[d] : 0u;
        sum += e[i];
    }

    /* 3) Normalize et ve softmax çıkışının nicemlemesine çevir */
    for (i = 0; i < YZ_N_CLASS; ++i) {
        uint32_t p = (e[i] * YZ_SM_OUT_SCALE_INV + sum / 2u) / sum;
        if (p > (uint32_t)(YZ_SM_OUT_SCALE_INV - 1))
            p = (uint32_t)(YZ_SM_OUT_SCALE_INV - 1);
        out[i] = (int32_t)p + YZ_SM_OUT_ZP;
    }
}

/* Sonuç çerçevesi:  "YZ:<sinif> S=<s0>;<s1>;<s2>;<s3>\n"
 *  Karakterler doğrudan immediate olarak verilir; string literal kullanılsaydı
 *  .rodata'dan (INSTRRAM) veri okuması gerekirdi, bu yol gereksiz yere
 *  instruction fetch ile aynı slave'e yük bindirir. */
static void yz_report(uint8_t tag, const int32_t *scores)
{
    int i;
    yz_putc('Y');
    yz_putc('Z');
    yz_putc(':');
    yz_putc(tag);
    if (scores) {
        yz_putc(' ');
        yz_putc('S');
        yz_putc('=');
        for (i = 0; i < YZ_N_CLASS; ++i) {
            if (i) yz_putc(';');
            yz_puti(scores[i]);
        }
    }
    yz_putc('\n');
}

/* --- Kesme servis rutinleri --- */
static void load_done_isr(void)
{
    /* Ekrana "INFRNC" bas: art arda aynı kelime gönderildiğinde bile
     * yeni bir çıkarımın başladığı gözle görülsün. */
    Gpio->GPIO_ODR = 6;

    /* Veri yüklendi -> hızlandırıcıyı başlat + load IRQ'yu temizle.
     * YZ_CTRL bitleri donanımda pulse üretir; ikisi tek yazmada verilir. */
    YzAccel->YZ_CTRL.all = 0x3u;      /* [0] START | [1] LOAD_CLEAR */

    /* PC'ye "veri tamam, çıkarım başladı" bilgisi. Önce START verildi:
     * hızlandırıcı çalışırken UART'ı sürüyoruz, çıkarımı geciktirmiyoruz.
     * Bu sırada infer_done gelirse MIE=0 olduğu için pending kalır ve
     * mret'ten hemen sonra servis edilir -> kesme kaybolmaz. */
    yz_report('B', 0);                /* Busy / inference started */
}

static void infer_done_isr(void)
{
    int32_t  acc[YZ_N_CLASS], scores[YZ_N_CLASS];
    uint32_t cls = 0;
    int i;

    /* Ham FC skorlarını oku ve softmax'ı uygula */
    for (i = 0; i < YZ_N_CLASS; ++i)
        acc[i] = YzAccel->YZ_SCORE[i];
    yz_softmax(acc, scores);

    /* Modelin cevabı softmax çıkışının argmax'ıdır ve eşitlikte ilk sınıf
     * kazanır. Hızlandırıcının YZ_RESULT'taki kendi argmax'ı ham int32
     * akümülatörler üzerindendir; requantization iki akümülatörü aynı int8
     * değerine indirdiğinde ikisi ayrışabilir. Referans model bu durumda
     * ilk sınıfı seçtiği için sınıf buradan türetilir. */
    for (i = 1; i < YZ_N_CLASS; ++i)
        if (scores[i] > scores[cls]) cls = (uint32_t)i;

    /* Sınıfı 7-segment değerine çevir ve GPIO_ODR'ye yaz */
    switch (cls) {
        case 2:  Gpio->GPIO_ODR = 7;  break;   /* Evet       -> 7  */
        case 3:  Gpio->GPIO_ODR = 8;  break;   /* Hayır      -> 8  */
        case 0:  Gpio->GPIO_ODR = 9;  break;   /* Sessizlik  -> 9  */
        case 1:  Gpio->GPIO_ODR = 10; break;   /* Bilinmeyen -> 10 */
        default: break;
    }

    /* Sınıf + dört skor PC'ye: "YZ:2 S=-128;-128;127;-128"
     * (sınıf sırası soc.h'taki gibi: sessizlik, bilinmeyen, evet, hayır) */
    yz_report((uint8_t)('0' + cls), scores);

    /* infer IRQ'yu temizle (en sonda) */
    YzAccel->YZ_CTRL.all = 0x4u;      /* [2] INFER_CLEAR */
}

/* --- Trap dağıtıcı (direct mode: tüm trap'ler buraya) --- */
void __attribute__((interrupt("machine"), aligned(256))) trap_handler(void)
{
    uint32_t cause;
    __asm__ volatile ("csrr %0, mcause" : "=r"(cause));

    if (cause & 0x80000000u) {                  /* bit31 = 1 -> interrupt */
        uint32_t id = cause & 0x1Fu;
        if      (id == 16u) load_done_isr();    /* irq_i[16] = load_done  */
        else if (id == 17u) infer_done_isr();   /* irq_i[17] = infer_done */
        /* yeni kaynak eklersen buraya bir else if daha */
    }
    /* exception (bit31=0) -> şimdilik yok sayılıyor (mepc'ye döner) */
}

/* --- Interrupt altyapısını kur (bir kere) --- */
static void irq_init(void)
{
    __asm__ volatile ("csrw mtvec, %0" :: "r"((uintptr_t)&trap_handler));   /* direct mode */
    uint32_t mie_mask = 0x00030000u;   /* bit16 load_done + bit17 infer_done */
    __asm__ volatile ("csrs mie, %0" :: "r"(mie_mask));                     /* hatları aç */
    __asm__ volatile ("csrsi mstatus, 0x8");                               /* MIE = 1 */
}

/* --- UART'ları konfigüre et (bir kere, boot'ta) ---
 *  UART_YZ (UartAI): host'un gönderdiği ses özniteliğini ALIR. 1960 baytlık
 *  vektör her çıkarımda tel üzerinden geçtiği için hızlı taraf budur;
 *  şartnamenin istediği 1 Mbps burada kullanılır (170 ms -> 19,6 ms).
 *
 *  Genel UART (Uart): çıkarım sonucunu GÖNDERİR (bkz. yz_putc). Çerçeve
 *  birkaç on bayt olduğu için 115200 yeterlidir. İki farklı baud'un aynı
 *  anda kullanılması şartname Bölüm 4.2.2/3'ün istediği çok-baud desteğini
 *  de gösterir. */
static void uart_init(void)
{
    UartAI->UART_CPB     = UART_CPB_3M;      /* YZ veri akisi: 3 Mbps */
    UartAI->UART_STP.all = 0;     /* 1 stop bit (RX bu alanı kullanmıyor ama netlik icin) */

    Uart->UART_CPB       = UART_CPB_1M;  /* sonuç çerçevesi */
    Uart->UART_STP.all   = 0;     /* 1 stop bit */
}

/* --- main: kurulumlar, sonra dur --- */
int main(void) {

    uart_init();
    irq_init();

    for (;;);
}
