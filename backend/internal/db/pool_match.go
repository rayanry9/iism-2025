package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetAllPoolMatches(c *gin.Context) (*[]schema.GetAllPoolMatchesResponse, error) {
	rows, err := config.DB.Query(c, `
	SELECT 
		pm.id,
		pm.sport_id,
		pm.team1_temp_name,
		(
			select pt.institute_id
			from pool_teams pt
			join pools p on pt.pool_id = p.id and p.sport_id = pm.sport_id
			where pt.id = pm.team1_id
		) as team1Id,
		pm.team2_temp_name,
		(
			select pt.institute_id
			from pool_teams pt
			join pools p on pt.pool_id = p.id and p.sport_id = pm.sport_id
			where pt.id = pm.team2_id
		) as team2Id,
		pm.status,
		pm.result,
		pm.start_time,
		pm.end_time,
		pm.venue,
		pm.type,
		pm.match_name,
		pm.live_stream_link
	FROM 
		pool_matches pm
	`)
	if err != nil {
		return nil, err
	}

	data, err := pgx.CollectRows(rows, pgx.RowToStructByName[schema.GetAllPoolMatchesResponse])
	if err != nil {
		return nil, err
	}
	return &data, nil
}
