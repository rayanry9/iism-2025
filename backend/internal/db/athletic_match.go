package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetAllAthleticMatches(c *gin.Context) (*[]schema.GetAllAthleticMatchesResponse, error) {

	rows, err := config.DB.Query(c, `
		SELECT 
		*
		FROM 
		athletic_matches`)
	if err != nil {
		return nil, err
	}
	data, err := pgx.CollectRows(rows, pgx.RowToStructByName[schema.GetAllAthleticMatchesResponse])
	if err != nil {
		return nil, err
	}
	return &data, nil
}
