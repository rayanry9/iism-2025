package schema

type PoolTeamDB struct {
	Id          int    `db:"id"`
	TempName    string `db:"temp_name"`
	InstituteId int    `db:"institute_id"`
	PoolId      int    `db:"pool_id"`
}

type WebsocketPoolTeamUpdateRequest struct {
	SportId int `form:"sportId"`
}

type UpdatePoolTeamRequest struct {
	Id          int `json:"id"`
	InstituteId int `json:"instituteId"`
}
