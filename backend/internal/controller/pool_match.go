package controller

import (
	"log/slog"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/db"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetAllPoolMatches(c *gin.Context) {
	data, err := db.GetAllPoolMatches(c)
	if err != nil {
		c.Status(http.StatusInternalServerError)
		slog.Error("Failed to get pool matches", "error", err.Error())
		return
	}
	c.JSON(http.StatusOK, data)
}

func UpdatePoolMatch(c *gin.Context) {
	userId, _ := c.Get("userId")

	role, err := db.GetUserRole(c, userId.(int))
	if err != nil {
		slog.Info("Failed to get user role", "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
		return
	}

	if role != schema.UserAdmin {
		slog.Info("StatusUnauthorized user role", "req", c.Request)
		c.JSON(http.StatusForbidden, gin.H{"message": "not allowed"})
		return
	}

	var req schema.UpdatePoolMatchRequest
	if err := c.Bind(&req); err != nil {
		slog.Info("Failed to bind update pool match request", "req", c.Request, "err", err)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
		return
	}

	data, err := db.UpdatePoolMatch(c, req)
	if err != nil {
		slog.Error("Failed to update pool match data", "err", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to update pool match data"})
		return
	}
	c.JSON(http.StatusOK, data)
}
