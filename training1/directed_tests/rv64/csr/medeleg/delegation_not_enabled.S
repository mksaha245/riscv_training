/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:28/11/2025
 
Owner:Sumanth
 
Testcase name:delegation_not_enabled
 
Description:
This test verifies that when delegation is disabled, traps are handled
in Machine mode or Supervisor mode handler.
 
===========================================================*/
 
// Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
    li      gp, 3                 # global pointer init
    li      x1, 20                # temp init

# setup for handler
handler:
    la      x31, m_call
    csrw    mtvec, x31
 
start:
    li      x5,  0x000
    csrw    medeleg, x5           # delegation disabled

    csrr    x31, mstatus
    li      x6,  0x800
    csrw    mstatus, x6           # mstatus.mpp[12:11] = 01 (M -> S)

    csrr    x6, mstatus

# setup for mepc
    la      x7,  smode
    csrw    mepc, x7
    mret

smode:
    la      x20, s_call           # setup S-mode handler
    csrw    stvec, x20

    li      x10, 2
    li      x11, 2
    li      x12, 9

# generating exception: ecall from supervisor mode
    ecall
    add     x15, x10, x11

# supervisor mode trap handler
s_call:
    csrr    x16, scause
    csrr    x17, stval
    csrr    x18, sepc

    addi    x18, x18, 4
    beq     x12, x16, pass
    csrw    sepc, x18
    sret

# machine mode trap handler
m_call:
    csrr    x16, mcause
    csrr    x17, mtval
    csrr    x18, mepc

    addi    x18, x18, 4
    beq     x12, x16, pass
    csrw    mepc, x18
    sret

exit:
    nop
    nop
 
TEST_PASSFAIL
 
RVTEST_CODE_END
 
.data
 
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

