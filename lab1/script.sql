BEGIN;

--дропнуть перед началом
DROP TABLE IF EXISTS entities_action, entity, action, location, human, ship CASCADE;
DROP TYPE IF EXISTS sex, major CASCADE;

--СОЗДАНИЕ
--енамчики
CREATE TYPE sex AS ENUM ('man', 'woman');
CREATE TYPE major AS ENUM ('captain', 'engineer', 'cook', 'cleaner');

--таблицы
CREATE TABLE ship (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) DEFAULT 'Неизвестный',
    description TEXT
);

CREATE TABLE human (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    age INTEGER NOT NULL CHECK (age > 0),
    major major,
    sex sex NOT NULL DEFAULT 'man',
    ship_id INTEGER REFERENCES ship(id) ON DELETE SET NULL
);

CREATE TABLE location (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    description TEXT
);

CREATE TABLE action (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    description TEXT,
    ship_id INTEGER NOT NULL REFERENCES ship(id) ON DELETE RESTRICT,
    location_id INTEGER NOT NULL REFERENCES location(id) ON DELETE RESTRICT,
    time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    result BOOLEAN
);

CREATE TABLE entity (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    description TEXT
);

CREATE TABLE entities_action (
    entity_id INTEGER NOT NULL REFERENCES entity(id) ON DELETE CASCADE,
    action_id INTEGER NOT NULL REFERENCES action(id) ON DELETE CASCADE,
    PRIMARY KEY (entity_id, action_id)
);

--ЗАПОЛНЕНИЕ
INSERT INTO ship (name, description) VALUES
('Покойоколка', 'Загадочное судно с хранителями свэга в синих кепках'),
('67-й покоритель', 'Давным-давно утерянная среди песков времени легенда'),
('Т.Ю.', 'Летающая обитель космо-варваров');

INSERT INTO human (name, age, major, sex, ship_id) VALUES
('Егор', 52, 'cook', DEFAULT, 1),
('Боб', 67, 'cleaner', DEFAULT, 3),
('Угара', 1488, NULL, 'woman', 3),
('Последний выживший', 1000000000, 'captain', DEFAULT, 2);

INSERT INTO location (name, description)
VALUES ('Олимп', 'Место, где встречаются легенды космического дрейфа');

INSERT INTO entity (name, description) VALUES
('Трактор', 'Наиужаснейший монстр из всех существовавших'),
('Карман', 'Правая рука Трактора');

INSERT INTO action (name, description, ship_id, location_id, time, result) VALUES 
('Прах Покойоколки', 'В первые моменты Олимпийской резни корабль Покойоколка обрел вечный покой', 1, 1, '2976-01-18 15:28:00', TRUE),
('Ликбез', 'Не успел никто опомнится после Праха Покойоколки, как тут же судно Т.Ю погрузилось в пасть Кармана', 3, 1, '2976-01-18 15:30:47', TRUE),
('Покоритель покорил', 'Единственным выжившим при Олимпе стал капитан 67-го покорителя', 2, 1, '2976-01-18 16:02:14', FALSE);

INSERT INTO entities_action (entity_id, action_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2),
(2, 3);

--ВЫВОД
SELECT * FROM human;
SELECT * FROM ship;
SELECT * FROM action;
SELECT * FROM entity;
SELECT * FROM entities_action;
SELECT * FROM location;

COMMIT;