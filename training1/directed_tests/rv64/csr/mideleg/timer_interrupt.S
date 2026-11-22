/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:2/12/2025

Owner:Sumanth

Testcase name:timer_interrupt

Description:This test is to verify when delegation is enabled in mideleg csr,sip 

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1, 20

start:
    csrr    x5, mideleg				
    li      x6, 0xffffffff
    csrw    mideleg, x6				#enable all fields in mideleg
    csrr    x7, mstatus
    li      x27, 0x1
    slli    x27, x27, 1
    csrs    sstatus, x27

    li      x8, 0x1
    slli    x8, x8, 3
    csrs    mstatus, x8				#mstatus.mie[3]=1

    li      x9, 0x1
    slli    x9, x9, 11
    csrs    mstatus, x9

    la      x10, smode
    csrw    mepc, x10
    mret

smode:
    la      x12, s_handler
    csrw    stvec, x12
    li      x27, 0x1
    slli    x27, x27, 1
    csrs    sstatus, x27			#sstatus.sie[1]=1
    li      x11, 0x1
    slli    x11, x11, 5
    csrs    sip, x11				#sip.stip[5]=1
    csrs    sie, x11				#sie.stie[5]=1

s_handler:
    csrr    x14, scause
    csrr    x16, stval
    csrr    x15, sepc
    addi    x15, x15, 4
    csrw    sepc, x15
    sret

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
