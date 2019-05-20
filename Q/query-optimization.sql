ELECT 
    count(*) 
FROM 
    acc_{account_id}.urls as recordings_urls, 
    acc_{account_id}.recording_data as recording_data, 
    acc_{account_id}.sessions as sessions 
WHERE 
    recording_data.usp_id = sessions.usp_id 
    AND  (  1 = 1  )  
    AND sessions.referrer_id = recordings_urls.id 
    AND r_time > to_timestamp(1542585600) 
    AND r_time < to_timestamp(1545177599) 
    AND recording_data.duration >=5 
    AND recording_data.num_of_pages > 0
    AND EXISTS(
        SELECT urls.url
        FROM 
            acc_{account_id}.urls as urls,
            (SELECT unnest(urls) AS rec_url_id FROM acc_{account_id}.recording_data) 
            AS unrolled_urls
        WHERE
            urls.id = unrolled_urls.rec_url_id AND
            urls.url  ILIKE  '%enterprise_customer.com/jobs%'
    );
