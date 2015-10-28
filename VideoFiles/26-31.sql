-- Documentation
-- http://www.postgresql.org/docs/9.5/static/functions-string.html

-- Finding the length of a string
SELECT LENGTH('This string has 30 characters.');
SELECT CHAR_LENGTH('This string has 30 characters.');
SELECT OCTET_LENGTH('This string has 30 characters.');

-- Concatenating strings
SELECT 'This is a string.' || 'This is another string.';
SELECT CONCAT('This is a string', 'This is another string');
SELECT CONCAT_WS(':', 'This is a string', 'This is another string', 'One more string here');

-- Substrings
SELECT POSITION('string' IN 'This is a string');
SELECT SUBSTRING('This is a string' FROM 11);
SELECT SUBSTRING('This is a string' FROM 11 FOR 3);

-- Replacing strings
SELECT REPLACE('This is a string', 'is a', 'is not a');
SELECT OVERLAY('This is a xxxxxx' PLACING 'string' FROM 11);

-- Trimming strings
SELECT TRIM('  This is a string   ');  -- defaults to BTRIM
SELECT LTRIM('  This is a string   ');
SELECT RTRIM('  This is a string   ');

-- Converting strings
-- http://www.postgresql.org/docs/9.5/static/functions-formatting.html
SELECT TO_CHAR(1234567890.1234, '999,999,999,999.99');
SELECT TO_HEX(5555);
SELECT UPPER(TO_HEX(5555));

