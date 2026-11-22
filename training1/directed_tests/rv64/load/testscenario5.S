/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:10/6/25

Owner:sumanth

Testcase name:cross the load store

Description:loading a big data from memory and storing the lesser data and compare

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
li x12,512 
#test1############
test1:
#	Load double and then store byte to same address, verify result
	li x13,0x1234
	ld x11,16(x6)
	sh x13,16(x6)
	ld x11,16(x6)

test2:
	ld x11,16(x6)
	sb x12,16(x6)
	ld x11,16(x6)

test3:
	ld x11,16(x6)
	sw x12,16(x6)
	ld x11,16(x6)

test4:
	lw x11,8(x6)
	sb x12,8(x6)
	lw x11,8(x6)

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









