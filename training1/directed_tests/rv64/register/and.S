
#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32M
RVTEST_CODE_BEGIN

  li gp, 3
start: 
//the testintention is to check the and operation
 li x6,7
li x7,3
li x8,0x12345678
li x9,0x20
li x10,0x30
li x11,0x100
li x12,2
test1:
and x28,x6,x7//111 and 011 so bitwise and so 3 is stored in destination register
test2:
and x29,x7,x6//3
test3:
and x30,x8,x7//0
test4:
andi x30,x6,-6//111 and -6 s0 010 2 is stored in destination
test5:
andi x31,x6,6//111 and 110 so 6

add x27,x9,x10
sub x27,x10,x9
or x27,x10,x9
xor x27,x10,x7
sll x27,x11,x12
slli x27,x11,3
srl x27,x11,x12
srli x27,x11,2
andi x27,x6,2
xori x27,x6,2
sra x27,x7,x6
srai x27,x7,7
ori x27,x7,7


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



