// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#include "textflag.h"

TEXT _rt0_amd64_unigornel(SB),NOSPLIT,$-8
	LEAQ	8(SP), SI // argv
	MOVQ	0(SP), DI // argc
	MOVQ	$main(SB), AX
	JMP	AX

TEXT main(SB),NOSPLIT,$-8
	MOVQ	$runtime·rt0_go(SB), AX
	JMP	AX

TEXT _rt0_amd64_unigornel_lib(SB),NOSPLIT,$0
	MOVQ	$_rt0_amd64_unigornel_lib_go(SB), AX
	CALL	AX
	RET

nocgo:
	RET

TEXT _rt0_amd64_unigornel_lib_go(SB),NOSPLIT,$0
	MOVQ	sys_argc(SB), DI
	LEAQ	sys_argv(SB), SI
	MOVQ	$runtime·rt0_go(SB), AX
	CALL	AX
	RET
