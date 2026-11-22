
/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:10/6/25

Owner:sumanth

Testcase name:load upper immediate

Description:as we know the load upper immediate loads the upper 20 bits and keeps the lower most 12 bits to zero my intension is to check by lui more 20 bits check the errors

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:
level1:
li x12,0x12345

csrr x13,mstatus

li x14,0x2000
or x13,x14,x13
csrw mstatus,x13

float:
  li x6, 0x42C50000     // 98.5
  li x7, 0x41200000     // 10.0
  csrr x11, mstatus
  fmv.w.x f4, x6        // Move into f4
  fmv.w.x f5, x7        // Move into f5
  fadd.s f6, f4, f5     // f6 = f4 + f5 = 108.5
  csrr x11, mstatus
  csrr x12,mcause


//mret
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  .word 0x0FFFFFFF//0
  .word 0x06627912//4
  .word 0x584944fc//8
  .word 0x584944fc//12
  .dword 0x12345678558f5366//16
  .word 0x558f5366//24
  .word -0x29df2fb1//28
      

RVTEST_DATA_END











