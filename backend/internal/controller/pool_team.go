package controller

import (
	"encoding/json"
	"log/slog"
	"net/http"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"github.com/rayanry9/iism-2025/backend/internal/db"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
	"github.com/rayanry9/iism-2025/backend/internal/utility"
)

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool {
		origin := r.Header.Get("Origin")
		return origin == os.Getenv("FRONTEND_URL")
	},
}

func PoolTeamUpdateWebsocket(c *gin.Context) {
	conn, err := upgrader.Upgrade(c.Writer, c.Request, nil)
	if err != nil {
		slog.Warn("Websocket Upgrade", "err", err)
		c.Status(http.StatusInternalServerError)
		return
	}
	defer conn.Close()

	subChan := utility.PoolBroadcasterInstance.Subscribe()
	ticker := time.NewTicker(30 * time.Second)
	for {
		select {
		case data := <-subChan:
			jsonData, err := json.Marshal(data)
			if err != nil {
				conn.WriteMessage(websocket.CloseMessage, nil)
				conn.Close()
				close(subChan)
				slog.Info("Connection Closed", "err", err)
				return
			}
			if err := conn.WriteMessage(websocket.TextMessage, jsonData); err != nil {
				conn.WriteMessage(websocket.CloseMessage, nil)
				conn.Close()
				close(subChan)
				slog.Info("Connection Closed", "err", err)
				return
			}
		case <-ticker.C:
			if err := conn.WriteMessage(websocket.PingMessage, nil); err != nil {
				conn.WriteMessage(websocket.CloseMessage, nil)
				conn.Close()
				close(subChan)
				slog.Info("Connection Closed", "err", err)
				return
			}

		}
	}

}

func UpdatePoolTeam(c *gin.Context) {
	var req schema.UpdatePoolTeamRequest
	if err := c.BindJSON(&req); err != nil {
		slog.Warn("Bad Request", "err", err)
		c.Status(http.StatusBadRequest)
		return
	}
	var data utility.PoolTeamUpdateBroadcastData
	if req.Upcoming {
		data = utility.PoolTeamUpdateBroadcastData{
			PoolTeamId: req.Id,
			Upcoming:   true,
		}

	} else {
		instituteName, err := db.UpdatePoolTeam(c, req)
		if err != nil {
			slog.Warn("Failed to Update", "err", err)
			c.Status(http.StatusInternalServerError)
			return
		}
		data = utility.PoolTeamUpdateBroadcastData{
			InstituteName: instituteName,
			InstituteId:   req.InstituteId,
			PoolTeamId:    req.Id,
			Upcoming:      false,
		}
	}
	utility.PoolBroadcasterInstance.Broadcast(data)
}

func GetAllPoolTeams(c *gin.Context) {
	data, err := db.GetAllPoolTeams(c)
	if err != nil {
		slog.Warn("GetAllPoolTeams", "err", err)
		c.Status(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, data)
}
