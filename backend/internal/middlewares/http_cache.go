package middlewares

import (
	"fmt"

	"github.com/gin-gonic/gin"
)

func CacheHTTP(duration int) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Header("Cache-Control", fmt.Sprintf("max-age=%v", duration))
		// c.Header("Cache-Control", fmt.Sprintf("max-age=%v", 2))
		c.Next()
	}
}
