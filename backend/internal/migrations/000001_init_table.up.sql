CREATE TABLE IF NOT EXISTS institutes (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS sports (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	staff BOOL NOT NULL DEFAULT false,
	type SMALLINT NOT NULL
);

-- 1 -> Male 
-- 2 -> Female
-- 3 -> Mixed
-- 4 -> Athletics Male
-- 5 -> Athletics Female
-- 6 -> Athletics Mixed

CREATE TABLE IF NOT EXISTS users (
	id SERIAL PRIMARY KEY,
	first_name TEXT NOT NULL,
	middle_name TEXT,
	last_name TEXT NOT NULL,
	gender TEXT NOT NULL DEFAULT 'Unspecified',
	email TEXT NOT NULL,
	password TEXT NOT NULL,
	profile_pic TEXT
);

CREATE TABLE IF NOT EXISTS players (
	id SERIAL PRIMARY KEY,
	sport_id INT NOT NULL CONSTRAINT fk_player_sport REFERENCES sports(id),
	institute_id INT NOT NULL CONSTRAINT fk_player_institute REFERENCES institutes(id),
	description TEXT
);

CREATE TABLE IF NOT EXISTS admins (
	id SERIAL PRIMARY KEY,
	sport_id INT NOT NULL CONSTRAINT fk_admin_sport REFERENCES sports(id)
);

CREATE TABLE IF NOT EXISTS pools (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	sport_id INT NOT NULL CONSTRAINT fk_pool_sport REFERENCES sports(id)
);

CREATE TABLE IF NOT EXISTS pool_teams (
	id SERIAL PRIMARY KEY,
	temp_name TEXT NOT NULL,
	institute_id INT CONSTRAINT fk_pool_team_institute REFERENCES institutes (id),
	pool_id INT NOT NULL CONSTRAINT fk_pool_team_pool REFERENCES pools(id)
);

CREATE TABLE IF NOT EXISTS pool_matches (
	id SERIAL PRIMARY KEY,
	team1_temp_name TEXT NOT NULL,
	team1_id INT CONSTRAINT fk_pool_match_pool_team_1 REFERENCES pool_teams (id),
	team2_temp_name TEXT NOT NULL,
	team2_id INT CONSTRAINT fk_pool_match_pool_team_2 REFERENCES pool_teams (id),
	status TEXT NOT NULL,
	start_time TIMESTAMPTZ NOT NULL,
	duration INTERVAL,
	end_time TIMESTAMPTZ,
	venue TEXT,
	type SMALLINT NOT NULL,
	match_name TEXT
);

-- 1 -> League
-- 2 -> Normal
