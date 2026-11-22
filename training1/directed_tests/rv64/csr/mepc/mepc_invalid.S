/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:28/11/2025
 
Owner:Sumanth
 
Testcase name:mepc_invalid
 
Description:write an invalid pc to mepc that is not present in the core and verify any error or exception will occur.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

#set up handler 
handler:
	la x7,m_call
	csrw mtvec,x7
 
start:
	li x9,0x1
	csrr x7,mepc

	li x5,0xffffffffffff		#writing a invalid address to mepc
	csrw mepc,x5
	csrr x7,mepc				#read mepc 
	addi x10,x5,-2044
    mret						#using mret jumps into that invalid pc
	
	
m_call:
	csrr x11,mcause
	beq x11,x9,check_pass		#self check pass
	bne x11,x9,check_fail		#self check fail
	csrr x12,mtval
	csrr x13,mepc
	addi x13,x13,4
	csrw mepc,x13
	mret

check_fail:
	nop
	nop

check_pass:
	nop
	nop
	li x20,0x80000004
	csrw mtvec,x20

TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END
