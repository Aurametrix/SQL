SELECT query, total_time / calls AS avg_time
 FROM pg_stat_statements
ORDER BY total_time DESC 
LIMIT 10;
