CREATE TYPE pubtype AS enum (
    'article',
    'inproceedings',
    'proceedings',
    'book',
    'incollection',
    'phdthesis',
    'mastersthesis',
    'www'
);


CREATE TABLE author (
    aid SERIAL CONSTRAINT author_pk PRIMARY KEY,
    name varchar NOT NULL
);


CREATE TABLE publication (
    pubid int CONSTRAINT publication_pk PRIMARY KEY,
    pubkey varchar NOT NULL,
    title varchar,
    YEAR int,
    pubtype pubtype
);


CREATE UNIQUE INDEX publication_pubkey_uindex ON publication (pubkey);


CREATE TABLE authored (
    authoredid SERIAL CONSTRAINT authored_pk PRIMARY KEY,
    aid SERIAL,
    pubid int,
);

