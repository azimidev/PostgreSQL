-- PostgreSQL Documentation
-- http://www.postgresql.org/docs/9.5/static/functions-math.html

-- Arithmetic operators

SELECT 5 * 30;
SELECT 7 / 3;
SELECT 7.0 / 3;
SELECT 7 % 3;

-- world database
SELECT name, population / 1000000 AS "pop (MM)" FROM Country
    WHERE population > 100000000
    ORDER by population DESC;

-- test database
SELECT item_id, price FROM sale;
SELECT item_id, price / 100 AS  Price FROM sale;
SELECT item_id, CAST(price AS NUMERIC) / 100 AS price FROM sale;
SELECT item_id, TO_CHAR(CAST(price AS NUMERIC) / 100, '999,999.09') AS price FROM sale;

-- math functions

-- ABS
CREATE TABLE t ( a INTEGER, b INTEGER );
INSERT INTO t VALUES ( 1, 2 );
INSERT INTO t VALUES ( 3, 4 );
INSERT INTO t VALUES ( -1, -2 );
INSERT INTO t VALUES ( -3, -4 );
SELECT a, b FROM t;
SELECT ABS(a), b FROM t;
DROP TABLE IF EXISTS t;

-- ROUND
CREATE TABLE t ( a NUMERIC(10,3), b NUMERIC(10,3) );
INSERT INTO t VALUES ( 123.456, 456.789 );
INSERT INTO t VALUES ( -123.456, -456.789 );
SELECT ROUND(a), b FROM t;
SELECT ROUND(a, 2), b FROM t;
SELECT RANDOM(); -- between 0 to 1
DROP TABLE IF EXISTS t;

