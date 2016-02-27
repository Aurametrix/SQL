SELECT * FROM people WHERE first_name = "John" and last_name = "Doe";

SELECT * FROM users WHERE email = 'phughes5m@nbcnews.com';

/*
ADDING an INDEX
*/

CREATE INDEX <index name> ON <table name> USING <method>(<column name>);

# or
CREATE INDEX email_idx ON users USING btree(email);

EXPLAIN SELECT * FROM users WHERE email = 'phughes5m@nbcnews.com';

EXPLAIN SELECT * FROM users WHERE id > 100 AND id < 200;  # sequential isn't always the worst

EXPLAIN SELECT * FROM users WHERE id > 200 AND id < 800;


