package schema

type SportType int

const (
	SportMale            SportType = 1
	SportFemale          SportType = 2
	SportMixed           SportType = 3
	SportAthleticsMale   SportType = 4
	SportAthleticsFemale SportType = 5
	SportAthleticsMixed  SportType = 6
)

func (d SportType) IsValid() bool {
	return d > 0 && d < 7
}

type SportDB struct {
	Id    int       `db:"id"`
	Name  string    `db:"name"`
	Staff bool      `db:"staff"`
	Type  SportType `db:"type"`
}
