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

handler:
	la x21,m_call
	csrw mtvec,x21
start:
	li x5,0
	csrc mcounteren,x5
	csrr x6,mstatus
	li x7,3
	slli x7,x7,11
	csrc mstatus,x7
	li x8,1
	slli x8,x8,11
	csrs mstatus,x8
	csrr x8,mstatus
	la x9,smode
	csrw mepc,x9
	mret
	
smode:
	li x5,0
	csrc mcounteren,x5
	csrr x21,mcounteren

m_call:
	csrr x16,mcause
	csrr x17,mtval
	csrr x18,mepc
	addi x18,x18,4
	beq x12,x16,pass
	csrw mepc,x18
	sret


TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END
