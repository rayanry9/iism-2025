package schema

import "time"

type AthleticMatchType int

const (
	AthleticHeats        AthleticMatchType = 1
	AthleticQuarterFinal AthleticMatchType = 2
	AthleticSemiFinal    AthleticMatchType = 3
	AthleticFinal        AthleticMatchType = 4
)

type AthleticMatchDB struct {
	Id                   int               `db:"id"`
	SportId              int               `db:"sport_id"`
	ParticipantsTempText string            `db:"participants_temp_text"`
	Participants         []int             `db:"participants"`
	StartTime            time.Time         `db:"start_time"`
	EndTime              *time.Time        `db:"end_time"`
	Venue                *string           `db:"venue"`
	Status               MatchStatus       `db:"status"`
	Type                 AthleticMatchType `db:"type"`
	LiveStreamLink       *string           `db:"live_stream_link"`
}

type GetAllAthleticMatchesResponse struct {
	Id                   int               `json:"id"`
	SportId              int               `json:"sportId"`
	ParticipantsTempText string            `json:"participantsTempText"`
	Participants         []int             `json:"participants"`
	StartTime            time.Time         `json:"startTime"`
	EndTime              *time.Time        `json:"endTime"`
	Venue                *string           `json:"venue"`
	Status               MatchStatus       `json:"status"`
	Type                 AthleticMatchType `json:"type"`
	LiveStreamLink       *string           `json:"liveStreamLink"`
}
