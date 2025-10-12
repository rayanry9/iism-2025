package custom

import (
	"database/sql/driver"
	"encoding/json"
	"strings"
	"time"
)

type Date time.Time

func (t *Date) UnmarshalJSON(b []byte) error {

	layout := "2006-01-02"

	s := strings.Trim(string(b), `" `)
	parsed, err := time.Parse(layout, s)
	if err != nil {
		return err
	}
	*t = Date(parsed)
	return nil
}

func (t Date) MarshalJSON() ([]byte, error) {
	return json.Marshal(time.Time(t).Format("2006-01-02"))
}

func (d *Date) Scan(src any) error {
	*d = Date(src.(time.Time))
	return nil
}

func (d Date) Value() (driver.Value, error) {
	return time.Time(d), nil
}
