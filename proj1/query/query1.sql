/*1. 358.086ms*/
EXPLAIN ANALYZE
SELECT DISTINCT PUBTYPE AS type, COUNT(*) AS pub_count
 FROM publication
 WHERE YEAR BETWEEN 2000 AND 2018
 GROUP BY PUBTYPE;