package utility

import (
	"errors"
	"os"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

var secretKey = os.Getenv("JWT_SECRET")

type JWTClaims struct {
	UserID int `json:"userId"`
	jwt.RegisteredClaims
}

func CreateToken(userId int) (string, error) {

	claims := JWTClaims{
		UserID: userId,
		RegisteredClaims: jwt.RegisteredClaims{
			Subject:   "UserData",
			Issuer:    "iism-2025",
			IssuedAt:  jwt.NewNumericDate(time.Now()),
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(time.Hour * 6)),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS512, claims)
	tokenString, err := token.SignedString([]byte(secretKey))
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

func VerifyToken(tokenString string) (*jwt.Token, error) {
	token, err := jwt.ParseWithClaims(tokenString, &JWTClaims{}, func(t *jwt.Token) (interface{}, error) { return []byte(secretKey), nil })

	if err != nil {
		return nil, err
	}

	if !token.Valid {
		return nil, errors.New("Invalid/Expired JWT Token")
	}

	return token, nil
}
