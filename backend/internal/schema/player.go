package schema

type PlayerDB struct {
	Id          int     `db:"id"`
	SportId     int     `db:"sport_id"`
	InstituteId int     `db:"institute_id"`
	Description *string `db:"description"`
}
