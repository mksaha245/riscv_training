/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:21/11/2025

Owner:sumanth

Testcase name:mstatus_tw

Description:This test is to verify when tw bit is enabled when execute wfi in supervisor mode will raise an illegal exception or not.

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
    li      x5, 0x200800                  	#mstatus.tw[21]=1 ,
                                          	#mstatus.mpp[12:11]=01 switch mode machine to supervisor
    or      x5, x5, x4
    csrw    mstatus, x5
    la      x21, m_handler    				#machine trap handler setup
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
    wfi
    addi    x5, x5, 4
    beq     x8, x24, check_pass           	#self checking pass
    bne     x8, x24, check_fail           	#self checking fail

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
    csrr    x9, mepc
    addi    x9, x9, 4
    csrw    mepc, x9
    mret

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
