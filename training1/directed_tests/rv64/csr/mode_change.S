
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
j start

//.align 4

exception_handler:
csrr x31,mepc
addi x31,x31,4
csrw mepc,x31
csrr x30,mcause
csrr x29,mtval
mret

start:
la x11,exception_handler
csrw mtvec, x11
csrr x11, mstatus

#define my_pc0 0x0
#define virtual_addr0 0xAF020100

	li x11, 0xF          
	csrw pmpcfg0, x11
	li x12, 0xEFFFFFFFFF
	csrw pmpaddr0, x12


la t6, label_1
csrw mepc, t6
                  li x16, 0x800060800
                  csrw 0x300, x16 # MSTATUS
                  li x16, 0x0
                  csrw 0x304, x16 # MIE
                  li x16, 0x200080000
                  csrw 0x100, x16 # SSTATUS
                  li x16, 0x0
                  csrw 0x104, x16 # SIE
		  csrr t1, mstatus

mode_swf:
	 li a2, 0x8000000000000000
	 li t1, 0x80002000
	 srl t1,t1,12
	 or t1,t1,a2
	 csrw satp, t1
	 //mret

label_1:
    li a4, virtual_addr0  
    li a1, 0x11223344
    sw a1, (a4) 
    li a1, 0
    lw a1, (a4)
    nop
  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  .dword 0x0000000020000c01

 .skip (0x80002010 - 0x80002000 - 8)
 .dword 0x0000000020000c01

 .skip (0x80003000 - 0x80002010 - 8)
 .dword 0x0000000020001001 

 .skip (0x80003BC0 - 0x80003000 - 8)
 .dword 0x0000000020001001

 .skip (0x80004000 - 0x80003BC0 - 8)
 .dword 0x00000000000000cf 

 .skip (0x80004100 - 0x80004000 - 8)
 .dword 0x00000000200014CF       

RVTEST_DATA_END












