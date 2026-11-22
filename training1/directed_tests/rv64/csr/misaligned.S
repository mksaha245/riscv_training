#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:


Install_trap_handler:
  la   x5, my_Trap_handler
  csrw mtvec, x5

level1:
  la   x9, inp_data
  lw   x12, 1(x9)      

 li x9,5         
 j done
my_Trap_handler:
  csrr x12, mepc
  li  x13, 4
  add  x12,x12,x13
  csrw mepc,x12
  csrr x11, mcause     
  csrr x10, mtval

  mret

done:
nop
li x20,0X80000004
csrw mtvec, x20
csrr x21, mtvec
lw   x12, 0(x9)
nop

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
inp_data:
  .word 0x06627935
  .word 0x584944fc
  .word 0x06627935
  TEST_DATA
RVTEST_DATA_END
