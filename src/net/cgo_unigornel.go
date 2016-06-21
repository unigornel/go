// Copyright 2011 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build cgo,!netgo
// +build unigornel

package net

import "C"
import "unsafe"

const cgoAddrInfoFlags = 0

// An addrinfoErrno represents a getaddrinfo, getnameinfo-specific
// error number. It's a signed number and a zero value is a non-error
// by convention.
type addrinfoErrno int

func (eai addrinfoErrno) Error() string   { return "not implemented" }
func (eai addrinfoErrno) Temporary() bool { return false }
func (eai addrinfoErrno) Timeout() bool   { return false }

func cgoLookupHost(name string) (hosts []string, err error, completed bool) {
	panic("not implemented")
	addrs, err, completed := cgoLookupIP(name)
	for _, addr := range addrs {
		hosts = append(hosts, addr.String())
	}
	return
}

func cgoLookupPort(network, service string) (port int, err error, completed bool) {
	acquireThread()
	defer releaseThread()
	panic("not implemented")
}

func cgoLookupIPCNAME(name string) (addrs []IPAddr, cname string, err error, completed bool) {
	acquireThread()
	defer releaseThread()
	panic("not implemented")
}

func cgoLookupIP(name string) (addrs []IPAddr, err error, completed bool) {
	addrs, _, err, completed = cgoLookupIPCNAME(name)
	return
}

func cgoLookupCNAME(name string) (cname string, err error, completed bool) {
	_, cname, err, completed = cgoLookupIPCNAME(name)
	return
}

// These are roughly enough for the following:
//
// Source		Encoding			Maximum length of single name entry
// Unicast DNS		ASCII or			<=253 + a NUL terminator
//			Unicode in RFC 5892		252 * total number of labels + delimiters + a NUL terminator
// Multicast DNS	UTF-8 in RFC 5198 or		<=253 + a NUL terminator
//			the same as unicast DNS ASCII	<=253 + a NUL terminator
// Local database	various				depends on implementation
const (
	nameinfoLen    = 64
	maxNameinfoLen = 4096
)

func cgoLookupPTR(addr string) ([]string, error, bool) {
	acquireThread()
	defer releaseThread()
	panic("not implemented")
}

func cgoSockaddr(ip IP, zone string) (unsafe.Pointer, int32) {
	panic("not implemented")
}

func copyIP(x IP) IP {
	if len(x) < 16 {
		return x.To16()
	}
	y := make(IP, len(x))
	copy(y, x)
	return y
}
