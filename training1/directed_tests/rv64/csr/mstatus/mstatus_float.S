/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:17/11/2025

Owner:sumanth

Testcase name:mstatus_float

Description:This test is verify mstatus.fs ,verify how it is behaving in each state

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MF
RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1, 20

    j       start

trap_handler:
    csrr    x12, mcause
    csrr    x13, mepc
    addi    x13, x13, 4
    csrw    mepc, x13
    mret

start:
    li      x21, 0x80000004
    csrw    mtvec, x21
    la      x15, trap_handler
    csrw    mtvec, x15

    csrr    x10, mstatus                      // default value 0x8000000a00006080
    la      x11, inp_float

/*test1:
    li x5,0x0000
    csrw mstatus,x5                           // off
    flw f6,0(x11)                             // 00 state coming illegal instruction exception
*/

//---------------------01 state-----------------------------------------
test2:
    li      x6, 0x2000
    csrw    mstatus, x6                        // initial mstatus.fs[14:13]=01
    flw     f7, 0(x11)

//--------------------10 state------------------------------------------
test3:
    li      x7, 0x4000
    csrw    mstatus, x7                        // clean mstatus.fs[14:13]=10
    flw     f8, 4(x11)

//--------------------11 state--------------------------------------------
test4:
    li      x8, 0x6000
    csrw    mstatus, x8                        // dirty mstatus.fs[14:13]=11
    flw     f9, 0(x11)						   //mstatus.sd[63]=1

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
inp_float:
    .float  4.5
    .float  6.5
    .float  7.5

    TEST_DATA
RVTEST_DATA_END
