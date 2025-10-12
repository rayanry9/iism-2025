package middlewares

import (
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/utility"
)

func AuthJWT() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString, err := c.Cookie("jwt")
		if err != nil {
			c.AbortWithStatus(http.StatusUnauthorized)
			return
		}

		token, err := utility.VerifyToken(tokenString)
		if err != nil {
			c.AbortWithStatus(http.StatusUnauthorized)
			return
		}
		claims, ok := token.Claims.(*utility.JWTClaims)
		if !ok {
			c.AbortWithError(http.StatusInternalServerError, errors.New("Failed parsing Claims"))
			return
		}

		c.Set("userId", claims.UserID)
		c.Next()
	}
}
