/*5.*/
EXPLAIN ANALYZE
SELECT author.aid, name, count FROM
    (SELECT auth.aid,  count(*) AS count FROM
        (SELECT * FROM publication
         WHERE title LIKE '%Data%') pub
         JOIN authored auth ON pub.pubid = auth.pubid
         GROUP BY auth.aid
         ORDER BY count DESC LIMIT 10) AS top_10_auth
    JOIN author ON author.aid = top_10_auth.aid;