/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:12/11/2025
 
Owner:Sumanth
 
Testcase name:execute_disable
 
Description:This test is to verify the behavior pmpcfg register when execute bit is disabled verify whether instruction access fault is raised or not.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

 
start:
	la x15,trap_handler	#trap handler setup
	csrw mtvec,x15
	li x5,0x800			#mstatus.mpp[12:11]=01 mode change machine to supervisor 
	csrr x6,mstatus
	or x6,x6,x5
	csrw mstatus,x6
	
pmp_label:
	csrr x7,pmpcfg0		#read default value of pmpcfg register
	li x8,0xB			#disable execute enable read,write
	csrw pmpcfg0,x8		#pmpcfg.e[2]=0
	csrr x31,pmpaddr0
	li x30,0x80004000	#top of range
	srli x30,x30,2		#shift 2 bits
	csrw pmpaddr0,x30	


	la x10,s_mode
	csrw mepc,x10
	mret

s_mode:
	li x13,0x12345678
	la x11,inp_data
	add x30,x30,x8
	sw x13,0(x11)
	lw x12,0(x11)		#load access fault


trap_handler:
	csrr x20,mcause
	csrr x21,mtval
	csrr x22,mepc
	addi x22,x22,4
	csrw mepc,x22
	mret


 
 
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
inp_data:

	.word 0x12345678
	.word 0x32415678
  TEST_DATA
 
 
RVTEST_DATA_END

