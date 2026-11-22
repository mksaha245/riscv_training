
/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:11/6/25

Owner:sumanth

Testcase name:raw,war,waw

Description:loading a data in destination register and same register in memory for dependency check

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
li x12,0xf1234567
li x13,0x200 
la x6,inp_data
#test1############
test1:
	lb x11,0(x6)
	lh x11,0(x6)
	lw x11,0(x6)
	lbu x11,0(x6)
	lhu x11,0(x6)
	lwu x11,0(x6)
	

	lwu x11,0(x6)
	mv x13,x12

test2:
	sh x12,2(x6)
	lh x11,0(x6)
	
test3:
	lb x11,4(x6)
	lh x11,4(x6)
	lw x11,4(x6)
	lbu x11,4(x6)
	lhu x11,4(x6)
	lwu x11,4(x6)

test4:
	sw x12,4(x6)
	lw x11,4(x6)	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  .word 0xFFFFFFFF//0
  .word 0xf6627912//4
  .word 0x584944fc//8
  .word 0x584944fc//12
  .dword 0x12345678558f5366//16
  .word 0x558f5366//24
  .word -0x29df2fb1//28


     RVTEST_DATA_END












