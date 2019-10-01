
create table author_half
(
	aid SERIAL
		constraint author_half_pk
			primary key,
	name varchar not null
);


create table publication_half
(
	pubid int
	    constraint publication_half_pk
			primary key,
	pubkey varchar not null,
	title varchar,
	year int,
        crossref varchar,
        journal varchar,
    pubtype pubtype
);

create table authored_half
(
	authoredid SERIAL
		constraint authored_half_pk
			primary key,
	aid SERIAL
		constraint authored_author_id_fk
			references author (aid),
	pubid int
		constraint authored_half_publication_id_fk
			references publication_half (pubid)
);

INSERT INTO publication_half (pubid, pubkey, title, year, crossref, journal, pubtype)
SELECT * FROM PUBLICATION limit 4761232/2;

INSERT INTO authored_half (authoredid, aid, pubid)
SELECT AUTHORED.* FROM authored, publication_half WHERE AUTHORED.PUBID = publication_half.pubid;

INSERT INTO author_half (aid, name)
SELECT distinct author.* FROM author, authored_half WHERE author.AID = authored_half.AID;



