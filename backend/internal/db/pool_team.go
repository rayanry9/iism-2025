package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func UpdatePoolTeam(c *gin.Context, req schema.UpdatePoolTeamRequest) (string, error) {
	_, err := config.DB.Exec(c, `UPDATE pool_teams SET institute_id = $1 WHERE id = $2`, req.InstituteId, req.Id)
	if err != nil {
		return "", err
	}

	var name string
	if err := config.DB.QueryRow(c, `SELECT name FROM institutes WHERE id = $1`, req.InstituteId).Scan(&name); err != nil {
		return "", err
	}
	return name, nil
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
