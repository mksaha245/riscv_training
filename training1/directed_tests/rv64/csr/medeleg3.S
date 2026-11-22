/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:19/11/2025
 
Owner:sumanth
 
Testcase name:del_illegal_exception
 
Description:
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

 
start:
csrr x21,medeleg
//csrw medeleg,x0
//li x22,0xFFFF
//csrw medeleg,x22
//csrr x10,medeleg
li x9,0x8
csrw medeleg,x9

li x6,0x800
csrw mstatus,x6
la x16,s_handler
csrw stvec,x16
la x6,s_mode
csrw mepc,x6
mret

.align 4
s_handler:
csrr x12,scause
csrr x13,sepc
addi x13,x13,2
csrw sepc,x13
sret

.align 4
s_mode:
li x28,0x20
li x29,0x30
addi x28,x28,6
add x28,x28,x29
ebreak
j exit

exit:
nop


TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
inp_data:
	.word 0x12345678
	.word 0x98765432
	.word 0x11223344
  TEST_DATA
 
 
RVTEST_DATA_END

