
/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:4/12/25

Owner:sumanth

Testcase name:seie1

Description:This test is to verify whether supervisor external interrupt is generating ,verify the interrupt by scause.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3


start:
	la x10,m_call
	csrw mtvec,x10
	csrr x16,mstatus
	li x17,0x1
	slli x17,x17,11
	or x16,x16,x17
	csrs mstatus,x17
	la x18,smode
	csrw mepc,x18
	mret	
	

smode:
	csrr x5,sstatus
	li x6,0x1
	slli x6,x6,1
	or x6,x5,x6
	csrs sstatus,x6			#sstatus.spp[8]=0 switch supervisor to user
	li x8,0x1
	slli x8,x8,9
	csrs sip,x8			#sip.seip[5]=1 will not happen because seip is read only bit so interrupt will not generate
	csrs sie,x8			#sie.seie[5]=1
	


m_call:
	csrr x11,mcause
	csrr x12,mepc
	addi x12,x12,4
	csrw mepc,x12
	mret

check_pass:
	li x22,0x80000004
	csrw stvec,x22


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





