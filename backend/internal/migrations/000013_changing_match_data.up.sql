alter table pool_matches
	add column team1_score int[] not null default ARRAY[0,0,0,0,0],
	add column team1_balls int not null default 0,
	add column team1_wickets int not null default 0,
	add column team2_score int[] not null default ARRAY[0,0,0,0,0],
	add column team2_balls int not null default 0,
	add column team2_wickets int not null default 0;

update pool_matches pm set team1_score = pmd.team1_score, team1_balls= pmd.team1_balls, team1_wickets= pmd.team1_wickets, team2_score=pmd.team2_score, team2_balls= pmd.team2_balls, team2_wickets= pmd.team2_wickets from pool_matches_data pmd where pmd.match_id = pm.id;
