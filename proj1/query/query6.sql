-- rename the conference to remove the year in conference name
SELECT DISTINCT(regexp_replace(P1.crossref , '\/\d{2}.*', ''))
FROM publication AS P1, (SELECT P2.pubkey
                         FROM publication AS P2
                         WHERE P2.title LIKE '%June%') AS june_conf
WHERE P1.crossref = june_conf.pubkey
GROUP BY P1.crossref
HAVING COUNT(P1.pubkey) > 100;

