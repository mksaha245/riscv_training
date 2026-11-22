/*=========================================================== 

Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.

Date:12/6/25

Owner:Sumanth

Testcase name: TC_JMP_TEST

Description: Verify control flow integrity through 15 jumps using a mix of jal, jalr, j, and jr. Each label should jump to another, and the 15th jump should land at a final end label at end.

===========================================================*/
 
 
#include "test_macros.h"

#include "riscv_test.h"

RVTEST_RV32U

RVTEST_CODE_BEGIN

  li gp, 3

start: 

la x6,level_1

la x7,level_2

la x8,level_3

la x9,level_4

la x10,level_5

la x11,level_6

la x12,level_7

la x13,level_8

la x14,level_9

la x15,level_10

  li x16,10

  li x17,15
 
level_1:               # First execution point

  and x18,x16,x17      # x18 = x16 & x17 = 10 & 15 = 10 (0b1010)

  jal x19, level_11    # Jump to level_11, x19 = return addr(16E)
 
level_2:               #12

  nop				   #no operation(16E)

  jr x13               # Jump to x13 = level_8
 
level_3:			   #7

  and x18,x16,x17      # x18 = 10 & 15 = 10

  jal x23, level_12    # Jump to level_12
 
level_4:			   #4

  andi x18,x16,5       # x18 = x16 & 5 = 10 & 5 = 0 (will not execute)

  sub x18,x16,x17      # x18 = 10 - 15 = -5 (0xFFFFFFFB)

  andi x18,x16,-5      # x18 = 10 & 0xFFFFFFFB = 10 & ~4 = 10 & 0xFFFFFFFB = 8

  jalr x21,x12,8       # x12 = level_7 → jump to level_7 + 8 (likely next instruction)
 
level_5:               #10

  andi x18,x16,5       # x18 = 10 & 5 = 0

  sub x18,x16,x17      # x18 = 10 - 15 = -5

  addi x18,x16,-5      # x18 = 10 - 5 = 5
 
level_6:               #11

  xor x18,x16,x17      # x18 = 10 ^ 15 = 5 (0b1010 ^ 1111 = 0101)

  jalr x21,x7,0        # x7 = level_2 → jump to level_2
 
level_7:			   #5

  andi x18,x16,5       # x18 = 10 & 5 = 0(will not execute)

  sub x18,x16,x17      # x18 = -5(will not execute)

  andi x18,x16,-5      # x18 = 10 & ~5 = 10

  jalr x22,x14,8       # x14 = level_9 → jump to level_9 + 8
 
level_8:               #13

  nop                  #no operation

  j level_10           # Jump to level_10
 
level_9:			   #6

  nop                  #no operation(c.nop)(will not execute)

  nop                  #no operation(c.nop)(will not execute)

  ori x18,x16,50       # x18 = 10 | 50 = 58(will not execute)

  jr x8                # x8 = level_3 → jump to level_3
 
level_10:              #14

  nop                  #no operation

  j end                # Jump to end
 
level_11:			   #2

  or x18,x16,x17       # x18 = 10 | 15 = 15 (0b1111)

  j level_14           # Jump to level_14
 
level_12:			   #8

  addi x18,x18,6       # x18 = x18 + 6 → x18 = 10 + 6 = 16 (if x18 was 10)
 
level_13:              #9

  addi x18,x17,12      # x18 = 15 + 12 = 27

  jalr x24,x10,4       # x10 = level_5 → jump to level_5 + 4
 
level_14:			   #3

  or x18,x16,x17       # x18 = 10 | 15 = 15

  xor x18,x16,x17      # x18 = 10 ^ 15 = 5

  jalr x20, 4(x9)      # x9 = level_4 → jump to level_4 + 4
 
end:

  nop                  # Final instruction
 
TEST_PASSFAIL
 
RVTEST_CODE_END
 
.data
 
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
 
 
