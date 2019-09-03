
select *
from pg_stat_activity
 
/* This lists all queries currently running and idle. */
 
select
pid,
usename,
pg_blocking_pids(pid) as blocked_by,
query as blocked_query
from pg_stat_activity
where
cardinality(pg_blocking_pids(pid)) &gt; 0;
 
/* This lists queries causing locks. */


 
select count(*) from
(
    select
    userid
    from userschema.usertable
    where market = 'UK'
    and payingcustomer = 1 
) as derivedtable;


select
    firstname, lastname, userid
    from userschema.usertable
    where lastname like 'anders%' 
       -- only on the end of the string
 
