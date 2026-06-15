/* =====================================================================
 *  CV32E40P Uygulama Linker Script
 *  Bootloader'in Flash'tan kopyalayip jump ettigi uygulama icin.
 *
 *  INSTRRAM (rx) : 0x10000000, 8KB  -> .text + .rodata
 *  DATARAM  (rw) : 0x20000000, 8KB  -> .data + .bss + yigin
 *
 *  NOT: Bu script bootloader linker.ld ile ayni yapida,
 *       tek fark IMEM'in INSTRRAM adresini gostermesidir.
 * ===================================================================== */

OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
    IMEM (rx) : ORIGIN = 0x10000000, LENGTH = 8K   /* INSTRRAM */
    DMEM (rw) : ORIGIN = 0x20000000, LENGTH = 8K   /* DATARAM  */
}

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

    /* Baslangic degerlerinin INSTRRAM'deki adresi.
     * Uygulama boot.S bu adresten okuyup DMEM'e kopyalar. */
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
