WITH    tree AS
        (
        SELECT  /*+ MATERIALIZE */
                '  ,,,"''' AS needles, 'Oo%$&' AS decorations
        FROM    dual
        ),
        branches AS
        (
        SELECT  level AS id, level - TRUNC((level - 2) / 6) * 2 AS s
        FROM    dual
        CONNECT BY
                level <= 24
        )
SELECT  RPAD(' ', 18, ' ') || '*' AS tree
FROM    dual
UNION ALL
SELECT  RPAD(' ', 18 - s, ' ') || '/' ||
        (
        SELECT  REPLACE(
                SYS_CONNECT_BY_PATH
                (
                CASE
                WHEN DBMS_RANDOM.value < 0.1 THEN
                        SUBSTR(decorations, TRUNC(DBMS_RANDOM.value * LENGTH(decorations)) + 1, 1)
                ELSE
                        SUBSTR(needles, TRUNC(DBMS_RANDOM.value * LENGTH(needles)) + 1, 1)
                END , '/'
                ),
                '/', ''
                )
        FROM    tree
        WHERE   CONNECT_BY_ISLEAF = 1
        CONNECT BY
                level <= s * 2 - 1
        )
        || '\'
FROM    branches
