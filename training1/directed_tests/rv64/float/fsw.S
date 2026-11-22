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

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 3
start: 
// 
 la x5,inp_data
 li x6,512
 li x7,256
fmv.w.x f6,x6
fmv.w.x f7,x6
test1:
	flw f11,0(x5)
	fsw f6,0(x5)
test2:
	//flw f12,3(x5)

test3:
	flw f13,4(x5)
	fsw f7,4(x5)
test4:
	flw f14,20(x5)
	fsw f7,20(x5)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
.float 2.5
.float 0.5
.float 4.6
.float 8.8


RVTEST_DATA_END





