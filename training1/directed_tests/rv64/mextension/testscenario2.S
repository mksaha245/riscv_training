/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:17/06/25

Owner:sumanth

Testcase name:Divide by zero

Description:if any number is divide by zero it should give infinite but we should check the spike and know the answer

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start: 
// 
 li x6,0x100
 li x7,0

test1:
	div x10,x6,x7
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA




RVTEST_DATA_END




