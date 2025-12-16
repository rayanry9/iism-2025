package schema

import "time"

type Leaderboard struct {
	Id           int       `db:"id"`
	InstituteId  int       `db:"institute_id"`
	HostingIIT   int       `db:"hosting_iit"`
	Points       int       `db:"points"`
	AchievedFrom string    `db:"achieved_from"`
	Staff        bool      `db:"staff"`
	CreatedAt    time.Time `db:"created_at"`
}

type GetLeaderboardDataRequest struct {
	Staff bool `form:"staff"`
}

type GetLeaderboardDataResponse struct {
	InstituteId  int      `json:"instituteId"`
	HostingIIT   int      `json:"hostingIIT"`
	Points       int      `json:"points"`
	AchievedFrom []string `json:"achievedFrom"`
}
