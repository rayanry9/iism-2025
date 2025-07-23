package controller

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/db"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetPoolsBySportId(c *gin.Context) {
	var req schema.GetPoolsBySportIdRequest

	if err := c.Bind(&req); err != nil {
		fmt.Println(err)
		c.Status(http.StatusBadRequest)
		return
	}

	data, err := db.GetPoolsBySportId(c, req)
	if err != nil {
		fmt.Println(err)
		c.Status(http.StatusInternalServerError)
		return
	}

	c.JSON(http.StatusOK, data)
}
