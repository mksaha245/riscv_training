/*===========================================================

Copyright  2026 Scaledge India Pvt Ltd - All Right Reserved.

Date:5/10/26

Owner:sumanth

Testcase name: floating point exceptions

Description:
Generate all 5 IEEE-754 floating-point exception flags:

NV - Invalid Operation
DZ - Divide by Zero
OF - Overflow
UF - Underflow
NX - Inexact

===========================================================*/

// Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MF
RVTEST_CODE_BEGIN

  li gp, 3

  la x6, inp_data

//===========================================================
// Load floating point operands
//===========================================================

  flw f1, 0(x6)       // f1 = 0.0
  flw f2, 4(x6)       // f2 = 1.0
  flw f3, 8(x6)       // f3 = -1.0

  flw f4, 12(x6)      // f4 = 3.4e38
  flw f5, 16(x6)      // f5 = 2.0

  flw f6, 20(x6)      // f6 = 1.0e-30
  flw f7, 24(x6)      // f7 = 1.0e-10


//===========================================================
// Invalid Operation - NV
//===========================================================
// 0.0 / 0.0 = NaN
//
// Expected:
// Result = NaN
// fflags.NV = 1
//
// Clear fflags before test

test1:

  csrw fflags, zero

  fdiv.s f10, f1, f1

  csrr t0, fflags


//===========================================================
// Divide By Zero - DZ
//===========================================================
// 1.0 / 0.0 = +Infinity
//
// Expected:
// Result = +Infinity
// fflags.DZ = 1

test2:

  csrw fflags, zero

  fdiv.s f11, f2, f1

  csrr t0, fflags


//===========================================================
// Overflow - OF
//===========================================================
// 3.4e38 * 2.0
//
// FP32 maximum is approximately 3.4028235e38.
//
// Therefore:
// 3.4e38 * 2.0 > FP32 maximum
//
// Expected:
// Result = +Infinity
// fflags.OF = 1
// fflags.NX = 1

test3:

  csrw fflags, zero

  fmul.s f12, f4, f5

  csrr t0, fflags


//===========================================================
// Underflow - UF
//===========================================================
// 1.0e-30 * 1.0e-30
//
// Result = 1.0e-60
//
// This is far below the minimum normal FP32 value.
//
// Expected:
// Very small/subnormal or zero result
// fflags.UF = 1
// fflags.NX may also be 1

test4:

  csrw fflags, zero

  fmul.s f13, f6, f6

  csrr t0, fflags


//===========================================================
// Inexact - NX
//===========================================================
// 1.0 / 3.0
//
// 1/3 cannot be represented exactly in FP32.
//
// Expected:
// Result ~= 0.33333334
// fflags.NX = 1

test5:

  csrw fflags, zero

  fdiv.s f14, f2, f7

  csrr t0, fflags


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

  .float 0.0          // offset 0
  .float 1.0          // offset 4
  .float -1.0         // offset 8

  .float 3.4e38       // offset 12
  .float 2.0          // offset 16

  .float 1.0e-30      // offset 20
  .float 1.0e-10      // offset 24


RVTEST_DATA_END
