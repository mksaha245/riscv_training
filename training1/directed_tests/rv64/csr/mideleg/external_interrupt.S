
/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:2/12/2025
 
Owner:Sumanth
 
Testcase name:external_interrupt
 
Description:this test is to verify that when delegation is enabled in mideleg csr ,similarly sip ,sie bit is high verify interrupt is handling in supervisor mode or not.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"

#include "riscv_test.h"
 
RVTEST_RV64M

RVTEST_CODE_BEGIN
 
  li gp, 3

  li x1,20

 
start:
	csrr x5,mideleg		# reading the default value of mideleg
	li x6,0xffffffff	# enabling all the fields in mideleg
	csrw mideleg,x6		# verify which bits are writable
	csrr x7,mstatus		
	li x8,0x1
	slli x8,x8,3		# enable mie bit in mstatus
	csrs mstatus,x8	

	li x9,0x1			# mstatus.mpp[12:11]=01 change mode to machine to supervisor.
	slli x9,x9,11
	csrs mstatus,x9

	la x10,smode
	csrw mepc,x10
	mret

smode:

	la x12,scall		#setup for smode trap handler
	csrw stvec,x12
	li x27,0x1
	slli x27,x27,1
	csrs sstatus,x27	#sstatus.sie[1]=1
	li x11,0x1		
	slli x11,x11,9
	csrs sip,x11		#sip.seip[9]=1
	csrs sie,x11		#sie.seie[9]=1 

scall:
	csrr x14,scause
	csrr x16,stval
	csrr x15,sepc
	addi x15,x15,4
	csrw sepc,x15
	sret





TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN

  TEST_DATA
 
 
RVTEST_DATA_END
 

