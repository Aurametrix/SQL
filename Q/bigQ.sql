# finding top pages
SELECT title, SUM(views) total_views
FROM `bigquery-public-data.wikipedia.pageviews_2019` 
WHERE wiki IN ('en', 'en.m') 
AND datehour>='2019-01-01'
GROUP BY title
ORDER BY 2 DESC
LIMIT 10

SELECT title, SUM(views) total_views
FROM `bigquery-public-data.wikipedia.pageviews_2019` 
WHERE wiki IN ('en', 'en.m') 
AND title NOT IN ('Main_Page','-','Wikipedia')
AND title NOT LIKE 'File%'
AND title NOT LIKE 'Special:%'
AND title NOT LIKE 'Portal:%'
AND datehour>='2019-01-01'
AND views>3
GROUP BY title
ORDER BY 2 DESC
LIMIT 10

CREATE OR REPLACE TABLE `wikipedia_extracts.2019_top_en_daily_views`
AS
WITH data AS (
  SELECT * FROM
  # fixing `bigquery-public-data.wikipedia.pageviews_2019`
     `fh-bigquery.wikipedia_v3.pageviews_2019` 
  WHERE wiki IN ('en', 'en.m')
  AND title NOT IN ('Main_Page','-','Wikipedia')
  AND title NOT LIKE 'File%'
  AND title NOT LIKE 'Special:%'
  AND title NOT LIKE 'Portal:%'
  AND views > 3
  AND datehour > '2000-01-01'
)
, pivot_desktop_mobile AS (
  SELECT title, DATE(datehour) date
    , SUM(IF(wiki='en', views, null)) desktop
    , SUM(IF(wiki='en.m', views, null)) mobile      
  FROM data 
  GROUP BY title, date
  )
, top_year AS (
  SELECT *, total_mobile/(total_desktop+total_mobile) ratio_mobile
  FROM (
    SELECT title, SUM(desktop+mobile) total_views
      , SUM(desktop) total_desktop
      , SUM(mobile) total_mobile
      , ARRAY_AGG(STRUCT(date, desktop+mobile AS views)) arr
      , ARRAY_AGG(date ORDER BY desktop+mobile DESC LIMIT 1)[OFFSET(0)] top_day
    FROM pivot_desktop_mobile
    WHERE mobile/(desktop+mobile) BETWEEN 0.05 AND 0.95
    GROUP BY title
    ORDER BY total_views DESC 
    LIMIT 200
  )
)
SELECT title, date, views
  , STRUCT(
      top_day, total_views, total_desktop, total_mobile
      , total_mobile/(total_mobile+total_desktop) AS ratio_mobile
  ) AS stats
FROM top_year, UNNEST(arr)
