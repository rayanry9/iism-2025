package controller

import (
	"log/slog"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/db"
)

func GetAllSports(c *gin.Context) {
	data, err := db.GetAllSports(c)
	if err != nil {
		slog.Error("GetAllSports", "err", err)
		c.Status(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, data)
}
