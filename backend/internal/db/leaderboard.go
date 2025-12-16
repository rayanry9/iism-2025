package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetLeaderboardData(c *gin.Context, req schema.GetLeaderboardDataRequest) (*[]schema.GetLeaderboardDataResponse, error) {
	rows, err := config.DB.Query(c, `select institute_id, hosting_iit, sum(points) as points, array_agg(achieved_from) as achieved_from from leaderboards where staff = $1 group by institute_id, hosting_iit`, req.Staff)
	if err != nil {
		return nil, err
	}
	data, err := pgx.CollectRows(rows, pgx.RowToStructByName[schema.GetLeaderboardDataResponse])
	if err != nil {
		return nil, err
	}
	return &data, nil
}
