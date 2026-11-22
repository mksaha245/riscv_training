//===========================================================

//Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

//Date:17/11/2025

//Owner:sumanth

//Testcase name:readcsr mvendorid,marchid,mimpid,mhartid

//Description:read default values of the CSRs

//===========================================================

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
  li x1,20
 

start: 
	

	test1:
		csrr x5,mvendorid	#0
	
	test2:
		csrr x6,mimpid		#0

	test3:
		csrr x7,mhartid		#0

	test4:
		csrr x8,marchid		#5

	test5:
		//csrr x9,mconfigptr


  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END

