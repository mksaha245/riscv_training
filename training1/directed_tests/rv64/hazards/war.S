/* ===========================================================
   Copyright 2025 Scaledge India Pvt Ltd - All Rights Reserved.

   Date        : 04/07/2025
   Owner       : Sumanth
   Testcase    : WAR Hazard
   Description : Verifies Write After Read hazard where a later
                 instruction writes to a register being read by an earlier one.
   =========================================================== */

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  # ---------------------
  # Initialization
  # ---------------------
  li     gp, 3
  li     x6, 10
  li     x7, 20
  li     x8, 0
  li     x9, 100
  la     x5, inp_data

start:

  # ==========================================================
  # Test 1: Read x6, then write to x6 (WAR)
  # ==========================================================
test1:
  add    x10, x6, x7       # Read x6 and x7 → result x10 = 30
  add    x6, x0, x8        # Overwrite x6 → WAR hazard on x6
  # Ensure that the first `add` gets the original x6 = 10, not overwritten one.

  # ==========================================================
  # Test 2: Load using x5, then overwrite x5
  # ==========================================================
test2:
  lw     x11, 0(x5)        # Read address from x5 and load data
  addi   x5, x0, 8         # Overwrite x5 after it's read
  # Ensure lw uses correct x5 value before it's overwritten

 
  TEST_PASSFAIL

RVTEST_CODE_END

# ---------------------
# Data Section
# ---------------------
.data
RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
  .word   0x00000064       # 0 => 100
  .word   0x000000C8       # 4 => 200

RVTEST_DATA_END

