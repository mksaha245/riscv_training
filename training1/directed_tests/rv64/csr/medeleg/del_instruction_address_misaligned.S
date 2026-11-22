/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:3/12/2025
 
Owner:sumanth
 
Testcase name:del_instruction_misaligned_address
 
Description: This test verifies  that jump to misaligned address then this exception will occur while enabling the delegation and verify that trap is handled in supervisor mode or not.
 
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
	li x5,0x3			
	slli x5,x5,11
	csrc mstatus,x5
	li x5,0x1
	slli x5,x5,11
	csrs mstatus,x5		#mstatus.mpp[12:11]=01 switch machine to supervisor mode


	la x7,s_mode
	csrw mepc,x7
	mret

s_mode:
	la x5,s_call		#supervisor trap handler setup
	csrw stvec,x5
	
	la x10,target_addr	#jump to target address that is misaligned
	jalr x1,x10,1		#offset misaligned


target_addr:
	nop

	 beq x0,x11,pass	#exception is not generating
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

