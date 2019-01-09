SELECT
	count(*) AS count,
	winner,
	counter * 60 * 5 AS counter
FROM
	(
		SELECT
			winner,
			round(length / (60 * 5)) AS counter
		FROM
			players
		WHERE
			build = $1
			AND (hero = $2 OR region = $3)
	)
GROUP BY
	winner, counter