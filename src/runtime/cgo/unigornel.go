// Copyright 2016 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build unigornel

package cgo

import _ "unsafe" // for go:linkname

// Supply environ and __progname, because we don't
// link against the standard NetBSD crt0.o and the
// libc dynamic library needs them.

//go:linkname _environ environ
//go:linkname _progname __progname

var _environ uintptr
var _progname uintptr

//go:cgo_import_static _unimplemented_syscall

//go:cgo_import_static sys_argc
//go:cgo_import_static sys_argv

//go:cgo_import_static sys_mmap
//go:cgo_import_static sys_write
//go:cgo_import_static sys_read
//go:cgo_import_static sys_nanotime
//go:cgo_import_static sys_now
//go:cgo_import_static sys_thread_id
//go:cgo_import_static sys_futex_wait
//go:cgo_import_static sys_futex_wake
//go:cgo_import_static sys_usleep
