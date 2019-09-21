CREATE TABLE publication_half AS(
    SELECT * FROM PUBLICATION limit 4761232/2);

CREATE TABLE authored_half AS(
    SELECT AUTHORED.* FROM authored, publication_half WHERE AUTHORED.PUBID = publication_half.pubid);

CREATE TABLE author_half AS(
    SELECT author.* FROM author, authored_half WHERE author.AID = authored_half.AID );
