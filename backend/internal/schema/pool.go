package schema

type PoolDB struct {
	Id      int    `db:"id"`
	Name    string `db:"name"`
	SportId int    `db:"sport_id"`
}

type GetPoolsBySportIdRequest struct {
	SportId int `form:"sportId"`
}

type PoolTeams struct {
	Id       int     `json:"id"`
	TempName string  `json:"tempName"`
	Name     *string `json:"name"`
}
type GetPoolsBySportIdResponse struct {
	Id    int         `json:"id"`
	Name  string      `json:"name"`
	Teams []PoolTeams `json:"teams"`
}
