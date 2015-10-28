-- CREATE TABLE

DROP TABLE IF EXISTS foo;

CREATE TABLE foo (
    animal  TEXT,
    sound   TEXT
);

CREATE TABLE IF NOT EXISTS foo (
    animal  TEXT,
    sound   TEXT
);

-- CREATE INDEX

CREATE INDEX idxAnimal ON foo (animal);

CREATE TABLE foo (
    animal  TEXT PRIMARY KEY,
    sound   TEXT
);

CREATE TABLE foo (
    animal  TEXT UNIQUE,
    sound   TEXT
);


DROP INDEX IF EXISTS idxAnimal;

-- special case ID fields

CREATE TABLE foo (
    id      SERIAL PRIMARY KEY,
    animal  TEXT,
    sound   TEXT
);

INSERT INTO foo (animal, sound) VALUES ('cat', 'purr') RETURNING id;
INSERT INTO foo (animal, sound) VALUES ('dog', 'woof') RETURNING id;
INSERT INTO foo (animal, sound) VALUES ('duck', 'quack') RETURNING id;
INSERT INTO foo (animal, sound) VALUES ('bear', 'grrr') RETURNING id;

-- utility queries

SELECT * FROM view_tables;

INSERT INTO foo (animal, sound) VALUES ('cat', 'purr');
INSERT INTO foo (animal, sound) VALUES ('dog', 'woof');
INSERT INTO foo (animal, sound) VALUES ('duck', 'quack');
INSERT INTO foo (animal, sound) VALUES ('bear', 'grrr');

SELECT * FROM foo;

SELECT * FROM view_tables;
SELECT * FROM view_indexes;

DROP TABLE foo;

