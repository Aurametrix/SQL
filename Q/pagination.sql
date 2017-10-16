CREATE TABLE `users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(32) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `metadata` text COLLATE utf8_unicode_ci,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uf_uniq_external_id` (`external_id`),
  UNIQUE KEY `uf_uniq_name` (`name`),
  KEY `date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Solution 1 - obvious and wrong
SELECT user_id, external_id, name, metadata, date_created
FROM users;

# Solution 2 - 10 000 rows in set (0.03 sec) but very slow for the 5000th page

SELECT user_id, external_id, name, metadata, date_created
FROM users
ORDER BY user_id ASC
LIMIT 0, 10 000;

SELECT user_id, external_id, name, metadata, date_created
FROM users
ORDER BY user_id ASC
LIMIT 50 000 000, 10 000; --- 5 000th page * 10 000 page size

# Best solution

SELECT user_id, external_id, name, metadata, date_created
FROM users
WHERE user_id > 51 234 123 --- value of user_id for 50 000 000th record
ORDER BY user_id ASC
LIMIT 10 000;
