/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:4/12/2025
 
Owner:Sumanth
 
Testcase name:mepc_nested_trap
 
Description:
This test verifies that:
1. First it holds the address of the first faulting instruction after handling from the trap handler.
2. Then it should hold the faulting address of the next exception.
 
===========================================================*/
 
// Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
    li      gp, 3                 
    li      x1, 20                

handler:
    la      x5, m_call
    csrw    mtvec, x5              # machine trap handler setup

start: 
    li      x6, 20
    li      x29, 0x2
    csrw    mvendorid, x6          # illegal instruction to generate trap
    nop
    nop
    addi    x6, x6, 10

    beq     x29, x7, check_pass    # self-check condition
    beq     x11, x9, check_pass
    bne     x29, x7, check_fail
    bne     x11, x9, check_fail

m_call:
    la      x10, nested_trap
    csrw    mtvec, x10             # nested trap setup

    csrr    x7, mcause
    bne     x7, x29, fail          # verify first trap

    csrr    x8, mepc
    csrw    mimpid, x7             # illegal instruction to generate nested trap

    addi    x8, x8, 4
    csrw    mepc, x8
    mret

.align 4
nested_trap:
    csrr    x11, mcause
    bne     x11, x29, fail         # verify nested trap

    csrr    x12, mepc
    addi    x12, x12, 4
    csrw    mepc, x12
    mret

check_fail:
    nop                            # fail padding
    nop

check_pass:
    nop                            # pass padding
    nop
    li      x31, 0x80000004
    csrw    mtvec, x31             # reset mtvec

TEST_PASSFAIL
 
RVTEST_CODE_END
 
.data
 
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

