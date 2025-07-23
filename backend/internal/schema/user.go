package schema

type UserGender string

const (
	UserMale        UserGender = "Male"
	UserFemale      UserGender = "Female"
	UserUnspecified UserGender = "Unspecified"
)

type UserDB struct {
	Id         int     `db:"id"`
	FirstName  string  `db:"first_name"`
	MiddleName *string `db:"middle_name"`
	LastName   string  `db:"last_name"`
	Gender     string  `db:"gender"`
	Email      string  `db:"email"`
	Password   string  `db:"password"`
	ProfilePic *string `db:"profile_pic"`
}
