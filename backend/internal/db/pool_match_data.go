package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetPoolMatchDataById(c *gin.Context, req schema.GetPoolMatchDataByIdRequest) (*schema.GetPoolMatchDataByIdResponse, error) {
	rows, err := config.DB.Query(c, `select id, team1_score, team1_balls, team1_wickets, team2_score, team2_balls, team2_wickets from pool_matches_data `)
	if err != nil {
		return nil, err
	}
	data, err := pgx.CollectOneRow(rows, pgx.RowToStructByName[schema.GetPoolMatchDataByIdResponse])
	if err != nil {
		if err == pgx.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}
	return &data, nil
}
