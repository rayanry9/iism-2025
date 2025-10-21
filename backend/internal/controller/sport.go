package controller

import (
	"log/slog"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/db"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
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
func GetAllAthleticSubSportsData(c *gin.Context) {
	var req schema.GetAllAthleticSubSportDataRequest
	if err := c.Bind(&req); err != nil {
		slog.Error("Athletic Sub sports data GET", "error", err)
		c.Status(http.StatusBadRequest)
		return
	}
	data, err := db.GetAllAtheleticSubSportsData(c, req)
	if err != nil {
		slog.Error("Get Athletics sub sport data", "err", err)
		c.Status(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, data)
}
