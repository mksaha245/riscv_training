
#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start: 
//the testintention is see jal
   # Addresses for test  
  li x12, 8 
  li x13, 28
//
jal x1,test1
add x5,x12,x13
nop
nop
li x14,0x20
li x15,0x30
add x16,x14,x15
sub x17,x15,x14
mul x18,x15,x14
test1:
add x6,x12,x13

TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  
RVTEST_DATA_END




