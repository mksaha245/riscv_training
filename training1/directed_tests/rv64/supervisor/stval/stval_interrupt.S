/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:5/12/2025
 
Owner:Sumanth
 
Testcase name:stval_interrupt
 
Description:This test is to verify the value of stval while executing the supervisor software interrupt in supervisor mode.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"

#include "riscv_test.h"
 
RVTEST_RV64M

RVTEST_CODE_BEGIN
 
  li gp, 3

  li x1,20

handler:
	la x5,m_trap_handler
	csrw mtvec,x5 
start: 
	li x23,0x808
	li x27,0xffff
	csrw mideleg,x27
	//li x21,0x8
	
	csrr x24,mstatus
	or x24,x23,x24			#mstatus.mie[3]=1
	csrw mstatus,x24		#mstatus.mpp[12:11]=01 machine to supervisor mode change
	la x26,s_mode
	csrw mepc,x26
	mret

s_mode:
	la x5,s_handler
	csrw stvec,x5 

	li x6,0x20
	li x7,0x3
	li x9,0x8000000000000001

	add x10,x6,x7
	li x25,0x2
	csrr x6,sstatus			#sstatus.sie[1]=1
	or x26,x25,x26
	csrw sstatus,x26
	li x27,0x2
	csrs sip,x27			#sip.ssip[1]=1
	csrs sie,x27			#sie.ssie[1]=1
	nop
	nop
	li x9,0x8000000000000001
	add x10,x6,x7
	beq x9,x11,check_pass	#self checking
	bne x9,x11,check_fail


.align 4
s_handler:
	csrr x11,scause
	csrr x14,stval
	bne x9,x11,fail
	csrr x12,sepc
	csrr x13,stval
	addi x12,x12,4
	csrw sepc,x12
	sret

m_trap_handler:
	csrr x15,mcause
	csrr x14,mtval
	bne x15,x9,fail
	beq x15,x9,check_pass	#self check pass
	csrr x16,mepc
	addi x16,x16,4
	csrw mepc,x16
	mret

check_fail:
	nop
	nop

check_pass:
	nop
	nop
	li x17,0x80000004
	csrw stvec,x17
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN

  TEST_DATA
 
 
RVTEST_DATA_END

