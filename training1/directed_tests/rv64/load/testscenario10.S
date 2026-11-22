
/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:10/6/2025

Owner:sumanth

Testcase name:load immediate

Description:Load Immediate instruction can load 32bit immediate value in RV32I and load 64bit immediate value in RV64I what if we load beyond the limit

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
	li x5,0x123456789abcdef0 	//it will load the immediate value

test2:
	//li x6,0x123456789abcdef01 	// it is beyond the limit so it will result as a illegal operand

test3:
	li x7,0x7fffffffffffffff 	// it will load
	li x11,0xdfffffffffffffff	// it will load
	
test4:
	li x8,0x8fffffffffffffff	// it will load

test5:
	li x9,-0x7fffffffffffffff	// it will load

test6:
//	li x10,-0xffffffffffffffff1	// it is beyond the so it will result a illegal operand

test7:
	li x11,-0x8000000000000001	// it will load
	
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











