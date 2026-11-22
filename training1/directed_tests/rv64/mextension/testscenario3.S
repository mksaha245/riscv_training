/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:

Owner:

Testcase name:

Description:

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start: 
// 
 li x6,0x12345678
 li x7,0x123456789abcdef0
	li x8,0xf1234567

test1:
	mul x10,x6,x8
	mulh x11,x6,x7
	mulhu x12,x6,x8
	mulhsu x13,x7,x8
test2:
	li x28,0xf234
	div x14,x6,x28
	divu x15,x6,x28
	divw x16,x6,x28
	divuw x17,x6,x28

test3:
		
	rem x14,x6,x28
	remu x15,x6,x28
	remw x16,x6,x28
	remuw x17,x6,x28
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA




RVTEST_DATA_END





