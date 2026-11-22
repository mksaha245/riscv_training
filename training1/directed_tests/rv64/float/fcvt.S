#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64UF
RVTEST_CODE_BEGIN
 
  li gp, 8             
 
  # Load integer values into registers
  li x10, 42          	 	 # for signed int (w)
  li x11,-4294967295   	 	 # max 32-bit unsigned int (wu)
  li x12, -1000         	 # negative int (for conversion to float)
  li x13, 123456789012345 	 # 64-bit large int (l)
  li x14, -98765432109876 	 # 64-bit negative int (l)
  li x15, 0x0FFFFFFFFFFFFFFF 	 # max 64-bit unsigned int (lu)
 
  FCVTSW:  //(int32 → float)
  fcvt.s.w f1, x10     # f1 = 42.0
  fcvt.s.w f2, x12     # f2 = -1000.0
 
  FCVTSWU: //(uint32 → float)
  fcvt.s.wu f3, x11    # f3 = 4294967295.0
 
  FCVTSL: // (int64 → float)
  fcvt.s.l f4, x13     # f4 = 123456789012345.0
  fcvt.s.l f5, x14     # f5 = -98765432109876.0
 
  FCVTSLU: // (uint64 → float)
  fcvt.s.lu f6, x15    # f6 = large float ~1.8446744e+19
 
  FCVTWS: //(float → int32)
  fmv.w.x f7, x10      # move 42 into f7
  fcvt.w.s x16, f1     # x16 = 42
 
  FCVTWUS: // (float → uint32)
  fcvt.wu.s x17, f3    # x17 = 4294967295
 
  FCVTLS: //(float → int64)
  fcvt.l.s x18, f4     # x18 = 123456789012345
 
  FCVTLUS: // (float → uint64)
  fcvt.lu.s x19, f6    # x19 = 0xFFFFFFFFFFFFFFFF (rounded if exceeds)
 
RVTEST_CODE_END
 
.data
 
RVTEST_DATA_BEGIN
TEST_DATA
RVTEST_DATA_END
