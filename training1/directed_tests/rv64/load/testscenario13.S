
/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:11/6/25

Owner:sumanth

Testcase name: sign extension

Description:we know that lw loads the signed data and lwu treats the data as unsigned value we get to know this output by seeing the spike  

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
li x12,0x123456789abcdef0 
li x7,-0x0
li x8,2
la x6,inp_data
#test1############
test1:
	ADDI x10,x12,2

test2:
	slli x10,x7,3

test3:
	neg x11,x8
test4:
	ld x11,4(x6)	

	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  .dword 0x000000000FFFFFFF//0
      

RVTEST_DATA_END













