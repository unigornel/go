// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build unigornel

package net

import (
	"syscall"
	"time"
)

func probeIPv4Stack() bool {
	return true
}

func probeIPv6Stack() (supportsIPv6, supportsIPv4map bool) {
	return false, false
}

// favoriteAddrFamily returns the appropriate address family to
// the given net, laddr, raddr and mode. At first it figures
// address family out from the net. If mode indicates "listen"
// and laddr is a wildcard, it assumes that the user wants to
// make a passive connection with a wildcard address family, both
// AF_INET and AF_INET6, and a wildcard address like following:
//
//	1. A wild-wild listen, "tcp" + ""
//	If the platform supports both IPv6 and IPv6 IPv4-mapping
//	capabilities, or does not support IPv4, we assume that
//	the user wants to listen on both IPv4 and IPv6 wildcard
//	addresses over an AF_INET6 socket with IPV6_V6ONLY=0.
//	Otherwise we prefer an IPv4 wildcard address listen over
//	an AF_INET socket.
//
//	2. A wild-ipv4wild listen, "tcp" + "0.0.0.0"
//	Same as 1.
//
//	3. A wild-ipv6wild listen, "tcp" + "[::]"
//	Almost same as 1 but we prefer an IPv6 wildcard address
//	listen over an AF_INET6 socket with IPV6_V6ONLY=0 when
//	the platform supports IPv6 capability but not IPv6 IPv4-
//	mapping capability.
//
//	4. A ipv4-ipv4wild listen, "tcp4" + "" or "0.0.0.0"
//	We use an IPv4 (AF_INET) wildcard address listen.
//
//	5. A ipv6-ipv6wild listen, "tcp6" + "" or "[::]"
//	We use an IPv6 (AF_INET6, IPV6_V6ONLY=1) wildcard address
//	listen.
//
// Otherwise guess: if the addresses are IPv4 then returns AF_INET,
// or else returns AF_INET6.  It also returns a boolean value what
// designates IPV6_V6ONLY option.
//
// Note that OpenBSD allows neither "net.inet6.ip6.v6only=1" change
// nor IPPROTO_IPV6 level IPV6_V6ONLY socket option setting.
func favoriteAddrFamily(net string, laddr, raddr sockaddr, mode string) (family int, ipv6only bool) {
	switch net[len(net)-1] {
	case '4':
		return syscall.AF_INET, false
	case '6':
		return syscall.AF_INET6, true
	}

	if mode == "listen" && (laddr == nil || laddr.isWildcard()) {
		if supportsIPv4map || !supportsIPv4 {
			return syscall.AF_INET6, false
		}
		if laddr == nil {
			return syscall.AF_INET, false
		}
		return laddr.family(), false
	}

	if (laddr == nil || laddr.family() == syscall.AF_INET) &&
		(raddr == nil || raddr.family() == syscall.AF_INET) {
		return syscall.AF_INET, false
	}
	return syscall.AF_INET6, false
}

// Internet sockets (TCP, UDP, IP)

func internetSocket(net string, laddr, raddr sockaddr, deadline time.Time, sotype, proto int, mode string, cancel <-chan struct{}) (fd *netFD, err error) {
	family, ipv6only := favoriteAddrFamily(net, laddr, raddr, mode)
	return socket(net, family, sotype, proto, ipv6only, laddr, raddr, deadline, cancel)
}

func ipToSockaddr(family int, ip IP, port int, zone string) (syscall.Sockaddr, error) {
	switch family {
	case syscall.AF_INET:
		if len(ip) == 0 {
			ip = IPv4zero
		}
		if ip = ip.To4(); ip == nil {
			return nil, &AddrError{Err: "non-IPv4 address", Addr: ip.String()}
		}
		sa := new(syscall.SockaddrInet4)
		for i := 0; i < IPv4len; i++ {
			sa.Addr[i] = ip[i]
		}
		sa.Port = port
		return sa, nil
	case syscall.AF_INET6:
		if len(ip) == 0 {
			ip = IPv6zero
		}
		// IPv4 callers use 0.0.0.0 to mean "announce on any available address".
		// In IPv6 mode, Linux treats that as meaning "announce on 0.0.0.0",
		// which it refuses to do. Rewrite to the IPv6 unspecified address.
		if ip.Equal(IPv4zero) {
			ip = IPv6zero
		}
		if ip = ip.To16(); ip == nil {
			return nil, &AddrError{Err: "non-IPv6 address", Addr: ip.String()}
		}
		sa := new(syscall.SockaddrInet6)
		for i := 0; i < IPv6len; i++ {
			sa.Addr[i] = ip[i]
		}
		sa.Port = port
		sa.ZoneId = uint32(zoneToInt(zone))
		return sa, nil
	}
	return nil, &AddrError{Err: "invalid address family", Addr: ip.String()}
}
