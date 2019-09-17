DROP VIEW IF EXISTS coauthor CASCADE;
DROP VIEW IF EXISTS authored_data CASCADE;
DROP VIEW IF EXISTS data_conf_journal CASCADE;


-- create a view for:
-- inproceeding in proceeding, where proceeding name contains "data",
-- or journal whose name contains “data”
CREATE VIEW data_conf_journal AS(
    SELECT P1.pubid
    FROM publication AS P1
    WHERE P1.journal ILIKE '%data%'
    OR P1.crossref in (SELECT P2.pubkey
                                  FROM publication AS P2
                                  WHERE P2.title ILIKE '%data%' AND P2.pubtype = 'proceedings')
);


-- create a view for author and his inproceeding/article
CREATE VIEW authored_data AS(
    SELECT authored.aid, authored.pubid
    FROM authored,
         data_conf_journal
    WHERE authored.pubid = data_conf_journal.pubid
);

-- create a view for coauthor number
CREATE VIEW coauthor AS(
    SELECT A1.aid , COUNT(DISTINCT A2.aid) AS coauthor_num
    FROM authored_data A1, authored_data A2
    WHERE A1.pubid = A2.pubid AND NOT A1.aid = A2.aid
    GROUP BY A1.aid
    ORDER BY coauthor_num DESC
    LIMIT 1
);

-- find author name
SELECT author.name
FROM author, coauthor
WHERE author.aid = coauthor.aid
