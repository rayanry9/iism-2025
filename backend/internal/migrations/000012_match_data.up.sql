create table if not exists pool_match_data (
	id serial primary key,
	match_id int not null constraint fk_data_match references pool_matches(id),
	type int not null,
	data jsonb not null,
	created_at timestamptz not null default now()
);

-- type 1-20 -> common
-- 1 -> score
-- 2 -> lineup
-- type 21-50 -> cricket
-- 21 -> balls
-- type 51-60 -> football
-- 51 -> half
-- type 61-70 -> hockey
-- type 71-80 -> volleyball 

create table if not exists leaderboards (
	id serial primary key,
	institute_id int not null constraint fk_leaderboard_institute references institutes (id),
	hosting_iit int not null constraint fk_hosting_institute references institutes (id) constraint allowed_hosting_iit check (hosting_iit = ANY(array[10,17,23])),
	points int not null,
	achieved_from text not null,
	staff bool not null default false,
	created_at timestamptz not null default now()
);
