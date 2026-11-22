/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:27/11/2025
 
Owner:Sumanth
 
Testcase name:meie
 
Description:this test is to verify when in mstatus mie is enabled , mie&mip 9 th bit also enabled then supervisor external interrupt generated
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

#setup for mtvec
handler:
	la x20,m_call
	csrw mtvec,x20
 
start:
#enabling the 3rd bit of mstatus
	li x5,0x1
	slli x5,x5,3
	csrs mstatus,x5
#enabling the 9th bit of mip and mie then interrupt will generated	
	li x10,0x1
	slli x10,x10,9
	csrs mip,x10
	csrs mie,x10
	jal x0,exit

m_call:
	csrr x11,mcause
	csrr x12,mtval
	csrr x13,mepc
	addi x13,x13,4
	csrw mepc,x13
	mret

exit:
	nop
	nop
	li x31,0x80000004
	csrw mtvec,x31

	 
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END


