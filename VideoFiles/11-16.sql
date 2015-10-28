
-- integer types

CREATE TABLE t ( a INTEGER, b INTEGER );
CREATE TABLE t ( a SMALLINT, b SMALLINT );
CREATE TABLE t ( a BIGINT, b BIGINT );

SELECT * FROM t;

-- NUMERIC types

CREATE TABLE t ( a NUMERIC, b NUMERIC );
CREATE TABLE t ( a NUMERIC(12,2), b NUMERIC(64,5) );

DROP TABLE t;

-- real types

CREATE TABLE t ( a REAL, b DOUBLE PRECISION );

CREATE TABLE t ( da NUMERIC(10,2), db NUMERIC(10,2), fa REAL, fb REAL );
INSERT INTO t VALUES ( .1, .2, .1, .2 );
SELECT * FROM t;

SELECT da, db, da + db = .3 FROM t;
SELECT fa, fb, fa + fb = .3 FROM t;
SELECT fa, fb, to_char(fa + fb, '9D99999999999999999999EEEE') FROM t;

DROP TABLE t;

-- text types

CREATE TABLE t ( a TEXT, b TEXT, c TEXT );
CREATE TABLE t ( a TEXT, b VARCHAR(16), c CHAR(16) );

-- 36 char string
INSERT INTO t VALUES (
    'Now is the time for all good men ...',
    'Now is the time for all good men ...',
    'Now is the time for all good men ...'
);

-- 12 char string
INSERT INTO t VALUES ( 'Amir Azimi', 'Amir Azimi', 'Amir Azimi' );

-- boolean types

CREATE TABLE t ( a BOOLEAN, b BOOL );

INSERT INTO t VALUES ( TRUE, FALSE );
INSERT INTO t VALUES ( '1', '0' );
INSERT INTO t VALUES ( 'true', 't' );
INSERT INTO t VALUES ( 'false', 'f' );
INSERT INTO t VALUES ( 'yes', 'y' );
INSERT INTO t VALUES ( 'no', 'n' );

-- date/time types

CREATE TABLE t ( a TIMESTAMP, b TIMESTAMP WITH TIME ZONE );
CREATE TABLE t ( a TIME, b TIME WITH TIME ZONE );
CREATE TABLE t ( a DATE, b DATE );
CREATE TABLE t ( a INTERVAL, b INTERVAL );

INSERT INTO t VALUES ( '2011-10-07 15:25:00 EDT', '2011-10-07 3:25 PM EDT' );
INSERT INTO t VALUES ( '2011-10-07 15:25:00 UTC', '2011-10-07 3:25 PM UTC' );

INSERT INTO t VALUES ( '1 day', '1 week' );
INSERT INTO t VALUES ( '1 month', '1 year' );

INSERT INTO t VALUES ( AGE( DATE '2011-10-07', DATE '2011-10-06'), '2 days' );

-- reusable inserts

INSERT INTO t VALUES ( 1, 2 );
INSERT INTO t VALUES ( -32768, 32767 );
INSERT INTO t VALUES ( -2147483648, 2147483647 );
INSERT INTO t VALUES ( -9223372036854775808, 9223372036854775807 );

