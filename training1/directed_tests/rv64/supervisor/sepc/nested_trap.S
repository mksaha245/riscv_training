/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:5/12/2025
 
Owner:Sumanth
 
Testcase name:nested_trap
 
Description:This test verifies that 
1.first it hold the address of first faulting instruction after handling from the trap handler.
2.Then it should be holding faulting address of next exception. 
===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M

RVTEST_CODE_BEGIN

    li      gp, 3
    li      x1,20

handler:
    la      x5,m_trap_handler
    csrw    mtvec,x5 
start: 
    li      x23,0x800
    li      x27,0xffff
    csrw    medeleg,x27                   # medeleg[9]=1,#medeleg[3]=1
    csrr    x24,mstatus
    or      x24,x23,x24
    csrw    mstatus,x24                   # mstatus.mpp[12:11]=01 machine to supervisor mode change
    la      x26,s_mode
    csrw    mepc,x26
    mret

s_mode:
    la      x5,s_handler                    # s mode trap handler setup
    csrw    stvec,x5 
    li      x9,0x9 

    ecall
    beq     x9,x11,check_pass               # self checking
    bne     x9,x11,check_fail

.align 4
s_handler:
    la      x26,s_nested_handler
    csrw    stvec,x26
    csrr    x11,scause
    csrr    x14,stval
    bne     x9,x11,fail
    csrr    x12,sepc
    ebreak
    addi    x12,x12,4
    csrw    sepc,x12
    sret

s_nested_handler:
    csrr    x11,scause
    csrr    x14,stval
    li      x29,0x3
    beq     x29,x11,check_pass             # self check 
    csrr    x12,sepc
    addi    x12,x12,4
    csrw    sepc,x12
    sret

m_trap_handler:
    csrr    x15,mcause
    csrr    x14,mtval
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
inp_data:
    .word   0x12345678

TEST_DATA

RVTEST_DATA_END

