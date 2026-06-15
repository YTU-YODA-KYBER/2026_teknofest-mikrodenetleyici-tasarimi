/* =====================================================================
 *  Minimal Boot Kodu - CV32E40P
 *  - Stack pointer hard-code (DMEM sonu = 0x20000000 + 8K)
 *  - BSS sifirla
 *  - .rodata IMEM'de kalir (dual-port boot ROM ile data port'tan okunur)
 *  - main()'e atla
 * ===================================================================== */

.section .vectors, "ax"
.global _start

_start:
    li    sp, 0x20002000        /* DMEM sonu (8KB) */

    la    t0, _sidata
    la    t1, _sdata
    la    t2, _edata
_data_loop:
    bge   t1, t2, _data_done
    lw    t3, 0(t0)
    sw    t3, 0(t1)
    addi  t0, t0, 4
    addi  t1, t1, 4
    j     _data_loop
_data_done:

    /* BSS sifirla */
    la    t0, _sbss
    la    t1, _ebss
_bss_loop:
    bge   t0, t1, _bss_done
    sw    zero, 0(t0)
    addi  t0, t0, 4
    j     _bss_loop
_bss_done:

    call  main

_hang:
    j     _hang
