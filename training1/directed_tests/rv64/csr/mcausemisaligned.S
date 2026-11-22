#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
trap:
la x5,arvind
csrw mtvec,x5
level1:
li x7,0x200
la x6,inp_data
sw x7,2(x6)
li x31,0x300
j done
arvind:
csrr x13,mepc
li x14,6
add x13,x13,x14
csrw mepc,x13
csrr x11,mcause  # see in for cause it has been trapped
csrr x12,mtval// see the which address it has been trapped
csrr x13,mepc

add x13,x10,x10
mret

j done
done:
nop
add x15,x7,x14

li x20,0X80000004
csrw mtvec, x20
csrr x21, mtvec
sw   x7, 0(x6)
nop

  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  .word 0x0FFFFFFF//0
  .word 0x06627912//4
  .word 0x584944fc//8
  .word 0x584944fc//12
  .dword 0x12345678558f5366//16
  .word 0x558f5366//24
  .word -0x29df2fb1//28
      

RVTEST_DATA_END

