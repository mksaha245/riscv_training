 

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3
start: 
//the testintention isto loads the register into memory using different instruction type and check its alligned or not
 la x6,inp_data

lw x10,40(x6)//in address 0x06627912 a byte will load last 2 value is 12 
lw x11,32(x6)
lw x12,24(x6)
lw x13,16(x6)
ld x14,8(x6)
lb x15,2(x6)
lbu x15,1(x6)
lh x16,4(x6)
lhu x17,4(x6)

lwu x18,0(x6)

lw x19,0(x6)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data

RVTEST_DATA_BEGIN
  TEST_DATA


inp_data:
  .word 0xF6627912//0
  .word 0x06627912//4
  .dword 0x584944fc12345678//8
  .word 0x584944fc//12
  .word 0x558f5366//16
  .word 0x558f5366//20
  .word 0x29df2fb1//24
  .word 0x29df2fb1//28
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




