/*===========================================================
 
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
 
Date:15/12/2025
 
Owner:Sumanth
 
Testcase name:mcountinhibit_set
 
Description:This test verifies that when mcountinhibit is set the counter should not increment, verify by mcycle
 
===========================================================*/
 
//Testcase writing section
  
#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li gp,3

start:
	csrr x5,mcountinhibit
    li x6, 0xffffffff                  
    csrw mcountinhibit, x6   
    csrr x11, mcycle    		#43         
    csrr x12, minstret  		#44
           
test: 
  
    li x4, 100                  
    li x5, 200                  
    add x9, x4, x5              
    li x7, 300                  
    add x10, x9, x7              

    csrw mcountinhibit, x0      
   
    csrr x21, mcycle            #4d 
    csrr x22, minstret          #4e
   
    sub x23, x21, x11             
    sub x24, x22, x12   
    
exit :
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
