package main

import (
	"fmt"
	"os"

	"github.com/rayanry9/iism-2025/backend/internal/utility"
)

func main() {
	fmt.Printf("Password : %v \nEncoded Password: %v\n", os.Args[1:2][0], utility.GenerateEncodedHashFromPassword(os.Args[1:2][0]))
}
