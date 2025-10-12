package db

import (
	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func GetUserDetailFromEmail(c *gin.Context, email string) (id int, password *string, exists bool, err error) {
	err = config.DB.QueryRow(c, `SELECT id, password FROM users WHERE email ILIKE $1`, email).Scan(&id, &password)

	if err == pgx.ErrNoRows {
		return -1, nil, false, nil
	} else if err != nil {
		return
	}
	return id, password, true, nil
}

func GetUserDetails(c *gin.Context, userId int) (schema.GetUserDetailsResponse, error) {
	var data schema.GetUserDetailsResponse
	err := config.DB.QueryRow(c, `
	select 
		u.first_name, 
		u.middle_name, 
		u.last_name, 
		u.gender, 
		u.email, 
		u.profile_pic, 
		u.contact_no, 
		emergency_contact_no, 
		u.blood_group, 
		u.food_preference, 
		u.hostel, 
		u.check_in_date, 
		u.check_out_date, 
		u.role, 
		u.assigned_id, 
		i.name, 
		json_agg(
			json_build_object(
				'sportId',us.sport_id,
				'secondary', us.secondary,
				'reserver', us.reserve,
				'extra', us.extra
			)
		) 
			FILTER ( 
				WHERE us.sport_id IS NOT NULL 
			) 
		from 
			users u 
		left join 
			user_sports us 
			on us.user_id = u.id 
		join 
			institutes i 
			on i.id = u.institute_id 
		where 
			u.id = $1 
		group by 
			u.id, i.id`, userId).Scan(&data.FirstName, &data.MiddleName, &data.LastName, &data.Gender, &data.Email, &data.ProfilePic, &data.ContactNo, &data.EmergencyContactNo, &data.BloodGroup, &data.FoodPreference, &data.Hostel, &data.CheckInDate, &data.CheckOutDate, &data.Role, &data.AssignedId, &data.Institute, &data.Sports)
	return data, err
}

func RegisterPlayer(c *gin.Context, req schema.RegisterPlayerRequest, sports []schema.RegisterPlayerSportData) error {
	tx, err := config.DB.Begin(c)
	if err != nil {
		return err
	}
	defer tx.Rollback(c)

	var userId int
	err = tx.QueryRow(c, `
	insert into 
		users 
			(first_name, middle_name, last_name, gender, email, profile_pic, contact_no, emergency_contact_no, blood_group, food_preference, check_in_date, check_out_date, role, remark, institute_id)
	select	
		$1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, id 
	from 
		institutes
	where 
		name = $15
	returning users.id`, req.FirstName, req.MiddleName, req.LastName, req.Gender, req.Email, req.ProfilePic.Filename, req.ContactNo, req.EmergencyContactNo, req.BloodGroup, req.FoodPreference, req.CheckInDate, req.CheckOutDate, schema.UserPlayer, req.Remark, req.Institute).Scan(&userId)
	if err != nil {
		return err
	}

	for idx := range sports {
		_, err = tx.Exec(c, `insert into user_sports (user_id, sport_id, secondary, reserve, extra) values ($1, $2, $3, $4, $5)`, userId, sports[idx].SportId, sports[idx].Secondary, sports[idx].Reserve, sports[idx].Extra)
		if err != nil {
			return err
		}
	}
	return tx.Commit(c)
}

func GetPlayers(c *gin.Context, req schema.GetPlayersRequest) (*[]schema.GetPlayersResponse, error) {

	rows, err := config.DB.Query(c, `
	select	
		u.id as user_id,
		u.profile_pic,
		u.first_name,
		u.middle_name,
		u.last_name,
		us.extra
	from
		users u
	join
		user_sports us
		on us.user_id = u.id AND NOT (us.secondary OR us.reserve)
	join 
		institutes i
		on i.id = u.institute_id
	where
		us.sport_id = $1 and i.name ILIKE $2
	`, req.SportId, req.Institute)

	if err != nil {
		return nil, err
	}
	data, err := pgx.CollectRows(rows, pgx.RowToStructByName[schema.GetPlayersResponse])
	return &data, err
}
func GetPlayerCount(c *gin.Context, req schema.GetPlayerCountRequest) (*schema.GetPlayerCountResponse, error) {
	var res schema.GetPlayerCountResponse

	err := config.DB.QueryRow(c, `
	select	
		count(u.id) as count
	from
		users u
	join
		user_sports us
		on us.user_id = u.id AND NOT (us.secondary OR us.reserve)
	join 
		institutes i
		on i.id = u.institute_id
	where
		us.sport_id = $1 and i.name ILIKE $2
	`, req.SportId, req.Institute).Scan(&res.Count)

	if err != nil {
		return nil, err
	}
	return &res, err
}
