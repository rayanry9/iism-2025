package schema

type SportType int

const (
	SportMale                 SportType = 1
	SportFemale               SportType = 2
	SportMixed                SportType = 3
	SportAthleticsMale        SportType = 4
	SportAthleticsFemale      SportType = 5
	SportAthleticsMixed       SportType = 6
	SportAthleticsMaleRelay   SportType = 7
	SportAthleticsFemaleRelay SportType = 8
	SportAthleticsMixedRelay  SportType = 9
)

func (d SportType) IsValid() bool {
	return d > 0 && d < 10
}

type SportDB struct {
	Id    int       `db:"id"`
	Name  string    `db:"name"`
	Staff bool      `db:"staff"`
	Type  SportType `db:"type"`
}

type GetAllSportsResponse struct {
	Id    int       `json:"id"`
	Name  string    `json:"name"`
	Staff bool      `json:"staff"`
	Type  SportType `json:"type"`
}
type GetAllAthleticSubSportDataRequest struct {
	Institute string `form:"institute"`
	SportId   int    `form:"sportId"`
}
type GetAllAthleticSubSportDataResponse struct {
	SportId       int    `json:"sportId"`
	Name          string `json:"name"`
	Type          int    `json:"type"`
	Count         int    `json:"count"`
	ReservedCount int    `json:"reservedCount"`
}
