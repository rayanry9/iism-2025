package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetPoolsBySportId(c *gin.Context, req schema.GetPoolsBySportIdRequest) (*[]schema.GetPoolsBySportIdResponse, error) {
	rows, err := config.DB.Query(c, `
	SELECT 
		p.id,
		p.name,
		ARRAY_AGG(
			json_build_object(
				'id', pt.id,
				'tempName', pt.temp_name,
				'name', i.name
			)
		) FILTER (WHERE pt.id IS NOT NULL) AS teams
	FROM 
		pools p
	LEFT JOIN
		pool_teams pt
		ON pt.pool_id = p.id
	LEFT JOIN
		institutes i
		ON pt.institute_id = i.id
	WHERE 
	 	p.sport_id = $1
	GROUP BY
		p.id, p.name	
	`, req.SportId)
	if err != nil {
		return nil, err
	}

	data, err := pgx.CollectRows(rows, pgx.RowToStructByName[schema.GetPoolsBySportIdResponse])

	if err != nil {
		return nil, err
	}
	return &data, nil

}
