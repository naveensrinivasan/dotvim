package main

import (
	"fmt"
	"strings"

	"github.com/codeskyblue/go-sh"
)

func main() {
	o, err := sh.Command("docker-machine", "status", "default").Output()
	if err != nil {
		fmt.Println("eerr", err)
		return
	}
	if strings.ContainsAny(string(o), "Running") {
		return
	}
	sh.Command("docker-machine", "start", "default").Run()
}
