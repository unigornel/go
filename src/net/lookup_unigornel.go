// Copyright 2016 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build unigornel

package net

func readProtocols() {
	panic("not implemented")
}

func lookupProtocol(name string) (int, error) {
	panic("not implemented")
}

func lookupHost(host string) (addrs []string, err error) {
	panic("not implemented")
}

func lookupIP(host string) (addrs []IPAddr, err error) {
	panic("not implemented")
}

func lookupPort(network, service string) (int, error) {
	panic("not implemented")
}

func lookupCNAME(name string) (string, error) {
	panic("not implemented")
}

func lookupSRV(service, proto, name string) (string, []*SRV, error) {
	panic("not implemented")
}

func lookupMX(name string) ([]*MX, error) {
	panic("not implemented")
}

func lookupNS(name string) ([]*NS, error) {
	panic("not implemented")
}

func lookupTXT(name string) ([]string, error) {
	panic("not implemented")
}

func lookupAddr(addr string) ([]string, error) {
	panic("not implemented")
}
