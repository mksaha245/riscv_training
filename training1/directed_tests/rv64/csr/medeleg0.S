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

 
start:

li x6,1
csrw medeleg,x6
li x5,0x800
csrw mstatus,x5
la x5,s_call
csrw stvec,x5

la x7,s_mode
csrw mepc,x7
mret

s_mode:

la x10,target_addr
jalr x1,x10,0

.align 4
target_addr:
nop

j exit
s_call:
csrr x11,scause
csrr x12,sepc
addi x12,x12,4
csrw sepc,x12
sret

exit:
nop
nop
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
inp_data:
	.word 0x12345678
	.word 0x98765432
  TEST_DATA
 
 
RVTEST_DATA_END
