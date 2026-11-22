/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:19/11/2025
 
Owner:sumanth
 
Testcase name:mcause exceptions
 
Description:create different exceptions cases and handled through handlers.
 
===========================================================*/
 
#Testcase writing section
 
#include "test_macros.h"

#include "riscv_test.h"
 
RVTEST_RV64M

RVTEST_CODE_BEGIN
 
  	li gp, 3

  	li x1,20

 
start:
	#trap handler setup
	la x5,m_exp 
	csrw mtvec,x5

	li x6,0x20
	li x7,0x30
test0:
	# check all the possible scenarios for misaligned
	li x23,0x80000151

	jalr x0,x23,1
test1:
	#trying to write in the read only csr
	csrw mvendorid,x6// illegal exception mcause value 2
	add x10,x6,x7
test2: 
	la x9,inp_data
	lw x11,2(x9)//load misaligned exception mcause value 4
	add x10,x6,x7
test3:
	sw x6,2(x9)//store misaligned exception  mcause value 6
	add x10,x6,x7

test4:
	ebreak//breakpoint exception mcause value 3
	
	add x10,x6,x7
	add x21,x6,x7
	slli x6,x6,2

test5:
	li x16,0x3
	ecall// ecall from m-mode mcause value 11 //b
	add x10,x6,x7

test6:
	li x8,0x800
	csrw mstatus,x8
	la x14,s_mode
	csrw mepc,x14
	mret
	//la x18,s_call
	//csrw stvec,x18

s_mode:
	la x18,s_call
	csrw stvec,x18
	add x10,x6,x7
	ecall  //ecall from supervisor mode mcause value 9
	add x10,x6,x7
	li x17,0x000
	csrw sstatus,x17
//	la x18,s_call
//	csrw stvec,x18
	la x15,u_mode
	csrw sepc,x15
	sret

u_mode:
	add x10,x6,x7
	ecall // ecall from user mcause value 8
	add x10,x6,x7




	
jal x0, exit
.align 4
	# m mode handler
m_exp:
# keep individual exception individual testcase
#add self checking
	csrr x12,mcause
	beq  x15,x12,e_break
	csrr x19,mtval
	csrr x13,mepc
	addi x13,x13,4
	csrw mepc,x13
	li   x16,0x8
	beq  x16,x12,exit
	mret

e_break:
	csrr x12,mcause
	csrr x13,mepc
	addi x13,x13,2
	csrw mepc,x13
	mret

s_call:
	csrr x12,scause
	csrr x13,sepc
        csrr x19,stval
        addi x13,x13,4
        csrw sepc,x13
        sret

exit:

nop
//add x10,x6,x7
li x25,0x1800
csrw mstatus,x25
li x22,0x80000004
csrw mtvec,x22

	
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
inp_data:

	.word 0x12345678
	.word 0x98765432
	.word 0x34567891

  TEST_DATA
 
 
RVTEST_DATA_END

 
