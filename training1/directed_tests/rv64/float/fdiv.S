/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:20/6/25

Owner:sumanth

Testcase name:floating division

Description:dive the floating point numbers by different scenarios

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
	flw f8,12(x6)
	fdiv.s f10,f5,f6

#divide zero by zero
test2:
	fdiv.s f11,f7,f8//7fc0_0000 NaN

#divide by zero
test3:
	fdiv.s f12,f6,f7//7f80_0000 inf
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
.float 2.5
.float 1.5
.float 0.0
.float 0.0
.float 4.6
.float 8.8


RVTEST_DATA_END






