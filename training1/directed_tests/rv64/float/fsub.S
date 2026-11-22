/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:20/6/25

Owner:sumanth

Testcase name:floating substraction

Description:lets substract same floating number observe 0 in output

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 3
start: 
// 
 la x6,inp_data
test1:
	flw f5,0(x6)
	flw f6,4(x6)
	flw f7,8(x6)
	fsub.s f10,f5,f6

#substract with same number 
test2:
	fsub.s f11,f6,f7
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
.float 2.5
.float 1.5
.float 1.5
.float 4.6
.float 8.8


RVTEST_DATA_END






