
#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
	li x1,4
start: 
//the testintention is see jal
   # Addresses for test  
  li x12, 8 
  li x13, 28
	la x1,test1
jalr x0,x1,4
add x5,x12,x13
nop
nop
li x13,0x20
li x14,0x30
add x15,x13,x14
sub x16,x14,x13
mul x17,x13,x14
test1:
add x6,x12,x13
add x6,x12,x13
add x6,x12,x13

TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  
RVTEST_DATA_END




