#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV32M//macros
RVTEST_CODE_BEGIN//macros
////////////////////////////////////////////
  li gp, 3// global pointer
//branch g.equality unsigned
 
start:
 // the test intension is to see the jalr statements
// the jalr statements uses I format
li x5,10
li x6,-12
li x7,12
li x8,-15
la x9,s3
 
s1: 
nop
addi x15,x6,100//
s2:
add x10,x5,x6//-2
sub x11,x5,x6//10+12=22 so 16
add x12,x5,x7//16
add x13,x5,x8//1011 so sign extended b
jalr x1,x9,4// jalr rd,rs1,offset or jalr rd,offset(rs1) 
s3:
addi x17,x5,15//10+15=25 ,
s4:
addi x16,x5,5//15 e
addi x17,x5,1//b
 
TEST_PASSFAIL
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
inp_data:
  .word 0x06627935
  .word 0x5849446c
  .word 0x06627935
  .dword 0x1111111106627912
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
