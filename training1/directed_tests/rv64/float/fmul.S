/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:20/6/25

Owner:sumanth

Testcase name:multiplication

Description:we know the multiplication now try the floating multiplication see output in spike file

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
	flw f9,16(x6)
	fmul.s f10,f5,f6

#multiply by zero
test2:
	fmul.s f11,f6,f7//00

#multiply by 1
test3:
	fmul.s f12,f6,f8//same number

# multiply by -1
test4:

	fmul.s f13,f6,f9//2's


  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
.float 2.5
.float 1.5
.float 0.0
.float 1.0
.float -1.0
.float 4.6
.float 8.8


RVTEST_DATA_END






