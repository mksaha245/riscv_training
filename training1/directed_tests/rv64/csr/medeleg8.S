/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:18/11/2025
 
Owner:sumanth
 
Testcase name:environment call from u mode
 
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

li x6,0x100
csrw medeleg,x6
li x5,0x000
csrw mstatus,x5
la x10,s_call
csrw stvec,x10
la x7,u_mode
csrw mepc,x7
mret

u_mode:

la x8,inp_data
lw x9,4(x8)
lw x14,4(x8)
ecall

add x18,x14,x9
//la x5,s_call
//csrw stvec,x5
jal x0, exit
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
	.word 0x11223344
  TEST_DATA
 
 
RVTEST_DATA_END

