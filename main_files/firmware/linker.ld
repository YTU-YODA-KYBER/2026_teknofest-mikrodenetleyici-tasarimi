/* =====================================================================
 *  CV32E40P Linker Script
 *  IMEM (boot ROM)  : 0x00000000, 1KB  -> .text + .rodata
 *  DMEM (data RAM)   : 0x20000000, 8KB  -> .data + .bss + stack
 *
 *  .rodata IMEM'de kalir; CPU data port + dual-port boot ROM ile okur.
 *  Stack pointer boot.S'de hard-code (li sp, 0x20002000).
 *
 *  RTL ayari:
 *    boot ROM ADDR_WIDTH = 8  (2^8 word x 4 byte = 1KB)
 *    data RAM ADDR_WIDTH  = 11 (2^11 word x 4 byte = 8KB)
 * ===================================================================== */

OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
    IMEM (rx) : ORIGIN = 0x00000000, LENGTH = 1K
    DMEM (rw) : ORIGIN = 0x20000000, LENGTH = 8K
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
