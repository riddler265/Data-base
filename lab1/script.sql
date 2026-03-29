BEGIN;

CREATE TYPE sex AS ENUM ('man', 'woman');

CREATE TYPE major AS ENUM ('captain', 'engineer', 'cook', 'cleaner');

CREATE TABLE ship (
    id SERIAL PRIMARY KEY,
    name TEXT,
    description TEXT
);

CREATE TABLE human (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER NOT NULL CHECK (age > 0),
    major major,
    sex sex NOT NULL DEFAULT 'man',
    ship_id INTEGER REFERENCES ship(id)
);

CREATE TABLE location (
    id SERIAL PRIMARY KEY,
    name TEXT,
    description TEXT
);

CREATE TABLE action (
    id SERIAL PRIMARY KEY,
    name TEXT,
    description TEXT,
    ship_id INTEGER NOT NULL REFERENCES ship(id),
    location_id INTEGER NOT NULL REFERENCES location(id),
    time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    result BOOLEAN
);

CREATE TABLE entity (
    id SERIAL PRIMARY KEY,
    name TEXT,
    description TEXT
);

CREATE TABLE entities_action (
    id SERIAL PRIMARY KEY,
    entity_id INTEGER NOT NULL REFERENCES entity(id),
    action_id INTEGER NOT NULL REFERENCES action(id)
);