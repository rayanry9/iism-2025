package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/controller"
)

func SetupApiRoutes(r *gin.RouterGroup) {
	r.GET("get-pools-by-sport-id", controller.GetPoolsBySportId)
	// r.POST("update-pool-team", controller.UpdatePoolTeam)
	// r.GET("notify-pool-team-update", controller.PoolTeamUpdateWebsocket)

	r.GET("get-all-institutes", controller.GetAllInstitutes)
	r.GET("get-all-sports", controller.GetAllSports)
	r.GET("get-all-pools", controller.GetAllPools)
	r.GET("get-all-pool-teams", controller.GetAllPoolTeams)

	r.GET("get-all-pool-matches", controller.GetAllPoolMatches)
	r.GET("get-all-athletic-matches", controller.GetAllAthleticMatches)
}
