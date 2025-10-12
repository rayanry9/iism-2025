ALTER TABLE users ALTER COLUMN last_name DROP NOT NULL;
ALTER TABLE users 
ADD COLUMN contact_no TEXT,
ADD COLUMN emergency_contact_no TEXT,
ADD COLUMN food_preference TEXT,
ADD COLUMN hostel TEXT,
ADD COLUMN blood_group TEXT,
ADD COLUMN check_in_date DATE,
ADD COLUMN check_out_date DATE,
ADD COLUMN assigned_id TEXT,
ADD COLUMN remark TEXT,
ADD COLUMN role SMALLINT NOT NULL,
ADD COLUMN institute_id INT NOT NULL CONSTRAINT fk_user_institute REFERENCES institutes (id);
ALTER TABLE users ADD CONSTRAINT unq_email UNIQUE (email);
ALTER TABLE users ALTER COLUMN password DROP NOT NULL;

CREATE TABLE IF NOT EXISTS user_sports (
		id SERIAL PRIMARY KEY,
		user_id INT NOT NULL CONSTRAINT fk_user_sports_user REFERENCES users (id),
		sport_id INT NOT NULL CONSTRAINT fk_user_sports_sport REFERENCES sports (id),
		secondary BOOL NOT NULL DEFAULT false,
		reserve BOOL NOT NULL DEFAULT false,
		extra TEXT
);

CREATE UNIQUE INDEX unq_primary_user_sport ON user_sports (user_id, sport_id) WHERE NOT (secondary OR reserve);

-- Role - > 1 -> non player 
-- 2 -> Player
-- 3 -> Contingent Leader
-- 4 -> Deputy Contingent Leader
-- 5 -> Admin
-- 6 -> Coach

DROP TABLE players IF EXISTS;
DROP TABLE admins IF EXISTS;
