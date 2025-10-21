package db

import (
	"errors"

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

func GetAllAtheleticSubSportsData(c *gin.Context, req schema.GetAllAthleticSubSportDataRequest) (*[]schema.GetAllAthleticSubSportDataResponse, error) {
	var err error
	var rows pgx.Rows
	switch req.SportId {
	case 0:
		fallthrough
	case -1:
		fallthrough
	case -2:
		rows, err = config.DB.Query(c, `
		with data as (
			select	
				u.id as id, us.secondary, us.reserve, s.name, s.type, s.id as sportId
			from
				users u
			join
				user_sports us
				on us.user_id = u.id
			join
				sports s
				on us.sport_id = s.id
			join 
				institutes i
				on i.id = u.institute_id
			where
				s.type = ANY($1) and i.name ILIKE $2 and not s.staff
		)
		select distinct
			s.id as sportId, s.name, s.type, (select coalesce(count(id),0) from data where not reserve and sportId = s.id) as count, (select coalesce(count(id),0) from data where reserve and sportId = s.id) as reservedCount
		from 
			sports s
		left join
			data d
			on s.id = d.sportId
		where 
			s.type = ANY($1) and not s.staff
		`, []int{req.SportId*-1 + 4, req.SportId*-1 + 7, 6, 9}, req.Institute)
	case -3:
		fallthrough
	case -4:
		fallthrough
	case -5:
		rows, err = config.DB.Query(c, `
		with data as (
			select	
				u.id as id, us.secondary, us.reserve, s.name, s.type, s.id as sportId
			from
				users u
			join
				user_sports us
				on us.user_id = u.id
			join
				sports s
				on us.sport_id = s.id
			join 
				institutes i
				on i.id = u.institute_id
			where
				s.type = ANY($1) and i.name ILIKE $2 and s.staff
		)
		select distinct
			s.id as sportId, s.name, s.type, (select coalesce(count(id),0) from data where not reserve and sportId = s.id) as count, (select coalesce(count(id),0) from data where reserve and sportId = s.id) as reservedCount
		from 
			sports s
		left join
			data d
			on s.id = d.sportId
		where 
			s.type = ANY($1) and s.staff
		`, []int{req.SportId*-1 + 1, req.SportId*-1 + 4, 6, 9}, req.Institute)
	default:
		return nil, errors.New("Wrong sport id for athletics group")
	}
	if err != nil {
		return nil, err
	}
	data, err := pgx.CollectRows(rows, pgx.RowToStructByName[schema.GetAllAthleticSubSportDataResponse])
	return &data, err
}
