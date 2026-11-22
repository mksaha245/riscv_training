/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:8/12/2025

Owner:Sumanth

Testcase name:mstatus_mpp

Description:
This test verifies the mstatus.mpp bit and checks if it switches
Machine mode to Supervisor mode.

===========================================================*/

// Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3                  # global pointer init

start:
    csrr    x6, mstatus
    li      x5, 0x800
    or      x5, x6, x5
    csrw    mstatus, x5            # mstatus.mpp[12:11] = 01 (M -> S)

    la      x8, s_mode             # setup supervisor mode entry
    csrw    mepc, x8
    mret

s_mode:
    add     x10, x6, x5            # simple operation to verify execution in S-mode

    TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
