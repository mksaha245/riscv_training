#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
  li x1,20
j start 

start: 
csrr x10,medeleg
li x9,0x8
csrw medeleg,x9

li x6,0x800
csrw mstatus,x6
la x16,m_call
csrw mtvec,x16
la x6,s_mode
csrw mepc,x6
mret

s_call:
csrr x12,scause
csrr x13,sepc
addi x13,x13,4
csrw sepc,x13
sret

m_call:
csrr x14,mcause
csrr x15,mepc
addi x15,x15,4
csrw mepc,x15
mret

s_mode:
la x18,s_call
csrw stvec,x18
li x28,0x20
li x29,0x30
addi x28,x28,6
add x28,x28,x29
ebreak
j exit

exit:
nop


  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END

