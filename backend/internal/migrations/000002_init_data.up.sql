INSERT INTO institutes (id, name) VALUES (1, 'Bombay');
INSERT INTO institutes (id, name) VALUES (2, 'Bhubaneswar');
INSERT INTO institutes (id, name) VALUES (3, 'Bhilai');
INSERT INTO institutes (id, name) VALUES (4, '(BHU) Varanasi');
INSERT INTO institutes (id, name) VALUES (5, 'Delhi');
INSERT INTO institutes (id, name) VALUES (6, 'Dharwad');
INSERT INTO institutes (id, name) VALUES (7, 'Guwahati');
INSERT INTO institutes (id, name) VALUES (8, 'Gandhinagar');
INSERT INTO institutes (id, name) VALUES (9, 'Goa');
INSERT INTO institutes (id, name) VALUES (10, 'Hyderabad');
INSERT INTO institutes (id, name) VALUES (11, 'Indore');
INSERT INTO institutes (id, name) VALUES (12, '(ISM) Dhanbad');
INSERT INTO institutes (id, name) VALUES (13, 'Jodhpur');
INSERT INTO institutes (id, name) VALUES (14, 'Jammu');
INSERT INTO institutes (id, name) VALUES (15, 'Kanpur');
INSERT INTO institutes (id, name) VALUES (16, 'Kharagpur');
INSERT INTO institutes (id, name) VALUES (17, 'Madras');
INSERT INTO institutes (id, name) VALUES (18, 'Mandi');
INSERT INTO institutes (id, name) VALUES (19, 'Patna');
INSERT INTO institutes (id, name) VALUES (20, 'Palakkad');
INSERT INTO institutes (id, name) VALUES (21, 'Roorkee');
INSERT INTO institutes (id, name) VALUES (22, 'Ropar');
INSERT INTO institutes (id, name) VALUES (23, 'Tirupati');

-- Student Sports

INSERT INTO sports (id, name, type) VALUES (1, 'Badminton', 1);
INSERT INTO sports (id, name, type) VALUES (2, 'Badminton', 2);
INSERT INTO sports (id, name, type) VALUES (3, 'Basketball', 1);
INSERT INTO sports (id, name, type) VALUES (4, 'Basketball', 2);
INSERT INTO sports (id, name, type) VALUES (5, 'Cricket', 1);
INSERT INTO sports (id, name, type) VALUES (6, 'Hockey', 1);
INSERT INTO sports (id, name, type) VALUES (7, 'Football', 1);
INSERT INTO sports (id, name, type) VALUES (8, 'Squash', 1);
INSERT INTO sports (id, name, type) VALUES (9, 'Squash', 2);
INSERT INTO sports (id, name, type) VALUES (10, 'Table Tennis', 1);
INSERT INTO sports (id, name, type) VALUES (11, 'Table Tennis', 2);
INSERT INTO sports (id, name, type) VALUES (12, 'Tennis', 1);
INSERT INTO sports (id, name, type) VALUES (13, 'Tennis', 2);
INSERT INTO sports (id, name, type) VALUES (14, 'Volleyball', 1);
INSERT INTO sports (id, name, type) VALUES (15, 'Volleyball', 2);
INSERT INTO sports (id, name, type) VALUES (26, 'Aquatics Water Polo', 1);

-- Staff Sports

INSERT INTO sports (id, name, type, staff) VALUES (16, 'Badminton', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (17, 'Badminton', 2, true);
INSERT INTO sports (id, name, type, staff) VALUES (18, 'Basketball', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (19, 'Cricket', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (20, 'Football', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (21, 'Squash', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (22, 'Tennis', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (23, 'Table Tennis', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (24, 'Table Tennis', 2, true);
INSERT INTO sports (id, name, type, staff) VALUES (25, 'Volleyball', 1, true);

-- Pools

-- Badminton Pools

INSERT INTO pools (id, name, sport_id) VALUES (1, 'A', 1);
INSERT INTO pools (id, name, sport_id) VALUES (2, 'B', 1);
INSERT INTO pools (id, name, sport_id) VALUES (3, 'C', 1);
INSERT INTO pools (id, name, sport_id) VALUES (4, 'D', 1);
INSERT INTO pools (id, name, sport_id) VALUES (5, 'E', 1);
INSERT INTO pools (id, name, sport_id) VALUES (6, 'F', 1);
INSERT INTO pools (id, name, sport_id) VALUES (7, 'G', 1);
INSERT INTO pools (id, name, sport_id) VALUES (8, 'H', 1);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 1, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 2);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 2);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 2);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 3);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 3);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 3);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 4, 13);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 4);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 4);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 5, 16);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 6);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 6);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 6);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 7);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 7);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 7);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 8, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 8);

INSERT INTO pools (id, name, sport_id) VALUES (9, 'A', 2);
INSERT INTO pools (id, name, sport_id) VALUES (10, 'B', 2);
INSERT INTO pools (id, name, sport_id) VALUES (11, 'C', 2);
INSERT INTO pools (id, name, sport_id) VALUES (12, 'D', 2);
INSERT INTO pools (id, name, sport_id) VALUES (13, 'E', 2);
INSERT INTO pools (id, name, sport_id) VALUES (14, 'F', 2);
INSERT INTO pools (id, name, sport_id) VALUES (15, 'G', 2);
INSERT INTO pools (id, name, sport_id) VALUES (16, 'H', 2);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 9, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 9);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 10);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 10);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 10);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 11);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 11);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 11);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 12, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 12);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 13, 13);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 13);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 13);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 14);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 14);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 14);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 15);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 16, 16);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 16);

-- Basketball Pools

INSERT INTO pools (id, name, sport_id) VALUES (17, 'A', 3);
INSERT INTO pools (id, name, sport_id) VALUES (18, 'B', 3);
INSERT INTO pools (id, name, sport_id) VALUES (19, 'C', 3);
INSERT INTO pools (id, name, sport_id) VALUES (20, 'D', 3);
INSERT INTO pools (id, name, sport_id) VALUES (21, 'E', 3);
INSERT INTO pools (id, name, sport_id) VALUES (22, 'F', 3);
INSERT INTO pools (id, name, sport_id) VALUES (23, 'G', 3);
INSERT INTO pools (id, name, sport_id) VALUES (24, 'H', 3);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 17, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 18);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 18);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 18);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 19);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 19);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 19);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 20, 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 20);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 20);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 21, 10);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 22);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 22);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 22);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 23);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 23);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 23);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 24, 4);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 24);

INSERT INTO pools (id, name, sport_id) VALUES (25, 'A', 4);
INSERT INTO pools (id, name, sport_id) VALUES (26, 'B', 4);
INSERT INTO pools (id, name, sport_id) VALUES (27, 'C', 4);
INSERT INTO pools (id, name, sport_id) VALUES (28, 'D', 4);
INSERT INTO pools (id, name, sport_id) VALUES (157, 'E', 4);
INSERT INTO pools (id, name, sport_id) VALUES (158, 'F', 4);
INSERT INTO pools (id, name, sport_id) VALUES (159, 'G', 4);
INSERT INTO pools (id, name, sport_id) VALUES (160, 'H', 4);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 25, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 25);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 26);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 26);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 26);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 27);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 27);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 27);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 28, 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 28);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 28);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 157, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 157);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 157);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 158);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 158);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 158);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 159);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 159);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 159);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 160, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 160);

-- Cricket 

INSERT INTO pools (id, name, sport_id) VALUES (29, 'A', 5);
INSERT INTO pools (id, name, sport_id) VALUES (30, 'B', 5);
INSERT INTO pools (id, name, sport_id) VALUES (31, 'C', 5);
INSERT INTO pools (id, name, sport_id) VALUES (32, 'D', 5);
INSERT INTO pools (id, name, sport_id) VALUES (33, 'E', 5);
INSERT INTO pools (id, name, sport_id) VALUES (34, 'F', 5);
INSERT INTO pools (id, name, sport_id) VALUES (35, 'G', 5);
INSERT INTO pools (id, name, sport_id) VALUES (36, 'H', 5);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 29, 4);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 29);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 29);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 30);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 30);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 30);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 31);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 31);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 31);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 32, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 32);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 32);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 33, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 33);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 33);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 34);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 34);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 34);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 35);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 35);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 35);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 36, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 36);


-- Hockey

INSERT INTO pools (id, name, sport_id) VALUES (37, 'A', 6);
INSERT INTO pools (id, name, sport_id) VALUES (38, 'B', 6);
INSERT INTO pools (id, name, sport_id) VALUES (39, 'C', 6);
INSERT INTO pools (id, name, sport_id) VALUES (40, 'D', 6);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 37, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 37);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 37);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 38, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 38);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 38);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 39, 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 39);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 39);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 40, 4);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 40);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 40);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 40);

-- Football

INSERT INTO pools (id, name, sport_id) VALUES (41, 'A', 7);
INSERT INTO pools (id, name, sport_id) VALUES (42, 'B', 7);
INSERT INTO pools (id, name, sport_id) VALUES (43, 'C', 7);
INSERT INTO pools (id, name, sport_id) VALUES (44, 'D', 7);
INSERT INTO pools (id, name, sport_id) VALUES (45, 'E', 7);
INSERT INTO pools (id, name, sport_id) VALUES (46, 'F', 7);
INSERT INTO pools (id, name, sport_id) VALUES (47, 'G', 7);
INSERT INTO pools (id, name, sport_id) VALUES (48, 'H', 7);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 41, 16);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 41);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 42);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 42);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 42);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 43);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 43);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 43);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 44, 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 44);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 44);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 45, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 45);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 45);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 46);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 46);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 46);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 47);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 47);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 47);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 48, 7);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 48);

-- Squash

INSERT INTO pools (id, name, sport_id) VALUES (49, 'A', 8);
INSERT INTO pools (id, name, sport_id) VALUES (50, 'B', 8);
INSERT INTO pools (id, name, sport_id) VALUES (51, 'C', 8);
INSERT INTO pools (id, name, sport_id) VALUES (52, 'D', 8);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 49, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 49);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 49);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A4', 49);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 50, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 50);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 50);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 50);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 51, 13);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 51);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 51);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 51);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 52, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 52);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 52);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 52);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D5', 52);

INSERT INTO pools (id, name, sport_id) VALUES (53, 'A', 9);
INSERT INTO pools (id, name, sport_id) VALUES (54, 'B', 9);
INSERT INTO pools (id, name, sport_id) VALUES (55, 'C', 9);
INSERT INTO pools (id, name, sport_id) VALUES (56, 'D', 9);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 53, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 53);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 53);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 54, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 54);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 54);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 54);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 55, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 55);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 55);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 55);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 56, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 56);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 56);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 56);

-- Table Tennis

INSERT INTO pools (id, name, sport_id) VALUES (57, 'A', 10);
INSERT INTO pools (id, name, sport_id) VALUES (58, 'B', 10);
INSERT INTO pools (id, name, sport_id) VALUES (59, 'C', 10);
INSERT INTO pools (id, name, sport_id) VALUES (60, 'D', 10);
INSERT INTO pools (id, name, sport_id) VALUES (61, 'E', 10);
INSERT INTO pools (id, name, sport_id) VALUES (62, 'F', 10);
INSERT INTO pools (id, name, sport_id) VALUES (63, 'G', 10);
INSERT INTO pools (id, name, sport_id) VALUES (64, 'H', 10);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 57, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 57);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 57);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 58);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 58);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 58);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 59);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 59);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 59);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 60, 7);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 60);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 60);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 61, 16);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 61);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 61);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 62);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 62);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 62);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 63);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 63);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 63);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 64, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 64);

INSERT INTO pools (id, name, sport_id) VALUES (65, 'A', 11);
INSERT INTO pools (id, name, sport_id) VALUES (66, 'B', 11);
INSERT INTO pools (id, name, sport_id) VALUES (67, 'C', 11);
INSERT INTO pools (id, name, sport_id) VALUES (68, 'D', 11);
INSERT INTO pools (id, name, sport_id) VALUES (69, 'E', 11);
INSERT INTO pools (id, name, sport_id) VALUES (70, 'F', 11);
INSERT INTO pools (id, name, sport_id) VALUES (71, 'G', 11);
INSERT INTO pools (id, name, sport_id) VALUES (72, 'H', 11);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 65, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 65);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 65);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 66);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 66);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 66);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 67);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 67);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 67);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 68, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 68);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 68);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 69, 18);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 69);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 69);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 70);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 70);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 70);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 71);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 71);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 71);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 72, 13);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 72);

-- Tennis

INSERT INTO pools (id, name, sport_id) VALUES (73, 'A', 12);
INSERT INTO pools (id, name, sport_id) VALUES (74, 'B', 12);
INSERT INTO pools (id, name, sport_id) VALUES (75, 'C', 12);
INSERT INTO pools (id, name, sport_id) VALUES (76, 'D', 12);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 73, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 73);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 73);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A4', 73);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 74, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 74);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 74);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 74);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 75, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 75);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 75);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 75);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C5', 75);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 76, 11);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 76);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 76);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 76);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D5', 76);

INSERT INTO pools (id, name, sport_id) VALUES (77, 'A', 13);
INSERT INTO pools (id, name, sport_id) VALUES (78, 'B', 13);
INSERT INTO pools (id, name, sport_id) VALUES (79, 'C', 13);
INSERT INTO pools (id, name, sport_id) VALUES (80, 'D', 13);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 77, 22);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 77);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 77);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A4', 77);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 78, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 78);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 78);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 78);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 79, 19);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 79);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 79);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 79);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 80, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 80);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 80);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 80);

-- Volleyball

INSERT INTO pools (id, name, sport_id) VALUES (81, 'A', 14);
INSERT INTO pools (id, name, sport_id) VALUES (82, 'B', 14);
INSERT INTO pools (id, name, sport_id) VALUES (83, 'C', 14);
INSERT INTO pools (id, name, sport_id) VALUES (84, 'D', 14);
INSERT INTO pools (id, name, sport_id) VALUES (85, 'E', 14);
INSERT INTO pools (id, name, sport_id) VALUES (86, 'F', 14);
INSERT INTO pools (id, name, sport_id) VALUES (87, 'G', 14);
INSERT INTO pools (id, name, sport_id) VALUES (88, 'H', 14);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 81, 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 81);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 81);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 82);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 82);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 82);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 83);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 83);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 83);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 84, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 84);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 84);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 85, 14);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 85);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 85);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 86);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 86);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 86);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 87);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 87);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 87);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 88, 4);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 88);

INSERT INTO pools (id, name, sport_id) VALUES (89, 'A', 15);
INSERT INTO pools (id, name, sport_id) VALUES (90, 'B', 15);
INSERT INTO pools (id, name, sport_id) VALUES (91, 'C', 15);
INSERT INTO pools (id, name, sport_id) VALUES (92, 'D', 15);
INSERT INTO pools (id, name, sport_id) VALUES (93, 'E', 15);
INSERT INTO pools (id, name, sport_id) VALUES (94, 'F', 15);
INSERT INTO pools (id, name, sport_id) VALUES (95, 'G', 15);
INSERT INTO pools (id, name, sport_id) VALUES (96, 'H', 15);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 89, 4);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 89);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 90);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 90);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 90);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 91);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 91);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 91);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 92, 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 92);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 92);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 93, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 93);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 93);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 94);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 94);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 94);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 95);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 95);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 95);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 96, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 96);

-- Badminton Staff

INSERT INTO pools (id, name, sport_id) VALUES (97, 'A', 16);
INSERT INTO pools (id, name, sport_id) VALUES (98, 'B', 16);
INSERT INTO pools (id, name, sport_id) VALUES (99, 'C', 16);
INSERT INTO pools (id, name, sport_id) VALUES (100, 'D', 16);
INSERT INTO pools (id, name, sport_id) VALUES (101, 'E', 16);
INSERT INTO pools (id, name, sport_id) VALUES (102, 'F', 16);
INSERT INTO pools (id, name, sport_id) VALUES (103, 'G', 16);
INSERT INTO pools (id, name, sport_id) VALUES (104, 'H', 16);

INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A1', 97);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 97);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 97);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 98);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 98);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 98);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 99);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 99);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 99);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 100, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 100);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 100);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 101, 12);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 101);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 101);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 102);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 102);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 102);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 103);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 103);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 103);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 104, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 104);

INSERT INTO pools (id, name, sport_id) VALUES (105, 'A', 17);
INSERT INTO pools (id, name, sport_id) VALUES (106, 'B', 17);
INSERT INTO pools (id, name, sport_id) VALUES (107, 'C', 17);
INSERT INTO pools (id, name, sport_id) VALUES (108, 'D', 17);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 105, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 105);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 105);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A4', 105);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 106, 18);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 106);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 106);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 106);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 107, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 107);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 107);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 107);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 108, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 108);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 108);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 108);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D5', 108);

-- Basketball Staff

INSERT INTO pools (id, name, sport_id) VALUES (109, 'A', 18);
INSERT INTO pools (id, name, sport_id) VALUES (110, 'B', 18);
INSERT INTO pools (id, name, sport_id) VALUES (111, 'C', 18);
INSERT INTO pools (id, name, sport_id) VALUES (112, 'D', 18);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 109, 18);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 109);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 109);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A4', 109);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 110, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 110);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 110);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 110);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 111, 7);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 111);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 111);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 111);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 112, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 112);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 112);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 112);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D5', 112);

-- Cricket Staff

INSERT INTO pools (id, name, sport_id) VALUES (113, 'A', 19);
INSERT INTO pools (id, name, sport_id) VALUES (114, 'B', 19);
INSERT INTO pools (id, name, sport_id) VALUES (115, 'C', 19);
INSERT INTO pools (id, name, sport_id) VALUES (116, 'D', 19);
INSERT INTO pools (id, name, sport_id) VALUES (117, 'E', 19);
INSERT INTO pools (id, name, sport_id) VALUES (118, 'F', 19);
INSERT INTO pools (id, name, sport_id) VALUES (119, 'G', 19);
INSERT INTO pools (id, name, sport_id) VALUES (120, 'H', 19);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 113, 8);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 113);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 114);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 114);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 114);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 115);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 115);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 115);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 116, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 116);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 116);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 117, 13);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 117);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 117);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 118);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 118);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 118);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 119);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 119);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 119);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 120, 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 120);


-- Football Staff

INSERT INTO pools (id, name, sport_id) VALUES (121, 'A', 20);
INSERT INTO pools (id, name, sport_id) VALUES (122, 'B', 20);
INSERT INTO pools (id, name, sport_id) VALUES (123, 'C', 20);
INSERT INTO pools (id, name, sport_id) VALUES (124, 'D', 20);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 121, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 121);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 121);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A4', 121);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A5', 121);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 122, 12);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 122);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 122);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 122);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B5', 122);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 123, 7);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 123);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 123);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 123);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C5', 123);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 124, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 124);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 124);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 124);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D5', 124);

-- Squash Staff

INSERT INTO pools (id, name, sport_id) VALUES (125, 'A', 21);
INSERT INTO pools (id, name, sport_id) VALUES (126, 'B', 21);
INSERT INTO pools (id, name, sport_id) VALUES (127, 'C', 21);
INSERT INTO pools (id, name, sport_id) VALUES (128, 'D', 21);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 125, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 125);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 125);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 126, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 126);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 126);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 126);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 127, 16);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 127);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 127);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 127);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 128, 8);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 128);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 128);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 128);

-- Tennis Staff

INSERT INTO pools (id, name, sport_id) VALUES (129, 'A', 22);
INSERT INTO pools (id, name, sport_id) VALUES (130, 'B', 22);
INSERT INTO pools (id, name, sport_id) VALUES (131, 'C', 22);
INSERT INTO pools (id, name, sport_id) VALUES (132, 'D', 22);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 129, 16);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 129);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 129);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A4', 129);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A5', 129);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 130, 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 130);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 130);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 130);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B5', 130);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 131, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 131);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 131);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 131);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C5', 131);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 132, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 132);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 132);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 132);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D5', 132);


-- Table Tennis Staff

INSERT INTO pools (id, name, sport_id) VALUES (133, 'A', 23);
INSERT INTO pools (id, name, sport_id) VALUES (134, 'B', 23);
INSERT INTO pools (id, name, sport_id) VALUES (135, 'C', 23);
INSERT INTO pools (id, name, sport_id) VALUES (136, 'D', 23);
INSERT INTO pools (id, name, sport_id) VALUES (137, 'E', 23);
INSERT INTO pools (id, name, sport_id) VALUES (138, 'F', 23);
INSERT INTO pools (id, name, sport_id) VALUES (139, 'G', 23);
INSERT INTO pools (id, name, sport_id) VALUES (140, 'H', 23);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 133, 16);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 133);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 134);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 134);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 134);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 135);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 135);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 135);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 136, 10);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 136);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 136);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 137, 4);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 137);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 137);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 138);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 138);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 138);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 139);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 139);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 139);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 140, 21);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 140);

INSERT INTO pools (id, name, sport_id) VALUES (141, 'A', 24);
INSERT INTO pools (id, name, sport_id) VALUES (142, 'B', 24);
INSERT INTO pools (id, name, sport_id) VALUES (143, 'C', 24);
INSERT INTO pools (id, name, sport_id) VALUES (144, 'D', 24);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 141, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 141);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 141);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A4', 141);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 142, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 142);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 142);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B4', 142);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B5', 142);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 143, 4);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 143);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 143);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C4', 143);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C5', 143);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 144, 10);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 144);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 144);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D4', 144);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D5', 144);

-- Volleyball Staff

INSERT INTO pools (id, name, sport_id) VALUES (145, 'A', 25);
INSERT INTO pools (id, name, sport_id) VALUES (146, 'B', 25);
INSERT INTO pools (id, name, sport_id) VALUES (147, 'C', 25);
INSERT INTO pools (id, name, sport_id) VALUES (148, 'D', 25);
INSERT INTO pools (id, name, sport_id) VALUES (149, 'E', 25);
INSERT INTO pools (id, name, sport_id) VALUES (150, 'F', 25);
INSERT INTO pools (id, name, sport_id) VALUES (151, 'G', 25);
INSERT INTO pools (id, name, sport_id) VALUES (152, 'H', 25);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 145, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 145);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 146);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 146);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 146);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 147);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 147);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 147);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 148, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 148);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 148);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('E1', 149, 12);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 149);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 149);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 150);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 150);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 150);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 151);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 151);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 151);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('H1', 152, 10);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 152);

-- Aquatics Water Polo Student

INSERT INTO pools (id, name, sport_id) VALUES (153, 'A', 26);
INSERT INTO pools (id, name, sport_id) VALUES (154, 'B', 26);
INSERT INTO pools (id, name, sport_id) VALUES (155, 'C', 26);
INSERT INTO pools (id, name, sport_id) VALUES (156, 'D', 26);

INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('A1', 153, 5);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 153);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('B1', 154, 1);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 154);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 154);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('C1', 155, 17);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 155);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 155);
INSERT INTO pool_teams (temp_name, pool_id, institute_id) VALUES ('D1', 156, 15);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 156);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 156);
