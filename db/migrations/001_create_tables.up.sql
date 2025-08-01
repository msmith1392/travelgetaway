-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT now()
);

-- Trips table
CREATE TABLE trips (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

-- Activity Days table
CREATE TABLE activity_days (
    id SERIAL PRIMARY KEY,
    trip_id INTEGER REFERENCES trips(id),
    date DATE NOT NULL,
    day_details TEXT
);

-- Activities table
CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    activity_day_id INTEGER REFERENCES activity_days(id),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    time TIME,
    location VARCHAR(255)
);

-- Trip Users table
CREATE TABLE trip_users (
    id SERIAL PRIMARY KEY,
    trip_id INTEGER REFERENCES trips(id),
    user_id INTEGER REFERENCES users(id),
    CONSTRAINT unique_trip_user UNIQUE (trip_id, user_id)
);

-- Indexes for performance
CREATE INDEX idx_trips_user_id ON trips(user_id);
CREATE INDEX idx_activity_days_trip_id ON activity_days(trip_id);
CREATE INDEX idx_activities_activity_day_id ON activities(activity_day_id);
CREATE INDEX idx_trip_users_trip_id ON trip_users(trip_id);
CREATE INDEX idx_trip_users_user_id ON trip_users(user_id);