/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:8/12/25

Owner:sumanth

Testcase name:mstatus_mpp

Description:This test is to verify the mstatus.mpp bit,verify it is switching mode machine to user.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
	csrr x6,mstatus
	li x5,0x000
	or x5,x6,x5
	csrw mstatus,x5		#mstatus.mpp[12:11]=00 switch machine to user mode
	
	la x8,s_mode
	csrw mepc,x8
	mret

s_mode:
	add x10,x6,x5
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END

      


