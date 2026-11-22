/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:17/11/2025

Owner:sumanth

Testcase name:mepc2bits

Description:according to specification the last two bits of mepc is 0 i am trying to write in that 2 bits a non-zero value 

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
  li x1,20
 

start:

	li x5,1
	csrw mepc,x5//ignoring the 1 it only 4 byte aligned 
	
 TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
