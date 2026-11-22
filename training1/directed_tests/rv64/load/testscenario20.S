/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:13/5/2026

Owner:sumanth

Testcase name:load scenarios

Description: as we know byte is 1byte alligned half is 2 byte alligned, word is 4 byte alligned, double is 8 byte alligned we are checking for alligned address

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start:

la x20,trap_handler
csrw mtvec,x20

li x12,512 
#test1############
#consecutive load for same address and same destination register
test1:
#simple load store 
	la x6,inp_data
	lw x11,0(x6)
	//sw x12,0(x6)
	lw x11,0(x6)

#consecutive load for different address and same destination register

test2:
	lw x11,0(x6)
	//sb x12,1(x6)
	lw x11,4(x6)

#consecutive load for different address and different destination register 
test3:
	lw x13,4(x6)
	//sd x12,16(x6)
	lw x14,16(x6)

#test for exception trap misaligned load address
test4:
	lw x11,2(x6)
	//sh x12,2(x6)
	//lh x11,2(x6)
trap_handler:
	csrr x21,mcause
	csrr x22,mepc
	csrr x23,mtval
	addi x22,x22,4
	csrw mepc,x22
	mret
		
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









