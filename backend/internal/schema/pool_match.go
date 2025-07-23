package schema

import "time"

type PoolMatchType int

const (
	PoolMatchLeague PoolMatchType = 1
	PoolMatchNormal PoolMatchType = 2
)

func (d PoolMatchType) IsValid() bool {
	return d == 1 || d == 2
}

type PoolMatchStatus string

const (
	PoolMatchPending   PoolMatchStatus = "Pending"
	PoolMatchOngoing   PoolMatchStatus = "Ongoing"
	PoolMatchConcluded PoolMatchStatus = "Concluded"
)

func (d PoolMatchStatus) IsValid() bool {
	return d == PoolMatchPending || d == PoolMatchConcluded || d == PoolMatchOngoing
}

type PoolMatchDB struct {
	Id            int             `db:"id"`
	Team1TempName string          `db:"team1_temp_name"`
	Team1Id       *int            `db:"team1_id"`
	Team2TempName string          `db:"temp2_temp_name"`
	Team2Id       *int            `db:"team2_id"`
	Status        PoolMatchStatus `db:"status"`
	StartTime     time.Time       `db:"start_time"`
	Duration      *time.Duration  `db:"duration"`
	EndTime       *time.Time      `db:"end_time"`
	Venue         *string         `db:"venue"`
	Type          PoolMatchType   `db:"type"`
	MatchName     *string         `db:"match_name"`
}
