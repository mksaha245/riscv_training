
//**********************************************************************

//    Copyright 2026 Scaledge - All Rights Reserved.

//    Originator: S Shanmukh

//    Item: v39_m_mode

//    Date Created: 

//**********************************************************************
//
//    Description: data translation in m-mode. spec reference: The MPRV (Modify PRiVilege) bit modifies the effective privilege mode, i.e., the privilege level at which
//		   loads and stores execute. When MPRV=0, loads and stores behave as normal, using the translation and protection mechanisms of the current privilege mode. 
//		   When MPRV=1, load and store memory addresses are translated and protected, and endianness is applied, as though the current privilege mode were set to MPP. 
//		   Instruction address-translation and protection are unaffected by the setting of MPRV. MPRV is read-only 0 if U-mode is not supported.
//
//    virtual to physical address translating (instruction):
//   		   #satp = 0x8000000000080002
//   		   #L2 pte_addr= 0x80002000 pte = 0x0000000020000C01 
//   		   #L1 pte_addr= 0x80003000 pte = 0x0000000020001001 
//   		   #L0 pte_addr= 0x80004000 pte = 0x00000000000000CF 
//                 #VA = 0x0 
//                 #PA = 0x0 
//
//
//    virtual to physical address translating (Data):
//   		   #satp = 0x8000000000080002
//   		   #L2 pte_addr= 0x80002010 pte = 0x0000000020000C01 
//   		   #L1 pte_addr= 0x80003BC0 pte = 0x0000000020001001 
//   		   #L0 pte_addr= 0x80004100 pte = 0x000000002000144F    
//                 #VA = 0xAF020101 
//                 #PA = 0x80005101 
//
//********************************************************************** 

#include "test_macros.h"
#include "riscv_test.h"

//CZ_NO_COMPRESS
	 
RVTEST_RV64M
RVTEST_CODE_BEGIN

j code_begin

.align 4

exception_handler:
csrr x31,mepc
addi x31,x31,4
csrw mepc,x31
csrr x30,mcause
csrr x29,mtval
mret

code_begin:
la x11,exception_handler
csrw mtvec, x11
csrr x11, mstatus

#define my_pc0 0x0
#define virtual_addr0 0xAF020101

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


.section .data 
 //.skip (0x80002000 - 0x80000000 )
 .dword 0x000000001c000c01

 .skip (0x80002010 - 0x80002000 - 8)
 .dword 0x000000001c000c01

 .skip (0x80003000 - 0x80002010 - 8)
 .dword 0x000000001c001001 

 .skip (0x80003BC0 - 0x80003000 - 8)
 .dword 0x000000001c001001

 .skip (0x80004000 - 0x80003BC0 - 8)
 .dword 0x00000000000000cf 

 .skip (0x80004100 - 0x80004000 - 8)
 .dword 0x000000001c0014CF     





