// Copyright 2016 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package net

import (
	"syscall"
	"time"
)

func probeIPv4Stack() bool {
	return true
}

func probeIPv6Stack() (supportsIPv6, supportsIPv4map bool) {
	return
}

func favoriteAddrFamily(net string, laddr, raddr sockaddr, mode string) (family int, ipv6only bool) {
	panic("not implemented")
}

func internetSocket(net string, laddr, raddr sockaddr, deadline time.Time, sotype, proto int, mode string, cancel <-chan struct{}) (fd *netFD, err error) {
	panic("not implemented")
}

func ipToSockaddr(family int, ip IP, port int, zone string) (syscall.Sockaddr, error) {
	panic("not implemented")
}
