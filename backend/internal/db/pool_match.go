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
		pm.live_stream_link,
		pm.team1_score, 
		pm.team1_balls, 
		pm.team1_wickets, 
		pm.team2_score, 
		pm.team2_balls, 
		pm.team2_wickets 
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

func UpdatePoolMatch(c *gin.Context, req schema.UpdatePoolMatchRequest) (*schema.GetAllPoolMatchesResponse, error) {

	_, err := config.DB.Exec(c, `
	update pool_matches set 
		team1_score= coalesce($1, team1_score),
		team1_balls= coalesce($2, team1_balls),
		team1_wickets= coalesce($3, team1_wickets),
		team2_score= coalesce($4, team2_score),
		team2_balls= coalesce($5, team2_balls),
		team2_wickets= coalesce($6, team2_wickets),
		result = coalesce($7, result),
		live_stream_link = coalesce($8, live_stream_link),
		status = coalesce($9, status)
	where 
		id = $10
	`, req.Team1Score, req.Team1Balls, req.Team1Wickets, req.Team2Score, req.Team2Balls, req.Team2Wickets, req.Result, req.LiveStreamLink, req.Status, req.Id)

	if err != nil {
		return nil, err
	}

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
		pm.live_stream_link,
		pm.team1_score, 
		pm.team1_balls, 
		pm.team1_wickets, 
		pm.team2_score, 
		pm.team2_balls, 
		pm.team2_wickets 
	FROM 
		pool_matches pm
	where pm.id= $1
	`, req.Id)
	if err != nil {
		return nil, err
	}

	data, err := pgx.CollectOneRow(rows, pgx.RowToStructByName[schema.GetAllPoolMatchesResponse])
	if err != nil {
		return nil, err
	}
	return &data, nil
}
