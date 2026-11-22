/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:6/6/2025

Owner:sumanth

Testcase name:Negative offset check

Description:First i have to check the negative offset is working or not if yes,as we know for load store the offset is 12 bits so the range will -2048 to 2047  and bit is 0 so i am checking that what happens we give beyond negative offset value

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
li x12,512 
la x6,inp_data
#test1############
test1:
	lw x11,-100(x6)
	sw x12,-100(x6)

test2:
	lw x11,-2000(x6)
	sw x12,-2000(x6)

test3:
//	lw x11,-1999(x6)//
//	sw x12,-1999(x6)//

test4:
	lw x11,-2004(x6)
	sw x12,-2004(x6)

test5:
	lw x11,-2048(x6)
	sw x12,-2048(x6)

test6:
//	lw x11,-2052(x6)// illegal operands
//	sw x12,-2052(x6)// illegal operands	
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









