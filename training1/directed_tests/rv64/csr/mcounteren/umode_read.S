/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:28/11/2025

Owner:Sumanth

Testcase name:umode_read

Description:This test verifies that change machine mode to user mode in mcounteren read the mcounteren in user mode will raise an illegal exception.

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
    li      x5, 0xffffffff
    csrs    mcounteren, x5                 #set all bits high into mcounteren csr
    csrr    x6, mstatus
    li      x7, 3
    slli    x7, x7, 11                     #mstatus.mpp[12:11]=00 clearing the bits
    csrc    mstatus, x7
    li      x8, 0
    slli    x8, x8, 11                     #mstatus.mpp[12:11]=00 mode will change machine to user
    csrs    mstatus, x8
    csrr    x8, mstatus
    li      x15, 0x2

    la      x9, umode
    csrw    mepc, x9
    mret

umode:
    csrr    x31, mcounteren                #read to mcounteren in user mode will cause illegal exception
    nop
    nop
    beq     x16, x15, check_pass           #self check pass
    bne     x16, x15, check_fail           #self check fail

m_call:
    csrr    x16, mcause
    bne     x16, x15, fail
    beq     x16, x15, check_pass
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
