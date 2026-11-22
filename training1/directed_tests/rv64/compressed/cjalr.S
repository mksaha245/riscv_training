#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
li gp, 3
 
# Test 1:compressed jalr
test1:
    la x1, label1
    c.jalr x1
   c.nop
	c.nop
label1:
    c.li x6,31
 
TEST_PASSFAIL
RVTEST_CODE_END
 
.data
 
RVTEST_DATA_BEGIN
TEST_DATA
RVTEST_DATA_END
