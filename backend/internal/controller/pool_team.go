package controller

import (
	"log/slog"
	"net/http"
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
		return origin == "http://localhost:5173"
	},
}

func PoolTeamUpdateWebsocket(c *gin.Context) {
	var req schema.WebsocketPoolTeamUpdateRequest
	if err := c.Bind(&req); err != nil {
		slog.Warn("Bad Request", "err", err)
		c.Status(http.StatusBadRequest)
		return
	}

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
		case id := <-subChan:
			if id == req.SportId {
				if err := conn.WriteMessage(websocket.TextMessage, []byte("update")); err != nil {
					conn.WriteMessage(websocket.CloseMessage, nil)
					conn.Close()
					close(subChan)
					slog.Info("Connection Closed", "err", err)
					return
				}
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

	sportId, err := db.UpdatePoolTeam(c, req)
	if err != nil {
		slog.Warn("Failed to Update", "err", err)
		c.Status(http.StatusInternalServerError)
		return
	}
	utility.PoolBroadcasterInstance.Broadcast(sportId)

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
