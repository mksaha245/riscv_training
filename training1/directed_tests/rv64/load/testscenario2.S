/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:6/6/2025

Owner:sumanth

Testcase name:misalligned address checking

Description:as we know byte is 1byte alligned half is 2 byte alligned, word is 4 byte alligned, double is 8 byte alligned we are checking for misalligned address


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
#simple load store 
	la x6,inp_data
	lw x11,1(x6)
	sw x12,2(x6)
	lw x11,2(x6)

test2:
	lb x11,1(x6)	//as lb is 1 byte alligned we don't misalligned traps
	sb x12,1(x6)
	lb x11,1(x6)

test3:
	ld x11,4(x6)
	sd x12,4(x6)
	ld x11,4(x6)

test4:
	lh x11,3(x6)
	sh x12,3(x6)
	lh x11,3(x6)
		
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









