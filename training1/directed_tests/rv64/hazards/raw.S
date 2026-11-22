/* ===========================================================
   Copyright 2025 Scaledge India Pvt Ltd - All Rights Reserved.

   Date        : 04/07/2025
   Owner       : Sumanth
   Testcase    : RAW Hazard
   Description : Verifies various RAW (Read After Write) hazard scenarios.
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
  la     x5, inp_data   # Load address of input data

start:

  # ==========================================================
  # Test 1: ALU-ALU Dependency (RAW hazard between ADD → SUB)
  # ==========================================================
test1:
  add    x10, x6, x7       # x10 = x6 + x7
  sub    x11, x10, x7      # RAW: reads x10 just written

  # ==========================================================
  # Test 2: Load-Use Hazard (MEM → EX)
  # ==========================================================
test2:
  lw     x12, 0(x5)        # Load word into x12 from memory
  add    x13, x12, x7      # RAW: uses loaded x12

  # ==========================================================
  # Test 3: Load → Store Hazard (using same register)
  # ==========================================================
test3:
  lw     x13, 0(x5)        # Load into x13
  sw     x13, 0(x5)        # RAW: store value from x13

  # ==========================================================
  # Test 4: ALU → Store Hazard
  # ==========================================================
test4:
  add    x14, x6, x7       # Compute value
  sw     x14, 0(x5)        # RAW: write x14 to memory

  # ==========================================================
  # Test 5: MUL → ADD Dependency
  # ==========================================================
test5:
  mul    x15, x6, x7       # Multiply
  add    x16, x15, x7      # RAW: x15 just written

  # ==========================================================
  # Test 6: ALU → Branch (control using recent result)
  # ==========================================================
test6:
  add    x17, x6, x7       # x17 = x6 + x7
  beq    x17, x13, test5   # RAW: branch depends on x17

  # ---------------------
  # End Test
  # ---------------------
  TEST_PASSFAIL

RVTEST_CODE_END

# ---------------------
# Data Section
# ---------------------
.data
RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
  .word  0x0FFFFFFF     # 0
  .word  0x06627912     # 4
  .word  0x584944FC     # 8
  .word  0x584944FC     # 12
  .dword 0x12345678558F5366 # 16
  .word  0x558F5366     # 24
  .word -0x29DF2FB1     # 28

RVTEST_DATA_END




