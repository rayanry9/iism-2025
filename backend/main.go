package main

import (
	"log/slog"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/routes"
)

func main() {

	// .env Load
	err := godotenv.Load()
	if err != nil {
		slog.Error("Failed to Initialize .env")
	}

	// Databse Initialize
	config.InitDB()
	defer config.DB.Close()

	// Gin Setup
	if os.Getenv("GIN_MODE") == "release" {
		gin.SetMode(gin.ReleaseMode)
	} else {
		gin.SetMode(gin.DebugMode)
	}
	router := gin.Default()
	router.SetTrustedProxies(nil)
	router.Use(config.SetSecurityHeaders(), config.SetCors())
	routes.SetupApiRoutes(router.Group("api"))

	slog.Info("Server Started at " + os.Getenv("API_BASE_URL") + ":" + os.Getenv("API_PORT"))
	router.Run(os.Getenv("API_BASE_URL") + ":" + os.Getenv("API_PORT"))
}
