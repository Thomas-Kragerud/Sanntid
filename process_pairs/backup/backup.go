package backup

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"net"
	"time"
)

func Start(notify chan int) {
	var theCount int
	pollRate := 500 * time.Millisecond
	for {
		time.Sleep(pollRate)

		// Establish connection with server (Primary)
		con, err := net.Dial("tcp", "localhost:6000")
		if err != nil {
			fmt.Printf("Primary is down, starting new primary\n")
			notify <- theCount
			return
		}
		// Error handling is trivial and is left to the student assistant
		con.Write([]byte("Kjøh"))
		buf := make([]byte, 4)
		con.Read(buf)
		var recived int32
		binary.Read(bytes.NewReader(buf), binary.BigEndian, &recived)
		theCount = int(recived)
		con.Close()
	}
}
