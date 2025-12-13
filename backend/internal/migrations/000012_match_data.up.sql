create table if not exists leaderboards (
	id serial primary key,
	institute_id int not null constraint fk_leaderboard_institute references institutes (id),
	hosting_iit int not null constraint fk_hosting_institute references institutes (id) constraint allowed_hosting_iit check (hosting_iit = ANY(array[10,17,23])),
	points int not null,
	achieved_from text not null,
	staff bool not null default false,
	created_at timestamptz not null default now()
);

create table if not exists pool_matches_data(
		id serial primary key,
		match_id int not null constraint fk_data_match references pool_matches(id),
		team1_score int[] not null default ARRAY[0,0,0,0,0],
		team1_balls int not null default 0,
		team1_wickets int not null default 0,
		team2_score int[] not null default ARRAY[0,0,0,0,0],
		team2_balls int not null default 0,
		team2_wickets int not null default 0
);
