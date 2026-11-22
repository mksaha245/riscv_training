
/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:4/12/25

Owner:sumanth

Testcase name:spp

Description:This test is to verify whether switching mode from supervisor to user by the help of spp is occuring or not.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3

start:
	csrr x16,mstatus
	li x17,0x1
	slli x17,x17,11
	or x16,x16,x17
	csrs mstatus,x17
	la x18,smode
	csrw mepc,x18
	mret	
	
smode:
	la x10,s_call
	csrw stvec,x10
start1:
	csrr x5,sstatus
	li x6,0x0
	slli x6,x6,8
	or x6,x5,x6
	csrs sstatus,x6			#sstatus.spp[8]=0 switch supervisor to user
	la x9,enter_umode
	csrw sepc,x9
	sret
	

enter_umode:
	addi x21,x6,4
	jal x0,check_pass


s_call:
	csrr x11,scause
	csrr x12,sepc
	addi x12,x12,4
	csrw sepc,x12
	sret

check_pass:
	jal x0,pass

  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  .word 0x0FFFFFFF//0
  .word 0x06627912//4
  .word 0x584944fc//8
  .word 0x584944fc//12
  .dword 0x12345678558f5366//16
  .word 0x558f5366//24
  .word -0x29df2fb1//28
      

RVTEST_DATA_END


