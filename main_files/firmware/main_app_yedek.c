/* =====================================================================
 *  main_app.c  —  INSTRRAM'de çalışan ana uygulama (İSKELET)
 *  main() kurulumları yapar, sonra for(;;) ile durur.
 *  İş mantığı kesme-güdümlüdür; ISR'lar içine yazılır.
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

#define IRQ_LOAD_DONE     16      /* irq_i[16] */
#define IRQ_INFER_DONE    17      /* irq_i[17] */

/* --- Kesme servis rutinleri --- */
static void load_done_isr(void)
{
    /* Veri yüklendi -> hızlandırıcıyı başlat + load IRQ'yu temizle */
    YZ_ACCEL->CTRL = CTRL_START | CTRL_LOAD_CLEAR;
}

static void infer_done_isr(void)
{
    uint8_t cls = (uint8_t)(YZ_ACCEL->RESULT & 0x3u);

    /* ===== İŞ MANTIĞI BURAYA ===== */
    (void)cls;   /* TODO: 7-segment'e yaz / UART'tan gönder / vb. */

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
    /* exception (bit31=0) -> şimdilik yok sayılıyor */
}

/* --- Interrupt altyapısını kur (bir kere) --- */
static void irq_init(void)
{
    __asm__ volatile ("csrw mtvec, %0" :: "r"((uintptr_t)&trap_handler));   /* direct mode */
    uint32_t mie_mask = (1u << IRQ_LOAD_DONE) | (1u << IRQ_INFER_DONE);
    __asm__ volatile ("csrs mie, %0" :: "r"(mie_mask));                     /* hatları aç */
    __asm__ volatile ("csrsi mstatus, 0x8");                               /* MIE = 1 */
}

/* --- main: kurulumlar, sonra dur --- */
int main(void)
{
    irq_init();

    /* Diğer başlangıç işlemleri buraya (UART/GPIO config, vb.) */

    for (;;);   /* işlemci burada durur; her şey kesmelerle yürür */

        return 0;
}
