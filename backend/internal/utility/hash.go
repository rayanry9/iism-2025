package utility

import (
	"crypto/rand"
	"crypto/subtle"
	"encoding/base64"
	"errors"
	"fmt"
	"strings"

	"golang.org/x/crypto/argon2"
)

const (
	iterations  = 2
	memory      = 64 * 1024
	parallelism = 4
	keyLength   = 32
	saltLength  = 16
)

func GenerateEncodedHashFromPassword(password string) (encodedHash string) {
	salt := generateRandomBytes(saltLength)
	hash := argon2.IDKey([]byte(password), salt, iterations, memory, parallelism, keyLength)

	b64salt := base64.RawStdEncoding.EncodeToString(salt)
	b64hash := base64.RawStdEncoding.EncodeToString(hash)

	return fmt.Sprintf("$argon2id$v=%d$m=%d,t=%d,p=%d$%s$%s", argon2.Version, memory, iterations, parallelism, b64salt, b64hash)
}

func generateRandomBytes(n uint) []byte {
	b := make([]byte, n)
	rand.Read(b)
	return b
}

func VerifyHashWithPassword(encodedHash string, password string) (match bool, err error) {

	vals := strings.Split(encodedHash, "$")
	if len(vals) != 6 {
		return false, errors.New("Invalid Hash")
	}

	var version int

	_, err = fmt.Sscanf(vals[2], "v=%d", &version)
	if err != nil {
		return false, err
	}

	if version != argon2.Version {
		return false, errors.New("Incompatible Argon2Id version")
	}

	var (
		iterationsLocal  int
		memoryLocal      int
		parallelismLocal int
	)

	_, err = fmt.Sscanf(vals[3], "m=%d,t=%d,p=%d", &memoryLocal, &iterationsLocal, &parallelismLocal)
	if err != nil {
		return false, err
	}

	salt, err := base64.RawStdEncoding.Strict().DecodeString(vals[4])
	if err != nil {
		return false, err
	}

	hash, err := base64.RawStdEncoding.Strict().DecodeString(vals[5])
	if err != nil {
		return false, err
	}
	keyLengthLocal := len(hash)

	newHash := argon2.IDKey([]byte(password), salt, uint32(iterationsLocal), uint32(memoryLocal), uint8(parallelismLocal), uint32(keyLengthLocal))

	if subtle.ConstantTimeCompare(hash, newHash) == 1 {
		return true, nil
	} else {
		return false, nil
	}

}
