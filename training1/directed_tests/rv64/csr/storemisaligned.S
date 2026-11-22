#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3

start:
  # setup mtvec to our handler
  la x5, arvind
  csrw mtvec, x5

  # data base address
  la x6, inp_data

  # put some test value in x7
  li x7, 0x200

  # intentionally cause misaligned store trap
  sw x7, 2(x6)

  # if no trap, jump to done
  j done


# ---------------------------------------------------------
# Trap handler (for misaligned access)
# ---------------------------------------------------------
arvind:
  # read mepc (address of faulting instruction)
  csrr x13, mepc

  # increment mepc by 4 so we skip the faulting instruction
  li x14, 4
  add x13, x13, x14
  csrw mepc, x13

  # read trap information
  csrr x11, mcause     # cause of trap
  csrr x12, mtval      # faulting address
  csrr x13, mepc       # return address (after skip)

  # store trap info to memory for verification
  la x10, trap_info
  sw x11, 0(x10)       # mcause
  sw x12, 4(x10)       # mtval
  sw x13, 8(x10)       # mepc after handler

  # return from trap
  mret


# ---------------------------------------------------------
done:
  nop
  add x15, x7, x14     # dummy operation

  TEST_PASSFAIL

RVTEST_CODE_END

# ---------------------------------------------------------
# Data section
# ---------------------------------------------------------
.data

RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
  .word 0x0FFFFFFF      # 0
  .word 0x06627912      # 4
  .word 0x584944fc      # 8
  .word 0x584944fc      # 12
  .dword 0x12345678558f5366  # 16
  .word 0x558f5366      # 24
  .word -0x29df2fb1     # 28

trap_info:
  .word 0               # mcause
  .word 0               # mtval
  .word 0               # mepc

RVTEST_DATA_END

