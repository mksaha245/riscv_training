/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:25/11/2025
 
Owner:sumanth
 
Testcase name:medeleg6
 
Description:This checks that when delegation is enabled the store to an unalligned address will handled in supervisor mode or not
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

 
start:

li x6,0x10
csrw medeleg,x6
li x5,0x800
csrw mstatus,x5

la x7,s_mode
csrw mepc,x7
mret

s_mode:
li x14,0x12348765
la x8,inp_data
sw x14,2(x8)

la x5,s_call
csrw stvec,x5
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
li x23,0x80000004
csrw mtvec,x23

TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
inp_data:
	.word 0x12345678
	.word 0x98765432
	.word 0x11223344
  TEST_DATA
 
 
RVTEST_DATA_END


