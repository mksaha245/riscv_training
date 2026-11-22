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
 la x6,inp_data
li x7,0x7fc00000
li x8,0x7fc00000
test1:
	flw f5,0(x6)
	flw f6,4(x6)
//	flw f7,8(x6)
//	flw f8,8(x6)
	fmv.w.x f14,f7,x7
	fmv.w.x f15,f8,x8
	feq.s x10,f5,f6

test2:
	feq.s x11,f7,f8
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
.float 2.5
.float 1.5
//.float 0x7fc00000
.float 4.6
.float 8.8


RVTEST_DATA_END






