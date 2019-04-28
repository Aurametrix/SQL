NOTIFY 'foo_events', '{"userid":42,"action":"grok"}'

SELECT pg_notify('foo_events', '{"userid":42,"action":"grok"}');

CREATE TABLE invoices (
    invoice_number   int  NOT NULL PRIMARY KEY,
    issued_on        date NOT NULL DEFAULT now()
);

CREATE TABLE government_invoices (
    department_id    text NOT NULL
) INHERITS (invoices);

-- install the extension (required only once)
CREATE EXTENSION postgres_fdw;

-- big_server is our big, remote server with the migrated table
CREATE SERVER big_server FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (host '10.1.2.3', dbname 'big_db');

-- create a user mapping for the app user
CREATE USER MAPPING FOR app_user SERVER big_server
  OPTIONS (user 'remote_user', password 'remote_pass');

-- and finally create the virtual table invoices -> big_db.public.invoices
CREATE FOREIGN TABLE invoices (
  invoice_num int NOT NULL PRIMARY KEY
  -- other columns omitted for brevity
) SERVER big_server;

-- the parent table
CREATE TABLE invoices (
    invoice_number   int  NOT NULL,
    issued_on        date NOT NULL DEFAULT now()
) PARTITION BY RANGE (issued_on);
  
-- table for the month of May 2018
CREATE TABLE invoices_2018_05 PARTITION OF invoices
  FOR VALUES FROM ('2018-05-01') TO ('2018-06-01');

-- table for the month of June 2018
CREATE TABLE invoices_2018_06 PARTITION OF invoices
  FOR VALUES FROM ('2018-06-01') TO ('2018-07-01');
