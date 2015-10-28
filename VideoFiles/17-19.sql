-- INSERT
CREATE TABLE a (a TEXT, b TEXT, c TEXT);
INSERT INTO a VALUES ('a', 'b', 'c');
INSERT INTO a VALUES ('a', 'b', 'c');
INSERT INTO a VALUES ('a', 'b', 'c');
INSERT INTO a VALUES ('a', 'b', 'c');
INSERT INTO a VALUES ('a', 'b', 'c');
SELECT * FROM a;

CREATE TABLE b (d TEXT, e TEXT, f TEXT);
INSERT INTO b SELECT * FROM a;
INSERT INTO b (f, e, d) SELECT * FROM a;
INSERT INTO b (f, e, d) SELECT c, a, b FROM a;
SELECT * FROM b;
DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;

-- UPDATE
CREATE TABLE t ( id SERIAL PRIMARY KEY, quote TEXT, byline TEXT );
INSERT INTO t ( quote, byline ) VALUES ( 'Aye Carumba!', 'Bart Simpson' );
INSERT INTO t ( quote, byline ) VALUES ( 'But Bullwinkle, that trick never works!', 'Rocket J. Squirrel' );
INSERT INTO t ( quote, byline ) VALUES ( 'I know.', 'Han Solo' );
INSERT INTO t ( quote, byline ) VALUES ( 'Ahhl be baahk.', 'The Terminator' );
SELECT * FROM t;
UPDATE t SET quote = 'Hasta la vista, baby.' WHERE id = 4;
SELECT * FROM t WHERE id = 4;
UPDATE t SET quote = 'Rosebud.', byline = 'Charles Foster Kane' WHERE id = 4;
SELECT * FROM t WHERE id = 4;
DROP TABLE IF EXISTS t;

-- DELETE 

-- album database
SELECT * FROM track WHERE title = 'Fake Track'
DELETE FROM track WHERE title = 'Fake Track'

-- SELECT
-- album database
SELECT * FROM album;
SELECT title, artist, label FROM album;
SELECT artist AS "Artist", title AS "Album", released AS "Release Date" FROM album;
    -- will use a lot with JOINs, VIEWs, sub-selects, etc.

SELECT * FROM track
WHERE album_id IN (
  SELECT id FROM album WHERE artist = 'Jimi Hendrix' OR artist = 'Johnny Winter'
);

SELECT a.title AS album, t.title AS track, t.track_number
    FROM album AS a, track AS t
    WHERE a.id = t.album_id
    ORDER BY a.title, t.track_number;

-- JOIN

-- world database
SELECT c.name, l.language
    FROM countryLanguage AS l
    JOIN country AS c
        ON l.countryCode = c.code
    ORDER BY c.name, l.language

SELECT c.name, l.language
    FROM countryLanguage AS l
    JOIN country AS c
        ON l.countryCode = c.Code
    WHERE c.name = 'Iran'
    ORDER BY l.language

-- album database
SELECT a.artist, a.title AS album, t.title AS track, t.track_number
  FROM track as t
  JOIN album AS a
    ON t.album_id = a.id
  ORDER BY a.artist, album, t.track_number


