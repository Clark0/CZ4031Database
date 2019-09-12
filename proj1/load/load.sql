create table pub_temp(
    pubid int
        constraint pub_temp_pk
                primary key,
    pubtype pubtype,
    mdate date,
    pubkey varchar,
    crossref varchar,
    journal varchar,
    year int,
    month varchar,
    title varchar
);

COPY pub_temp from '/pub.csv'  DELIMITER ',' CSV HEADER;

create table pub_authors_temp(
    authoredid SERIAL
         constraint pub_authors_temp_pk
            primary key,
    pubid int,
    author varchar
);

COPY pub_authors_temp(pubid, author) from '/pub_authors.csv' DELIMITER ',' CSV HEADER;

INSERT INTO publication (pubid, pubkey, title, year, pubtype)
SELECT pubid, pubkey, title, year, pubtype
FROM pub_temp;

INSERT INTO author (name)
SELECT distinct author
FROM pub_authors_temp;

INSERT INTO authored (aid, pubid)
SELECT aid, pubid
FROM pub_authors_temp, author
WHERE pub_authors_temp.author = author.name;

DROP TABLE pub_temp, pub_authors_temp;
