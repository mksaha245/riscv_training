
#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
li x1,20
start: 
//the testintention is see jal
   # Addresses for test  
  li x12, 8 
  li x13, 28
la x5,test1
jalr x1,x5,0
add x5,x12,x13
nop
nop
test1:
add x6,x12,x13

TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  
RVTEST_DATA_END




