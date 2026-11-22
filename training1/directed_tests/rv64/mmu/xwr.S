/*===========================================================
 
Copyright  2026 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:7/5/2026
 
Owner:Sumanth
 
Testcase name:xwr
 
Description:
 
===========================================================*/
#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start: 
	la x15,trap_handler
	csrw mtvec,x15
	li x18,0xF
	csrw pmpcfg0,x18
	li x19,0x80004000
	srli x20,x19,2
	csrw pmpaddr0,x20
	li x5,0x800
	csrr x8,mstatus
	li x11,0x8000000000080002
	csrw satp,x11
	or x7,x5,x8
	csrw mstatus,x7

	la x10,s_mode
	csrw mepc,x10
	mret

s_mode:
	//li x11,0x8000000000080002
	//csrw satp,x11
	la x14,inp_data
	lw x12,0(x14)
	sw x13,0(x14)

	jal x0,exit

trap_handler:
	csrr x16,mcause
	csrr x17,mepc
	addi x17,x17,4
	csrw mepc,x17
	mret
exit:
	nop



  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  .word 0x06627912
  .word 0x06627912
  .word 0x584944fc
  .word 0x584944fc
  .word 0x558f5366
  .word 0x558f5366
  .word 0x29df2fb1
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



