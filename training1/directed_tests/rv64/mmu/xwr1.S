/*===========================================================
Copyright  2026 Scaledge India Pvt Ltd - All Right Reserved.
Testcase name: XWR + Sv39 + PMP
Owner: Sumanth
===========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp, 3

//--------------------------------------------------
// Trap handler setup
//--------------------------------------------------
start:
    la      x15, trap_handler
    csrw    mtvec, x15

//--------------------------------------------------
// PMP setup (full access region)
//--------------------------------------------------
    li      x18, 0x0F                  // RWX + TOR
    csrw    pmpcfg0, x18

    li      x19, 0x80004000
    srli    x20, x19, 2
    csrw    pmpaddr0, x20

//--------------------------------------------------
// Build Sv39 page table (identity map)
//--------------------------------------------------
    la      x1, root_page_table       // root PT base
    srli    x2, x1, 12                // PPN for SATP

    li      x3, 8                     // MODE = Sv39
    slli    x3, x3, 60

    or      x2, x2, x3
    csrw    satp, x2

    sfence.vma

//--------------------------------------------------
// Enter S-mode
//--------------------------------------------------
    li      x5, 0x800
    csrr    x8, mstatus
    or      x7, x5, x8
    csrw    mstatus, x7

    la      x10, s_mode
    csrw    mepc, x10
    mret

//--------------------------------------------------
// Supervisor mode code (XWR test)
//--------------------------------------------------
s_mode:

    la      x14, inp_data

    // LOAD test (R)
    lw      x12, 0(x14)

    // STORE test (W)
    sw      x12, 4(x14)

    // EXECUTION test (X) - simple loop jump
    la      x6, exec_label
    jalr    x6

exec_label:
    nop

    jal     x0, exit

//--------------------------------------------------
// Trap handler
//--------------------------------------------------
trap_handler:

    csrr    x16, mcause
    csrr    x17, mepc

    addi    x17, x17, 4
    csrw    mepc, x17

    mret

exit:
    nop

TEST_PASSFAIL

RVTEST_CODE_END


//--------------------------------------------------
// DATA SECTION
//--------------------------------------------------
.section .data
.align 12

//--------------------------------------------------
// Root Page Table (Sv39)
//--------------------------------------------------
root_page_table:

    // VPN[2] = 0 → index 0 (for 0x80000000 mapping)
    .dword 0

    .dword 0

    // Leaf PTE: map 0x80000000 → 0x80000000
    // PTE = (PPN << 10) | 0xCF (RWX + valid)
    .dword ((0x80000000 >> 12) << 10) | 0xCF

    .zero 4096 - 24


RVTEST_DATA_BEGIN
TEST_DATA

.align 3

inp_data:
    .word 0x06627912
    .word 0x584944fc
    .word 0x558f5366
    .word 0x29df2fb1
    .word 0x40053e92
    .word 0x17010699

RVTEST_DATA_END
