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

''

// optimizer


// left-deep and right-deep
for each set of (i-1) relations S begin
    for each relation R not in S begin
        consider all possible algorithms to join bestjoin[S] with R
        consider all possible algorithms to join R with bestjoin[S]
        pick the best one, and set bestjoin[S + R] to that plan
    end
end

// bushy
for j = 2 to (i-2) begin
    for each set of j relations S1 begin
        for each set of (i-j) relations S2 begin
            consider all plans to join bestjoin[S1] with bestjoin[S2]
            set bestjoin[S1+S2] to the best plan if better than current
        end
    end
end
