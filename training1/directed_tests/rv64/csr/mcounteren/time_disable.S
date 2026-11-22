/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:28/11/2025

Owner:Sumanth

Testcase name:time_disable

Description:This test is to verify that when time bit is disable in mcounteren register then read to time in supervisor mode will cause a illegal exception

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1, 20

#setup the trap handler
handler:
    la      x21, m_call
    csrw    mtvec, x21

start:
    li      x5, 0xfffffffd                #mcounteren.tm[1]=0
    csrs    mcounteren, x5
    csrr    x6, mstatus
    li      x7, 3
    slli    x7, x7, 11
    csrc    mstatus, x7
    li      x8, 1
    slli    x8, x8, 11
    csrs    mstatus, x8                   #setting 10 in mstatus.mpp[12:11] mode change machine to supervisor
    csrr    x8, mstatus
    li      x15, 0x2
    la      x9, smode
    csrw    mepc, x9
    mret

smode:
    csrr    x21, time                      #read to time in supervisor will cause a illegal exception
    addi    x5, x5, 2

#trap handler
m_call:
    csrr    x16, mcause
    beq     x15, x16, check_pass           #self check pass
    bne     x15, x16, check_fail           #self check fail
    csrr    x17, mtval
    csrr    x18, mepc
    addi    x18, x18, 4
    beq     x12, x16, pass
    csrw    mepc, x18
    mret

check_fail:
    nop
    nop

check_pass:
    nop
    nop
    li      x27, 0x80000004
    csrw    mtvec, x27

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
