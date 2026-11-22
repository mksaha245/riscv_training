#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
  li x1,20
start: 
li x5,0x200
test1:
csrr x13,mimpid
csrr x0,mimpid

csrw mimpid,x5
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END


