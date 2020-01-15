WITH quarters AS (
  WITH weeks AS (
      SELECT year, quarter, json_group_object(week, total) AS week_json 
      FROM sales 
      GROUP BY year, quarter
      ) 
  SELECT year, json_group_object(quarter, json(week_json)) AS quarters_json 
  FROM weeks 
  GROUP BY year
) 
SELECT json_group_object(year, json(quarters_json)) 
FROM quarters;"
