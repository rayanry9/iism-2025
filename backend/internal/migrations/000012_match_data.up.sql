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

create or replace function add_cricket_match_data(
	p_match_id int,
	p_team1_score int,
	p_team1_balls int,
	p_team1_wickets int,
	p_team2_score int,
	p_team2_balls int,
	p_team2_wickets int
) returns void 
language plpgsql
as $$
begin
	INSERT INTO pool_matches_data (
		match_id,
		team1_score,
		team1_balls,
		team1_wickets,
		team2_score,
		team2_balls,
		team2_wickets
	) 
	VALUES (
		p_match_id,
		array[p_team1_score,0,0,0,0],
		p_team1_balls,
		p_team1_wickets,
		array[p_team2_score,0,0,0,0],
		p_team2_balls,
		p_team2_wickets
	);
end;
$$;
