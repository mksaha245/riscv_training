#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
  li x1,20
start:
la x5,trap_handler
csrw mtvec,x5

test1:
li x5,0x20
li x6,0x10
add x10,x5,x6
ebreak
li x7,20
j done

.align 4
trap_handler:
csrr x8,mepc
addi x8,x8,2
csrw mepc,x8
csrr x11,mcause
csrr x12,mtval
mret


done:
nop
li x21,0x80000004
csrw mtvec,x21
csrr x13,mscratch

 
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END



