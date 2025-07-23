package db

import (
	"github.com/gin-gonic/gin"
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
