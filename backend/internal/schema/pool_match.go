package schema

import (
	"time"
)

type PoolMatchType int
type PoolMatchResult int
type MatchStatus int

const (
	PoolMatchLeague       PoolMatchType = 1
	PoolMatchPreQuarter   PoolMatchType = 2
	PoolMatchQuarterFinal PoolMatchType = 3
	PoolMatchSemiFinal    PoolMatchType = 4
	PoolMatchFinal        PoolMatchType = 5
)

const (
	PoolMatchTeam1Win PoolMatchResult = 1
	PoolMatchTeam2Win PoolMatchResult = 2
	PoolMatchDraw     PoolMatchResult = 3
)

const (
	MatchPending   MatchStatus = 1
	MatchOngoing   MatchStatus = 2
	MatchConcluded MatchStatus = 3
)

func (d PoolMatchType) IsValid() bool {
	return d == 1 || d == 2
}

func (d MatchStatus) IsValid() bool {
	return d == MatchPending || d == MatchConcluded || d == MatchOngoing
}

type PoolMatchDB struct {
	Id             int           `db:"id"`
	Team1TempName  string        `db:"team1_temp_name"`
	Team1Id        *int          `db:"team1_id"`
	Team2TempName  string        `db:"team2_temp_name"`
	Team2Id        *int          `db:"team2_id"`
	Status         MatchStatus   `db:"status"`
	Result         *int          `db:"result"`
	StartTime      time.Time     `db:"start_time"`
	EndTime        *time.Time    `db:"end_time"`
	Venue          *string       `db:"venue"`
	Type           PoolMatchType `db:"type"`
	SportId        int           `db:"sport_id"`
	MatchName      *string       `db:"match_name"`
	LiveStreamLink *string       `db:"live_stream_link"`
	Team1Score     []int         `db:"team1_score"`
	Team1Balls     int           `db:"team1_balls"`
	Team1Wickets   int           `db:"team1_wickets"`
	Team2Score     []int         `db:"team2_score"`
	Team2Balls     int           `db:"team2_balls"`
	Team2Wickets   int           `db:"team2_wickets"`
}

type GetAllPoolMatchesResponse struct {
	Id             int           `json:"id"`
	SportId        int           `json:"sportId"`
	Team1TempName  string        `json:"team1TempName"`
	Team1Id        *int          `json:"team1Id"`
	Team2TempName  string        `json:"team2TempName"`
	Team2Id        *int          `json:"team2Id"`
	Status         MatchStatus   `json:"status"`
	Result         *int          `json:"result"`
	StartTime      time.Time     `json:"startTime"`
	EndTime        *time.Time    `json:"endTime"`
	Venue          *string       `json:"venue"`
	Type           PoolMatchType `json:"type"`
	MatchName      *string       `json:"matchName"`
	LiveStreamLink *string       `json:"liveStreamLink"`
	Team1Score     []int         `json:"team1Score"`
	Team1Balls     int           `json:"team1Balls"`
	Team1Wickets   int           `json:"team1Wickets"`
	Team2Score     []int         `json:"team2Score"`
	Team2Balls     int           `json:"team2Balls"`
	Team2Wickets   int           `json:"team2Wickets"`
}

type UpdatePoolMatchRequest struct {
	Id             int          `form:"id"`
	Status         *MatchStatus `form:"status"`
	Result         *int         `form:"result"`
	LiveStreamLink *string      `form:"liveStreamLink"`
	Team1Score     *[]int       `form:"team1Score"`
	Team1Balls     *int         `form:"team1Balls"`
	Team1Wickets   *int         `form:"team1Wickets"`
	Team2Score     *[]int       `form:"team2Score"`
	Team2Balls     *int         `form:"team2Balls"`
	Team2Wickets   *int         `form:"team2Wickets"`
}
