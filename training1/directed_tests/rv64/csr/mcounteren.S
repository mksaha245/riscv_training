/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:
 
Owner:
 
Testcase name:
 
Description:
 
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
csrr x6,mcounteren
csrr x11,mcycle
csrr x12,minstret
csrr x13,mcountinhibit

li x21,0xffffffff
csrw mcountinhibit,x21

li x6,0xFFFFFFFF//cy=1,t=1,instruction retired=1
csrw mcounteren,x6

li x7,0x800
csrw mstatus,x7

la x8,s_mode
csrw mepc,x8

mret

s_mode:

jal x0,exit
m_call:
csrr x22,mcause
beq x22,x23,exit
csrr x23,mepc
csrr x24,mtval
addi x23,x23,4
csrw mepc,x23
mret


exit:
nop

//li x23,0x80000004
//csrw mtvec,x23

TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END
