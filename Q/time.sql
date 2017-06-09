with weeks as (
  select week as week
  from generate_series('2017-01-01'::date, now()::date, '1 week'::interval) weeks
)

SELECT weeks.week,
       count(*)
FROM weeks,
     users
WHERE users.created_at > weeks.week
  AND users.created_at <= weeks.week - '1 week'::interval
