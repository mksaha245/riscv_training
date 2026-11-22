/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:5/12/2025
 
Owner:Sumanth
 
Testcase name:sepc_invalid
 
Description:This test verifies write an invalid pc to sepc generates any exception or not.
===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64S

RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1,20

handler:
    la      x5,s_handler          # trap handler setup
    csrw    stvec,x5 
start: 

    li      x6,0x20
    li      x7,0xffffffffffffffff # write an invalid pc to sepc
    csrw    sepc,x7
    sret

    li      x9,0x2
    add     x10,x6,x7
    beq     x9,x11,check_pass     # self checking
    bne     x9,x11,check_fail

.align 4
s_handler:
    csrr    x11,scause
    csrr    x14,stval
    bne     x9,x11,fail
    csrr    x12,sepc
    csrr    x13,stval
    addi    x12,x12,4
    csrw    sepc,x12
    sret

check_fail:
    nop
    nop

check_pass:
    nop
    nop
    li      x17,0x80000004
    csrw    stvec,x17
TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
inp_data:
    .word   0x12345678

TEST_DATA

RVTEST_DATA_END

