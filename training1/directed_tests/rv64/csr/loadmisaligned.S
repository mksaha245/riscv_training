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
	la	x7,m_handler
	csrw mtvec,x7
	li 	x20,0x4
	la	x5,inp_data
load:
    lw	x6,2(x5)		#load address misaligned
	
	jal x0,exit


m_handler:
	csrr x11,mcause
	csrr x13,mtval
	bne	 x11,x20,fail
	csrr x12,mepc
	rem  x14,x13,x20
	add  x14,x14,x14
	sub	 x13,x13,x14  
	csrw mepc,x12
	mret

exit:
	nop
	nop


TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
inp_data:
	.word 0x12345678
	.word 0x21346587
  TEST_DATA
 
 
RVTEST_DATA_END
 
