/* =====================================================================
 *  CV32E40P Linker Script  --  UYGULAMAYI BOOT ROM'DAN KOSTURMA
 *  IMEM (boot ROM)  : 0x00000000, 4KB  -> .text + .rodata
 *  DMEM (data RAM)   : 0x20000000, 8KB  -> .data + .bss + stack
 *
 *  Uygulamayi QSPI flash + flasher + DMA zincirine hic girmeden denemek
 *  icindir: app dogrudan boot ROM'a yuklenir ve resetten sonra kosar.
 *  Simulasyon ve ASIC sim varyantlari bunu kullanir.
 *
 *  ANA PROJENIN 1KB'lik boot ROM'u DEGISMEZ (linker.ld, sartname siniri);
 *  buyutulen yalnizca bu senaryodur. Uygulama softmax exp tablosuyla
 *  birlikte 1KB'i astigi icin gereklidir.
 *
 *  RTL ayari (testbench/tcl bu parametreyi DISARIDAN ezer):
 *    boot ROM ADDR_WIDTH = 10  (2^10 word x 4 byte = 4KB)
 *    data RAM ADDR_WIDTH  = 11 (2^11 word x 4 byte = 8KB)
 * ===================================================================== */

OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
    IMEM (rx) : ORIGIN = 0x00000000, LENGTH = 4K
    DMEM (rw) : ORIGIN = 0x20000000, LENGTH = 8K
}

/* Yigin tepesi: Data RAM'in sonu. boot.S "la sp, _stack_top" ile alir. */
_stack_top = ORIGIN(DMEM) + LENGTH(DMEM);

SECTIONS
{
    .text : ALIGN(4) {
        KEEP(*(.vectors))
        KEEP(*(.vectors.*))
        *(.text)
        *(.text.*)
        *(.rodata)
        *(.rodata.*)
        *(.srodata)
        *(.srodata.*)
        . = ALIGN(4);
        _etext = .;
    } > IMEM

    .data : ALIGN(4) {
        _sdata = .;
        *(.data)
        *(.data.*)
        *(.sdata)
        *(.sdata.*)
        . = ALIGN(4);
        _edata = .;
    } > DMEM AT > IMEM

    _sidata = LOADADDR(.data);

    .bss : ALIGN(4) {
        _sbss = .;
        *(.bss)
        *(.bss.*)
        *(.sbss)
        *(.sbss.*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } > DMEM

    /DISCARD/ : {
        *(.comment)
        *(.note)
        *(.note.*)
        *(.eh_frame)
        *(.eh_frame.*)
        *(.riscv.attributes)
    }
}
