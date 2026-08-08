/* =====================================================================
 *  CV32E40P Linker Script  --  YZ BENCH SENARYOSU (yalnizca dogrulama)
 *
 *  IMEM (boot ROM) : 0x00000000, 32KB -> .text + .rodata
 *  DMEM (data RAM) : 0x20000000, 32KB -> .data + .bss + yigin
 *
 *  NEDEN AYRI BIR SCRIPT
 *  ---------------------
 *  Ana proje bellek boyutlari sartname ile sinirlidir ve linker.ld'de
 *  1KB / 8KB olarak sabittir. Ama sartnamenin "yazilim gerceklemesi"
 *  maddesi icin CPU'da kosan TFLite modeli tek basina 16KB'lik FC
 *  agirligini .rodata'da (yani Boot ROM'da) tasiyor; 1KB'a sigmaz.
 *
 *  Bu yuzden ana projeye HIC DOKUNULMAZ: yalnizca bench hedefleri
 *  (make bench / make sim_bench) bu scripti kullanir, RTL tarafinda da
 *  ayni sekilde yalnizca yz_bench_test.tcl / yz_bench_test.sv
 *  ADDR_WIDTH_boot=13, ADDR_WIDTH_data=13 parametrelerini disaridan ezer.
 *
 *  BELLEK BUTCESI (olculen)
 *    .text + .rodata : 18,3 KB (kart) / 20,3 KB (sim, gomulu girdi ile)
 *    .bss            :  5,9 KB (1960 girdi + 4000 scratch + sonuc)
 *
 *  Adres bolgeleri interconnect'te zaten 64KB genis oldugu icin adres
 *  cozucude (AXI4_Interconnect.sv) hicbir degisiklik gerekmez.
 * ===================================================================== */

OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
    IMEM (rx) : ORIGIN = 0x00000000, LENGTH = 32K
    DMEM (rw) : ORIGIN = 0x20000000, LENGTH = 32K
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

    /* Baslangic degerlerinin IMEM'deki adresi; boot.S buradan kopyalar. */
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
