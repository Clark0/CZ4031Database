-- find the name of author who wrote more books than articles
SELECT A.name, COUNT(P.pubtype) FILTER ( WHERE P.pubtype = 'book' ) AS book_num,
COUNT(P.pubtype) FILTER ( WHERE P.pubtype = 'article') AS article_num
FROM publication AS P, authored AS AP, author AS A
WHERE (P.pubtype = 'book'
  OR P.pubtype = 'article')
  AND P.pubid = AP.pubid
  AND AP.aid = A.aid
GROUP BY A.name
HAVING COUNT(P.pubtype) FILTER ( WHERE P.pubtype = 'book' ) > COUNT(P.pubtype) FILTER ( WHERE P.pubtype = 'article');
