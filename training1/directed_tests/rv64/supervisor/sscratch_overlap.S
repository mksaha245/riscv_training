/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:25/11/2025

Owner:sumanth

Testcase name:sscratch_overlap

Description:The register value will not change due to exception, in order to prevent overwrite and loss of the previous values, when a supervisor mode trap handler is entered, the old value of sscratch will remain same.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1,20

handler:
    la      x6,m_call         	  # trap handler setup
    csrw    mtvec,x6

start: 
    li      x21,0x800
    csrr    x22,mstatus
    or      x22,x21,x22
    csrw    mstatus,x22			  #mstatus.mpp[12:11]=01 switch machine to supervisor mode
    la      x23,s_mode
    csrw    mepc,x23
    mret

s_mode:
    li      x5,0x12345678     	  # write a value to sscratch
    csrw    sscratch,x5
    li      x27,0x3

    ebreak                    	  # trigger an exception
    nop
    addi    x5,x5,4
    addi    x5,x5,4
    csrr    x8,sscratch       	  # after returning from the trap read from sscratch, value should not change

    beq     x10,x27,check_pass    # self check for pass
    bne     x10,x27,check_fail    # self check for fail

.align 4
m_call:
    csrr    x10,mcause
    bne     x10,x27,fail
    csrr    x11,mepc
    csrr    x12,mtval
    addi    x11,x11,2
    csrw    mepc,x11
    mret

check_fail:
    nop
    nop

check_pass:
    nop
    nop
    li      x15,0x80000004
    csrw    stvec,x15

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA
RVTEST_DATA_END

