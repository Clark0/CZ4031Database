/*2. 3471.999ms*/
EXPLAIN ANALYZE
SELECT * FROM
(SELECT key_array[1] AS conf, key_array[2] AS conf_name, count(*) AS paper_count
    FROM (
--         Split pubkey to publication_types(conference, journals...), conference title and the rest
        SELECT regexp_split_to_array(pubkey, '/') AS key_array,*
        FROM publication
        WHERE PUBKEY LIKE 'conf/%'  /*select only conference papers*/
         ) as dt(key_array)
 GROUP BY conf, conf_name) AS conf_papers
WHERE paper_count >500;