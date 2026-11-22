/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:20/11/2025
 
Owner:sumanth
 
Testcase name:mstatus
 
Description: verifying tw bit when 21st bit is 0 it behaves normal when tw=1 then a illegal exception arises
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"

#include "riscv_test.h"
 
RVTEST_RV64M

RVTEST_CODE_BEGIN
 
  li gp, 3

  li x1,20

 
start: 
csrr x5,mstatus
li x6,0xffffffffffffffff
li x15,0x2
csrw mstatus,x6
li x7,0x200800
csrw mstatus,x7
la x14,m_call
csrw mtvec,x14

li x13,0x4
csrw medeleg,x13
la x9,s_call
csrw stvec,x9

la x8,s_mode
csrw mepc,x8

mret

s_mode:
la x9,s_call
csrw stvec,x9
addi x7,x7,4
wfi

addi x7,x7,4 
jal x0,exit
.align 4
s_call:
csrr x10,scause
csrr x11,stval
csrr x12,sepc
addi x12,x12,4
csrw sepc,x12
sret

m_call:
csrr x10,mcause
csrr x11,mtval
csrr x12,mepc
addi x12,x12,4
csrw mepc,x12
beq x15,x10,exit
mret

exit:
nop

li x16,0x80000004
csrw mtvec,x16
nop



TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN

  TEST_DATA
 
 
RVTEST_DATA_END

 
