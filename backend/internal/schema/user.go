package schema

import (
	"mime/multipart"

	"github.com/rayanry9/iism-2025/backend/internal/custom"
)

type UserGender string
type UserRole int

const (
	UserMale        UserGender = "Male"
	UserFemale      UserGender = "Female"
	UserOthers      UserGender = "Others"
	UserUnspecified UserGender = "Unspecified"
)
const (
	UserNonPlayer              UserRole = 1
	UserPlayer                 UserRole = 2
	UserContingentLeader       UserRole = 3
	UserDeputyContingentLeader UserRole = 4
	UserAdmin                  UserRole = 5
	UserCoach                  UserRole = 6
)

type UserDB struct {
	Id                 int          `db:"id"`
	FirstName          string       `db:"first_name"`
	MiddleName         *string      `db:"middle_name"`
	LastName           *string      `db:"last_name"`
	Gender             string       `db:"gender"`
	Email              *string      `db:"email"`
	Password           *string      `db:"password"`
	ProfilePic         *string      `db:"profile_pic"`
	JerseyNo           *string      `db:"jersey_no"`
	ContactNo          *string      `db:"contact_no"`
	EmergencyContactNo *string      `db:"emergency_contact_no"`
	BloodGroup         *string      `db:"blood_group"`
	FoodPreference     *string      `db:"food_preference"`
	Hostel             *string      `db:"hostel"`
	Designation        *string      `db:"designation"`
	CheckInDate        *custom.Date `db:"check_in_date"`
	CheckOutDate       *custom.Date `db:"check_out_date"`
	Role               UserRole     `db:"role"`
	Staff              bool         `db:"staff"`
	AssignedId         *string      `db:"assigned_id"`
	Remark             *string      `db:"remark"`
	InstituteId        int          `db:"institute_id"`
}

type LoginRequest struct {
	Email    string `form:"email"`
	Password string `form:"password"`
}
type GetUserDetailsRequest struct {
	UserId int `json:"userId"`
}

type GetUserDetailsResponse struct {
	FirstName          string                     `json:"firstName"`
	MiddleName         *string                    `json:"middleName"`
	LastName           *string                    `json:"lastName"`
	Gender             string                     `json:"gender"`
	Email              *string                    `json:"email"`
	ProfilePic         *string                    `json:"profilePic"`
	ContactNo          *string                    `json:"contactNo"`
	EmergencyContactNo *string                    `json:"emergencyContactNo"`
	BloodGroup         *string                    `json:"bloodGroup"`
	JerseyNo           *string                    `json:"jersey_no"`
	Designation        *string                    `json:"designation"`
	FoodPreference     *string                    `json:"foodPreference"`
	Hostel             *string                    `json:"hostel"`
	CheckInDate        *custom.Date               `json:"checkInDate"`
	CheckOutDate       *custom.Date               `json:"checkOutDate"`
	Role               UserRole                   `json:"role"`
	Staff              bool                       `json:"staff"`
	Extra              *string                    `json:"extra"`
	Remark             *string                    `json:"remark"`
	AssignedId         *string                    `json:"assignedId"`
	Institute          string                     `json:"institute"`
	Sports             *[]RegisterPlayerSportData `json:"sports"`
}

type RegisterPlayerRequest struct {
	FirstName          string               `form:"first_name"`
	MiddleName         *string              `form:"middle_name"`
	LastName           *string              `form:"last_name"`
	Gender             string               `form:"gender"`
	Email              string               `form:"email"`
	ProfilePic         multipart.FileHeader `form:"profile_pic"`
	ContactNo          string               `form:"contact_no"`
	EmergencyContactNo string               `form:"emergency_contact_no"`
	JerseyNo           string               `form:"jersey"`
	BloodGroup         string               `form:"blood_group"`
	FoodPreference     string               `form:"food_preference"`
	CheckInDate        string               `form:"check_in_date" json:"check_in_date"`
	CheckOutDate       string               `form:"check_out_date" json:"check_out_date"`
	Remark             *string              `form:"remark"`
	Institute          string               `form:"institute"`
	Sports             string               `form:"sports"`
	Staff              bool                 `form:"staff"`
}

type RegisterPlayerSportData struct {
	SportId   int     `json:"sportId"`
	Secondary bool    `json:"secondary"`
	Reserve   bool    `json:"reserve"`
	Extra     *string `json:"extra"`
}

type RegisterPlayerEditRequest struct {
	UserId             int                  `form:"user_id"`
	FirstName          string               `form:"first_name"`
	MiddleName         *string              `form:"middle_name"`
	LastName           *string              `form:"last_name"`
	Gender             string               `form:"gender"`
	Email              string               `form:"email"`
	ProfilePic         multipart.FileHeader `form:"profile_pic"`
	ContactNo          string               `form:"contact_no"`
	EmergencyContactNo string               `form:"emergency_contact_no"`
	JerseyNo           string               `form:"jersey"`
	BloodGroup         string               `form:"blood_group"`
	FoodPreference     string               `form:"food_preference"`
	CheckInDate        string               `form:"check_in_date" json:"check_in_date"`
	CheckOutDate       string               `form:"check_out_date" json:"check_out_date"`
	Remark             *string              `form:"remark"`
	Institute          string               `form:"institute"`
	Sports             string               `form:"sports"`
	Staff              bool                 `form:"staff"`
}

type RegisterCoachRequest struct {
	FirstName          string               `form:"first_name"`
	MiddleName         *string              `form:"middle_name"`
	LastName           *string              `form:"last_name"`
	Gender             string               `form:"gender"`
	Email              string               `form:"email"`
	ProfilePic         multipart.FileHeader `form:"profile_pic"`
	ContactNo          string               `form:"contact_no"`
	EmergencyContactNo string               `form:"emergency_contact_no"`
	BloodGroup         string               `form:"blood_group"`
	Designation        string               `form:"designation"`
	FoodPreference     string               `form:"food_preference"`
	CheckInDate        string               `form:"check_in_date" json:"check_in_date"`
	CheckOutDate       string               `form:"check_out_date" json:"check_out_date"`
	Remark             *string              `form:"remark"`
	Institute          string               `form:"institute"`
	Staff              bool                 `form:"staff"`
}
type RegisterCoachEditRequest struct {
	UserId             int                  `form:"user_id"`
	FirstName          string               `form:"first_name"`
	MiddleName         *string              `form:"middle_name"`
	LastName           *string              `form:"last_name"`
	Gender             string               `form:"gender"`
	Email              string               `form:"email"`
	ProfilePic         multipart.FileHeader `form:"profile_pic"`
	ContactNo          string               `form:"contact_no"`
	EmergencyContactNo string               `form:"emergency_contact_no"`
	BloodGroup         string               `form:"blood_group"`
	Designation        string               `form:"designation"`
	FoodPreference     string               `form:"food_preference"`
	CheckInDate        string               `form:"check_in_date" json:"check_in_date"`
	CheckOutDate       string               `form:"check_out_date" json:"check_out_date"`
	Remark             *string              `form:"remark"`
	Institute          string               `form:"institute"`
	Staff              bool                 `form:"staff"`
}

type GetPlayersRequest struct {
	SportId   int    `form:"sport_id"`
	Institute string `form:"institute"`
}
type GetPlayerCountRequest struct {
	SportId   int    `form:"sport_id"`
	Institute string `form:"institute"`
}
type GetPlayerCountResponse struct {
	SportId        int `json:"sportId"`
	Count          int `json:"count"`
	SecondaryCount int `json:"secondaryCount"`
	ReserveCount   int `json:"reserveCount"`
}

type GetPlayersResponse struct {
	UserId     int     `json:"userId"`
	ProfilePic string  `json:"profilePic"`
	FirstName  string  `json:"firstName"`
	MiddleName *string `json:"middleName"`
	LastName   *string `json:"lastName"`
	Extra      *string `json:"extra"`
	IsPrimary  bool    `json:"isPrimary"`
}

type RemovePlayerRequest struct {
	UserId int `json:"userId"`
}

type GetPlayerDataRequest struct {
	UserId int `form:"id"`
}

type GetPlayerDataResponse struct {
	FirstName          string      `json:"firstName"`
	MiddleName         *string     `json:"middleName"`
	LastName           *string     `json:"lastName"`
	Gender             string      `json:"gender"`
	Email              string      `json:"email"`
	ProfilePic         string      `json:"profilePic"`
	ContactNo          string      `json:"contactNo"`
	EmergencyContactNo string      `json:"emergencyContactNo"`
	BloodGroup         string      `json:"bloodGroup"`
	JerseyNo           *string     `json:"jersey"`
	Designation        *string     `json:"designation"`
	FoodPreference     string      `json:"foodPreference"`
	CheckInDate        custom.Date `json:"checkInDate" `
	CheckOutDate       custom.Date `json:"checkOutDate"`
	Remark             *string     `json:"remark"`
	Sports             []struct {
		SportId   int     `json:"sportId"`
		Secondary bool    `json:"secondary"`
		Reserve   bool    `json:"reserve"`
		Extra     *string `json:"extra"`
	} `json:"sports"`
}
