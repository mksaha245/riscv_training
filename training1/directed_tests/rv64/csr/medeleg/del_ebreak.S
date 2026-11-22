/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:19/11/2025
 
Owner:Sumanth
 
Testcase name:del_ebreak
 
Description:
This test verifies that while enabling the delegation bit and executing the
EBREAK instruction, the trap is taken to Supervisor mode or not.
 
===========================================================*/
 
// Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
    li      gp, 3                 # global pointer init
    li      x1, 20                # temp init
 
start:
    csrr    x21, medeleg
    li      x9,  0x8
    csrw    medeleg, x9           # medeleg[3] = 1

    li      x6,  0x1
    slli    x6,  x6, 11           # mstatus.mpp[12:11] = 01 (M -> S)
    csrs    mstatus, x6

    la      x6,  s_mode
    csrw    mepc, x6
    mret

.align 4
s_mode:
    la      x16, s_handler        # setup S-mode trap handler
    csrw    stvec, x16

    li      x28, 0x20
    li      x29, 0x30

    ebreak                        # ebreak exception

    addi    x28, x28, 6
    add     x28, x28, x29

    li      x31, 0x3
    bne     x12, x31, not_pass    # check condition: fail
    beq     x12, x31, check_pass  # check condition: pass

.align 4
s_handler:
    csrr    x12, scause           # read scause
    bne     x31, x12, fail        # verify delegated ebreak

    csrr    x13, sepc
    addi    x13, x13, 2           # skip ebreak
    csrw    sepc, x13
    sret

not_pass:
    nop                           # fail padding
    nop

check_pass:
    nop                           # pass padding
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

