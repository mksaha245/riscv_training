
/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:4/12/25

Owner:sumanth

Testcase name:sstatus_default

Description:This test is to verify default value of sstatus and enable all 64 bits to high verify which bits are writable.

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64S
RVTEST_CODE_BEGIN

  li gp, 3
handler:
	la x10,s_call
	csrw stvec,x10
start:
	csrr x5,sstatus
	li x6,0xffffffff
	csrw sstatus,x6	



s_call:
	csrr x11,scause
	csrr x12,sepc
	addi x12,x12,4
	csrw sepc,x12
	sret

check_pass:
	li x22,0x80000004
	csrw stvec,x22


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



