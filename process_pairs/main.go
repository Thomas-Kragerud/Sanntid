package main

import (
	"Project/backup"
	"Project/primary"
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
)

const (
	backupFlag = "-backup"
)

func main() {
	theCount := 0

	// Read from cmd line
	isBackup := len(os.Args) > 1 && os.Args[1] == backupFlag

	// Chanals
	primaryChan := make(chan struct{})
	backupChan := make(chan int)

	// Get file path
	_, currentFilePath, _, ok := runtime.Caller(0)
	if !ok {
		log.Printf("Error getting the current file path\n")
		return
	}
	absPath, err := filepath.Abs(currentFilePath)
	if err != nil {
		log.Printf("Could not do filepath Abs\n")
	}

	if isBackup {
		log.Printf("Booting backup\n")
		go backup.Start(backupChan)
	} else {
		log.Printf("Booting primary ")
		go primary.Start(primaryChan, theCount)
	}

	for {
		select {

		case <-primaryChan:
			// Primary us to create a new backup
			log.Printf("Primary booter en backup!!")
			srcDir := filepath.Dir(absPath)
			cmd := exec.Command("osascript", "-e", `tell app "Terminal" to do script "cd `+srcDir+` && go run `+filepath.Base(absPath)+` `+backupFlag+`"`)

			if err := cmd.Start(); err != nil {
				fmt.Println("Error starting backup:", err)
				return
			}

		case updatedCount := <-backupChan:
			// Backup ses primary is dead -> transforms into the new primary
			go primary.Start(primaryChan, updatedCount)

		}
	}
}
