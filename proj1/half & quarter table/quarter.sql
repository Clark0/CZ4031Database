
create table author_quarter
(
	aid SERIAL
		constraint author_quarter_pk
			primary key,
	name varchar not null
);


create table publication_quarter
(
	pubid int
	    constraint publication_quarter_pk
			primary key,
	pubkey varchar not null,
	title varchar,
	year int,
        crossref varchar,
        journal varchar,
    pubtype pubtype
);

create table authored_quarter
(
	authoredid SERIAL
		constraint authored_quarter_pk
			primary key,
	aid SERIAL
		constraint authored_author_id_fk
			references author (aid),
	pubid int
		constraint authored_quarter_publication_id_fk
			references publication_quarter (pubid)
);

INSERT INTO publication_quarter (pubid, pubkey, title, year, crossref, journal, pubtype)
SELECT * FROM PUBLICATION limit 4761232/4;

INSERT INTO authored_quarter (authoredid, aid, pubid)
SELECT AUTHORED.* FROM authored, publication_quarter WHERE AUTHORED.PUBID = publication_quarter.pubid;

INSERT INTO author_quarter (aid, name)
SELECT distinct author.* FROM author, authored_quarter WHERE author.AID = authored_quarter.AID;