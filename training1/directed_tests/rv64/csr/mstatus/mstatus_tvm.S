/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:21/11/2025

Owner:sumanth

Testcase name:mstatus_tvm

Description:This test is to verify when tvm bit is enabled when try to read or write to satp register will raise an illegal exception or not.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1, 20

start:
    csrr    x4, mstatus
    li      x5, 0x100800                  #mstatus.tvm[20]=1 ,
                                          #mstatus.mpp[12:11]=01 switch mode machine to supervisor
    or      x5, x5, x4
    csrw    mstatus, x5
    la      x21, m_call                    #machine trap handler setup
    csrw    mtvec, x21
    li      x22, 0x2
    la      x6, s_mode
    csrw    mepc, x6
    mret

#supervisor mode
s_mode:
    la      x7, s_call
    csrw    stvec, x7
    li      x24, 0x2
    addi    x5, x5, 4
    csrr    x5, satp                        #read or write on satp will raise an illegal exception due to tvm bit is high in mstatus
    la      x10, u_mode
    csrw    sepc, x10
    sret

u_mode:
    nop

s_call:
    csrr    x8, scause
    csrr    x9, sepc
    addi    x9, x9, 4
    csrw    sepc, x9
    sret

.align 4
m_call:
    csrr    x8, mcause
    bne     x8, x24, fail
    beq     x8, x24, check_pass
    csrr    x9, mepc
    addi    x9, x9, 4
    csrw    mepc, x9
    mret

check_pass:
    nop
    li      x14, 0x80000004
    csrw    mtvec, x14

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

