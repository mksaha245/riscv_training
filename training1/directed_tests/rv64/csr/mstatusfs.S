#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
li gp, 3                 # global pointer
 
 
start:
csrr x5, mstatus         # Read mstatus
 
# -------------------------------
# Install Trap Handler
# -------------------------------
install_trap_handler:
  la   x25, my_trap_handler
  csrw mtvec, x25
 
# ---------------------------------------------------------
# FLOATING OPERATION WITH DEFAULT FS (FS=00 → Off)
# Expect: Trap due to floating-point instruction when FS=0
# ---------------------------------------------------------
float_operation1:
  li x6, 0x42C50000        
  li x7, 0x41200000       
 
  fmv.w.x f4, x6           # Should trap if FS=Off
  fmv.w.x f5, x7
  fadd.s f6, f4, f5        
 
  csrr x11, mstatus        
  csrr x12, mcause         
 
# ---------------------------------------------------------
# Enable FS Bit (FS = 11 → Dirty)
# mstatus.FS bits = [14:13]
# ---------------------------------------------------------
active_fs_bit:
  csrr x10, mstatus
  li   x8, (3 << 13)       # FS = 3 (Dirty)
  or   x10, x10, x8
  csrw mstatus, x10
 
# ---------------------------------------------------------
# FLOATING OPERATION AFTER FS ENABLED (should NOT trap)
# ---------------------------------------------------------
float_operation2:
  li x6, 0x42C50000        # 98.5
  li x7, 0x41200000        # 10.0
 
  fmv.w.x f4, x6
  fmv.w.x f5, x7
  fadd.s f6, f4, f5
 
  csrr x11, mstatus
  csrr x12, mcause
 
  j done
 
# ---------------------------------------------------------
# Trap Handler
# ---------------------------------------------------------
my_trap_handler:
  csrr x20, mepc
  li   x21, 4              # Skip the faulting instruction
  add  x20, x20, x21
  csrw mepc, x20
  mret
 
done:
  nop
  nop
 
////////////////////////////////////////////////////////////
  TEST_PASSFAIL
 
RVTEST_CODE_END
 
.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END
