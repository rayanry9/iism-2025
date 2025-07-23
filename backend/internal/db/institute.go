package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetAllInstitutes(c *gin.Context) (*[]schema.GetAllInstitutesResponse, error) {
	rows, err := config.DB.Query(c, `SELECT id, name FROM institutes`)
	if err != nil {
		return nil, err
	}
	data, err := pgx.CollectRows(rows, pgx.RowToStructByName[schema.GetAllInstitutesResponse])

	if err != nil {
		return nil, err
	}
	return &data, nil
}
