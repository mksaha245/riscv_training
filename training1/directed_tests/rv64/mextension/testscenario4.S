/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:17/6/25

Owner:sumanth

Testcase name:Sign and unsign check

Description:Performing the operations all multiplication instructions see how each and every instructions behaves

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
 li x7,0xf1234567
 li x8,0x123456789abcdef0
 li x9,0xf123456789abcdef
 li x5,0x12345678
 li x8,-16
 li x9,-16

#unsigned
test1:
	mul x10,x6,x5
	mulh x10,x6,x5
	mulhu x10,x6,x5
	mulhsu x10,x6,x5
	
#unsignedXsigned
test2:
	mul x11,x6,x7
	mulh x11,x6,x7
	mulhu x11,x6,x7
	mulhsu x11,x6,x7


#unsignedXunsigned
test3:
	mul x12,x8,x9
	mulh x12,x8,x9
	mulhu x12,x8,x9
	mulhsu x12,x8,x9

#more than 32 bits
test4:

	mul x13,x8,x9
	mulh x13,x8,x9
	mulhu x13,x8,x9
	mulhsu x13,x8,x9
	mulw x13,x8,x9

  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA




RVTEST_DATA_END





