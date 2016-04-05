// Copyright 2010 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package runtime

import "unsafe"

// Don't split the stack as this function may be invoked without a valid G,
// which prevents us from allocating more stack.
//go:nosplit
func sysAlloc(n uintptr, sysStat *uint64) unsafe.Pointer {
	v := mmap(nil, n, _PROT_READ|_PROT_WRITE, _MAP_ANON|_MAP_PRIVATE, -1, 0)
	if uintptr(v) < 4096 {
		return nil
	}
	mSysStatInc(sysStat, n)
	return v
}

func sysUnused(v unsafe.Pointer, n uintptr) {
	madvise(v, n, _MADV_FREE)
}

func sysUsed(v unsafe.Pointer, n uintptr) {
}

// Don't split the stack as this function may be invoked without a valid G,
// which prevents us from allocating more stack.
//go:nosplit
func sysFree(v unsafe.Pointer, n uintptr, sysStat *uint64) {
	mSysStatDec(sysStat, n)
	munmap(v, n)
}

func sysFault(v unsafe.Pointer, n uintptr) {
	mmap(v, n, _PROT_NONE, _MAP_ANON|_MAP_PRIVATE|_MAP_FIXED, -1, 0)
}

func sysReserve(v unsafe.Pointer, n uintptr, reserved *bool) unsafe.Pointer {
	p := mmap(v, n, _PROT_NONE, _MAP_ANON|_MAP_PRIVATE, -1, 0)
	if uintptr(p) == 0 {
		return nil
	}
	*reserved = true
	return p
}

const _ENOMEM = 12

func sysMap(v unsafe.Pointer, n uintptr, reserved bool, sysStat *uint64) {
	mSysStatInc(sysStat, n)

	// On 64-bit, we don't actually have v reserved, so tread carefully.
	if !reserved {
		flags := int32(_MAP_ANON | _MAP_PRIVATE)
		if GOOS == "dragonfly" {
			// TODO(jsing): For some reason DragonFly seems to return
			// memory at a different address than we requested, even when
			// there should be no reason for it to do so. This can be
			// avoided by using MAP_FIXED, but I'm not sure we should need
			// to do this - we do not on other platforms.
			flags |= _MAP_FIXED
		}
		p := mmap(v, n, _PROT_READ|_PROT_WRITE, flags, -1, 0)
		if uintptr(p) == _ENOMEM {
			throw("runtime: out of memory")
		}
		if p != v {
			print("runtime: address space conflict: map(", v, ") = ", p, "\n")
			throw("runtime: address space conflict")
		}
		return
	}

	p := mmap(v, n, _PROT_READ|_PROT_WRITE, _MAP_ANON|_MAP_PRIVATE, -1, 0)
	if uintptr(p) == _ENOMEM {
		throw("runtime: out of memory")
	}
	if p != v {
		throw("runtime: cannot map pages in arena address space")
	}
}
