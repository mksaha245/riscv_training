/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:18/11/2025
 
Owner:Sumanth
 
Testcase name:del_ecall_umode
 
Description:
This test verifies that by enabling the delegation, ecall is executed in
User mode and verifies that the trap is handled in Supervisor mode or not.
 
===========================================================*/
 
// Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
    li      gp, 3                 # global pointer init
    li      x1, 20                # temp init
 
start:
    li      x6, 0x100              # medeleg[8] = 1 (ecall from U delegated)
    csrw    medeleg, x6

    li      x5, 0x0
    slli    x5, x5, 11             # shift for mpp bits

    csrr    x17, mstatus           # read default mstatus
    or      x5, x17, x5
    csrs    mstatus, x5            # mstatus.mpp[12:11] = 00 (M -> U)

    la      x10, s_call            # setup supervisor trap handler
    csrw    stvec, x10

    la      x7, u_mode             # user mode entry
    csrw    mepc, x7               # mepc setup
    mret
 
u_mode:
    la      x8, inp_data           # load data base address
    lw      x9,  4(x8)
    lw      x14, 4(x8)

    li      x31, 0x8               # scause value for ecall from U-mode
    ecall                          # ecall from user mode

    add     x18, x14, x9
    bne     x11, x31, not_pass     # self-check: fail
    beq     x11, x31, check_pass   # self-check: pass
 
s_call:
    csrr    x11, scause            # read scause
    bne     x31, x11, fail         # verify delegated trap

    csrr    x12, sepc              # read sepc
    addi    x12, x12, 4            # skip ecall
    csrw    sepc, x12
    sret
 
not_pass:
    nop                            # fail padding
    nop
 
check_pass:
    nop                            # pass padding
    nop
 
TEST_PASSFAIL
 
RVTEST_CODE_END
 
.data
 
RVTEST_DATA_BEGIN
inp_data:
    .word   0x12345678
    .word   0x98765432
    .word   0x11223344

    TEST_DATA
RVTEST_DATA_END

