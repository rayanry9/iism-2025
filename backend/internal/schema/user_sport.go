package schema

type UserSportDB struct {
	Id        int     `db:"id"`
	UserId    int     `db:"user_id"`
	SportId   int     `db:"sport_id"`
	Secondary bool    `db:"secondary"`
	Reserve   bool    `db:"reserve"`
	Extra     *string `db:"extra"`
}
