// Copyright 2014 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package runtime

import "unsafe"

type mOS struct {
	waitsemacount uint32
}

//go:noescape
func setitimer(mode int32, new, old *itimerval)

//go:noescape
func sigaction(sig int32, new, old *sigactiont)

//go:noescape
func sigaltstack(new, old *sigaltstackt)

//go:noescape
func sigprocmask(mode int32, new, old *sigset)

//go:noescape
func sysctl(mib *uint32, miblen uint32, out *byte, size *uintptr, dst *byte, ndst uintptr) int32

func lwp_tramp()

func raise(sig int32)
func raiseproc(sig int32)

//go:noescape
func getcontext(ctxt unsafe.Pointer)

//go:noescape
func lwp_create(ctxt unsafe.Pointer, flags uintptr, lwpid unsafe.Pointer) int32

//go:noescape
func futex_wait(addr unsafe.Pointer, val uint32, ns int64) int32

//go:noescape
func futex_wake(addr unsafe.Pointer, cnt uint32) int32

func thread_id() uint64

func osyield()

func Write(fd uintptr, p unsafe.Pointer, n int32) int32
