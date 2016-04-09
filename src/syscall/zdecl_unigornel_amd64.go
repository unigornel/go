// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// System calls and other sys.stuff for AMD64, Unigornel.
//
// THIS FILE IS GENERATED DO NOT EDIT.
//
// mksys.py --godecl --convert-pointers --prefix sys --package syscall ../include/syscalls.h ../include/futex.h ../include/mmap.h
//

package syscall

import "unsafe"

func sysWrite(fd uint64, p unsafe.Pointer, n int32) int32
func sysNanotime()
func sysThread_id()
func sysUsleep(usec uint32)
func sysNanosleep(nsec uint64)
func sysLwp_create(context unsafe.Pointer, flags uintptr, lwpid unsafe.Pointer) int32
func sysLwp_tramp()
func sysOsyield()
func sysExit(code int32)
func sysExit1(code int32)
func sysOpen(name unsafe.Pointer, mode int32, perm int32) int32
func sysClosefd(fd int32) int32
func sysRead(fd int32, p unsafe.Pointer, n int32) int32
func sysRaise(sig int32)
func sysRaiseproc(sig int32)
func sysSetitimer(mode int32, new unsafe.Pointer, old unsafe.Pointer)
func sysGetcontext(ctxt unsafe.Pointer)
func sysSigprocmask(mode int32, new unsafe.Pointer, old unsafe.Pointer)
func sysSigaction(sig int32, new unsafe.Pointer, old unsafe.Pointer)
func sysMunmap(addr unsafe.Pointer, n uintptr)
func sysMadvise(addr unsafe.Pointer, n uintptr, flags int32)
func sysSigaltstack(new unsafe.Pointer, old unsafe.Pointer)
func sysSettls()
func sysSysctl(mib unsafe.Pointer, miblen uint32, out unsafe.Pointer, size unsafe.Pointer, dst unsafe.Pointer, ndst uintptr) int32
func sysKqueue() int32
func sysKevent(kq int32, ch unsafe.Pointer, nch int32, ev unsafe.Pointer, nev int32, ts unsafe.Pointer) int32
func sysCloseonexec(fd int32)
func sysFutex_wait(addr unsafe.Pointer, val uint32, ns int64) int32
func sysFutex_wake(addr unsafe.Pointer, cnt uint32) int32
func sysMmap(addr unsafe.Pointer, n uintptr, prot int32, flags int32, fd int32, offset uint32)
