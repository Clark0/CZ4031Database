create table author
(
	id SERIAL
		constraint author_pk
			primary key,
	name varchar not null
);

create type month as enum(
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
);

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

create table publication
(
	id int
		constraint publication_pk
			primary key,
	pubkey varchar not null,
	title varchar,
	month month,
	year int,
    type pubtype
);

create unique index publication_pubkey_uindex
	on publication (pubkey);

create table authored
(
	id int
		constraint authored_pk
			primary key,
	authorid int
		constraint authored_author_id_fk
			references author (id),
	pubid int
		constraint authored_publication_id_fk
			references publication (id)
);

