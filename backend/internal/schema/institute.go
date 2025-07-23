package schema

type InstituteDB struct {
	Id   int    `db:"id"`
	Name string `db:"name"`
}

type GetAllInstitutesResponse struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}
