/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:2/12/2025

Owner:Sumanth

Testcase name:Software_interrupt

Description:This test is to verify delegate the interrupt to supervisor mode verify whether trap is handled in supervisor mode handler or not.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1, 20

start:
    csrr    x5, mideleg                     #default value of mideleg
    li      x6, 0xffffffff
    csrw    mideleg, x6                     #enable all bits of mideleg know which bits are writable
    csrr    x7, mstatus
    li      x8, 0x1                         #enable the mie bit in mstatus
    slli    x8, x8, 3
    csrs    mstatus, x8

    li      x9, 0x1
    slli    x9, x9, 11
    csrs    mstatus, x9

    la      x10, smode
    csrw    mepc, x10
    mret

smode:
    la      x12, scall                      #setup the trap handler
    csrw    stvec, x12
    li      x27, 0x1                        #enable the sstatus.sie[1]=1
    slli    x27, x27, 1
    csrs    sstatus, x27
    li      x27, 0x8000000000000001
    li      x11, 0x1
    slli    x11, x11, 1
    csrs    sip, x11                        #sip.ssip[1]=1
    csrs    sie, x11                        #sie.ssie[1]=1
    nop
    nop

scall:
    csrr    x14, scause
    beq     x14, x27, check_pass
    bne     x14, x27, check_fail
    csrr    x16, stval
    csrr    x15, sepc
    addi    x15, x15, 4
    csrw    sepc, x15
    sret

check_fail:
    nop
    nop

check_pass:
    nop
    nop
    li      x28, 0x80000004
    csrw    stvec, x28

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

