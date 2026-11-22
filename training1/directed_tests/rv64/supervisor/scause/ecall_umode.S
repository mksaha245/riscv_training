/*===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:5/12/2025

Owner:Sumanth

Testcase name:ecall_umode

Description:This test is to verify the value of scause while executing the ecall exception from user mode.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li gp, 3
    li x1,20

handler:
    la      x5,m_trap_handler
    csrw    mtvec,x5 

start: 
    li      x23,0x800
    li      x27,0x200
    csrw    medeleg,x27        # medeleg[9]=1, delegate ecall to supervisor
    csrr    x24,mstatus
    or      x24,x23,x24
    csrw    mstatus,x24        # mstatus.mpp[12:11]=01, machine to supervisor mode
    la      x26,s_mode
    csrw    mepc,x26
    mret

s_mode:
    la      x5,s_handler
    csrw    stvec,x5 

    li      x6,0x20
    li      x7,0x3
    li      x9,0x8
    add     x10,x6,x7

    li      x20,0x000
    //csrr    x21,sstatus        # sstatus.spp[8]=0, switch supervisor to user
    //or      x21,x20,x21
    csrw    sstatus,x20

    la      x22,u_mode
    csrw    sepc,x22
    sret

u_mode:
    nop
    nop
    ecall
    li      x9,0x8
    add     x10,x6,x7
    beq     x9,x11,check_pass  # self-checking
    bne     x9,x11,check_fail

.align 4
s_handler:
    csrr    x11,scause         # scause for ecall from user
    csrr    x14,stval
    bne     x9,x11,fail
    csrr    x12,sepc
    addi    x12,x12,4
    csrw    sepc,x12
    sret

m_trap_handler:
    csrr    x15,mcause
    csrr    x14,mtval
    bne     x15,x9,fail
    beq     x15,x9,check_pass  # self-check pass
    csrr    x16,mepc
    addi    x16,x16,4
    csrw    mepc,x16
    mret

check_fail:
    nop
    nop

check_pass:
    nop
    nop
    li      x17,0x80000004
    csrw    stvec,x17

TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA
RVTEST_DATA_END

