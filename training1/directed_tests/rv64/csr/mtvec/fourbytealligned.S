/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:28/11/2025
 
Owner:Sumanth
 
Testcase name:fourbytealligned
 
Description:This test is to verify whether the mtvec goes into trap handler which is not four byte alligned.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

handler:
	la x5,m_call		#trap handler setup
	csrw mtvec,x5 
start:
	li x5,0x2
	csrw mvendorid,x5	#illegal exception
	nop
	beq x16,x5,check_pass
	bne x16,x5,check_fail
	


#trap handler non 4 byte alligned
m_call:
	csrr x16,mcause
	bne x16,x5,fail
	csrr x17,mtval
	csrr x18,mepc
	addi x18,x18,4
	csrw mepc,x18
	mret

check_fail:
	nop
	nop

check_pass:
	nop
	nop
	li x21,0x80000004
	csrw mtvec,x21

 
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END
