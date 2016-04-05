// Copyright 2015 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build cgo
// +build unigornel

#include <mini-os/types.h>
#include <mini-os/go_pthread.h>
#include <mini-os/runtime.h>
#include <mini-os/waittypes.h>

DECLARE_WAIT_QUEUE_HEAD(runtime_init_wq);
int runtime_init_done = 0;

void
x_cgo_sys_thread_create(void* (*func)(void*), void* arg) {
	pthread_t p;
	int err = pthread_create(&p, NULL, func, arg);
	if (err != 0) {
		fprintf(stderr, "pthread_create failed: %s", strerror(err));
		abort();
	}
}

void
_cgo_wait_runtime_init_done() {
	pthread_cond_wait(&runtime_init_wq, &runtime_init_done);
}

void
x_cgo_notify_runtime_init_done(void* dummy) {
	runtime_init_done = 1;
	pthread_cond_broadcast(&runtime_init_wq);
}
