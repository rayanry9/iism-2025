DROP TABLE IF EXISTS pool_matches;

CREATE TABLE IF NOT EXISTS pool_matches(
	id SERIAL PRIMARY KEY,
	team1_temp_name TEXT NOT NULL,
	team1_id INT CONSTRAINT fk_pool_match_pool_team_1 REFERENCES pool_teams (id),
	team2_temp_name TEXT NOT NULL,
	team2_id INT CONSTRAINT fk_pool_match_pool_team_2 REFERENCES pool_teams (id),
	status INT NOT NULL,
	result INT,
	sport_id INT CONSTRAINT fk_pool_match_sport REFERENCES sports(id),
	start_time TIMESTAMPTZ NOT NULL,
	end_time TIMESTAMPTZ,
	venue TEXT,
	type SMALLINT NOT NULL,
	match_name TEXT NOT NULL,
	live_stream_link TEXT
);

-- STATUS | 1 -> Upcoming | 2-> Ongoing | 3 -> Done
-- Result | 1 -> team 1 win | 2 -> team 2 win | 3 -> draw
-- type | 1 - > league | 2-> pre quarter | 3 -> quarter final | 4 -> semi final | 5 -> final


CREATE TABLE IF NOT EXISTS athletic_matches(
	id SERIAL PRIMARY KEY,
	sport_id INT NOT NULL CONSTRAINT fk_athletic_match_sport REFERENCES sports(id),
	participants_temp_text TEXT NOT NULL,
	participants INT[], -- Institute Ids 
	start_time TIMESTAMPTZ NOT NULL,
	end_time TIMESTAMPTZ,
	venue TEXT,
	status INT NOT NULL,
	type SMALLINT NOT NULL,
	live_stream_link TEXT
);
-- STATUS | 1 -> Upcoming | 2-> Ongoing | 3 -> Done
-- type | 1 ->heats | 2->quarter Final | 3-> semi final | 4 -> final
