SELECT time,
exponential_moving_average(value, 0.5) OVER (ORDER BY time)
FROM metrics
WHERE measurement = 'foo' and time > now() - '1 hour';


vs


from(db:"metrics")
|> range(start:-1h)
|> filter(fn: (r) => r._measurement == "foo")
|> exponentialMovingAverage(size:-10s)
