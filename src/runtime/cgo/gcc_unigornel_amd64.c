// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#include <types.h>
#include <go_pthread.h>
#include <runtime.h>
#include <string.h>
#include <xmalloc.h>
#include "libcgo_unigornel.h"

static void* threadentry(void*);
static void (*setg_gcc)(void*);

void
x_cgo_init(G *g, void (*setg)(void*))
{
	int attr;
	size_t size;

	setg_gcc = setg;
	pthread_attr_init(&attr);
	pthread_attr_getstacksize(&attr, &size);
	g->stacklo = (uintptr)&attr - size + 4096;
	pthread_attr_destroy(&attr);
}


void
_cgo_sys_thread_start(ThreadStart *ts)
{
	pthread_t p;
	size_t size;
	int err;


	pthread_attr_init(NULL);
	pthread_attr_getstacksize(NULL, &size);

	// Leave stacklo=0 and set stackhi=size; mstack will do the rest.
	ts->g->stackhi = size;
	err = pthread_create(&p, NULL, threadentry, ts);

	if (err != 0) {
		fprintf(stderr, "runtime/cgo: pthread_create failed: %s\n", strerror(err));
		abort();
	}
}

static void*
threadentry(void *v)
{
	ThreadStart ts;

	ts = *(ThreadStart*)v;
	free(v);

	/*
	 * Set specific keys.
	 */
	setg_gcc((void*)ts.g);

	crosscall_amd64(ts.fn);
	return nil;
}
