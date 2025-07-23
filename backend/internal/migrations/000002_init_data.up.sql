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
INSERT INTO institutes (id, name) VALUES (12, 'Dhanbad');
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
INSERT INTO sports (id, name, type) VALUES (7, 'Football', 3);
INSERT INTO sports (id, name, type) VALUES (8, 'Squash', 1);
INSERT INTO sports (id, name, type) VALUES (9, 'Squash', 2);
INSERT INTO sports (id, name, type) VALUES (10, 'Table Tennis', 1);
INSERT INTO sports (id, name, type) VALUES (11, 'Table Tennis', 2);
INSERT INTO sports (id, name, type) VALUES (12, 'Tennis', 1);
INSERT INTO sports (id, name, type) VALUES (13, 'Tennis', 2);
INSERT INTO sports (id, name, type) VALUES (14, 'Volleyball', 1);
INSERT INTO sports (id, name, type) VALUES (15, 'Volleyball', 2);


-- Staff Sports
INSERT INTO sports (id, name, type, staff) VALUES (16, 'Badminton', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (17, 'Badminton', 2, true);
INSERT INTO sports (id, name, type, staff) VALUES (18, 'Basketball', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (19, 'Cricket', 3, true);
INSERT INTO sports (id, name, type, staff) VALUES (20, 'Football', 3, true);
INSERT INTO sports (id, name, type, staff) VALUES (21, 'Squash', 3, true);
INSERT INTO sports (id, name, type, staff) VALUES (22, 'Tennis', 3, true);
INSERT INTO sports (id, name, type, staff) VALUES (23, 'Table Tennis', 1, true);
INSERT INTO sports (id, name, type, staff) VALUES (24, 'Table Tennis', 2, true);
INSERT INTO sports (id, name, type, staff) VALUES (25, 'Volleyball', 3, true);


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

INSERT INTO pools (id, name, sport_id) VALUES (9, 'A', 2);
INSERT INTO pools (id, name, sport_id) VALUES (10, 'B', 2);
INSERT INTO pools (id, name, sport_id) VALUES (11, 'C', 2);
INSERT INTO pools (id, name, sport_id) VALUES (12, 'D', 2);
INSERT INTO pools (id, name, sport_id) VALUES (13, 'E', 2);
INSERT INTO pools (id, name, sport_id) VALUES (14, 'F', 2);
INSERT INTO pools (id, name, sport_id) VALUES (15, 'G', 2);
INSERT INTO pools (id, name, sport_id) VALUES (16, 'H', 2);

-- Basketball Pools

INSERT INTO pools (id, name, sport_id) VALUES (17, 'A', 3);
INSERT INTO pools (id, name, sport_id) VALUES (18, 'B', 3);
INSERT INTO pools (id, name, sport_id) VALUES (19, 'C', 3);
INSERT INTO pools (id, name, sport_id) VALUES (20, 'D', 3);
INSERT INTO pools (id, name, sport_id) VALUES (21, 'E', 3);
INSERT INTO pools (id, name, sport_id) VALUES (22, 'F', 3);
INSERT INTO pools (id, name, sport_id) VALUES (23, 'G', 3);
INSERT INTO pools (id, name, sport_id) VALUES (24, 'H', 3);

INSERT INTO pools (id, name, sport_id) VALUES (25, 'A', 4);
INSERT INTO pools (id, name, sport_id) VALUES (26, 'B', 4);
INSERT INTO pools (id, name, sport_id) VALUES (27, 'C', 4);
INSERT INTO pools (id, name, sport_id) VALUES (28, 'D', 4);

-- Cricket 

INSERT INTO pools (id, name, sport_id) VALUES (29, 'A', 5);
INSERT INTO pools (id, name, sport_id) VALUES (30, 'B', 5);
INSERT INTO pools (id, name, sport_id) VALUES (31, 'C', 5);
INSERT INTO pools (id, name, sport_id) VALUES (32, 'D', 5);
INSERT INTO pools (id, name, sport_id) VALUES (33, 'E', 5);
INSERT INTO pools (id, name, sport_id) VALUES (34, 'F', 5);
INSERT INTO pools (id, name, sport_id) VALUES (35, 'G', 5);
INSERT INTO pools (id, name, sport_id) VALUES (36, 'H', 5);

-- Hockey

INSERT INTO pools (id, name, sport_id) VALUES (37, 'A', 6);
INSERT INTO pools (id, name, sport_id) VALUES (38, 'B', 6);
INSERT INTO pools (id, name, sport_id) VALUES (39, 'C', 6);
INSERT INTO pools (id, name, sport_id) VALUES (40, 'D', 6);

-- Football

INSERT INTO pools (id, name, sport_id) VALUES (41, 'A', 7);
INSERT INTO pools (id, name, sport_id) VALUES (42, 'B', 7);
INSERT INTO pools (id, name, sport_id) VALUES (43, 'C', 7);
INSERT INTO pools (id, name, sport_id) VALUES (44, 'D', 7);
INSERT INTO pools (id, name, sport_id) VALUES (45, 'E', 7);
INSERT INTO pools (id, name, sport_id) VALUES (46, 'F', 7);
INSERT INTO pools (id, name, sport_id) VALUES (47, 'G', 7);
INSERT INTO pools (id, name, sport_id) VALUES (48, 'H', 7);

-- Squash

INSERT INTO pools (id, name, sport_id) VALUES (49, 'A', 8);
INSERT INTO pools (id, name, sport_id) VALUES (50, 'B', 8);
INSERT INTO pools (id, name, sport_id) VALUES (51, 'C', 8);
INSERT INTO pools (id, name, sport_id) VALUES (52, 'D', 8);

INSERT INTO pools (id, name, sport_id) VALUES (53, 'A', 9);
INSERT INTO pools (id, name, sport_id) VALUES (54, 'B', 9);
INSERT INTO pools (id, name, sport_id) VALUES (55, 'C', 9);
INSERT INTO pools (id, name, sport_id) VALUES (56, 'D', 9);

-- Table Tennis

INSERT INTO pools (id, name, sport_id) VALUES (57, 'A', 10);
INSERT INTO pools (id, name, sport_id) VALUES (58, 'B', 10);
INSERT INTO pools (id, name, sport_id) VALUES (59, 'C', 10);
INSERT INTO pools (id, name, sport_id) VALUES (60, 'D', 10);
INSERT INTO pools (id, name, sport_id) VALUES (61, 'E', 10);
INSERT INTO pools (id, name, sport_id) VALUES (62, 'F', 10);
INSERT INTO pools (id, name, sport_id) VALUES (63, 'G', 10);
INSERT INTO pools (id, name, sport_id) VALUES (64, 'H', 10);

INSERT INTO pools (id, name, sport_id) VALUES (65, 'A', 11);
INSERT INTO pools (id, name, sport_id) VALUES (66, 'B', 11);
INSERT INTO pools (id, name, sport_id) VALUES (67, 'C', 11);
INSERT INTO pools (id, name, sport_id) VALUES (68, 'D', 11);
INSERT INTO pools (id, name, sport_id) VALUES (69, 'E', 11);
INSERT INTO pools (id, name, sport_id) VALUES (70, 'F', 11);
INSERT INTO pools (id, name, sport_id) VALUES (71, 'G', 11);
INSERT INTO pools (id, name, sport_id) VALUES (72, 'H', 11);

-- Tennis

INSERT INTO pools (id, name, sport_id) VALUES (73, 'A', 12);
INSERT INTO pools (id, name, sport_id) VALUES (74, 'B', 12);
INSERT INTO pools (id, name, sport_id) VALUES (75, 'C', 12);
INSERT INTO pools (id, name, sport_id) VALUES (76, 'D', 12);

INSERT INTO pools (id, name, sport_id) VALUES (77, 'A', 13);
INSERT INTO pools (id, name, sport_id) VALUES (78, 'B', 13);
INSERT INTO pools (id, name, sport_id) VALUES (79, 'C', 13);
INSERT INTO pools (id, name, sport_id) VALUES (80, 'D', 13);

-- Volleyball

INSERT INTO pools (id, name, sport_id) VALUES (81, 'A', 14);
INSERT INTO pools (id, name, sport_id) VALUES (82, 'B', 14);
INSERT INTO pools (id, name, sport_id) VALUES (83, 'C', 14);
INSERT INTO pools (id, name, sport_id) VALUES (84, 'D', 14);
INSERT INTO pools (id, name, sport_id) VALUES (85, 'E', 14);
INSERT INTO pools (id, name, sport_id) VALUES (86, 'F', 14);
INSERT INTO pools (id, name, sport_id) VALUES (87, 'G', 14);
INSERT INTO pools (id, name, sport_id) VALUES (88, 'H', 14);

INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A1', 81);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 81);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A3', 81);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 82);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 82);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 82);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 83);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 83);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 83);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D1', 84);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 84);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D3', 84);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E1', 85);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 85);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 85);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 86);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 86);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 86);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 87);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 87);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 87);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H1', 88);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H2', 88);

INSERT INTO pools (id, name, sport_id) VALUES (89, 'A', 15);
INSERT INTO pools (id, name, sport_id) VALUES (90, 'B', 15);
INSERT INTO pools (id, name, sport_id) VALUES (91, 'C', 15);
INSERT INTO pools (id, name, sport_id) VALUES (92, 'D', 15);
INSERT INTO pools (id, name, sport_id) VALUES (93, 'E', 15);
INSERT INTO pools (id, name, sport_id) VALUES (94, 'F', 15);
INSERT INTO pools (id, name, sport_id) VALUES (95, 'G', 15);
INSERT INTO pools (id, name, sport_id) VALUES (96, 'H', 15);

INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A1', 89);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('A2', 89);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B1', 90);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B2', 90);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('B3', 90);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C1', 91);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C2', 91);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('C3', 91);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D1', 92);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('D2', 92);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E1', 93);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E2', 93);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('E3', 93);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F1', 94);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F2', 94);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('F3', 94);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G1', 95);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G2', 95);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('G3', 95);
INSERT INTO pool_teams (temp_name, pool_id) VALUES ('H1', 96);
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

INSERT INTO pools (id, name, sport_id) VALUES (105, 'A', 17);
INSERT INTO pools (id, name, sport_id) VALUES (106, 'B', 17);
INSERT INTO pools (id, name, sport_id) VALUES (107, 'C', 17);
INSERT INTO pools (id, name, sport_id) VALUES (108, 'D', 17);

-- Basketball Staff

INSERT INTO pools (id, name, sport_id) VALUES (109, 'A', 18);
INSERT INTO pools (id, name, sport_id) VALUES (110, 'B', 18);
INSERT INTO pools (id, name, sport_id) VALUES (111, 'C', 18);
INSERT INTO pools (id, name, sport_id) VALUES (112, 'D', 18);

-- Cricket Staff

INSERT INTO pools (id, name, sport_id) VALUES (113, 'A', 19);
INSERT INTO pools (id, name, sport_id) VALUES (114, 'B', 19);
INSERT INTO pools (id, name, sport_id) VALUES (115, 'C', 19);
INSERT INTO pools (id, name, sport_id) VALUES (116, 'D', 19);
INSERT INTO pools (id, name, sport_id) VALUES (117, 'E', 19);
INSERT INTO pools (id, name, sport_id) VALUES (118, 'F', 19);
INSERT INTO pools (id, name, sport_id) VALUES (119, 'G', 19);
INSERT INTO pools (id, name, sport_id) VALUES (120, 'H', 19);


-- Football Staff

INSERT INTO pools (id, name, sport_id) VALUES (121, 'A', 20);
INSERT INTO pools (id, name, sport_id) VALUES (122, 'B', 20);
INSERT INTO pools (id, name, sport_id) VALUES (123, 'C', 20);
INSERT INTO pools (id, name, sport_id) VALUES (124, 'D', 20);

-- Squash Staff

INSERT INTO pools (id, name, sport_id) VALUES (125, 'A', 21);
INSERT INTO pools (id, name, sport_id) VALUES (126, 'B', 21);
INSERT INTO pools (id, name, sport_id) VALUES (127, 'C', 21);
INSERT INTO pools (id, name, sport_id) VALUES (128, 'D', 21);

-- Tennis Staff

INSERT INTO pools (id, name, sport_id) VALUES (129, 'A', 22);
INSERT INTO pools (id, name, sport_id) VALUES (130, 'B', 22);
INSERT INTO pools (id, name, sport_id) VALUES (131, 'C', 22);
INSERT INTO pools (id, name, sport_id) VALUES (132, 'D', 22);

-- Table Tennis Staff

INSERT INTO pools (id, name, sport_id) VALUES (133, 'A', 23);
INSERT INTO pools (id, name, sport_id) VALUES (134, 'B', 23);
INSERT INTO pools (id, name, sport_id) VALUES (135, 'C', 23);
INSERT INTO pools (id, name, sport_id) VALUES (136, 'D', 23);
INSERT INTO pools (id, name, sport_id) VALUES (137, 'E', 23);
INSERT INTO pools (id, name, sport_id) VALUES (138, 'F', 23);
INSERT INTO pools (id, name, sport_id) VALUES (139, 'G', 23);
INSERT INTO pools (id, name, sport_id) VALUES (140, 'H', 23);

INSERT INTO pools (id, name, sport_id) VALUES (141, 'A', 24);
INSERT INTO pools (id, name, sport_id) VALUES (142, 'B', 24);
INSERT INTO pools (id, name, sport_id) VALUES (143, 'C', 24);
INSERT INTO pools (id, name, sport_id) VALUES (144, 'D', 24);

-- Volleyball Staff

INSERT INTO pools (id, name, sport_id) VALUES (145, 'A', 24);
INSERT INTO pools (id, name, sport_id) VALUES (146, 'B', 24);
INSERT INTO pools (id, name, sport_id) VALUES (147, 'C', 24);
INSERT INTO pools (id, name, sport_id) VALUES (148, 'D', 24);
INSERT INTO pools (id, name, sport_id) VALUES (149, 'E', 24);
INSERT INTO pools (id, name, sport_id) VALUES (150, 'F', 24);
INSERT INTO pools (id, name, sport_id) VALUES (151, 'G', 24);
INSERT INTO pools (id, name, sport_id) VALUES (152, 'H', 24);
