-- find the name of author who wrote more books than phdthesis 
SELECT A.name
FROM publication AS P, authored AS AP, author AS A
WHERE (P.pubtype = 'book'
  OR P.pubtype = 'phdthesis')
  AND P.pubid = AP.pubid
  AND AP.aid = A.aid
GROUP BY A.name
HAVING COUNT(P.pubtype) FILTER ( WHERE P.pubtype = 'book' ) > COUNT(P.pubtype) FILTER ( WHERE P.pubtype = 'phdthesis');
