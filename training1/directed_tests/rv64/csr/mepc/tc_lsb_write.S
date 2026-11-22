/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:28/11/2025

Owner:Sumanth

Testcase name:tc_lsb_write

Description:This test verifies write operation on last two bits of sepc .

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li gp, 3
    li x1,20

# set up trap handler
handler:
    la      x7,m_call
    csrw    mtvec,x7

start:
    li      x9,0x0

	li		x5,0x80000003		#write lsb of mepc[1:0] non zero value 
	csrw	mepc,x5
	mret
    nop
    nop
    beq     x9,x11,check_pass
    bne     x9,x11,check_fail

m_call:
    csrr    x11,mcause
    bne     x11,x9,check_fail   # verify trap cause matches expected
    csrr    x12,mtval
    csrr    x13,mepc            # mepc should hold faulting instruction address
    addi    x13,x13,4
    csrw    mepc,x13
    mret

check_fail:
    nop
    nop

check_pass:
    nop
    nop
    li      x20,0x80000004
    csrw    mtvec,x20

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA
RVTEST_DATA_END



