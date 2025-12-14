package schema

type PoolMatchesData struct {
	Id           int   `db:"id"`
	MatchId      int   `db:"match_id"`
	Team1Score   []int `db:"team1_score"`
	Team1Balls   int   `db:"team1_balls"`
	Team1Wickets int   `db:"team1_wickets"`
	Team2Score   []int `db:"team2_score"`
	Team2Balls   int   `db:"team2_balls"`
	Team2Wickets int   `db:"team2_wickets"`
}

type GetPoolMatchDataByIdRequest struct {
	MatchId int `form:"match_id"`
}

type GetPoolMatchDataByIdResponse struct {
	Id           int   `json:"id"`
	MatchId      int   `json:"matchId"`
	Team1Score   []int `json:"team1Score"`
	Team1Balls   int   `json:"team1Balls"`
	Team1Wickets int   `json:"team1Wickets"`
	Team2Score   []int `json:"team2Score"`
	Team2Balls   int   `json:"team2Balls"`
	Team2Wickets int   `json:"team2Wickets"`
}
