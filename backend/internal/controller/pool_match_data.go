package controller

import (
	"log/slog"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/db"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetPoolMatchDataById(c *gin.Context) {

	var req schema.GetPoolMatchDataByIdRequest
	if err := c.Bind(&req); err != nil {
		slog.Error("Pool match data GET", "error", err, "req", c.Request)
		c.Status(http.StatusBadRequest)
		return
	}
	data, err := db.GetPoolMatchDataById(c, req)
	if err != nil {
		slog.Error("Get pool match data", "err", err, "req", c.Request)
		c.Status(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, data)
}
