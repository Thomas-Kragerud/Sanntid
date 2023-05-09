package main

import (
	"fmt"
	"time"
)

func run(loopTime int) {
	// A for loop that loops once every second and exits after 10 seconds.
	for s := time.Now(); time.Since(s) < time.Duration(loopTime)*time.Second; time.Sleep(1 * time.Second) {
		fmt.Printf("Hello World, but from another program!\n")
	}
}

func main() {
	run(5)
}
