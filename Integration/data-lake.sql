-------------------------------------------------
-- Prepare FDW and list the available services --
-------------------------------------------------
-- Enable postgres_fdw extension
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

-- Create the “foreign” Carriers server
CREATE SERVER IF NOT EXISTS "carriers-service"
  FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    host '127.0.0.1',
    dbname 'carriers-db-name',
    port '5444',
    -- Our databases being local on the same server
    -- (thanks to streaming replication)
    -- we make sure to tell postgres about it so it can “safely”
    -- delegate cost estimates to the foreign database without
    -- impacting SQL performances
    use_remote_estimate 'true',
    -- guesstimate connection time for a localhost database
    fdw_startup_cost '10',
     -- guesstimate extra cost per-tuple added by the FDW layer
    fdw_tuple_cost '0.0001'
);

-- Create a user mapping to connect to the “foreign”
-- Carriers-Service server
CREATE USER MAPPING IF NOT EXISTS FOR PUBLIC
  SERVER "carriers-service" OPTIONS (
    USER 'carriers-db-user',
    PASSWORD :'carriers_db_password'
  -- the “:” is sql interpolation syntax for psql
  -- you can define variables with “\set foo 'my_value';”
  -- postgresql.org/docs/13/app-psql.html#APP-PSQL-INTERPOLATION
);

-----------------------------------------------
-- Prepare dedicated schema for each service --
-----------------------------------------------

-- Empty any existing objects
DROP SCHEMA IF EXISTS "carriers" CASCADE;

-- Create a dedicated schema which will receive foreign tables
CREATE SCHEMA "carriers";

-- Explicit read privilege for the reporting user
ALTER DEFAULT PRIVILEGES IN SCHEMA "carriers" GRANT
SELECT
    ON TABLES TO "reporting-ro";

---------------------------
-- Import foreign tables --
---------------------------
IMPORT FOREIGN SCHEMA reporting
FROM
    SERVER "carriers-service" INTO "carriers";

-----------------------------------------------------------------
-- Analyse foreign tables                                      --
-- (https://www.postgresql.org/docs/current/postgres-fdw.html) --
--                                                             --
-- Running an `ANALYZE` query after importing foreign tables   --
-- is a good way to update the local statistics of those       --
-- foreign tables. It will help the query planer to run better --
-- queries on foreign tables.                                  --
-----------------------------------------------------------------
DO $$
DECLARE
    tablenames TEXT;
BEGIN
    tablenames := STRING_AGG(
        '"' || foreign_table_schema ||
        '"."' ||
        foreign_table_name || '"', ', '
    )
FROM
    information_schema.foreign_tables;
    EXECUTE 'ANALYZE ' || tablenames;
END;
$$;
