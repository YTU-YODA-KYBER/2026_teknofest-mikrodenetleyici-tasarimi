/* =====================================================================
 *  main_app.c  —  INSTRRAM'de çalışan ana uygulama
 *  main() kurulumları yapar, sonra for(;;) ile durur.
 *  İş mantığı kesme-güdümlüdür; ISR'lar içine yazılır.
 *
 *  Akış: UART -> (HW DMA) -> YZ bellek -> load_done IRQ -> hızlandırıcı
 *        start -> infer_done IRQ -> sonucu GPIO_ODR'ye yaz -> 7-segment
 *        + aynı sonucu UART_YZ TX'ten PC'ye ASCII olarak gönder.
 * ===================================================================== */

#include "soc.h"

/* Register tanımları soc.h'tadır (YzAccel, UartAI, Gpio);
 * register'lara yazılan değerler burada doğrudan sayı olarak verilir. */

/* --- GENEL UART üzerinden tek bayt gönder (blocking) ---
 *  Şartname Bölüm 4.2.2 madde 5: "CPU kesme servisi (ISR) ile sonucu alıp
 *  GENEL UART üzerinden yazdıracaktır."
 *
 *  Eskiden UartAI (UART_YZ) kullanılıyordu, çünkü uart_mux.sv fiziksel TX
 *  pinini GPIO_IDR[1:0]'a göre sürüyordu ve YZ modunda pin UART_YZ'ye
 *  bağlıydı -> genel UART'a yazılan bayt karttan hiç çıkmıyordu.
 *  uart_mux.sv artık TX'i HER MODDA genel UART'tan sürüyor (gerekçesi o
 *  dosyada); YZ arayüzü zaten tek yönlüdür, UART_YZ'nin göndereceği bir şey
 *  yoktur. Bu yüzden sonuç artık şartnamenin istediği yoldan çıkıyor.
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

/* Sonuç çerçevesi: 'Y' 'Z' ':' <karakter> '\n'  (5 bayt, ~434 us @115200)
 *  Karakterler doğrudan immediate olarak verilir; string literal kullanılsaydı
 *  .rodata'dan (INSTRRAM) veri okuması gerekirdi, bu yol gereksiz yere
 *  instruction fetch ile aynı slave'e yük bindirir. */
static void yz_report(uint8_t tag)
{
    yz_putc('Y');
    yz_putc('Z');
    yz_putc(':');
    yz_putc(tag);
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
    yz_report('B');                   /* Busy / inference started */
}

static void infer_done_isr(void)
{
    uint32_t cls = YzAccel->YZ_RESULT.bit.CLASS;

    /* Sınıfı 7-segment değerine çevir ve GPIO_ODR'ye yaz */
    switch (cls) {
        case 2:  Gpio->GPIO_ODR = 7;  break;   /* Evet       -> 7  */
        case 3:  Gpio->GPIO_ODR = 8;  break;   /* Hayır      -> 8  */
        case 0:  Gpio->GPIO_ODR = 9;  break;   /* Sessizlik  -> 9  */
        case 1:  Gpio->GPIO_ODR = 10; break;   /* Bilinmeyen -> 10 */
        default: break;
    }

    /* Aynı sonucu PC'ye gönder: "YZ:0".."YZ:3" (soc.h'taki sınıf sırası) */
    yz_report((uint8_t)('0' + cls));

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
 *  UART_YZ (UartAI): host'un gönderdiği ses özniteliğini ALIR. Bu olmadan RX
 *  reset default'unda kalır ve veriyi hiç doğru örnekleyemez -> DMA'ya
 *  hiçbir zaman doğru bayt gitmez.
 *
 *  Genel UART (Uart): çıkarım sonucunu GÖNDERİR (bkz. yz_putc). Eskiden
 *  yalnız UART_YZ konfigüre ediliyordu; TX genel UART'a taşındığı için
 *  onun bölücüsü de kurulmak zorunda, aksi halde sonuç çerçevesi reset
 *  default baud'unda çıkar ve host okuyamaz. */
static void uart_init(void)
{
    UartAI->UART_CPB     = UART_CPB_115200;  /* SYS_CLK_HZ'den turetilir (send_data.py ile aynı baud) */
    UartAI->UART_STP.all = 0;     /* 1 stop bit (RX bu alanı kullanmıyor ama netlik icin) */

    Uart->UART_CPB       = UART_CPB_115200;  /* sonuç çerçevesi aynı baud'da çıksın */
    Uart->UART_STP.all   = 0;     /* 1 stop bit */
}

/* --- main: kurulumlar, sonra dur --- */
int main(void) {

    uart_init();
    irq_init();

    for (;;);
}
