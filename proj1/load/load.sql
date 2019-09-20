CREATE TABLE pub_temp (
    pubid int CONSTRAINT pub_temp_pk PRIMARY KEY,
    pubtype pubtype, 
    mdate date, 
    pubkey varchar, 
    crossref varchar, 
    journal varchar, 
    YEAR int, 
    MONTH varchar, 
    title varchar
);

/* load csv file to the temp table */
COPY pub_temp 
FROM '/pub.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE pub_authors_temp (
    authoredid SERIAL CONSTRAINT pub_authors_temp_pk PRIMARY KEY, 
    pubid int, 
    author varchar
);

/* load csv file to the temp table */
COPY pub_authors_temp(pubid, author)
FROM '/pub_authors.csv' DELIMITER ',' CSV HEADER;


INSERT INTO publication (pubid, pubkey, title, YEAR, pubtype)
SELECT pubid, pubkey, title, YEAR, pubtype
FROM pub_temp;


INSERT INTO author (name)
SELECT DISTINCT author
FROM pub_authors_temp;


INSERT INTO authored (aid, pubid)
SELECT aid, pubid
FROM pub_authors_temp, author
WHERE pub_authors_temp.author = author.name;

/* drop temp tables */
DROP TABLE pub_temp,
           pub_authors_temp;


/* add foreign key constraints */
ALTER TABLE authored 
ADD CONSTRAINT authored_author_id_fk 
    FOREIGN KEY (aid) REFERENCES author(aid);
    ON DELETE CASCADE;

ALTER TABLE authored
ADD CONSTRAINT authored_publication_id_fk 
    FOREIGN KEY (pubid) REFERENCES publication(pubid);
    ON DELETE CASCADE;


