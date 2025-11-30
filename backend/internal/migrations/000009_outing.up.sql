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
