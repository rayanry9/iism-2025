package controller

import (
	"encoding/json"
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/db"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
	"github.com/rayanry9/iism-2025/backend/internal/utility"
)

func Login(c *gin.Context) {
	var req schema.LoginRequest
	if err := c.Bind(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid Login Data"})
		slog.Error("Bad Request for login", "error", err)
		return
	}

	id, password, exists, err := db.GetUserDetailFromEmailOrAssignedId(c, req.Email)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error on our end"})
		slog.Error("Failed getting user detail", "error", err)
		return
	}
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "User does not exists"})
		return
	}
	if password == nil {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "User does not exists"})
		return
	}
	match, err := utility.VerifyHashWithPassword(*password, req.Password)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error on our end"})
		slog.Error("Failed getting user detail", "error", err)
		return
	}
	if !match {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "Wrong Password"})
		return
	}
	token, err := utility.CreateToken(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		return
	}

	if os.Getenv("GIN_MODE") == "debug" {
		http.SetCookie(c.Writer, &http.Cookie{
			Name:     "jwt",
			Value:    token,
			MaxAge:   int((time.Hour * 5)),
			Path:     "/",
			Secure:   false,
			HttpOnly: true,
			SameSite: http.SameSiteLaxMode,
		})
	} else {
		http.SetCookie(c.Writer, &http.Cookie{
			Name:     "jwt",
			Value:    token,
			MaxAge:   int((time.Hour * 5)),
			Path:     "/",
			Domain:   strings.Split(os.Getenv("FRONTEND_URL"), "://")[1],
			Secure:   true,
			HttpOnly: true,
			SameSite: http.SameSiteLaxMode,
		})
	}
}

func Logout(c *gin.Context) {
	if os.Getenv("GIN_MODE") == "debug" {
		http.SetCookie(c.Writer, &http.Cookie{
			Name:     "jwt",
			MaxAge:   -1,
			Path:     "/",
			Secure:   false,
			HttpOnly: true,
			SameSite: http.SameSiteLaxMode,
		})
	} else {
		http.SetCookie(c.Writer, &http.Cookie{
			Name:     "jwt",
			MaxAge:   -1,
			Path:     "/",
			Domain:   strings.Split(os.Getenv("FRONTEND_URL"), "://")[1],
			Secure:   true,
			HttpOnly: true,
			SameSite: http.SameSiteLaxMode,
		})
	}

}

func Me(c *gin.Context) {
	userId, exists := c.Get("userId")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "StatusUnauthorized"})
		return
	}
	data, err := db.GetUserDetails(c, userId.(int))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Error on our side"})
		slog.Error("Failed to get user details", "userId", userId, "error", err)
		return
	}

	c.JSON(http.StatusOK, data)
}

func RegisterPlayer(c *gin.Context) {
	var req schema.RegisterPlayerRequest

	if err := c.Bind(&req); err != nil {
		slog.Info("Bad request for register player", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad Request"})
		return
	}

	if req.ProfilePic.Size > 10*1024*1024 {
		slog.Info("Profile Pic File size exceeded", "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "File Size exceeded"})
		return
	}

	var sportsData []schema.RegisterPlayerSportData
	if err := json.Unmarshal([]byte(req.Sports), &sportsData); err != nil {
		slog.Info("Bad request for Sport Data", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad Request"})
		return
	}

	sportName, err := db.GetSportNameFromId(c, sportsData[0].SportId)
	if err != nil {
		slog.Info("Bad request for register player | No such sport id", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "No such sport"})
		return
	}
	// IIT - Sport - Player
	fmt.Println(req.ProfilePic.Filename)
	req.ProfilePic.Filename = fmt.Sprintf("%s-%s-%s", req.Institute, sportName, utility.ToPascalCase(req.FirstName)+utility.ToPascalCase(utility.CoalesceString(req.MiddleName))+utility.ToPascalCase(utility.CoalesceString(req.LastName)))

	if err := utility.SaveProfilePic(req.ProfilePic); err != nil {
		slog.Error("Failed to save profile pic", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to save Profile Picture"})
		return
	}

	if err := db.RegisterPlayer(c, req, sportsData); err != nil {
		slog.Error("Failed to register player", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to register player."})
		return
	}
	c.Status(http.StatusOK)
}

func RegisterPlayerEdit(c *gin.Context) {
	var req schema.RegisterPlayerEditRequest

	if err := c.Bind(&req); err != nil {
		slog.Info("Bad request for register player edit", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad Request"})
		return
	}

	if req.ProfilePic.Size > 10*1024*1024 {
		slog.Info("Profile Pic File size exceeded", "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "File Size exceeded"})
		return
	}

	var sportsData []schema.RegisterPlayerSportData
	if err := json.Unmarshal([]byte(req.Sports), &sportsData); err != nil {
		slog.Info("Bad request for Sport Data edit", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad Request"})
		return
	}

	sportName, err := db.GetSportNameFromId(c, sportsData[0].SportId)
	if err != nil {
		slog.Info("Bad request for register player eidt | No such sport id", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "No such sport"})
		return
	}
	// IIT - Sport - Player
	fmt.Println(req.ProfilePic.Filename)
	req.ProfilePic.Filename = fmt.Sprintf("%s-%s-%s", req.Institute, sportName, utility.ToPascalCase(req.FirstName)+utility.ToPascalCase(utility.CoalesceString(req.MiddleName))+utility.ToPascalCase(utility.CoalesceString(req.LastName)))

	if err := utility.SaveProfilePic(req.ProfilePic); err != nil {
		slog.Error("Failed to save profile pic", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to save Profile Picture"})
		return
	}

	if err := db.RegisterPlayerEdit(c, req, sportsData); err != nil {
		slog.Error("Failed to register player edit", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to edit player."})
		return
	}
	c.Status(http.StatusOK)
}

func RegisterCoach(c *gin.Context) {
	var req schema.RegisterCoachRequest

	if err := c.Bind(&req); err != nil {
		slog.Info("Bad request for register player", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad Request"})
		return
	}

	if req.ProfilePic.Size > 10*1024*1024 {
		slog.Info("Profile Pic File size exceeded", "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "File Size exceeded"})
		return
	}

	// IIT - Sport - Player
	req.ProfilePic.Filename = fmt.Sprintf("%s-%s-%s", req.Institute, req.Gender, utility.ToPascalCase(req.FirstName)+utility.ToPascalCase(utility.CoalesceString(req.MiddleName))+utility.ToPascalCase(utility.CoalesceString(req.LastName)))

	if err := utility.SaveProfilePic(req.ProfilePic); err != nil {
		slog.Error("Failed to save profile pic", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to save Profile Picture"})
		return
	}

	if err := db.RegisterCoach(c, req); err != nil {
		slog.Error("Failed to register coach", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to register personnel."})
		return
	}
	c.Status(http.StatusOK)
}

func RegisterCoachEdit(c *gin.Context) {
	var req schema.RegisterCoachEditRequest

	if err := c.Bind(&req); err != nil {
		slog.Info("Bad request for edit coach", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad Request"})
		return
	}

	if req.ProfilePic.Size > 10*1024*1024 {
		slog.Info("Profile Pic File size exceeded", "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "File Size exceeded"})
		return
	}

	// IIT - Sport - Player
	req.ProfilePic.Filename = fmt.Sprintf("%s-%s-%s", req.Institute, req.Gender, utility.ToPascalCase(req.FirstName)+utility.ToPascalCase(utility.CoalesceString(req.MiddleName))+utility.ToPascalCase(utility.CoalesceString(req.LastName)))

	if err := utility.SaveProfilePic(req.ProfilePic); err != nil {
		slog.Error("Failed to save profile pic", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to save Profile Picture"})
		return
	}

	if err := db.RegisterCoachEdit(c, req); err != nil {
		slog.Error("Failed to edit coach", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to register personnel."})
		return
	}
	c.Status(http.StatusOK)
}

func GetPlayers(c *gin.Context) {
	var req schema.GetPlayersRequest

	if err := c.Bind(&req); err != nil {
		slog.Info("Bad request for get players", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad Request"})
		return
	}

	data, err := db.GetPlayers(c, req)
	if err != nil {
		slog.Error("Failed to Get players", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to get players."})
		return
	}
	c.JSON(http.StatusOK, data)
}
func GetPlayerCount(c *gin.Context) {
	var req schema.GetPlayerCountRequest

	if err := c.Bind(&req); err != nil {
		slog.Info("Bad request for get player count", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad Request"})
		return
	}

	data, err := db.GetPlayerCount(c, req)
	if err != nil {
		slog.Error("Failed to Get player count", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to get player count."})
		return
	}
	c.JSON(http.StatusOK, data)
}

func RemovePlayer(c *gin.Context) {
	var req schema.RemovePlayerRequest

	removerId, _ := c.Get("userId")

	if err := c.Bind(&req); err != nil {
		slog.Info("Bad request for remove player", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
		return
	}

	if err := db.RemovePlayer(c, req, removerId.(int)); err != nil {
		if err.Error() == "Invalid" {
			c.JSON(http.StatusForbidden, gin.H{"message": "You do not have permission to delete this user"})
			return
		} else {
			slog.Error("Failed to Remove Player", "error", err, "req", c.Request)
			c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to remove player."})
			return
		}
	}

	c.Status(http.StatusOK)
}

func GetPlayerData(c *gin.Context) {
	var req schema.GetPlayerDataRequest

	if err := c.Bind(&req); err != nil {
		slog.Info("Bad request for get player data", "error", err, "req", c.Request)
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad Request"})
		return
	}

	data, err := db.GetPlayerData(c, req)
	if err != nil {
		slog.Error("Failed to Get player Data", "error", err, "req", c.Request)
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to get player data."})
		return
	}
	c.JSON(http.StatusOK, data)
}
