#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
  li x1,20
start: 
li x5,0x200
csrr x13,mhartid
csrr x0,mvhartid

csrw mhartid,x5
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END


