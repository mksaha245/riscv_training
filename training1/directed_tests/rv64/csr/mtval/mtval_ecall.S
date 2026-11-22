/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:24/11/2025
 
Owner:sumanth
 
Testcase name:mtval_ecall
 
Description:This test is to verify the value of mtval while executing the ecall instruction
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"

#include "riscv_test.h"
 
RVTEST_RV64M

RVTEST_CODE_BEGIN
 
  li gp, 3

  li x1,20

handler:
	la	 x5, m_call				#			traphandler setup
	csrw mtvec, x5 				#			write trap handler address to mtvec
start: 

	li	 x6, 0x20
	li	 x7, 0x30
	li	 x31, 0xb
	add	 x10,x6,x7
	ecall						#			mtval= 0

	nop
	nop
	add	 x10, x6, x7

	beq	 x11, x31, check_pass	#			self checking pass
	bne	 x11, x31, check_fail	#			self checking fail


.align 4
m_call:
	csrr x11,mcause				#			read mcause
	bne  x11,x31, fail			#			if cause != expected, fail
	csrr x13,mtval				#			read mtval=0
	csrr x12,mepc				#			read mepc
	addi x12,x12,4				#			update mepc to next instruction
	csrw mepc,x12
	mret						#			return from trap

check_fail:
	nop
	nop

check_pass:
	nop
	nop
	li	 x17,0x80000004
	csrw mtvec,x17


TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN

  TEST_DATA
 
 
RVTEST_DATA_END

