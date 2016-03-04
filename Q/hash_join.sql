CREATE TABLE people (age DECIMAL(3), name VARCHAR(16));
INSERT INTO people (age, name) VALUES (27, 'Jonah');
INSERT INTO people (age, name) VALUES (18, 'Alan');
INSERT INTO people (age, name) VALUES (28, 'Glory');
INSERT INTO people (age, name) VALUES (18, 'Popeye');
INSERT INTO people (age, name) VALUES (28, 'Alan');
 
CREATE TABLE nemesises (name VARCHAR(16), nemesis VARCHAR(16));
INSERT INTO nemesises (name, nemesis) VALUES ('Jonah', 'Whales');
INSERT INTO nemesises (name, nemesis) VALUES ('Jonah', 'Spiders');
INSERT INTO nemesises (name, nemesis) VALUES ('Alan', 'Ghosts');
INSERT INTO nemesises (name, nemesis) VALUES ('Alan', 'Zombies');
INSERT INTO nemesises (name, nemesis) VALUES ('Glory', 'Buffy');

/* kind of a hash join */

SELECT * FROM people p JOIN nemesises n ON p.name = n.name
