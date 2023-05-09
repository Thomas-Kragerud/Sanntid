package primary

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"net"
	"os"
	"sync"
	"time"
)

const (
	SERVER_HOST = "localhost"
	SERVER_PORT = "6000"
	SERVER_TYPE = "tcp"
)

func Start(notify chan struct{}, countFrom int) {

	theCount := countFrom
	var mu sync.Mutex

	// The counter
	go func() {
		defer mu.Unlock()
		for {
			time.Sleep(time.Second)
			mu.Lock()
			fmt.Printf("%d\n", theCount)
			theCount++
			mu.Unlock()
		}
	}()

	// Create a new backup
	notify <- struct{}{}

	// Set up TCP server
	listen, err := net.Listen(SERVER_TYPE, SERVER_HOST+":"+SERVER_PORT)
	if err != nil {
		fmt.Printf("Error staring TCP server for listening: %s\n", err.Error())
		os.Exit(1)
	}
	defer listen.Close()

	chAccept := make(chan net.Conn)
	chErr := make(chan error)
	timeOut := time.NewTimer(5 * time.Second)

	// Accepting incoming connections
	go func() {
		for {
			conn, err := listen.Accept()
			if err != nil {
				chErr <- err
			}
			chAccept <- conn
		}
	}()

	// Handle the incoming connections
	for {
		select {
		case con := <-chAccept:
			timeOut.Reset(5 * time.Second)
			mu.Lock()
			go handleCon(con, theCount)
			mu.Unlock()

		case err := <-chErr:
			fmt.Printf("Error listening to Backup %s\n", err.Error())
			os.Exit(1)

		case <-timeOut.C:
			// listen.Accept() timed out
			fmt.Printf("Timed out\n")
		}
	}
}

func handleCon(con net.Conn, c int) {
	defer con.Close()
	buffer := make([]byte, 1024)

	for {
		_, err := con.Read(buffer)
		if err != nil {
			return
		}

		buf := new(bytes.Buffer)
		binary.Write(buf, binary.BigEndian, int32(c))
		byteSlice := buf.Bytes()
		_, err = con.Write(byteSlice)
	}
}

func countToDeath(killMe chan<- bool, t int) {
	tTime := time.Duration(t)
	for s := time.Now(); time.Since(s) < tTime*time.Second; time.Sleep(1 * time.Second) {
		fmt.Printf("Terminate in %d sek \n", tTime-time.Since(s)/time.Second)
	}
	killMe <- true
}
