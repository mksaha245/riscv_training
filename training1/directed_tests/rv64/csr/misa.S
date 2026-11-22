
#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
  li x1,20
start: 

level1:
  csrr x11,misa
  li x10,0x0
  csrr x11,misa
csrw misa,x10
  csrr x12,misa

 
level2:
li x6,6
  csrr x7,misa
  csrr x8,misa
  csrw misa,x12
  csrw misa,x6
  csrr x10,misa
  csrr x8,misa


  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END





