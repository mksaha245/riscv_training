/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:4/7/2025

Owner:sumanth

Testcase name:structural Hazard

Description: 

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MU
RVTEST_CODE_BEGIN

  li gp, 3
start:
//li x12,512 
li x6,10
li x7,20
#test1###########

test1:
	la x5,inp_data
	lw x14,0(x5)
	add x14,x6,x7

test2:

	add x15,x6,x7
	sw x15,0(x5)

test3:
		
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
  .dword 0x12345678558f5366//16
  .word 0x558f5366//24
  .word -0x29df2fb1//28
  RVTEST_DATA_END









