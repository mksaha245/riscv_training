/* ===========================================================
   Copyright 2025 Scaledge India Pvt Ltd - All Rights Reserved.

   Date        : 04/07/2025
   Owner       : Sumanth
   Testcase    : WAW Hazard
   Description : Verifies Write After Write (WAW) hazard scenarios
   =========================================================== */

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  # ---------------------
  # Initialization
  # ---------------------
  li     gp, 3

start:
  li     x12, 512
  li     x6, 10
  li     x7, 20

  # ==========================================================
  # Test 1: WAW Hazard - ALU-ALU Write to Same Register
  # ==========================================================
test1:
  add    x11, x6, x7       # Write 1 to x11
  sub    x11, x6, x7       # Write 2 to x11 (WAW hazard)

  # ==========================================================
  # Test 2: WAW Hazard - Load and ALU writing to Same Register
  # ==========================================================
test2:
  la     x5, inp_data
  lw     x12, 0(x5)        # Load word into x12
  add    x12, x6, x7       # Overwrite x12 again (WAW hazard)

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

inp_data:
  .word   0x0FFFFFFF       # 0
  .word   0x06627912       # 4
  .word   0x584944FC       # 8
  .word   0x584944FC       # 12
  .dword  0x12345678558F5366 # 16
  .word   0x558F5366       # 24
  .word  -0x29DF2FB1       # 28

RVTEST_DATA_END

