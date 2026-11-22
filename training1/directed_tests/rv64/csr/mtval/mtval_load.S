/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:21/11/2025
 
Owner:sumanth
 
Testcase name:mtval_load
 
Description:This test is to verify the value of mtval on load misaligned address exception.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

handler:
	la	 x5,m_handler		#trap handler setup
	csrw mtvec,x5
 
start:
	li x31,0x4
 	la x6,inp_data
 	lw x5,2(x6)				#load address misaligned 
	li x7,9
	li x8,5
	add x10,x7,x8
	beq x11,x31,check_pass	#self checking for pass
	bne x11,x31,check_fail	#self checking for fail

#trap handler
.align 4
m_handler:
	csrr x11,mcause
	bne  x11,x31,fail	
	csrr x13,mtval			#mtval should be faulting address inside memory
	csrr x12,mepc
	addi x12,x12,4
	csrw mepc,x12
	mret

check_fail:
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

  TEST_DATA
 
 
RVTEST_DATA_END
