package main

import (
	"context"
	"crypto/rand"
	"fmt"
	"math/big"
	"os"
	"strings"

	"github.com/joho/godotenv"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/utility"
)

func randomDigitsString(n int) string {

	max := new(big.Int).Exp(big.NewInt(10), big.NewInt(int64(n)), nil)
	num, _ := rand.Int(rand.Reader, max)

	return fmt.Sprintf("%0*d", n, num)
}
func main() {
	err := godotenv.Load()
	if err != nil {
		panic(err)
	}

	config.InitDB()
	data, err := os.ReadFile("data.txt")
	if err != nil {
		panic(err)
	}

	for str := range strings.SplitSeq(string(data), "\n") {
		if str == "" {
			continue
		}
		pwd := randomDigitsString(6)
		fmt.Printf("Id: %s  Pwd: %s\n", str, pwd)

		_, err := config.DB.Exec(context.Background(), `update users set password = $1 where assigned_id ilike $2`, utility.GenerateEncodedHashFromPassword(pwd), str)
		if err != nil {
			fmt.Printf("Error at Id: %s and error being %v\n", str, err)
		}
	}

}
