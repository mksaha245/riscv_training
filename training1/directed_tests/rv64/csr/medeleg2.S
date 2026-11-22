/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:25/11/2025
 
Owner:sumanth
 
Testcase name:medeleg2
 
Description:when delegation is enabled verify the illegal exception are handled in supervisor mode or not.
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"

#include "riscv_test.h"
 
RVTEST_RV64M

RVTEST_CODE_BEGIN
 
  li gp, 3

  li x1,20

//handler:
//la x5,s_call
//csrw mtvec,x5
start: 
csrr x5,medeleg
csrw medeleg,x0
csrr x5,medeleg

li x6,0xffff
csrw medeleg,x6

//li x7,0x4
//csrw medeleg,x7
csrr x7,medeleg
test1:
la x5,s_call
csrw stvec,x5
li x8,0x800
csrw mstatus,x8
//la x5,s_call
//csrw stvec,x5


la x9,s_mode
csrw mepc,x9
mret

.align 4
//------------supervisor mode entry---------//
s_mode:
li x31,0x20
li x30,0x30
add x29,x30,x31
handler:
la x5,s_call
csrw stvec,x5
supervisr:
addi x8,x8,4 
csrw mvendorid,x7
 add x10,x8,x7
jal x0,exit

.align 4
//---------s mode trap handler-------------//
s_call:

csrr x10,scause
csrr x11,sepc
addi x11,x11,4
csrw sepc,x11
sret


.align 4
exit:

nop
add x10,x8,x7
li x23,0x80000004
csrw mtvec,x23


TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN

  TEST_DATA
 
 
RVTEST_DATA_END

 
