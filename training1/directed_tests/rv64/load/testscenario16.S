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
li x12,512 
//RAW Dependency
test1:
#simple load store 
	la x6,inp_data
	lw x11,0(x6)
	sw x11,0(x6)
test2:
	add x10,x5,x6
	sub x11,x10,x6
		
test3:

	
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









