#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp, 1

# ==================================================
# TEST 1
# rd=x1, rs1=x5
# Expected RAS: PUSH
# ==================================================

    la   x5, func1
    jalr x1, x5, 0

    addi x10, x0, 10


# ==================================================
# TEST 2
# rd=x0, rs1=x1
# Expected RAS: POP
# ==================================================

    jal x1, func2

    addi x11, x0, 20


# ==================================================
# TEST 3
# rd=x5, rs1=x1
# Expected RAS: POP then PUSH
# ==================================================

    jal x1, func3

    addi x12, x0, 30


# ==================================================
# TEST 4
# rd=x1, rs1=x1
# Expected RAS: PUSH
# ==================================================

    jal x1, func4

    addi x13, x0, 40


TEST_PASSFAIL


# ==================================================
# FUNCTIONS
# ==================================================

func1:

    addi x20, x0, 100

    # return
    jalr x0, x1, 0


func2:

    addi x21, x0, 200

    # return
    jalr x0, x1, 0


func3:

    addi x22, x0, 300

    # RAS-specific rd=x5, rs1=x1
    # Expected: POP + PUSH
    #
    # Be careful: this changes control flow because
    # x1 is used as the target.
    jalr x5, x1, 0


func4:

    addi x23, x0, 400

    jalr x1, x1, 0


RVTEST_CODE_END

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
