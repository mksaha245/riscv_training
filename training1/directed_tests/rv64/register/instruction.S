/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:6/6/2025

Owner:sumanth

Testcase name:alligned address checking

Description: as we know byte is 1byte alligned half is 2 byte alligned, word is 4 byte alligned, double is 8 byte alligned we are checking for alligned address

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
	li x5,10
	li x6,20
	li x8,20
	li x9,4
	li x31,2
test1:
	add x10,x5,x6
	sub x10,x6,x5
	mul x10,x5,x6
	div x10,x6,x5
	sll x14,x9,x31
	srl x14,x9,x31
	or x14,x5,x6
	and x14,x5,x6
	xor x14,x5,x6
test2:
	addi x10,x5,2
	slli x10,x9,1
	srli x10,x8,3
	ori x14,x5,2
	andi x14,x5,3
	xori x14,x5,7

test3:
	la x7,inp_data
	lb x11,0(x7)
	lh x11,0(x7)
	lw x11,0(x7)
	ld x11,0(x7)
test4:
	li x12,0x12345678
	sb x12,0(x7)
	sh x12,0(x7)
	sw x12,0(x7)
	sd x12,0(x7)
test7:
	amoadd.w x11,x6,0(x7)
	amoand.w x11,x6,0(x7)
	lr.w x12,0(x7)
	sc.w x13,x12,0(x7)
test8:
	li x11,10
	li x12,7
	la x13,inp_data
	c.add x5,x6
	c.addi x5,10
	c.and x11,x12
	c.andi x11,7
	c.or x11,x12
	c.slli x12,2
	c.sub x11,x12
	c.sw x12,0(x13)
	c.xor x11,x12

test9:
	mulh x15,x5,x6
	mulhsu x15,x5,x6
	mulhu x15,x5,x6
	mulw x15,x5,x6
	div x15,x5,x6
	divu x15,x5,x6
	rem x15,x9,x31
	remu x15,x9,x31



test:
	

test5:
	beq x6,x8,taken

taken:
add x10,x5,x6
		

test6:
	jal x1,nontaken
	jalr x1,0(x6)

nontaken:
add x10,x5,x6
		
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









