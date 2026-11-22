/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:24/11/2025
 
Owner:sumanth
 
Testcase name:del_load_address_misaligned
 
Description:This test verifies that by enabling the delegation when load word from a unalligned address exception occurs and verify that trap is handled in supervisor mode or not.
 
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
	csrw medeleg,x6		#medeleg[4]=1
	li x5,0x800
	csrw mstatus,x5		#mstatus.mpp[12:11]=01 switch machine to supervisor moder
	la x28,mcall
	csrw mtvec,x28
	la x7,s_mode
	csrw mepc,x7
	mret

s_mode:
	la x30,s_call		#trap handler setup
	csrw stvec,x30
	la x8,inp_data
	lw x9,2(x8)			#load address misaligned address exception


	addi x9,x9,4
	li x31,0x4
	bne x11,x31,not_pass#self checking logic
	beq x11,x31,check_pass

.align 4
mcall:					#delegatable but trap is handling in machine mode
	csrr x11,mcause	
	csrr x12,mepc
	addi x12,x12,4
	csrw mepc,x12
	mret

s_call:
	csrr x11,scause
	csrr x12,sepc
	addi x12,x12,4
	csrw sepc,x12
	sret

not_pass:
	nop
	nop

check_pass:
	nop
	nop
	li x17,0x80000004
	csrw mtvec,x17
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

