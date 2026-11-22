/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:24/11/2025

Owner:sumanth

Testcase name:mstatus_mie

Description: This test is to verify the mstatus.mie bit how it triggers an interrupt.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1, 20

start:
    la      x7, m_call
    csrw    mtvec, x7
    li      x31, 0x8000000000000001
    csrr    x4, mstatus
    li      x5, 0x8
    or      x5, x4, x5
    csrw    mstatus, x5                  #mstatus.mie[3]=1

    li      x6, 0x2
    csrw    mie, x6                      #mie.ssie[2]=1

    csrw    mip, x6                      #mie.ssip[2]=1

.align 4
m_call:
    csrr    x8, mcause
    beq     x8, x31, check_pass          #self check pass
    bne     x8, x31, check_fail          #self check fail
    csrr    x9, mepc
    addi    x9, x9, 4
    csrw    mepc, x9
    mret

check_fail:
    nop
    nop

check_pass:
    nop
    nop
    li      x21, 0x80000004
    csrw    mtvec, x21

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
