/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:9/6/2025

Owner:sumanth

Testcase name:memory overwrite

Description: we have to check what happens if we store different values in same register and same address

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
#memory overwrite in same register 
	la x6,inp_data
	li x14,0x123456789abcdef0
	sd x14,8(x6)
	ld x11,8(x6)
	li x14,0x12345678
	sw x14,8(x6)
	ld x11,8(x6)
	li x14,0x1234
	sh x14,8(x6)	
	ld x11,8(x6)
	li x14,0x12
	sb x14,8(x6)
	ld x11,8(x6)
	
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









