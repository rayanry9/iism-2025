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
ADD COLUMN staff BOOLEAN NOT NULL DEFAULT false,
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

CREATE UNIQUE INDEX IF NOT EXISTS unq_primary_user_sport ON user_sports (user_id, sport_id) WHERE NOT (secondary OR reserve);

-- Role - > 1 -> non player 
-- 2 -> Player
-- 3 -> Contingent Leader
-- 4 -> Deputy Contingent Leader
-- 5 -> Admin
-- 6 -> Coach

DROP TABLE IF EXISTS players ;
DROP TABLE IF EXISTS admins ;

-- ATHLETICS STUDENT
INSERT INTO sports (id, name, type) VALUES (27, '100 M', 4);
INSERT INTO sports (id, name, type) VALUES (28, '200 M', 4);
INSERT INTO sports (id, name, type) VALUES (29, '400 M', 4);
INSERT INTO sports (id, name, type) VALUES (30, '800 M', 4);
INSERT INTO sports (id, name, type) VALUES (31, '1500 M', 4);
INSERT INTO sports (id, name, type) VALUES (32, '5000 M', 4);
INSERT INTO sports (id, name, type) VALUES (33, '110 M Hurdles', 4);
INSERT INTO sports (id, name, type) VALUES (34, '400 M Hurdles', 4);
INSERT INTO sports (id, name, type) VALUES (35, '4x110 M Relay', 7);
INSERT INTO sports (id, name, type) VALUES (36, '4x400 M Relay', 7);
INSERT INTO sports (id, name, type) VALUES (37, 'High Jump', 4);
INSERT INTO sports (id, name, type) VALUES (38, 'Long Jump', 4);
INSERT INTO sports (id, name, type) VALUES (39, 'Triple Jump', 4);
INSERT INTO sports (id, name, type) VALUES (40, 'Pole Vault', 4);
INSERT INTO sports (id, name, type) VALUES (41, 'Shot Put', 4);
INSERT INTO sports (id, name, type) VALUES (42, 'Discus Throw', 4);
INSERT INTO sports (id, name, type) VALUES (43, 'Javelin Throw', 4);
INSERT INTO sports (id, name, type) VALUES (44, 'Hammer Throw', 4);

-- FEMALE
INSERT INTO sports (id, name, type) VALUES (45, '100 M', 5);
INSERT INTO sports (id, name, type) VALUES (46, '200 M', 5);
INSERT INTO sports (id, name, type) VALUES (47, '400 M', 5);
INSERT INTO sports (id, name, type) VALUES (48, '800 M', 5);
INSERT INTO sports (id, name, type) VALUES (49, '1500 M', 5);
INSERT INTO sports (id, name, type) VALUES (50, '100 M Hurdles', 5);
INSERT INTO sports (id, name, type) VALUES (51, '4x100 M Relay', 8);
INSERT INTO sports (id, name, type) VALUES (52, '4x400 M Relay', 8);
INSERT INTO sports (id, name, type) VALUES (53, 'High Jump', 5);
INSERT INTO sports (id, name, type) VALUES (54, 'Long Jump', 5);
INSERT INTO sports (id, name, type) VALUES (55, 'Shot Put', 5);
INSERT INTO sports (id, name, type) VALUES (56, 'Discus Throw', 5);
INSERT INTO sports (id, name, type) VALUES (57, 'Javelin Throw', 5);

-- Mixed
INSERT INTO sports (id, name, type) VALUES (58, '4x400 M Relay', 9);


-- STAFF

-- DEMO
INSERT INTO sports (id, name, type, staff) VALUES (59, 'Chess', 3, true);
INSERT INTO sports (id, name, type, staff) VALUES (60, '100 M ( 55+ yrs )', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (61, '5000 M ( 50+ yrs )', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (62, '100 M ( 55+ yrs )', 5, true);

-- MEN

INSERT INTO sports (id, name, type, staff) VALUES (63, '100 M', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (64, '200 M', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (65, '400 M', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (66, '800 M', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (67, '1500 M', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (68, '5000 M', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (69, '4x100 M Relay', 7, true);
INSERT INTO sports (id, name, type, staff) VALUES (70, 'High Jump', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (71, 'Long Jump', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (72, 'Hammer Throw', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (73, 'Shot Put', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (74, 'Discuss Throw', 4, true);
INSERT INTO sports (id, name, type, staff) VALUES (75, 'Javelin Throw', 4, true);

-- WOMEN

INSERT INTO sports (id, name, type, staff) VALUES (76, '100 M', 5, true);
INSERT INTO sports (id, name, type, staff) VALUES (77, '200 M', 5, true);
INSERT INTO sports (id, name, type, staff) VALUES (78, '400 M', 5, true);
INSERT INTO sports (id, name, type, staff) VALUES (79, '4x100 M Relay', 8, true);
INSERT INTO sports (id, name, type, staff) VALUES (80, 'Long Jump', 5, true);
INSERT INTO sports (id, name, type, staff) VALUES (81, 'Shot Put', 5, true);
INSERT INTO sports (id, name, type, staff) VALUES (82, 'Discuss Throw', 5, true);
INSERT INTO sports (id, name, type, staff) VALUES (83, 'Javelin Throw', 5, true);
