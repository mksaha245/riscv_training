/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:24/11/2025
 
Owner:sumanth
 
Testcase name:mtval_ebreak
 
Description:to verify the value of mtval while executing the ebreak instructions
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"

#include "riscv_test.h"
 
RVTEST_RV64M

RVTEST_CODE_BEGIN
 
  li gp, 3

  li x1,20

handler:
la x5,m_call
csrw mtvec,x5 
start: 

li x6,0x20
li x7,0x30
add x10,x6,x7
ebreak//mepc=mtval

nop
nop
add x10,x6,x7

jal x0,exit


.align 4
m_call:
csrr x11,mcause
csrr x12,mepc
csrr x13,mtval
addi x12,x12,4
csrw mepc,x12
mret

exit:
nop
nop
li x17,0x80000004
csrw mtvec,x17
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN

  TEST_DATA
 
 
RVTEST_DATA_END
 
