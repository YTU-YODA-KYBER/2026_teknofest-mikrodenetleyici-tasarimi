.section .vectors, "ax"
.global _start

_start:
    li    sp, 0x20002000

    /* .data kopyala */
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

    /* .bss sıfırla */
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
