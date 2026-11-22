/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:17/11/2025
 
Owner:sumanth
 
Testcase name:mepc
 
Description:
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

 
start: 
	li x5,0x80000002
	lw x6,0(x5)
	csrr x8,mepc
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN

inp_data:
	.word 0x12345678
  TEST_DATA
 
 
RVTEST_DATA_END
