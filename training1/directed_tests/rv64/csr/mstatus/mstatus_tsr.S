/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:21/11/2025

Owner:Sumanth

Testcase name:mstatus_tsr

Description:
This test verifies that when the tsr bit is enabled, executing the sret instruction
in supervisor mode triggers an illegal exception.

===========================================================*/

// Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3                      
    li      x1, 20                     

start:
    csrr    x4, mstatus                  # read mstatus
    li      x5, 0x400800                 # mstatus.tsr[21] = 1, mstatus.mpp[12:11] = 01 (M -> S)
    or      x5, x4, x5                   # combine current mstatus with new bits
    csrw    mstatus, x5                  # write back to mstatus

# trap handler setup
    la      x21, m_call                  # machine mode trap handler address
    csrw    mtvec, x21                   # set mtvec
    li      x22, 0x2                     # expected cause for illegal instruction

    la      x6, s_mode                   # supervisor mode entry
    csrw    mepc, x6                     # set mepc
    mret                                 # return from machine mode

# supervisor mode
s_mode:
    la      x7, s_call                   # supervisor trap handler address
    csrw    stvec, x7                    # set stvec

    li      x27, 0x2                     # expected trap cause
    addi    x5, x5, 4                    # increment temporary register

    li      x29, 0x000                   # sstatus.spp[8] = 0 (S -> U)
    csrr    x30, sstatus                 # read sstatus
    or      x29, x30, x29                # update sstatus
    csrw    sstatus, x29                 # write back sstatus

    la      x10, u_mode                  # user mode entry
    csrw    sepc, x10                    # set sepc
    sret                                 # triggers illegal exception due to tsr

u_mode:
    nop                                  # user mode placeholder

s_call:
    csrr    x8, scause                   # read supervisor cause
    csrr    x9, sepc                     # read supervisor EPC
    addi    x9, x9, 4                    # skip faulting instruction
    csrw    sepc, x9                       
    sret                                 # return from supervisor trap

.align 4
m_call:
    csrr    x8, mcause                   # read machine cause
    beq     x8, x27, check_pass          # check if cause matches expected
    bne     x8, x27, check_fail          # fail if not matching

    csrr    x9, mepc                     # read machine EPC
    addi    x9, x9, 4                    # skip faulting instruction
    csrw    mepc, x9
    mret                                 # return from machine trap

check_fail:
    nop                                  # fail padding
    nop

check_pass:
    nop                                  # pass padding
    nop
    li      x14, 0x80000004              # reset mtvec
    csrw    mtvec, x14

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
