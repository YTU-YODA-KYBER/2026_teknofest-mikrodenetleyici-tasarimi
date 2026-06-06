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
