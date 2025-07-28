package schema

type PoolTeamDB struct {
	Id          int    `db:"id"`
	TempName    string `db:"temp_name"`
	InstituteId *int   `db:"institute_id"`
	PoolId      int    `db:"pool_id"`
}

type UpdatePoolTeamRequest struct {
	Id          int  `json:"id"`
	InstituteId int  `json:"instituteId"`
	Upcoming    bool `json:"upcoming"`
}

type GetAllPoolTeamsResponse struct {
	Id          int    `json:"id"`
	TempName    string `json:"tempName"`
	InstituteId *int   `json:"instituteId"`
	PoolId      int    `json:"poolId"`
}
