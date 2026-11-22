/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:27/11/2025
 
Owner:Sumanth
 
Testcase name:del_ecall_mmode
 
Description:This test verifies that by enabling the delegation ,ecall is executed in machine mode and verify that trap is handled in supervisor mode or not.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

handler:
	la x31,mcall
	csrw mtvec,x31
start:
	li x5,0x800
	csrw medeleg,x5		#medeleg[11]=1
	csrr x31,mstatus
 	li x6,0x800
	csrw mstatus,x6		#mstatus.mpp[12:11]=01 mode will change to machine to supervisor
	csrr x6,mstatus	
	ecall				#ecall from m mode hence it is not delegatable beacuse it is going into machine mode handler
	la x7,smode			#mepc setup
	csrw mepc,x7
	mret

smode:
	la x20,s_call		#setup the supervisor handler
	csrw stvec,x20
	li x10,2
	li x11,2
	li x12,9
	add x15,x10,x11
	beq x12,x16,pass	#if equal go the pass label


s_call:

	csrr x16,scause
	csrr x17,stval
	csrr x18,sepc
	addi x18,x18,4
	csrw sepc,x18
	sret

mcall:
	csrr x16,mcause
	csrr x17,mtval
	csrr x18,mepc
	addi x18,x18,4
	csrw mepc,x18
	mret

exit:
	nop
	nop
	
	
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END
