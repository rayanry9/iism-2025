package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func UpdatePoolTeam(c *gin.Context, req schema.UpdatePoolTeamRequest) (int, error) {
	_, err := config.DB.Exec(c, `UPDATE pool_teams SET institute_id = $1 WHERE id = $2`, req.InstituteId, req.Id)
	if err != nil {
		return -1, err
	}

	var sportId int
	if err := config.DB.QueryRow(c, `SELECT s.id FROM pool_teams pt LEFT JOIN pools p ON p.id = pt.pool_id LEFT JOIN sports s ON p.sport_id = s.id WHERE pt.id = $1`, req.Id).Scan(&sportId); err != nil {
		return -1, err
	}
	return sportId, nil
}

func GetAllPoolTeams(c *gin.Context) (*[]schema.GetAllPoolTeamsResponse, error) {
	rows, err := config.DB.Query(c, `SELECT id, temp_name, institute_id, pool_id FROM pool_teams`)
	if err != nil {
		return nil, err
	}
	data, err := pgx.CollectRows(rows, pgx.RowToStructByName[schema.GetAllPoolTeamsResponse])

	if err != nil {
		return nil, err
	}
	return &data, nil
}
