/*===========================================================

Copyright  2026 Scaledge India Pvt Ltd - All Right Reserved.

Date:6/10/26

Owner:sumanth

Testcase name: floating point instructions

Description:
verify all f extension instruction and know the result and verify from floating calculator
===========================================================*/

// Testcase writing section

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MF
RVTEST_CODE_BEGIN

  li gp, 3

  la x6, inp_data

	#li f5,0.5// it is not possible we have to load from memory it will result in the illegal operands

	flw f4,0(x6)
	flw f5,4(x6)

	test1:
	fadd.s f22,f4,f5 //2.5+3.75=6.25
	fsub.s f22,f5,f4 //3.75-2.5=1.25
	fsub.s f22,f4,f5 //2.5-3.75=
	fmul.s f23,f4,f5
	fdiv.s f23,f5,f4
	fdiv.s f23,f4,f5
	fsqrt.s f23,f4
	fmin.s f23,f4,f5 //2.5 stores the smaller floating number
	fmax.s f23,f4,f5 //3.75 stores the larger floating number
	#fle.s f23,f4,f5
	#fle.s f23,f5,f4
	#flt.s f23,f4,f5
	#flt.s f23,f5,f4
#========================
#in flt and fle rd is integer so rd must be x31-x0

	fle.s x23,f4,f5
	fle.s x23,f5,f4
	flt.s x23,f4,f5
	flt.s x23,f5,f4
	feq.s x23,f5,f5


# for move instructions
	test2:
	#li x5,5.5 it is not possible convert to hexa
	li x5,0x54b00000
	fmv.x.w x7,f4
	fmv.w.x f6,x5
 	//fadd.s f4, f6,f0
#conversions
	test3:
	fcvt.s.w f7,x5
	fcvt.w.s x10,f4 # in x10 2 is stored according to frm the frm is 0 so it nearest even number that is  2
	csrr x12,fcsr

	test_fcvt:

    #=======================================================
    # Integer -> Float
    #=======================================================

    li       x5, 5
    fcvt.s.w f6, x5

    li       x5, 5
    fcvt.s.wu f7, x5

    li       x5, 5
    fcvt.s.l f8, x5

    li       x5, 5
    fcvt.s.lu f9, x5


    #=======================================================
    # x0 -> Float
    # Should generate +0.0 and no exception
    #=======================================================

    fcvt.s.w f10, x0


    #=======================================================
    # Float -> Signed Word
    #=======================================================

    li       x5, 0x40b00000       # 5.5
    fmv.w.x  f6, x5

    # RNE
    li       x5, 0
    csrw     frm, x5
    fcvt.w.s x7, f6               # expected 6

    # RTZ
    li       x5, 1
    csrw     frm, x5
    fcvt.w.s x7, f6               # expected 5

    # RDN
    li       x5, 2
    csrw     frm, x5
    fcvt.w.s x7, f6               # expected 5

    # RUP
    li       x5, 3
    csrw     frm, x5
    fcvt.w.s x7, f6               # expected 6

    # RMM
    li       x5, 4
    csrw     frm, x5
    fcvt.w.s x7, f6               # expected 6


    #=======================================================
    # Float -> Unsigned Word
    #=======================================================

    fcvt.wu.s x7, f6


    #=======================================================
    # Float -> Signed Long
    #=======================================================

    fcvt.l.s x7, f6


    #=======================================================
    # Float -> Unsigned Long
    #=======================================================

    fcvt.lu.s x7, f6


    #=======================================================
    # NaN -> Integer
    # NV expected
    #=======================================================

    li       x5, 0x7fc00000
    fmv.w.x  f6, x5

    fcvt.w.s x7, f6


    #=======================================================
    # +Infinity -> Integer
    # NV expected
    #=======================================================

    li       x5, 0x7f800000
    fmv.w.x  f6, x5

    fcvt.w.s x7, f6


    #=======================================================
    # Negative value -> Unsigned
    # NV expected
    #=======================================================

    li       x5, 0xbf800000       # -1.0
    fmv.w.x  f6, x5

    fcvt.wu.s x7, f6
//===========================================================

  TEST_PASSFAIL

RVTEST_CODE_END


//===========================================================
// Data
//===========================================================

  .data

RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:

  .float 2.5          // offset 0
  .float 3.75          // offset 4
  .float -1.0         // offset 8

  .float 3.4e38       // offset 12
  .float 2.0          // offset 16

  .float 1.0e-30      // offset 20
  .float 1.0e-10      // offset 24


RVTEST_DATA_END

