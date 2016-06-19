// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// System calls and other sys.stuff for AMD64, Unigornel.
//
// THIS FILE IS GENERATED DO NOT EDIT.
//
// mksys.py --prefix sys --package syscall ../include/syscalls.h ../include/mmap.h ../include/futex.h
//

#include "go_asm.h"
#include "textflag.h"


// func sysWrite(fd uint64, p unsafe.Pointer, n int32) int32
TEXT syscall·sysWrite(SB),NOSPLIT,$0
	CALL	runtime·entersyscall(SB)
	MOVQ	fd+0(FP), DI
	MOVQ	p+8(FP), SI
	MOVL	n+16(FP), DX
	LEAQ	sys_write(SB), AX
	CALL	AX
	MOVL	AX, ret+24(FP)
	CALL	runtime·exitsyscall(SB)
	RET

// func sysRead(fd int32, p unsafe.Pointer, n int32) int32
TEXT syscall·sysRead(SB),NOSPLIT,$0
	CALL	runtime·entersyscall(SB)
	MOVL	fd+0(FP), DI
	MOVQ	p+8(FP), SI
	MOVL	n+16(FP), DX
	LEAQ	sys_read(SB), AX
	CALL	AX
	MOVL	AX, ret+24(FP)
	CALL	runtime·exitsyscall(SB)
	RET

// func sysNanotime() uint64
TEXT syscall·sysNanotime(SB),NOSPLIT,$0
	LEAQ	sys_nanotime(SB), AX
	CALL	AX
	MOVQ	AX, ret+0(FP)
	RET

TEXT syscall·sysNow(SB),NOSPLIT,$16
	LEAQ	0(SP), DI
	LEAQ	sys_now(SB), AX
	CALL	AX
	MOVQ	0(SP), AX
	MOVL	8(SP), DX
	MOVQ	AX, sec+0(FP)
	MOVL	DX, nsec+8(FP)
	RET

// func sysThread_id() uint64
TEXT syscall·sysThread_id(SB),NOSPLIT,$0
	LEAQ	sys_thread_id(SB), AX
	CALL	AX
	MOVQ	AX, ret+0(FP)
	RET

// func sysUsleep(usec uint32)
TEXT syscall·sysUsleep(SB),NOSPLIT,$0
	MOVL	usec+0(FP), DI
	LEAQ	sys_usleep(SB), AX
	CALL	AX
	RET

// func sysNanosleep(nsec uint64)
TEXT syscall·sysNanosleep(SB),NOSPLIT,$0
	MOVQ	nsec+0(FP), DI
	LEAQ	sys_nanosleep(SB), AX
	CALL	AX
	RET

// func sysLwp_create(context unsafe.Pointer, flags uintptr, lwpid unsafe.Pointer) int32
TEXT syscall·sysLwp_create(SB),NOSPLIT,$0
	MOVQ	context+0(FP), DI
	MOVQ	flags+8(FP), SI
	MOVQ	lwpid+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+24(FP)
	RET

// func sysLwp_tramp()
TEXT syscall·sysLwp_tramp(SB),NOSPLIT,$0
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysOsyield()
TEXT syscall·sysOsyield(SB),NOSPLIT,$0
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysExit(code int32)
TEXT syscall·sysExit(SB),NOSPLIT,$0
	MOVL	code+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysExit1(code int32)
TEXT syscall·sysExit1(SB),NOSPLIT,$0
	MOVL	code+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysOpen(name *byte, mode int32, perm int32) int32
TEXT syscall·sysOpen(SB),NOSPLIT,$0
	MOVQ	name+0(FP), DI
	MOVL	mode+8(FP), SI
	MOVL	perm+12(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+16(FP)
	RET

// func sysClosefd(fd int32) int32
TEXT syscall·sysClosefd(SB),NOSPLIT,$0
	MOVL	fd+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+8(FP)
	RET

// func sysRaise(sig int32)
TEXT syscall·sysRaise(SB),NOSPLIT,$0
	MOVL	sig+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysRaiseproc(sig int32)
TEXT syscall·sysRaiseproc(SB),NOSPLIT,$0
	MOVL	sig+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysSetitimer(mode int32, new *itimerval, old *itimerval)
TEXT syscall·sysSetitimer(SB),NOSPLIT,$0
	MOVL	mode+0(FP), DI
	MOVQ	new+8(FP), SI
	MOVQ	old+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysGetcontext(ctxt unsafe.Pointer)
TEXT syscall·sysGetcontext(SB),NOSPLIT,$0
	MOVQ	ctxt+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysSigprocmask(mode int32, new *sigset, old *sigset)
TEXT syscall·sysSigprocmask(SB),NOSPLIT,$0
	MOVL	mode+0(FP), DI
	MOVQ	new+8(FP), SI
	MOVQ	old+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysSigaction(sig int32, new *sigset, old *sigset)
TEXT syscall·sysSigaction(SB),NOSPLIT,$0
	MOVL	sig+0(FP), DI
	MOVQ	new+8(FP), SI
	MOVQ	old+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysMunmap(addr unsafe.Pointer, n uintptr)
TEXT syscall·sysMunmap(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI
	MOVQ	n+8(FP), SI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysMadvise(addr unsafe.Pointer, n uintptr, flags int32)
TEXT syscall·sysMadvise(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI
	MOVQ	n+8(FP), SI
	MOVL	flags+16(FP), DX
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysSigaltstack(new *sigaltstackt, old *sigaltstackt)
TEXT syscall·sysSigaltstack(SB),NOSPLIT,$0
	MOVQ	new+0(FP), DI
	MOVQ	old+8(FP), SI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysSettls()
TEXT syscall·sysSettls(SB),NOSPLIT,$0
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysSysctl(mib *uint32, miblen uint32, out *byte, size *uintptr, dst *byte, ndst uintptr) int32
TEXT syscall·sysSysctl(SB),NOSPLIT,$0
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

// func sysKqueue() int32
TEXT syscall·sysKqueue(SB),NOSPLIT,$0
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	MOVL	AX, ret+0(FP)
	RET

// func sysKevent(kq int32, ch *kqueuet, nch int32, ev *kqueuet, nev int32, ts *timespec) int32
TEXT syscall·sysKevent(SB),NOSPLIT,$0
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

// func sysCloseonexec(fd int32)
TEXT syscall·sysCloseonexec(SB),NOSPLIT,$0
	MOVL	fd+0(FP), DI
	LEAQ	_unimplemented_syscall(SB), AX
	CALL	AX
	RET

// func sysMmap(addr unsafe.Pointer, n uintptr, prot int32, flags int32, fd int32, offset uint32) unsafe.Pointer
TEXT syscall·sysMmap(SB),NOSPLIT,$0
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

// func sysFutex_wait(addr unsafe.Pointer, val uint32, ns int64) int32
TEXT syscall·sysFutex_wait(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI
	MOVL	val+8(FP), SI
	MOVQ	ns+16(FP), DX
	LEAQ	sys_futex_wait(SB), AX
	CALL	AX
	MOVL	AX, ret+24(FP)
	RET

// func sysFutex_wake(addr unsafe.Pointer, cnt uint32) int32
TEXT syscall·sysFutex_wake(SB),NOSPLIT,$0
	MOVQ	addr+0(FP), DI
	MOVL	cnt+8(FP), SI
	LEAQ	sys_futex_wake(SB), AX
	CALL	AX
	MOVL	AX, ret+16(FP)
	RET
