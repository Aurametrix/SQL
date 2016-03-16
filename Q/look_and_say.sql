DROP VIEW delta;
CREATE VIEW delta AS
    SELECT sequence1.v AS x,
           (sequence1.v<>sequence2.v)*sequence1.c AS v,
           sequence1.c AS c
      FROM SEQUENCE AS sequence1,
           SEQUENCE AS sequence2
     WHERE sequence1.c = sequence2.c+1;
 
DROP VIEW rle0;
CREATE VIEW rle0 AS
    SELECT delta2.x AS x,
           SUM(delta2.v) AS v,
           delta2.c AS c
      FROM delta AS delta1,
           delta AS delta2
     WHERE delta1.c >= delta2.c
  GROUP BY delta1.c;
 
DROP VIEW rle1;
CREATE VIEW rle1 AS
    SELECT SUM(x)/x AS a,
           x AS b,
           c AS c
      FROM rle0
  GROUP BY v;
 
DROP VIEW rle2;
CREATE VIEW rle2 AS
    SELECT a AS v, 1 AS o, 2*c+0 AS c FROM rle1 UNION
    SELECT b AS v, 1 AS o, 2*c+1 AS c FROM rle1;
 
DROP VIEW normed;
CREATE VIEW normed AS
    SELECT r1.v AS v, SUM(r2.o) AS c
      FROM rle2 AS r1,
           rle2 AS r2
     WHERE r1.c >= r2.c
  GROUP BY r1.c;
 
DROP TABLE rle;
CREATE TABLE rle(v INT, c INT);
INSERT INTO rle SELECT * FROM normed ORDER BY c;
 
DELETE FROM SEQUENCE;
INSERT INTO SEQUENCE VALUES(-1,0);
INSERT INTO SEQUENCE SELECT * FROM rle;
