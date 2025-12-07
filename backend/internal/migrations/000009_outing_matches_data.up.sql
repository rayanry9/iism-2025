create table if not exists outings (
	id serial primary key,
	user_id int not null constraint fk_outing_user references users(id),
	entry_time timestamp not null,
	exit_time timestamp not null,
	reason text not null,
	status smallint not null default 0 CHECK (status = any(array[0,1,2])),
	created_at timestamp not null default now()
);
-- status 0-> init
-- 				1-> approved
-- 				2-> denied

create table if not exists outing_logs (
	id serial primary key,
	is_entry bool not null,
	user_id int not null constraint fk_outing_log_user references users (id),
	created_at timestamp not null default now()
);

create or replace function add_pool_match(
	p_team1_temp text,
	p_team1 text, 
	p_team1_pool text,
	p_team2_temp text,
	p_team2 text, 
	p_team2_pool text,
	p_sport_id int, 
	p_start_time timestamptz, 
	p_venue text, 
	p_match_type int, 
	p_match_name text
) returns void 
language plpgsql
as $$
begin
	INSERT INTO pool_matches (
		team1_temp_name, 
		team1_id, 
		team2_temp_name, 
		team2_id, 
		sport_id, 
		status, 
		start_time, 
		venue, 
		type, 
		match_name) 
	VALUES (
		p_team1_temp, (
			select 
			pt.id from pool_teams pt 
			join institutes i on i.id = pt.institute_id 
			join pools p on p.id = pt.pool_id and p.sport_id = p_sport_id
			where i.name = p_team1 and p.name = p_team1_pool 
		), 
		p_team2_temp, (
			select 
			pt.id from pool_teams pt 
			join institutes i on i.id = pt.institute_id 
			join pools p on p.id = pt.pool_id and p.sport_id = p_sport_id
			where i.name = p_team2 and p.name = p_team2_pool
		), 
		p_sport_id, 1, 
		p_start_time, 
		p_venue, p_match_type, p_match_name
	);
end;
$$;

create or replace function add_athletic_match(
	p_sport_id int, 
	p_participants_temp_text text,
	p_start_time timestamptz, 
	p_venue text, 
	p_match_type int
) returns void 
language plpgsql
as $$
begin
	if p_participants_temp_text is null then
	INSERT INTO athletic_matches (
		sport_id, 
		participants_temp_text,
		participants,
		status, 
		start_time, 
		venue, 
		type) 
	VALUES (
		p_sport_id,
		'',
		(select array_agg(distinct u.institute_id) filter (where u.id is not null) from users u join user_sports us on us.user_id = u.id and us.sport_id = p_sport_id),
		1, 
		p_start_time, 
		p_venue, p_match_type
	);
else 
	INSERT INTO athletic_matches (
		sport_id, 
		participants_temp_text,
		participants,
		status, 
		start_time, 
		venue, 
		type) 
	VALUES (
		p_sport_id,
		p_participants_temp_text,
		array[]::int[],
		1, 
		p_start_time, 
		p_venue, p_match_type
	);
	end if;
end;
$$;

-- Athletics Day 1

select add_athletic_match(49, null,    '2025-12-15 07:00 Asia/Kolkata', 'SNCC', 4); -- 1500m Women Final (single)
select add_athletic_match(31, null,    '2025-12-15 07:30 Asia/Kolkata', 'SNCC', 4); -- 1500m Men Final (single)
select add_athletic_match(27, null,    '2025-12-15 08:00 Asia/Kolkata', 'SNCC', 1); -- 100m Men Heats (multiple; heats => NULL)
select add_athletic_match(45, null,    '2025-12-15 08:30 Asia/Kolkata', 'SNCC', 1); -- 100m Women Heats (multiple; heats => NULL)
select add_athletic_match(40, null,    '2025-12-15 09:00 Asia/Kolkata', 'SNCC', 4); -- Pole Vault Men Final (single)
select add_athletic_match(58, null,'2025-12-15 10:00 Asia/Kolkata', 'SNCC', 3); -- 4x400m Relay Mixed Heats / Semi-Final (combined => match_type=3, Pending)

select add_athletic_match(27, 'Pending','2025-12-15 15:30 Asia/Kolkata', 'SNCC', 3); -- 100m Men Semi-Final (multiple => Pending)
select add_athletic_match(45, 'Pending','2025-12-15 16:00 Asia/Kolkata', 'SNCC', 3); -- 100m Women Semi-Final (multiple => Pending)
select add_athletic_match(58, 'Pending','2025-12-15 16:30 Asia/Kolkata', 'SNCC', 4); -- 4x400m Relay Mixed Final (multiple => Pending)
select add_athletic_match(44, null,    '2025-12-15 16:40 Asia/Kolkata', 'SNCC', 4); -- Hammer Throw Men Final (single)


-- Athletic Day 2
select add_athletic_match(27, 'Pending','2025-12-16 08:00 Asia/Kolkata', 'SNCC', 4); -- 100m Men Final (multiple => Pending)
select add_athletic_match(45, 'Pending','2025-12-16 08:30 Asia/Kolkata', 'SNCC', 4); -- 100m Women Final (multiple => Pending)
select add_athletic_match(34, 'Pending','2025-12-16 09:00 Asia/Kolkata', 'SNCC', 3); -- 400m Hurdles Men Heats / Semi-Final (combined => match_type=3, Pending)
select add_athletic_match(57, null,    '2025-12-16 09:30 Asia/Kolkata', 'SNCC', 4); -- Javelin Throw Women Final (single)

select add_athletic_match(28, null,    '2025-12-16 15:30 Asia/Kolkata', 'SNCC', 1); -- 200m Men Heats (multiple; heats => NULL)
select add_athletic_match(46, null,    '2025-12-16 16:00 Asia/Kolkata', 'SNCC', 1); -- 200m Women Heats (multiple; heats => NULL)
select add_athletic_match(42, null,    '2025-12-16 16:20 Asia/Kolkata', 'SNCC', 4); -- Discus Throw Men Final (single)
select add_athletic_match(38, null,    '2025-12-16 16:30 Asia/Kolkata', 'SNCC', 4); -- Long Jump Men Final (single)

-- Athletic Day 3
select add_athletic_match(28, 'Pending','2025-12-17 08:00 Asia/Kolkata', 'SNCC', 3); -- 200m Men Semi-Final (multiple => Pending)
select add_athletic_match(46, 'Pending','2025-12-17 08:30 Asia/Kolkata', 'SNCC', 3); -- 200m Women Semi-Final (multiple => Pending)
select add_athletic_match(56, null,    '2025-12-17 09:00 Asia/Kolkata', 'SNCC', 4); -- Discus Throw Women Final (single)
select add_athletic_match(34, 'Pending','2025-12-17 10:00 Asia/Kolkata', 'SNCC', 4); -- 400m Hurdles Men Final (multiple => Pending)

select add_athletic_match(28, 'Pending','2025-12-17 15:30 Asia/Kolkata', 'SNCC', 4); -- 200m Men Final (multiple => Pending)
select add_athletic_match(46, 'Pending','2025-12-17 16:00 Asia/Kolkata', 'SNCC', 4); -- 200m Women Final (multiple => Pending)
select add_athletic_match(39, null,    '2025-12-17 16:30 Asia/Kolkata', 'SNCC', 4); -- Triple Jump Men Final (single)

-- Athletic Day 4
select add_athletic_match(32, null,    '2025-12-18 07:00 Asia/Kolkata', 'SNCC', 4); -- 5000m Men Final (single)
select add_athletic_match(29, null,    '2025-12-18 08:00 Asia/Kolkata', 'SNCC', 1); -- 400m Men Heats (multiple; heats => NULL)
select add_athletic_match(47, null,    '2025-12-18 08:30 Asia/Kolkata', 'SNCC', 1); -- 400m Women Heats (multiple; heats => NULL)
select add_athletic_match(53, null,    '2025-12-18 09:00 Asia/Kolkata', 'SNCC', 4); -- High Jump Women Final (single)
select add_athletic_match(35, 'Pending','2025-12-18 09:15 Asia/Kolkata', 'SNCC', 3); -- 4x100m Relay Men Heats / Semi-Final (combined => Pending)
select add_athletic_match(51, 'Pending','2025-12-18 09:30 Asia/Kolkata', 'SNCC', 3); -- 4x100m Relay Women Heats / Semi-Final (combined => Pending)

select add_athletic_match(29, 'Pending','2025-12-18 15:30 Asia/Kolkata', 'SNCC', 3); -- 400m Men Semi-Final (multiple => Pending)
select add_athletic_match(47, 'Pending','2025-12-18 16:00 Asia/Kolkata', 'SNCC', 3); -- 400m Women Semi-Final (multiple => Pending)
select add_athletic_match(33, 'Pending','2025-12-18 16:15 Asia/Kolkata', 'SNCC', 3); -- 110m Hurdles Men Heats / Semi-Final (combined => Pending)
select add_athletic_match(50, 'Pending','2025-12-18 16:30 Asia/Kolkata', 'SNCC', 3); -- 100m Hurdles Women Heats / Semi-Final (combined => Pending)
select add_athletic_match(41, null,    '2025-12-18 16:30 Asia/Kolkata', 'SNCC', 4); -- Shot Put Men Final (single)

-- Athletic Day 5 
select add_athletic_match(29, 'Pending','2025-12-19 08:00 Asia/Kolkata', 'SNCC', 4); -- 400m Men Final (multiple => Pending)
select add_athletic_match(47, 'Pending','2025-12-19 08:30 Asia/Kolkata', 'SNCC', 4); -- 400m Women Final (multiple => Pending)
select add_athletic_match(55, null,    '2025-12-19 09:00 Asia/Kolkata', 'SNCC', 4); -- Shot Put Women Final (single)
select add_athletic_match(50, 'Pending','2025-12-19 09:15 Asia/Kolkata', 'SNCC', 4); -- 100m Hurdles Women Final (multiple => Pending)
select add_athletic_match(33, 'Pending','2025-12-19 09:30 Asia/Kolkata', 'SNCC', 4); -- 110m Hurdles Men Final (multiple => Pending)

select add_athletic_match(30, 'Pending','2025-12-19 15:30 Asia/Kolkata', 'SNCC', 3); -- 800m Men Heats / Semi-Final (combined => Pending)
select add_athletic_match(48, 'Pending','2025-12-19 16:00 Asia/Kolkata', 'SNCC', 3); -- 800m Women Heats / Semi-Final (combined => Pending)
select add_athletic_match(35, 'Pending','2025-12-19 16:30 Asia/Kolkata', 'SNCC', 4); -- 4x100m Relay Men Final (multiple => Pending)
select add_athletic_match(51, 'Pending','2025-12-19 17:00 Asia/Kolkata', 'SNCC', 4); -- 4x100m Relay Women Final (multiple => Pending)

-- Athletic 6
select add_athletic_match(36, 'Pending','2025-12-20 08:00 Asia/Kolkata', 'SNCC', 3); -- 4x400m Relay Men Heats / Semi-Final (combined => Pending)
select add_athletic_match(52, 'Pending','2025-12-20 08:30 Asia/Kolkata', 'SNCC', 3); -- 4x400m Relay Women Heats / Semi-Final (combined => Pending)
select add_athletic_match(37, null,    '2025-12-20 09:00 Asia/Kolkata', 'SNCC', 4); -- High Jump Men Final (single)

select add_athletic_match(30, 'Pending','2025-12-20 15:30 Asia/Kolkata', 'SNCC', 4); -- 800m Men Final (multiple => Pending)
select add_athletic_match(48, 'Pending','2025-12-20 16:00 Asia/Kolkata', 'SNCC', 4); -- 800m Women Final (multiple => Pending)
select add_athletic_match(43, null,    '2025-12-20 16:15 Asia/Kolkata', 'SNCC', 4); -- Javelin Throw Men Final (single)
select add_athletic_match(54, null,    '2025-12-20 16:30 Asia/Kolkata', 'SNCC', 4); -- Long Jump Women Final (single)

-- Athletic Day 7
select add_athletic_match(36, 'Pending','2025-12-21 09:00 Asia/Kolkata', 'SNCC', 4); -- 4x400m Relay Men Final (multiple => Pending)
select add_athletic_match(52, 'Pending','2025-12-21 09:30 Asia/Kolkata', 'SNCC', 4); -- 4x400m Relay Women Final (multiple => Pending)


-- Staff Athletic Day 1

-- 5000m Men Final (single)
select add_athletic_match(68, null, '2025-12-24 07:00 Asia/Kolkata', 'SNCC', 4);
-- 5000m 50+ Men Final (single)
select add_athletic_match(61, null, '2025-12-24 07:00 Asia/Kolkata', 'SNCC', 4);
-- 100m Men Heats (multiple: heats => NULL)
select add_athletic_match(63, null, '2025-12-24 08:00 Asia/Kolkata', 'SNCC', 1);
-- 100m Women Heats (multiple: heats => NULL)
select add_athletic_match(76, null, '2025-12-24 08:30 Asia/Kolkata', 'SNCC', 1);
-- 100m 55+ Men Final (single)
select add_athletic_match(60, null, '2025-12-24 09:00 Asia/Kolkata', 'SNCC', 4);
-- 100m 50+ Women Final (single)
select add_athletic_match(62, null, '2025-12-24 09:15 Asia/Kolkata', 'SNCC', 4);
-- High Jump Men Final (single)
select add_athletic_match(70, null, '2025-12-24 09:00 Asia/Kolkata', 'SNCC', 4);

-- Staff Athletic Day 2
-- 800m Men Final (single)
select add_athletic_match(66, null, '2025-12-25 07:00 Asia/Kolkata', 'SNCC', 4);
-- Discus Women Final (single)
select add_athletic_match(82, null, '2025-12-25 07:20 Asia/Kolkata', 'SNCC', 4);
-- Long Jump Women Final (single)
select add_athletic_match(80, null, '2025-12-25 08:00 Asia/Kolkata', 'SNCC', 4);
-- 400m Men Heats (Heats => NULL, event repeats on Day 6 Final)
select add_athletic_match(65, null, '2025-12-25 08:30 Asia/Kolkata', 'SNCC', 1);
-- Discus Men Final (single)
select add_athletic_match(74, null, '2025-12-25 09:00 Asia/Kolkata', 'SNCC', 4);

-- Staff Athletic Day 3
-- Long Jump Men Final (single)
select add_athletic_match(71, null, '2025-12-26 07:00 Asia/Kolkata', 'SNCC', 4);
-- 200m Women Heats (multiple => heats NULL)
select add_athletic_match(77, null, '2025-12-26 07:30 Asia/Kolkata', 'SNCC', 1);
-- 200m Men Heats (multiple => heats NULL)
select add_athletic_match(64, null, '2025-12-26 08:00 Asia/Kolkata', 'SNCC', 1);
-- Shot Put Women Final (single)
select add_athletic_match(81, null, '2025-12-26 08:00 Asia/Kolkata', 'SNCC', 4);
-- Shot Put Men Final (single)
select add_athletic_match(73, null, '2025-12-26 08:30 Asia/Kolkata', 'SNCC', 4);
-- 4x100m Men Heats (multiple => heats NULL)
select add_athletic_match(69, null, '2025-12-26 09:00 Asia/Kolkata', 'SNCC', 1);
-- 4x100m Women Heats (multiple => heats NULL)
select add_athletic_match(79, null, '2025-12-26 09:15 Asia/Kolkata', 'SNCC', 1);

-- Staff Athletic Day 4
-- 1500m Men Final (single)
select add_athletic_match(67, null, '2025-12-27 07:00 Asia/Kolkata', 'SNCC', 4);
-- 100m Men Final (multiple => Final => Pending)
select add_athletic_match(63, 'Pending', '2025-12-27 07:30 Asia/Kolkata', 'SNCC', 4);
-- 100m Women Final (multiple => Pending)
select add_athletic_match(76, 'Pending', '2025-12-27 08:00 Asia/Kolkata', 'SNCC', 4);
-- Javelin Women Final (single)
select add_athletic_match(83, null, '2025-12-27 08:30 Asia/Kolkata', 'SNCC', 4);
-- Javelin Men Final (single)
select add_athletic_match(75, null, '2025-12-27 09:00 Asia/Kolkata', 'SNCC', 4);

-- Staff Athletic Day 5
-- 200m Women Final (multiple => Pending)
select add_athletic_match(77, 'Pending', '2025-12-28 07:00 Asia/Kolkata', 'SNCC', 4);
-- 200m Men Final (multiple => Pending)
select add_athletic_match(64, 'Pending', '2025-12-28 07:30 Asia/Kolkata', 'SNCC', 4);
-- Hammer Throw Men Final (single)
select add_athletic_match(72, null, '2025-12-28 08:00 Asia/Kolkata', 'SNCC', 4);
-- 4x100m Women Final (multiple => Pending)
select add_athletic_match(79, 'Pending', '2025-12-28 08:30 Asia/Kolkata', 'SNCC', 4);
-- 4x100m Men Final (multiple => Pending)
select add_athletic_match(69, 'Pending', '2025-12-28 09:00 Asia/Kolkata', 'SNCC', 4);

-- Staff Athletic Day 6
-- 400m Women Time Trials ("Heats") → match_type = 1, event appears only once => NULL
select add_athletic_match(78, null, '2025-12-29 08:00 Asia/Kolkata', 'SNCC', 4);
-- 400m Men Final (multiple: appeared as Heats on Day 2 => Pending)
select add_athletic_match(65, 'Pending', '2025-12-29 08:30 Asia/Kolkata', 'SNCC', 4);



-- Cricket Day 0
select add_pool_match('', '(BHU) Varanasi', 'A', '', 'Ropar', 'A', 5, '2025-12-13 08:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Madras', 'B', '', 'Bhilai', 'B', 5, '2025-12-13 08:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Delhi', 'D', '', 'Jammu', 'D', 5, '2025-12-13 13:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Gandhinagar', 'C', '', 'Mandi', 'C', 5, '2025-12-13 13:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');


-- Cricket Day 1
select add_pool_match('', 'Guwahati', 'F', '', '(ISM) Dhanbad', 'F', 5, '2025-12-14 08:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool F');
select add_pool_match('', 'Kanpur', 'E', '', 'Goa', 'E', 5, '2025-12-14 08:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool E');
select add_pool_match('', 'Tirupati', 'G', '', 'Indore', 'G', 5, '2025-12-14 08:30:00 Asia/Kolkata', 'Ground 3', 1, 'Pool G');

-- Cricket Day 2
select add_pool_match('', 'Kharagpur', 'G', '', 'Indore', 'G', 5, '2025-12-15 08:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool G');
select add_pool_match('', 'Jodhpur', 'A', '', 'Ropar', 'A', 5, '2025-12-15 08:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool A');
select add_pool_match('', 'Gandhinagar', 'C', '', 'Hyderabad', 'C', 5, '2025-12-15 13:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Roorkee', 'B', '', 'Bhilai', 'B', 5, '2025-12-15 13:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Dharwad', 'D', '', 'Jammu', 'D', 5, '2025-12-15 08:30:00 Asia/Kolkata', 'Ground 3', 1, 'Pool D');
select add_pool_match('', 'Patna', 'E', '', 'Goa', 'E', 5, '2025-12-15 13:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool E');
select add_pool_match('', 'Bhubaneswar', 'F', '', '(ISM) Dhanbad', 'F', 5, '2025-12-15 08:30:00 Asia/Kolkata', 'Ground 4', 1, 'Pool F');

-- Cricket Day 3
select add_pool_match('', 'Madras', 'B', '', 'Roorkee', 'B', 5, '2025-12-16 08:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Delhi', 'D', '', 'Dharwad', 'D', 5, '2025-12-16 08:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');
select add_pool_match('', 'Kanpur', 'E', '', 'Patna', 'E', 5, '2025-12-16 08:30:00 Asia/Kolkata', 'Ground 3', 1, 'Pool E');
select add_pool_match('', 'Guwahati', 'F', '', 'Bhubaneswar', 'F', 5, '2025-12-16 08:30:00 Asia/Kolkata', 'Ground 4', 1, 'Pool F');
select add_pool_match('', 'Hyderabad', 'C', '', 'Mandi', 'C', 5, '2025-12-16 13:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', '(BHU) Varanasi', 'A', '', 'Jodhpur', 'A', 5, '2025-12-16 13:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool A');
select add_pool_match('', 'Kharagpur', 'G', '', 'Tirupati', 'G', 5, '2025-12-16 13:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool G');
select add_pool_match('', 'Bombay', 'H', '', 'Palakkad', 'H', 5, '2025-12-16 13:00:00 Asia/Kolkata', 'Ground 4', 1, 'Pool H');

-- Cricket Day 4
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 5, '2025-12-17 08:30:00 Asia/Kolkata', 'Ground 1', 2, 'PQF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 5, '2025-12-17 08:30:00 Asia/Kolkata', 'Ground 2', 2, 'PQF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 5, '2025-12-17 13:00:00 Asia/Kolkata', 'Ground 1', 2, 'PQF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 5, '2025-12-17 13:00:00 Asia/Kolkata', 'Ground 2', 2, 'PQF4');
select add_pool_match('Winner of Pool E', NULL, null, 'Runner-up of Pool G', NULL, null, 5, '2025-12-17 08:30:00 Asia/Kolkata', 'Ground 3', 2, 'PQF5');
select add_pool_match('Winner of Pool F', NULL, null, 'Runner-up of Pool H', NULL, null, 5, '2025-12-17 08:30:00 Asia/Kolkata', 'Ground 4', 2, 'PQF6');
select add_pool_match('Winner of Pool G', NULL, null, 'Runner-up of Pool E', NULL, null, 5, '2025-12-17 13:00:00 Asia/Kolkata', 'Ground 3', 2, 'PQF7');
select add_pool_match('Winner of Pool H', NULL, null, 'Runner-up of Pool F', NULL, null, 5, '2025-12-17 13:00:00 Asia/Kolkata', 'Ground 4', 2, 'PQF8');


-- Cricket Day 5
select add_pool_match('Winner of PQF1', NULL, null, 'Winner of PQF6', NULL, null, 5, '2025-12-18 08:30:00 Asia/Kolkata', 'Ground 1', 3, 'QF1');
select add_pool_match('Winner of PQF2', NULL, null, 'Winner of PQF5', NULL, null, 5, '2025-12-18 08:30:00 Asia/Kolkata', 'Ground 2', 3, 'QF2');
select add_pool_match('Winner of PQF3', NULL, null, 'Winner of PQF8', NULL, null, 5, '2025-12-18 13:00:00 Asia/Kolkata', 'Ground 1', 3, 'QF3');
select add_pool_match('Winner of PQF4', NULL, null, 'Winner of PQF7', NULL, null, 5, '2025-12-18 13:00:00 Asia/Kolkata', 'Ground 2', 3, 'QF4');

-- Cricket Day 7
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 5, '2025-12-20 08:30:00 Asia/Kolkata', 'Ground 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 5, '2025-12-20 13:00:00 Asia/Kolkata', 'Ground 1', 4, 'SF2');

-- Cricket Day 8
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 5, '2025-12-21 08:30:00 Asia/Kolkata', 'Ground 2', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 5, '2025-12-21 08:30:00 Asia/Kolkata', 'Ground 1', 5, 'FINAL');


-- Football Day 2
select add_pool_match('', 'Kanpur', 'B', '', 'Bhilai', 'B', 7, '2025-12-15 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'C', '', 'Palakkad', 'C', 7, '2025-12-15 08:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Roorkee', 'D', '', 'Patna', 'D', 7, '2025-12-15 09:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Delhi', 'E', '', 'Bhubaneswar', 'E', 7, '2025-12-15 09:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool E');
select add_pool_match('', 'Gandhinagar', 'F', '', 'Indore', 'F', 7, '2025-12-15 16:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool F');
select add_pool_match('', 'Mandi', 'G', '', 'Jodhpur', 'G', 7, '2025-12-15 16:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool G');

-- Football Day 3
select add_pool_match('', 'Ropar', 'B', '', 'Bhilai', 'B', 7, '2025-12-16 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', '(BHU) Varanasi', 'C', '', 'Palakkad', 'C', 7, '2025-12-16 08:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Jammu', 'D', '', 'Patna', 'D', 7, '2025-12-16 09:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Madras', 'E', '', 'Bhubaneswar', 'E', 7, '2025-12-16 09:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool E');
select add_pool_match('', 'Hyderabad', 'F', '', 'Indore', 'F', 7, '2025-12-16 16:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool F');
select add_pool_match('', 'Tirupati', 'G', '', 'Jodhpur', 'G', 7, '2025-12-16 16:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool G');

-- Football Day 4
select add_pool_match('', 'Kharagpur', 'A', '', '(ISM) Dhanbad', 'A', 7, '2025-12-17 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Kanpur', 'B', '', 'Ropar', 'B', 7, '2025-12-17 08:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'C', '', '(BHU) Varanasi', 'C', 7, '2025-12-17 09:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Roorkee', 'D', '', 'Jammu', 'D', 7, '2025-12-17 09:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');
select add_pool_match('', 'Delhi', 'E', '', 'Madras', 'E', 7, '2025-12-17 15:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool E');
select add_pool_match('', 'Mandi', 'G', '', 'Tirupati', 'G', 7, '2025-12-17 15:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool G');
select add_pool_match('', 'Gandhinagar', 'F', '', 'Hyderabad', 'F', 7, '2025-12-17 16:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool F');
select add_pool_match('', 'Guwahati', 'H', '', 'Dharwad', 'H', 7, '2025-12-17 16:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool H');

-- Football Day 5
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 7, '2025-12-18 08:00:00 Asia/Kolkata', 'Ground 2', 2, 'PQF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 7, '2025-12-18 08:00:00 Asia/Kolkata', 'Ground 1', 2, 'PQF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 7, '2025-12-18 09:30:00 Asia/Kolkata', 'Ground 2', 2, 'PQF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 7, '2025-12-18 09:30:00 Asia/Kolkata', 'Ground 1', 2, 'PQF4');
select add_pool_match('Winner of Pool E', NULL, null, 'Runner-up of Pool G', NULL, null, 7, '2025-12-18 15:00:00 Asia/Kolkata', 'Ground 2', 2, 'PQF5');
select add_pool_match('Winner of Pool F', NULL, null, 'Runner-up of Pool H', NULL, null, 7, '2025-12-18 15:00:00 Asia/Kolkata', 'Ground 1', 2, 'PQF6');
select add_pool_match('Winner of Pool G', NULL, null, 'Runner-up of Pool E', NULL, null, 7, '2025-12-18 16:30:00 Asia/Kolkata', 'Ground 2', 2, 'PQF7');
select add_pool_match('Winner of Pool H', NULL, null, 'Runner-up of Pool F', NULL, null, 7, '2025-12-18 16:30:00 Asia/Kolkata', 'Ground 1', 2, 'PQF8');

-- Football Day 6
select add_pool_match('Winner of PQF1', NULL, null, 'Winner of PQF6', NULL, null, 7, '2025-12-19 08:00:00 Asia/Kolkata', 'Ground 1', 3, 'QF1');
select add_pool_match('Winner of PQF2', NULL, null, 'Winner of PQF5', NULL, null, 7, '2025-12-19 09:30:00 Asia/Kolkata', 'Ground 1', 3, 'QF2');
select add_pool_match('Winner of PQF3', NULL, null, 'Winner of PQF8', NULL, null, 7, '2025-12-19 15:00:00 Asia/Kolkata', 'Ground 1', 3, 'QF3');
select add_pool_match('Winner of PQF4', NULL, null, 'Winner of PQF7', NULL, null, 7, '2025-12-19 16:30:00 Asia/Kolkata', 'Ground 1', 3, 'QF4');

-- Football Day 7
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 7, '2025-12-20 08:00:00 Asia/Kolkata', 'Ground 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 7, '2025-12-20 09:30:00 Asia/Kolkata', 'Ground 1', 4, 'SF2');

-- Football Day 8
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 7, '2025-12-21 08:00:00 Asia/Kolkata', 'Ground 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 7, '2025-12-21 09:30:00 Asia/Kolkata', 'Ground 1', 5, 'FINAL');


-- Hockey Day 2
select add_pool_match('', 'Delhi', 'A', '', 'Mandi', 'A', 6, '2025-12-15 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', '(BHU) Varanasi', 'D', '', 'Kanpur', 'D', 6, '2025-12-15 10:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Bombay', 'B', '', 'Jodhpur', 'B', 6, '2025-12-15 13:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Ropar', 'D', '', '(ISM) Dhanbad', 'D', 6, '2025-12-15 15:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');

-- Hockey Day 3
select add_pool_match('', 'Mandi', 'A', '', 'Hyderabad', 'A', 6, '2025-12-16 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', '(ISM) Dhanbad', 'D', '', 'Kanpur', 'D', 6, '2025-12-16 10:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Roorkee', 'C', '', 'Guwahati', 'C', 6, '2025-12-16 13:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', '(BHU) Varanasi', 'D', '', 'Ropar', 'D', 6, '2025-12-16 15:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');

-- Hockey Day 4
select add_pool_match('', '(BHU) Varanasi', 'D', '', '(ISM) Dhanbad', 'D', 6, '2025-12-17 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Bombay', 'B', '', 'Madras', 'B', 6, '2025-12-17 10:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Roorkee', 'C', '', 'Kharagpur', 'C', 6, '2025-12-17 13:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Kanpur', 'D', '', 'Ropar', 'D', 6, '2025-12-17 15:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');

-- Hockey Day 5
select add_pool_match('', 'Delhi', 'A', '', 'Hyderabad', 'A', 6, '2025-12-18 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Jodhpur', 'B', '', 'Madras', 'B', 6, '2025-12-18 10:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Guwahati', 'C', '', 'Kharagpur', 'C', 6, '2025-12-18 14:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');

-- Hockey Day 6
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 6, '2025-12-19 08:00:00 Asia/Kolkata', 'Ground 1', 3, 'QF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 6, '2025-12-19 10:00:00 Asia/Kolkata', 'Ground 1', 3, 'QF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 6, '2025-12-19 13:00:00 Asia/Kolkata', 'Ground 1', 3, 'QF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 6, '2025-12-19 15:30:00 Asia/Kolkata', 'Ground 1', 3, 'QF4');

-- Hockey Day 7
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 6, '2025-12-20 08:00:00 Asia/Kolkata', 'Ground 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 6, '2025-12-20 10:00:00 Asia/Kolkata', 'Ground 1', 4, 'SF2');

-- Hockey Day 8
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 6, '2025-12-21 08:00:00 Asia/Kolkata', 'Ground 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 6, '2025-12-21 10:00:00 Asia/Kolkata', 'Ground 1', 5, 'FINAL');


-- Volleyball Day 2
select add_pool_match('', 'Jodhpur', 'F', '', 'Delhi', 'F', 14, '2025-12-15 09:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool F');
select add_pool_match('', 'Kharagpur', 'G', '', 'Goa', 'G', 14, '2025-12-15 09:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool G');
select add_pool_match('', 'Madras', 'D', '', 'Dharwad', 'D', 14, '2025-12-15 10:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', 'Jammu', 'E', '', 'Patna', 'E', 14, '2025-12-15 10:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool E');
select add_pool_match('', 'Roorkee', 'A', '', 'Kanpur', 'A', 14, '2025-12-15 17:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Hyderabad', 'B', '', 'Palakkad', 'B', 14, '2025-12-15 17:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Bhubaneswar', 'C', '', 'Mandi', 'C', 14, '2025-12-15 18:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool C');

-- Volleyball Day 3
select add_pool_match('', 'Gandhinagar', 'A', '', 'Kanpur', 'A', 14, '2025-12-16 09:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Bombay', 'B', '', 'Palakkad', 'B', 14, '2025-12-16 09:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Tirupati', 'C', '', 'Mandi', 'C', 14, '2025-12-16 11:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool C');
select add_pool_match('', 'Guwahati', 'D', '', 'Dharwad', 'D', 14, '2025-12-16 17:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', '(ISM) Dhanbad', 'E', '', 'Patna', 'E', 14, '2025-12-16 17:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool E');
select add_pool_match('', 'Indore', 'F', '', 'Delhi', 'F', 14, '2025-12-16 18:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool F');
select add_pool_match('', 'Ropar', 'G', '', 'Goa', 'G', 14, '2025-12-16 18:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool G');

-- Volleyball Day 4
select add_pool_match('', 'Jammu', 'E', '', '(ISM) Dhanbad', 'E', 14, '2025-12-17 09:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool E');
select add_pool_match('', 'Jodhpur', 'F', '', 'Indore', 'F', 14, '2025-12-17 09:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool F');
select add_pool_match('', 'Kharagpur', 'G', '', 'Ropar', 'G', 14, '2025-12-17 10:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool G');
select add_pool_match('', '(BHU) Varanasi', 'H', '', 'Bhilai', 'H', 14, '2025-12-17 10:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool H');
select add_pool_match('', 'Bhubaneswar', 'C', '', 'Tirupati', 'C', 14, '2025-12-17 16:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool C');
select add_pool_match('', 'Madras', 'D', '', 'Guwahati', 'D', 14, '2025-12-17 16:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');
select add_pool_match('', 'Roorkee', 'A', '', 'Gandhinagar', 'A', 14, '2025-12-17 18:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Hyderabad', 'B', '', 'Bombay', 'B', 14, '2025-12-17 18:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');

-- Volleyball Day 5
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 14, '2025-12-18 09:00:00 Asia/Kolkata', 'Court 1', 2, 'PQF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 14, '2025-12-18 09:00:00 Asia/Kolkata', 'Court 2', 2, 'PQF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 14, '2025-12-18 10:30:00 Asia/Kolkata', 'Court 1', 2, 'PQF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 14, '2025-12-18 10:30:00 Asia/Kolkata', 'Court 2', 2, 'PQF4');
select add_pool_match('Winner of Pool E', NULL, null, 'Runner-up of Pool G', NULL, null, 14, '2025-12-18 17:00:00 Asia/Kolkata', 'Court 1', 2, 'PQF5');
select add_pool_match('Winner of Pool F', NULL, null, 'Runner-up of Pool H', NULL, null, 14, '2025-12-18 17:00:00 Asia/Kolkata', 'Court 2', 2, 'PQF6');
select add_pool_match('Winner of Pool G', NULL, null, 'Runner-up of Pool E', NULL, null, 14, '2025-12-18 18:30:00 Asia/Kolkata', 'Court 1', 2, 'PQF7');
select add_pool_match('Winner of Pool H', NULL, null, 'Runner-up of Pool F', NULL, null, 14, '2025-12-18 18:30:00 Asia/Kolkata', 'Court 2', 2, 'PQF8');

-- Volleyball Day 6
select add_pool_match('Winner of PQF1', NULL, null, 'Winner of PQF6', NULL, null, 14, '2025-12-19 10:00:00 Asia/Kolkata', 'Court 1', 3, 'QF1');
select add_pool_match('Winner of PQF2', NULL, null, 'Winner of PQF5', NULL, null, 14, '2025-12-19 10:00:00 Asia/Kolkata', 'Court 2', 3, 'QF2');
select add_pool_match('Winner of PQF3', NULL, null, 'Winner of PQF8', NULL, null, 14, '2025-12-19 17:00:00 Asia/Kolkata', 'Court 1', 3, 'QF3');
select add_pool_match('Winner of PQF4', NULL, null, 'Winner of PQF7', NULL, null, 14, '2025-12-19 17:00:00 Asia/Kolkata', 'Court 2', 3, 'QF4');


-- Volleyball Day 7
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 14, '2025-12-20 10:00:00 Asia/Kolkata', 'Court 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 14, '2025-12-20 17:00:00 Asia/Kolkata', 'Court 1', 4, 'SF2');

-- Volleyball Day 8
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 14, '2025-12-21 10:30:00 Asia/Kolkata', 'Court 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 14, '2025-12-21 10:30:00 Asia/Kolkata', 'Court 2', 5, 'Final');


-- Volleyball Women Day 1
select add_pool_match('', 'Kanpur', 'E', '', 'Jammu', 'E', 15, '2025-12-15 09:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool E');
select add_pool_match('', 'Bhubaneswar', 'G', '', 'Gandhinagar', 'G', 15, '2025-12-15 09:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool G');
select add_pool_match('', 'Roorkee', 'D', '', 'Mandi', 'D', 15, '2025-12-15 11:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool D');
select add_pool_match('', 'Jodhpur', 'C', '', 'Bhilai', 'C', 15, '2025-12-15 11:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool C');
select add_pool_match('', 'Delhi', 'B', '', 'Patna', 'B', 15, '2025-12-15 17:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool B');
select add_pool_match('', 'Madras', 'F', '', '(ISM) Dhanbad', 'F', 15, '2025-12-15 17:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool F');

-- Volleyball Women Day 2
select add_pool_match('', 'Tirupati', 'B', '', 'Patna', 'B', 15, '2025-12-16 09:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool B');
select add_pool_match('', 'Guwahati', 'C', '', 'Bhilai', 'C', 15, '2025-12-16 09:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool C');
select add_pool_match('', 'Dharwad', 'E', '', 'Jammu', 'E', 15, '2025-12-16 11:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool E');
select add_pool_match('', 'Palakkad', 'F', '', '(ISM) Dhanbad', 'F', 15, '2025-12-16 11:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool F');
select add_pool_match('', 'Indore', 'G', '', 'Gandhinagar', 'G', 15, '2025-12-16 17:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool G');
select add_pool_match('', 'Kharagpur', 'D', '', 'Mandi', 'D', 15, '2025-12-16 17:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');

-- Volleyball Women Day 3
select add_pool_match('', 'Delhi', 'B', '', 'Tirupati', 'B', 15, '2025-12-17 09:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool B');
select add_pool_match('', 'Bhubaneswar', 'G', '', 'Indore', 'G', 15, '2025-12-17 09:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool G');
select add_pool_match('', 'Roorkee', 'D', '', 'Kharagpur', 'D', 15, '2025-12-17 11:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool D');
select add_pool_match('', 'Madras', 'F', '', 'Palakkad', 'F', 15, '2025-12-17 11:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool F');
select add_pool_match('', 'Jodhpur', 'C', '', 'Guwahati', 'C', 15, '2025-12-17 16:30:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Bombay', 'H', '', 'Hyderabad', 'H', 15, '2025-12-17 16:30:00 Asia/Kolkata', 'Court 4', 1, 'Pool H');
select add_pool_match('', 'Kanpur', 'E', '', 'Dharwad', 'E', 15, '2025-12-17 18:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool E');
select add_pool_match('', '(BHU) Varanasi', 'A', '', 'Ropar', 'A', 15, '2025-12-17 18:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool A');

-- Volleyball Women Day 4
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 15, '2025-12-18 09:00:00 Asia/Kolkata', 'Court 3', 2, 'PQF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 15, '2025-12-18 09:00:00 Asia/Kolkata', 'Court 4', 2, 'PQF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 15, '2025-12-18 11:00:00 Asia/Kolkata', 'Court 3', 2, 'PQF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 15, '2025-12-18 11:00:00 Asia/Kolkata', 'Court 4', 2, 'PQF4');
select add_pool_match('Winner of Pool E', NULL, null, 'Runner-up of Pool G', NULL, null, 15, '2025-12-18 16:30:00 Asia/Kolkata', 'Court 3', 2, 'PQF5');
select add_pool_match('Winner of Pool F', NULL, null, 'Runner-up of Pool H', NULL, null, 15, '2025-12-18 16:30:00 Asia/Kolkata', 'Court 4', 2, 'PQF6');
select add_pool_match('Winner of Pool G', NULL, null, 'Runner-up of Pool E', NULL, null, 15, '2025-12-18 18:00:00 Asia/Kolkata', 'Court 3', 2, 'PQF7');
select add_pool_match('Winner of Pool H', NULL, null, 'Runner-up of Pool F', NULL, null, 15, '2025-12-18 18:00:00 Asia/Kolkata', 'Court 4', 2, 'PQF8');

-- Volleyball Women Day 5
select add_pool_match('Winner of PQF1', NULL, null, 'Winner of PQF6', NULL, null, 15, '2025-12-19 10:00:00 Asia/Kolkata', 'Court 3', 3, 'QF1');
select add_pool_match('Winner of PQF2', NULL, null, 'Winner of PQF5', NULL, null, 15, '2025-12-19 10:00:00 Asia/Kolkata', 'Court 4', 3, 'QF2');
select add_pool_match('Winner of PQF3', NULL, null, 'Winner of PQF8', NULL, null, 15, '2025-12-19 17:00:00 Asia/Kolkata', 'Court 3', 3, 'QF3');
select add_pool_match('Winner of PQF4', NULL, null, 'Winner of PQF7', NULL, null, 15, '2025-12-19 17:00:00 Asia/Kolkata', 'Court 4', 3, 'QF4');

-- Volleyball Women Day 6
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 15, '2025-12-20 10:00:00 Asia/Kolkata', 'Court 3', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 15, '2025-12-20 17:00:00 Asia/Kolkata', 'Court 3', 4, 'SF2');

-- Volleyball Women Day 7
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 15, '2025-12-21 09:00:00 Asia/Kolkata', 'Court 3', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 15, '2025-12-21 09:00:00 Asia/Kolkata', 'Court 4', 5, 'Final');



-- Staff Badminton Men Day 1
select add_pool_match('', '(BHU) Varanasi', 'B', '', 'Palakkad', 'B', 16, '2025-12-24 08:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Dharwad', 'C', '', 'Bhilai', 'C', 16, '2025-12-24 08:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Delhi', 'D', '', 'Jammu', 'D', 16, '2025-12-24 09:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', '(ISM) Dhanbad', 'E', '', 'Ropar', 'E', 16, '2025-12-24 09:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool E');
select add_pool_match('', 'Indore', 'F', '', 'Gandhinagar', 'F', 16, '2025-12-24 11:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool F');
select add_pool_match('', 'Jodhpur', 'G', '', 'Kanpur', 'G', 16, '2025-12-24 11:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool G');
select add_pool_match('', 'Kharagpur', 'A', '', 'Madras', 'A', 16, '2025-12-24 12:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');


-- Staff Badminton Men Day 2
select add_pool_match('', '(BHU) Varanasi', 'B', '', 'Goa', 'B', 16, '2025-12-25 08:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Dharwad', 'C', '', 'Mandi', 'C', 16, '2025-12-25 08:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Delhi', 'D', '', 'Roorkee', 'D', 16, '2025-12-25 09:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', '(ISM) Dhanbad', 'E', '', 'Bhubaneswar', 'E', 16, '2025-12-25 09:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool E');
select add_pool_match('', 'Indore', 'F', '', 'Patna', 'F', 16, '2025-12-25 11:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool F');
select add_pool_match('', 'Jodhpur', 'G', '', 'Hyderabad', 'G', 16, '2025-12-25 11:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool G');
select add_pool_match('', 'Kharagpur', 'A', '', 'Tirupati', 'A', 16, '2025-12-25 12:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');

-- Staff Badminton Men Day 3
select add_pool_match('', 'Palakkad', 'B', '', 'Goa', 'B', 16, '2025-12-26 08:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Bhilai', 'C', '', 'Mandi', 'C', 16, '2025-12-26 08:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Jammu', 'D', '', 'Roorkee', 'D', 16, '2025-12-26 09:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', 'Ropar', 'E', '', 'Bhubaneswar', 'E', 16, '2025-12-26 09:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool E');
select add_pool_match('', 'Gandhinagar', 'F', '', 'Patna', 'F', 16, '2025-12-26 11:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool F');
select add_pool_match('', 'Kanpur', 'G', '', 'Hyderabad', 'G', 16, '2025-12-26 11:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool G');
select add_pool_match('', 'Tirupati', 'A', '', 'Madras', 'A', 16, '2025-12-26 12:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Bombay', 'H', '', 'Guwahati', 'H', 16, '2025-12-26 12:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool H');

-- Staff Badminton Men Day 4
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 16, '2025-12-27 08:00:00 Asia/Kolkata', 'Court 1', 2, 'PQF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 16, '2025-12-27 08:00:00 Asia/Kolkata', 'Court 2', 2, 'PQF2'); 
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 16, '2025-12-27 09:30:00 Asia/Kolkata', 'Court 1', 2, 'PQF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 16, '2025-12-27 09:30:00 Asia/Kolkata', 'Court 2', 2, 'PQF4');
select add_pool_match('Winner of Pool E', NULL, null, 'Runner-up of Pool G', NULL, null, 16, '2025-12-27 11:00:00 Asia/Kolkata', 'Court 1', 2, 'PQF5');
select add_pool_match('Winner of Pool F', NULL, null, 'Runner-up of Pool H', NULL, null, 16, '2025-12-27 11:00:00 Asia/Kolkata', 'Court 2', 2, 'PQF6');
select add_pool_match('Winner of Pool G', NULL, null, 'Runner-up of Pool E', NULL, null, 16, '2025-12-27 00:30:00 Asia/Kolkata', 'Court 1', 2, 'PQF7');
select add_pool_match('Winner of Pool H', NULL, null, 'Runner-up of Pool F', NULL, null, 16, '2025-12-27 00:30:00 Asia/Kolkata', 'Court 2', 2, 'PQF8');

-- Staff Badminton Men Day 5
select add_pool_match('Winner of PQF1', NULL, null, 'Winner of PQF6', NULL, null, 16, '2025-12-28 08:00:00 Asia/Kolkata', 'Court 1', 3, 'QF1');
select add_pool_match('Winner of PQF2', NULL, null, 'Winner of PQF5', NULL, null, 16, '2025-12-28 08:00:00 Asia/Kolkata', 'Court 2', 3, 'QF2');
select add_pool_match('Winner of PQF3', NULL, null, 'Winner of PQF8', NULL, null, 16, '2025-12-28 09:30:00 Asia/Kolkata', 'Court 1', 3, 'QF3');
select add_pool_match('Winner of PQF4', NULL, null, 'Winner of PQF7', NULL, null, 16, '2025-12-28 09:30:00 Asia/Kolkata', 'Court 2', 3, 'QF4');
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 16, '2025-12-28 16:00:00 Asia/Kolkata', 'Court 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 16, '2025-12-28 16:00:00 Asia/Kolkata', 'Court 2', 4, 'SF2');

-- Staff Badminton Men Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 16, '2025-12-29 09:30:00 Asia/Kolkata', 'Court 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 16, '2025-12-29 09:30:00 Asia/Kolkata', 'Court 2', 5, 'Final');


-- Staff Badminton Women Day 1
select add_pool_match('', 'Kanpur', 'A', '', 'Hyderabad', 'A', 17, '2025-12-24 08:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Mandi', 'B', '', 'Patna', 'B', 17, '2025-12-24 08:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'C', '', '(ISM) Dhanbad', 'C', 17, '2025-12-24 09:30:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Madras', 'D', '', 'Bhilai', 'D', 17, '2025-12-24 09:30:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');
select add_pool_match('', 'Ropar', 'A', '', 'Gandhinagar', 'A', 17, '2025-12-24 11:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool A');
select add_pool_match('', 'Guwahati', 'B', '', '(BHU) Varanasi', 'B', 17, '2025-12-24 11:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool B');
select add_pool_match('', 'Tirupati', 'C', '', 'Indore', 'C', 17, '2025-12-24 12:30:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Kharagpur', 'D', '', 'Delhi', 'D', 17, '2025-12-24 12:30:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');
select add_pool_match('', 'Madras', 'D', '', 'Roorkee', 'D', 17, '2025-12-24 20:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');

-- Staff Badminton Women Day 2
select add_pool_match('', 'Kanpur', 'A', '', 'Gandhinagar', 'A', 17, '2025-12-25 08:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool A');
select add_pool_match('', 'Mandi', 'B', '', '(BHU) Varanasi', 'B', 17, '2025-12-25 08:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'C', '', 'Indore', 'C', 17, '2025-12-25 09:30:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Madras', 'D', '', 'Delhi', 'D', 17, '2025-12-25 09:30:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');
select add_pool_match('', 'Ropar', 'A', '', 'Hyderabad', 'A', 17, '2025-12-25 11:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool A');
select add_pool_match('', 'Guwahati', 'B', '', 'Patna', 'B', 17, '2025-12-25 11:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool B');
select add_pool_match('', 'Tirupati', 'C', '', '(ISM) Dhanbad', 'C', 17, '2025-12-25 12:30:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Kharagpur', 'D', '', 'Bhilai', 'D', 17, '2025-12-25 12:30:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');

-- Staff Badminton Women Day 3
select add_pool_match('', 'Bhilai', 'D', '', 'Roorkee', 'D', 17, '2025-12-26 08:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool D');
select add_pool_match('', 'Bombay', 'C', '', 'Tirupati', 'C', 17, '2025-12-26 09:30:00 Asia/Kolkata', 'Court 4', 1, 'Pool C');
select add_pool_match('', 'Madras', 'D', '', 'Kharagpur', 'D', 17, '2025-12-26 11:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool D');
select add_pool_match('', 'Mandi', 'B', '', 'Guwahati', 'B', 17, '2025-12-26 11:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool B');
select add_pool_match('', 'Kanpur', 'A', '', 'Ropar', 'A', 17, '2025-12-26 12:30:00 Asia/Kolkata', 'Court 3', 1, 'Pool A');
select add_pool_match('', 'Delhi', 'D', '', 'Roorkee', 'D', 17, '2025-12-26 15:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');

-- Staff Badminton Women Day 4
select add_pool_match('', 'Patna', 'B', '', '(BHU) Varanasi', 'B', 17, '2025-12-27 08:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool B');
select add_pool_match('', '(ISM) Dhanbad', 'C', '', 'Indore', 'C', 17, '2025-12-27 08:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool C');
select add_pool_match('', 'Bhilai', 'D', '', 'Delhi', 'D', 17, '2025-12-27 09:30:00 Asia/Kolkata', 'Court 3', 1, 'Pool D');
select add_pool_match('', 'Hyderabad', 'A', '', 'Gandhinagar', 'A', 17, '2025-12-27 11:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool A');
select add_pool_match('', 'Kharagpur', 'D', '', 'Roorkee', 'D', 17, '2025-12-27 12:30:00 Asia/Kolkata', 'Court 3', 1, 'Pool D');

-- Staff Badminton Women Day 5
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 17, '2025-12-28 08:00:00 Asia/Kolkata', 'Court 3', 3, 'QF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 17, '2025-12-28 08:00:00 Asia/Kolkata', 'Court 4', 3, 'QF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 17, '2025-12-28 09:30:00 Asia/Kolkata', 'Court 3', 3, 'QF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 17, '2025-12-28 09:30:00 Asia/Kolkata', 'Court 4', 3, 'QF4');
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 17, '2025-12-28 16:30:00 Asia/Kolkata', 'Court 3', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 17, '2025-12-28 16:30:00 Asia/Kolkata', 'Court 4', 4, 'SF2');

-- Staff Badminton Women Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 17, '2025-12-29 10:30:00 Asia/Kolkata', 'Court 3', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 17, '2025-12-29 10:30:00 Asia/Kolkata', 'Court 4', 5, 'Final');


-- Staff Basketball Day 1
select add_pool_match('', 'Mandi', 'A', '', 'Dharwad', 'A', 18, '2025-12-24 09:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Guwahati', 'C', '', 'Roorkee', 'C', 18, '2025-12-24 09:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Delhi', 'D', '', '(BHU) Varanasi', 'D', 18, '2025-12-24 10:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', 'Indore', 'A', '', 'Kharagpur', 'A', 18, '2025-12-24 10:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool A');
select add_pool_match('', 'Kanpur', 'B', '', 'Hyderabad', 'B', 18, '2025-12-24 12:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'D', '', 'Ropar', 'D', 18, '2025-12-24 12:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');

-- Staff Basketball Day 2
select add_pool_match('', '(ISM) Dhanbad', 'D', '', '(BHU) Varanasi', 'D', 18, '2025-12-25 09:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', 'Delhi', 'D', '', 'Ropar', 'D', 18, '2025-12-25 09:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');
select add_pool_match('', 'Roorkee', 'C', '', 'Gandhinagar', 'C', 18, '2025-12-25 10:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool C');
select add_pool_match('', 'Bhubaneswar', 'B', '', 'Madras', 'B', 18, '2025-12-25 10:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Guwahati', 'C', '', 'Jammu', 'C', 18, '2025-12-25 15:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool C');
select add_pool_match('', 'Indore', 'A', '', 'Dharwad', 'A', 18, '2025-12-25 15:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool A');
select add_pool_match('', 'Mandi', 'A', '', 'Kharagpur', 'A', 18, '2025-12-25 16:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Bombay', 'D', '', '(ISM) Dhanbad', 'D', 18, '2025-12-25 16:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');

-- Staff Basketball Day 3
select add_pool_match('', 'Kanpur', 'B', '', 'Madras', 'B', 18, '2025-12-26 09:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', '(BHU) Varanasi', 'D', '', 'Ropar', 'D', 18, '2025-12-26 09:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');
select add_pool_match('', 'Mandi', 'A', '', 'Indore', 'A', 18, '2025-12-26 10:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Bhubaneswar', 'B', '', 'Hyderabad', 'B', 18, '2025-12-26 10:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Delhi', 'D', '', 'Bombay', 'D', 18, '2025-12-26 15:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', 'Jammu', 'C', '', 'Gandhinagar', 'C', 18, '2025-12-26 15:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Kharagpur', 'A', '', 'Dharwad', 'A', 18, '2025-12-26 16:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Ropar', 'D', '', '(ISM) Dhanbad', 'D', 18, '2025-12-26 16:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');

-- Staff Basketball Day 
select add_pool_match('', 'Kanpur', 'B', '', 'Bhubaneswar', 'B', 18, '2025-12-27 09:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Jammu', 'C', '', 'Roorkee', 'C', 18, '2025-12-27 09:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Hyderabad', 'B', '', 'Madras', 'B', 18, '2025-12-27 10:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'D', '', '(BHU) Varanasi', 'D', 18, '2025-12-27 10:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');
select add_pool_match('', 'Guwahati', 'C', '', 'Gandhinagar', 'C', 18, '2025-12-27 15:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool C');
select add_pool_match('', 'Delhi', 'D', '', '(ISM) Dhanbad', 'D', 18, '2025-12-27 15:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');


-- Staff Basketball Day 5
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 18, '2025-12-28 09:00:00 Asia/Kolkata', 'Court 1', 3, 'QF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 18, '2025-12-28 09:00:00 Asia/Kolkata', 'Court 2', 3, 'QF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 18, '2025-12-28 10:30:00 Asia/Kolkata', 'Court 1', 3, 'QF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 18, '2025-12-28 10:30:00 Asia/Kolkata', 'Court 2', 3, 'QF4');
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 18, '2025-12-28 15:30:00 Asia/Kolkata', 'Court 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 18, '2025-12-28 17:00:00 Asia/Kolkata', 'Court 1', 4, 'SF2');

-- Staff Basketball Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 18, '2025-12-29 10:00:00 Asia/Kolkata', 'Court 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 18, '2025-12-29 00:00:00 Asia/Kolkata', 'Court 1', 5, 'Final');


-- Staff Cricket Day 0
select add_pool_match('', 'Bombay', 'B', '', 'Kharagpur', 'B', 19, '2025-12-23 08:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', '(ISM) Dhanbad', 'C', '', '(BHU) Varanasi', 'C', 19, '2025-12-23 08:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Jodhpur', 'E', '', 'Bhubaneswar', 'E', 19, '2025-12-23 08:30:00 Asia/Kolkata', 'Ground 3', 1, 'Pool E');
select add_pool_match('', 'Madras', 'D', '', 'Tirupati', 'D', 19, '2025-12-23 12:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Bhilai', 'F', '', 'Delhi', 'F', 19, '2025-12-23 12:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool F');
select add_pool_match('', 'Kanpur', 'G', '', 'Jammu', 'G', 19, '2025-12-23 12:30:00 Asia/Kolkata', 'Ground 3', 1, 'Pool G');

-- Staff Cricket Day 1
select add_pool_match('', 'Mandi', 'F', '', 'Delhi', 'F', 19, '2025-12-24 07:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool F');
select add_pool_match('', 'Patna', 'B', '', 'Kharagpur', 'B', 19, '2025-12-24 07:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Guwahati', 'D', '', 'Tirupati', 'D', 19, '2025-12-24 07:30:00 Asia/Kolkata', 'Ground 3', 1, 'Pool D');
select add_pool_match('', 'Hyderabad', 'C', '', '(BHU) Varanasi', 'C', 19, '2025-12-24 11:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Indore', 'E', '', 'Bhubaneswar', 'E', 19, '2025-12-24 11:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool E');
select add_pool_match('', 'Ropar', 'G', '', 'Jammu', 'G', 19, '2025-12-24 11:30:00 Asia/Kolkata', 'Ground 3', 1, 'Pool G');

-- Staff Cricket Day 2
select add_pool_match('', 'Madras', 'D', '', 'Guwahati', 'D', 19, '2025-12-25 08:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Roorkee', 'H', '', 'Palakkad', 'H', 19, '2025-12-25 08:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool H');
select add_pool_match('', 'Bombay', 'B', '', 'Patna', 'B', 19, '2025-12-25 08:30:00 Asia/Kolkata', 'Ground 3', 1, 'Pool B');
select add_pool_match('', 'Jodhpur', 'E', '', 'Indore', 'E', 19, '2025-12-25 08:30:00 Asia/Kolkata', 'Ground 4', 1, 'Pool E');
select add_pool_match('', '(ISM) Dhanbad', 'C', '', 'Hyderabad', 'C', 19, '2025-12-25 12:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Kanpur', 'G', '', 'Dharwad', 'G', 19, '2025-12-25 12:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool G');
select add_pool_match('', 'Gandhinagar', 'A', '', 'Bhilai', 'A', 19, '2025-12-25 12:30:00 Asia/Kolkata', 'Ground 3', 1, 'Pool A');
select add_pool_match('', 'Mandi', 'F', '', 'Bhilai', 'F', 19, '2025-12-25 12:30:00 Asia/Kolkata', 'Ground 4', 1, 'Pool F');

-- Staff Cricket Day 3
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 19, '2025-12-26 08:30:00 Asia/Kolkata', 'Ground 1', 2, 'PQF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 19, '2025-12-26 08:30:00 Asia/Kolkata', 'Ground 2', 2, 'PQF2');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 19, '2025-12-26 08:30:00 Asia/Kolkata', 'Ground 3', 2, 'PQF4');
select add_pool_match('Winner of Pool E', NULL, null, 'Runner-up of Pool G', NULL, null, 19, '2025-12-26 08:30:00 Asia/Kolkata', 'Ground 4', 2, 'PQF5');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 19, '2025-12-26 12:30:00 Asia/Kolkata', 'Ground 1', 2, 'PQF3');
select add_pool_match('Winner of Pool F', NULL, null, 'Runner-up of Pool H', NULL, null, 19, '2025-12-26 12:30:00 Asia/Kolkata', 'Ground 2', 2, 'PQF6');
select add_pool_match('Winner of Pool G', NULL, null, 'Runner-up of Pool E', NULL, null, 19, '2025-12-26 12:30:00 Asia/Kolkata', 'Ground 3', 2, 'PQF7');
select add_pool_match('Winner of Pool H', NULL, null, 'Runner-up of Pool F', NULL, null, 19, '2025-12-26 12:30:00 Asia/Kolkata', 'Ground 4', 2, 'PQF8');

-- Staff Cricket Day 4
select add_pool_match('Winner of PQF1', NULL, null, 'Winner of PQF6', NULL, null, 19, '2025-12-27 08:30:00 Asia/Kolkata', 'Ground 1', 3, 'QF1');
select add_pool_match('Winner of PQF2', NULL, null, 'Winner of PQF5', NULL, null, 19, '2025-12-27 08:30:00 Asia/Kolkata', 'Ground 2', 3, 'QF2');
select add_pool_match('Winner of PQF3', NULL, null, 'Winner of PQF8', NULL, null, 19, '2025-12-27 12:30:00 Asia/Kolkata', 'Ground 1', 3, 'QF3');
select add_pool_match('Winner of PQF4', NULL, null, 'Winner of PQF7', NULL, null, 19, '2025-12-27 12:30:00 Asia/Kolkata', 'Ground 2', 3, 'QF4');

-- Staff Cricket Day 5
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 19, '2025-12-28 08:30:00 Asia/Kolkata', 'Ground 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 19, '2025-12-28 08:30:00 Asia/Kolkata', 'Ground 2', 4, 'SF2');

-- Staff Cricket Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 19, '2025-12-29 08:30:00 Asia/Kolkata', 'Ground 2', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 19, '2025-12-29 08:30:00 Asia/Kolkata', 'Ground 1', 5, 'Final');


-- Staff Football Day 1
select add_pool_match('', 'Kanpur', 'A', '', 'Dharwad', 'A', 20, '2025-12-24 08:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool A');
select add_pool_match('', 'Hyderabad', 'B', '', 'Jammu', 'B', 20, '2025-12-24 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Guwahati', 'C', '', 'Gandhinagar', 'C', 20, '2025-12-24 09:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Bombay', 'D', '', 'Palakkad', 'D', 20, '2025-12-24 09:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');
select add_pool_match('', 'Roorkee', 'A', '', 'Ropar', 'A', 20, '2025-12-24 11:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool A');
select add_pool_match('', '(ISM) Dhanbad', 'B', '', 'Madras', 'B', 20, '2025-12-24 11:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Mandi', 'C', '', 'Tirupati', 'C', 20, '2025-12-24 12:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Delhi', 'D', '', 'Kharagpur', 'D', 20, '2025-12-24 12:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');

-- Staff Football Day 2
select add_pool_match('', 'Dharwad', 'A', '', 'Bhubaneswar', 'A', 20, '2025-12-25 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Gandhinagar', 'C', '', 'Mandi', 'C', 20, '2025-12-25 08:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', '(ISM) Dhanbad', 'B', '', 'Jammu', 'B', 20, '2025-12-25 09:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'D', '', 'Kharagpur', 'D', 20, '2025-12-25 09:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Kanpur', 'A', '', 'Ropar', 'A', 20, '2025-12-25 11:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Guwahati', 'C', '', 'Tirupati', 'C', 20, '2025-12-25 11:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Madras', 'B', '', 'Hyderabad', 'B', 20, '2025-12-25 12:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Delhi', 'D', '', 'Palakkad', 'D', 20, '2025-12-25 12:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');
select add_pool_match('', 'Roorkee', 'A', '', 'Bhubaneswar', 'A', 20, '2025-12-25 15:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Gandhinagar', 'C', '', '(BHU) Varanasi', 'C', 20, '2025-12-25 15:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Jammu', 'B', '', 'Indore', 'B', 20, '2025-12-25 16:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Kharagpur', 'D', '', 'Patna', 'D', 20, '2025-12-25 16:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');

-- Staff Football Day 3
select add_pool_match('', 'Indore', 'B', '', 'Madras', 'B', 20, '2025-12-26 08:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Kanpur', 'A', '', 'Roorkee', 'A', 20, '2025-12-26 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Guwahati', 'C', '', 'Mandi', 'C', 20, '2025-12-26 09:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Bombay', 'D', '', 'Delhi', 'D', 20, '2025-12-26 09:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Bhubaneswar', 'A', '', 'Ropar', 'A', 20, '2025-12-26 11:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool A');
select add_pool_match('', '(BHU) Varanasi', 'C', '', 'Tirupati', 'C', 20, '2025-12-26 11:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Jammu', 'B', '', 'Madras', 'B', 20, '2025-12-26 15:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Roorkee', 'A', '', 'Dharwad', 'A', 20, '2025-12-26 15:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool A');
select add_pool_match('', 'Patna', 'D', '', 'Palakkad', 'D', 20, '2025-12-26 16:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');
select add_pool_match('', 'Indore', 'B', '', 'Hyderabad', 'B', 20, '2025-12-26 16:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');

-- Staff Football Day 4
select add_pool_match('', 'Bombay', 'D', '', 'Patna', 'D', 20, '2025-12-27 08:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Guwahati', 'C', '', '(BHU) Varanasi', 'C', 20, '2025-12-27 08:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Kanpur', 'A', '', 'Bhubaneswar', 'A', 20, '2025-12-27 09:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Dharwad', 'A', '', 'Ropar', 'A', 20, '2025-12-27 09:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool A');
select add_pool_match('', '(ISM) Dhanbad', 'B', '', 'Indore', 'B', 20, '2025-12-27 11:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Gandhinagar', 'C', '', 'Tirupati', 'C', 20, '2025-12-27 11:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Kharagpur', 'D', '', 'Palakkad', 'D', 20, '2025-12-27 15:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool D');
select add_pool_match('', 'Mandi', 'C', '', '(BHU) Varanasi', 'C', 20, '2025-12-27 15:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Delhi', 'D', '', 'Patna', 'D', 20, '2025-12-27 16:30:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');
select add_pool_match('', '(ISM) Dhanbad', 'B', '', 'Hyderabad', 'B', 20, '2025-12-27 16:30:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');

-- Staff Football Day 5
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 20, '2025-12-28 08:00:00 Asia/Kolkata', 'Ground 2', 3, 'QF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 20, '2025-12-28 08:00:00 Asia/Kolkata', 'Ground 1', 3, 'QF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 20, '2025-12-28 09:30:00 Asia/Kolkata', 'Ground 2', 3, 'QF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 20, '2025-12-28 09:30:00 Asia/Kolkata', 'Ground 1', 3, 'QF4');
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 20, '2025-12-28 16:30:00 Asia/Kolkata', 'Ground 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 20, '2025-12-28 16:30:00 Asia/Kolkata', 'Ground 2', 4, 'SF2');

-- Staff Football Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 20, '2025-12-29 08:00:00 Asia/Kolkata', 'Ground 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 20, '2025-12-29 09:30:00 Asia/Kolkata', 'Ground 1', 5, 'Final');


-- Staff Squash Day 1
select add_pool_match('', 'Delhi', 'A', '', 'Patna', 'A', 21, '2025-12-24 08:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Kanpur', 'B', '', 'Indore', 'B', 21, '2025-12-24 08:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Kharagpur', 'C', '', '(BHU) Varanasi', 'C', 21, '2025-12-24 09:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool C');
select add_pool_match('', 'Gandhinagar', 'D', '', 'Mandi', 'D', 21, '2025-12-24 09:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');
select add_pool_match('', 'Hyderabad', 'B', '', 'Guwahati', 'B', 21, '2025-12-24 11:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'C', '', '(ISM) Dhanbad', 'C', 21, '2025-12-24 11:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Jammu', 'D', '', 'Roorkee', 'D', 21, '2025-12-24 12:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');

-- Staff Squash Day 2
select add_pool_match('', 'Madras', 'A', '', 'Patna', 'A', 21, '2025-12-25 10:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Hyderabad', 'B', '', 'Indore', 'B', 21, '2025-12-25 10:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'C', '', '(BHU) Varanasi', 'C', 21, '2025-12-25 11:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool C');
select add_pool_match('', 'Jammu', 'D', '', 'Mandi', 'D', 21, '2025-12-25 11:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');
select add_pool_match('', 'Kanpur', 'B', '', 'Guwahati', 'B', 21, '2025-12-25 15:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Kharagpur', 'C', '', '(ISM) Dhanbad', 'C', 21, '2025-12-25 15:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Gandhinagar', 'D', '', 'Roorkee', 'D', 21, '2025-12-25 16:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');

-- Staff Squash Day 3
select add_pool_match('', 'Delhi', 'A', '', 'Madras', 'A', 21, '2025-12-26 10:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Kanpur', 'B', '', 'Hyderabad', 'B', 21, '2025-12-26 10:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Kharagpur', 'C', '', 'Bombay', 'C', 21, '2025-12-26 11:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool C');
select add_pool_match('', 'Gandhinagar', 'D', '', 'Jammu', 'D', 21, '2025-12-26 11:30:00 Asia/Kolkata', 'Court 2', 1, 'Pool D');
select add_pool_match('', 'Indore', 'B', '', 'Guwahati', 'B', 21, '2025-12-26 15:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', '(BHU) Varanasi', 'C', '', '(ISM) Dhanbad', 'C', 21, '2025-12-26 15:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Mandi', 'D', '', 'Roorkee', 'D', 21, '2025-12-26 16:30:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');

-- Staff Squash Day 4
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 21, '2025-12-27 10:00:00 Asia/Kolkata', 'Court 1', 3, 'QF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 21, '2025-12-27 10:00:00 Asia/Kolkata', 'Court 2', 3, 'QF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 21, '2025-12-27 11:30:00 Asia/Kolkata', 'Court 1', 3, 'QF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 21, '2025-12-27 11:30:00 Asia/Kolkata', 'Court 2', 3, 'QF4');

-- Staff Squash Day 5
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 21, '2025-12-28 10:00:00 Asia/Kolkata', 'Court 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 21, '2025-12-28 11:30:00 Asia/Kolkata', 'Court 1', 4, 'SF2');

-- Staff Squash Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 21, '2025-12-29 10:00:00 Asia/Kolkata', 'Court 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 21, '2025-12-29 11:30:00 Asia/Kolkata', 'Court 1', 5, 'Final');


--Staff Tennis Day 1
select add_pool_match('', 'Kharagpur', 'A', '', 'Tirupati', 'A', 22, '2025-12-24 09:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Roorkee', 'B', '', 'Patna', 'B', 22, '2025-12-24 09:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Hyderabad', 'C', '', 'Delhi', 'C', 22, '2025-12-24 09:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool C');
select add_pool_match('', 'Bombay', 'D', '', 'Mandi', 'D', 22, '2025-12-24 09:00:00 Asia/Kolkata', 'Ground 4', 1, 'Pool D');
select add_pool_match('', '(BHU) Varanasi', 'A', '', 'Indore', 'A', 22, '2025-12-24 12:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Gandhinagar', 'B', '', 'Jodhpur', 'B', 22, '2025-12-24 12:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Goa', 'C', '', 'Madras', 'C', 22, '2025-12-24 12:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool C');
select add_pool_match('', 'Bhubaneswar', 'D', '', 'Ropar', 'D', 22, '2025-12-24 12:00:00 Asia/Kolkata', 'Ground 4', 1, 'Pool D');

--Staff Tennis Day 2
select add_pool_match('', 'Patna', 'B', '', 'Jodhpur', 'B', 22, '2025-12-25 09:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Goa', 'C', '', 'Kanpur', 'C', 22, '2025-12-25 09:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Bombay', 'D', '', 'Bhubaneswar', 'D', 22, '2025-12-25 09:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool D');
select add_pool_match('', 'Kharagpur', 'A', '', '(BHU) Varanasi', 'A', 22, '2025-12-25 09:00:00 Asia/Kolkata', 'Ground 4', 1, 'Pool A');
select add_pool_match('', 'Roorkee', 'B', '', 'Gandhinagar', 'B', 22, '2025-12-25 13:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Madras', 'C', '', 'Delhi', 'C', 22, '2025-12-25 13:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');
select add_pool_match('', 'Mandi', 'D', '', 'Guwahati', 'D', 22, '2025-12-25 13:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool D');
select add_pool_match('', 'Tirupati', 'A', '', 'Indore', 'A', 22, '2025-12-25 13:00:00 Asia/Kolkata', 'Ground 4', 1, 'Pool A');
select add_pool_match('', 'Jodhpur', 'B', '', '(ISM) Dhanbad', 'B', 22, '2025-12-25 17:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Kanpur', 'C', '', 'Hyderabad', 'C', 22, '2025-12-25 17:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool C');

--Staff Tennis Day 3
select add_pool_match('', 'Kharagpur', 'A', '', 'Indore', 'A', 22, '2025-12-26 09:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool A');
select add_pool_match('', 'Patna', 'B', '', '(ISM) Dhanbad', 'B', 22, '2025-12-26 09:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Kanpur', 'C', '', 'Delhi', 'C', 22, '2025-12-26 09:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool C');
select add_pool_match('', 'Bombay', 'D', '', 'Guwahati', 'D', 22, '2025-12-26 09:00:00 Asia/Kolkata', 'Ground 4', 1, 'Pool D');
select add_pool_match('', 'Roorkee', 'B', '', 'Jodhpur', 'B', 22, '2025-12-26 13:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool B');
select add_pool_match('', 'Hyderabad', 'C', '', 'Goa', 'C', 22, '2025-12-26 13:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool C');
select add_pool_match('', 'Mandi', 'D', '', 'Bhubaneswar', 'D', 22, '2025-12-26 13:00:00 Asia/Kolkata', 'Ground 4', 1, 'Pool D');
select add_pool_match('', 'Gandhinagar', 'B', '', '(ISM) Dhanbad', 'B', 22, '2025-12-26 17:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool B');
select add_pool_match('', 'Guwahati', 'D', '', 'Ropar', 'D', 22, '2025-12-26 17:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');

--Staff Tennis Day 4
select add_pool_match('', 'Hyderabad', 'C', '', 'Madras', 'C', 22, '2025-12-27 09:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Bombay', 'D', '', 'Ropar', 'D', 22, '2025-12-27 09:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');
select add_pool_match('', 'Tirupati', 'A', '', '(BHU) Varanasi', 'A', 22, '2025-12-27 09:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool A');
select add_pool_match('', 'Roorkee', 'B', '', '(ISM) Dhanbad', 'B', 22, '2025-12-27 09:00:00 Asia/Kolkata', 'Ground 4', 1, 'Pool B');
select add_pool_match('', 'Delhi', 'C', '', 'Goa', 'C', 22, '2025-12-27 13:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Bhubaneswar', 'D', '', 'Guwahati', 'D', 22, '2025-12-27 13:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');
select add_pool_match('', 'Patna', 'B', '', 'Gandhinagar', 'B', 22, '2025-12-27 13:00:00 Asia/Kolkata', 'Ground 3', 1, 'Pool B');
select add_pool_match('', 'Kanpur', 'C', '', 'Madras', 'C', 22, '2025-12-27 17:00:00 Asia/Kolkata', 'Ground 1', 1, 'Pool C');
select add_pool_match('', 'Mandi', 'D', '', 'Ropar', 'D', 22, '2025-12-27 17:00:00 Asia/Kolkata', 'Ground 2', 1, 'Pool D');

--Staff Tennis Day 5
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 22, '2025-12-28 09:00:00 Asia/Kolkata', 'Ground 1', 3, 'QF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 22, '2025-12-28 09:00:00 Asia/Kolkata', 'Ground 2', 3, 'QF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 22, '2025-12-28 09:00:00 Asia/Kolkata', 'Ground 3', 3, 'QF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 22, '2025-12-28 09:00:00 Asia/Kolkata', 'Ground 4', 3, 'QF4');
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 22, '2025-12-28 16:00:00 Asia/Kolkata', 'Ground 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 22, '2025-12-28 16:00:00 Asia/Kolkata', 'Ground 2', 4, 'SF2');

--Staff Tennis Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 22, '2025-12-29 10:00:00 Asia/Kolkata', 'Ground 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 22, '2025-12-29 10:00:00 Asia/Kolkata', 'Ground 2', 5, 'Final');


-- Staff Table Tennis Men Day 1
select add_pool_match('', 'Palakkad', 'B', '', 'Indore', 'B', 23, '2025-12-24 10:00:00 Asia/Kolkata', 'Table 1', 1, 'Pool B');
select add_pool_match('', 'Jammu', 'C', '', 'Ropar', 'C', 23, '2025-12-24 10:00:00 Asia/Kolkata', 'Table 2', 1, 'Pool C');
select add_pool_match('', 'Guwahati', 'D', '', 'Gandhinagar', 'D', 23, '2025-12-24 10:30:00 Asia/Kolkata', 'Table 3', 1, 'Pool D');
select add_pool_match('', 'Delhi', 'E', '', 'Bhilai', 'E', 23, '2025-12-24 10:30:00 Asia/Kolkata', 'Table 4', 1, 'Pool E');
select add_pool_match('', 'Kanpur', 'F', '', 'Madras', 'F', 23, '2025-12-24 11:00:00 Asia/Kolkata', 'Table 1', 1, 'Pool F');
select add_pool_match('', '(ISM) Dhanbad', 'G', '', 'Goa', 'G', 23, '2025-12-24 11:00:00 Asia/Kolkata', 'Table 2', 1, 'Pool G');

-- Staff Table Tennis Men Day 2
select add_pool_match('', 'Bombay', 'B', '', 'Indore', 'B', 23, '2025-12-25 09:30:00 Asia/Kolkata', 'Table 1', 1, 'Pool B');
select add_pool_match('', 'Mandi', 'C', '', 'Ropar', 'C', 23, '2025-12-25 09:30:00 Asia/Kolkata', 'Table 2', 1, 'Pool C');
select add_pool_match('', 'Hyderabad', 'D', '', 'Gandhinagar', 'D', 23, '2025-12-25 09:30:00 Asia/Kolkata', 'Table 3', 1, 'Pool D');
select add_pool_match('', '(BHU) Varanasi', 'E', '', 'Bhilai', 'E', 23, '2025-12-25 09:30:00 Asia/Kolkata', 'Table 4', 1, 'Pool E');
select add_pool_match('', 'Bhubaneswar', 'F', '', 'Madras', 'F', 23, '2025-12-25 10:30:00 Asia/Kolkata', 'Table 1', 1, 'Pool F');
select add_pool_match('', 'Tirupati', 'G', '', 'Goa', 'G', 23, '2025-12-25 10:30:00 Asia/Kolkata', 'Table 2', 1, 'Pool G');

-- Staff Table Tennis Men Day 3
select add_pool_match('', 'Bombay', 'B', '', 'Palakkad', 'B', 23, '2025-12-26 09:30:00 Asia/Kolkata', 'Table 1', 1, 'Pool B');
select add_pool_match('', 'Mandi', 'C', '', 'Jammu', 'C', 23, '2025-12-26 09:30:00 Asia/Kolkata', 'Table 2', 1, 'Pool C');
select add_pool_match('', 'Hyderabad', 'D', '', 'Guwahati', 'D', 23, '2025-12-26 09:30:00 Asia/Kolkata', 'Table 3', 1, 'Pool D');
select add_pool_match('', '(BHU) Varanasi', 'E', '', 'Delhi', 'E', 23, '2025-12-26 09:30:00 Asia/Kolkata', 'Table 4', 1, 'Pool E');
select add_pool_match('', 'Bhubaneswar', 'F', '', 'Kanpur', 'F', 23, '2025-12-26 10:30:00 Asia/Kolkata', 'Table 1', 1, 'Pool F');
select add_pool_match('', 'Tirupati', 'G', '', '(ISM) Dhanbad', 'G', 23, '2025-12-26 10:30:00 Asia/Kolkata', 'Table 2', 1, 'Pool G');
select add_pool_match('', 'Kharagpur', 'A', '', 'Dharwad', 'A', 23, '2025-12-26 10:30:00 Asia/Kolkata', 'Table 3', 1, 'Pool A');
select add_pool_match('', 'Roorkee', 'H', '', 'Patna', 'H', 23, '2025-12-26 10:30:00 Asia/Kolkata', 'Table 4', 1, 'Pool H');

-- Staff Table Tennis Men Day 4
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 23, '2025-12-27 09:30:00 Asia/Kolkata', 'Table 1', 2, 'PQF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 23, '2025-12-27 09:30:00 Asia/Kolkata', 'Table 2', 2, 'PQF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 23, '2025-12-27 09:30:00 Asia/Kolkata', 'Table 3', 2, 'PQF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 23, '2025-12-27 09:30:00 Asia/Kolkata', 'Table 4', 2, 'PQF4');
select add_pool_match('Winner of Pool E', NULL, null, 'Runner-up of Pool G', NULL, null, 23, '2025-12-27 10:30:00 Asia/Kolkata', 'Table 1', 2, 'PQF5');
select add_pool_match('Winner of Pool F', NULL, null, 'Runner-up of Pool H', NULL, null, 23, '2025-12-27 10:30:00 Asia/Kolkata', 'Table 2', 2, 'PQF6');
select add_pool_match('Winner of Pool G', NULL, null, 'Runner-up of Pool E', NULL, null, 23, '2025-12-27 10:30:00 Asia/Kolkata', 'Table 3', 2, 'PQF7');
select add_pool_match('Winner of Pool H', NULL, null, 'Runner-up of Pool F', NULL, null, 23, '2025-12-27 10:30:00 Asia/Kolkata', 'Table 4', 2, 'PQF8');

-- Staff Table Tennis Men Day 5
select add_pool_match('Winner of PQF1', NULL, null, 'Winner of PQF6', NULL, null, 23, '2025-12-28 10:30:00 Asia/Kolkata', 'Table 1', 3, 'QF1');
select add_pool_match('Winner of PQF2', NULL, null, 'Winner of PQF5', NULL, null, 23, '2025-12-28 10:30:00 Asia/Kolkata', 'Table 2', 3, 'QF2');
select add_pool_match('Winner of PQF3', NULL, null, 'Winner of PQF8', NULL, null, 23, '2025-12-28 10:30:00 Asia/Kolkata', 'Table 3', 3, 'QF3');
select add_pool_match('Winner of PQF4', NULL, null, 'Winner of PQF7', NULL, null, 23, '2025-12-28 10:30:00 Asia/Kolkata', 'Table 4', 3, 'QF4');
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 23, '2025-12-28 17:00:00 Asia/Kolkata', 'Table 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 23, '2025-12-28 17:00:00 Asia/Kolkata', 'Table 2', 4, 'SF2');

-- Staff Table Tennis Men Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 23, '2025-12-29 09:30:00 Asia/Kolkata', 'Table 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 23, '2025-12-29 10:30:00 Asia/Kolkata', 'Table 1', 5, 'Final');


-- Staff Table Tennis Women Day 1
select add_pool_match('', 'Bombay', 'A', '', 'Indore', 'A', 24, '2025-12-24 17:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Delhi', 'B', '', 'Patna', 'B', 24, '2025-12-24 17:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', '(BHU) Varanasi', 'C', '', 'Roorkee', 'C', 24, '2025-12-24 17:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Hyderabad', 'D', '', '(ISM) Dhanbad', 'D', 24, '2025-12-24 17:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');
select add_pool_match('', 'Kharagpur', 'A', '', 'Guwahati', 'A', 24, '2025-12-24 18:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Mandi', 'B', '', 'Kanpur', 'B', 24, '2025-12-24 18:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Ropar', 'C', '', 'Madras', 'C', 24, '2025-12-24 18:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Gandhinagar', 'D', '', 'Tirupati', 'D', 24, '2025-12-24 18:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');

-- Staff Table Tennis Women Day 2
select add_pool_match('', 'Bombay', 'A', '', 'Guwahati', 'A', 24, '2025-12-25 17:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Delhi', 'B', '', 'Kanpur', 'B', 24, '2025-12-25 17:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', '(BHU) Varanasi', 'C', '', 'Madras', 'C', 24, '2025-12-25 17:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Hyderabad', 'D', '', 'Tirupati', 'D', 24, '2025-12-25 17:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');
select add_pool_match('', 'Kharagpur', 'A', '', 'Indore', 'A', 24, '2025-12-25 18:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Mandi', 'B', '', 'Patna', 'B', 24, '2025-12-25 18:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Ropar', 'C', '', 'Roorkee', 'C', 24, '2025-12-25 18:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Gandhinagar', 'D', '', '(ISM) Dhanbad', 'D', 24, '2025-12-25 18:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');

-- Staff Table Tennis Women Day 3
select add_pool_match('', 'Bombay', 'A', '', 'Kharagpur', 'A', 24, '2025-12-26 17:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Delhi', 'B', '', 'Mandi', 'B', 24, '2025-12-26 17:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', '(BHU) Varanasi', 'C', '', 'Ropar', 'C', 24, '2025-12-26 17:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Hyderabad', 'D', '', 'Gandhinagar', 'D', 24, '2025-12-26 17:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');
select add_pool_match('', 'Guwahati', 'A', '', 'Indore', 'A', 24, '2025-12-26 18:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Kanpur', 'B', '', 'Patna', 'B', 24, '2025-12-26 18:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool B');
select add_pool_match('', 'Madras', 'C', '', 'Roorkee', 'C', 24, '2025-12-26 18:00:00 Asia/Kolkata', 'Court 3', 1, 'Pool C');
select add_pool_match('', 'Tirupati', 'D', '', '(ISM) Dhanbad', 'D', 24, '2025-12-26 18:00:00 Asia/Kolkata', 'Court 4', 1, 'Pool D');

-- Staff Table Tennis Women Day 4
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 24, '2025-12-27 11:30:00 Asia/Kolkata', 'Court 1', 3, 'QF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 24, '2025-12-27 11:30:00 Asia/Kolkata', 'Court 2', 3, 'QF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 24, '2025-12-27 11:30:00 Asia/Kolkata', 'Court 3', 3, 'QF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 24, '2025-12-27 11:30:00 Asia/Kolkata', 'Court 4', 3, 'QF4');

-- Staff Table Tennis Women Day 5
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 24, '2025-12-28 18:00:00 Asia/Kolkata', 'Court 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 24, '2025-12-28 18:00:00 Asia/Kolkata', 'Court 2', 4, 'SF2');

-- Staff Table Tennis Women Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 24, '2025-12-29 09:30:00 Asia/Kolkata', 'Court 2', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 24, '2025-12-29 10:30:00 Asia/Kolkata', 'Court 2', 5, 'Final');

-- Staff Volleyball Day 1
select add_pool_match('', 'Dharwad', 'B', '', 'Jodhpur', 'B', 25, '2025-12-24 09:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'C', '', 'Delhi', 'C', 25, '2025-12-24 09:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Kanpur', 'D', '', 'Indore', 'D', 25, '2025-12-24 10:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', '(ISM) Dhanbad', 'E', '', 'Gandhinagar', 'E', 25, '2025-12-24 10:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool E');
select add_pool_match('', 'Patna', 'F', '', 'Palakkad', 'F', 25, '2025-12-24 11:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool F');
select add_pool_match('', 'Ropar', 'G', '', 'Bhilai', 'G', 25, '2025-12-24 11:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool G');

-- Staff Volleyball Day 2
select add_pool_match('', '(BHU) Varanasi', 'B', '', 'Jodhpur', 'B', 25, '2025-12-25 10:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Mandi', 'C', '', 'Delhi', 'C', 25, '2025-12-25 10:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Tirupati', 'D', '', 'Indore', 'D', 25, '2025-12-25 17:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', 'Roorkee', 'E', '', 'Gandhinagar', 'E', 25, '2025-12-25 17:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool E');
select add_pool_match('', 'Kharagpur', 'F', '', 'Palakkad', 'F', 25, '2025-12-25 18:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool F');
select add_pool_match('', 'Bhubaneswar', 'G', '', 'Bhilai', 'G', 25, '2025-12-25 18:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool G');

-- Staff Volleyball Day 3
select add_pool_match('', 'Dharwad', 'B', '', '(BHU) Varanasi', 'B', 25, '2025-12-26 10:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool B');
select add_pool_match('', 'Bombay', 'C', '', 'Mandi', 'C', 25, '2025-12-26 10:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool C');
select add_pool_match('', 'Kanpur', 'D', '', 'Tirupati', 'D', 25, '2025-12-26 11:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool D');
select add_pool_match('', '(ISM) Dhanbad', 'E', '', 'Roorkee', 'E', 25, '2025-12-26 11:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool E');
select add_pool_match('', 'Patna', 'F', '', 'Kharagpur', 'F', 25, '2025-12-26 17:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool F');
select add_pool_match('', 'Ropar', 'G', '', 'Bhubaneswar', 'G', 25, '2025-12-26 17:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool G');
select add_pool_match('', 'Madras', 'A', '', 'Jammu', 'A', 25, '2025-12-26 18:00:00 Asia/Kolkata', 'Court 1', 1, 'Pool A');
select add_pool_match('', 'Hyderabad', 'H', '', 'Guwahati', 'H', 25, '2025-12-26 18:00:00 Asia/Kolkata', 'Court 2', 1, 'Pool H');

-- Staff Volleyball Day 4
select add_pool_match('Winner of Pool A', NULL, null, 'Runner-up of Pool C', NULL, null, 25, '2025-12-27 10:00:00 Asia/Kolkata', 'Court 1', 2, 'PQF1');
select add_pool_match('Winner of Pool B', NULL, null, 'Runner-up of Pool D', NULL, null, 25, '2025-12-27 10:00:00 Asia/Kolkata', 'Court 2', 2, 'PQF2');
select add_pool_match('Winner of Pool C', NULL, null, 'Runner-up of Pool A', NULL, null, 25, '2025-12-27 11:00:00 Asia/Kolkata', 'Court 1', 2, 'PQF3');
select add_pool_match('Winner of Pool D', NULL, null, 'Runner-up of Pool B', NULL, null, 25, '2025-12-27 11:00:00 Asia/Kolkata', 'Court 2', 2, 'PQF4');
select add_pool_match('Winner of Pool E', NULL, null, 'Runner-up of Pool G', NULL, null, 25, '2025-12-27 17:00:00 Asia/Kolkata', 'Court 1', 2, 'PQF5');
select add_pool_match('Winner of Pool F', NULL, null, 'Runner-up of Pool H', NULL, null, 25, '2025-12-27 17:00:00 Asia/Kolkata', 'Court 2', 2, 'PQF6');
select add_pool_match('Winner of Pool G', NULL, null, 'Runner-up of Pool E', NULL, null, 25, '2025-12-27 18:00:00 Asia/Kolkata', 'Court 1', 2, 'PQF7');
select add_pool_match('Winner of Pool H', NULL, null, 'Runner-up of Pool F', NULL, null, 25, '2025-12-27 18:00:00 Asia/Kolkata', 'Court 2', 2, 'PQF8');

-- Staff Volleyball Day 5
select add_pool_match('Winner of PQF1', NULL, null, 'Winner of PQF6', NULL, null, 25, '2025-12-28 10:00:00 Asia/Kolkata', 'Court 1', 3, 'QF1');
select add_pool_match('Winner of PQF2', NULL, null, 'Winner of PQF5', NULL, null, 25, '2025-12-28 10:00:00 Asia/Kolkata', 'Court 2', 3, 'QF2');
select add_pool_match('Winner of PQF3', NULL, null, 'Winner of PQF8', NULL, null, 25, '2025-12-28 11:00:00 Asia/Kolkata', 'Court 1', 3, 'QF3');
select add_pool_match('Winner of PQF4', NULL, null, 'Winner of PQF7', NULL, null, 25, '2025-12-28 11:00:00 Asia/Kolkata', 'Court 2', 3, 'QF4');
select add_pool_match('Winner of QF1', NULL, null, 'Winner of QF4', NULL, null, 25, '2025-12-28 18:00:00 Asia/Kolkata', 'Court 1', 4, 'SF1');
select add_pool_match('Winner of QF2', NULL, null, 'Winner of QF3', NULL, null, 25, '2025-12-28 18:00:00 Asia/Kolkata', 'Court 2', 4, 'SF2');

-- Staff Volleyball Day 6
select add_pool_match('Loser of SF1', NULL, null, 'Loser of SF2', NULL, null, 25, '2025-12-29 09:00:00 Asia/Kolkata', 'Court 1', 5, '3rd Place');
select add_pool_match('Winner of SF1', NULL, null, 'Winner of SF2', NULL, null, 25, '2025-12-29 11:00:00 Asia/Kolkata', 'Court 2', 5, 'Final');


