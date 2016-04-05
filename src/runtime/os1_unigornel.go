// Copyright 2011 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package runtime

import "unsafe"

const (
	_ESRCH     = 3
	_ETIMEDOUT = 60

	// From NetBSD's <sys/time.h>
	_CLOCK_REALTIME  = 0
	_CLOCK_VIRTUAL   = 1
	_CLOCK_PROF      = 2
	_CLOCK_MONOTONIC = 3
)

var sigset_all = sigset{[4]uint32{^uint32(0), ^uint32(0), ^uint32(0), ^uint32(0)}}

func getncpu() int32 {
	return 1
}

//go:nosplit
func semacreate(mp *m) {
}

//go:nosplit
func futexsleep(addr *uint32, val uint32, ns int64) {
	ns += 1
	if ns < 0 {
		ns = 0
	}
	futex_wait(unsafe.Pointer(addr), val, ns)
}

//go:nosplit
func futexwakeup(addr *uint32, cnt uint32) {
	futex_wake(unsafe.Pointer(addr), cnt)
}

// May run with m.p==nil, so write barriers are not allowed.
//go:nowritebarrier
func newosproc(mp *m, stk unsafe.Pointer) {
	if false {
		print("newosproc stk=", stk, " m=", mp, " g=", mp.g0, " id=", mp.id, " ostk=", &mp, "\n")
	}

	var uc ucontextt
	getcontext(unsafe.Pointer(&uc))

	uc.uc_flags = _UC_SIGMASK | _UC_CPU
	uc.uc_link = nil
	uc.uc_sigmask = sigset_all

	lwp_mcontext_init(&uc.uc_mcontext, stk, mp, mp.g0, funcPC(netbsdMstart))

	ret := lwp_create(unsafe.Pointer(&uc), 0, unsafe.Pointer(&mp.procid))
	if ret < 0 {
		print("runtime: failed to create new OS thread (have ", mcount()-1, " already; errno=", -ret, ")\n")
		throw("runtime.newosproc")
	}
}

// netbsdMStart is the function call that starts executing a newly
// created thread. On NetBSD, a new thread inherits the signal stack
// of the creating thread. That confuses minit, so we remove that
// signal stack here before calling the regular mstart. It's a bit
// baroque to remove a signal stack here only to add one in minit, but
// it's a simple change that keeps NetBSD working like other OS's.
// At this point all signals are blocked, so there is no race.
//go:nosplit
func netbsdMstart() {
	signalstack(nil)
	mstart()
}

func osinit() {
	ncpu = getncpu()
}

var urandom_dev = []byte("/dev/urandom\x00")

//go:nosplit
func getRandomData(r []byte) {
	extendRandom(r, 0)
}

func goenvs() {
	goenvs_unix()
}

// Called to initialize a new m (including the bootstrap m).
// Called on the parent thread (main thread in case of bootstrap), can allocate memory.
func mpreinit(mp *m) {
	mp.gsignal = malg(32 * 1024)
	mp.gsignal.m = mp
}

//go:nosplit
func msigsave(mp *m) {
}

//go:nosplit
func msigrestore(sigmask sigset) {
}

//go:nosplit
func sigblock() {
}

// Called to initialize a new m (including the bootstrap m).
// Called on the new thread, cannot allocate memory.
func minit() {
	_g_ := getg()
	_g_.m.procid = uint64(thread_id())
}

// Called from dropm to undo the effect of an minit.
//go:nosplit
func unminit() {
}

func memlimit() uintptr {
	return 0
}

func sigtramp()

type sigactiont struct {
	sa_sigaction uintptr
	sa_mask      sigset
	sa_flags     int32
}

//go:nosplit
//go:nowritebarrierrec
func setsig(i int32, fn uintptr, restart bool) {
}

//go:nosplit
//go:nowritebarrierrec
func setsigstack(i int32) {
	throw("setsigstack")
}

//go:nosplit
//go:nowritebarrierrec
func getsig(i int32) uintptr {
	return 0
}

//go:nosplit
func signalstack(s *stack) {
}

//go:nosplit
//go:nowritebarrierrec
func updatesigmask(m sigmask) {
}

func unblocksig(sig int32) {
}
