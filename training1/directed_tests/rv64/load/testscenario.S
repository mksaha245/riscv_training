/* ===========================================================

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:

Owner:sumanth

Testcase name:

Description:

===========================================================*/

//Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start: 
#test1############
test1:
#simple load store 
	la x6,inp_data
	lw x11,0(x6)
	sw x12,0(x6)

#test2##############
test2:
#check with the misalligned offset
	la x6,inp_data
//	lw x11,1(x6)//exception load_trap_address_misalligned
//	sw x12,2(x6)//exception store_trap_address_misalligned

#test3##############
test3:
#check with negative offset
	la x6,inp_data
	li x12,12345678
	lw x11,-40(x6)
	sw x12,-40(x6)

#test4################
test4:
#load in different address store in different address
	la x6,inp_data
	lw x11,4(x6)
	sw x12,8(x6)

#test5###############
test5:
#same address
	la x6,inp_data
	lw x11,4(x6)
	sw x12,4(x6)
	lw x11,4(x6)
	sw x12,4(x6)
	lw x11,4(x6)
	sw x12,4(x6)
	lw x11,4(x6)
	sw x12,4(x6)

#test6##################
test6:
#Load double and then store byte to same address, verify result
	li x13,0x1234
	ld x11,16(x6)
	sh x13,16(x6)
	ld x11,16(x6)

#test7###################
test7:
#memory overwrite
	la x6,inp_data
	li x14,0x123456789abcdef0
	sd x14,8(x6)
	ld x11,8(x6)
	li x14,0x12345678
	sw x14,8(x6)
	lw x11,8(x6)
	li x16,0x1234
	sh x16,8(x6)	
	lh x11,8(x6)
	li x14,0x12
	sb x14,8(x6)
	lb x11,8(x6)

#test8#################
test8:
# 
	la x0,inp_data
//	lw x11,0(x0)//exception trap_load_access_fault
//	sw x14,0(x0)//exception trap_store_access_fault

#test9################
test9:
#
	la x6,inp_data
	lw x0,0(x6)
	sw x0,0(x6)//store zero

#test10################
#load a negative data
test10:
	lw x11,28(x6)//see the sign extension
	lwu x11,28(x6)//msb is 0


		
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
  .word 0x29df2fb1
  .word 0x40053e92
  .word 0x40053e92
  .word 0x17010699
  .word 0x17010699
  .word 0x594b9169
  .word 0x594b9169
  .word 0x64cd11c7
  .word 0x64cd11c7
  .word 0x6133a31e
  .word 0x6133a31e
  .word 0x2a9e3a3d
  .word 0x2a9e3a3d
  .word 0x59f86117
  .word 0x59f86117
  .word 0x39214611
  .word 0x39214611
  .word 0x6ec633f5
  .word 0x6ec633f5
  .word 0x4910a7b3
  .word 0x4910a7b3
  .word 0x3392ec72
  .word 0x3392ec72
  .word 0x6c3af175
  .word 0x6c3af175
  .word 0x74555adb
  .word 0x74555adb
  .word 0x360a50f7
  .word 0x360a50f7
  .word 0x39febbec
  .word 0x39febbec
  .word 0x28cb8c74
  .word 0x28cb8c74

RVTEST_DATA_END







