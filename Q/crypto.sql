with crypto_text_tokens as (
    select rows.tokens as token
      from (
        select tokenize(text) as text_tokens
        from (
            select text as text
            from "rockset-dynamodb-demo" 
            where text like '%crypto%' or text like '%blockchain%'
        ) subq
    ) subq, unnest(text_tokens as tokens) as rows
)
select token, count(token) as count
from crypto_text_tokens
where token like '_%coin'
group by token
order by count desc
limit 10;
