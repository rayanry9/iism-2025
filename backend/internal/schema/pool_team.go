package schema

type PoolTeamDB struct {
	Id          int    `db:"id"`
	TempName    string `db:"temp_name"`
	InstituteId *int   `db:"institute_id"`
	PoolId      int    `db:"pool_id"`
}

type WebsocketPoolTeamUpdateRequest struct {
	SportId int `form:"sportId"`
}

type UpdatePoolTeamRequest struct {
	Id          int `json:"id"`
	InstituteId int `json:"instituteId"`
}

type GetAllPoolTeamsResponse struct {
	Id          int    `json:"id"`
	TempName    string `json:"tempName"`
	InstituteId *int   `json:"instituteId"`
	PoolId      int    `json:"poolId"`
}
