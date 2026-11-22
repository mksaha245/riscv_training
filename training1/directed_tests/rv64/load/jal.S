
/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:11/6/25

Owner:sumanth

Testcase name: sign extension

Description:we know that lw loads the signed data and lwu treats the data as unsigned value we get to know this output by seeing the spike  

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
li x12,512 
li x7,-0x0
li x8,2

#test1############
test1:
	la x5,sumanth
	jal x1,sumanth
	andi x14,x12,31
	jalr x1,x5,4
	add x10,x12,x8
	nop
	nop
	nop

sumanth:
	addi x13,x12,-78
	xori x13,x12,2
	jal x5,ex
	ret	

ex:
nop	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


      

RVTEST_DATA_END













