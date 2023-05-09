package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"strconv"
	"time"
)

const (
	filename    = "counter.txt"
	primaryFlag = "-primary"
	backupFlag  = "-backup"
	timeout     = 3 * time.Second
)

func main() {
	isPrimary := len(os.Args) > 1 && os.Args[1] == primaryFlag

	if isPrimary {
		runPrimary()
	} else {
		runBackup()
	}
}

func runPrimary() {
	counter := readCounter()
	_, currentFilePath, _, ok := runtime.Caller(0)
	if !ok {
		fmt.Println("Error getting the current file path")
		return
	}
	absPath, err := filepath.Abs(currentFilePath)
	if err != nil {
		log.Printf("Error :----)\n")
	}
	fmt.Print(absPath)
	cmd := exec.Command("osascript", "-e", `tell app "Terminal" to do script "go run `+absPath+` `+backupFlag+`"`)

	if err := cmd.Start(); err != nil {
		fmt.Println("Error starting backup:", err)
		return
	}

	for {
		counter++
		writeCounter(counter)
		fmt.Println(counter)
		time.Sleep(1 * time.Second)
	}
}

func runBackup() {
	for {
		time.Sleep(timeout)
		log.Printf("Backup is running\n")

		if primaryAlive() {
			continue
		}

		runPrimary()
		break
	}
}

func readCounter() int {
	data, err := ioutil.ReadFile(filename)
	if err != nil {
		return 0
	}

	counter, err := strconv.Atoi(string(data))
	if err != nil {
		return 0
	}

	return counter
}

func writeCounter(counter int) {
	data := []byte(strconv.Itoa(counter))
	if err := ioutil.WriteFile(filename, data, 0644); err != nil {
		fmt.Println("Error writing counter to file:", err)
	}
}

func primaryAlive() bool {
	info, err := os.Stat(filename)
	log.Printf("Info %s   Err %v\n", info, err)
	if err != nil {
		return false
	}
	return time.Since(info.ModTime()) < timeout
}
