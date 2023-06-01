package main

import (
	"fmt"
	"runtime"
	"sync"
	"sync/atomic"
)

// Wait group to wait for all goroutines to finish
// Atomic - read, modify, right completed as a single uninterruptible operation
//  that completes in a single step, without the possibility of being interrupted.

// From perspective of other threads, locks that protects a sequence of operation, can create
// the impression of atomicity
// They see the sequence of operations as either not having occurred or having fully occurred, and never see
// intermediate state, Locks are therefore "effectively atomic"
//
// However, this is not the same as truly atomic operations, which is a guaranteed by
// the hardware to be uninterruptible.
// Locks are a higher level concept than atomic operations, typically involve context switches and is much slower than
// atomic operations
//
// Atomic primitives, like those in Go's sync/atomic map directly onto hardware features and
// typically faster and lighter weight than locks, but only work for individual, simple operations

var (
	counter int64
	wg      sync.WaitGroup
)

func increment(name string) {
	for count := 0; count < 2; count++ {
		// Atomically increment the counter
		atomic.AddInt64(&counter, 1)

		// Yield the thread and place back in queue.
		// This done for "fairness" giving other goroutines a chance to run
		// However, it is not necessary in this simple example
		// Thr runtime.Gosched() function is part of Go's concurrency mechanisms
		// It yields the processor, allowing other goroutines to run
		// It does not suspend the current goroutine, so execution resumes automatically
		runtime.Gosched()
	}
	// Done with this goroutine
	wg.Done()
}

func main() {
	// Create two goroutines.
	wg.Add(2)

	go increment("Goroutine1")
	go increment("Goroutine2")

	// Wait for the goroutines to finish
	wg.Wait()

	fmt.Printf("Final Counter: %d\n", counter)
}
