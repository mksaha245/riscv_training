/*===========================================================

Copyright  2026 Scaledge India Pvt Ltd - All Right Reserved.

Date: 9/10/26

Owner: Arvind

Testcase name: fp_basic_tc

Description:
verify fadd.s, fsub.s, fmul.s, fdiv.s and fsqrt.s with simple normal numbers (4.0 and 2.0).
Results are checked against the floating point calculator. No flag is expected.
===========================================================*/

// Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MF
RVTEST_CODE_BEGIN

  li gp, 3

 start:
 // x6 = start of the input data table
  la x6, inp_data

  // load the inputs into FP registers (f1, f2, ...)
  flw f1, 0(x6)   # 4.0
  flw f2, 4(x6)   # 2.0

test1:   # basic add, sub, mul, div, sqrt
  fadd.s f22, f1, f2   # expected 6.0 (0x40C00000)
  frflags x20          # read fflags, expected 0x00
  csrw fflags, x0      # clear flags for the next instruction
  fsub.s f23, f1, f2   # expected 2.0 (0x40000000)
  frflags x20          # read fflags, expected 0x00
  csrw fflags, x0      # clear flags for the next instruction
  fmul.s f24, f1, f2   # expected 8.0 (0x41000000)
  frflags x20          # read fflags, expected 0x00
  csrw fflags, x0      # clear flags for the next instruction
  fdiv.s f25, f1, f2   # expected 2.0 (0x40000000)
  frflags x20          # read fflags, expected 0x00
  csrw fflags, x0      # clear flags for the next instruction
  fsqrt.s f26, f1   # expected 2.0 (0x40000000)
  frflags x20          # read fflags, expected 0x00
  csrw fflags, x0      # clear flags for the next instruction

//===========================================================

  TEST_PASSFAIL

RVTEST_CODE_END


//===========================================================
// Data
//===========================================================

  .data

RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:

  .word 0x40800000   // offset 0: 4.0
  .word 0x40000000   // offset 4: 2.0

RVTEST_DATA_END

