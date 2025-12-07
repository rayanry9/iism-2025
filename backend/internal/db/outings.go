package db

import (
	"errors"

	"github.com/gin-gonic/gin"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/schema"
)

func MakeOuting(c *gin.Context, userId int, req schema.OutingRequest) error {
	tx, err := config.DB.Begin(c)
	if err != nil {
		return err
	}
	defer tx.Rollback(c)
	var id int
	err = tx.QueryRow(c, `
    INSERT INTO outings (
        user_id,
        entry_time,
        exit_time,
        reason,
        status,
        created_at
    )
    VALUES ($1, $2, $3, $4, $5, NOW())
	returning id
	`, userId, req.EntryTime, req.ExitTime, req.Reason, 0).Scan(&id)
	if err != nil {
		return err
	}
	return tx.Commit(c)
}
func IsCoach(c *gin.Context, userId int) (bool, error) {
	var role int

	err := config.DB.QueryRow(c, `
        SELECT role
        FROM users
        WHERE id = $1
    `, userId).Scan(&role)

	if err != nil {
		return false, err
	}

	return role == int(schema.UserCoach), nil
}
func GetUserInstitute(c *gin.Context, userId int) (int, error) {
	var instituteId int
	err := config.DB.QueryRow(c, `
        SELECT institute_id 
        FROM users 
        WHERE id = $1
    `, userId).Scan(&instituteId)

	return instituteId, err
}
func GetOutingStatusAndInstitute(c *gin.Context, outingId int) (status int, instituteId int, err error) {
	err = config.DB.QueryRow(c, `
        SELECT 
            o.status,
            u.institute_id
        FROM outings o
        JOIN users u ON u.id = o.user_id
        WHERE o.id = $1
    `, outingId).Scan(&status, &instituteId)

	return
}

// Update outing status (0=pending, 1=approved, 2=denied)
func UpdateOutingStatus(c *gin.Context, outingId int, newStatus int) error {
	// just a simple update, controller ensures it's valid
	cmdTag, err := config.DB.Exec(c, `
        UPDATE outings
        SET status = $1
        WHERE id = $2
    `, newStatus, outingId)

	if err != nil {
		return err
	}

	if cmdTag.RowsAffected() == 0 {
		return errors.New("no rows updated")
	}

	return nil
}
func GetAllOutings(c *gin.Context, instituteId int) ([]schema.OutingData, error) {
	rows, err := config.DB.Query(c, `
        SELECT
            o.id,
            o.reason,
            o.entry_time,
            o.exit_time,
            o.created_at,
            o.status,
            u.first_name,
            u.last_name
        FROM outings o
        JOIN users u ON u.id = o.user_id
        WHERE u.institute_id = $1
        ORDER BY o.created_at DESC
    `, instituteId)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	outings := []schema.OutingData{}

	for rows.Next() {
		var o schema.OutingData
		err := rows.Scan(
			&o.OutingId,
			&o.Reason,
			&o.EntryTime,
			&o.ExitTime,
			&o.CreatedAt,
			&o.Status,
			&o.FirstName,
			&o.LastName,
		)
		if err != nil {
			return nil, err
		}
		outings = append(outings, o)
	}

	return outings, nil
}
func GetUserOutings(c *gin.Context, userId int) ([]schema.OutingData, error) {

	rows, err := config.DB.Query(c, `
        SELECT
            o.id,
            o.reason,
            o.entry_time,
            o.exit_time,
            o.created_at,
            o.status,
            u.first_name,
            u.last_name
        FROM outings o
        JOIN users u ON u.id = o.user_id
        WHERE o.user_id = $1
        ORDER BY o.created_at DESC
    `, userId)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	outings := []schema.OutingData{}

	for rows.Next() {
		var o schema.OutingData
		err := rows.Scan(
			&o.OutingId,
			&o.Reason,
			&o.EntryTime,
			&o.ExitTime,
			&o.CreatedAt,
			&o.Status,
			&o.FirstName,
			&o.LastName,
		)
		if err != nil {
			return nil, err
		}

		outings = append(outings, o)
	}

	return outings, nil
}
