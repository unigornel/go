// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// System calls and other sys.stuff for AMD64, Unigornel.
//
// THIS FILE IS GENERATED DO NOT EDIT.
//
// mksys.py ../include/syscalls.h ../include/mmap.h ../include/futex.h
//

#include "go_asm.h"
#include "textflag.h"


// func write(fd uint64, p unsafe.Pointer, n int32) int32
TEXT runtime·write(SB),NOSPLIT,$0
	MOVQ	fd+0(FP), DI
	MOVQ	p+8(FP), SI
	MOVL	n+16(FP), DX
	LEAQ	sys_write(SB), AX
	CALL	AX
	MOVL	AX, ret+24(FP)
	RET

// func read(fd int32, p unsafe.Pointer, n int32) int32
TEXT runtime·read(SB),NOSPLIT,$0
	CALL	runtime·entersyscall(SB)
	MOVL	fd+0(FP), DI
	MOVQ	p+8(FP), SI
	MOVL	n+16(FP), DX
	LEAQ	sys_read(SB), AX
	CALL	AX
	MOVL	AX, ret+24(FP)
	CALL	runtime·exitsyscall(SB)
	RET

// func nanotime() uint64
TEXT runtime·nanotime(SB),NOSPLIT,$0
	LEAQ	sys_nanotime(SB), AX
	CALL	AX
	MOVQ	AX, ret+0(FP)
	RET

TEXT time·now(SB),NOSPLIT,$16
	LEAQ	0(SP), DI
	LEAQ	sys_now(SB), AX
	CALL	AX
	MOVQ	0(SP), AX
	MOVL	8(SP), DX
	MOVQ	AX, sec+0(FP)
	MOVL	DX, nsec+8(FP)
	RET

// func thread_id() uint64
TEXT runtime·thread_id(SB),NOSPLIT,$0
	LEAQ	sys_thread_id(SB), AX
	CALL	AX
	MOVQ	AX, ret+0(FP)
	RET

// func usleep(usec uint32)
TEXT runtime·usleep(SB),NOSPLIT,$0
	MOVL	usec+0(FP), DI
	LEAQ	sys_usleep(SB), AX
	CALL	AX
	RET

// func nanosleep(nsec uint64)
TEXT runtime·nanosleep(SB),NOSPLIT,$0
	MOVQ	nsec+0(FP), DI
	LEAQ	sys_nanosleep(SB), AX
	CALL	AX
	RET

// func lwp_create(context unsafe.Pointer, flags uintptr, lwpid unsafe.Pointer) int32
TEXT runtime·lwp_create(SB),NOSPLIT,$0
	MOVQ	context+0(FP), DI
	MOVQ	flags+8(FP), SI
	MOVQ	lwpid+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+24(FP)
	RET

// func lwp_tramp()
TEXT runtime·lwp_tramp(SB),NOSPLIT,$0
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func osyield()
TEXT runtime·osyield(SB),NOSPLIT,$0
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func exit(code int32)
TEXT runtime·exit(SB),NOSPLIT,$0
	MOVL	code+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func exit1(code int32)
TEXT runtime·exit1(SB),NOSPLIT,$0
	MOVL	code+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func open(name *byte, mode int32, perm int32) int32
TEXT runtime·open(SB),NOSPLIT,$0
	MOVQ	name+0(FP), DI
	MOVL	mode+8(FP), SI
	MOVL	perm+12(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+16(FP)
	RET

// func closefd(fd int32) int32
TEXT runtime·closefd(SB),NOSPLIT,$0
	MOVL	fd+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+8(FP)
	RET

// func raise(sig int32)
TEXT runtime·raise(SB),NOSPLIT,$0
	MOVL	sig+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func raiseproc(sig int32)
TEXT runtime·raiseproc(SB),NOSPLIT,$0
	MOVL	sig+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func setitimer(mode int32, new *itimerval, old *itimerval)
TEXT runtime·setitimer(SB),NOSPLIT,$0
	MOVL	mode+0(FP), DI
	MOVQ	new+8(FP), SI
	MOVQ	old+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func getcontext(ctxt unsafe.Pointer)
TEXT runtime·getcontext(SB),NOSPLIT,$0
	MOVQ	ctxt+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sigprocmask(mode int32, new *sigset, old *sigset)
TEXT runtime·sigprocmask(SB),NOSPLIT,$0
	MOVL	mode+0(FP), DI
	MOVQ	new+8(FP), SI
	MOVQ	old+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sigaction(sig int32, new *sigset, old *sigset)
TEXT runtime·sigaction(SB),NOSPLIT,$0
	MOVL	sig+0(FP), DI
	MOVQ	new+8(FP), SI
	MOVQ	old+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func munmap(addr unsafe.Pointer, n uintptr)
TEXT runtime·munmap(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI
	MOVQ	n+8(FP), SI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func madvise(addr unsafe.Pointer, n uintptr, flags int32)
TEXT runtime·madvise(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI
	MOVQ	n+8(FP), SI
	MOVL	flags+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sigaltstack(new *sigaltstackt, old *sigaltstackt)
TEXT runtime·sigaltstack(SB),NOSPLIT,$0
	MOVQ	new+0(FP), DI
	MOVQ	old+8(FP), SI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func settls()
TEXT runtime·settls(SB),NOSPLIT,$0
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysctl(mib *uint32, miblen uint32, out *byte, size *uintptr, dst *byte, ndst uintptr) int32
TEXT runtime·sysctl(SB),NOSPLIT,$0
	MOVQ	mib+0(FP), DI
	MOVL	miblen+8(FP), SI
	MOVQ	out+16(FP), DX
	MOVQ	size+24(FP), CX
	MOVQ	dst+32(FP), R8
	MOVQ	ndst+40(FP), R9
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+48(FP)
	RET

// func kqueue() int32
TEXT runtime·kqueue(SB),NOSPLIT,$0
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+0(FP)
	RET

// func kevent(kq int32, ch *kqueuet, nch int32, ev *kqueuet, nev int32, ts *timespec) int32
TEXT runtime·kevent(SB),NOSPLIT,$0
	MOVL	kq+0(FP), DI
	MOVQ	ch+8(FP), SI
	MOVL	nch+16(FP), DX
	MOVQ	ev+24(FP), CX
	MOVL	nev+32(FP), R8
	MOVQ	ts+40(FP), R9
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+48(FP)
	RET

// func closeonexec(fd int32)
TEXT runtime·closeonexec(SB),NOSPLIT,$0
	MOVL	fd+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func mmap(addr unsafe.Pointer, n uintptr, prot int32, flags int32, fd int32, offset uint32) unsafe.Pointer
TEXT runtime·mmap(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI
	MOVQ	n+8(FP), SI
	MOVL	prot+16(FP), DX
	MOVL	flags+20(FP), CX
	MOVL	fd+24(FP), R8
	MOVL	offset+28(FP), R9
	LEAQ	sys_mmap(SB), AX
	CALL	AX
	MOVQ	AX, ret+32(FP)
	RET

// func futex_wait(addr unsafe.Pointer, val uint32, ns int64) int32
TEXT runtime·futex_wait(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI
	MOVL	val+8(FP), SI
	MOVQ	ns+16(FP), DX
	LEAQ	sys_futex_wait(SB), AX
	CALL	AX
	MOVL	AX, ret+24(FP)
	RET

// func futex_wake(addr unsafe.Pointer, cnt uint32) int32
TEXT runtime·futex_wake(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI
	MOVL	cnt+8(FP), SI
	LEAQ	sys_futex_wake(SB), AX
	CALL	AX
	MOVL	AX, ret+16(FP)
	RET
