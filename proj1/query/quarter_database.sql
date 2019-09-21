CREATE TABLE publication_quarter AS(
    SELECT * FROM publication_half limit 4761232/4);

CREATE TABLE authored_quarter AS(
    SELECT authored.* FROM authored, publication_quarter WHERE AUTHORED.PUBID = publication_quarter.pubid);

CREATE TABLE author_quarter AS(
    SELECT AUTHOR.* FROM author, authored_quarter WHERE author.AID = authored_quarter.AID)