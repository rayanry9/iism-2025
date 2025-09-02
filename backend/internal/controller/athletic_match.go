package controller

import (
	"log/slog"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/db"
)

func GetAllAthleticMatches(c *gin.Context) {
	data, err := db.GetAllAthleticMatches(c)
	if err != nil {
		c.Status(http.StatusInternalServerError)
		slog.Error(err.Error())
		return
	}
	c.JSON(http.StatusOK, data)

}
