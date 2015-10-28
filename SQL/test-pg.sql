
SET ROLE web;

-- create views for listing tables and databases
DROP VIEW IF EXISTS view_tables;
DROP VIEW IF EXISTS view_databases;
DROP VIEW IF EXISTS view_views;
DROP VIEW IF EXISTS view_indexes;

CREATE VIEW view_tables AS
    SELECT tablename AS table, tableowner AS owner FROM pg_tables WHERE schemaname = 'public';
CREATE VIEW view_databases AS
    SELECT datname AS database FROM pg_database WHERE datname NOT IN ('template1', 'template0', 'postgres');
CREATE VIEW view_views AS
    SELECT viewname AS view, viewowner as owner, definition FROM pg_views WHERE schemaname = 'public';
CREATE VIEW view_indexes AS
    SELECT class.relname AS index, roles.rolname AS owner FROM pg_class AS class
        JOIN pg_roles AS roles ON roles.oid = class.relowner
        WHERE class.relkind = 'i' AND class.relnamespace =
            (SELECT oid FROM pg_namespace WHERE nspname = 'public'); 

-- customer table
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    id              SERIAL PRIMARY KEY, 
    name            TEXT,
    address         TEXT,
    city            TEXT,
    state           CHAR(2),
    zip             CHAR(10)
);

-- item table
DROP TABLE IF EXISTS item;
CREATE TABLE item (
    id              SERIAL PRIMARY KEY,
    name            TEXT,
    description     TEXT
);

-- sale table
DROP TABLE IF EXISTS sale;
CREATE TABLE sale (
    id              SERIAL PRIMARY KEY,
    item_id         INTEGER,
    customer_id     INTEGER,
    date            DATE,
    quantity        INTEGER,
    price           INTEGER     -- in cents
);

BEGIN;
INSERT INTO customer ( id, name, address, city, state, zip ) VALUES ( 1, 'Bill Smith', '123 Main Street', 'Hope', 'CA', '98765' );
INSERT INTO customer ( id, name, address, city, state, zip ) VALUES ( 2, 'Mary Smith', '123 Dorian Street', 'Harmony', 'AZ', '98765' );
INSERT INTO customer ( id, name, address, city, state, zip ) VALUES ( 3, 'Bob Smith', '123 Laugh Street', 'Humor', 'CA', '98765' );

INSERT INTO item ( id, name, description ) VALUES ( 1, 'Box of 64 Pixels', '64 RGB pixels in a decorative box' );
INSERT INTO item ( id, name, description ) VALUES ( 2, 'Sense of Humor', 'Especially dry. Imported from England.' );
INSERT INTO item ( id, name, description ) VALUES ( 3, 'Beauty', 'Inner beauty. No cosmetic surgery required!' );
INSERT INTO item ( id, name, description ) VALUES ( 4, 'Bar Code', 'Unused. In original packaging.' );

INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 1, 1, 2, '2009-02-27', 3, 2995 );
INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 2, 2, 2, '2009-02-27', 1, 1995 );
INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 3, 1, 1, '2009-02-28', 1, 2995 );
INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 4, 4, 3, '2009-02-28', 2, 999 );
INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 5, 1, 2, '2009-02-28', 1, 2995 );
COMMIT;


