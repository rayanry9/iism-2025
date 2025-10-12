package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetAllSports(c *gin.Context) (*[]schema.GetAllSportsResponse, error) {
	rows, err := config.DB.Query(c, `SELECT id, name, staff, type FROM sports`)
	if err != nil {
		return nil, err
	}
	data, err := pgx.CollectRows(rows, pgx.RowToStructByName[schema.GetAllSportsResponse])

	if err != nil {
		return nil, err
	}
	return &data, nil
}

func GetSportNameFromId(c *gin.Context, sportId int) (name string, err error) {
	err = config.DB.QueryRow(c, `select name from sports where id = $1`, sportId).Scan(&name)
	return
}
