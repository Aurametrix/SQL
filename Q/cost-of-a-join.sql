DROP FUNCTION IF EXISTS create_tables(integer, integer, boolean);
CREATE FUNCTION create_tables(num_tables integer, num_rows integer, create_indexes boolean) RETURNS void AS $function_text$
BEGIN

-- There's no table before the first one, so this one's a little different.  Create it here instead of in our loop.
DROP TABLE IF EXISTS table_1 CASCADE;
CREATE TABLE table_1 (
    id serial primary key
);

-- Populate the first table
INSERT INTO table_1 (id)
SELECT
    nextval('table_1_id_seq')
FROM
    generate_series(1, num_rows);

-- Create and populate all the other tables
FOR i IN 2..num_tables LOOP
    EXECUTE 'DROP TABLE IF EXISTS table_' || i || ' CASCADE;';

    EXECUTE format($$
        CREATE TABLE table_%1$s (
            id serial primary key,
            table_%2$s_id integer references table_%2$s (id)
        );

        INSERT INTO table_%1$s (table_%2$s_id)
        SELECT
            id
        FROM
            table_%2$s
        ORDER BY
            random();
    $$, i, i-1);

    IF create_indexes THEN
        EXECUTE 'CREATE INDEX ON table_' || i || ' (table_' || i - 1 || '_id);';
    END IF;
END LOOP;
END;
$function_text$ LANGUAGE plpgsql;

-- We'll want to make sure PostgreSQL has an idea of what's in these tables
DROP FUNCTION IF EXISTS analyze_tables(integer);
CREATE FUNCTION analyze_tables(num_tables integer) RETURNS void AS $function_text$
BEGIN

FOR i IN 1..num_tables LOOP
    EXECUTE 'ANALYZE table_' || i || ';';
END LOOP;
END;
$function_text$ LANGUAGE plpgsql;
