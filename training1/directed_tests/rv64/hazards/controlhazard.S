/* ===========================================================
   Copyright 2025 Scaledge India Pvt Ltd - All Rights Reserved.

   Date        : 04/07/2025
   Owner       : Sumanth
   Testcase    : Control Hazard
   Description : Tests control hazard by branching and checking
                 if wrong path instructions are flushed correctly.
   =========================================================== */

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  # ---------------------
  # Initialization
  # ---------------------
  li     gp, 3
  li     x1, 10
  li     x2, 10
  li     x3, 0x100          # dummy value to track PC branch
  li     x4, 1
  li     x5, 0

start:

  # ==========================================================
  # Test 1: Control Hazard - Conditional Branch Taken
  # ==========================================================
test1:
  beq    x1, x2, branch_taken   # Should branch, hazard occurs
  addi   x5, x0, 111            # Wrong path (should be flushed)
  addi   x6, x0, 222            # Wrong path (should be flushed)

branch_taken:
  addi   x7, x0, 999            # Correct instruction after branch

  # ==========================================================
  # Test 2: Control Hazard - Conditional Branch Not Taken
  # ==========================================================
test2:
  li     x1, 5
  li     x2, 8
  bne    x1, x2, next_block     # Should branch
  addi   x8, x0, 111            # Wrong path (flushed)
  addi   x9, x0, 222            # Wrong path (flushed)

next_block:
  addi   x10, x0, 777           # Correct path

  # ---------------------
  # End Test
  # ---------------------
test3:
  TEST_PASSFAIL

RVTEST_CODE_END

# ---------------------
# Data Section
# ---------------------
.data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END

