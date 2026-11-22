/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:18/11/2025
 
Owner:sumanth
 
Testcase name:mtvec_4byte
 
Description:As mtvec register lsb two bits are 4 byte alligned i want to verify that what happens if its not 4 byte alligned 
 
===========================================================*/
 
//Testcase writing section
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1,20

 
start:
li x10,0x5
li x12,0x5
li x5,0x80000003
csrw mtvec,x5
//csrr x6,mepc
ecall
.align 4
add x11,x10,x12

m_call:
csrr x7,mcause
csrr x8,mepc
addi x8,x8,4
csrw mepc,x8
mret
 
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END
