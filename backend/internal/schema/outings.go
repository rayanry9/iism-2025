package schema

import "time"

type OutingRequest struct {
	Reason    string    `json:"reason"`
	EntryTime time.Time `json:"entryTime"`
	ExitTime  time.Time `json:"exitTime"`
}
type GetOutingDataResponse struct {
	OutingId  int       `json:"outingId"`
	Reason    string    `json:"reason"`
	EntryTime time.Time `json:"entryTime"`
	ExitTime  time.Time `json:"exitTime"`
	CreatedAt time.Time `json:"createdAt"`
	FirstName string    `json:"firstName"`
	LastName  string    `json:"lastName"`
	Status    int       `json:"status"`
}
type OutingStatusUpdateRequest struct {
	OutingId int `json:"outingId"`
}
