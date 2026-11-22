# See LICENSE.vyoma for more details
#include "test_macros.h"
#include "riscv_test.h"
 
 
/*
sv39  va=ox401bddc
instr:
Level 2 PTE Address is 8000_2010 & PTE Value is 2000_0C01
Level 1 PTE Address is 8000_3000 & PTE Value is 2000_1001 
Level 0 PTE Address is 8000_4000 & PTE value is 2000_00CF
The PA is 0x8000_0000
 
Data: satp=0x8000000000080002
Level 2 PTE Address is 8000_2000 & PTE Value is 2000_0C01
Level 1 PTE Address is 8000_3100 & PTE Value is 2000_1001
Level 0 PTE Address is 8000_40D8 & PTE value is 2000_14CF
The PA is 0x8000_5DDC 
*/
 
RVTEST_RV64M
RVTEST_CODE_BEGIN

  j start
  
trap_handler:
 
  csrr x9,mtval
  csrr x10,mcause
  csrr x6,mepc
  addi x6,x6,4
  csrw mepc,x6
  mret
  
start:

  li gp, 3
  la x6, trap_handler
  csrw mtvec, x6
 
#define virtual_address 0x401bddc
 
test:

  li x18,0xf
  csrw pmpcfg0,x18
  li x6,0xffffffff
  csrw pmpaddr0,x6
  li x4, 0x800
  csrs mstatus, x4
  la x6, s_mode
  csrw mepc, x6
  mret
 
s_mode:

  li x7, 0x8000000000080002
  csrw satp, x7
  nop
  nop
  nop 
  li x10, virtual_address
  li x7, 0xccccfdba
  lw x30,(x10)
  sw x7, (x10)
  nop
  nop
exit:
  nop

  	//li x25,0x1800
	//csrw mstatus,x25
	li x22,0x80000004
	csrw stvec,x22

  TEST_PASSFAIL
RVTEST_CODE_END

  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
.dword 0x0000000020000c01
.skip (0x80002010 - 0x80002000 - 8)
.dword 0x0000000020000c01
.skip (0x80003000 - 0x80002010 - 8)
.dword 0x0000000020001001
.skip (0x80003100 - 0x80003000 - 8)
.dword 0x0000000020001001
.skip (0x80004000 - 0x80003100 - 8)
.dword 0x00000000200000cf
.skip (0x800040d8 - 0x80004000 - 8)
.dword 0x00000000200014cf     //111 - no faults
//.dword 0x00000000200014c3     //001 - store page fault
//.dword 0x00000000200014c5     //010 - store and load page fault
//.dword 0x00000000200014c7     //011 - no faults
//.dword 0x00000000200014c9     //100 - store and load page fault
//.dword 0x00000000200014cb     //101 - store page fault
//.dword 0x00000000200014cd     //110 - store and load page fault

 
RVTEST_DATA_END

