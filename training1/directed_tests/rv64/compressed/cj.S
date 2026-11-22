
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV32M
RVTEST_CODE_BEGIN
 
 
test1:
 
	c.li x8,7
	c.j label

	c.nop
	c.nop
 
 
label:

    c.addi x11, 10
 
 
TEST_PASSFAIL
RVTEST_CODE_END
 
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END
 
