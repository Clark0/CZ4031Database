COPY pub_temp from '../parser/out/pub.csv'  DELIMITERS ',' CSV;
COPY pub_authors_temp from '../parser/out/pub_authors.csv' DELIMITERS ',' CSV;

/* load schema */
\i schema.sql

INSERT INTO publication (id, pubkey, title, month, year, type)
SELECT pubid, pubkey, title, title, month, year, pubtype
FROM pub_temp

INSERT INTO author (name)
SELECT unique author
FROM pub_authors_temp

INSERT INTO authored (authorid, pubid)
SELECT pubid, authorid
FROM pub_authors_temp, author
WHERE pub_authors_temp.author = author.name

DROP TABLE pub_temp, pub_authors_temp
