#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3                

start:
    csrr    x6, mstatus
    li      x5, 0x1000
    or      x5, x6, x5
    csrw    mstatus, x5            

    la      x8, h_mode             
    csrw    mepc, x8
    mret

h_mode:
    add     x10, x6, x5           

    TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
