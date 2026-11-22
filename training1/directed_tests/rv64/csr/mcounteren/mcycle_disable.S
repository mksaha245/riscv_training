/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:8/12/2025

Owner:Sumanth

Testcase name:mcycle_disable

Description:This test is to verify in mcounteren.mcycle bit is disabled verify read mcycle in supervisor mode will raise an illegal exception or not.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1, 20

handler:
    la      x21, m_call             #trap handler setup
    csrw    mtvec, x21

start:
	csrw	x28, mcounteren
    li      x5, 0xfffffffe
	or		x5, x28, x5
    csrw    mcounteren, x5			#mcounteren.cy[0]=0
    csrr    x6, mstatus
    li      x7, 3
    slli    x7, x7, 11
    csrc    mstatus, x7
    li      x8, 1
    slli    x8, x8, 11
    csrs    mstatus, x8             #mstatus.mpp[12:11]=01 switch to supervisor mode
    csrr    x8, mstatus
    li      x15, 0x2
    la      x9, smode
    csrw    mepc, x9
    mret

smode:
    csrr    x21, mcycle             #this read of mcycle in supervisor will raise an illegal exception

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
