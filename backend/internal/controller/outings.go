package controller

import (
	"bytes"
	"fmt"
	"io"
	"log/slog"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/db"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func CreateOuting(c *gin.Context) {
	userId, exists := c.Get("userId")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "StatusUnauthorized"})
		return
	}
	var req schema.OutingRequest
	body, _ := io.ReadAll(c.Request.Body)
	fmt.Println("RAW BODY:", string(body))
	c.Request.Body = io.NopCloser(bytes.NewBuffer(body))
	if err := c.Bind(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid JSON"})
		return
	}

	if req.EntryTime.IsZero() || req.ExitTime.IsZero() || req.Reason == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Missing required fields"})
		return
	}

	err := db.MakeOuting(c, userId.(int), req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Error on our side"})
		fmt.Println(err)
		slog.Error("DB error")

		return
	}
	c.Status(http.StatusOK)
}

func GetAllOutings(c *gin.Context) {
	userId, exists := c.Get("userId")
	if !exists {
		c.JSON(401, gin.H{"message": "unauthorized"})
		return
	}

	isCoach, err := db.IsCoach(c, userId.(int))
	if err != nil {
		c.JSON(500, gin.H{"message": "server error"})
		return
	}
	if os.Getenv("GIN_MODE") != "debug" {
		if !isCoach {
			fmt.Println("YO FOOl")
			c.JSON(403, gin.H{"message": "forbidden"})
			return
		}
	}

	instituteId, err := db.GetUserInstitute(c, userId.(int))
	if err != nil {
		c.JSON(500, gin.H{"message": "server error"})
		return
	}

	outings, err := db.GetAllOutings(c, instituteId)
	if err != nil {
		c.JSON(500, gin.H{"message": "server error"})
		return
	}

	c.JSON(200, outings)
}
func ApproveOuting(c *gin.Context) {
	userId, exists := c.Get("userId")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
		return
	}

	// Must be a coach
	isCoach, err := db.IsCoach(c, userId.(int))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}
	if os.Getenv("GIN_MODE") != "debug" {
		if !isCoach {
			c.JSON(http.StatusForbidden, gin.H{"message": "forbidden"})
			return
		}
	}

	var req schema.OutingStatusUpdateRequest
	if err := c.BindJSON(&req); err != nil || req.OutingId == 0 {
		c.JSON(http.StatusBadRequest, gin.H{"message": "invalid request"})
		return
	}

	// Coach's institute
	coachInstitute, err := db.GetUserInstitute(c, userId.(int))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}

	// Outing's status + institute of the student
	status, studentInstitute, err := db.GetOutingStatusAndInstitute(c, req.OutingId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}

	// Must be same institute
	if coachInstitute != studentInstitute {
		c.JSON(http.StatusForbidden, gin.H{"message": "forbidden"})
		return
	}

	// Must be pending (0)
	if status != 0 {
		c.JSON(http.StatusBadRequest, gin.H{"message": "outing is not pending"})
		return
	}

	if err := db.UpdateOutingStatus(c, req.OutingId, 1); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}

	c.Status(http.StatusOK)
}
func DenyOuting(c *gin.Context) {
	userId, exists := c.Get("userId")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
		return
	}

	// Must be a coach
	isCoach, err := db.IsCoach(c, userId.(int))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}
	if os.Getenv("GIN_MODE") != "debug" {
		if !isCoach {
			c.JSON(http.StatusForbidden, gin.H{"message": "forbidden"})
			return
		}
	}

	var req schema.OutingStatusUpdateRequest
	if err := c.BindJSON(&req); err != nil || req.OutingId == 0 {
		c.JSON(http.StatusBadRequest, gin.H{"message": "invalid request"})
		return
	}

	// Coach's institute
	coachInstitute, err := db.GetUserInstitute(c, userId.(int))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}

	// Outing's status + student's institute
	status, studentInstitute, err := db.GetOutingStatusAndInstitute(c, req.OutingId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}

	if coachInstitute != studentInstitute {
		c.JSON(http.StatusForbidden, gin.H{"message": "forbidden"})
		return
	}

	if status != 0 {
		c.JSON(http.StatusBadRequest, gin.H{"message": "outing is not pending"})
		return
	}

	if err := db.UpdateOutingStatus(c, req.OutingId, 2); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}

	c.Status(http.StatusOK)
}
func GetMyOutings(c *gin.Context) {
	userId, exists := c.Get("userId")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
		return
	}

	outings, err := db.GetUserOutings(c, userId.(int))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}

	c.JSON(http.StatusOK, outings)
}
