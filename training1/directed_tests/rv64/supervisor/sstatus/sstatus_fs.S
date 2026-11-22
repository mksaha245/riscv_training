/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:5/12/2025
 
Owner:Sumanth
 
Testcase name:sstatus_fs
 
Description:This test is to verify the sstatus floating bit by changing states.
 
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
//-----------------------test1-----------------------------------------	
	test1:
			la x20,inp_data
			csrr x21,sstatus
			li x22,0x0000
			or x22,x21,x22
			csrw sstatus,x22	#sstatus.fs[14:13]=00 //off state
			//flw f5,0(x20)		#in off state execute floating illegal instruction will occur

//----------------------test2------------------------------------------
	test2:
			li x22,0x2000
			or x22,x21,x22
			csrw sstatus,x22	#sstatus.fs[14:13]=01 //initial state
			flw f5,0(x20)		#sd bit=0

//----------------------test3-------------------------------------------
	test3:
			li x22,0x4000
			or x22,x21,x22
			csrw sstatus,x22	#sstatus.fs[14:13]=10 //clean state
			flw f5,0(x20)		#sstatus.sd[63]=0
//----------------------test4-----------------------------------------
	test4:
			li x22,0x6000
			or x22,x21,x22
			csrw sstatus,x22	#sstatus.fs[14:13]=11//dirty state
			flw f5,0(x20)		#sstatus.sd[63]=1


	li x9,0x0
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
inp_data:
	.float 4.5
	.float 3.5
  TEST_DATA
 
 
RVTEST_DATA_END

