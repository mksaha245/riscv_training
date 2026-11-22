/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date: 6/6/25

Owner:sumanth

Testcase name:

Description:

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
li x12,512 
#test1############
test1:
	la x6,inp_data1
	jalr x1,4(x6)
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  .word 0x0FFFFFFF//0
  .word 0x06627912//4
  .word 0x584944fc//8
  .word 0x584944fc//12
inp_data1:
  .dword 0x12345678558f5366//16
  .word 0x558f5366//24
  .word -0x29df2fb1//28
  RVTEST_DATA_END









