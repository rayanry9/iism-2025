package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/controller"
)

func SetupApiRoutes(r *gin.RouterGroup) {
	r.GET("get-pools-by-sport-id", controller.GetPoolsBySportId)
}
