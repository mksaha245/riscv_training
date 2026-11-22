
/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:11/6/25

Owner:sumanth

Testcase name:raw,war,waw

Description:loading a data in destination register and same register in memory for dependency check

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
li x12,512
li x13,0x200 
la x6,inp_data
#test1############
test1:
	lw x11,0(x6)
//	sw x12,0(x11)//exception trap store access fault

test2:
	sw x12,0(x6)
//	lw x11,0(x12)//exception trap load access fault



test3:
	sw x12,0(x6)
//	sw x13,0(x12)//exception trap store access fault
	
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











