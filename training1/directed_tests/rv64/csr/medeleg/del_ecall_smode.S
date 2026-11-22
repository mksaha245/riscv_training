/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:27/11/2025
 
Owner:Sumanth
 
Testcase name:del_ecall_smode
 
Description:
This test verifies that by enabling the delegation, ecall is executed in
Supervisor mode and verify that trap is handled in supervisor mode or not.
 
===========================================================*/
 
// Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
    li      gp, 3
    li      x1, 20
 
start:
    li      x5, 0x200
    csrw    medeleg, x5          # enabling 9th bit of medeleg

    csrr    x31, mstatus
    li      x6, 0x800
    csrw    mstatus, x6          # mstatus.mpp[12:11] = 01 (Machine -> Supervisor)
    csrr    x6, mstatus

    la      x7, smode             # mepc setup
    csrw    mepc, x7
    mret
 
smode:
    la      x20, s_handler           # setup the supervisor handler
    csrw    stvec, x20

    li      x10, 2
    li      x11, 2
    li      x12, 9

    ecall                         # ecall from supervisor mode

    add     x15, x10, x11
    beq     x12, x16, check_pass  # if equal go the pass label
    bne     x12, x16, check_fail
 
s_handler:
    csrr    x16, scause
    bne     x12, x16, fail

    csrr    x17, stval
    csrr    x18, sepc
    addi    x18, x18, 4
    csrw    sepc, x18
    sret
 
check_fail:
    nop
    nop
 
check_pass:
    nop
    nop
 
TEST_PASSFAIL
 
RVTEST_CODE_END
 
.data
 
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

