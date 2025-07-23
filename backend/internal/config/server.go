package config

import (
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func SetSecurityHeaders() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Header("X-Frame-Options", "DENY")
		c.Header("Content-Security-Policy", "default-src 'self'; connect-src *; font-src *; script-src-elem * 'unsafe-inline'; img-src * data:; style-src * 'unsafe-inline';")
		c.Header("X-XSS-Protection", "1; mode=block")
		c.Header("Strict-Transport-Security", "max-age=31536000; includeSubDomains; preload")
		c.Header("Referrer-Policy", "strict-origin")
		c.Header("X-Content-Type-Options", "nosniff")
		c.Header("Permissions-Policy", "geolocation=(),midi=(),sync-xhr=(),microphone=(),camera=(),magnetometer=(),gyroscope=(),fullscreen=(self),payment=()")
		c.Next()
	}
}

func SetCors() gin.HandlerFunc {
	return cors.New(cors.Config{
		// AllowOrigins: []string{"https://" + os.Getenv("BASE_URL") + ":" + os.Getenv("PORT")},
		AllowOrigins:     []string{"http://localhost:5173", "http://192.168.198.78:5173"},
		AllowMethods:     []string{"GET", "POST", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization", "Content-Disposition"},
		AllowCredentials: true,
	})
}
