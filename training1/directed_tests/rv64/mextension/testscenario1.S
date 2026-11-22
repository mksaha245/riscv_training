/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:17/6/25

Owner:sumanth

Testcase name:divide by -1

Description:lets observe in spike file what happens when we divide by -1 we will get overflow condition

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start: 
// 
 li x6,0x80000000
 li x7,-1
 li x8,1
 li x9,100
test1:
	div x10,x6,x7//ffff_ffff_8000_0000

test2:
	 div x11,x8,x7

test3:
	div x12,x9,x7
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA




RVTEST_DATA_END



