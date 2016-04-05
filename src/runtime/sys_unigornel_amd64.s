// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// System calls and other sys.stuff for AMD64, NetBSD
// /usr/src/sys/kern/syscalls.master for syscall numbers.
//

#include "go_asm.h"
#include "go_tls.h"
#include "textflag.h"

// int32 lwp_create(void *context, uintptr flags, void *lwpid)
TEXT runtime·lwp_create(SB),NOSPLIT,$0
	MOVQ	ctxt+0(FP), DI
	MOVQ	flags+8(FP), SI
	MOVQ	lwpid+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	NEGQ	AX
	MOVL	AX, ret+24(FP)
	RET

TEXT runtime·lwp_tramp(SB),NOSPLIT,$0
	
	// Set FS to point at m->tls.
	LEAQ	m_tls(R8), DI
	CALL	runtime·settls(SB)

	// Set up new stack.
	get_tls(CX)
	MOVQ	R8, g_m(R9)
	MOVQ	R9, g(CX)
	CALL	runtime·stackcheck(SB)

	// Call fn
	CALL	R12

	// It shouldn't return. If it does, exit.
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JMP	-3(PC)			// keep exiting

TEXT runtime·osyield(SB),NOSPLIT,$0
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

TEXT runtime·futex_wait(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI		// arg 1 - addr
	MOVL	val+8(FP), SI		// arg 2 - val
	MOVQ	ns+16(FP), DX		// arg 3 - ns
	LEAQ	sys_futex_wait(SB), AX
	CALL	AX
	MOVL	AX, ret+24(FP)
	RET

TEXT runtime·futex_wake(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI		// arg 1 - addr
	MOVL	hint+8(FP), SI		// arg 2 - cnt
	LEAQ	sys_futex_wake(SB), AX
	CALL	AX
	MOVL	AX, ret+16(FP)
	RET

TEXT runtime·thread_id(SB),NOSPLIT,$0
	LEAQ	sys_thread_id(SB), AX
	CALL	AX
	MOVQ	AX, ret+0(FP)
	RET

// Exit the entire program (like C exit)
TEXT runtime·exit(SB),NOSPLIT,$-8
	MOVL	code+0(FP), DI		// arg 1 - exit status
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	$0xf1, 0xf1		// crash
	RET

TEXT runtime·exit1(SB),NOSPLIT,$-8
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	$0xf1, 0xf1		// crash
	RET

TEXT runtime·open(SB),NOSPLIT,$-8
	MOVQ	name+0(FP), DI		// arg 1 pathname
	MOVL	mode+8(FP), SI		// arg 2 flags
	MOVL	perm+12(FP), DX		// arg 3 mode
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$-1, AX
	MOVL	AX, ret+16(FP)
	RET

TEXT runtime·closefd(SB),NOSPLIT,$-8
	MOVL	fd+0(FP), DI		// arg 1 fd
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$-1, AX
	MOVL	AX, ret+8(FP)
	RET

TEXT runtime·read(SB),NOSPLIT,$-8
	MOVL	fd+0(FP), DI		// arg 1 fd
	MOVQ	p+8(FP), SI		// arg 2 buf
	MOVL	n+16(FP), DX		// arg 3 count
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$-1, AX
	MOVL	AX, ret+24(FP)
	RET

TEXT runtime·write(SB),NOSPLIT,$-8
	MOVQ	fd+0(FP), DI		// arg 1 - fd
	MOVQ	p+8(FP), SI		// arg 2 - buf
	MOVL	n+16(FP), DX		// arg 3 - nbyte
	LEAQ	sys_write(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$-1, AX
	MOVL	AX, ret+24(FP)
	RET

TEXT runtime·Write(SB),NOSPLIT,$0
	MOVQ	$runtime·write(SB), AX
	JMP		AX

TEXT runtime·usleep(SB),NOSPLIT,$0
	MOVL	usec+0(FP), DI		// arg 1 - usec
	LEAQ	sys_usleep(SB), AX
	CALL	AX
	RET

TEXT runtime·raise(SB),NOSPLIT,$16
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVQ	AX, DI			// arg 1 - target
	MOVL	sig+0(FP), SI		// arg 2 - signo
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

TEXT runtime·raiseproc(SB),NOSPLIT,$16
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVQ	AX, DI			// arg 1 - pid
	MOVL	sig+0(FP), SI		// arg 2 - signo
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

TEXT runtime·setitimer(SB),NOSPLIT,$-8
	MOVL	mode+0(FP), DI		// arg 1 - which
	MOVQ	new+8(FP), SI		// arg 2 - itv
	MOVQ	old+16(FP), DX		// arg 3 - oitv
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func now() (sec int64, nsec int32)
TEXT time·now(SB), NOSPLIT, $16
	LEAQ	0(SP), DI		// arg 2 - tp
	LEAQ	sys_now(SB), AX
	CALL	AX
	MOVQ	0(SP), AX		// sec
	MOVL	8(SP), DX		// nsec

	// sec is in AX, nsec in DX
	MOVQ	AX, sec+0(FP)
	MOVL	DX, nsec+8(FP)
	RET

TEXT runtime·nanotime(SB),NOSPLIT,$0
	LEAQ	sys_nanotime(SB), AX
	CALL	AX
	MOVQ	AX, ret+0(FP)
	RET

TEXT runtime·getcontext(SB),NOSPLIT,$-8
	MOVQ	ctxt+0(FP), DI		// arg 1 - context
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$0xf1, 0xf1		// crash
	RET

TEXT runtime·sigprocmask(SB),NOSPLIT,$0
	MOVL	mode+0(FP), DI		// arg 1 - how
	MOVQ	new+8(FP), SI		// arg 2 - set
	MOVQ	old+16(FP), DX		// arg 3 - oset
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$0xf1, 0xf1		// crash
	RET

TEXT runtime·sigreturn_tramp(SB),NOSPLIT,$-8
	MOVQ	R15, DI			// Load address of ucontext
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVQ	$-1, DI			// Something failed...
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX

TEXT runtime·sigaction(SB),NOSPLIT,$-8
	MOVL	sig+0(FP), DI		// arg 1 - signum
	MOVQ	new+8(FP), SI		// arg 2 - nsa
	MOVQ	old+16(FP), DX		// arg 3 - osa
					// arg 4 - tramp
	LEAQ	runtime·sigreturn_tramp(SB), R10
	MOVQ	$2, R8			// arg 5 - vers
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$0xf1, 0xf1		// crash
	RET

TEXT runtime·sigfwd(SB),NOSPLIT,$0-32
	MOVL	sig+8(FP), DI
	MOVQ	info+16(FP), SI
	MOVQ	ctx+24(FP), DX
	MOVQ	fn+0(FP), AX
	CALL	AX
	RET

TEXT runtime·sigtramp(SB),NOSPLIT,$32
	MOVQ	DI, 0(SP)   // signum
	MOVQ	SI, 8(SP)   // info
	MOVQ	DX, 16(SP)  // ctx
	MOVQ	R15, 24(SP) // for sigreturn
	CALL	runtime·sigtrampgo(SB)
	MOVQ	24(SP), R15
	RET

TEXT runtime·mmap(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI		// arg 1 - addr
	MOVQ	n+8(FP), SI		// arg 2 - len
	MOVL	prot+16(FP), DX		// arg 3 - prot
	MOVL	flags+20(FP), CX		// arg 4 - flags
	MOVL	fd+24(FP), R8		// arg 5 - fd
	MOVL	off+28(FP), R9
	SUBQ	$16, SP
	MOVQ	R9, 8(SP)		// arg 7 - offset (passed on stack)
	MOVQ	$0, R9			// arg 6 - pad
	LEAQ	sys_mmap(SB), AX
	CALL	AX
	ADDQ	$16, SP
	MOVQ	AX, ret+32(FP)
	RET

TEXT runtime·munmap(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI		// arg 1 - addr
	MOVQ	n+8(FP), SI		// arg 2 - len
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$0xf1, 0xf1		// crash
	RET


TEXT runtime·madvise(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI		// arg 1 - addr
	MOVQ	n+8(FP), SI		// arg 2 - len
	MOVL	flags+16(FP), DX	// arg 3 - behav
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	// ignore failure - maybe pages are locked
	RET

TEXT runtime·sigaltstack(SB),NOSPLIT,$-8
	MOVQ	new+8(SP), DI		// arg 1 - nss
	MOVQ	old+16(SP), SI		// arg 2 - oss
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$0xf1, 0xf1		// crash
	RET

// set tls base to DI
TEXT runtime·settls(SB),NOSPLIT,$8
	// adjust for ELF: wants to use -8(FS) for g
	ADDQ	$8, DI			// arg 1 - ptr
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	MOVL	$0xf1, 0xf1		// crash
	RET

TEXT runtime·sysctl(SB),NOSPLIT,$0
	MOVQ	mib+0(FP), DI		// arg 1 - name
	MOVL	miblen+8(FP), SI		// arg 2 - namelen
	MOVQ	out+16(FP), DX		// arg 3 - oldp
	MOVQ	size+24(FP), R10		// arg 4 - oldlenp
	MOVQ	dst+32(FP), R8		// arg 5 - newp
	MOVQ	ndst+40(FP), R9		// arg 6 - newlen
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC 4(PC)
	NEGQ	AX
	MOVL	AX, ret+48(FP)
	RET
	MOVL	$0, AX
	MOVL	AX, ret+48(FP)
	RET

// int32 runtime·kqueue(void)
TEXT runtime·kqueue(SB),NOSPLIT,$0
	MOVQ	$0, DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	NEGQ	AX
	MOVL	AX, ret+0(FP)
	RET

// int32 runtime·kevent(int kq, Kevent *changelist, int nchanges, Kevent *eventlist, int nevents, Timespec *timeout)
TEXT runtime·kevent(SB),NOSPLIT,$0
	MOVL	fd+0(FP), DI
	MOVQ	ev1+8(FP), SI
	MOVL	nev1+16(FP), DX
	MOVQ	ev2+24(FP), R10
	MOVL	nev2+32(FP), R8
	MOVQ	ts+40(FP), R9
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	JCC	2(PC)
	NEGQ	AX
	MOVL	AX, ret+48(FP)
	RET

// void runtime·closeonexec(int32 fd)
TEXT runtime·closeonexec(SB),NOSPLIT,$0
	MOVL	fd+0(FP), DI	// fd
	MOVQ	$2, SI		// F_SETFD
	MOVQ	$1, DX		// FD_CLOEXEC
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET
