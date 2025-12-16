package controller

import (
	"log/slog"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/db"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetLeaderboardData(c *gin.Context) {
	var req schema.GetLeaderboardDataRequest
	if err := c.Bind(&req); err != nil {
		slog.Info("Failed to bind leaderboard data request", "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
		return
	}

	data, err := db.GetLeaderboardData(c, req)
	if err != nil {
		slog.Error("Failed to query leaderboard data", "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to get leaderboard data"})
		return
	}
	c.JSON(http.StatusOK, data)
}
