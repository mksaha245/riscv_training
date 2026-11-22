#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp, 1

# --------------------------------------------------
# Test RET instruction
# --------------------------------------------------

test1:

    # Call function1
    jal x1, function1

    # Execution must come back here after function1
    addi x10, x0, 10       # Expected: executed

    # Call function2
    jal x1, function2

    # Execution must come back here after function2
    addi x11, x0, 20       # Expected: executed

    TEST_PASSFAIL


# --------------------------------------------------
# function1
# --------------------------------------------------

function1:

    addi x5, x0, 100

    # RET = jalr x0, x1, 0
    ret


# --------------------------------------------------
# function2
# --------------------------------------------------

function2:

    addi x6, x0, 200

    # RET
    ret


RVTEST_CODE_END

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
