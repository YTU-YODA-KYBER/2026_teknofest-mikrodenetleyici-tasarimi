/* =====================================================================
 *  main_app.c  —  INSTRRAM'de çalışan ana uygulama
 *  main() kurulumları yapar, sonra for(;;) ile durur.
 *  İş mantığı kesme-güdümlüdür; ISR'lar içine yazılır.
 *
 *  Akış: UART -> (HW DMA) -> YZ bellek -> load_done IRQ -> hızlandırıcı
 *        start -> infer_done IRQ -> sonucu GPIO_ODR'ye yaz -> 7-segment.
 * ===================================================================== */

#include <stdint.h>

/* --- YZ Hızlandırıcı CSR haritası (interconnect M6: 0x4006_0000) --- */
typedef struct {
    volatile uint32_t CTRL;     /* 0x00 W: [0]START [1]LOAD_CLEAR [2]INFER_CLEAR */
    volatile uint32_t STATUS;   /* 0x04 R: [0]busy [1]load_pending [2]infer_pending */
    volatile uint32_t RESULT;   /* 0x08 R: [1:0] sınıf (0-3) */
} yz_accel_t;

#define YZ_ACCEL          ((yz_accel_t *) 0x40060000UL)

#define CTRL_START        (1u << 0)
#define CTRL_LOAD_CLEAR   (1u << 1)
#define CTRL_INFER_CLEAR  (1u << 2)

/* --- UART_YZ (YZ veri akışı UART'ı) CSR haritası (interconnect M5: 0x4005_0000) ---
 *  RX örnekleme hızı bu register'a bağlı; CPU yazmazsa reset default'unda
 *  (cnt_limit_mirror=5, ~625 kbaud sanılan hız) kalır ve host'un gönderdiği
 *  gerçek baud ile hiç örtüşmez -> RX her baytı yanlış örnekler, DMA'ya
 *  hiçbir zaman doğru veri gitmez. Boot'ta MUTLAKA konfigüre edilmeli. */
typedef struct {
    volatile uint32_t CPB;      /* 0x00 RW: clock-per-bit = sys_clk_hz / baud   */
    volatile uint32_t STP;      /* 0x04 RW: stop-bit [1:0] (00=1, 01=1.5, 1X=2) */
    volatile uint32_t RDR;      /* 0x08 RO: son alınan bayt (RX)                */
    volatile uint32_t TDR;      /* 0x0C RW: gönderilecek bayt (TX)              */
    volatile uint32_t CFG;      /* 0x10 RW: [0]TX start [1]RX done [2]TX done   */
} uart_yz_t;

#define UART_YZ           ((uart_yz_t *) 0x40050000UL)

#define SYS_CLK_HZ         50000000UL   /* clk_wiz_0 cikisi (fpga_top: 100MHz->50MHz) */
#define UART_YZ_BAUD       115200UL     /* send_audio.py'deki BAUD ile AYNI olmali   */
#define UART_YZ_CPB        (SYS_CLK_HZ / UART_YZ_BAUD)   /* ~434 @ 50MHz/115200 */

/* --- GPIO haritası (interconnect: 0x4001_0000) --- */
typedef struct {
    volatile uint32_t IDR;      /* 0x00 R : giriş  (switch) */
    volatile uint32_t ODR;      /* 0x04 RW: çıkış  (7-segment'e bağlı) */
} gpio_t;

#define GPIO              ((gpio_t *) 0x40010000UL)

/* --- Kesme hatları --- */
#define IRQ_LOAD_DONE     16      /* irq_i[16] */
#define IRQ_INFER_DONE    17      /* irq_i[17] */

/* --- Sınıf indeksleri (TFLite Micro Speech standart sırası) ---
 *  DİKKAT: Bu sıra hızlandırıcının fc_weights sırasına bağlı.
 *  "yes" gönderince ekranda 7 çıkmıyorsa, aşağıdaki 4 değeri yeniden eşle. */
#define CLS_SILENCE       0       /* Sessizlik */
#define CLS_UNKNOWN       1       /* Bilinmeyen */
#define CLS_YES           2       /* Evet */
#define CLS_NO            3       /* Hayır */

/* --- 7-segment'te gösterilecek değerler --- */
#define DISP_YES          7
#define DISP_NO           8
#define DISP_SILENCE      9
#define DISP_UNKNOWN      0       /* belirtilmedi -> idle/0 */

/* --- Kesme servis rutinleri --- */
static void load_done_isr(void)
{
    /* Veri yüklendi -> hızlandırıcıyı başlat + load IRQ'yu temizle */
    YZ_ACCEL->CTRL = CTRL_START | CTRL_LOAD_CLEAR;
}

static void infer_done_isr(void)
{
    uint8_t cls = (uint8_t)(YZ_ACCEL->RESULT & 0x3u);

    /* Sınıfı 7-segment değerine çevir ve GPIO_ODR'ye yaz */
    switch (cls) {
        case CLS_YES:     GPIO->ODR = DISP_YES;     break;   /* Evet      -> 7 */
        case CLS_NO:      GPIO->ODR = DISP_NO;      break;   /* Hayır     -> 8 */
        case CLS_SILENCE: GPIO->ODR = DISP_SILENCE; break;   /* Sessizlik -> 9 */
        case CLS_UNKNOWN: GPIO->ODR = DISP_UNKNOWN; break;   /* Bilinmeyen-> 0 */
        default:          break;
    }

    /* infer IRQ'yu temizle (en sonda) */
    YZ_ACCEL->CTRL = CTRL_INFER_CLEAR;
}

/* --- Trap dağıtıcı (direct mode: tüm trap'ler buraya) --- */
void __attribute__((interrupt("machine"), aligned(256))) trap_handler(void)
{
    uint32_t cause;
    __asm__ volatile ("csrr %0, mcause" : "=r"(cause));

    if (cause & 0x80000000u) {                  /* bit31 = 1 -> interrupt */
        uint32_t id = cause & 0x1Fu;
        if      (id == IRQ_LOAD_DONE)  load_done_isr();
        else if (id == IRQ_INFER_DONE) infer_done_isr();
        /* yeni kaynak eklersen buraya bir else if daha */
    }
    /* exception (bit31=0) -> şimdilik yok sayılıyor (mepc'ye döner) */
}

/* --- Interrupt altyapısını kur (bir kere) --- */
static void irq_init(void)
{
    __asm__ volatile ("csrw mtvec, %0" :: "r"((uintptr_t)&trap_handler));   /* direct mode */
    uint32_t mie_mask = (1u << IRQ_LOAD_DONE) | (1u << IRQ_INFER_DONE);
    __asm__ volatile ("csrs mie, %0" :: "r"(mie_mask));                     /* hatları aç */
    __asm__ volatile ("csrsi mstatus, 0x8");                               /* MIE = 1 */
}

/* --- UART_YZ'yi konfigüre et (bir kere, boot'ta) ---
 *  Bu olmadan RX reset default'unda kalır ve host'un gönderdiği veriyi
 *  hiç doğru örnekleyemez -> DMA'ya hiçbir zaman doğru bayt gitmez. */
static void uart_yz_init(void)
{
    UART_YZ->CPB = UART_YZ_CPB;   /* ör. 50e6/115200 ~= 434 */
    UART_YZ->STP = 0;             /* 1 stop bit (RX bu alanı kullanmıyor ama netlik icin) */
}

/* --- main: kurulumlar, sonra dur --- */
int main(void) {

    uart_yz_init();
    irq_init();

    for (;;);

    for (;;);
}
