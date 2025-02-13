package main

import (
	_ "API/Database"
	"API/WebServer"
)

func main() {
	WebServer.StartServer()
}
