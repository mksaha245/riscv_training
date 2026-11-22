/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:25/11/2025
 
Owner:sumanth
 
Testcase name:del_illegal_instruction
 
Description:this test verifies that when delegation is enabled verify the illegal exception are handled in supervisor mode or not.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"

#include "riscv_test.h"
 
RVTEST_RV64M

RVTEST_CODE_BEGIN
 
  li gp, 3

  li x1,20


start: 
	csrr x5,medeleg
	csrw medeleg,x0
	csrr x5,medeleg

	li x6,0xffffffff		#make all fields enable in medeleg csr
	csrw medeleg,x6			#by this we can know which bits are writable in medeleg
	csrr x7,medeleg

	li x8,0x1
	slli x8,x8,11
	csrs mstatus,x8			#mstatus.mpp[12:11]=01 switch machine to supervisor mode

	la x9,s_mode
	csrw mepc,x9			
	mret

.align 4
//------------supervisor mode entry---------//
s_mode:
	li x31,0x20
	li x30,0x30
	add x29,x30,x31
handler:
	la x5,s_call			#setup for supervisor trap handler
	csrw stvec,x5
supervisr:
	addi x8,x8,4 
	csrw mvendorid,x7		#illegal instruction exception must generate because we are writing into read only csr
 	add x10,x8,x7
	li x30,0x2
	bne x30,x10,check_not_passed
	beq x30,x10,check_passed#not properly handled and it is not going into the trap handler	

.align 4
//---------s mode trap handler-------------//
s_call:

	csrr x10,scause
	csrr x11,sepc
	addi x11,x11,4
	csrw sepc,x11
	sret

check_not_passed:
	nop
	nop

.align 4
check_passed:

	nop
	add x10,x8,x7
	li x23,0x80000004
	csrw mtvec,x23


TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN

  TEST_DATA
 
 
RVTEST_DATA_END

