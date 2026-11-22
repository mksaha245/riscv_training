/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:28/11/2025

Owner:Sumanth

Testcase name:instret_disable

Description:This test verifies that disabling the instret in mcounteren ,read the instret in supervisor mode will cause an illegal exception

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
    li      x5, 0xfffffffb                  //disable the instret bit
    csrs    mcounteren, x5                  //mcounteren.ir[2]=0
    csrr    x6, mstatus
    li      x7, 3
    slli    x7, x7, 11                      //mstatus.mpp[12:11]=00 clearing the bits
    csrc    mstatus, x7
    li      x8, 1
    slli    x8, x8, 11                      //mstatus.mpp[12:11]=01 mode will change machine to supervisor
    csrs    mstatus, x8
    csrr    x8, mstatus
    li      x15, 0x2
    la      x9, smode
    csrw    mepc, x9
    mret

smode:
    csrr    x21, instret                    //read in supervisor will cause an illegal exception
    addi    x5, x5, 2

m_call:
    csrr    x16, mcause
    beq     x15, x16, check_pass
    bne     x15, x16, check_fail
    csrr    x17, mtval
    csrr    x18, mepc
    addi    x18, x18, 4
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

