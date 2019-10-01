create type pubtype as enum(
    'article',
    'inproceedings',
    'proceedings',
    'book',
    'incollection',
    'phdthesis',
    'mastersthesis',
    'www'
);

create table author
(
	aid SERIAL
		constraint author_pk
			primary key,
	name varchar not null
);

create table publication
(
	pubid int
		constraint publication_pk
			primary key,
	pubkey varchar not null,
	title varchar,
	year int,
        crossref varchar,
        journal varchar,
    pubtype pubtype
);


create unique index publication_pubkey_uindex
	on publication (pubkey);

create table authored
(
	authoredid SERIAL
		constraint authored_pk
			primary key,
	aid SERIAL
		constraint authored_author_id_fk
			references author (aid),
	pubid int
		constraint authored_publication_id_fk
			references publication (pubid)
);
