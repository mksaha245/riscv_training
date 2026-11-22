
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
trap:
la x5,arvind
csrw mtvec,x5
level1:
la x6,inp_data
lw x6,2(x6)

arvind:
csrr x11,mcause  # see in for cause it has been trapped
csrr x12,mtval  // see the which address it has been trapped

j done

done:
nop

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













