package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"time"
)

const checkpointFile = "go_file.txt"

func process_data(start, end int) {
	for i := start; i <= end; i++ {
		// Save checkpoint before complete side effect
		create_checkpoint(i)
		fmt.Printf("Processing %d\n", i)
		time.Sleep(1 * time.Second)
	}
	fmt.Print("Processing complete")
}

func create_checkpoint(value int) {
	// Write the checkpoint file
	os.WriteFile(checkpointFile, []byte(fmt.Sprintf("%d", value)), 0644)
}

func load_checkpoint() int {
	if _, err := os.Stat(checkpointFile); err == nil {
		data, _ := ioutil.ReadFile(checkpointFile)
		value, _ := strconv.Atoi(string(data))
		return value
	}
	return 0
}

func main() {
	start := load_checkpoint()
	end := 10

	defer func() {
		if r := recover(); r != nil {
			mid := load_checkpoint()
			fmt.Printf("\nCheckpoint created at %d", mid)
		}
		if _, err := os.Stat(checkpointFile); err == nil {
			if load_checkpoint() == end {
				os.Remove(checkpointFile)
			}
		}
	}()

	process_data(start, end)
}
