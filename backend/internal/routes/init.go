package routes

import (
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/controller"
	"github.com/rayanry9/iism-2025/backend/internal/middlewares"
)

func SetupApiRoutes(r *gin.RouterGroup) {
	r.GET("get-pools-by-sport-id", middlewares.CacheHTTP(60*60*6), controller.GetPoolsBySportId)
	// r.POST("update-pool-team", controller.UpdatePoolTeam)
	// r.GET("notify-pool-team-update", controller.PoolTeamUpdateWebsocket)

	r.GET("get-all-institutes", middlewares.CacheHTTP(60*60*12), controller.GetAllInstitutes)
	r.GET("get-all-sports", middlewares.CacheHTTP(60*60*24), controller.GetAllSports)
	r.GET("get-all-athletic-sub-sports-data", middlewares.CacheHTTP(0), controller.GetAllAthleticSubSportsData)
	r.GET("get-all-pools", middlewares.CacheHTTP(60*60*12), controller.GetAllPools)
	r.GET("get-all-pool-teams", middlewares.CacheHTTP(60*60*12), controller.GetAllPoolTeams)

	r.GET("get-all-pool-matches", middlewares.CacheHTTP(60*60*12), controller.GetAllPoolMatches)
	r.GET("get-all-athletic-matches", controller.GetAllAthleticMatches)

	r.POST("login", controller.Login)
	r.POST("logout", middlewares.AuthJWT(), controller.Logout)
	r.GET("me", middlewares.AuthJWT(), middlewares.CacheHTTP(60*5), controller.Me)
	r.POST("register", middlewares.AuthJWT(), controller.RegisterPlayer)
	r.POST("register-edit", middlewares.AuthJWT(), controller.RegisterPlayerEdit)
	r.POST("register-coach", middlewares.AuthJWT(), controller.RegisterCoach)
	r.POST("register-coach-edit", middlewares.AuthJWT(), controller.RegisterCoach)
	r.POST("remove-player", middlewares.AuthJWT(), controller.RemovePlayer)
	r.Static("/profile-pic", "images/users/web").Use(middlewares.CacheHTTP(60 * 1))

	r.Static("/gallery", "images/gallery").Use(middlewares.CacheHTTP(60 * 60 * 24))
	r.GET("/get-gallery-count", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"count": os.Getenv("TOTAL_GALLERY_IMAGES"),
		})
	})

	r.Static("/profile-pic-orig", "images/users/original").Use(middlewares.CacheHTTP(60 * 1))
	r.GET("get-players", middlewares.CacheHTTP(24), controller.GetPlayers)
	r.GET("get-player-data", middlewares.CacheHTTP(24), controller.GetPlayerData)
	r.GET("get-player-count", middlewares.CacheHTTP(24), controller.GetPlayerCount)

}
