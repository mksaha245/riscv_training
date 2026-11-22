/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:2/12/2025
 
Owner:Sumanth
 
Testcase name:mideleg
 
Description:To know the default values of interrupt delegation
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

 
start: 

	li x5,0xffffffff
	csrr x6,mideleg
	csrw mideleg,x5		#from spike we came to know 0x00000222 are writable

TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END
