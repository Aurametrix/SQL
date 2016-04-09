CREATE TABLE Movies (
  mid int PRIMARY KEY,
  title text NOT NULL
);

CREATE TABLE People (
  pid int PRIMARY KEY,
  name text NOT NULL
);
  
CREATE TABLE Nominees (
  pid int,
  mid int,
  year int NOT NULL,
  won bool NOT NULL,
  PRIMARY KEY (pid, mid)
);

// SQL query that finds the names of all movies nominated in 2016:

SELECT m.title
FROM Movies m, Nominees n
WHERE m.mid = n.mid AND n.year = 2016;
