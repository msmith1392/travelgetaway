-- Users
INSERT INTO users (email, password, name)
VALUES
  ('alice@example.com', 'exalicepw123!', 'Alice Example'),
  ('bob@example.com', 'exbobpw123!', 'Bob Example'),
  ('carol@example.com', 'excarolpw123!', 'Carol Example'),
  ('dave@example.com', 'exdavepw123!', 'Dave Example'),
  ('eve@example.com', 'exevepw123!', 'Eve Example');

-- Trips
INSERT INTO trips (user_id, name, start_date, end_date)
VALUES
  (1, 'Italy Adventure', '2025-05-10', '2025-05-15'),
  (2, 'Japan Journey', '2025-06-01', '2025-06-10');

-- Activity Days
INSERT INTO activity_days (trip_id, date, day_details)
VALUES
  (1, '2025-05-10', 'Arrive in Rome, check in to hotel'),
  (1, '2025-05-11', 'Visit Colosseum and Roman Forum'),
  (2, '2025-06-01', 'Arrive in Tokyo, explore Shibuya'),
  (2, '2025-06-02', 'Day trip to Mt. Fuji');

-- Activities
INSERT INTO activities (activity_day_id, name, description, time, location)
VALUES
  (1, 'Check-in', 'Hotel check-in and rest', '15:00', 'Rome'),
  (2, 'Colosseum Tour', 'Guided tour of Colosseum', '10:00', 'Rome'),
  (2, 'Lunch', 'Lunch near Roman Forum', '13:00', 'Rome'),
  (3, 'Shibuya Crossing', 'Walk and photos', '17:00', 'Tokyo'),
  (4, 'Mt. Fuji Tour', 'Bus tour to Mt. Fuji', '08:00', 'Mt. Fuji');

-- Trip Users (sharing trips)
INSERT INTO trip_users (trip_id, user_id)
VALUES
  (1, 1), -- Alice on Italy Adventure
  (1, 2), -- Bob on Italy Adventure
  (1, 3), -- Carol on Italy Adventure
  (2, 2), -- Bob on Japan Journey
  (2, 4), -- Dave on Japan Journey
  (2, 5); -- Eve on Japan Journey