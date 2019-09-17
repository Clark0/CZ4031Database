-- Find authors who have published at least 1 paper every year
-- in the last 30 years, and whose family name start with ‘H’
SELECT A.name
FROM publication AS P, authored AS AP, author AS A
WHERE A.name ~ '\sH(\w+)$'
  AND P.year > 1989
  AND AP.pubid = P.pubid
  AND AP.aid = A.aid
GROUP BY A.name
HAVING COUNT (DISTINCT P.year) = 30;

-- Find the names and number of publications for authors who
-- have the earliest publication record in DBLP.
SELECT A.name, COUNT(*)
FROM publication AS P, authored AS AP, author AS A
WHERE AP.aid = A.aid
  AND AP.pubid = P.pubid
  AND P.year =
      (SELECT MIN(P2.year)
       FROM publication AS P2)
GROUP BY A.name;

