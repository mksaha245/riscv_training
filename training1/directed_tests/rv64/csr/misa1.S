//===========================================================

//Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

//Date:17/11/2025

//Owner:sumanth

//Testcase name:misa (machine isa)

//Description:to know the which extensions support in the core

//===========================================================


#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
  li x1,20
start: 

	level1:
		csrr x11,misa//0x14112d is the default value means atomic,compress,double,single precision,integer,m extension,supervisor,user are supported
		li x10,0x000000
		csrr x11,misa
		csrw misa,x10//0x140100 means integer,supervisor,user are non changable others are toggling
		csrr x12,misa

	level2:

		li x13,0x1FFFFFF
		csrw misa,x13// illegal so misa is read only 
		csrr x14,misa
 

  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END






