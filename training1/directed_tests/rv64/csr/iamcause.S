#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

j start

trap_handler:
    csrr x10,mcause
    csrr x6,mepc
    addi x6,x6,4
    csrw mepc,x6
    mret

start:
  li gp, 3
  li x19,3
	la x6,trap_handler
	csrw mtvec,x6
 
	la x18,inp_data
	li x24,5
	add x20,x18,x24
 

exit:
nop
  
  TEST_PASSFAIL
RVTEST_CODE_END
 
 
  .data
RVTEST_DATA_BEGIN
  TEST_DATA
 
inp_data:
  .word 0x06627912
  .word 0x584944fc
  .word 0x558f5366
  .word 0x29df2fb1
  .word 0x40053e92
  .word 0x17010699
RVTEST_DATA_END
