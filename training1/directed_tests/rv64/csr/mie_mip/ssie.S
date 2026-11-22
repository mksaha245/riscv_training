/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:27/11/2025
 
Owner:Sumanth
 
Testcase name:ssie
 
Description:This test is to verify when mie bit is enabled , 1st bit of mie & mip are enable then supervisor software interrupt is generated.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20
#setup the mtvec
handler:
	la x20,m_call
	csrw mtvec,x20
 
start:
#setting 3rd bit of mstatus
	li x5,0x1
	slli x5,x5,3
	li x31,0x8000000000000001
	csrs mstatus,x5
#setting 1st bit of mie & mip to high then supervisor software can be generated
	li x10,0x1
	slli x10,x10,1
	csrs mip,x10
	csrs mie,x10

m_call:
	csrr x11,mcause		#0x8000000000000001
	beq x11,x31,check_pass
	bne x11,x31,fail
	csrr x12,mtval
	csrr x13,mepc
	addi x13,x13,4
	csrw mepc,x13
	mret

check_pass:
	nop
	nop
	li x30,0x80000004
	csrw mtvec,x30

	 
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END
